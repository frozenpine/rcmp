<script setup lang="ts">
import { ref, h, reactive, computed, nextTick } from "vue";
import { open } from '@tauri-apps/plugin-dialog';
import { useOsTheme, darkTheme, dateZhCN, zhCN } from 'naive-ui'
import {
  NConfigProvider,
  NSpace, NSpin, NInput, NButton, NCard, NIcon, NButtonGroup,
  NForm, NFormItem,
  NDataTable, NDropdown
} from "naive-ui";
import type { DataTableColumns, DataTableInst } from 'naive-ui'
import { Search, DatabaseImport, Folder } from "@vicons/tabler"
import { FileCsv } from "@vicons/fa"

import { CurrencyFormatter } from "./utils/formatter.ts";
import { DBAccount } from "./models/db.ts"
import { fundStore} from "./store/fund.ts";

const fmt = CurrencyFormatter();
const fund = fundStore();

const columns: DataTableColumns<DBAccount> = [
  {title: "交易日", key: "trading_day", fixed: "left", width: 100},
  {title: "资金账号", key: "account_id", fixed: "left", width: 100},
  {title: "账号名称", key: "account_name", fixed: "left", width: 100},
  {
    title: "昨权益", key: "pre_balance",
    render(row) {return h("label", fmt(row.pre_balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "今权益", key: "balance",
    render(row) {return h("label", fmt(row.balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "持仓盈亏", key: "position_profit",
    render(row) {return h("label", fmt(row.position_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "平仓盈亏", key: "close_profit",
    render(row) {return h("label", fmt(row.close_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "手续费", key: "fee",
    render(row) {return h("label", fmt(row.fee))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "净盈亏", key: "net_profit",
    render(row) {return h("label", fmt(row.net_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {title: "币种", key: "currency_id", fixed: "right", width: 60},
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
const accountID = ref("");
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
});
const dt = ref<DataTableInst>();
const menu = ref<{x: number; y: number; show: boolean}>({x: 0, y: 0, show: false});

async function sink_account(dir: boolean = false) {
  const source = dir? await open({
    title: "文件夹导入",
    multiple: false,
    directory: true,
  }) : await open({
    title: "文件导入",
    multiple: true,
    directory: false,
    filters: [{name: "查询资金", extensions: ["csv"]}],
  });

  if (!source) return;

  parsing.value = true;
  fund.doSinkTuAccount(source)
      .then(count => {
        console.log("all account data sunk finished", source, count)
      })
      .catch(console.error)
      .finally(() => {parsing.value = false;});
}

function query_account() {
  if (!accountID.value) return;

  console.log("querying account data:", accountID.value);
  loading.value = true;

  fund.doQueryAccount(accountID.value)
      .then((accounts) => {
        data.value = accounts;
      })
      .catch(console.error)
      .finally(() => loading.value = false);
}

function handleMenuSelect(sel: string) {
  menu.value.show = false;

  switch (sel) {
    case "all": {
      const {page, pageSize} = pagination;
      pagination.pageSize = pagination.pageSizes[pagination.pageSizes.length - 1];
      pagination.page = 1;

      nextTick().then(()=>{
        dt.value?.downloadCsv({
          fileName: `account_${accountID.value}_all.csv`,
        });

        pagination.pageSize = pageSize;
        pagination.page = page;
      })
      break;
    }
    case "page": {
      dt.value?.downloadCsv({
        fileName: `account_${accountID.value}_partial.csv`,
        keepOriginalData: false,
      })
      break;
    }
    default: {
      console.error("unsupported menu item:", sel);
      break;
    }
  }
}

const getRowKey = (row: any): string => {
  const data = row as DBAccount;
  return [data.trading_day, data.account_id, data.currency_id].join(".")
}

const rowProps = (_: DBAccount) => {
  return {
    onContextmenu: (e: MouseEvent) => {
      e.preventDefault()
      menu.value.show = false;
      nextTick().then(() => {
        menu.value.show = true;
        menu.value.x = e.clientX;
        menu.value.y = e.clientY;
      })
    }
  }
}

</script>

<template>
  <n-config-provider :theme="osTheme==='dark'? darkTheme : null" :locale="zhCN" :date-locale="dateZhCN">
    <n-space vertical class="container">
      <n-space align="center" justify="center">
        <n-card title="Welcome to RCMP" size="huge" hoverable >
          <template #header-extra>
            <n-spin size="small" :show="parsing">
              <n-icon style="margin-right: 5px" size="15"><DatabaseImport/></n-icon>
              <n-button-group size="tiny" :disabled="parsing">
                <n-button @click="()=> sink_account(true)" ghost round >
                  <template #icon>
                    <n-icon><Folder/></n-icon>
                  </template>
                </n-button>
                <n-button @click="()=> sink_account(false)" ghost round >
                  <template #icon>
                    <n-icon><FileCsv/></n-icon>
                  </template>
                </n-button>
              </n-button-group>
            </n-spin>
          </template>
          <n-form justify="center" :disabled="loading" inline>
            <n-form-item>
              <n-input v-model:value="accountID" placeholder="请输入资金账号" clearable />
            </n-form-item>
            <n-form-item>
              <n-button attr-type="submit" @click="query_account" :disabled="!accountID" type="info" >
                <template #icon>
                  <n-icon><Search/></n-icon>
                </template>
                查询
              </n-button>
            </n-form-item>
          </n-form>
        </n-card>
      </n-space>
      <n-data-table ref="dt" :columns="columns" :data="data" :loading="loading"
                    :row-key="getRowKey" :pagination="pagination" :row-props="rowProps"
                    striped ></n-data-table>
      <n-dropdown placement="bottom-start" trigger="manual" :x="menu.x" :y="menu.y" :show="menu.show"
                  :on-clickoutside="() => menu.show = false" @select="handleMenuSelect"
                  :options="[{label: '导出全部', key: 'all'}, {label: '导出当前', key: 'page'}]"></n-dropdown>
    </n-space>
  </n-config-provider>
</template>

<style scoped>
.n-card {
  min-width: 400px;
  background: transparent;
}
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