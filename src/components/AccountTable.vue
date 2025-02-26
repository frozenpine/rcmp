<script setup lang="ts">
import {
  type DataTableColumns, type DataTableInst,
  NDataTable, NDropdown, NWatermark,
} from "naive-ui";
import {computed, h, nextTick, reactive, ref} from "vue";
import dayjs from "dayjs";

import {DBAccount} from "../models/db.ts";
import {CurrencyFormatter} from "../utils/formatter.ts";
import {useMessage} from "../utils/feedback.ts";

interface AccountTableProps {
  loading?: boolean;
  data?: DBAccount[];
  pageSizes?: number[];
  watermark?: string;
}

const {
  loading = false,
  data,
  pageSizes = [5, 10, 15, 50],
  watermark = "瑞达期货",
} = defineProps<AccountTableProps>();

const CNY = CurrencyFormatter();
const message = useMessage();

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

const calcPageSizes = computed(()=>{
  if (!data || data.length < 1) {
    return pageSizes;
  }

  for (let idx = 0; idx < pageSizes.length; idx++) {
    if (pageSizes[idx] > data.length) {
      if (idx > 0) {
        return pageSizes.slice(0, idx).concat([data.length]);
      } else {
        return [data.length];
      }
    }
  }

  return pageSizes.concat([data.length]);
})

const pagination = reactive({
  page: 1,
  pageSize: calcPageSizes.value[0] || 5,
  showSizePicker: true,
  pageSizes: calcPageSizes,
  onChange: (page: number) => {pagination.page = page},
  onUpdatePageSize: (pageSize: number) => {
    pagination.pageSize = pageSize;
    pagination.page = 1;
  }
});
const dt = ref<DataTableInst>();
const contextMenu = ref<{x: number; y: number; show: boolean}>({x: 0, y: 0, show: false});

function handleMenuSelect(sel: string) {
  contextMenu.value.show = false;

  const now = dayjs().format("YYYYMMDDHHmmss");

  switch (sel) {
    case "all": {
      const {page, pageSize} = pagination;
      pagination.pageSize = pagination.pageSizes[pagination.pageSizes.length - 1];
      pagination.page = 1;

      nextTick().then(()=>{
        dt.value?.downloadCsv({
          fileName: `account_all_${now}.csv`,
        });

        pagination.pageSize = pageSize;
        pagination.page = page;
      })
      break;
    }
    case "page": {
      dt.value?.downloadCsv({
        fileName: `account_partial_${now}.csv`,
        keepOriginalData: false,
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

const getRowKey = (row: any): string => {
  const data = row as DBAccount;
  return [data.trading_day, data.broker_id, data.account_id, data.currency_id].join(".")
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
    <n-data-table ref="dt" :columns="defaultColumns" :data="data" :loading="loading"
                  :row-key="getRowKey" :pagination="data && data.length > 0? pagination : false" :row-props="rowProps"
                  striped ></n-data-table>
  </n-watermark>
  <n-dropdown placement="bottom-start" trigger="manual" :x="contextMenu.x" :y="contextMenu.y" :show="contextMenu.show"
              :on-clickoutside="() => contextMenu.show = false" @select="handleMenuSelect"
              :options="[{label: '导出全部', key: 'all'}, {label: '导出当前', key: 'page'}, ]"></n-dropdown>
</template>

<style scoped>

</style>