<script setup lang="ts">
import {
  type DataTableInst,
  type DataTableCreateSummary, type TableColumn,
  NDataTable, NDropdown, NWatermark, NFlex,
  NFloatButton, NIcon, NCheckbox,
} from "naive-ui";
import type {SummaryRowData} from "naive-ui/es/data-table/src/interface";
import {h, nextTick, ref, computed, useModel} from "vue";
import dayjs from "dayjs";
import {storeToRefs} from "pinia";
import {TableEdit16Regular, TextColumnOne20Filled} from "@vicons/fluent";

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

const allColumns: Map<string, TableColumn<RowData>> = new Map([
  ["broker_id", {title: "经纪商代码", key: "broker_id", titleAlign: "center"}],
  ["account_id", {title: "资金账号", key: "account_id", fixed: "left", width: 100, titleAlign: "center"}],
  ["account_name", {title: "账号名称", key: "account_name", fixed: "left", width: 100, titleAlign: "center"}],
  ["trading_day", {title: "交易日", key: "trading_day", fixed: "left", width: 100, titleAlign: "center"}],
  ["frozen_balance", {
    title: "冻结权益", key: "frozen_balance", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.frozen_balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["pre_balance", {
    title: "昨权益", key: "pre_balance", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.pre_balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["balance", {
    title: "今权益", key: "balance", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.balance))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["available", {
    title: "可用", key: "available", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.available))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["deposit", {
    title: "入金", key: "deposit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.deposit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["withdraw", {
    title: "出金", key: "withdraw", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.withdraw))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["margin", {
    title: "保证金", key: "margin", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.margin))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["frozen_margin", {
    title: "冻结保证金", key: "frozen_margin", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.frozen_margin))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["position_profit", {
    title: "持仓盈亏", key: "position_profit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.position_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["close_profit", {
    title: "平仓盈亏", key: "close_profit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.close_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["fee", {
    title: "手续费", key: "fee", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.fee))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["frozen_fee", {
    title: "冻结手续费", key: "frozen_fee", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.frozen_fee))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["net_profit", {
    title: "净盈亏", key: "net_profit", titleAlign: "center", align: "right",
    render(row) {return h("label", CNY(row.net_profit))},
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }],
  ["currency_id", {title: "币种", key: "currency_id", fixed: "right", width: 60, titleAlign: "center", align: "right"}],
])

const displayedColumns = ref([
    {
      key: "broker_id",
      show: false,
    }, {
      key: "account_id",
      show: true,
    }, {
      key: "account_name",
      show: true,
    }, {
      key: "trading_day",
      show: true,
    }, {
      key: "pre_balance",
      show: true,
    }, {
      key: "deposit",
      show: true,
    }, {
      key: "withdraw",
      show: true,
    }, {
      key: "balance",
      show: true,
    }, {
      key: "frozen_balance",
      show: false,
    }, {
      key: "available",
      show: false,
    }, {
      key: "margin",
      show: false,
    }, {
      key: "frozen_margin",
      show: false,
    }, {
      key: "fee",
      show: true,
    }, {
      key: "frozen_fee",
      show: false,
    }, {
      key: "position_profit",
      show: true,
    }, {
      key: "close_profit",
      show: true,
    }, {
      key: "net_profit",
      show: true,
    }, {
      key: "currency_id",
      show: true,
    },
])

const defaultColumns = computed(() => {
  return displayedColumns.value.filter(
      (v) => v.show
  ).map((v) => {
    return allColumns.get(v.key)
  });
})

const headerColumnOptions = computed(() => {
  return displayedColumns.value.map((v) => {
    return {
      type: "render",
      render: () => h(
          NCheckbox,
          {
            checked: v.show,
            onUpdateChecked: (b) => v.show = b,
            style: {
              padding: "3px 5px",
            }
          },
          {
            default: () => allColumns.get(v.key).title
          }
      )
    }
  })
})

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

const expandCol = ref([
  {
    type: "expand",
    renderExpand: row => {
      return h(NDataTable, {
        columns: defaultColumns.value,
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
]);

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
        "deposit": {
          value: h('span', {
            style: {fontColor: "red"},
          }, CNY(monthData.reduce(
              (pre, row) => pre + row.deposit,
              0,
          ))),
        },
        "withdraw": {
          value: h('span', {
            style: {fontColor: "green"},
          }, CNY(monthData.reduce(
              (pre, row) => pre + row.withdraw,
              0,
          ))),
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
        "deposit": {
          value: h('span', {
            style: {fontColor: "red"},
          }, CNY(monthData.reduce(
              (pre, row) => pre + row.deposit,
              0,
          ))),
        },
        "withdraw": {
          value: h('span', {
            style: {fontColor: "green"},
          }, CNY(monthData.reduce(
              (pre, row) => pre + row.withdraw,
              0,
          ))),
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
      'deposit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.deposit,
            0,
        ))),
      },
      'withdraw': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + row.withdraw,
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
      'deposit': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + (row.group || []).reduce(
                (pre, curr) => pre + curr.deposit,
                0
            ),
            0,
        ))),
      },
      'withdraw': {
        value: h('span', {class: "summary",}, CNY(pageData.reduce(
            (pre, row) => pre + (row.group || []).reduce(
                (pre, curr) => pre + curr.withdraw,
                0
            ),
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
    <n-float-button shape="circle" :style="{zIndex: 999}" :left="15" :top="335" menu-trigger="hover">
      <n-icon><TableEdit16Regular/></n-icon>
      <template #menu>
        <n-dropdown trigger="click" :options="headerColumnOptions">
          <n-float-button shape="square">
            <n-icon><TextColumnOne20Filled/></n-icon>
          </n-float-button>
        </n-dropdown>
      </template>
    </n-float-button>
    <n-data-table ref="dt" :columns="expandCol.concat(defaultColumns)" :data="groupedData" :loading="loading"
                  :row-key="getRowKey" :row-props="rowProps"
                  :summary="groupedData && groupedData.length > 0? groupDurationSummary : undefined"
                  striped >
    </n-data-table>
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