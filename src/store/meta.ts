import {defineStore} from "pinia";
import dayjs from "dayjs"
import { invoke } from "@tauri-apps/api/core";

import { Vacation, ProductInfo, DBInvestor, DBGroup } from "../models/db.ts"

export const metaStore = defineStore("meta", {
    state: () => {
        return {
            holidays: new Map([]) as Map<string, Vacation>,
            products: new Map([]) as Map<string, ProductInfo>,
            investors: new Map([]) as Map<string, DBInvestor>,
            groups: new Map([]) as Map<number, DBGroup>,
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
        },
        group_investors(state) {
            return [...state.groups.values()]
        }
    },
    actions: {
        async doQueryInvestors(all: boolean, force: boolean = false): Promise<Array<DBInvestor>> {
            return new Promise((resolve, _) => {
                if (this.investors.size > 0 && !force) {
                    console.log("query investor hit data cache:", all);

                    resolve([...this.investors.values()]);
                } else {
                    console.log("query investor from database:", all);
                    invoke("query_investors", {
                        includeAll: all
                    }).then((values) => {
                        const investors = values as Array<DBInvestor>;

                        investors.forEach((v) => {
                            this.investors.set(
                                [v.broker_id, v.investor_id].join("."),
                                v
                            );

                            v.groups?.forEach((g) => {
                                if (g.group_id < 0) return;

                                if (!this.groups.has(g.group_id)) {
                                    this.groups.set(g.group_id, Object.assign({}, g));
                                }

                                this.groups.get(g.group_id)!.investors!.push(v);
                            })
                        })

                        resolve(investors)
                    });
                }
            });
        }
    }
})
