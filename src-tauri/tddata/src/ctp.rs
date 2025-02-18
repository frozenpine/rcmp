use std::fmt::Display;
use super::db;

#[derive(Debug, Default, serde::Serialize, Clone)]
pub enum CurrencyID {
    #[default]
    Invalid,

    CNY,
    USD,
}

impl From<&str> for CurrencyID {
    fn from(value: &str) -> Self {
        match value {
            "CNY" | "￥" => Self::CNY,
            "USD" | "$" => Self::USD,
            _ => Self::default(),
        }
    }
}

impl From<String> for CurrencyID {
    fn from(value: String) -> Self {
        Self::from(value.as_str())
    }
}

impl Display for CurrencyID {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            CurrencyID::CNY => write!(f, "CNY"),
            CurrencyID::USD => write!(f, "USD"),
            _ => write!(f, "{:?}", self),
        }
    }
}

impl<'de> serde::Deserialize<'de> for CurrencyID {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: serde::Deserializer<'de>,
    {
        let v = serde_json::Value::deserialize(deserializer)?;

        match v {
            serde_json::Value::String(s) => Ok(Self::from(s.as_str())),
            _ => Err(serde::de::Error::custom("unsupported value type")),
        }
    }
}

#[derive(Debug, Default, serde::Serialize, Copy, Clone)]
pub struct PercentValue(f64);

impl<'de> serde::Deserialize<'de> for PercentValue {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: serde::Deserializer<'de>
    {
        match <f64 as serde::Deserialize>::deserialize(deserializer) {
            Ok(v) => {Ok(Self(v/100.0))},
            Err(e) => Err(e)
        }
    }

    fn deserialize_in_place<D>(deserializer: D, place: &mut Self) -> Result<(), D::Error>
    where
        D: serde::Deserializer<'de>
    {
        place.0 = f64::deserialize(deserializer)?;
        Ok(())
    }
}

impl Display for PercentValue {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:.2} %", self.0*100.0)
    }
}

pub mod tu {
    use super::{CurrencyID, PercentValue, db};
    use std::collections::hash_set;
    use std::io::Read;

    #[derive(Debug, Default, serde::Deserialize, serde::Serialize, Clone)]
    pub struct Account {
        #[serde(default, alias = "交易日")]
        pub trading_day: String,

        #[serde(alias = "投资者帐号")]
        pub user_id: String,

        #[serde(alias = "投资者名称")]
        pub user_name: String,

        #[serde(alias = "风险度")]
        pub risk_percent: PercentValue,

        #[serde(alias = "昨权益")]
        pub pre_balance: f64,

        #[serde(alias = "入金")]
        pub deposit: f64,

        #[serde(alias = "出金")]
        pub withdraw: f64,

        #[serde(alias = "冻结保证金")]
        pub frozen_margin: f64,

        #[serde(alias = "冻结权利金")]
        pub frozen_premium: f64,

        #[serde(alias = "冻结手续费")]
        pub frozen_fee: f64,

        #[serde(alias = "保证金")]
        pub margin: f64,

        #[serde(alias = "权利金")]
        pub premium: f64,

        #[serde(alias = "手续费")]
        pub fee: f64,

        #[serde(alias = "持仓盈亏")]
        pub position_profit: f64,

        #[serde(alias = "平仓盈亏")]
        pub close_profit: f64,

        #[serde(alias = "权益")]
        pub balance: f64,

        #[serde(alias = "可用资金")]
        pub available: f64,

        #[serde(alias = "资金冻结")]
        pub frozen_balance: f64,

        #[serde(alias = "上次质押金额")]
        pub pre_pledge: f64,

        #[serde(alias = "质押金额")]
        pub pledge: f64,

        #[serde(alias = "投资者交割保证金")]
        pub deliv_margin: f64,

        #[serde(alias = "上次货币质入金额")]
        pub pre_currency_pledge_in: f64,

        #[serde(alias = "上次货币质出金额")]
        pub pre_currency_pledge_out: f64,

        #[serde(alias = "货币质入金额")]
        pub currency_pledge_in: f64,

        #[serde(alias = "货币质出金额")]
        pub currency_pledge_out: f64,

        #[serde(alias = "交易所风险度")]
        pub risk_percent_in_exchange: PercentValue,

        #[serde(alias = "交易所保证金")]
        pub margin_in_exchange: f64,

        #[serde(alias = "交易所可用资金")]
        pub available_in_exchange: f64,

        #[serde(alias = "交易所交割保证金")]
        pub deliv_margin_in_exchange: f64,

        #[serde(alias = "币种代码")]
        pub currency_id: CurrencyID,
    }

    impl db::AccountInfo for Account {
        fn get_trading_day(&self) -> String {
            self.trading_day.clone()
        }

        fn get_account_id(&self) -> String {
            self.user_id.clone()
        }

        fn get_account_name(&self) -> String {
            self.user_name.clone()
        }

        fn get_balance(&self) -> f64 {
            self.balance
        }

        fn get_frozen_balance(&self) -> f64 {
            self.frozen_balance
        }

        fn get_pre_balance(&self) -> f64 {
            self.pre_balance
        }

        fn get_available(&self) -> f64 {
            self.available
        }

        fn get_deposit(&self) -> f64 {
            self.deposit
        }

        fn get_withdraw(&self) -> f64 {
            self.withdraw
        }

        fn get_margin(&self) -> f64 {
            self.margin
        }

        fn get_frozen_margin(&self) -> f64 {
            self.frozen_margin
        }

        fn get_fee(&self) -> f64 {
            self.fee
        }

        fn get_frozen_fee(&self) -> f64 {
            self.frozen_fee
        }

        fn get_premium(&self) -> f64 {
            self.premium
        }

        fn get_frozen_premium(&self) -> f64 {
            self.frozen_premium
        }

        fn get_position_profit(&self) -> f64 {
            self.position_profit
        }

        fn get_close_profit(&self) -> f64 {
            self.close_profit
        }

        fn get_net_profit(&self) -> f64 {
            // FIXME: 权利金计算
            self.position_profit+self.close_profit-self.fee
        }

        fn get_currency_id(&self) -> String {
            self.currency_id.to_string()
        }
    }

    pub fn read_account_csv(
        file_path: &str,
        accounts: &[&str],
    ) -> Result<Vec<Account>, Box<dyn std::error::Error>> {
        log::debug!(
            "opening csv file for data reading with accounts filter: {:?}, {:?}",
            file_path, accounts,
        );

        let f = std::fs::File::open(file_path)?;
        let mut decoder = encoding_rs_io::DecodeReaderBytesBuilder::new()
            .encoding(Some(encoding_rs::GB18030))
            .build(f);

        let mut data: Vec<u8> = Vec::new();
        let _ = decoder.read_to_end(&mut data)?;

        let mut finder = csv::ReaderBuilder::new()
            .has_headers(false)
            .from_reader(data.as_slice());

        let mut date: String = String::from("");

        let mut acct_cache = hash_set::HashSet::with_capacity(accounts.len());

        for acct in accounts {
            acct_cache.insert(*acct);
        }

        let mut record = csv::StringRecord::new();

        while let Ok(exist) = finder.read_record(&mut record) {
            if !exist {
                return Err(Box::new(std::io::Error::new(
                    std::io::ErrorKind::Other,
                    "csv parser error",
                )));
            }

            let name = record.iter().next().unwrap_or("");
            let value = record.iter().nth(1).unwrap_or("");

            match name {
                "日期" => {
                    date = String::from(value);
                    log::info!("trading day for account data found: {:?}", date);
                }
                "查询结果" => {
                    break;
                }
                _ => {}
            }
        }

        let truncate_data = data[finder.position().byte() as usize..].to_vec();

        let mut parser = csv::ReaderBuilder::new().from_reader(truncate_data.as_slice());

        Ok(parser
            .deserialize::<Account>()
            .filter_map(|row| match row {
                Ok(mut v) => {
                    if acct_cache.is_empty() || acct_cache.contains(v.user_id.as_str()) {
                        v.trading_day = date.clone();
                        Some(v)
                    } else {
                        None
                    }
                }
                _ => None,
            })
            .collect())
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_tu_accounts() {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .target(env_logger::Target::Stdout)
            .init();
        
        let find_accounts = tu::read_account_csv(
            "../../data/查询资金2025-02-06.csv", &["880303"])
            .expect("read tu accounts failed");

        assert_eq!(find_accounts.len(), 1);
        assert_eq!(find_accounts[0].user_id, "880303");
        log::info!("{:?}", &find_accounts);
    }
}
