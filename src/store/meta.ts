import {defineStore} from "pinia";
import dayjs from "dayjs"

import { Vacation, ProductInfo } from "../models/db.ts"

export const metaStore = defineStore("meta", {
    state: () => {
        return {
            initialized: false as Boolean,
            holidays: new Map([]) as Map<string, Vacation>,
            products: new Map([]) as Map<string, ProductInfo>,
        }
    },
    getters: {
        is_holiday: (state) => {
            return (value: string | number | dayjs.Dayjs | Date): boolean => {
                const date = dayjs(value)

                return state.holidays.has(date.format("YYYY-MM-DD"))
            }
        },
        get_holiday: (state) => {
            return (value: string | number | dayjs.Dayjs | Date): Vacation | undefined => {
                const date = dayjs(value)

                return state.holidays.get(date.format("YYYY-MM-DD"))
            }
        }
    }
})
