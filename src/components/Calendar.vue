<script setup lang="ts">
import { ref } from "vue";
import { NIcon, NCalendar, NPopover, NTag, NDatePicker, NButton, NFlex, NInput } from "naive-ui";
import { CalendarAlt, Plus } from "@vicons/fa";

import { metaStore } from "../store/meta.ts";
import { useMessage } from "../utils/feedback.ts";

const meta = metaStore();
const message = useMessage();

const newHolidayName = ref("")
const newHolidayRange = ref()

function holidayName(year: number, month: number, day: number): string {
  const holiday = meta.getHoliday(`${year}-${month}-${day}`);

  return holiday ? holiday.name : "周末";
}
</script>

<template>
    <n-popover trigger="click" content-style="padding: 3px">
        <template #trigger>
            <n-icon size="15"><CalendarAlt/></n-icon>
        </template>
        <n-calendar class="trading-calendar" :is-date-disabled="meta.isHoliday">
            <template #header="{ year, month }">
                <n-flex inline align="center">
                    <span class="calendar-header-text">{{ `${year} 年 ${month} 月` }}</span>
                    <n-popover trigger="click">
                        <template #trigger>
                            <n-button size="tiny" text>
                                <template #icon>
                                    <n-icon><Plus/></n-icon>
                                </template>
                                新增假日
                            </n-button>
                        </template>
                        <n-date-picker size="small" type="daterange" 
                                       :actions="null" panel clearable
                                       v-model:value="newHolidayRange">
                            <template #footer>
                                <n-flex justify="end">
                                    <n-input size="tiny" style="width: 30%;" 
                                             placeholder="请输入假日名"
                                             v-model:value="newHolidayName"></n-input>
                                    <n-button size="tiny" :disabled="!newHolidayName" 
                                              @click="() => meta.addNewVacation(newHolidayName, newHolidayRange).catch(e => message.error(`新增假日失败: ${e}`))">
                                        确认
                                    </n-button>
                                </n-flex>
                            </template>
                        </n-date-picker>
                    </n-popover>
                </n-flex>
            </template>

            <template #default="{ year, month, date }">
            <n-tag
                v-if="meta.isHoliday(`${year}-${month}-${date}`)"
                type="error"
                size="small"
                round
                disabled
                :bordered="false"
            >
                {{ holidayName(year, month, date) }}
            </n-tag>
            </template>
        </n-calendar>
    </n-popover>
</template>

<style scoped>
.trading-calendar {
  height: 100%;
}

.calendar-header-text {
  font-size: 14px;
  font-weight: 500;
}
</style>