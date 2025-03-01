import {Vacation} from "../models/db.ts";

export interface InvestorLoaderInst {
    loadGroupInvestors(force: boolean = false): void;
}

export interface TradeDateLoaderInst {
    loadHolidays(force: boolean = false): void;
}