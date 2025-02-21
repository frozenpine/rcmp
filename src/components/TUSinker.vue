<script setup lang="ts">
import {DatabaseImport, Folder} from "@vicons/tabler";
import {NButton, NButtonGroup, NIcon, NSpin} from "naive-ui";
import {FileCsv} from "@vicons/fa";
import {ref} from "vue";
import {open} from "@tauri-apps/plugin-dialog";
import {useMessage} from "../utils/feedback.ts";
import {fundStore} from "../store/fund.ts";

const fund = fundStore();
const message = useMessage();

const parsing = ref(false);

async function sink_account(dir: boolean = false) {
  const source = dir? await open({
    title: "文件夹导入",
    multiple: false,
    directory: true,
  }) : await open({
    title: "文件导入",
    multiple: true,
    directory: false,
    filters: [{name: "查询资金", extensions: ["csv"]}],
  });

  if (!source) return;

  parsing.value = true;
  fund.doSinkTuAccount(source)
      .then(count => {
        console.log("all account data sunk finished", source, count);
        message.success(`已导入【${count}】条资金记录`);
      })
      .catch(console.error)
      .finally(() => {parsing.value = false;});
}
</script>

<template>
  <n-spin size="small" :show="parsing">
    <n-icon style="margin-right: 5px" size="15"><DatabaseImport/></n-icon>
    <n-button-group size="tiny" :disabled="parsing">
      <n-button @click="()=> sink_account(true)" ghost round >
        <template #icon>
          <n-icon><Folder/></n-icon>
        </template>
      </n-button>
      <n-button @click="()=> sink_account(false)" ghost round >
        <template #icon>
          <n-icon><FileCsv/></n-icon>
        </template>
      </n-button>
    </n-button-group>
  </n-spin>
</template>

<style scoped>

</style>