<script setup lang="ts">
import {ref, onMounted, computed} from "vue";
import {useOsTheme, darkTheme, dateZhCN, zhCN} from 'naive-ui'
import {
  NConfigProvider, NMessageProvider, NBackTop, NNotificationProvider,
  NSpace, NButton, NCard, NIcon, NPopover,
  NForm, NFormItem,
} from "naive-ui";
import { Search, ArrowBigUpLine, InfoCircle } from "@vicons/tabler"

import Feedback from "./components/Feedback.vue"
import AccountTable from "./components/AccountTable.vue"
import TUAccountSinker from "./components/TUAccountSinker.vue"
import InvestorSelector from "./components/InvestorSelector.vue"

import { fundStore } from "./store/fund.ts";

const fund = fundStore();

const osTheme = useOsTheme();

const accountLoading = ref(false);
const investorSelectorRef = ref(undefined);
const selectedInvestor = ref<string>("");

const selectedInvestorAccounts = computed(() => {
  return fund.getInvestorAccounts(selectedInvestor.value);
})

function queryAccounts(force: boolean = false) {
  if (!selectedInvestor.value) return;

  accountLoading.value = true;

  fund.doQueryAccounts(selectedInvestor.value, {force: force})
      .catch(console.error)
      .finally(() => accountLoading.value = false);
}

onMounted(() => {
  investorSelectorRef.value?.loadGroupInvestors();
})
</script>

<template>
  <n-config-provider :theme="osTheme==='dark'? darkTheme : null" :locale="zhCN" :date-locale="dateZhCN">
    <n-message-provider><Feedback :message="true" /></n-message-provider>
    <n-notification-provider><Feedback :notification="true" /></n-notification-provider>
    <n-space vertical class="container">
      <n-space align="center" justify="center">
        <n-card title="Welcome to RCMP" size="huge" hoverable >
          <template #header-extra>
            <TUAccountSinker />
          </template>
          <n-form class="query" :disabled="accountLoading" inline>
            <n-form-item><InvestorSelector ref="investorSelectorRef" v-model:selected="selectedInvestor" /></n-form-item>
            <n-form-item>
              <n-space align="baseline">
                <n-button attr-type="submit"
                          @click.exact.stop="queryAccounts(false)"
                          @click.ctrl.exact.stop="queryAccounts(true)"
                          :disabled="!selectedInvestor" type="info" >
                  <template #icon>
                    <n-icon><Search/></n-icon>
                  </template>
                  查询
                </n-button>
                <n-popover placement="bottom-start">
                  <template #trigger>
                    <n-icon size="20" :depth="3"><InfoCircle/></n-icon>
                  </template>
                  按住Ctrl点击, 强制从数据库刷新
                </n-popover>
              </n-space>
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