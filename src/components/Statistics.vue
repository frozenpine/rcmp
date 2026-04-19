<script setup lang="ts">
import { computed, ref, nextTick, watch } from "vue";
import { NDatePicker, NIcon, NGrid, NGridItem, NStatistic, NPopover, NFlex } from "naive-ui";
import { User, Users, CalendarAlt, InfoCircle } from "@vicons/fa";

import { metaStore } from "../store/meta.ts";
import { Thousandth } from "../utils/formatter.ts";

const meta = metaStore();
const countFmt = Thousandth(0)

const firstDate = computed(() => {
  return meta.firstDay ? meta.firstDay.format('YYYY-MM-DD') : "N/A";
})

const lastDate = computed(() => {
  return meta.lastDay ? meta.lastDay.format('YYYY-MM-DD') : "N/A";
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
  { immediate: true },
)
</script>

<template>
  <n-grid :cols="4" :x-gap="5">
    <n-grid-item>
      <n-flex justify="center">
        <n-statistic :label="`起始日期 ${firstDate ? '(' + firstDate + ')' : ''}`" tabular-nums>
          <template #prefix v-if="!startEdit">
            <n-icon size="15">
              <CalendarAlt />
            </n-icon>
          </template>
          <n-date-picker ref="startPickerRef" type="date" class="datepicker" v-model:formatted-value="selectedStart"
            :is-date-disabled="meta.isHoliday" @blur="() => startEdit = false" clearable v-if="startEdit" />
          <span class="content" :class="{ invalid: selectedStart && selectedStart > lastDate }"
            @dblclick="() => { startEdit = true; nextTick(() => startPickerRef.focus()); }" v-else>
            {{ selectedStart ? selectedStart : firstDate }}
          </span>
          <template #suffix>
            <n-popover placement="bottom-start" v-if="!startEdit">
              <template #trigger>
                <n-icon size="15" style="margin-left: 5px;">
                  <InfoCircle />
                </n-icon>
              </template>
              双击日期选择查询起始日期
            </n-popover>
          </template>
        </n-statistic>
      </n-flex>
    </n-grid-item>
    <n-grid-item>
      <n-flex justify="center">
        <n-statistic :label="`截止日期 ${lastDate ? '(' + lastDate + ')' : ''}`" tabular-nums>
          <template #prefix v-if="!endEdit">
            <n-icon size="15">
              <CalendarAlt />
            </n-icon>
          </template>
          <n-date-picker ref="endPickerRef" type="date" class="datepicker" v-model:formatted-value="selectedEnd"
            :is-date-disabled="meta.isHoliday" @blur="() => endEdit = false" clearable v-if="endEdit" />
          <span class="content" :class="{ invalid: selectedEnd && selectedEnd < firstDate }"
            @dblclick="() => { endEdit = true; nextTick(() => { endPickerRef.focus() }); }" v-else>
            {{ selectedEnd ? selectedEnd : lastDate }}
          </span>
          <template #suffix>
            <n-popover placement="bottom-start" v-if="!endEdit">
              <template #trigger>
                <n-icon size="15" style="margin-left: 5px;">
                  <InfoCircle />
                </n-icon>
              </template>
              双击日期选择查询截止日期
            </n-popover>
          </template>
        </n-statistic>
      </n-flex>
    </n-grid-item>
    <n-grid-item>
      <n-flex justify="center">
        <n-statistic label="分组数" tabular-nums>
          <template #prefix>
            <n-icon size="20">
              <Users />
            </n-icon>
          </template>
          <span class="content">{{ countFmt(meta.groupCount) }}</span>
          <template #suffix>
            <span class="content"> 组</span>
          </template>
        </n-statistic>
      </n-flex>
    </n-grid-item>
    <n-grid-item>
      <n-flex justify="center">
        <n-statistic label="投资者数" tabular-nums>
          <template #prefix>
            <n-icon size="15">
              <User />
            </n-icon>
          </template>
          <span class="content">{{ countFmt(meta.groupedInvestorCount) }}</span>
          <template #suffix>
            <span class="content">/ {{ countFmt(meta.investors ? meta.investors.size : 0) }} 位</span>
          </template>
        </n-statistic>
      </n-flex>
    </n-grid-item>
  </n-grid>
</template>

<style scoped>
.grid {
  justify-content: center;
}

.content {
  font-size: 15px;
}

.invalid {
  color: red
}

.datepicker {
  width: 10ch;
}
</style>