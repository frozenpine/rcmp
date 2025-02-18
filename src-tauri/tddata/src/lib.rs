pub mod ctp;
pub mod db;

#[cfg(test)]
mod test {
    use std::env;
    use super::{ctp::tu, db};

    #[test]
    fn test_sink() {
        env_logger::init();
        
        let p = env::current_dir().unwrap();
        println!("current directory: {}", p.display());
        
        let accounts = tu::read_account_csv(
            "../../data/查询资金2025-02-06.csv", &[]
        ).unwrap();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(async {
            db::DB::new("..\\..\\data", &["fund"]).await.unwrap()
        });

        println!("{:?}", &db);

        let line = rt.block_on(async {
            db.sink_accounts(& accounts.iter().map(
                |acct| acct as &dyn db::AccountInfo
            ).collect::<Vec<_>>(), 1000).await.unwrap()
        });

        println!("{}", line);
    }
}
