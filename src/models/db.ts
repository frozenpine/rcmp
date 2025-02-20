import { Exchange, ProductClass } from "./type.ts"

export interface DBAccount {
    trading_day: string;
    account_id: string;
    account_name?: string;
    balance: number;
    frozen_balance: number;
    pre_balance: number;
    available: number;
    deposit: number;
    withdrawal: number;
    margin: number;
    frozen_margin: number;
    fee: number;
    frozen_fee: number;
    position_profit: number;
    close_profit: number;
    net_profit: number;
    currency_id: string;
}

export interface Segment {
    readonly segment_name: string;
    readonly is_auction: boolean;
    readonly from: number;
    readonly to: number;
}

export interface ProductInfo {
    readonly exchange_id: Exchange
    readonly product_id: string,
    readonly product_identity: string,
    readonly product_class: ProductClass,
    readonly price_tick: number,
    readonly volume_multiple: number,
    readonly min_market_volume?: number,
    readonly max_market_volume?: number,
    readonly min_limit_volume?: number,
    readonly max_limit_volume?: number,
    readonly underlying_multiple?: number,
    readonly product_name?: string,
}

export interface Vacation {
    readonly year:number,
    readonly name: string,
    readonly start: string,
    readonly end: string,
    readonly range: string[],
}