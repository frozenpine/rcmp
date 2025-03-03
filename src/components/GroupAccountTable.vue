<script setup lang="ts">
import {
  type DataTableInst, type DataTableColumns, type DataTableCreateSummary,
  type DropdownOption, type DropdownGroupOption,
  NDataTable, NDropdown, NWatermark, NFlex, NSwitch,
  NButton, NIcon, NCheckbox, NButtonGroup, NEllipsis,
} from "naive-ui";
import type { SummaryRowData, TableColumn } from "naive-ui/es/data-table/src/interface";
import { h, nextTick, ref, computed } from "vue";
import dayjs from "dayjs";
import { TextColumnOne20Filled, CaretUp16Filled, CaretDown16Filled } from "@vicons/fluent";

import { CurrencyFormatter } from "../utils/formatter.ts";
import { useMessage, useNotification } from "../utils/feedback.ts";
import { DBAccount } from "../models/db.ts";
import { metaStore } from "../store/meta.ts";

interface GroupAccountTableProps {
  loading?: boolean;
  data?: DBAccount[];
  watermark?: string;
  maxHeight?: number
}

const {
  loading = false,
  data,
  watermark = "瑞达期货",
  maxHeight = 500,
} = defineProps<GroupAccountTableProps>();

interface Formatter {
  [index: string]: (value: number) => string;
}

const CurrencyFmt: Formatter = {
  CNY: CurrencyFormatter(),
  USD: CurrencyFormatter('$'),
}

const meta = metaStore();
const message = useMessage();
const notification = useNotification();

const exportAll = ref(false);
const showWaterMark = ref(false);

interface RowData extends DBAccount {
  group: RowData[];
  identity: string;
  rowKey: string;
}

function defineAccount(acct: RowData) {
  const group: RowData[] = [];

  return new Proxy(acct, {
    get: (target, propKey) => {
      switch (propKey) {
        case "identity":
          return [target.broker_id, target.account_id].join(".")
        case "rowKey":
          return [target.broker_id, target.account_id, target.currency_id].join(".")
        case "group":
          return group;
        default:
          return (target as any)[propKey]
      }
    }
  })
}

interface ColumnDisplayDefine {
  [index: string | symbol]: any;
  show?: boolean,
  sortable: boolean,
}

function defineColumn(col: ColumnDisplayDefine & TableColumn<RowData>) {
  return new Proxy(col, {
    get: (target, propKey) => {
      switch (propKey) {
        case "checkUp": {
          return (idx: number) => idx === 0 || !target.sortable || !dataColumns.value[idx - 1].sortable
        }
        case "checkDown": {
          return (idx: number) => idx === dataColumns.value.length - 1 || !target.sortable || !dataColumns.value[idx + 1].sortable
        }
        case "sortUp": {
          return (idx: number) => {
            if (idx === 0) return;

            const curr = dataColumns.value[idx];
            const pre = dataColumns.value[idx - 1];

            if (pre && !pre.sortable) return;

            const pre_chain = dataColumns.value.slice(0, idx - 1);
            const next_chain = dataColumns.value.slice(idx + 1);

            dataColumns.value = pre_chain.concat([curr, pre].concat(next_chain));
          }
        }
        case "sortDown": {
          return (idx: number) => {
            if (idx === dataColumns.value.length - 1) return;

            const curr = dataColumns.value[idx];
            const next = dataColumns.value[idx + 1];

            if (next && !next.sortable) return;

            const pre_chain = dataColumns.value.slice(0, idx);
            const next_chain = dataColumns.value.slice(idx + 2)

            dataColumns.value = pre_chain.concat([next, curr].concat(next_chain));
          }
        }
        default: {
          return target[propKey];
        }
      }
    }
  })
}

const dataColumns = ref([
  defineColumn({
    title: "经纪商",
    key: "broker_id",
    titleAlign: "center",
    show: false,
    sortable: false,
  }),
  defineColumn({
    title: "资金账号",
    key: "account_id",
    fixed: "left",
    sortable: false,
    width: 100,
    titleAlign: "center"
  }),
  defineColumn({
    title: "账号名称",
    key: "account_name",
    fixed: "left",
    sortable: false,
    width: 100,
    titleAlign: "center",
  }),
  defineColumn({
    title: "交易日",
    key: "trading_day",
    fixed: "left",
    sortable: false,
    width: 100,
    titleAlign: "center",
  }),
  defineColumn({
    title: "昨权益",
    key: "pre_balance",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.pre_balance))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "入金",
    key: "deposit",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.deposit))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "出金",
    key: "withdraw",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.withdraw))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "今权益",
    key: "balance",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.balance))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "冻结权益",
    key: "frozen_balance",
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.frozen_balance))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "可用",
    key: "available",
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.available))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "保证金",
    key: "margin",
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.margin))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "冻结保证金",
    key: "frozen_margin",
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.frozen_margin))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "持仓盈亏",
    key: "position_profit",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.position_profit))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "平仓盈亏",
    key: "close_profit",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.close_profit))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "手续费",
    key: "fee",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.fee))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "冻结手续费",
    key: "frozen_fee",
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.frozen_fee))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "净盈亏",
    key: "net_profit",
    show: true,
    sortable: true,
    titleAlign: "center",
    align: "right",
    render(row) {
      return h("label", CurrencyFmt[row.currency_id](row.net_profit))
    },
    ellipsis: {
      tooltip: true
    },
    resizable: true,
  }),
  defineColumn({
    title: "币种",
    key: "currency_id",
    fixed: "right",
    sortable: false,
    width: 60,
    titleAlign: "center",
    align: "right",
  }),
])

const displayedColumns = computed((): DataTableColumns<RowData> => {
  return dataColumns.value.filter(
    (v) => v.fixed || v.show
  ) as unknown as DataTableColumns<RowData>;
})

type HeaderColumnOption = DropdownOption | DropdownGroupOption;

const headerColumnOptions = computed((): HeaderColumnOption[] => {
  const header: HeaderColumnOption[] = [
    {
      key: 'header',
      type: 'render',
      render: () => h(
        NFlex,
        {
          justify: "end",
          style: { margin: "5px 15px" },
        },
        {
          default: () => [
            h(NSwitch, {
              value: showWaterMark.value,
              onUpdateValue: (v) => showWaterMark.value = v,
            }, {
              checked: () => "显示水印",
              unchecked: () => "隐藏水印",
            }),
          ]
        }
      ),
    },
    {
      key: "header-divider",
      type: 'divider',
    }
  ];
  return header.concat(dataColumns.value.map((v, idx): HeaderColumnOption => {
    return {
      type: "render",
      render: () => h(
        NFlex,
        {
          justify: "space-between",
          style: { padding: "3px 15px" },
        },
        {
          default: () => [
            h(NCheckbox,
              {
                checked: v.fixed || v.show,
                disabled: !!v.fixed,
                onUpdateChecked: (b) => v.show = b,
                style: { padding: "3px 15px" }
              },
              { default: () => v.title }),
            h(NButtonGroup,
              {
                size: "tiny",
              },
              {
                default: () => [
                  h(NButton, {
                    round: true,
                    disabled: v.checkUp(idx),
                    focusable: false,
                    onClick: () => v.sortUp(idx),
                  }, {
                    default: () => h(NIcon, { component: CaretUp16Filled })
                  }),
                  h(NButton, {
                    round: true,
                    disabled: v.checkDown(idx),
                    focusable: false,
                    onClick: () => v.sortDown(idx),
                  }, {
                    default: () => h(NIcon, { component: CaretDown16Filled })
                  })
                ]
              }),
          ]
        }
      )
    }
  }));
});

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

const parentColumns = computed(() => {
  return ([
    {
      type: "expand",
      title: () => h(
        NDropdown,
        {
          trigger: "click",
          placement: "bottom-start",
          options: headerColumnOptions.value,
        },
        {
          default: () => h(
            NButton,
            {
              text: true,
              style: { fontSize: '24px' }
            },
            {
              default: () => h(
                NIcon,
                { component: TextColumnOne20Filled }
              )
            }
          )
        }
      ),
      renderExpand: (row: RowData) => h(
        NDataTable,
        {
          columns: (displayedColumns.value as DataTableColumns<RowData>),
          rowKey: (v) => v.rowKey,
          striped: true,
          data: row.group!,
          virtualScroll: true,
          minRowHeight: 30,
          maxHeight: 200,
          summary: investorDurationSummary,
          summaryPlacement: "top",
          size: "small",
        },
      )
    },
  ] as DataTableColumns<RowData>).concat(displayedColumns.value as DataTableColumns<RowData>);
});

const groupedData = computed((): RowData[] => {
  if (!data || data.length < 1) return [];

  if (!exportAll.value) {
    const results = [...data.reduce(
      (result: Map<string, RowData>, curr: DBAccount) => {
        const idt = [curr.broker_id, curr.account_id].join(".");

        let data = result.get(idt);

        if (!data) {
          data = defineAccount(curr as unknown as RowData);
        }
        data.group.push(defineAccount(curr as unknown as RowData));

        result.set(idt, data);

        return result;
      },
      new Map([]),
    ).values()];

    results.forEach((row) => {
      const last = row.group[0].trading_day;
      const first = row.group[row.group.length-1].trading_day;

      const dateCache = new Set(meta.getTradingDays(first, last).map((v) => v.format("YYYYMMDD")));
      console.log("check date range:", row.identity, first, last, dateCache);
      if (dateCache.size < 1) return;

      row.group.forEach((v) => {
        dateCache.delete(v.trading_day);
      })

      if (dateCache.size > 0) {
        const values = [...dateCache].sort();

        notification.warning({
          title: "交易日检查异常",
          description: `${row.account_name} (${row.account_id}) 缺失交易日数据`,
          content: () => h(
              NFlex, {},
              {
                default: () => [...values.map((d) => h(
                    "span",
                    `${d} 数据缺失`
                ))]
              }
          ),
          meta: dayjs().format("YYYY-MM-DD HH:mm:ss"),
          duration: 0,
          closable: true,
        })
      }
    })

    return results
  } else {
    return data;
  }
})

const dt = ref<DataTableInst>();
const contextMenu = ref<{ x: number; y: number; show: boolean }>({ x: 0, y: 0, show: false });

function handleMenuSelect(sel: string) {
  contextMenu.value.show = false;

  const now = dayjs().format("YYYYMMDDHHmmss");

  switch (sel) {
    case "all": {
      exportAll.value = true;
      nextTick().then(() => {
        dt.value?.downloadCsv({
          fileName: `account_all_${now}.csv`,
        });
        exportAll.value = false;
      })
      break;
    }
    case "page": {
      nextTick().then(() => {
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

type SummaryKeys = "pre_balance" | "frozen_balance" | "balance" |
  "available" | "deposit" | "withdraw" | "margin" | "frozen_margin" |
  "fee" | "frozen_fee" | "position_profit" | "close_profit" | "net_profit";

function calcSummary(data: RowData[], key: SummaryKeys, deep: boolean = false): Map<string, number> {
  return data.reduce(
    (pre, curr) => pre.set(
      curr.currency_id,
      (pre.get(curr.currency_id) || 0) + (
        deep ? curr.group.reduce(
          (pre, curr) => pre + (curr as any)[key] as number,
          0
        ) : (curr as any)[key] as number
      ),
    ),
    new Map<string, number>([])
  );
}

function makeSummaryCell(data: RowData[], key: SummaryKeys, deep: boolean = false) {
  return h(
    NFlex, {
    vertical: true,
  }, {
    default: () => [...calcSummary(data, key, deep).entries()].map(([currency_id, value]) => {
      return h(NEllipsis, CurrencyFmt[currency_id](value));
    }),
  });
}

const investorDurationSummary: DataTableCreateSummary<RowData> = (pageData): SummaryRowData[] => {
  const lastDay = dayjs(pageData[0].trading_day);
  const firstDay = dayjs(pageData[pageData.length - 1].trading_day);
  const diffMonth = lastDay.diff(firstDay, "month") + 1;

  const monthSummary = new Array<SummaryRowData>(diffMonth);

  for (let idx = 0; idx < diffMonth; idx++) {
    const month = firstDay.add(idx, "month").format("YYYYMM");

    const monthData = pageData.filter(
      (v) => { return v.trading_day.startsWith(month); }
    );

    monthSummary[idx] = {
      "account_id": {
        value: h(NFlex, {
          justify: "end",
          class: "summary",
        }, {
          default: () => `${month} 月度汇总：`,
        }),
        colSpan: 3,
      },
      "deposit": {
        value: makeSummaryCell(monthData, "deposit"),
      },
      "withdraw": {
        value: makeSummaryCell(monthData, "withdraw"),
      },
      'position_profit': {
        value: makeSummaryCell(monthData, "position_profit"),
      },
      'close_profit': {
        value: makeSummaryCell(monthData, "close_profit"),
      },
      'fee': {
        value: makeSummaryCell(monthData, "fee"),
      },
      'net_profit': {
        value: makeSummaryCell(monthData, "net_profit"),
      },
    }
  }

  return monthSummary;
}

const groupDurationSummary: DataTableCreateSummary<RowData> = (pageData): SummaryRowData | SummaryRowData[] => {
  const lastDay = dayjs(
    pageData[0].group![0].trading_day
  );
  const firstDay = dayjs(
    pageData[pageData.length - 1]
      .group![pageData[pageData.length - 1].group!.length - 1]
      .trading_day
  );

  const diffMonth = lastDay.diff(firstDay, "month") + 1;

  const monthSummary = new Array<SummaryRowData>(diffMonth);

  for (let idx = 0; idx < diffMonth; idx++) {
    const month = firstDay.add(idx, "month").format("YYYYMM");

    const monthData: RowData[] = pageData.reduce(
      (pre, curr) => {
        return pre.concat((curr.group || [] as DBAccount[]).filter(
          (v) => { return v.trading_day.startsWith(month); }
        ));
      }, [] as RowData[]
    );

    monthSummary[idx] = {
      'account_id': {
        value: h(NFlex, { justify: "end" }, { default: () => `${month} 月度汇总：` }),
        colSpan: 3,
      },
      "deposit": {
        value: makeSummaryCell(monthData, "deposit"),
      },
      "withdraw": {
        value: makeSummaryCell(monthData, "withdraw"),
      },
      'position_profit': {
        value: makeSummaryCell(monthData, "position_profit"),
      },
      'close_profit': {
        value: makeSummaryCell(monthData, "close_profit"),
      },
      'fee': {
        value: makeSummaryCell(monthData, "fee"),
      },
      'net_profit': {
        value: makeSummaryCell(monthData, "net_profit"),
      },
    }
  }

  return monthSummary.concat([{
    'account_id': {
      value: h(NFlex, {
        justify: "end",
        class: "summary",
      }, {
        default: () => "当前交易日汇总："
      }),
      colSpan: 3,
    },
    'pre_balance': {
      value: makeSummaryCell(pageData, "pre_balance"),
    },
    'deposit': {
      value: makeSummaryCell(pageData, "deposit"),
    },
    'withdraw': {
      value: makeSummaryCell(pageData, "withdraw"),
    },
    'balance': {
      value: makeSummaryCell(pageData, "balance"),
    },
    'position_profit': {
      value: makeSummaryCell(pageData, "position_profit"),
    },
    'close_profit': {
      value: makeSummaryCell(pageData, "close_profit"),
    },
    'fee': {
      value: makeSummaryCell(pageData, "fee"),
    },
    'net_profit': {
      value: makeSummaryCell(pageData, "net_profit"),
    },
  }, {
    'account_id': {
      value: h(NFlex, {
        justify: "end",
        class: "summary",
      }, {
        default: () => "截止最后交易日汇总："
      }),
      colSpan: 3,
    },
    'pre_balance': {
      value: makeSummaryCell(pageData, "pre_balance"),
    },
    'deposit': {
      value: makeSummaryCell(pageData, "deposit", true),
    },
    'withdraw': {
      value: makeSummaryCell(pageData, "withdraw", true),
    },
    'balance': {
      value: makeSummaryCell(pageData, "balance"),
    },
    'position_profit': {
      value: makeSummaryCell(pageData, "position_profit", true),
    },
    'close_profit': {
      value: makeSummaryCell(pageData, "close_profit", true),
    },
    'fee': {
      value: makeSummaryCell(pageData, "fee", true),
    },
    'net_profit': {
      value: makeSummaryCell(pageData, "net_profit", true),
    },
  }]);
}
</script>

<template>
  <n-watermark :content="watermark" :font-size="16" :line-height="16" :width="192" :height="128" :x-offset="12"
    :y-offset="28" :rotate="-15" cross selectable v-if="showWaterMark && watermark">
    <n-data-table ref="dt" :columns="parentColumns as DataTableColumns<RowData>" :data="groupedData" :loading="loading"
      :row-key="(row) => row.rowKey" :row-props="rowProps"
      :summary="groupedData && groupedData.length > 0 ? groupDurationSummary : undefined" striped>
    </n-data-table>
  </n-watermark>
  <n-data-table ref="dt" :columns="parentColumns as DataTableColumns<RowData>" :data="groupedData" :loading="loading"
    :row-key="(row) => row.rowKey" :row-props="rowProps" :max-height="maxHeight"
    :summary="groupedData && groupedData.length > 0 ? groupDurationSummary : undefined" striped v-else>
  </n-data-table>
  <n-dropdown placement="bottom-start" trigger="manual" :x="contextMenu.x" :y="contextMenu.y" :show="contextMenu.show"
    :on-clickoutside="() => contextMenu.show = false" @select="handleMenuSelect"
    :options="[{ label: '导出当前', key: 'page' }, { label: '导出全部', key: 'all' },]"></n-dropdown>
</template>

<style scoped>
.summary {
  font-weight: bold;
}
</style>