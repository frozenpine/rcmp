// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/

use chrono::Local;
use derivative::Derivative;
use futures::lock::Mutex;
use tauri::path::BaseDirectory;
use tauri::{Manager, State};
use tddata::{db, ctp::tu};

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
    accounts: Vec<&str>,
    start_date: Option<&str>,
    end_date: Option<&str>,
    state: State<'_, Mutex<Config>>,
) -> Result<Vec<db::DBAccount>, String> {
    let cfg = state.lock().await;

    match cfg._db.as_ref() {
        Some(db) => db
            .query_accounts_range(&accounts, start_date, end_date)
            .await
            .map_err(|e| {
                log::error!("query accounts failed: {:?}", e);
                "query accounts failed".to_string()
            }),
        None => Err("no database initialized.".into()),
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
            log::info!("using config file: config/config.toml");

            let resource_path = app
                .path()
                .resolve("config/config.toml", BaseDirectory::Resource)
                .unwrap();
            let cfg_file = std::fs::read_to_string(resource_path.clone()).unwrap();

            let mut cfg: Config = toml::from_str(&cfg_file)?;

            let db = tauri::async_runtime::block_on(db::create_db(
                &cfg.data_base,
                &cfg.sql_base,
                &cfg.schemas
                    .iter()
                    .map(|v| v.as_str())
                    .collect::<Vec<&str>>(),
            ))?;

            cfg._db = Some(db);

            app.manage(Mutex::new(cfg));

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
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
