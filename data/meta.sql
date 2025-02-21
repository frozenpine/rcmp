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
DROP TABLE IF EXISTS "group_info";
CREATE TABLE "group_info" (
  "group_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "group_name" TEXT NOT NULL,
  "group_desc" TEXT DEFAULT '',
  "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" DATETIME
);

-- ----------------------------
-- Table structure for holidays
-- ----------------------------
DROP TABLE IF EXISTS "holidays";
CREATE TABLE "holidays" (
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
DROP TABLE IF EXISTS "investor_group";
CREATE TABLE "investor_group" (
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
DROP TABLE IF EXISTS "investor_info";
CREATE TABLE "investor_info" (
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
DROP TABLE IF EXISTS "product_infos";
CREATE TABLE "product_infos" (
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
DROP TABLE IF EXISTS "product_segments";
CREATE TABLE "product_segments" (
  "product_identity" text,
  "segment_name" text,
  PRIMARY KEY ("product_identity", "segment_name"),
  CONSTRAINT "fk_product_segments_product_info" FOREIGN KEY ("product_identity") REFERENCES "product_infos" ("product_identity") ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT "fk_product_segments_trading_segment" FOREIGN KEY ("segment_name") REFERENCES "trading_segments" ("segment_name") ON DELETE SET NULL ON UPDATE CASCADE
);

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE "sqlite_sequence" (
  "name",
  "seq"
);

-- ----------------------------
-- Table structure for trading_segments
-- ----------------------------
DROP TABLE IF EXISTS "trading_segments";
CREATE TABLE "trading_segments" (
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
-- Auto increment value for group_info
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 2 WHERE name = 'group_info';

-- ----------------------------
-- Auto increment value for holidays
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 66 WHERE name = 'holidays';

-- ----------------------------
-- Indexes structure for table holidays
-- ----------------------------
CREATE UNIQUE INDEX "idx_holiday_range"
ON "holidays" (
  "year" ASC,
  "start" ASC,
  "end" ASC
);
CREATE INDEX "idx_holidays_deleted_at"
ON "holidays" (
  "deleted_at" ASC
);

-- ----------------------------
-- Auto increment value for product_infos
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 159 WHERE name = 'product_infos';

-- ----------------------------
-- Indexes structure for table product_infos
-- ----------------------------
CREATE UNIQUE INDEX "idx_product"
ON "product_infos" (
  "exchange_id" ASC,
  "product_id" ASC
);
CREATE INDEX "idx_product_infos_deleted_at"
ON "product_infos" (
  "deleted_at" ASC
);
CREATE INDEX "idx_product_infos_product_identity"
ON "product_infos" (
  "product_identity" ASC
);

-- ----------------------------
-- Auto increment value for trading_segments
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 16 WHERE name = 'trading_segments';

-- ----------------------------
-- Indexes structure for table trading_segments
-- ----------------------------
CREATE INDEX "idx_trading_segments_deleted_at"
ON "trading_segments" (
  "deleted_at" ASC
);
CREATE INDEX "idx_trading_segments_from"
ON "trading_segments" (
  "from" ASC
);
CREATE UNIQUE INDEX "idx_trading_segments_segment_name"
ON "trading_segments" (
  "segment_name" ASC
);
CREATE INDEX "idx_trading_segments_to"
ON "trading_segments" (
  "to" ASC
);

PRAGMA foreign_keys = true;
