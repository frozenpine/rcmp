<script setup lang="ts">
import { ref, computed, h } from "vue";
import {
    NIcon, NCalendar, NPopover, NTag, NDatePicker,
    NButton, NButtonGroup, NFlex, NInput, NTree,
    TreeOption, NPopconfirm, NThing,
} from "naive-ui";
import { CalendarAlt, Plus, Minus } from "@vicons/fa";

import { metaStore } from "../store/meta.ts";
import { useMessage } from "../utils/feedback.ts";
import { Vacation } from "../models/db.ts";

const meta = metaStore();
const message = useMessage();

const tdCalendar = ref()
const newHolidayName = ref("");
const newHolidayRange = ref<[number, number] | null>(null);

function holidayName(year: number, month: number, day: number): string {
    const holiday = meta.getHoliday(`${year}-${month}-${day}`);

    return holiday ? holiday.name : "周末";
}

function addNewHoliday() {
    if (!newHolidayName.value) return
    if (!newHolidayRange.value) return

    meta.addNewVacation(
        newHolidayName.value,
        [newHolidayRange.value![0], newHolidayRange.value![1]],
    ).then((v) => {
        message.info(`新假日[${v.name}]已添加: ${v.start} ~ ${v.end}`)
        tdCalendar.value.setShow(false)
    }).catch(() => message.error(`新增假日失败`))
}

const holidayTree = computed(() => {
    return meta.vacation_list.sort((l, r) => r.end - l.end).reduce(
        (data, item) => {
            const last = data[data.length - 1]

            const itemYear = `${item.year}`

            if (!last || itemYear !== last.key) {
                data.push({
                    label: itemYear,
                    key: itemYear,
                    children: [{
                        label: item.name,
                        key: `${item.year}_${item.name}`,
                        data: item,
                    }],
                })
            } else {
                last!.children!.push({
                    label: item.name,
                    key: `${item.year}_${item.name}`,
                    data: item,
                })
            }

            return data
        },
        [] as Array<TreeOption>,
    )
})

const holidayTreeLabelRender = ({ option }: { option: TreeOption }) => {
    if (option.children) return option.label

    const holiday: Vacation = option.data as any

    return h(NPopconfirm, {
        onPositiveClick: () => {
            meta.removeVacation(
                holiday.year, holiday.name,
            ).then(v => {
                if (v > 0) {
                    message.info(`${holiday.year} 年假日 ${holiday.name} 已删除`)
                } else {
                    message.warning(`${holiday.year} 年假日 ${holiday.name} 不存在`)
                }
            }).catch(e => message.error(`假日删除失败：${e}`))
        },
        style: "min-width: 200px",
    }, {
        trigger: () => option.label,
        default: () => h(NThing, {
            title: `${holiday.year}`,
            description: holiday.name,
            content: `是否确认删除该假日: ${holiday.start} ~ ${holiday.end} ?`
        }, {})
    })
}
</script>

<template>
    <n-popover ref="tdCalendar" trigger="click" content-style="padding: 3px">
        <template #trigger>
            <n-icon size="15">
                <CalendarAlt />
            </n-icon>
        </template>
        <n-calendar class="trading-calendar" :is-date-disabled="meta.isHoliday">
            <template #header="{ year, month }">
                <n-flex inline align="center">
                    <span class="calendar-header-text">{{ `${year} 年 ${month} 月` }}</span>
                    <n-popover trigger="click">
                        <template #trigger>
                            <n-button size="tiny" text>
                                <template #icon>
                                    <n-icon>
                                        <Plus />
                                    </n-icon>
                                </template>
                                新增假日
                            </n-button>
                        </template>
                        <n-date-picker size="small" type="daterange" :actions="null" panel clearable
                            v-model:value="newHolidayRange">
                            <template #footer>
                                <n-flex justify="end">
                                    <n-input size="tiny" style="width: 30%;" placeholder="请输入假日名"
                                        v-model:value="newHolidayName" clearable></n-input>
                                    <n-button-group>
                                        <n-button size="tiny" :disabled="!newHolidayName || !newHolidayRange"
                                            @click="addNewHoliday">
                                            添加
                                        </n-button>
                                        <n-button size="tiny" @click="() => newHolidayRange = null">清除</n-button>
                                    </n-button-group>
                                </n-flex>
                            </template>
                        </n-date-picker>
                    </n-popover>
                    <n-popover trigger="click" placement="bottom">
                        <template #trigger>
                            <n-button size="tiny" text>
                                <template #icon>
                                    <n-icon>
                                        <Minus />
                                    </n-icon>
                                </template>
                                删除假日
                            </n-button>
                        </template>
                        <n-tree :data="holidayTree" block-line block-node accordion check-strategy="child" show-line
                            virtual-scroll style="max-height: 300px; min-width: 150px;"
                            :render-label="holidayTreeLabelRender"
                            :override-default-node-click-behavior="({ option }) => option.children ? 'toggleExpand' : 'default'"></n-tree>
                    </n-popover>
                </n-flex>
            </template>
            <template #default="{ year, month, date }">
                <n-tag v-if="meta.isHoliday(`${year}-${month}-${date}`)" type="error" size="small" round disabled
                    :bordered="false">
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