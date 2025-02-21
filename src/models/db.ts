import { Exchange, ProductClass } from "./type.ts"

export interface DBAccount {
    readonly trading_day: string;
    readonly broker_id: string;
    readonly account_id: string;
    readonly account_name?: string;
    readonly balance: number;
    readonly frozen_balance: number;
    readonly pre_balance: number;
    readonly available: number;
    readonly deposit: number;
    readonly withdrawal: number;
    readonly margin: number;
    readonly frozen_margin: number;
    readonly fee: number;
    readonly frozen_fee: number;
    readonly position_profit: number;
    readonly close_profit: number;
    readonly net_profit: number;
    readonly currency_id: string;
}

export interface DBGroup {
    readonly group_id: number;
    readonly group_name: string;
    readonly group_desc: string;
    readonly created_at?: Date
    readonly deleted_at?: Date
    readonly investors?: DBInvestor[]
}

export interface DBInvestor {
    readonly broker_id: string;
    readonly investor_id: string;
    readonly investor_name: string;
    readonly investor_desc: string;
    readonly created_at?: Date,
    readonly deleted_at?: Date,
    readonly groups?: DBGroup[],
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