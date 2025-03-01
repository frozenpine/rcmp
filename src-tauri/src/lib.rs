// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
mod ctp;
mod db;

use std::fs;
use chrono::Local;
use derivative::Derivative;
use futures::lock::Mutex;
use tauri::path::BaseDirectory;
use tauri::{Manager, State};
use ctp::tu;

async fn sink_tu_accounts(
    db: &db::DB, accounts: Vec<tu::Account>,
) -> Result<u64, String> {
    db.sink_accounts(&accounts, 1000)
        .await
        .map_err(|e| {
            log::error!("sink tu accounts failed: {:?}", e);
            "sink tu accounts failed".to_string()
        })
}

#[tauri::command]
async fn query_investors(include_all: bool, state: State<'_, Mutex<Config>>) -> Result<Vec<db::DBInvestor>, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => db.query_investors(include_all).await.map_err(|e| {
            log::error!("query investors failed: {:?}", e);
            "query investors failed".to_string()
        }),
        None => Err("no database initialized.".into())
    }
}

#[tauri::command]
async fn mod_group_investors(
    group_name: &str,
    group_desc: Option<&str>,
    investors: Vec<db::DBInvestor>,
    state: State<'_, Mutex<Config>>,
) -> Result<db::DBInvestorGroup, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => db.mod_group_investors(
                group_name, group_desc, &investors,
            ).await.map_err(|e| {
                log::error!("mod group investors failed: {:?}", e);
                "mod group investors failed".to_string()
            }),
        None => Err("no database initialized.".into())
    }
}

#[tauri::command]
async fn sink_tu_account_dir(
    base_dir: &str, accounts: Vec<&str>, state: State<'_, Mutex<Config>>,
) -> Result<u64, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => {
            let accounts = tu::read_account_dir(base_dir, &accounts, 1)
                .map_err(|e| e.to_string())?;

            sink_tu_accounts(db, accounts).await
        }
        None => Err("no database initialized.".into())
    }
}

#[tauri::command]
async fn sink_tu_account_files(
    csv_files: Vec<&str>, accounts: Vec<&str>, state: State<'_, Mutex<Config>>
) -> Result<u64, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => {
            let mut data: Vec<Vec<tu::Account>> = Vec::with_capacity(csv_files.len());

            for file in csv_files {
                let accounts = tu::read_account_csv(file, &accounts)
                    .map_err(|e| e.to_string())?;
                data.push(accounts);
            }

            sink_tu_accounts(db, data.concat()).await
        }
        None => Err("no database initialized.".into())
    }
}

#[tauri::command]
async fn query_accounts(
    accounts: Vec<(&str, &str)>,
    start_date: Option<&str>,
    end_date: Option<&str>,
    state: State<'_, Mutex<Config>>,
) -> Result<Vec<db::DBAccount>, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => db
            .query_accounts(&accounts, start_date, end_date)
            .await
            .map_err(|e| {
                log::error!("query accounts failed: {:?}", e);
                "query accounts failed".to_string()
            }),
        None => Err("no database initialized.".into()),
    }
}

#[tauri::command]
async fn query_holidays(
    state: State<'_, Mutex<Config>>,
) -> Result<Vec<db::DBHoliday>, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => db.query_holidays()
            .await
            .map_err(|e| {
                log::error!("query holidays failed: {:?}", e);
                "query holidays failed".to_string()
            }),
        None => Err("no database initialized.".into())
    }
}

#[derive(serde::Deserialize, serde::Serialize, Derivative)]
#[derivative(Debug)]
struct Config {
    #[serde(skip_serializing, skip_deserializing)]
    #[derivative(Debug = "ignore")]
    _db: Option<db::DB>,

    data_base: String,
    sql_base: String,
    schemas: Vec<String>,
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_dialog::init())
        .setup(|app| {
            let tauri_cfg = app.config();

            log::info!("tauri config: {:?}", tauri_cfg);
            log::info!("using config file: config/config.toml");

            let resource_path = app
                .path()
                .resolve("config/config.toml", BaseDirectory::Resource)
                .map_err(|e| {
                    log::error!("failed to resolve config path: {:?}", e);
                    e
                })?;

            let cfg_file = fs::read_to_string(
                resource_path.clone()
            ).map_err(|e| {
                log::error!("read config file failed: {:?}", e);
                e
            })?;

            let mut cfg: Config = toml::from_str(&cfg_file)
                .map_err(|e| {
                    log::error!("parse config failed: {:?}", e);
                    e
                })?;

            if !fs::exists(&cfg.data_base)
                .map_err(|e| {
                    log::error!("check data dir failed: {:?}", e);
                    e
                })?
            {
                log::info!("making data base dir: {}", &cfg.data_base);

                fs::create_dir_all(&cfg.data_base)
                    .map_err(|e| {
                        log::error!("create data base dir failed: {:?}", e);
                        e
                    })?;

                log::info!("create data base dir: {}", &cfg.data_base);
            }

            let db = tauri::async_runtime::block_on(db::migrate_db(
                &cfg.data_base, &cfg.sql_base,
                tauri_cfg.version.clone().unwrap_or_default().as_str(),
                &cfg.schemas
                    .iter()
                    .map(|v| v.as_str())
                    .collect::<Vec<&str>>(),
            )).map_err(|e| {
                log::error!("migrate db failed: {:?}", e);
                e
            }).expect("migrate db failed");

            cfg._db = Some(db);

            app.manage(Mutex::new(cfg));

            log::info!("app initialized");

            Ok(())
        })
        .plugin(tauri_plugin_sql::Builder::new().build())
        .plugin(tauri_plugin_opener::init())
        .plugin(tauri_plugin_dialog::init())
        .plugin(
            tauri_plugin_log::Builder::new()
                .clear_targets()
                .targets(vec![
                    tauri_plugin_log::Target::new(tauri_plugin_log::TargetKind::Stdout),
                    tauri_plugin_log::Target::new(tauri_plugin_log::TargetKind::Folder {
                        path: std::path::PathBuf::from("./logs"),
                        file_name: None,
                    }),
                ])
                .format(|out, message, record| {
                    out.finish(format_args!(
                        "[{}] {:?} [{}]: {}",
                        record.level(),
                        Local::now(),
                        record.target(),
                        message,
                    ))
                })
                .max_file_size(50_000)
                .rotation_strategy(tauri_plugin_log::RotationStrategy::KeepAll)
                .build(),
        )
        .invoke_handler(tauri::generate_handler![
            sink_tu_account_dir,
            sink_tu_account_files,
            query_accounts,
            query_investors,
            mod_group_investors,
            query_holidays,
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

#[cfg(test)]
mod test {
    use std::env;
    use super::*;

    #[test]
    fn test_sink_file() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();

        let p = env::current_dir().unwrap();
        log::info!("current directory: {}", p.display());

        let accounts = tu::read_account_csv(
            "../data/查询资金2025-02-06.csv", &[],
        ).unwrap();

        let rt = tokio::runtime::Builder::new_current_thread()
            .enable_all()
            .build()
            .unwrap();

        let db = rt.block_on(db::open_db("../data", &["fund"]))
            .unwrap();

        log::info!("{:?}", &db);

        let row_count = rt.block_on(db.sink_accounts(&accounts, 1000))
            .unwrap();

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

        let db = rt.block_on(db::open_db("../data", &["fund"]))
            .unwrap();

        log::info!("{:?}", &db);

        let row_count = rt
            .block_on(db.sink_accounts(&accounts, 1000))
            .unwrap();

        log::info!("row affected: {}", row_count);
    }
}
