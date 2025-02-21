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
            accountID: string, {
                startDate,
                endDate,
                force = false,
            }: {
                startDate?: string
                endDate?: string
                force?: boolean
            } = {},
        ): Promise<Array<DBAccount>> {
            return new Promise((resolve, reject) => {
                if (!accountID) { reject("query account is required"); }

                if (!force && !startDate && !endDate && this.accounts.has(accountID)) {
                    console.log("query account hit data cache:", accountID);

                    resolve(this.accounts.get(accountID)!)
                } else {
                    console.log("query account from database:", accountID);

                    invoke("query_accounts", {
                        accounts: [accountID],
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
            })
        }
    }
})