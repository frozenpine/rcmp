/*
 Navicat Premium Dump SQL

 Source Server         : rcmp
 Source Server Type    : SQLite
 Source Server Version : 3045000 (3.45.0)
 Source Schema         : meta

 Target Server Type    : SQLite
 Target Server Version : 3045000 (3.45.0)
 File Encoding         : 65001

 Date: 25/02/2025 08:17:10
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for group_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS "group_info" (
  "group_name" TEXT NOT NULL,
  "group_desc" TEXT DEFAULT '',
  "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" DATETIME,
  PRIMARY KEY ("group_name")
);

-- ----------------------------
-- Table structure for holidays
-- ----------------------------
CREATE TABLE IF NOT EXISTS "holidays" (
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
-- Table structure for investor_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS "investor_info" (
     "broker_id" text NOT NULL,
     "investor_id" text NOT NULL,
     "investor_name" TEXT DEFAULT '',
     "investor_desc" TEXT DEFAULT '',
     "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
     "deleted_at" DATETIME,
     PRIMARY KEY ("broker_id", "investor_id")
);

-- ----------------------------
-- Table structure for investor_group
-- ----------------------------
CREATE TABLE IF NOT EXISTS "investor_group" (
  "group_name" text NOT NULL,
  "broker_id" text NOT NULL,
  "investor_id" text NOT NULL,
  "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" DATETIME,
  PRIMARY KEY ("group_name", "broker_id", "investor_id"),
  CONSTRAINT "group_ref" FOREIGN KEY ("group_name") REFERENCES "group_info" ("group_name") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "account_ref" FOREIGN KEY ("broker_id", "investor_id") REFERENCES "investor_info" ("broker_id", "investor_id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------
-- Indexes structure for table holidays
-- ----------------------------
CREATE UNIQUE INDEX IF NOT EXISTS "idx_holiday_range"
ON "holidays" (
  "year" ASC,
  "start" ASC,
  "end" ASC
);
CREATE INDEX IF NOT EXISTS "idx_holidays_deleted_at"
ON "holidays" (
  "deleted_at" ASC
);

PRAGMA foreign_keys = true;
