
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
    readonly first_day?: string;
    readonly last_day?: string;
    readonly created_at?: Date,
    readonly deleted_at?: Date,
    readonly groups?: DBGroup[],
}

export interface Vacation {
    readonly year:number,
    readonly name: string,
    readonly start: string,
    readonly end: string,
    readonly range: string[],
}