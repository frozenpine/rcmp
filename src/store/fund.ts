import { defineStore } from "pinia";
import { invoke } from "@tauri-apps/api/core";

import { DBAccount } from "../models/db.ts"

export const fundStore = defineStore("fund", {
    state: () => {
        return {
            accounts: new Map([]) as Map<string, DBAccount[]>,
        }
    },
    actions: {
        async doQueryAccount(
            data: string | string[],
            startDate: string | undefined = undefined,
            endDate: string | undefined = undefined,
            force: boolean = false,
        ): Promise<Array<DBAccount>> {
            return new Promise((resolve, reject) => {
                if (!data) { reject("query account is required"); }

                const accounts = Array.isArray(data)? data : [data];
                const accountSet = new Set<string>(accounts);

                if (!force && !startDate && !endDate) {
                    [...this.accounts.keys()].forEach((idt) => {
                        accountSet.delete(idt);
                    })
                }

                if (accountSet.size <= 0) {
                    console.log("query account hit data cache:", data);
                    const result: Array<DBAccount> = [];

                    accounts.forEach((v) => {
                        result.push(...this.accounts.get(v)!)
                    })

                    resolve(result)
                } else {
                    console.log("query account from database:", data);

                    invoke("query_accounts", {
                        accounts: [...accountSet],
                        startDate: startDate,
                        endDate: endDate,
                    }).then((values) => {
                        const accounts = values as Array<DBAccount>

                        accounts.forEach((v) => {
                            if (!this.accounts.has(v.account_id)) {
                                this.accounts.set(v.account_id, []);
                            }

                            this.accounts.get(v.account_id)!.push(v);
                        })

                        resolve(accounts);
                    });
                }
            })
        },
        async doSinkTuAccount(
            source: string | string[],
            accounts: string[] | undefined = undefined,
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
            })
        }
    }
})