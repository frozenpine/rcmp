<script setup lang="ts">
import {computed, ref, h, defineComponent} from "vue";
import {NTransfer, NCard, NSpace, NButton, NSelect, NInput} from "naive-ui";
import type {TransferOption, TransferRenderTargetLabel } from "naive-ui"

import {metaStore} from "../store/meta.ts"
import {DBInvestor} from "../models/db.ts";

class InvestorProxy implements TransferOption {
  private _inner: DBInvestor
  investor_name?: string
  investor_desc?: string

  constructor(inner: DBInvestor) {
    this._inner = inner;
  }

  get hasName(): boolean {
    return this._inner.investor_name != "" && this._inner.investor_name != undefined;
  }

  get investor_id(): string {
    return this._inner.investor_id;
  }

  get label(): string {
    return `${
      this._inner.investor_name? this._inner.investor_name : (
          this.investor_name? this.investor_name + '*' : "未命名"
      )
    }(${this._inner.investor_id})`
  }

  get value(): string {
    return this._inner.investor_id;
  }
}

const meta = metaStore();
const selectedGroup = ref<string | number | undefined>(undefined);
const selectedInvestors = ref<string[] | undefined>(undefined);

const groupName = computed(()=>{
  if (!selectedGroup.value) {
    if (selectedInvestors.value && selectedInvestors.value!.length > 0) {
      selectedInvestors.value!.length = 0;
    }
    return "请选择投资者组";
  }

  if (typeof selectedGroup.value === "string") return selectedGroup.value;

  const group = meta.getGroup(selectedGroup.value);

  selectedInvestors.value = group?.investors!.map((v) => {
    return v.investor_id;
  });

  return group?.group_name;
})

const groupOptions = computed(() => {
  return meta.groupInvestors.filter(
      g => g.group_id > 0
  ).map((g) => {
    return {
      label: g.group_name,
      value: g.group_id,
    }
  });
})

const transferOptions = computed(() => {
  return meta.allInvestors.map(v => new InvestorProxy(v));
})

const targetLabelRender: TransferRenderTargetLabel = function({option}) {
  const v = (option as any) as InvestorProxy;

  if (v.hasName) {
    return h(
        "span",
        v.label
    )
  } else {
    return h(
        NSpace,
        {},
        {
          default: ()=>[
            h(NInput, {
              placeholder: "请输入名称",
              size: 'tiny',
              style: {
                maxWidth: "110px"
              },
              onChange: (name) => v.investor_name = name,
            }),
            h("span", v.investor_id)
          ],
        },
    )
  }
}

function investorsCommit() {
  if (!selectedGroup.value) {return;}

  selectedInvestors.value!.forEach((v) => {
    const find = transferOptions.value.filter(g => g.investor_id === v)[0];

    console.log(v, find);
  })
}
</script>

<template>
  <n-card title="投资者组编辑">
    <template #header-extra>
        <n-select v-model:value="selectedGroup" :options="groupOptions"
                  tag filterable clearable></n-select>
    </template>
    <n-transfer v-model:value="selectedInvestors" :options="transferOptions"
                source-title="投资者账号" :target-title="groupName"
                :render-target-label="targetLabelRender"
                :disabled="!selectedGroup"
                @update:value="console.log(selectedInvestors)"
                source-filterable target-filterable virtual-scroll>
    </n-transfer>
    <template #action>
      <n-space justify="end">
        <n-button @click="investorsCommit">确定</n-button>
      </n-space>
    </template>
  </n-card>
</template>

<style scoped>
.n-card {
  min-width: 320px;
  max-width: 600px;
  width: 80%;
}
</style>