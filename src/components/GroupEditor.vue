<script setup lang="ts">
import {computed, ref} from "vue";
import {NTransfer, NCard, NSelect, NTag, NIcon} from "naive-ui";
import {ContactCardGroup48Filled} from "@vicons/fluent";

import {metaStore} from "../store/meta.ts"

const meta = metaStore();
const selectedGroup = ref<number | string | undefined>(undefined);
const selectedInvestors = ref<string[] | undefined>(undefined);

const groupName = computed(()=>{
  if (!selectedGroup.value) return "请选择投资者组";

  if (typeof selectedGroup.value === "string") return selectedGroup.value;

  const group = meta.getGroup(selectedGroup.value);

  selectedInvestors.value = group?.investors.map((v) => {
    return v.investor_id;
  });

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
      <n-tag :bordered="false" size="large">
        {{groupName}}
        <template #icon>
          <n-icon><ContactCardGroup48Filled/></n-icon>
        </template>
      </n-tag>
    </template>
    <template #header-extra>
        <n-select v-model:value="selectedGroup" :options="groupOptions"
                  :on-create="console.log"
                  tag filterable clearable></n-select>
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