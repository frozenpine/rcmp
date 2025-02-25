<script setup lang="ts">
import {ref, onMounted, computed} from "vue";
import {useOsTheme, darkTheme, dateZhCN, zhCN} from 'naive-ui'
import {
  NConfigProvider, NMessageProvider, NBackTop, NNotificationProvider,
  NSpace, NButton, NIcon, NPopover, NH1, NText, NSwitch,
  NForm, NFormItem, NStatistic, NPageHeader,
} from "naive-ui";
import { Search, ArrowBigUpLine, InfoCircle, CalendarStats } from "@vicons/tabler"
import {UserAlt} from "@vicons/fa";
import {ContactCardGroup16Filled} from "@vicons/fluent"

import Feedback from "./components/Feedback.vue"
import AccountTable from "./components/AccountTable.vue"
import GroupAccountTable from "./components/GroupAccountTable.vue"
import TUAccountSinker from "./components/TUAccountSinker.vue"
import InvestorSelector from "./components/InvestorSelector.vue"
import type {InvestorLoaderInst} from "./components/interface";

import { fundStore } from "./store/fund.ts";
import { metaStore } from "./store/meta.ts";
import { storeToRefs } from "pinia";
import GroupSelector from "./components/GroupSelector.vue";

const fund = fundStore();
const meta = metaStore();
const {firstDate, lastDate} = storeToRefs(fund);

const osTheme = useOsTheme();

const accountLoading = ref(false);
const investorLoaderRef = ref<InvestorLoaderInst>();
const selected = ref<string>("");
const isGroup = ref(true);

const accountData = computed(() => {
  if (isGroup.value) {
    return fund.getGroupAccounts(selected.value);
  } else {
    return fund.getInvestorAccounts(selected.value);
  }
})

function queryAccounts(force: boolean = false) {
  if (!selected.value) return;

  accountLoading.value = true;

  if (isGroup.value) {
    fund.doQueryGroup(selected.value)
        .catch(console.error)
        .finally(() => accountLoading.value = false);
  } else {
    fund.doQueryAccounts(selected.value, {force: force})
        .catch(console.error)
        .finally(() => accountLoading.value = false);
  }
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
      <template #default>
        <n-space v-if="fund.accounts.size > 0" class="container header" justify="space-between">
          <n-statistic label="起始日期">
            <template #prefix>
              <n-icon size="20"><CalendarStats/></n-icon>
            </template>
            <span class="statistics">{{firstDate.format('YYYY-MM-DD')}}</span>
          </n-statistic>
          <n-statistic label="截止日期">
            <template #prefix>
              <n-icon size="20"><CalendarStats/></n-icon>
            </template>
            <span class="statistics">{{lastDate.format('YYYY-MM-DD')}}</span>
          </n-statistic>
          <n-statistic label="分组数">
            <template #prefix>
              <n-icon size="20"><ContactCardGroup16Filled/></n-icon>
            </template>
            <span class="statistics">{{meta.groups.size}}</span>
            <template #suffix>
              <span class="statistics"> 组</span>
            </template>
          </n-statistic>
          <n-statistic label="投资者数">
            <template #prefix>
              <n-icon size="20"><UserAlt/></n-icon>
            </template>
            <span class="statistics">{{meta.investors.size}}</span>
            <template #suffix>
              <span class="statistics"> 位</span>
            </template>
          </n-statistic>
        </n-space>
      </template>
      <template #footer>
        <n-form class="query" :disabled="accountLoading" inline>
          <n-form-item>
            <n-switch v-model:value="isGroup">
              <template #checked>
                组选择
              </template>
              <template #unchecked>
                投资者选择
              </template>
            </n-switch>
          </n-form-item>
          <n-form-item>
            <GroupSelector ref="investorLoaderRef" v-model:selected="selected" v-if="isGroup" />
            <InvestorSelector ref="investorLoaderRef"
                              v-model:selected="selected"
                              @group="g => console.log('investor selected by group:', g)" v-else />
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
      <GroupAccountTable :group_name="selected" :data="accountData"
                         :loading="accountLoading" latest v-if="isGroup" />
      <AccountTable :data="accountData" :loading="accountLoading" v-else />
    </div>
    <n-back-top :style="{zIndex: 999}"><n-icon size="20"><ArrowBigUpLine/></n-icon></n-back-top>
  </n-config-provider>
</template>

<style scoped>
.statistics {
  font-size: 15px;
}
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