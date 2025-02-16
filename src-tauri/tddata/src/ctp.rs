#[derive(Debug, Default, serde::Serialize, Clone)]
pub enum CurrencyID {
    #[default]
    Invalid,
    
    CNY,
    USD
}

impl From<&str> for CurrencyID {
    fn from(value: &str) -> Self {
        match value {
            "CNY" | "￥" => Self::CNY,
            "USD" | "$" => Self::USD,
            _ => Self::default()
        }
    }
}

impl<'de> serde::Deserialize<'de> for CurrencyID {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: serde::Deserializer<'de> {
        
        let v = serde_json::Value::deserialize(deserializer)?;

        match v {
            serde_json::Value::String(s) => Ok(Self::from(s.as_str())),
            _ => Err(serde::de::Error::custom("unsupported value type"))
        }
    }
}

// type PercentValue = f64;
//
// impl<'de> serde::Deserialize<'de> for PercentValue {
//     fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
//     where
//         D: Deserializer<'de>
//     {
//         <f64 as serde::Deserialize>::deserialize(deserializer)
//     }
//
//     fn deserialize_in_place<D>(deserializer: D, place: &mut Self) -> Result<(), D::Error>
//     where
//         D: Deserializer<'de>
//     {
//         todo!()
//     }
// }

mod tu {
    use std::collections::hash_set;
    use std::io::Read;
    use super::CurrencyID;

    #[derive(Debug, Default, serde::Deserialize, serde::Serialize, Clone)]
    pub struct Account {
        #[serde(skip_deserializing)]
        pub trading_day: String,

        #[serde(rename(deserialize = "投资者帐号"))]
        pub user_id: String,
        
        #[serde(rename(deserialize = "投资者名称"))]
        pub user_name: String,
        
        #[serde(rename(deserialize = "风险度"))]
        pub risk_percent: f64,
        
        #[serde(rename(deserialize = "昨权益"))]
        pub pre_balance: f64,
        
        #[serde(rename(deserialize = "入金"))]
        pub deposit: f64,

        #[serde(rename(deserialize = "出金"))]
        pub withdraw: f64,

        #[serde(rename(deserialize = "冻结保证金"))]
        pub frozen_margin: f64,

        #[serde(rename(deserialize = "冻结权利金"))]
        pub frozen_premium: f64,

        #[serde(rename(deserialize = "冻结手续费"))]
        pub frozen_fee: f64,

        #[serde(rename(deserialize = "保证金"))]
        pub margin: f64,

        #[serde(rename(deserialize = "权利金"))]
        pub premium: f64,

        #[serde(rename(deserialize = "手续费"))]
        pub fee: f64,

        #[serde(rename(deserialize = "持仓盈亏"))]
        pub position_profit: f64,

        #[serde(rename(deserialize = "平仓盈亏"))]
        pub close_profit: f64,

        #[serde(rename(deserialize = "权益"))]
        pub balance: f64,

        #[serde(rename(deserialize = "可用资金"))]
        pub available: f64,

        #[serde(rename(deserialize = "资金冻结"))]
        pub frozen_balance: f64,

        #[serde(rename(deserialize = "上次质押金额"))]
        pub pre_pledge: f64,

        #[serde(rename(deserialize = "质押金额"))]
        pub pledge: f64,

        #[serde(rename(deserialize = "投资者交割保证金"))]
        pub deliv_margin: f64,

        #[serde(rename(deserialize = "上次货币质入金额"))]
        pub pre_currency_pledge_in: f64,

        #[serde(rename(deserialize = "上次货币质出金额"))]
        pub pre_currency_pledge_out: f64,

        #[serde(rename(deserialize = "货币质入金额"))]
        pub currency_pledge_in: f64,

        #[serde(rename(deserialize = "货币质出金额"))]
        pub currency_pledge_out: f64,

        #[serde(rename(deserialize = "交易所风险度"))]
        pub risk_percent_in_exchange: f64,

        #[serde(rename(deserialize = "交易所保证金"))]
        pub margin_in_exchange: f64,

        #[serde(rename(deserialize = "交易所可用资金"))]
        pub available_in_exchange: f64,

        #[serde(rename(deserialize = "交易所交割保证金"))]
        pub deliv_margin_in_exchange: f64,

        #[serde(rename(deserialize = "币种代码"))]
        pub currency_id: CurrencyID,
    }

    pub fn read_account_csv(file_path: &str, accounts: &[&str]) -> Result<Vec<Account>, Box<dyn std::error::Error>> {
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
                return Err(Box::new(std::io::Error::new(std::io::ErrorKind::Other, "csv parser error")));
            }

            let name = record.iter().next().unwrap_or("");
            let value = record.iter().nth(1).unwrap_or("");

            match name {
                "日期" => {
                    date = String::from(value);
                }
                "查询结果" => {
                    break;
                },
                _ => {}
            }
        }

        let truncate_data = data[finder.position().byte() as usize + 1..].to_vec();

        let mut parser = csv::ReaderBuilder::new()
            .from_reader(truncate_data.as_slice());

        Ok(parser.deserialize::<Account>().filter_map(|row| {
            match row {
                Ok(mut v) => {
                    if acct_cache.is_empty() || acct_cache.contains(v.user_id.as_str()) {
                        v.trading_day = date.clone();
                        Some(v)
                    } else {
                        None
                    }
                },
                _ => None
            }
        }).collect())
    }
}

mod test {
    use super::*;

    #[test]
    fn test_tu_accounts() {
        let find_accounts = tu::read_account_csv(
            "../../data/查询资金2025-02-06.csv", &["880303"],
        ).expect("read tu accounts failed");

        assert_eq!(find_accounts.len(), 1);
        println!("{:?}", &find_accounts);
    }
}