import {defineStore} from "pinia";
import dayjs from "dayjs"
import { invoke } from "@tauri-apps/api/core";

import { Vacation, DBInvestor, DBGroup } from "../models/db.ts"

export const metaStore = defineStore("meta", {
    state: () => {
        return {
            holidays: new Map([]) as Map<string, Vacation>,
            investors: new Map([]) as Map<string, DBInvestor>,
            groups: new Map([]) as Map<string, DBGroup>,
            ungrouped: new Map([]) as Map<string, DBInvestor>,
        }
    },
    getters: {
        isHoliday: (state) => {
            return (value: string | number | dayjs.Dayjs | Date): boolean => {
                const date = dayjs(value)

                return state.holidays.has(date.format("YYYY-MM-DD"))
            }
        },
        getHoliday: (state) => {
            return (value: string | number | dayjs.Dayjs | Date): Vacation | undefined => {
                const date = dayjs(value)

                return state.holidays.get(date.format("YYYY-MM-DD"))
            }
        },
        getGroup: (state) => {
            return (name: string): DBGroup|undefined => {
                return state.groups.get(name);
            }
        },
        getInvestor: (state) => {
            return (investor_id: string, broker_id: string = "5100"): DBInvestor | undefined => {
                const idt = [broker_id, investor_id].join(".")
                return state.investors.get(idt);
            }
        },
        allInvestors: (state): DBInvestor[] => {
            return [...state.investors.values()];
        },
        groupInvestors: (state): DBGroup[] => {
            return [...state.groups.values()].concat([{
                group_name: "未分组",
                investors: [...state.ungrouped.values()],
            } as DBGroup])
        }
    },
    actions: {
        async doQueryInvestors(
            {
                all = true,
                force = false,
            }: {
                all?: boolean,
                force?: boolean
            } = {},
        ): Promise<Array<DBInvestor>> {
            return new Promise((resolve, reject) => {
                if (this.investors.size > 0 && !force) {
                    console.log("query investor hit data cache:", all);

                    resolve([...this.investors.values()]);
                } else {
                    console.log("query investor from database:", all);
                    invoke("query_investors", {
                        includeAll: all
                    }).then((values) => {
                        const investors = values as Array<DBInvestor>;

                        this.investors.clear();
                        this.groups.clear();
                        this.ungrouped.clear();

                        investors.forEach((v) => {
                            const idt = [v.broker_id, v.investor_id].join(".");
                            this.investors.set(idt, v);

                            if (v.groups && v.groups.length > 0) {
                                v.groups?.forEach((g) => {
                                    if (!this.groups.has(g.group_name)) {
                                        this.groups.set(g.group_name, Object.assign(g, {
                                            investors: [],
                                        }));
                                    }

                                    this.groups.get(g.group_name)!.investors!.push(v);
                                })
                            } else {
                                this.ungrouped.set(idt, v)
                            }
                        })

                        resolve(investors)
                    }).catch(reject);
                }
            });
        },
        async doModifyGroup(group_name: string, {
            investors,
        }: {
            investors?: DBInvestor[],
        }): Promise<DBGroup> {
            return new Promise((resolve, reject) => {
                if (group_name === "") reject("group name is empty")

                invoke("mod_group_investors", {
                    groupName: group_name,
                    groupDesc: "",
                    investors: investors?.map(v => {
                        return {
                            broker_id: v.broker_id,
                            investor_id: v.investor_id,
                            investor_name: v.investor_name,
                            investor_desc: v.investor_desc,
                        }
                    }),
                }).then((g) => {
                    const group = g as DBGroup;
                    this.groups.set(group.group_name, group)

                    group.investors?.forEach((v) => {
                        const idt = [v.broker_id, v.investor_id].join(".")
                        this.ungrouped.delete(idt);
                    })
                    resolve(group);
                }).catch(reject);
            })
        },
    }
})
