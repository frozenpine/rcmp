<script setup lang="ts">
import {NButton, NButtonGroup, NIcon, NModal, NModalProvider, NSelect, NSpace} from "naive-ui";
import {computed, h, ref} from "vue";

import {metaStore} from "../store/meta.ts"
import dayjs from "dayjs";
import {useNotification} from "../utils/feedback.ts";
import GroupEditor from "./GroupEditor.vue";
import {EditNoteFilled, RefreshFilled} from "@vicons/material";

const meta = metaStore();
const notification = useNotification();

interface GroupSelectorProps {
  loading?: boolean;
  multiple?: boolean;
}

const {
  loading = false,
  multiple = false
} = defineProps<GroupSelectorProps>();

const selected = defineModel<string | undefined>("selected");
const investorLoading = ref(false);
const showEditor = ref(false);

const groupOptions = computed(() => {
  return meta.groupInvestors.filter(
      g => g.group_name != "未分组"
  ).map((g) => {
    return {
      label: g.group_name,
      value: g.group_name,
    }
  });
})

function loadGroupInvestors(force: boolean=false) {
  investorLoading.value = true;
  meta.doQueryInvestors({force: force})
      .then((investors) => {
        const group_investors = meta.groupInvestors;
        notification.info({
          title: "投资者组查询完成",
          description: `投资者账号总计: ${investors.length}`,
          content: () => h(
              NSpace, {vertical: true},
              {
                default: () => group_investors.map(
                    (g) => h("span", `投资者组[${g.group_name}]账号合计: ${g.investors?.length}`)
                )
              },
          ),
          meta: dayjs().format("YYYY-MM-DD HH:mm:ss"),
          duration: 3000,
        })
      }).catch((err) => {
    console.error("query investors failed:", err);
    notification.error({
      title: "投资者组查询错误",
      content: err.message,
      closable: false,
      meta: dayjs().format("YYYY-MM-DD HH:mm:ss"),
    })
  }).finally(()=>investorLoading.value = false);
}

defineExpose({
  loadGroupInvestors,
});
</script>

<template>
  <n-modal-provider>
    <n-modal v-model:show="showEditor" :mask-closable="false" size="large">
      <GroupEditor :selected="selected" @close="showEditor = false" />
    </n-modal>
  </n-modal-provider>
  <n-select :loading="loading || investorLoading" :multiple="multiple"
            v-model:value="selected" :options="groupOptions"
            size="small" tag filterable clearable>
    <template #action>
      <n-space justify="end">
        <n-button-group size="tiny">
          <n-button @click="loadGroupInvestors(true)" round>
            <template #icon><RefreshFilled/></template>
            刷新
          </n-button>
          <n-button @click="showEditor = true" round>
            <template #icon>
              <n-icon><EditNoteFilled/></n-icon>
            </template>
            编辑
          </n-button>
        </n-button-group>
      </n-space>
    </template>
  </n-select>
</template>

<style scoped>

</style>