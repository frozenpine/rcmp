<script setup lang="ts">
import {ref, onMounted, computed, h} from "vue";
import {useOsTheme, darkTheme, dateZhCN, zhCN, NFlex} from 'naive-ui'
import {
  NConfigProvider, NMessageProvider, NBackTop, NNotificationProvider,
  NSpace, NButton, NIcon, NPopover, NH1, NText, NSwitch,
  NForm, NFormItem, NPageHeader, NScrollbar,
} from "naive-ui";
import { Search, ArrowBigUpLine, InfoCircle, } from "@vicons/tabler"
import {User, Users} from "@vicons/fa";

import Feedback from "./components/Feedback.vue"
import GroupAccountTable from "./components/GroupAccountTable.vue"
import TUAccountSinker from "./components/TUAccountSinker.vue"
import GroupSelector from "./components/GroupSelector.vue";
import InvestorSelector from "./components/InvestorSelector.vue";
import Statistics from "./components/Statistics.vue";
import {useNotification} from "./utils/feedback.ts";
import type {InvestorLoaderInst} from "./components/interface";

import { fundStore } from "./store/fund.ts";
import {metaStore} from "./store/meta.ts";
import {Vacation} from "./models/db.ts";
import dayjs from "dayjs";

const fund = fundStore();
const osTheme = useOsTheme();

const accountLoading = ref(false);
const investorLoaderRef = ref<InvestorLoaderInst>();
const isGroup = ref(true);
const selected = ref<string | undefined>(undefined);
const selectedStart = ref<string | undefined>(undefined);
const selectedEnd = ref<string | undefined>(undefined);

const accountData = computed(() => {
  if (!selected.value) return [];

  return isGroup.value? fund.getGroupAccounts(
      selected.value,
  ) : fund.getInvestorAccounts(
      selected.value.split(".")[2],
      selected.value.split(".")[1],
  );
})

function queryAccounts(force: boolean = false) {
  if (!selected.value) return;

  accountLoading.value = true;

  console.log("query accounts:", isGroup.value, selected.value, selectedStart.value, selectedEnd.value);

  const query = isGroup.value? fund.doQueryGroup(
      selected.value,
      {
        startDate: selectedStart.value,
        endDate: selectedEnd.value,
        force: force
      }
  ) : fund.doQueryAccount(
      selected.value.split(".")[2],
      {
        broker_id: selected.value.split(".")[1],
        startDate: selectedStart.value,
        endDate: selectedEnd.value,
        force: force,
      }
  );

  query.catch((e) => console.log("query accounts failed:", e))
      .finally(() => accountLoading.value = false);
}

const windowHeight = ref<number>(600);
const contentHeight = computed(() => {
  return windowHeight.value - 370;
})

onMounted(() => {
  windowHeight.value = window.innerHeight;

  const notification = useNotification();
  metaStore().doQueryHolidays()
      .then((holidays) => {
        const startYear = holidays[0].year;
        const lastYear = holidays[holidays.length-1].year;

        const yearVacations: Array<[number, Vacation[]]> = holidays.reduce(
            (pre, curr) => {
              if (pre.length === 0 || pre[pre.length-1][0] !== curr.year) {
                pre.push([curr.year, [curr]])
              } else {
                pre[pre.length-1][1].push(curr)
              }
              return pre
            },
            [] as [number, Vacation[]][]
        ).reverse();

        notification.info({
          title: "法定节假日查询完成",
          description: `已获取 [${startYear} ~ ${lastYear}] ${yearVacations.length}年节假日信息`,
          content: () => h(
              NFlex, {vertical: true},
              {
                default: () => yearVacations.map(
                    ([year, vacations]) => h(
                        "span",
                        `${year} 年共计 ${vacations.reduce((pre, curr) => pre + curr.range.length, 0)} 个法定节假日`
                    )
                )
              }
          ),
          meta: dayjs().format("YYYY-MM-DD HH:mm:ss"),
          duration: 5000,
        });
      })
      .catch((e) => {
        console.log("load holidays failed:", e);

        notification.error({
          title: "法定节假日查询错误",
          content: e.message,
          closable: false,
          meta: dayjs().format("YYYY-MM-DD HH:mm:ss"),
        })
      })

  investorLoaderRef.value?.loadGroupInvestors();

  window.addEventListener("resize", (evt) => {
    windowHeight.value = (evt.target! as any).innerHeight;
  })
})
</script>

<template>
  <n-config-provider :theme="osTheme==='dark'? darkTheme : null" :locale="zhCN" :date-locale="dateZhCN">
    <n-message-provider><Feedback :message="true" /></n-message-provider>
    <n-notification-provider><Feedback :notification="true" /></n-notification-provider>
    <n-scrollbar>
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
              <n-switch v-model:value="isGroup" :on-update-value="() => selected = ''">
                <template #checked-icon>
                  <n-icon><Users/></n-icon>
                </template>
                <template #unchecked-icon>
                  <n-icon><User/></n-icon>
                </template>
              </n-switch>
            </n-form-item>
            <n-form-item>
              <GroupSelector ref="investorLoaderRef" v-model:selected="selected" v-if="isGroup" />
              <InvestorSelector ref="investorLoaderRef" v-model:selected="selected" v-else />
            </n-form-item>
            <n-form-item>
              <n-space align="baseline">
                <n-button attr-type="submit" size="small"
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
        <GroupAccountTable :data="accountData" :loading="accountLoading" :max-height="contentHeight" />
      </div>
      <n-back-top :style="{zIndex: 999}"><n-icon size="20"><ArrowBigUpLine/></n-icon></n-back-top>
    </n-scrollbar>
  </n-config-provider>
</template>

<style scoped>
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