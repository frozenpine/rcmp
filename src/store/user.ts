import {defineStore, Store} from 'pinia';

export type UserStore = Store<"user", {accountHeaders: string[]}>;

let store: UserStore | undefined = undefined;

const storeDefine = defineStore("user", {
    tauri: {
        saveOnChange: true,
        saveOnExit: true,
        syncStrategy: 'debounce',
        syncInterval: 1000,
    },
    state: () => {
        return {
            accountHeaders: [] as Array<string>,
        }
    }
});

export const userStore = async () => {
    if (store === undefined) {
        store = storeDefine();

        await store!.$tauri.start()
            .then(() => {
                console.log("rust pinia started");
            })
            .catch((e) => {
                console.log("rust pinia start failed:", e);
            });
    }

    return store!;
}