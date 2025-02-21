<script setup lang="ts">
import { ref } from "vue";
import { open } from '@tauri-apps/plugin-dialog';
import { useOsTheme, darkTheme, dateZhCN, zhCN } from 'naive-ui'
import {
  NConfigProvider,
  NSpace, NSpin, NInput, NButton, NCard, NIcon, NButtonGroup,
  NForm, NFormItem,
} from "naive-ui";
import { Search, DatabaseImport, Folder } from "@vicons/tabler"
import { FileCsv } from "@vicons/fa"

import AccountTable from "./components/AccountTable.vue"

import { DBAccount } from "./models/db.ts"
import { fundStore } from "./store/fund.ts";

const fund = fundStore();

const osTheme = useOsTheme();
const accountID = ref("");
const parsing = ref(false);
const loading = ref(false);
const data = ref<DBAccount[]>([]);

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
        data.value = accounts.reverse();
      })
      .catch(console.error)
      .finally(() => loading.value = false);
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
      <AccountTable :data="data" :loading="loading" />
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