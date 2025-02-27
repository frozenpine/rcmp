<script setup lang="ts">
import {ref, onMounted, computed} from "vue";
import {useOsTheme, darkTheme, dateZhCN, zhCN} from 'naive-ui'
import {
  NConfigProvider, NMessageProvider, NBackTop, NNotificationProvider,
  NSpace, NButton, NIcon, NPopover, NH1, NText,
  NForm, NFormItem, NPageHeader,
} from "naive-ui";
import { Search, ArrowBigUpLine, InfoCircle, } from "@vicons/tabler"

import Feedback from "./components/Feedback.vue"
import GroupAccountTable from "./components/GroupAccountTable.vue"
import TUAccountSinker from "./components/TUAccountSinker.vue"
import GroupSelector from "./components/GroupSelector.vue";
import Statistics from "./components/Statistics.vue";
import type {InvestorLoaderInst} from "./components/interface";

import { fundStore } from "./store/fund.ts";

const fund = fundStore();

const osTheme = useOsTheme();

const accountLoading = ref(false);
const investorLoaderRef = ref<InvestorLoaderInst>();
const selected = ref<string>("");
const selectedStart = ref<string | undefined>(undefined);
const selectedEnd = ref<string | undefined>(undefined);

const accountData = computed(() => {
  return fund.getGroupAccounts(selected.value);
})

function queryAccounts(force: boolean = false) {
  if (!selected.value) return;

  accountLoading.value = true;

  console.log("query accounts:", selected.value, selectedStart.value, selectedEnd.value);

  fund.doQueryGroup(
      selected.value,
      {
        startDate: selectedStart.value,
        endDate: selectedEnd.value,
        force: force
      }
  ).catch((e) => {
    console.log("query accounts failed:", e);
  }).finally(() => accountLoading.value = false);
}

onMounted(() => {
  investorLoaderRef.value?.loadGroupInvestors();
})
</script>

<template>
  <n-config-provider :theme="osTheme==='dark'? darkTheme : null" :locale="zhCN" :date-locale="dateZhCN">
    <n-message-provider><Feedback :message="true" /></n-message-provider>
    <n-notification-provider><Feedback :notification="true" /></n-notification-provider>
    <n-page-header subtitle="交易数据分析" class="container">
      <template #header></template>
      <template #title>
        <n-h1 prefix="bar" align-text>
          <n-text>Welcome to RCMP</n-text>
        </n-h1>
      </template>
      <template #extra><TUAccountSinker /></template>
      <template #default><Statistics v-model:start="selectedStart" v-model:end="selectedEnd" /></template>
      <template #footer>
        <n-form class="query" :disabled="accountLoading" inline>
          <n-form-item>
            <GroupSelector ref="investorLoaderRef" v-model:selected="selected" />
          </n-form-item>
          <n-form-item>
            <n-space align="baseline">
              <n-button attr-type="submit"
                        @click.exact.stop="queryAccounts(false)"
                        @click.ctrl.exact.stop="queryAccounts(true)"
                        :disabled="!selected" type="info" >
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
      </template>
    </n-page-header>
    <div class="container">
      <GroupAccountTable :data="accountData" :loading="accountLoading" />
    </div>
    <n-back-top :style="{zIndex: 999}"><n-icon size="20"><ArrowBigUpLine/></n-icon></n-back-top>
  </n-config-provider>
</template>

<style scoped>
.query {
  justify-content: center;
}
.header {
  margin: 0 30px;
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