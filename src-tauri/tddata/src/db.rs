use std::cell::Ref;
use sqlx::sqlite::SqlitePoolOptions;
use sqlx::SqlitePool;

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

pub struct DB<T> where T: sqlx::Database {
    dsn: String,
    username: Option<String>,
    password: Option<String>,
    pool: T,
}

pub async fn open_db(dsn: &str, username: Option<&str>, password: Option<&str>) -> Result<(), Box<dyn std::error::Error>> {
    // let pool = SqlitePoolOptions::new()
    //     .max_connections(5)
    //     .connect(dsn)
    //     .await?;
    // 
    // let db = DB{
    //     dsn: dsn.to_string(),
    //     username: match username { Some(u) => Some(u.to_string()), None => None },
    //     password: match password { Some(p) => Some(p.to_string()), None => None  },
    //     pool: pool,
    // };
    // 
    // Ok(())
    todo!()
}

pub fn sink_accounts(accounts: &[Ref<dyn AccountInfo>]) -> Result<(), Box<dyn std::error::Error>> {
    todo!()
}