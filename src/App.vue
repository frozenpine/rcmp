<script setup lang="ts">
import {ref, onMounted, computed} from "vue";
import {useOsTheme, darkTheme, dateZhCN, zhCN} from 'naive-ui'
import {
  NConfigProvider, NMessageProvider, NBackTop,
  NSpace, NButton, NCard, NIcon,
  NForm, NFormItem,
} from "naive-ui";
import { Search, ArrowBigUpLine } from "@vicons/tabler"

import Feedback from "./components/Feedback.vue"
import AccountTable from "./components/AccountTable.vue"
import TUAccountSinker from "./components/TUAccountSinker.vue"
import InvestorSelector from "./components/InvestorSelector.vue"
import { useMessage } from "./utils/feedback.ts"

import { fundStore } from "./store/fund.ts";
import { metaStore } from "./store/meta.ts";

const fund = fundStore();
const meta = metaStore();

const osTheme = useOsTheme();

const accountLoading = ref(false);
const investorLoading = ref(false);
const selectedInvestor = ref<string>(undefined);

const selectedInvestorAccounts = computed(() => {
  return fund.getInvestorAccounts(selectedInvestor.value);
})

function queryAccounts() {
  if (!selectedInvestor.value) return;

  accountLoading.value = true;

  fund.doQueryAccounts(selectedInvestor.value)
      .catch(console.error)
      .finally(() => accountLoading.value = false);
}

onMounted(() => {
  const message = useMessage();

  investorLoading.value = true;
  meta.doQueryInvestors(true)
      .then((investors) => {
        message.info(`已获取全部投资者信息【${investors.length}】`)
      }).catch((err) => {
        console.error("query investors failed:", err)
        message.error("投资者查询失败", {
          closable: true,
          duration: 0,
        })
      }).finally(()=>investorLoading.value = false);
})
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
          <n-form class="query" :disabled="accountLoading" inline>
            <n-form-item><InvestorSelector v-model:selected="selectedInvestor" :loading="investorLoading"/></n-form-item>
            <n-form-item>
              <n-button attr-type="submit" @click="queryAccounts" :disabled="!selectedInvestor" type="info" >
                <template #icon>
                  <n-icon><Search/></n-icon>
                </template>
                查询
              </n-button>
            </n-form-item>
          </n-form>
        </n-card>
      </n-space>
      <AccountTable :data="selectedInvestorAccounts" :loading="accountLoading" />
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