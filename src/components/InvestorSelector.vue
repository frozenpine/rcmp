<script setup lang="ts">
import {
  type TreeSelectOption,
  NTreeSelect, NFlex, NButton, NIcon,
  NModalProvider, NModal, NButtonGroup,
} from "naive-ui";
import {RefreshFilled, EditNoteFilled} from "@vicons/material";
import {computed, ref, h} from "vue";
import dayjs from "dayjs"

import {metaStore} from "../store/meta.ts";
import GroupEditor from "../components/GroupEditor.vue"
import {useNotification} from "../utils/feedback.ts"

interface SelectProps {
  loading?: boolean;
  multiple?: boolean;
}

const {
  loading = false,
  multiple = false,
} = defineProps<SelectProps>();

const meta = metaStore();
const notification = useNotification();

const selected = defineModel<string | undefined>("selected");

const showEditor = ref(false);
const investorLoading = ref(false);

function loadGroupInvestors(force: boolean=false) {
  investorLoading.value = true;

  meta.doQueryInvestors({force: force})
      .then((investors) => {
        const group_investors = meta.groupInvestors;
        notification.info({
          title: "投资者组查询完成",
          description: `投资者账号总计: ${investors.length}`,
          content: () => h(
              NFlex, {vertical: true},
              {
                default: () => group_investors.map(
                    (g) => h("span", `投资者组[${g.group_name}]账号合计: ${g.investors?.length}`)
                )
              },
          ),
          meta: dayjs().format("YYYY-MM-DD HH:mm:ss"),
          duration: 5000,
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

const selectOptions = computed((): TreeSelectOption[] => {
  return meta.groupInvestors.map((g) => {
    return {
      label: g.group_name,
      key: g.group_name,
      children: g.investors?.map((v) => {
        return {
          label: `${v.investor_name} (${v.investor_id})`,
          key: `${g.group_name}.${v.broker_id}.${v.investor_id}`,
        }
      }),
    }
  });
})
</script>

<template>
  <n-modal-provider>
    <n-modal v-model:show="showEditor" :mask-closable="false" size="large">
      <GroupEditor :selected="selected?.split('.')[0]" @close="showEditor = false" />
    </n-modal>
  </n-modal-provider>
  <n-tree-select :loading="loading || investorLoading" v-model:value="selected" :options="selectOptions"
                 :multiple="multiple" check-strategy="child" placeholder="请选择投资者"
                 :override-default-node-click-behavior="({option}) => {return option.children? 'toggleExpand': 'default'}"
                 clearable filterable cascade virtual-scroll >
    <template #action>
      <n-flex justify="end">
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
      </n-flex>
    </template>
  </n-tree-select>
</template>

<style scoped>
</style>