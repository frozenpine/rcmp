<script setup lang="ts">
import { ref } from "vue";
import { invoke } from "@tauri-apps/api/core";
import { open } from '@tauri-apps/plugin-dialog';
import {
  NSpace, NSpin, NInput, NButton,
} from "naive-ui";

const account_id = ref("");
const loading = ref(false);

async function sink_account() {
  await open({multiple: false, directory: true})
      .then(async (dir) => {
        if (!dir) return;

        loading.value = true;
        await invoke("sink_tu_account", {baseDir: dir, accounts: []})
            .then(() => {
              console.log("all account data sunk finished", dir)
            })
            .catch(console.error)
            .finally(()=>loading.value = false);
      })
      .catch(console.error);
}

async function query_account() {
  if (!account_id.value) return;

  console.log("querying account data:", account_id.value);

  await invoke("query_accounts", {accounts: [account_id.value], startDate: null, endDate: null})
      .then(console.log)
      .catch(console.error);
}
</script>

<template>
  <main class="container">
    <h1>Welcome to RCMP</h1>

    <n-space align="center" justify="center">
      <n-input type="text" v-model:value="account_id" placeholder="请输入资金账号" clearable />
      <n-button @click="query_account" :disabled="!account_id" type="info" >查询</n-button>
      <n-spin :show="loading"><n-button @click="sink_account" type="primary">导入</n-button></n-spin>
    </n-space>
  </main>
</template>

<style scoped>
</style>
<style>
:root {
  font-family: Inter, Avenir, Helvetica, Arial, sans-serif;
  font-size: 16px;
  line-height: 24px;
  font-weight: 400;

  color: #0f0f0f;
  background-color: #f6f6f6;

  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  -webkit-text-size-adjust: 100%;
}

.container {
  margin: 0;
  padding-top: 10vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
}

h1 {
  text-align: center;
}

@media (prefers-color-scheme: dark) {
  :root {
    color: #f6f6f6;
    background-color: #2f2f2f;
  }

  a:hover {
    color: #24c8db;
  }
}

</style>