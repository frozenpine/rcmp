pub mod ctp;
pub mod db;
pub mod file;

#[cfg(test)]
mod test {
    use super::{ctp::tu, db};
    use std::env;

    #[test]
    fn test_sink_file() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let p = env::current_dir().unwrap();
        log::info!("current directory: {}", p.display());

        let accounts = tu::read_account_csv("../data/查询资金2025-02-06.csv", &[]).unwrap();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(async { db::open_db("../data", &["fund"]).await.unwrap() });

        log::info!("{:?}", &db);

        let row_count = rt.block_on(async {
            // db.sink_accounts(
            //     &accounts
            //         .iter()
            //         .map(|acct| acct as &dyn db::AccountInfo)
            //         .collect::<Vec<_>>(),
            //     1000,
            // )
            // .await
            // .unwrap()
            db.sink_accounts(&accounts, 1000)
                .await
                .unwrap()
        });

        log::info!("row affected: {}", row_count);
    }

    #[test]
    fn test_sink_dir() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let accounts = tu::read_account_dir("../data", &[], 1).unwrap();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(db::open_db("../data", &["fund"])).unwrap();

        log::info!("{:?}", &db);

        let row_count = rt
            .block_on(
                // db.sink_accounts(
                //     &accounts
                //         .iter()
                //         .map(|v| v as &dyn db::AccountInfo)
                //         .collect::<Vec<_>>(),
                //     1000,
                // ),
                db.sink_accounts(&accounts, 1000)
            )
            .unwrap();

        log::info!("row affected: {}", row_count);
    }
}
