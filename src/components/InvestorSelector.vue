<script setup lang="ts">
import {NTreeSelect, NSpace, NButton, NIcon, NModalProvider, NModal, NButtonGroup} from "naive-ui";
import {RefreshFilled, EditNoteFilled} from "@vicons/material";
import {computed, ref} from "vue";

import {metaStore} from "../store/meta.ts";
import GroupEditor from "../components/GroupEditor.vue"
import {useMessage} from "../utils/feedback.ts"

interface SelectProps {
  loading?: boolean;
  multiple?: boolean;
}

const {
  loading = false,
  multiple = false,
} = defineProps<SelectProps>();

const meta = metaStore();
const message = useMessage();

const selected = defineModel<string | string[] | undefined>("selected");
const showEditor = ref(false);
const investorLoading = ref(false);

function loadGroupInvestors() {
  investorLoading.value = true;
  meta.doQueryInvestors(true)
      .then((investors) => {
        message.info(`已获取全部投资者信息【${investors.length}】`)
      }).catch((err) => {
    console.error("query investors failed:", err)
    message.error("投资者查询失败", {
      closable: true,
      duration: 0,
    })
  }).finally(()=>investorLoading.value = false);
}

defineExpose({
  loadGroupInvestors,
});

export interface InvestorSelectorInst {
  loadGroupInvestors(): void;
}

const selectOptions = computed(() => {
  return meta.groupInvestors.map((g) => {
    return {
      label: g.group_name,
      key: g.group_id,
      children: g.investors!.map((v) => {
        return {
          label: `${v.investor_name} (${v.investor_id})`,
          key: v.investor_id,
        }
      }),
    }
  });
})
</script>

<template>
  <n-modal-provider>
    <n-modal v-model:show="showEditor" size="large">
      <GroupEditor />
    </n-modal>
  </n-modal-provider>
  <n-tree-select :loading="loading || investorLoading" v-model:value="selected" :options="selectOptions"
                 :multiple="multiple" check-strategy="child" placeholder="请选择投资者"
                 :override-default-node-click-behavior="({option}) => {return option.children? 'toggleExpand': 'default'}"
                 clearable filterable cascade virtual-scroll >
    <template #action>
      <n-space justify="end">
        <n-button-group size="tiny">
          <n-button @click="loadGroupInvestors" round>
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
  </n-tree-select>
</template>

<style scoped>
.group-editor {
  width: 320px;
}
</style>