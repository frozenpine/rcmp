<script setup lang="ts">
import {type DataTableColumns, type DataTableInst, NDataTable, NDropdown, NWatermark} from "naive-ui";
import {h, nextTick, ref, computed} from "vue";
import dayjs from "dayjs";

import {CurrencyFormatter} from "../utils/formatter.ts";
import {useMessage} from "../utils/feedback.ts";
import {DBAccount} from "../models/db.ts";
import {fundStore} from "../store/fund.ts";
import {metaStore} from "../store/meta.ts";
import {storeToRefs} from "pinia";

interface GroupAccountTableProps {
  group_name?: string;
  loading?: boolean;
  latest?: boolean;
  data?: DBAccount[];
  watermark?: string;
}

const {
  group_name,
  loading = false,
  latest = false,
  data,
  watermark = "瑞达期货",
} = defineProps<GroupAccountTableProps>();

const fund = fundStore();
const meta = metaStore();
const CNY = CurrencyFormatter();
const message = useMessage();

const {lastDate} = storeToRefs(fund);

const defaultColumns: DataTableColumns<DBAccount> = [
  {title: "资金账号", key: "account_id", fixed: "left", width: 100, titleAlign: "center"},
  {title: "账号名称", key: "account_name", fixed: "left", width: 100, titleAlign: "center"},
  {title: "交易日", key: "trading_day", fixed: "left", width: 100, titleAlign: "center"},
  {
    title: "昨权益", key: "pre_balance", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.pre_balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "今权益", key: "balance", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "持仓盈亏", key: "position_profit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.position_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "平仓盈亏", key: "close_profit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.close_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "手续费", key: "fee", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.fee))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {
    title: "净盈亏", key: "net_profit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.net_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  },
  {title: "币种", key: "currency_id", fixed: "right", width: 60, titleAlign: "center", align: "right"},
]

class AccountProxy {
  private readonly _inner: DBAccount

  constructor(inner: DBAccount) {
    this._inner = inner;

    for (const key in inner) {
      Object.assign(this, {[key]: this._inner[key]});
    }
  }

  get group_name(): string {
    return group_name;
  }
}

const groupedData = computed(() => {
  if (!data || data.length < 1) return [];

  return data.filter((v) => {
    const investor = meta.getInvestor(v.account_id, v.broker_id);

    if (!investor) return false;

    const groups = new Set(investor!.groups?.map(v => v.group_name));

    if (groups.size === 0 || !groups.has(group_name)) return false;

    return latest ? v.trading_day === lastDate.value.format("YYYYMMDD") : true
  }).map(v => new AccountProxy(v));
})

const dt = ref<DataTableInst>();
const contextMenu = ref<{x: number; y: number; show: boolean}>({x: 0, y: 0, show: false});

const getRowKey = (row: any): string => {
  const data = row as DBAccount;
  return [data.trading_day, data.broker_id, data.account_id, data.currency_id].join(".")
}

function handleMenuSelect(sel: string) {
  contextMenu.value.show = false;

  const now = dayjs().format("YYYYMMDDHHmmss");

  switch (sel) {
    case "all": {
      nextTick().then(()=>{
        dt.value?.downloadCsv({
          fileName: `account_all_${now}.csv`,
        });
      })
      break;
    }
    default: {
      console.error("unsupported menu item:", sel);
      message.error(`尚未支持【${sel}】该菜单选项`);
      break;
    }
  }
}

const rowProps = (_: DBAccount) => {
  return {
    onContextmenu: (e: MouseEvent) => {
      e.preventDefault()
      contextMenu.value.show = false;
      nextTick().then(() => {
        contextMenu.value.show = true;
        contextMenu.value.x = e.clientX;
        contextMenu.value.y = e.clientY;
      })
    }
  }
}

</script>

<template>
  <n-watermark :content="watermark"
               :font-size="16"
               :line-height="16"
               :width="192"
               :height="128"
               :x-offset="12"
               :y-offset="28"
               :rotate="-15"
               cross selectable>
    <n-data-table ref="dt" :columns="defaultColumns" :data="groupedData" :loading="loading"
                  :row-key="getRowKey" :row-props="rowProps"
                  striped ></n-data-table>
  </n-watermark>
  <n-dropdown placement="bottom-start" trigger="manual" :x="contextMenu.x" :y="contextMenu.y" :show="contextMenu.show"
              :on-clickoutside="() => contextMenu.show = false" @select="handleMenuSelect"
              :options="[{label: '导出全部', key: 'all'}]"></n-dropdown>
</template>

<style scoped>

</style>