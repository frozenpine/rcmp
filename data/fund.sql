/*
 Navicat Premium Dump SQL

 Source Server         : rcmp
 Source Server Type    : SQLite
 Source Server Version : 3045000 (3.45.0)
 Source Schema         : fund

 Target Server Type    : SQLite
 Target Server Version : 3045000 (3.45.0)
 File Encoding         : 65001

 Date: 20/02/2025 11:10:59
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS "account";
CREATE TABLE "account" (
  "trading_day" TEXT NOT NULL,
  "account_id" text NOT NULL,
  "account_name" TEXT DEFAULT '',
  "balance" real NOT NULL DEFAULT 0,
  "frozen_balance" real NOT NULL DEFAULT 0,
  "pre_balance" real NOT NULL DEFAULT 0,
  "available" real NOT NULL DEFAULT 0,
  "deposit" real NOT NULL DEFAULT 0,
  "withdraw" real NOT NULL DEFAULT 0,
  "margin" real NOT NULL DEFAULT 0,
  "frozen_margin" real NOT NULL DEFAULT 0,
  "fee" real NOT NULL DEFAULT 0,
  "frozen_fee" real NOT NULL DEFAULT 0,
  "premium" real NOT NULL DEFAULT 0,
  "frozen_premium" real NOT NULL DEFAULT 0,
  "position_profit" real NOT NULL DEFAULT 0,
  "close_profit" real NOT NULL DEFAULT 0,
  "net_profit" real NOT NULL DEFAULT 0,
  "currency_id" text NOT NULL DEFAULT 'CNY',
  PRIMARY KEY ("trading_day", "account_id", "currency_id")
);

PRAGMA foreign_keys = true;
