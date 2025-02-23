<script setup lang="ts">
import {computed, ref} from "vue";
import {NTransfer, NCard, NSelect} from "naive-ui";

import {metaStore} from "../store/meta.ts"

const meta = metaStore();
const selectedGroup = ref<number | string | undefined>(undefined);
const selectedInvestors = ref<string[] | undefined>(undefined);

const groupName = computed(()=>{
  if (!selectedGroup.value) return "请选择投资者组";

  if (typeof selectedGroup.value === "string") return selectedGroup.value;

  const group = meta.getGroup(selectedGroup.value);

  selectedInvestors.value = group?.investors;

  return group?.group_name;
})

const groupOptions = computed(() => {
  return meta.groupInvestors.filter(
      g => g.group_id > 0
  ).map(g => {
    return {
      label: g.group_name,
      value: g.group_id,
    };
  });
})

const transferOptions = computed(() => {
  return meta.allInvestors.map((v) => {
    return {
      label: `${v.investor_name}(${v.investor_id})`,
      value: v.investor_id,
    };
  });
})
</script>

<template>
  <n-card>
    <template #header>
      {{groupName}}
    </template>
    <template #header-extra>
<!--      <n-space>-->
        <n-select v-model:value="selectedGroup" :options="groupOptions"
                  :on-create="console.log"
                  tag filterable clearable></n-select>
<!--        <n-popover trigger="click" placement="bottom-end">-->
<!--          <template #trigger>-->
<!--            <n-icon size="30"><ContactCardGroup28Filled/></n-icon>-->
<!--          </template>-->
<!--          <n-input size="small" placeholder="请输入组名"></n-input>-->
<!--          <template #footer>-->
<!--            <n-button size="tiny">确定</n-button>-->
<!--          </template>-->
<!--        </n-popover>-->
<!--      </n-space>-->
    </template>
    <n-transfer v-model:value="selectedInvestors" :options="transferOptions"
                source-title="投资者账号" :target-title="groupName"
                :disabled="!selectedGroup"
                @update:value="console.log(selectedInvestors)"
                source-filterable target-filterable virtual-scroll>
    </n-transfer>
  </n-card>
</template>

<style scoped>
.n-card {
  min-width: 320px;
  max-width: 600px;
  width: 80%;
}
</style>