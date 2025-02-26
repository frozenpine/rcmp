<script setup lang="ts">
import {
  type DataTableColumns, type DataTableInst,
  type DataTableCreateSummary,
  NDataTable, NDropdown, NWatermark, NFlex,
} from "naive-ui";
import type {SummaryRowData} from "naive-ui/es/data-table/src/interface";
import {h, nextTick, ref, computed} from "vue";
import dayjs from "dayjs";
import {storeToRefs} from "pinia";

import {CurrencyFormatter} from "../utils/formatter.ts";
import {useMessage} from "../utils/feedback.ts";
import {DBAccount} from "../models/db.ts";
import {metaStore} from "../store/meta.ts";

interface GroupAccountTableProps {
  loading?: boolean;
  data?: DBAccount[];
  watermark?: string;
}

const {
  loading = false,
  data,
  watermark = "瑞达期货",
} = defineProps<GroupAccountTableProps>();

const meta = metaStore();
const CNY = CurrencyFormatter();
const message = useMessage();

const {firstDay, lastDay} = storeToRefs(meta);
const exportAll = ref(false);

interface RowData extends DBAccount {
  group?: DBAccount[];
}

class AccountProxy {
  private readonly _inner: DBAccount;
  readonly group: DBAccount[];

  constructor(inner: DBAccount) {
    this._inner = inner;
    this.group = [];

    for (const key in inner) {
      Object.defineProperty(this, key, {
        get() {return this._inner[key];}
      })
    }
  }

  get value(): string {
    return [this._inner.broker_id, this._inner.account_id].join(".");
  }
}

const defaultColumns: DataTableColumns<RowData> = [
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

const getRowKey = (row: any): string => {
  const data = row as RowData;
  return [data.trading_day, data.broker_id, data.account_id, data.currency_id].join(".")
}

const rowProps = (_: RowData) => {
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

const expandCol: DataTableColumns<RowData> = [
  {
    type: "expand",
    renderExpand: row => {
      return h(NDataTable, {
        columns: defaultColumns,
        rowKey: getRowKey,
        striped: true,
        data: row.group,
        virtualScroll: true,
        minRowHeight: 30,
        maxHeight: 200,
        summary: investorDurationSummary,
        summaryPlacement: "top",
        size: "small",
      });
    }
  },
]

const groupedData = computed(() => {
  if (!data || data.length < 1) return [];

  if (!exportAll.value) {
    return [...data.reduce(
        (result: Map<string, AccountProxy>, curr: DBAccount) => {
          const idt = [curr.broker_id, curr.account_id].join(".");

          let data = result.get(idt);

          if (!data) {
            data = new AccountProxy(curr);
          }
          data.group.push(curr);

          result.set(idt, data);

          return result;
        },
        new Map([]),
    ).values()];
  } else {
    return data;
  }
})

const dt = ref<DataTableInst>();
const contextMenu = ref<{x: number; y: number; show: boolean}>({x: 0, y: 0, show: false});

function handleMenuSelect(sel: string) {
  contextMenu.value.show = false;

  const now = dayjs().format("YYYYMMDDHHmmss");

  switch (sel) {
    case "all": {
      exportAll.value = true;
      nextTick().then(()=>{
        dt.value?.downloadCsv({
          fileName: `account_all_${now}.csv`,
        });
        exportAll.value = false;
      })
      break;
    }
    case "page": {
      nextTick().then(()=>{
        dt.value?.downloadCsv({
          fileName: `account_current_${now}.csv`,
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


const investorDurationSummary: DataTableCreateSummary<RowData> = (pageData): SummaryRowData[] => {
    const diffMonth = lastDay.value.diff(firstDay.value, "month") + 1;

    const monthSummary = new Array<SummaryRowData>(diffMonth);

    for (let idx=0; idx < diffMonth; idx++) {
      const month = firstDay.value.add(idx, "month").format("YYYYMM");

      const monthData = pageData.filter(
          (v) => { return v.trading_day.startsWith(month); }
      );

      console.log("month data:", month, monthData);

      monthSummary[idx] = {
        'account_id': {
          value: h(NFlex, {
            justify: "end",
            class: "summary",
          }, {
            default: ()=> `${month} 月度汇总：`,
          }),
          colSpan: 3,
        },
        'position_profit': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.position_profit,
              0,
          ))),
        },
        'close_profit': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.close_profit,
              0,
          ))),
        },
        'fee': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.fee,
              0,
          ))),
        },
        'net_profit': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.net_profit,
              0,
          ))),
        },
      }
    }

    return monthSummary;
}

const groupDurationSummary: DataTableCreateSummary<RowData> = (pageData): SummaryRowData | SummaryRowData[] => {
    const diffMonth = lastDay.value.diff(firstDay.value, "month") + 1;

    const monthSummary = new Array<SummaryRowData>(diffMonth);

    for (let idx = 0; idx < diffMonth; idx++) {
        const month = firstDay.value.add(idx, "month").format("YYYYMM");

        const monthData: DBAccount[] = pageData.reduce(
            (pre, curr) => {
              return pre.concat((curr.group || [] as DBAccount[]).filter(
                  (v) => { return v.trading_day.startsWith(month); }
              ));
            }, [] as DBAccount[]
        );

      monthSummary[idx] = {
        'account_id': {
          value: h(NFlex, {justify: "end"}, {default: ()=> `${month} 月度汇总：`}),
          colSpan: 3,
        },
        'position_profit': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.position_profit,
              0,
          ))),
        },
        'close_profit': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.close_profit,
              0,
          ))),
        },
        'fee': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.fee,
              0,
          ))),
        },
        'net_profit': {
          value: h('span', {}, CNY(monthData.reduce(
              (pre, row) => pre + row.net_profit,
              0,
          ))),
        },
      }
    }

    return monthSummary.concat([{
      'account_id': {
        value: h(NFlex, {
          justify: "end",
          class: "summary",
        }, {
          default: ()=> "当前交易日汇总："
        }),
        colSpan: 3,
      },
      'pre_balance': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.pre_balance,
            0,
        ))),
      },
      'balance': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.balance,
            0,
        ))),
      },
      'position_profit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.position_profit,
            0,
        ))),
      },
      'close_profit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.close_profit,
            0,
        ))),
      },
      'fee': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.fee,
            0,
        ))),
      },
      'net_profit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.net_profit,
            0,
        ))),
      },
    },{
      'account_id': {
        value: h(NFlex, {
          justify: "end",
          class: "summary",
        }, {
          default: ()=> "截止最后交易日汇总："
        }),
        colSpan: 3,
      },
      'pre_balance': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.pre_balance,
            0,
        ))),
      },
      'balance': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.balance,
            0,
        ))),
      },
      'position_profit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + (row.group || []).reduce(
                (pre, curr) => pre + curr.position_profit,
                0
            ),
            0,
        ))),
      },
      'close_profit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + (row.group || []).reduce(
                (pre, curr) => pre + curr.close_profit,
                0
            ),
            0,
        ))),
      },
      'fee': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + (row.group || []).reduce(
                (pre, curr) => pre + curr.fee,
                0
            ),
            0,
        ))),
      },
      'net_profit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + (row.group || []).reduce(
                (pre, curr) => pre + curr.net_profit,
                0
            ),
            0,
        ))),
      },
    }]);
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
    <n-data-table ref="dt" :columns="expandCol.concat(defaultColumns)" :data="groupedData" :loading="loading"
                  :row-key="getRowKey" :row-props="rowProps"
                  :summary="groupedData && groupedData.length > 0? groupDurationSummary : undefined"
                  striped ></n-data-table>
  </n-watermark>
  <n-dropdown placement="bottom-start" trigger="manual" :x="contextMenu.x" :y="contextMenu.y" :show="contextMenu.show"
              :on-clickoutside="() => contextMenu.show = false" @select="handleMenuSelect"
              :options="[{label: '导出当前', key: 'page'}, {label: '导出全部', key: 'all'}, ]"></n-dropdown>
</template>

<style scoped>
.summary {
  font-weight: bold;
}
</style>