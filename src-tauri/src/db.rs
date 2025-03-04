use lazy_static::lazy_static;
use sqlx::sqlite::SqlitePoolOptions;
use sqlx::{Executor, Row};
use std::collections::{HashMap, HashSet};
use std::error::Error;
use std::fs;
use std::ops::Deref;
use std::path::PathBuf;
use std::sync::Mutex;
use sqlx::migrate::MigrateDatabase;

pub trait AccountInfo: Send + Sync {
    fn get_trading_day(&self) -> String;
    fn get_broker_id(&self) -> String;
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
    pub broker_id: String,
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
            broker_id: info.get_broker_id(),
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

#[derive(Debug, Clone, Default, sqlx::FromRow, serde::Serialize, serde::Deserialize)]
#[sqlx(default)]
pub struct DBInvestorGroup {
    pub group_name: String,
    pub group_desc: String,
    pub created_at: Option<chrono::NaiveDateTime>,
    pub deleted_at: Option<chrono::NaiveDateTime>,
    #[sqlx(skip)]
    pub investors: Option<Vec<DBInvestor>>,
}

#[derive(Debug, Clone, Default, sqlx::FromRow, serde::Serialize, serde::Deserialize)]
#[sqlx(default)]
pub struct DBInvestor {
    pub broker_id: String,
    pub investor_id: String,
    pub investor_name: String,
    pub investor_desc: String,
    #[sqlx(skip)]
    pub first_day: Option<String>,
    #[sqlx(skip)]
    pub last_day: Option<String>,
    pub created_at: Option<chrono::NaiveDateTime>,
    pub deleted_at: Option<chrono::NaiveDateTime>,
    #[sqlx(skip)]
    pub groups: Option<Vec<DBInvestorGroup>>,
}

#[derive(Debug, Clone, Default, sqlx::FromRow, serde::Serialize, serde::Deserialize)]
#[sqlx(default)]
pub struct DBHoliday {
    pub year: i32,
    pub name: String,
    pub start: i32,
    pub end: i32,
    #[sqlx(skip)]
    pub range: Vec<String>,
}

#[derive(Debug, Clone)]
struct Schema {
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
    pub async fn sink_accounts<T: AccountInfo>(
        &self,
        accounts: &[T],
        batch_size: usize,
    ) -> Result<u64, Box<dyn Error>> {
        if self.is_closed() {
            return Err("DB is closed".into());
        }

        log::debug!("sinking for account data: {}", accounts.len());

        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"INSERT OR REPLACE INTO fund.account (
    trading_day, broker_id, account_id, account_name,
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
                        acct.get_broker_id(),
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
                        .push_bind(values.18)
                        .push_bind(values.19);
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
    ) -> Result<Vec<DBAccount>, Box<dyn Error>> {
        qry_builder.push(" ORDER BY account_id ASC, trading_day DESC;");

        let query = qry_builder.build_query_as::<DBAccount>();
        Ok(query.fetch_all(&self.pool).await?)
    }

    pub async fn query_accounts(
        &self,
        accounts: &[(&str, &str)],
        start_date: Option<&str>,
        end_date: Option<&str>,
    ) -> Result<Vec<DBAccount>, Box<dyn Error>> {
        if self.is_closed() {
            return Err("DB is closed".into());
        }

        log::info!(
            "query accounts range data with args: {:?}, [{:?}, {:?}]",
            accounts,
            start_date,
            end_date
        );

        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"SELECT
    trading_day, broker_id, account_id, account_name,
    balance, frozen_balance, pre_balance,
    available, deposit, withdraw,
    margin, frozen_margin, fee, frozen_fee,
    premium, frozen_premium,
    position_profit, close_profit, net_profit, currency_id
 FROM fund.account WHERE "#,
        );

        if !accounts.is_empty() {
            qry_builder
                .push("(broker_id, account_id) IN ")
                .push_tuples(accounts, |mut b, (broker, account)| {
                    b.push_bind(*broker)
                        .push_bind(*account);
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

    pub async fn query_investors(
        &self, include_all: bool,
    ) -> Result<Vec<DBInvestor>, Box<dyn Error>> {
        if self.is_closed() {
            return Err("DB is closed".into());
        }

        log::info!("query investors data with args: {}", include_all);

        let mut qry_builder = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"WITH investors AS (
    SELECT
        u.broker_id, u.investor_id, u.investor_name, u.investor_desc, u.created_at AS inv_create,
        g.group_name, g.group_desc, g.created_at AS grp_create,
        v.first_day, v.last_day
    FROM meta.investor_info u, meta.group_info g
    INNER JOIN meta.investor_group r
    ON 
        u.broker_id = r.broker_id AND
        u.investor_id = r.investor_id AND 
        g.group_name = r.group_name AND 
        u.deleted_at IS NULL AND g.deleted_at IS NULL AND r.deleted_at IS NULL
    INNER JOIN (
        SELECT
            g.broker_id,
            g.account_id,
            min(trading_day) AS first_day,
            max(trading_day) AS last_day
        FROM fund.account g
        GROUP BY g.broker_id, g.account_id
    ) v
    ON u.broker_id = v.broker_id AND u.investor_id = v.account_id
)
SELECT * FROM investors
UNION ALL SELECT
    broker_id, account_id AS investor_id, account_name AS investor_name, '' AS investor_desc, NULL AS inv_create,
    '' AS group_name, '' AS group_desc, NULL AS grp_create,
    min(trading_day) AS first_day,
    max(trading_day) AS last_day
FROM fund.account
WHERE $1 AND account_id NOT IN (SELECT investor_id FROM investors)
GROUP BY broker_id, account_id
ORDER BY group_name DESC, broker_id, investor_id;"#
        );
        
        let rows = qry_builder.build()
            .bind(include_all)
            .fetch_all(&self.pool).await?;
        
        if rows.is_empty() { return Ok(Vec::new()); }
        
        let mut investors: Vec<DBInvestor> = Vec::with_capacity(rows.len());

        for row in rows {
            let broker_id = row.get("broker_id");
            let investor_id = row.get("investor_id");
            
            if investors.is_empty() || 
                investors[investors.len() - 1].broker_id != broker_id || 
                investors[investors.len() - 1].investor_id != investor_id {
                
                investors.push(DBInvestor{
                    broker_id,
                    investor_id,
                    investor_name: row.get("investor_name"),
                    investor_desc: row.get("investor_desc"),
                    first_day: row.get("first_day"),
                    last_day: row.get("last_day"),
                    created_at: row.get("inv_create"),
                    deleted_at: None,
                    groups: None,
                });
            }

            let group_name: String = row.get("group_name");

            if !group_name.is_empty() {
                let idx = investors.len() - 1;
                let investor = &mut investors[idx];

                if investor.groups.is_none() {
                    investor.groups = Some(vec![])
                }

                investor.groups.as_mut().unwrap()
                    .push(DBInvestorGroup{
                        group_name: group_name.clone(),
                        group_desc: row.get("group_desc"),
                        created_at: row.get("grp_create"),
                        deleted_at: None,
                        investors: None,
                    });
            }
        }

        Ok(investors)
    }

    pub async fn mod_group_investors(
        &self, group_name: &str, group_desc: Option<&str>,
        investors: &[DBInvestor],
    ) -> Result<DBInvestorGroup, Box<dyn Error>> {
        if group_name.is_empty() {
            return Err("Group name is empty".into());
        }

        let desc = group_desc.unwrap_or("");

        log::info!("inserting group: {}", group_name);
        let mut group = sqlx::QueryBuilder::<sqlx::Sqlite>::new(
            r#"INSERT OR REPLACE INTO meta.group_info(group_name, group_desc)"#
        ).push_values(
            [(group_name, desc)],
            |mut b, values| {
                b.push_bind(values.0)
                    .push_bind(values.1);
            }
        ).push("RETURNING group_name, group_desc, created_at, deleted_at;")
            .build_query_as::<DBInvestorGroup>()
            .fetch_one(&self.pool)
            .await?;

        if !investors.is_empty() {
            log::info!("inserting for group investors: {:?}", investors);

            group.investors = Some(sqlx::QueryBuilder::<sqlx::Sqlite>::new(
                r#"INSERT OR REPLACE INTO meta.investor_info(
    broker_id, investor_id, investor_name, investor_desc)"#
            ).push_values(
                investors.iter().filter_map(|v| {
                    if v.broker_id.is_empty() || v.investor_id.is_empty() {
                        log::warn!("investor data is incomplete, filtered out: {:?}", v);
                        None
                    } else {
                        Some((
                            v.broker_id.as_str(),
                            v.investor_id.as_str(),
                            v.investor_name.as_str(),
                            v.investor_desc.as_str(),
                        ))
                    }
                }),
                |mut b, values| {
                    b.push_bind(values.0)
                        .push_bind(values.1)
                        .push_bind(values.2)
                        .push_bind(values.3);
                }
            ).push(
                "RETURNING broker_id, investor_id, investor_name, investor_desc, created_at, deleted_at;"
            ).build_query_as::<DBInvestor>()
                .fetch_all(&self.pool)
                .await?);

            log::info!("inserting for group investors: {:?}", group.investors);
            sqlx::QueryBuilder::<sqlx::Sqlite>::new(
                r#"INSERT OR REPLACE INTO meta.investor_group(group_name, broker_id, investor_id) "#
            ).push_values(
                group.investors
                    .as_ref()
                    .unwrap()
                    .iter()
                    .map(|v| {
                        (group_name, v.broker_id.as_str(), v.investor_id.as_str())
                    }),
                |mut b, values| {
                    b.push_bind(values.0)
                        .push_bind(values.1)
                        .push_bind(values.2);
                }
            ).push(
                r#"; UPDATE meta.investor_group SET deleted_at = CURRENT_TIMESTAMP
WHERE group_name = $1 AND (broker_id, investor_id) NOT IN"#
            ).push_tuples(
                investors.iter().map(|v| {
                    (v.broker_id.as_str(), v.investor_id.as_str())
                }),
                |mut b, values| {
                    b.push_bind(values.0)
                        .push_bind(values.1);
                }
            ).build()
                .bind(group_name)
                .execute(&self.pool)
                .await?;
        }

        Ok(group)
    }

    pub async fn query_holidays(&self) -> Result<Vec<DBHoliday>, Box<dyn Error>> {
        if self.is_closed() {
            return Err("DB is closed".into());
        }

        log::info!("querying vacations");

        let mut qry_builder = sqlx::QueryBuilder::new(
            r#"SELECT
year, name, start, end
FROM meta.holidays
WHERE deleted_at IS NULL
ORDER BY year, start"#);

        let query = qry_builder.build_query_as::<DBHoliday>();

        let mut holidays = query.fetch_all(&self.pool).await?;

        for holiday in holidays.iter_mut() {
            let start = match chrono::NaiveDate::from_ymd_opt(
                holiday.start/10000,
                holiday.start as u32 % 10000 / 100,
                holiday.start as u32 % 100,
            ) {
                Some(date) => date,
                None => {
                    log::error!("parse start date failed: {:?}", holiday);
                    return Err("parse start date failed".into());
                }
            };
            
            let end = match chrono::NaiveDate::from_ymd_opt(
                holiday.end/10000,
                holiday.end as u32 % 10000 / 100,
                holiday.end as u32 % 100,
            ) {
                Some(date) => date,
                None => {
                    log::error!("parse end date failed: {:?}", holiday);
                    return Err("parse end date failed".into());
                }
            };

            for d in start.iter_days().take_while(
                |d| *d <= end,
            ) {
                holiday.range.push(d.format("%Y-%m-%d").to_string());
            }
        }

        Ok(holidays)
    }

    pub fn is_closed(&self) -> bool {
        self.pool.is_closed()
    }
}

pub async fn open_db(
    base_dir: &str, schemas: &[&str],
) -> Result<DB, Box<dyn Error>> {
    if base_dir.is_empty() {
        return Err("open db preflight check failed".into());
    }

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

    let db = DB {
        pool
    };

    Ok(db)
}

async fn get_or_create_conn(db_file_path: &str) -> Result<(sqlx::Pool<sqlx::Sqlite>, bool), sqlx::Error> {
    let mut exist = true;

    if !sqlx::Sqlite::database_exists(db_file_path).await? {
        sqlx::Sqlite::create_database(db_file_path).await?;
        exist = false;
    }

    Ok((SqlitePoolOptions::new()
        .min_connections(1)
        .max_connections(1)
        .connect(db_file_path)
        .await?, exist))
}

pub async fn create_db(
    base_dir: &str, sql_dir: &str, schemas: &[&str],
) -> Result<DB, Box<dyn Error>> {
    if base_dir.is_empty() || sql_dir.is_empty() {
        return Err("create db preflight check failed".into());
    }

    let mut schema_set = HashSet::with_capacity(schemas.len());

    for v in schemas {
        if !schema_set.insert(*v) {
            log::warn!("Schema already exists: {}", *v);
        }
    }

    for schema in schema_set {
        let db_path = PathBuf::from(base_dir)
            .join(schema)
            .with_extension("db");

        let sql_base = PathBuf::from(sql_dir)
            .join(schema);

        let (conn, _) = get_or_create_conn(db_path.to_str().unwrap())
            .await?;

        let structure_sql_path = sql_base
            .join(schema)
            .with_extension("sql");

        log::debug!("create schema structure by: {:?}", structure_sql_path);
        let structure_sql = fs::read_to_string(
            structure_sql_path,
        )?;

        let _ = sqlx::query(&structure_sql)
            .execute(&conn)
            .await?;

        for entry in walkdir::WalkDir::new(sql_base)
            .max_depth(1)
            .into_iter()
            .filter_map(Result::ok)
            .filter(|e| {
                if !e.file_type().is_file() {
                    return false;
                }

                let file_name = e.file_name().to_str().unwrap_or("");

                if !file_name.starts_with(&format!("{}-", schema)) {
                    return false;
                }

                file_name.ends_with("sql")
            })
        {
            let mut data_sql_done = PathBuf::from(entry.path());
            data_sql_done.set_extension("ok");

            if let Ok(exist) = fs::exists(data_sql_done.as_path()) {
                if exist {
                    log::info!("initial data already done: {:?}, {:?}", entry, data_sql_done);
                    continue;
                }
            }

            log::debug!("executing data insert by: {:?}", entry);

            let data_sql = fs::read_to_string(entry.path())?;

            match sqlx::query(&data_sql)
                .execute(&conn)
                .await
            {
                Ok(result) => {
                    log::info!("data sql finished: {:?}", result);

                    match fs::File::create(data_sql_done.as_path()) {
                        Ok(_) => log::info!("data ok file created: {:?}", data_sql_done),
                        Err(e) => log::error!("failed to create data ok file: {:?}", e),
                    }
                },
                Err(e) => log::error!("data sql exec failed: {:?}, {:?}", entry, e),
            }
        }
    }

    open_db(base_dir, schemas).await
}

pub async fn migrate_db(
    base_dir: &str, sql_base: &str, version: &str,
    schemas: &[&str],
) -> Result<DB, Box<dyn Error>> {
    if base_dir.is_empty() | sql_base.is_empty() | version.is_empty() {
        return Err("migrate db preflight check failed".into());
    }

    let mut schema_set = HashSet::with_capacity(schemas.len());

    for v in schemas {
        if !schema_set.insert(*v) {
            log::warn!("Schema already exists: {}", *v);
        }
    }

    for schema in schema_set {
        let migrate_sql_file = PathBuf::from(sql_base)
            .join(schema)
            .join(format!("{}_migrate_{}.sql", schema, version));

        log::info!("check migration: {}, {}, {:?}", schema, version, migrate_sql_file);

        if fs::exists(&migrate_sql_file).unwrap_or(false) {
            let migrate_done = PathBuf::from(&migrate_sql_file)
                .with_extension("ok");

            if fs::exists(&migrate_done).unwrap_or(false) {
                log::info!("migration already done: {:?}, {:?}",
                        migrate_sql_file, migrate_done);
                continue;
            }

            let migrate_sql = fs::read_to_string(&migrate_sql_file)?;

            log::info!("migrate sql found: {:?}", migrate_sql_file);

            let db_path = PathBuf::from(base_dir)
                .join(schema)
                .with_extension("db");

            let (conn, exist) = get_or_create_conn(db_path.to_str().unwrap())
                .await?;

            if !exist {
                log::info!("db not exist, skip migration: {}, {}", schema, version);
                continue;
            }

            match sqlx::query(&migrate_sql).execute(&conn).await {
                Ok(_) => {
                    log::info!("migrate successfully executed: {:?}", migrate_sql_file);

                    if fs::File::create(&migrate_done).is_ok() {
                        log::info!(
                                "migrate marked done: {:?}, {:?}",
                                migrate_sql_file, migrate_done
                            );
                    }
                },
                Err(e) => { return Err(e.into()); },
            };
        } else {
            log::info!("no migration for current schema: {}, {}", schema, version);
        }
    }

    create_db(base_dir, sql_base, schemas).await
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
            match open_db("../data", &["fund"]).await {
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
    fn test_create() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        rt.block_on(async {
            match create_db(
                "../data", "../sql",
                &["fund", "meta"])
                .await
            {
                Ok(db) => log::info!("db created: {:?}", db),
                Err(e) => log::error!("failed to create db: {:?}", e),
            }
        })
    }

    #[test]
    fn test_query_account() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(open_db("./data", &["fund"]))
            .unwrap();

        let result = rt.block_on(db.query_accounts(&[("5100", "1000008")], None, None))
            .unwrap();

        for v in result {
            log::info!("{:?}", v);
        }

        let result = rt.block_on(db.query_accounts(
            &[("5100", "880303"), ("5100","1000008")],
            Some("20250201"),
            Some("20250206"),
        )).unwrap();

        for v in result {
            log::info!("{:?}", v);
        }
    }

    #[test]
    fn test_query_investor() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(open_db("./data", &["fund", "meta"]))
            .unwrap();

        let result = rt.block_on(db.query_investors(true))
            .unwrap();

        for v in result {
            log::info!("{:?}", v);
        }
    }

    #[test]
    fn test_mod_group_investors() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(open_db("./data", &["fund", "meta"]))
            .unwrap();

        let g = rt.block_on(db.mod_group_investors(
            "test", None, &[DBInvestor{
                broker_id: "5100".to_string(),
                investor_id: "123456".to_string(),
                investor_name: "test".to_string(),
                investor_desc: Default::default(),
                first_day: None,
                last_day: None,
                created_at: None,
                deleted_at: None,
                groups: None,
            }],
        )).unwrap();

        log::info!("{:?}", g);
    }
    
    #[test]
    fn test_query_holidays() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(open_db("./data", &["fund", "meta"]))
            .unwrap();
        
        let result = rt.block_on(db.query_holidays())
            .unwrap();
        
        for v in result {
            log::info!("{:?}", v);
        }
    }
}
