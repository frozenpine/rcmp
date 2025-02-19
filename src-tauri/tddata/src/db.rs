use lazy_static::lazy_static;
use sqlx::sqlite::SqlitePoolOptions;
use sqlx::Executor;
use std::collections::HashMap;
use std::ops::Deref;
use std::path::PathBuf;
use std::sync::Mutex;

pub trait AccountInfo: Send + Sync {
    fn get_trading_day(&self) -> String;
    fn get_account_id(&self) -> String;
    fn get_account_name(&self) -> String;
    fn get_balance(&self) -> f64;
    fn get_frozen_balance(&self) -> f64;
    fn get_pre_balance(&self) -> f64;
    fn get_available(&self) -> f64;
    fn get_deposit(&self) -> f64;
    fn get_withdraw(&self) -> f64;
    fn get_margin(&self) -> f64;
    fn get_frozen_margin(&self) -> f64;
    fn get_fee(&self) -> f64;
    fn get_frozen_fee(&self) -> f64;
    fn get_premium(&self) -> f64;
    fn get_frozen_premium(&self) -> f64;
    fn get_position_profit(&self) -> f64;
    fn get_close_profit(&self) -> f64;
    fn get_net_profit(&self) -> f64;
    fn get_currency_id(&self) -> String;
}

#[derive(Debug, Clone, Default, sqlx::FromRow, serde::Serialize, serde::Deserialize)]
pub struct DBAccount {
    pub trading_day: String,
    pub account_id: String,
    pub account_name: String,
    pub balance: f64,
    pub frozen_balance: f64,
    pub pre_balance: f64,
    pub available: f64,
    pub deposit: f64,
    pub withdraw: f64,
    pub margin: f64,
    pub frozen_margin: f64,
    pub fee: f64,
    pub frozen_fee: f64,
    pub premium: f64,
    pub frozen_premium: f64,
    pub position_profit: f64,
    pub close_profit: f64,
    pub net_profit: f64,
    pub currency_id: String,
}

impl From<&dyn AccountInfo> for DBAccount {
    fn from(info: &dyn AccountInfo) -> Self {
        Self {
            trading_day: info.get_trading_day(),
            account_id: info.get_account_id(),
            account_name: info.get_account_name(),
            balance: info.get_balance(),
            frozen_balance: info.get_frozen_balance(),
            pre_balance: info.get_pre_balance(),
            available: info.get_available(),
            deposit: info.get_deposit(),
            withdraw: info.get_withdraw(),
            margin: info.get_margin(),
            frozen_margin: info.get_frozen_margin(),
            fee: info.get_fee(),
            frozen_fee: info.get_frozen_fee(),
            premium: info.get_premium(),
            frozen_premium: info.get_frozen_premium(),
            position_profit: info.get_position_profit(),
            close_profit: info.get_close_profit(),
            net_profit: info.get_net_profit(),
            currency_id: info.get_currency_id(),
        }
    }
}

#[derive(Debug, Clone)]
pub(crate) struct Schema {
    name: String,
    dsn: String,
}

impl Schema {
    pub fn new(base_dir: &str, name: &str) -> Schema {
        let mut dsn = PathBuf::from(base_dir).join(name);
        dsn.set_extension("db");

        Schema {
            name: name.to_string(),
            dsn: dsn.as_path().to_str().unwrap().to_string(),
        }
    }
}

#[derive(Debug)]
pub struct DB {
    pool: sqlx::SqlitePool,
}

lazy_static! {
    static ref post_conn_sql: Mutex<String> = Mutex::new(String::new());
}

impl DB {
    pub async fn new(base_dir: &str, schemas: &[&str]) -> Result<Self, Box<dyn std::error::Error>> {
        let mut schema_cache = HashMap::with_capacity(schemas.len());

        for v in schemas {
            let s = Schema::new(base_dir, v);

            if schema_cache.contains_key(&s.name) {
                log::warn!("Schema already exists: {}", &s.name);
            } else {
                schema_cache.insert(s.name.clone(), s);
            }
        }

        if let Ok(mut sql) = post_conn_sql.lock() {
            if sql.deref() == "" {
                *sql = schema_cache
                    .iter()
                    .map(|(k, v)| format!("ATTACH DATABASE '{}' AS {}", v.dsn, k))
                    .collect::<Vec<String>>()
                    .join("; ")
            } else {
                return Err("db with schemas already opened".into());
            }
        }

        // Opening in memory db & attach to file db specified by schemas
        let pool = SqlitePoolOptions::new()
            .min_connections(1)
            .max_connections(5)
            .after_connect(|conn, meta| {
                let mut sql = post_conn_sql.lock().unwrap().deref().to_string();
                sql.push(';');

                log::debug!(
                    "registering schema for conn with sql: {:?}, {:?}, {}",
                    conn,
                    meta,
                    sql
                );

                Box::pin(async move {
                    conn.execute(sql.as_str()).await?;
                    Ok(())
                })
            })
            .connect("")
            .await?;

        let db = Self { pool };

        Ok(db)
    }

    pub async fn sink_accounts(
        &self,
        accounts: &[&dyn AccountInfo],
        batch_size: usize,
    ) -> Result<u64, Box<dyn std::error::Error>> {
        log::debug!("sinking for account data: {}", accounts.len());

        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"INSERT OR REPLACE INTO fund.account (
    trading_day, account_id, account_name,
    balance, frozen_balance, pre_balance,
    available, deposit, withdraw,
    margin, frozen_margin, fee, frozen_fee,
    premium, frozen_premium,
    position_profit, close_profit, net_profit, currency_id)"#,
        );

        let mut count = 0_u64;
        let mut leading = accounts;
        let mut trailing;

        loop {
            if leading.len() > batch_size {
                (leading, trailing) = leading.split_at(batch_size);
            } else {
                trailing = &[];
            }

            qry_builder.reset().push_values(
                leading.iter().map(|acct| {
                    (
                        acct.get_trading_day(),
                        acct.get_account_id(),
                        acct.get_account_name(),
                        acct.get_balance(),
                        acct.get_frozen_balance(),
                        acct.get_pre_balance(),
                        acct.get_available(),
                        acct.get_deposit(),
                        acct.get_withdraw(),
                        acct.get_margin(),
                        acct.get_frozen_margin(),
                        acct.get_fee(),
                        acct.get_frozen_fee(),
                        acct.get_premium(),
                        acct.get_frozen_premium(),
                        acct.get_position_profit(),
                        acct.get_close_profit(),
                        acct.get_net_profit(),
                        acct.get_currency_id(),
                    )
                }),
                |mut b, values| {
                    b.push_bind(values.0)
                        .push_bind(values.1)
                        .push_bind(values.2)
                        .push_bind(values.3)
                        .push_bind(values.4)
                        .push_bind(values.5)
                        .push_bind(values.6)
                        .push_bind(values.7)
                        .push_bind(values.8)
                        .push_bind(values.9)
                        .push_bind(values.10)
                        .push_bind(values.11)
                        .push_bind(values.12)
                        .push_bind(values.13)
                        .push_bind(values.14)
                        .push_bind(values.15)
                        .push_bind(values.16)
                        .push_bind(values.17)
                        .push_bind(values.18);
                },
            );

            let query = qry_builder.build();
            let result = query.execute(&self.pool).await?;

            count += result.rows_affected();

            if trailing.is_empty() {
                break;
            } else {
                leading = trailing;
            }
        }

        Ok(count)
    }

    async fn execute_account_qry(
        &self,
        mut qry_builder: sqlx::QueryBuilder<'_, sqlx::Sqlite>,
    ) -> Result<Vec<DBAccount>, Box<dyn std::error::Error>> {
        qry_builder.push(" ORDER BY account_id, trading_day ASC;");

        let query = qry_builder.build_query_as::<DBAccount>();
        Ok(query.fetch_all(&self.pool).await?)
    }

    pub async fn query_accounts(
        &self,
        accounts: &[&str],
    ) -> Result<Vec<DBAccount>, Box<dyn std::error::Error>> {
        log::info!("querying all accounts data: {:?}", accounts);

        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"SELECT
    trading_day, account_id, account_name,
    balance, frozen_balance, pre_balance,
    available, deposit, withdraw,
    margin, frozen_margin, fee, frozen_fee,
    premium, frozen_premium,
    position_profit, close_profit, net_profit, currency_id
 FROM fund.account WHERE "#,
        );

        if accounts.is_empty() {
            qry_builder.push("TRUE");
        } else {
            qry_builder
                .push("account_id IN ")
                .push_tuples(accounts, |mut b, v| {
                    b.push_bind(*v);
                });
        }

        self.execute_account_qry(qry_builder).await
    }

    pub async fn query_accounts_range(
        &self,
        accounts: &[&str],
        start_date: Option<&str>,
        end_date: Option<&str>,
    ) -> Result<Vec<DBAccount>, Box<dyn std::error::Error>> {
        log::info!(
            "query accounts data between range: {:?}, [{:?}, {:?}]",
            accounts,
            start_date,
            end_date
        );

        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"SELECT
    trading_day, account_id, account_name,
    balance, frozen_balance, pre_balance,
    available, deposit, withdraw,
    margin, frozen_margin, fee, frozen_fee,
    premium, frozen_premium,
    position_profit, close_profit, net_profit, currency_id
 FROM fund.account WHERE "#,
        );

        if !accounts.is_empty() {
            qry_builder
                .push("account_id IN ")
                .push_tuples(accounts, |mut b, v| {
                    b.push_bind(*v);
                });
        } else {
            qry_builder.push("TRUE");
        }

        if let Some(start) = start_date {
            qry_builder.push(" AND trading_day >= ").push_bind(start);
        }

        if let Some(end) = end_date {
            qry_builder.push(" AND trading_day <= ").push_bind(end);
        }

        self.execute_account_qry(qry_builder).await
    }

    pub fn is_closed(&self) -> bool {
        self.pool.is_closed()
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_open() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        rt.block_on(async {
            match DB::new("..\\..\\data", &["fund"]).await {
                Ok(db) => {
                    log::info!("db opened: {:?}", db);
                }
                Err(e) => {
                    log::error!("failed to open db: {:?}", e);
                }
            }
        })
    }

    #[test]
    fn test_query() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(DB::new("..\\..\\data", &["fund"])).unwrap();

        let result = rt.block_on(db.query_accounts(&["1000008"])).unwrap();

        for v in result {
            log::info!("{:?}", v);
        }

        let result = rt
            .block_on(db.query_accounts_range(
                &["880303", "1000008"],
                Some("20250201"),
                Some("20250205"),
            ))
            .unwrap();

        for v in result {
            log::info!("{:?}", v);
        }
    }
}
