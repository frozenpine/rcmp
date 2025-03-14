import { defineStore } from "pinia";
import { invoke } from "@tauri-apps/api/core";
import dayjs from "dayjs";

import { DBAccount } from "../models/db.ts"
import {metaStore} from "./meta.ts"

export const fundStore = defineStore("fund", {
    state: () => {
        return {
            accounts: new Map([]) as Map<string, DBAccount[]>,
        }
    },
    getters: {
        getGroupAccounts: (state) => {
            const meta = metaStore();

            return (group_name: string): DBAccount[] | undefined => {
                const group = meta.getGroup(group_name);

                if (!group) return undefined;

                const investors = new Set<string>(group.investors?.map((v) => {
                    return [v.broker_id, v.investor_id].join(".")
                }))

                const results: DBAccount[] = [];

                investors.forEach((k) => {
                    results.push(...state.accounts.has(k)? state.accounts.get(k)! : []);
                })

                return results;
            }
        },
        getInvestorAccounts: (state) => {
            return (investor_id: string, broker_id: string = "5100"): DBAccount[] | undefined => {
                const idt = [broker_id, investor_id].join(".");
                return state.accounts.get(idt);
            }
        },
    },
    actions: {
        handlerAccounts(accounts: DBAccount[]) {
            accounts.forEach((v) => {
                const idt = [v.broker_id, v.account_id].join(".")

                if (!this.accounts.has(idt)) {
                    this.accounts.set(idt, []);
                }

                this.accounts.get(idt)!.push(v);
            })
        },
        async doQueryAccount(
            account_id: string, {
                broker_id = "5100",
                startDate,
                endDate,
                force = false,
            }: {
                broker_id?: string;
                startDate?: string
                endDate?: string
                force?: boolean
            } = {},
        ): Promise<Array<DBAccount>> {
            return new Promise((resolve, reject) => {
                if (!account_id) { reject("query account is required"); }

                const idt = [broker_id, account_id].join(".");

                if (!force && !startDate && !endDate && this.accounts.has(idt)) {
                    console.log("query account hit data cache:", broker_id, account_id);

                    resolve(this.getInvestorAccounts(account_id, broker_id)!)
                } else {
                    console.log("query account from database:", broker_id, account_id);

                    this.accounts.delete([broker_id, account_id].join("."))

                    const start = startDate? dayjs(startDate) : undefined;
                    const end = endDate? dayjs(endDate) : undefined

                    invoke("query_accounts", {
                        accounts: [[broker_id, account_id]],
                        startDate: start?.format("YYYYMMDD"),
                        endDate: end?.format("YYYYMMDD"),
                    }).then((values) => {
                        this.handlerAccounts(values as DBAccount[]);
                        resolve(values as DBAccount[]);
                    }).catch(reject);
                }
            })
        },
        async doQueryGroup(
            group_name: string,
            {
                startDate,
                endDate,
                force = false,
            }: {
                startDate?: string
                endDate?: string
                force?: boolean
            } = {},
        ): Promise<Array<DBAccount>> {
            const meta = metaStore();

            return new Promise((resolve, reject) => {
                if (!group_name) { reject("query group is required"); }

                const group = meta.getGroup(group_name);
                if (!group) { reject("query group not found"); }

                const persistent_accounts = new Set<string>(this.accounts.keys());
                const exist_accounts = new Set<string>();
                const query_accounts = new Set<string>(group!.investors!.map((v) => {
                    return [v.broker_id, v.investor_id].join(".")
                }))
                persistent_accounts.forEach((k) => {
                    if (!force && !startDate && !endDate && query_accounts.delete(k)) {
                        exist_accounts.add(k);
                    }
                })

                const result: DBAccount[] = [];

                exist_accounts.forEach((k) => {
                    result.push(...this.accounts.has(k)? this.accounts.get(k)! : [])
                })

                console.log("query groups:", persistent_accounts, exist_accounts, query_accounts, startDate, endDate)

                if (exist_accounts.size > 0) {
                    console.log("query group hit data cache:", group_name, exist_accounts);
                } else if (query_accounts.size > 0) {
                    console.log("query group from database:", group_name, query_accounts, startDate, endDate);

                    query_accounts.forEach((k) => {
                        this.accounts.delete(k)
                    })

                    const start = startDate? dayjs(startDate) : undefined;
                    const end = endDate? dayjs(endDate) : undefined

                    invoke("query_accounts", {
                        accounts: [...query_accounts].map((v) => {
                            return v.split(".", 2);
                        }),
                        startDate: start?.format("YYYYMMDD"),
                        endDate: end?.format("YYYYMMDD"),
                    }).then((values) => {
                        this.handlerAccounts(values as DBAccount[]);

                        result.push(...(values as DBAccount[]));
                        resolve(result);
                    }).catch(reject);
                }

                resolve(result);
            })
        },
        async doSinkTuAccount(
            source: string | string[], {
                accounts
            }: {accounts?: string[]} = {},
        ): Promise<number> {
            const sinker = Array.isArray(source) ? () => invoke(
                "sink_tu_account_files", {
                    csvFiles: source, accounts: accounts? accounts : [],
                }) : () => invoke(
                    "sink_tu_account_dir", {
                        baseDir: source, accounts: accounts? accounts : [],
                });

            return new Promise((resolve, reject) => {
                if (!source) { reject("source is required"); }

                sinker()
                    .then((count) => {
                        resolve(count as number)
                    })
                    .catch(reject)
            })
        }
    }
})