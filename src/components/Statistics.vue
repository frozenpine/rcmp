<script setup lang="ts">
import {computed, ref, nextTick, watch} from "vue";
import {NDatePicker, NIcon, NSpace, NStatistic} from "naive-ui";
import {ContactCardGroup16Filled} from "@vicons/fluent";
import {CalendarStats} from "@vicons/tabler";
import {UserAlt} from "@vicons/fa";

import {metaStore} from "../store/meta.ts";

const meta = metaStore();

const firstDate = computed(() => {
  return meta.firstDay? meta.firstDay.format('YYYY-MM-DD') : "N/A";
})

const lastDate = computed(() => {
  return meta.lastDay? meta.lastDay.format('YYYY-MM-DD') : "N/A";
})

const startEdit = ref<boolean>(false);
const endEdit = ref<boolean>(false);
const startPickerRef = ref();
const endPickerRef = ref();

const selectedStart = defineModel<string | undefined>("start")
const selectedEnd = defineModel<string | undefined>("end")

watch(
    () => [meta.firstDay, meta.lastDay],
    ([first, last]) => {
        if (first && !selectedStart.value) {
          selectedStart.value = first.format("YYYY-MM-DD");
        }

        if (last && !selectedEnd.value) {
            selectedEnd.value = last.format("YYYY-MM-DD");
        }
    },
    {immediate: true},
)

</script>

<template>
  <n-space class="container header" justify="space-between">
    <n-statistic label="起始日期" @dblclick="startEdit=true; nextTick(()=>{startPickerRef.focus()});">
      <template #prefix v-if="!startEdit">
        <n-icon size="20"><CalendarStats/></n-icon>
      </template>
      <n-date-picker ref="startPickerRef" type="date" v-model:formatted-value="selectedStart"
                     @blur="()=> startEdit = false" clearable v-if="startEdit" />
      <span class="statistics" v-else>{{selectedStart? selectedStart : firstDate}}</span>
      <template #suffix v-if="!startEdit && selectedStart && selectedStart !== firstDate">
        <span class="statistics">/ {{firstDate}}</span>
      </template>
    </n-statistic>
    <n-statistic label="截止日期" @dblclick="endEdit=true; nextTick(()=>{endPickerRef.focus()});">
      <template #prefix v-if="!endEdit">
        <n-icon size="20"><CalendarStats/></n-icon>
      </template>
      <n-date-picker ref="endPickerRef" type="date" v-model:formatted-value="selectedEnd"
                     @blur="()=> endEdit = false" clearable v-if="endEdit" />
      <span class="statistics" v-else>{{selectedEnd? selectedEnd : lastDate}}</span>
      <template #suffix v-if="!endEdit && selectedEnd && selectedEnd !== lastDate">
        <span class="statistics">/ {{lastDate}}</span>
      </template>
    </n-statistic>
    <n-statistic label="分组数">
      <template #prefix>
        <n-icon size="20"><ContactCardGroup16Filled/></n-icon>
      </template>
      <span class="statistics">{{ meta.groupCount }}</span>
      <template #suffix>
        <span class="statistics"> 组</span>
      </template>
    </n-statistic>
    <n-statistic label="投资者数">
      <template #prefix>
        <n-icon size="20"><UserAlt/></n-icon>
      </template>
      <span class="statistics">{{ meta.groupedInvestorCount }}</span>
      <template #suffix>
        <span class="statistics">/ {{ meta.investors? meta.investors.size : 0}} 位</span>
      </template>
    </n-statistic>
  </n-space>
</template>

<style scoped>
.statistics {
  font-size: 15px;
}
</style>