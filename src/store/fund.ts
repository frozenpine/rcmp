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
            accountID: string,
            startDate: string | undefined = undefined,
            endDate: string | undefined = undefined,
        ): Promise<Array<DBAccount>> {
            return new Promise((resolve, reject) => {
                if (!accountID) { reject("accountID is required"); }

                invoke("query_accounts", {
                    accounts: [accountID],
                    startDate: startDate,
                    endDate: endDate,
                }).then((values) => {
                    resolve(values as Array<DBAccount>);
                });
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