<script setup lang="ts">
import {ref, h, reactive, computed} from "vue";
import { invoke } from "@tauri-apps/api/core";
import { open } from '@tauri-apps/plugin-dialog';
import { useOsTheme, darkTheme, dateZhCN, zhCN } from 'naive-ui'
import {
  NConfigProvider,
  NSpace, NSpin, NInput, NButton, NCard, NIcon,
  NDataTable,
} from "naive-ui";
import type { DataTableColumns } from 'naive-ui'
import {Search, DatabaseImport} from "@vicons/tabler"

import {CurrencyFormatter} from "./utils/formatter.ts";

interface DBAccount {
  trading_day: string;
  account_id: string;
  account_name?: string;
  balance: number;
  frozen_balance: number;
  pre_balance: number;
  available: number;
  deposit: number;
  withdrawal: number;
  margin: number;
  frozen_margin: number;
  fee: number;
  frozen_fee: number;
  position_profit: number;
  close_profit: number;
  net_profit: number;
  currency_id: string;
}

const fmt = CurrencyFormatter();

const columns: DataTableColumns<DBAccount> = [
  {title: "交易日", key: "trading_day"},
  {title: "资金账号", key: "account_id"},
  {title: "账号名称", key: "account_name"},
  {title: "昨权益", key: "pre_balance",
    render(row) {return h("label", fmt(row.pre_balance))}},
  {title: "今权益", key: "balance",
    render(row) {return h("label", fmt(row.balance))}},
  {title: "持仓盈亏", key: "position_profit",
    render(row) {return h("label", fmt(row.position_profit))}},
  {title: "平仓盈亏", key: "close_profit",
    render(row) {return h("label", fmt(row.close_profit))}},
  {title: "手续费", key: "fee",
    render(row) {return h("label", fmt(row.fee))}},
  {title: "净盈亏", key: "net_profit",
    render(row) {return h("label", fmt(row.net_profit))}},
  {title: "币种", key: "currency_id"}
]

const defaultPageSizes = [5, 10, 15, 50];

const pageSizes = computed(()=>{
  if (data.value.length < 1) {
    return defaultPageSizes;
  }

  let idx = 0;

  for (; idx < defaultPageSizes.length; idx++) {
    if (defaultPageSizes[idx] > data.value.length) {
      break;
    }
  }

  return defaultPageSizes.slice(0, idx).concat([data.value.length]);
})

const osTheme = useOsTheme();
const account_id = ref("");
const parsing = ref(false);
const loading = ref(false);
const data = ref<DBAccount[]>([]);
const pagination = reactive({
  page: 1,
  pageSize: 5,
  showSizePicker: true,
  pageSizes: pageSizes,
  onChange: (page: number) => {pagination.page = page},
  onUpdatePageSize: (pageSize: number) => {
    pagination.pageSize = pageSize;
    pagination.page = 1;
  }
})

async function sink_account() {
  await open({multiple: false, directory: true})
      .then(async (dir) => {
        if (!dir) return;

        parsing.value = true;
        await invoke("sink_tu_account", {baseDir: dir, accounts: []})
            .then((count) => {
              console.log("all account data sunk finished", dir, count)
            })
            .catch(console.error)
            .finally(()=>parsing.value = false);
      })
      .catch(console.error);
}

async function query_account() {
  if (!account_id.value) return;

  console.log("querying account data:", account_id.value);
  loading.value = true;

  await invoke("query_accounts", {accounts: [account_id.value], startDate: null, endDate: null})
      .then((values) => {
        data.value = values as DBAccount[];

        console.log(values);
      })
      .catch(console.error)
      .finally(()=> loading.value = false);
}

const getRowKey = (row: any): string => {
  const data = row as DBAccount;
  return [data.trading_day, data.account_id, data.currency_id].join(".")
}
</script>

<template>
  <n-config-provider :theme="osTheme==='dark'? darkTheme : null" :locale="zhCN" :date-locale="dateZhCN">
    <n-space vertical class="container">
      <n-space align="center" justify="center">
        <n-card title="Welcome to RCMP" size="huge">
          <template #header-extra>
            <n-spin size="small" :show="parsing">
              <n-button @click="sink_account" size="small" quaternary round >
                <template #icon>
                  <n-icon><DatabaseImport/></n-icon>
                </template>
                导入
              </n-button>
            </n-spin>
          </template>
          <n-space align="center" justify="center">
            <n-input type="text" v-model:value="account_id" placeholder="请输入资金账号" clearable />
            <n-button @click="query_account" :disabled="!account_id" type="info" >
              <template #icon>
                <n-icon><Search/></n-icon>
              </template>
              查询
            </n-button>
          </n-space>
        </n-card>
      </n-space>
      <n-data-table :columns="columns" :data="data" :loading="loading" :row-key="getRowKey" :pagination="pagination" striped ></n-data-table>
    </n-space>
  </n-config-provider>
</template>

<style scoped>
</style>
<style>
:root {
  font-family: Inter, Avenir, Helvetica, Arial, sans-serif;
  font-size: 16px;
  line-height: 24px;
  font-weight: 400;

  color: #0f0f0f;
  background-color: #f6f6f6;

  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  -webkit-text-size-adjust: 100%;
}

.container {
  margin: 5px;
  padding: 5px;
}

@media (prefers-color-scheme: dark) {
  :root {
    color: #f6f6f6;
    background-color: #2f2f2f;
  }

  a:hover {
    color: #24c8db;
  }
}

</style>