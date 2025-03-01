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
    "year" integer NOT NULL,
    "name" text NOT NULL,
    "start" integer NOT NULL,
    "end" integer NOT NULL,
    "created_at" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" datetime,
    PRIMARY KEY ("year", "name", "start", "end")
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
  PRIMARY KEY ("group_name", "broker_id", "investor_id")
);

PRAGMA foreign_keys = true;
