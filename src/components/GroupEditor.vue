<script setup lang="ts">
import {computed, ref, /*h,*/ nextTick} from "vue";
import {NTransfer, NCard, NSpace, NButton/*, NInput*/} from "naive-ui";
import type {TransferOption/*, TransferRenderTargetLabel*/ } from "naive-ui"

import {metaStore} from "../store/meta.ts"
import {DBGroup, DBInvestor} from "../models/db.ts";
import {useMessage} from "../utils/feedback.ts";
import GroupSelector from "../components/GroupSelector.vue";

const {
  selected
} = defineProps<{selected?: string}>()

class InvestorProxy implements TransferOption {
  private _inner: DBInvestor
  investor_name?: string
  investor_desc?: string
  created_at?: Date

  constructor(inner: DBInvestor) {
    this._inner = inner;

    for (const key in inner) {
      Object.defineProperty(this, key, {
        get() {return this._inner[key];}
      })
    }
  }

  get label(): string {
    return `${
      this._inner.investor_name? this._inner.investor_name : (
          this.investor_name? this.investor_name + '*' : "未命名"
      )
    } (${this._inner.investor_id})`
  }

  get value(): string {
    return this._inner.investor_id;
  }
}

const meta = metaStore();
const message = useMessage();
const selectedGroup = ref<string | undefined>(selected);
const selectedInvestors = ref<string[] | undefined>(undefined);
const updating = ref(false);

const emit = defineEmits(["close"]);

const groupName = computed(()=>{
  if (!selectedGroup.value) {
    if (selectedInvestors.value && selectedInvestors.value!.length > 0) {
      selectedInvestors.value!.length = 0;
    }
    return "请选择投资者组";
  }

  const group = meta.getGroup(selectedGroup.value);

  selectedInvestors.value = group?.investors!.map((v) => {
    return v.investor_id;
  }) || [];

  return group?.group_name;
})

const transferOptions = computed(() => {
  return meta.allInvestors.map(v => new InvestorProxy(v));
})

function investorsCommit() {
  if (!selectedGroup.value) {return;}

  updating.value = true;
  meta.doModifyGroup(
      selectedGroup.value,
      {
        investors: selectedInvestors.value?.map(
            (v) => meta.getInvestor(v)
        ).filter(
            v => !!v
        )
      }
  ).then((group) => {
    console.log("group updated:", group);
    message.info(`投资者组[${group.group_name}]已更新`);
    nextTick(()=>{emit('close')});
  }).catch((err) => {
    console.error("investor group update failed:", err);
    message.error(`投资者组[${selectedGroup.value}]更新失败`);
  }).finally(() => {updating.value = false;});
}
</script>

<template>
  <n-card title="投资者组编辑" closable @close="emit('close')">
    <template #header-extra>
        <GroupSelector v-model:selected="selectedGroup"/>
    </template>
    <n-transfer v-model:value="selectedInvestors" :options="transferOptions"
                source-title="投资者账号" :target-title="groupName"
                :disabled="!selectedGroup"
                source-filterable target-filterable virtual-scroll>
    </n-transfer>
    <template #action>
      <n-space justify="end">
        <n-button @click="investorsCommit" :loading="updating">确定</n-button>
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