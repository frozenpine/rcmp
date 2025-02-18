use sqlx::sqlite::SqlitePoolOptions;
use std::cell::{Ref, RefCell};
use std::collections::HashMap;
use std::ops::Deref;
use std::path::PathBuf;
use std::sync::Mutex;
use lazy_static::lazy_static;
use sqlx::Executor;

pub trait AccountInfo {
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
}

#[derive(Debug, Clone, sqlx::FromRow, serde::Serialize, serde::Deserialize)]
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
}

impl DBAccount {
    pub fn new(info: Box<dyn AccountInfo>) -> Self {
        Self{
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

        Schema{
            name: name.to_string(),
            dsn: dsn.as_path().to_str().unwrap().to_string(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct DB
{
    schemas: RefCell<HashMap<String, Schema>>,
    pool: sqlx::SqlitePool,
}

impl DB {
    pub async fn new(base_dir: &str, schemas: &[&str]) -> Result<DB, Box<dyn std::error::Error>> {
        open_db(base_dir, schemas).await
    }

    pub async fn migrate(&self) -> Result<(), Box<dyn std::error::Error>> {
        todo!()
    }

    pub async fn sink_accounts(&self, accounts: &[Ref<'_, dyn AccountInfo>]) -> Result<u64, Box<dyn std::error::Error>> {
        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            "INSERT INTO fund.account (
                trading_day, account_id, account_name,
                balance, frozen_balance, pre_balance,
                available, deposit, withdraw,
                margin, frozen_margin, fee, frozen_fee,
                premium, frozen_premium,
                position_profit, close_profit, net_profit) "
        );

        qry_builder.push_values(accounts.iter().map(|acct| (
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
            )), |mut b, values  | {
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
                .push_bind(values.17);
        });

        let query = qry_builder.build();
        let result = query.execute(&self.pool).await?;

        Ok(result.rows_affected())
    }

    pub fn is_closed(&self) -> bool {
        self.pool.is_closed()
    }
}

lazy_static! {
    static ref post_conn: Mutex<String> = Mutex::new(String::new());
}

pub async fn open_db(base_dir: &str, schemas: &[&str]) -> Result<DB, Box<dyn std::error::Error>> {
    let schema_cache = RefCell::new(HashMap::with_capacity(schemas.len()));

    for v in schemas {
        let s = Schema::new(base_dir, v);

        if schema_cache.borrow().contains_key(&s.name) {
            log::warn!("Schema already exists: {}", &s.name);
        } else {
            schema_cache.borrow_mut().insert(s.name.clone(), s);
        }
    }


    if let Ok(mut sql) = post_conn.lock() {
        if sql.deref() == "" {
            *sql = schema_cache.clone().borrow().iter().map(
                |(k, v)| format!("ATTACH DATABASE '{}' AS {}", v.dsn, k)
            ).collect::<Vec<String>>().join("; ")
        } else {
            return Err("db with schemas already opened".into());
        }
    }

    let pool = SqlitePoolOptions::new()
        .min_connections(1)
        .max_connections(5)
        .after_connect(|conn, _meta| {
            let sql = post_conn.lock().unwrap().deref().to_string();

            Box::pin(async move {
                conn.execute(sql.as_str()).await?;
                Ok(())
            })
        })
        .connect(":memory:")
        .await?;

    let db = DB{
        schemas: schema_cache,
        pool,
    };

    Ok(db)
}

mod test {
    use super::*;

    #[test]
    fn test_open() {
        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        rt.block_on(async {
            match open_db("../../data", &["fund"]).await {
                Ok(db) => {
                    println!("db opened: {:?}", db);

                    let rows: Vec<(i64, String)> = sqlx::query_as("PRAGMA database_list;")
                        .fetch_all(&db.pool).await.unwrap();

                    for row in rows {
                        println!("{:?}", row);
                    }
                }
                Err(e) => {
                    println!("failed to open db: {:?}", e);
                }
            }
        })
    }
}