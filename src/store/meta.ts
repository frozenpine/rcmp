import {defineStore} from "pinia";
import dayjs from "dayjs"
import { invoke } from "@tauri-apps/api/core";

import { Vacation, DBInvestor, DBGroup } from "../models/db.ts"

type DateType = string | number | dayjs.Dayjs | Date;

export const metaStore = defineStore("meta", {
    state: () => {
        return {
            holidays: new Map([]) as Map<string, Vacation>,
            vacation_list: [] as Array<Vacation>,
            investors: new Map([]) as Map<string, DBInvestor>,
            groups: new Map([]) as Map<string, DBGroup>,
            ungrouped: new Map([]) as Map<string, DBInvestor>,
            firstDay: undefined as unknown as dayjs.Dayjs,
            lastDay: undefined as unknown as dayjs.Dayjs,
        }
    },
    getters: {
        isHoliday: (state) => {
            return (value: DateType): boolean => {
                const date = dayjs(value);
                const weekDay = date.day();

                return weekDay === 0 || weekDay === 6 || state.holidays.has(date.format("YYYY-MM-DD"))
            }
        },
        getHoliday: (state) => {
            return (value: DateType): Vacation | undefined => {
                const date = dayjs(value)

                return state.holidays.get(date.format("YYYY-MM-DD"))
            }
        },
        getTradingDays: (state) => {
            return (start: DateType | undefined = undefined, end: DateType | undefined): Array<dayjs.Dayjs> | undefined => {
                if (!start && !state.firstDay) {
                    console.log("no start date");
                    return undefined;
                }
                if (!end && !state.lastDay) {
                    console.log("no end date");
                    return undefined;
                }

                const startDate = dayjs(start) || state.firstDay;
                const endDate = dayjs(end) || state.lastDay;

                if (endDate.isBefore(startDate)) {
                    console.loe("invalid range:", startDate, endDate);
                    return undefined
                }

                const result = []

                const diffDays = endDate.diff(startDate, 'day') + 1;

                for (let i=0; i<diffDays; i++) {
                    const d = startDate.add(i, "day")

                    if (!state.isHoliday(d)) {
                        result.push(d);
                    }
                }

                return result
            }
        },
        groupCount: (state): number => {
            return state.groups? state.groups.size : 0
        },
        groupedInvestorCount: (state): number => {
            return state.investors? [...state.investors.values()].reduce(
                (pre, curr) => pre + ((curr.groups && curr.groups.length > 0)? 1 : 0),
                0
            ) : 0;
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
                            const first_day = v.first_day? dayjs(v.first_day) : undefined;
                            const last_day = v.last_day? dayjs(v.last_day) : undefined;

                            if (first_day && (!this.firstDay || first_day!.isBefore(this.firstDay))) {
                                this.firstDay = first_day;
                            }

                            if (last_day && (!this.lastDay || last_day!.isAfter(this.lastDay))) {
                                this.lastDay = last_day;
                            }

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

                    if (!group.investors || group.investors.length < 1) {
                        this.groups.delete(group_name);
                    }

                    resolve(group);
                }).catch(reject);
            })
        },
        async doQueryHolidays(force: boolean=false): Promise<Array<Vacation>> {
            return new Promise((resolve, reject) => {
                if (this.holidays.size > 0 && !force) {
                    resolve(this.vacation_list);
                } else {
                    console.log("query holidays");

                    invoke("query_holidays")
                        .then((values) => {
                            this.vacation_list = values as Vacation[];

                            this.holidays = new Map(
                                this.vacation_list.reduce(
                                    (pre, curr) => pre.concat(
                                        curr.range.map((d) => {
                                            return [d, curr]
                                        })
                                    ),
                                    [],
                                )
                            )

                            console.log("holiday cache:", this.holidays, this.getTradingDays('20250102', '20250206'));

                            resolve(this.vacation_list);
                        }).catch(reject);
                }
            })
        }
    }
})
