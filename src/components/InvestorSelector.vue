<script setup lang="ts">
import {NTreeSelect, NSpace, NButton, NIcon, NModalProvider, NModal} from "naive-ui";
import {Edit24Filled} from "@vicons/fluent"
import {computed, ref} from "vue";

import {metaStore} from "../store/meta.ts";
import GroupEditor from "../components/GroupEditor.vue"

interface SelectProps {
  loading?: boolean;
  multiple?: boolean;
}

const {
  loading = false,
  multiple = false,
} = defineProps<SelectProps>();

const meta = metaStore();

const selected = defineModel<string | string[] | undefined>("selected");
const showEditor = ref(false);

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
  <n-tree-select :loading="loading" v-model:value="selected" :options="selectOptions"
                 :multiple="multiple" check-strategy="child" placeholder="请选择投资者"
                 :override-default-node-click-behavior="({option}) => {return option.children? 'toggleExpand': 'default'}"
                 clearable filterable cascade virtual-scroll >
    <template #action>
      <n-space justify="end">
        <n-button size="tiny" @click="showEditor = true">
          <template #icon>
            <n-icon><Edit24Filled/></n-icon>
          </template>
          编辑分组
        </n-button>
      </n-space>
    </template>
  </n-tree-select>
</template>

<style scoped>
.group-editor {
  width: 320px;
}
</style>