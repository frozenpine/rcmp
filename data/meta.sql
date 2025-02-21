/*
 Navicat Premium Dump SQL

 Source Server         : rcmp
 Source Server Type    : SQLite
 Source Server Version : 3045000 (3.45.0)
 Source Schema         : meta

 Target Server Type    : SQLite
 Target Server Version : 3045000 (3.45.0)
 File Encoding         : 65001

 Date: 21/02/2025 18:08:18
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for group_info
-- ----------------------------
DROP TABLE IF EXISTS meta."group_info";
CREATE TABLE meta."group_info" (
  "group_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "group_name" TEXT NOT NULL,
  "group_desc" TEXT DEFAULT '',
  "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" DATETIME
);

-- ----------------------------
-- Table structure for holidays
-- ----------------------------
DROP TABLE IF EXISTS meta."holidays";
CREATE TABLE meta."holidays" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" datetime,
  "updated_at" datetime,
  "deleted_at" datetime,
  "year" integer,
  "name" text NOT NULL,
  "start" integer,
  "end" integer
);

-- ----------------------------
-- Table structure for investor_group
-- ----------------------------
DROP TABLE IF EXISTS meta."investor_group";
CREATE TABLE meta."investor_group" (
  "group_id" INTEGER NOT NULL,
  "broker_id" text NOT NULL,
  "investor_id" text NOT NULL,
  "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" DATETIME,
  PRIMARY KEY ("group_id", "broker_id", "investor_id"),
  CONSTRAINT "group_ref" FOREIGN KEY ("group_id") REFERENCES "group_info" ("group_id") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "account_ref" FOREIGN KEY ("broker_id", "investor_id") REFERENCES "investor_info" ("broker_id", "investor_id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------
-- Table structure for investor_info
-- ----------------------------
DROP TABLE IF EXISTS meta."investor_info";
CREATE TABLE meta."investor_info" (
  "broker_id" text NOT NULL,
  "investor_id" text NOT NULL,
  "investor_name" TEXT DEFAULT '',
  "investor_desc" TEXT DEFAULT '',
  "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" DATETIME,
  PRIMARY KEY ("broker_id", "investor_id")
);

-- ----------------------------
-- Table structure for product_infos
-- ----------------------------
DROP TABLE IF EXISTS meta."product_infos";
CREATE TABLE meta."product_infos" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" datetime,
  "updated_at" datetime,
  "deleted_at" datetime,
  "exchange_id" text,
  "product_id" text,
  "product_identity" text,
  "product_class" text NOT NULL,
  "price_tick" real NOT NULL,
  "volume_multiple" real NOT NULL,
  "min_market_volume" integer NOT NULL,
  "max_market_volume" integer NOT NULL,
  "min_limit_volume" integer NOT NULL,
  "max_limit_volume" integer NOT NULL,
  "underlying_multiple" real,
  "product_name" text
);

-- ----------------------------
-- Table structure for product_segments
-- ----------------------------
DROP TABLE IF EXISTS meta."product_segments";
CREATE TABLE meta."product_segments" (
  "product_identity" text,
  "segment_name" text,
  PRIMARY KEY ("product_identity", "segment_name"),
  CONSTRAINT "fk_product_segments_product_info" FOREIGN KEY ("product_identity") REFERENCES "product_infos" ("product_identity") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "fk_product_segments_trading_segment" FOREIGN KEY ("segment_name") REFERENCES "trading_segments" ("segment_name") ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------
-- Table structure for trading_segments
-- ----------------------------
DROP TABLE IF EXISTS meta."trading_segments";
CREATE TABLE meta."trading_segments" (
  "id" integer PRIMARY KEY AUTOINCREMENT,
  "created_at" datetime,
  "updated_at" datetime,
  "deleted_at" datetime,
  "from" integer,
  "to" integer,
  "is_auction" numeric NOT NULL,
  "segment_name" text
);

-- ----------------------------
-- Indexes structure for table holidays
-- ----------------------------
CREATE UNIQUE INDEX "idx_holiday_range"
ON meta."holidays" (
  "year" ASC,
  "start" ASC,
  "end" ASC
);
CREATE INDEX "idx_holidays_deleted_at"
ON meta."holidays" (
  "deleted_at" ASC
);

-- ----------------------------
-- Indexes structure for table product_infos
-- ----------------------------
CREATE UNIQUE INDEX "idx_product"
ON meta."product_infos" (
  "exchange_id" ASC,
  "product_id" ASC
);
CREATE INDEX "idx_product_infos_deleted_at"
ON meta."product_infos" (
  "deleted_at" ASC
);
CREATE INDEX "idx_product_infos_product_identity"
ON meta."product_infos" (
  "product_identity" ASC
);

-- ----------------------------
-- Indexes structure for table trading_segments
-- ----------------------------
CREATE INDEX "idx_trading_segments_deleted_at"
ON meta."trading_segments" (
  "deleted_at" ASC
);
CREATE INDEX "idx_trading_segments_from"
ON meta."trading_segments" (
  "from" ASC
);
CREATE UNIQUE INDEX "idx_trading_segments_segment_name"
ON meta."trading_segments" (
  "segment_name" ASC
);
CREATE INDEX "idx_trading_segments_to"
ON meta."trading_segments" (
  "to" ASC
);

PRAGMA foreign_keys = true;
