<script setup lang="ts">
import {NTreeSelect} from "naive-ui";
import {computed} from "vue";
import {metaStore} from "../store/meta.ts";

interface SelectProps {
  loading?: boolean;
  multiple?: boolean;
}

const {
  loading = false,
  multiple = false,
} = defineProps<SelectProps>();

const meta = metaStore();

const selected = defineModel("selected");

const selectOptions = computed(() => {
  const groupInvestors = meta.group_investors;

  return groupInvestors.map((g) => {
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
  <n-tree-select :loading="loading" v-model:value="selected" :options="selectOptions"
                 :multiple="multiple" check-strategy="child" placeholder="请选择投资者"
                 clearable filterable cascade virtual-scroll ></n-tree-select>
</template>

<style scoped>

</style>