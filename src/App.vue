<script setup lang="ts">
import { ref } from "vue";
import { useOsTheme, darkTheme, dateZhCN, zhCN } from 'naive-ui'
import {
  NConfigProvider, NMessageProvider, NBackTop,
  NSpace, NInput, NButton, NCard, NIcon,
  NForm, NFormItem,
} from "naive-ui";
import { Search, ArrowBigUpLine } from "@vicons/tabler"

import Feedback from "./components/Feedback.vue"
import AccountTable from "./components/AccountTable.vue"
import TUAccountSinker from "./components/TUAccountSinker.vue"

import { DBAccount } from "./models/db.ts"
import { fundStore } from "./store/fund.ts";

const fund = fundStore();

const osTheme = useOsTheme();
const accountID = ref("");
const loading = ref(false);
const data = ref<DBAccount[]>([]);

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
    <n-message-provider><Feedback/></n-message-provider>
    <n-space vertical class="container">
      <n-space align="center" justify="center">
        <n-card title="Welcome to RCMP" size="huge" hoverable >
          <template #header-extra>
            <TUAccountSinker />
          </template>
          <n-form class="query" :disabled="loading" inline>
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
    <n-back-top :style="{zIndex: 999}"><n-icon size="20"><ArrowBigUpLine/></n-icon></n-back-top>
  </n-config-provider>
</template>

<style scoped>
.n-card {
  min-width: 400px;
  background: transparent;
}
.query {
  justify-content: center;
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