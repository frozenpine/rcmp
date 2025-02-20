/*
 Navicat Premium Dump SQL

 Source Server         : rcmp
 Source Server Type    : SQLite
 Source Server Version : 3045000 (3.45.0)
 Source Schema         : meta

 Target Server Type    : SQLite
 Target Server Version : 3045000 (3.45.0)
 File Encoding         : 65001

 Date: 20/02/2025 11:11:58
*/

PRAGMA foreign_keys = false;

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
-- Records of holidays
-- ----------------------------
INSERT INTO "holidays" VALUES (1, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '元旦', 20160101, 20160101);
INSERT INTO "holidays" VALUES (2, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '春节', 20160207, 20160213);
INSERT INTO "holidays" VALUES (3, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '清明', 20160404, 20160404);
INSERT INTO "holidays" VALUES (4, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '劳动节', 20160501, 20160502);
INSERT INTO "holidays" VALUES (5, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '端午节', 20160609, 20160611);
INSERT INTO "holidays" VALUES (6, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '中秋节', 20160915, 20160917);
INSERT INTO "holidays" VALUES (7, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2016, '国庆节', 20161001, 20161007);
INSERT INTO "holidays" VALUES (8, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2017, '元旦', 20170101, 20170101);
INSERT INTO "holidays" VALUES (9, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2017, '春节', 20170127, 20170202);
INSERT INTO "holidays" VALUES (10, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2017, '清明', 20170402, 20170404);
INSERT INTO "holidays" VALUES (11, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2017, '劳动节', 20170501, 20170501);
INSERT INTO "holidays" VALUES (12, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2017, '端午节', 20170528, 20170530);
INSERT INTO "holidays" VALUES (13, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2017, '中秋&国庆', 20171001, 20171008);
INSERT INTO "holidays" VALUES (14, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '元旦', 20180101, 20180101);
INSERT INTO "holidays" VALUES (15, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '春节', 20180215, 20180221);
INSERT INTO "holidays" VALUES (16, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '清明', 20180405, 20180407);
INSERT INTO "holidays" VALUES (17, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '劳动节', 20180429, 20180501);
INSERT INTO "holidays" VALUES (18, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '端午节', 20180618, 20180618);
INSERT INTO "holidays" VALUES (19, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '中秋节', 20180924, 20180924);
INSERT INTO "holidays" VALUES (20, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2018, '国庆节', 20181001, 20181007);
INSERT INTO "holidays" VALUES (21, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '元旦', 20181230, 20190101);
INSERT INTO "holidays" VALUES (22, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '春节', 20190204, 20190210);
INSERT INTO "holidays" VALUES (23, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '清明', 20190405, 20190405);
INSERT INTO "holidays" VALUES (24, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '劳动节', 20190501, 20190501);
INSERT INTO "holidays" VALUES (25, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '端午节', 20190607, 20190607);
INSERT INTO "holidays" VALUES (26, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '中秋节', 20190913, 20190913);
INSERT INTO "holidays" VALUES (27, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2019, '国庆节', 20191001, 20191007);
INSERT INTO "holidays" VALUES (28, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2020, '元旦', 20200101, 20200101);
INSERT INTO "holidays" VALUES (29, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2020, '春节', 20200124, 20200130);
INSERT INTO "holidays" VALUES (30, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2020, '清明', 20200404, 20200406);
INSERT INTO "holidays" VALUES (31, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2020, '劳动节', 20200501, 20200505);
INSERT INTO "holidays" VALUES (32, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2020, '端午节', 20200625, 20200627);
INSERT INTO "holidays" VALUES (33, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2020, '国庆&中秋', 20201001, 20201008);
INSERT INTO "holidays" VALUES (34, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '元旦', 20210101, 20210103);
INSERT INTO "holidays" VALUES (35, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '春节', 20210211, 20210217);
INSERT INTO "holidays" VALUES (36, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '清明', 20210403, 20210405);
INSERT INTO "holidays" VALUES (37, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '劳动节', 20210501, 20210505);
INSERT INTO "holidays" VALUES (38, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '端午节', 20210612, 20210614);
INSERT INTO "holidays" VALUES (39, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '中秋节', 20210919, 20210921);
INSERT INTO "holidays" VALUES (40, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2021, '国庆节', 20211001, 20211007);
INSERT INTO "holidays" VALUES (41, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '元旦', 20220101, 20220103);
INSERT INTO "holidays" VALUES (42, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '春节', 20220131, 20220206);
INSERT INTO "holidays" VALUES (43, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '清明', 20220403, 20220405);
INSERT INTO "holidays" VALUES (44, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '劳动节', 20220430, 20220504);
INSERT INTO "holidays" VALUES (45, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '端午节', 20220603, 20220605);
INSERT INTO "holidays" VALUES (46, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '中秋节', 20220910, 20220912);
INSERT INTO "holidays" VALUES (47, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2022, '国庆节', 20221001, 20221007);
INSERT INTO "holidays" VALUES (48, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2023, '元旦', 20221231, 20230102);
INSERT INTO "holidays" VALUES (49, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2023, '春节', 20230121, 20230127);
INSERT INTO "holidays" VALUES (50, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2023, '清明', 20230405, 20230405);
INSERT INTO "holidays" VALUES (51, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2023, '劳动节', 20230429, 20230503);
INSERT INTO "holidays" VALUES (52, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2023, '端午节', 20230622, 20230624);
INSERT INTO "holidays" VALUES (53, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2023, '中秋&国庆', 20230929, 20231006);
INSERT INTO "holidays" VALUES (54, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '元旦', 20231230, 20240101);
INSERT INTO "holidays" VALUES (55, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '春节', 20240210, 20240217);
INSERT INTO "holidays" VALUES (56, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '清明节', 20240404, 20240406);
INSERT INTO "holidays" VALUES (57, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '劳动节', 20240501, 20240505);
INSERT INTO "holidays" VALUES (58, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '端午节', 20240610, 20240610);
INSERT INTO "holidays" VALUES (59, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '中秋节', 20240915, 20240917);
INSERT INTO "holidays" VALUES (60, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2024, '国庆节', 20241001, 20241007);
INSERT INTO "holidays" VALUES (61, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2025, '元旦', 20250101, 20250101);
INSERT INTO "holidays" VALUES (62, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2025, '春节', 20250128, 20250204);
INSERT INTO "holidays" VALUES (63, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2025, '清明', 20250404, 20250406);
INSERT INTO "holidays" VALUES (64, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2025, '劳动节', 20250501, 20250505);
INSERT INTO "holidays" VALUES (65, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2025, '端午节', 20250531, 20250602);
INSERT INTO "holidays" VALUES (66, '2024-11-25 16:09:35.6078199+08:00', '2024-11-25 16:09:35.6078199+08:00', NULL, 2025, '国庆&中秋', 20251001, 20251008);

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
-- Records of product_infos
-- ----------------------------
INSERT INTO "product_infos" VALUES (1, '2024-11-26 05:09:40', '2024-11-29 12:17:41.6262366+08:00', NULL, 'CZCE', 'AP', 'CZCE.AP', 'Futures', 1.0, 10.0, 1, 200, 1, 1000, 1.0, '鲜苹果');
INSERT INTO "product_infos" VALUES (2, '2024-11-26 05:09:40', '2024-11-29 12:17:41.694321+08:00', NULL, 'CZCE', 'APC', 'CZCE.APC', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '苹果看涨期权');
INSERT INTO "product_infos" VALUES (3, '2024-11-26 05:09:40', '2024-11-29 12:17:41.7695206+08:00', NULL, 'CZCE', 'APP', 'CZCE.APP', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '苹果看跌期权');
INSERT INTO "product_infos" VALUES (4, '2024-11-26 05:09:40', '2024-11-29 12:17:41.8345634+08:00', NULL, 'CZCE', 'CF', 'CZCE.CF', 'Futures', 5.0, 5.0, 1, 200, 1, 1000, NULL, '一号棉花');
INSERT INTO "product_infos" VALUES (5, '2024-11-26 05:09:40', '2024-11-29 12:17:41.896358+08:00', NULL, 'CZCE', 'CFC', 'CZCE.CFC', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '棉花看涨期权');
INSERT INTO "product_infos" VALUES (6, '2024-11-26 05:09:40', '2024-11-29 12:17:41.9660269+08:00', NULL, 'CZCE', 'CFP', 'CZCE.CFP', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '棉花看跌期权');
INSERT INTO "product_infos" VALUES (7, '2024-11-26 05:09:40', '2024-11-29 12:17:42.0327252+08:00', NULL, 'CZCE', 'CJ', 'CZCE.CJ', 'Futures', 5.0, 5.0, 1, 20, 1, 100, 1.0, '红枣');
INSERT INTO "product_infos" VALUES (8, '2024-11-26 05:09:40', '2024-11-29 12:17:42.1073651+08:00', NULL, 'CZCE', 'CJC', 'CZCE.CJC', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '红枣看涨期权');
INSERT INTO "product_infos" VALUES (9, '2024-11-26 05:09:40', '2024-11-29 12:17:42.1811225+08:00', NULL, 'CZCE', 'CJP', 'CZCE.CJP', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '红枣看跌期权');
INSERT INTO "product_infos" VALUES (10, '2024-11-26 05:09:40', '2024-11-29 12:17:42.2559681+08:00', NULL, 'CZCE', 'CY', 'CZCE.CY', 'Futures', 5.0, 5.0, 1, 200, 1, 1000, 1.0, '棉纱');
INSERT INTO "product_infos" VALUES (11, '2024-11-26 05:09:40', '2024-11-29 12:17:42.3298011+08:00', NULL, 'CZCE', 'ER', 'CZCE.ER', 'Futures', 1.0, 10.0, 1, 200, 1, 1000, NULL, '早籼稻');
INSERT INTO "product_infos" VALUES (12, '2024-11-26 05:09:40', '2024-11-29 12:17:42.4039565+08:00', NULL, 'CZCE', 'FG', 'CZCE.FG', 'Futures', 1.0, 20.0, 1, 500, 1, 500, NULL, '玻璃');
INSERT INTO "product_infos" VALUES (13, '2024-11-26 05:09:40', '2024-11-29 12:17:42.4782102+08:00', NULL, 'CZCE', 'FGC', 'CZCE.FGC', 'Options', 0.5, 20.0, 1, 2, 1, 100, 1.0, '玻璃看涨期权');
INSERT INTO "product_infos" VALUES (14, '2024-11-26 05:09:40', '2024-11-29 12:17:42.5443296+08:00', NULL, 'CZCE', 'FGP', 'CZCE.FGP', 'Options', 0.5, 20.0, 1, 2, 1, 100, 1.0, '玻璃看跌期权');
INSERT INTO "product_infos" VALUES (15, '2024-11-26 05:09:40', '2024-11-29 10:41:16.5754403+08:00', NULL, 'CFFEX', 'IC', 'CFFEX.IC', 'Futures', 0.2, 200.0, 1, 50, 1, 100, NULL, '中证500指数');
INSERT INTO "product_infos" VALUES (16, '2024-11-26 05:09:40', '2024-11-29 10:41:19.3364807+08:00', NULL, 'CFFEX', 'IF', 'CFFEX.IF', 'Futures', 0.2, 300.0, 1, 50, 1, 100, NULL, '沪深300指数');
INSERT INTO "product_infos" VALUES (17, '2024-11-26 05:09:40', '2024-11-29 10:41:20.8818068+08:00', NULL, 'CFFEX', 'IH', 'CFFEX.IH', 'Futures', 0.2, 300.0, 1, 50, 1, 100, NULL, '上证50指数');
INSERT INTO "product_infos" VALUES (18, '2024-11-26 05:09:40', '2024-11-29 10:41:21.8127174+08:00', NULL, 'CFFEX', 'IM', 'CFFEX.IM', 'Futures', 0.2, 200.0, 1, 10, 1, 20, NULL, '中证1000股指期货');
INSERT INTO "product_infos" VALUES (19, '2024-11-26 05:09:40', '2024-11-29 12:17:42.6186714+08:00', NULL, 'CZCE', 'JR', 'CZCE.JR', 'Futures', 1.0, 20.0, 1, 200, 1, 1000, NULL, '粳稻');
INSERT INTO "product_infos" VALUES (20, '2024-11-26 05:09:40', '2024-11-29 12:17:42.7013815+08:00', NULL, 'CZCE', 'LR', 'CZCE.LR', 'Futures', 1.0, 20.0, 1, 200, 1, 1000, NULL, '晚籼稻');
INSERT INTO "product_infos" VALUES (21, '2024-11-26 05:09:40', '2024-11-29 12:17:42.7832882+08:00', NULL, 'CZCE', 'MA', 'CZCE.MA', 'Futures', 1.0, 10.0, 1, 200, 1, 1000, NULL, '甲醇');
INSERT INTO "product_infos" VALUES (22, '2024-11-26 05:09:40', '2024-11-29 12:17:42.8407708+08:00', NULL, 'CZCE', 'MAC', 'CZCE.MAC', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '甲醇看涨期权');
INSERT INTO "product_infos" VALUES (23, '2024-11-26 05:09:40', '2024-11-29 12:17:42.9072808+08:00', NULL, 'CZCE', 'MAP', 'CZCE.MAP', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '甲醇看跌期权');
INSERT INTO "product_infos" VALUES (24, '2024-11-26 05:09:40', '2024-11-29 12:17:42.9648476+08:00', NULL, 'CZCE', 'ME', 'CZCE.ME', 'Futures', 1.0, 50.0, 1, 200, 1, 1000, NULL, '甲醇');
INSERT INTO "product_infos" VALUES (25, '2024-11-26 05:09:40', '2024-11-29 12:17:43.0310174+08:00', NULL, 'CZCE', 'OI', 'CZCE.OI', 'Futures', 1.0, 10.0, 1, 500, 1, 500, 1.0, '菜籽油');
INSERT INTO "product_infos" VALUES (26, '2024-11-26 05:09:40', '2024-11-29 12:17:43.095639+08:00', NULL, 'CZCE', 'OIC', 'CZCE.OIC', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '菜油看涨期权');
INSERT INTO "product_infos" VALUES (27, '2024-11-26 05:09:40', '2024-11-29 12:17:43.178761+08:00', NULL, 'CZCE', 'OIP', 'CZCE.OIP', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '菜油看跌期权');
INSERT INTO "product_infos" VALUES (28, '2024-11-26 05:09:40', '2024-11-29 12:17:43.2543869+08:00', NULL, 'CZCE', 'PF', 'CZCE.PF', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, 1.0, '短纤');
INSERT INTO "product_infos" VALUES (29, '2024-11-26 05:09:40', '2024-11-29 12:17:43.310945+08:00', NULL, 'CZCE', 'PFC', 'CZCE.PFC', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, '短纤看涨期权');
INSERT INTO "product_infos" VALUES (30, '2024-11-26 05:09:40', '2024-11-29 12:17:43.3855438+08:00', NULL, 'CZCE', 'PFP', 'CZCE.PFP', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, '短纤看跌期权');
INSERT INTO "product_infos" VALUES (31, '2024-11-26 05:09:40', '2024-11-29 12:17:43.4579353+08:00', NULL, 'CZCE', 'PK', 'CZCE.PK', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, 1.0, '花生仁');
INSERT INTO "product_infos" VALUES (32, '2024-11-26 05:09:40', '2024-11-29 12:17:43.5251988+08:00', NULL, 'CZCE', 'PKC', 'CZCE.PKC', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, '花生看涨期权');
INSERT INTO "product_infos" VALUES (33, '2024-11-26 05:09:40', '2024-11-29 12:17:43.5995252+08:00', NULL, 'CZCE', 'PKP', 'CZCE.PKP', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, '花生看跌期权');
INSERT INTO "product_infos" VALUES (34, '2024-11-26 05:09:40', '2024-11-29 12:17:43.6735842+08:00', NULL, 'CZCE', 'PM', 'CZCE.PM', 'Futures', 1.0, 50.0, 1, 200, 1, 1000, NULL, '普通小麦');
INSERT INTO "product_infos" VALUES (35, '2024-11-26 05:09:40', '2024-11-29 12:17:43.7394968+08:00', NULL, 'CZCE', 'PR', 'CZCE.PR', 'Futures', 2.0, 15.0, 1, 200, 1, 1000, 1.0, '瓶片');
INSERT INTO "product_infos" VALUES (36, '2024-11-26 05:09:40', '2024-11-29 12:17:43.8047935+08:00', NULL, 'CZCE', 'PX', 'CZCE.PX', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, 1.0, '对二甲苯');
INSERT INTO "product_infos" VALUES (37, '2024-11-26 05:09:40', '2024-11-29 12:17:43.9717915+08:00', NULL, 'CZCE', 'PXC', 'CZCE.PXC', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, '对二甲苯看涨期权');
INSERT INTO "product_infos" VALUES (38, '2024-11-26 05:09:40', '2024-11-29 12:17:44.1399554+08:00', NULL, 'CZCE', 'PXP', 'CZCE.PXP', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, '对二甲苯看跌期权');
INSERT INTO "product_infos" VALUES (39, '2024-11-26 05:09:40', '2024-11-29 12:17:44.3025434+08:00', NULL, 'CZCE', 'QM', 'CZCE.QM', 'Futures', 1.0, 50.0, 1, 200, 1, 1000, NULL, '优质强筋小麦');
INSERT INTO "product_infos" VALUES (40, '2024-11-26 05:09:40', '2024-11-29 12:17:44.4777633+08:00', NULL, 'CZCE', 'RI', 'CZCE.RI', 'Futures', 1.0, 20.0, 1, 500, 1, 500, NULL, '早籼稻');
INSERT INTO "product_infos" VALUES (41, '2024-11-26 05:09:40', '2024-11-29 12:17:44.6992898+08:00', NULL, 'CZCE', 'RM', 'CZCE.RM', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, NULL, '菜籽粕');
INSERT INTO "product_infos" VALUES (42, '2024-11-26 05:09:40', '2024-11-29 12:17:44.8507679+08:00', NULL, 'CZCE', 'RMC', 'CZCE.RMC', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '菜籽粕看涨期权');
INSERT INTO "product_infos" VALUES (43, '2024-11-26 05:09:40', '2024-11-29 12:17:44.9718518+08:00', NULL, 'CZCE', 'RMP', 'CZCE.RMP', 'Options', 0.5, 10.0, 1, 2, 1, 100, 1.0, '菜籽粕看跌期权');
INSERT INTO "product_infos" VALUES (44, '2024-11-26 05:09:40', '2024-11-29 12:17:45.1215375+08:00', NULL, 'CZCE', 'RO', 'CZCE.RO', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, NULL, '菜籽油');
INSERT INTO "product_infos" VALUES (45, '2024-11-26 05:09:40', '2024-11-29 12:17:45.2870299+08:00', NULL, 'CZCE', 'RS', 'CZCE.RS', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, NULL, '油菜籽');
INSERT INTO "product_infos" VALUES (46, '2024-11-26 05:09:40', '2024-11-29 12:17:45.4268995+08:00', NULL, 'CZCE', 'SA', 'CZCE.SA', 'Futures', 1.0, 20.0, 1, 200, 1, 200, 1.0, '纯碱');
INSERT INTO "product_infos" VALUES (47, '2024-11-26 05:09:40', '2024-11-29 12:17:45.5846981+08:00', NULL, 'CZCE', 'SAC', 'CZCE.SAC', 'Options', 0.5, 20.0, 1, 2, 1, 100, 1.0, '纯碱看涨期权');
INSERT INTO "product_infos" VALUES (48, '2024-11-26 05:09:40', '2024-11-29 12:17:45.7263028+08:00', NULL, 'CZCE', 'SAP', 'CZCE.SAP', 'Options', 0.5, 20.0, 1, 2, 1, 100, 1.0, '纯碱看跌期权');
INSERT INTO "product_infos" VALUES (49, '2024-11-26 05:09:40', '2024-11-29 12:17:45.8834798+08:00', NULL, 'CZCE', 'SF', 'CZCE.SF', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, NULL, '硅铁');
INSERT INTO "product_infos" VALUES (50, '2024-11-26 05:09:40', '2024-11-29 12:17:46.0488726+08:00', NULL, 'CZCE', 'SFC', 'CZCE.SFC', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '硅铁看涨期权');
INSERT INTO "product_infos" VALUES (51, '2024-11-26 05:09:40', '2024-11-29 12:17:46.2152687+08:00', NULL, 'CZCE', 'SFP', 'CZCE.SFP', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '硅铁看跌期权');
INSERT INTO "product_infos" VALUES (52, '2024-11-26 05:09:40', '2024-11-29 12:17:46.3482967+08:00', NULL, 'CZCE', 'SH', 'CZCE.SH', 'Futures', 1.0, 30.0, 1, 200, 1, 1000, 1.0, '烧碱');
INSERT INTO "product_infos" VALUES (53, '2024-11-26 05:09:40', '2024-11-29 12:17:46.4601736+08:00', NULL, 'CZCE', 'SHC', 'CZCE.SHC', 'Options', 0.5, 30.0, 1, 2, 1, 100, 1.0, '烧碱看涨期权');
INSERT INTO "product_infos" VALUES (54, '2024-11-26 05:09:40', '2024-11-29 12:17:46.5562229+08:00', NULL, 'CZCE', 'SHP', 'CZCE.SHP', 'Options', 0.5, 30.0, 1, 2, 1, 100, 1.0, '烧碱看跌期权');
INSERT INTO "product_infos" VALUES (55, '2024-11-26 05:09:40', '2024-11-29 12:17:46.7007292+08:00', NULL, 'CZCE', 'SM', 'CZCE.SM', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, NULL, '锰硅');
INSERT INTO "product_infos" VALUES (56, '2024-11-26 05:09:40', '2024-11-29 12:17:46.7960004+08:00', NULL, 'CZCE', 'SMC', 'CZCE.SMC', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '锰硅看涨期权');
INSERT INTO "product_infos" VALUES (57, '2024-11-26 05:09:40', '2024-11-29 12:17:46.9172683+08:00', NULL, 'CZCE', 'SMP', 'CZCE.SMP', 'Options', 1.0, 5.0, 1, 2, 1, 100, 1.0, '锰硅看跌期权');
INSERT INTO "product_infos" VALUES (58, '2024-11-26 05:09:40', '2024-11-29 12:17:47.0286933+08:00', NULL, 'CZCE', 'SR', 'CZCE.SR', 'Futures', 1.0, 10.0, 1, 200, 1, 1000, NULL, '白砂糖');
INSERT INTO "product_infos" VALUES (59, '2024-11-26 05:09:40', '2024-11-29 12:17:47.1864916+08:00', NULL, 'CZCE', 'SRC', 'CZCE.SRC', 'Options', 0.5, 10.0, 1, 2, 1, 20, 1.0, '白糖看涨期权');
INSERT INTO "product_infos" VALUES (60, '2024-11-26 05:09:40', '2024-11-29 12:17:47.3244415+08:00', NULL, 'CZCE', 'SRP', 'CZCE.SRP', 'Options', 0.5, 10.0, 1, 2, 1, 20, 1.0, '白糖看跌期权');
INSERT INTO "product_infos" VALUES (61, '2024-11-26 05:09:40', '2024-11-29 10:41:21.8706466+08:00', NULL, 'CFFEX', 'T', 'CFFEX.T', 'Futures', 0.005, 10000.0, 1, 50, 1, 200, NULL, '10年期国债');
INSERT INTO "product_infos" VALUES (62, '2024-11-26 05:09:40', '2024-11-29 12:17:47.4269452+08:00', NULL, 'CZCE', 'TA', 'CZCE.TA', 'Futures', 2.0, 5.0, 1, 200, 1, 1000, NULL, '精对苯二甲酸');
INSERT INTO "product_infos" VALUES (63, '2024-11-26 05:09:40', '2024-11-29 12:17:47.5848275+08:00', NULL, 'CZCE', 'TAC', 'CZCE.TAC', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, 'PTA看涨期权');
INSERT INTO "product_infos" VALUES (64, '2024-11-26 05:09:40', '2024-11-29 12:17:47.6802288+08:00', NULL, 'CZCE', 'TAP', 'CZCE.TAP', 'Options', 0.5, 5.0, 1, 2, 1, 100, 1.0, 'PTA看跌期权');
INSERT INTO "product_infos" VALUES (65, '2024-11-26 05:09:40', '2024-11-29 12:17:47.8387858+08:00', NULL, 'CZCE', 'TC', 'CZCE.TC', 'Futures', 0.2, 200.0, 1, 200, 1, 1000, NULL, '动力煤');
INSERT INTO "product_infos" VALUES (66, '2024-11-26 05:09:40', '2024-11-29 10:41:21.9358681+08:00', NULL, 'CFFEX', 'TF', 'CFFEX.TF', 'Futures', 0.005, 10000.0, 1, 50, 1, 200, NULL, '5年期国债');
INSERT INTO "product_infos" VALUES (67, '2024-11-26 05:09:40', '2024-11-29 10:41:21.9938726+08:00', NULL, 'CFFEX', 'TL', 'CFFEX.TL', 'Futures', 0.01, 10000.0, 1, 30, 1, 50, NULL, '30年国债期货');
INSERT INTO "product_infos" VALUES (68, '2024-11-26 05:09:40', '2024-11-29 10:41:22.0648879+08:00', NULL, 'CFFEX', 'TS', 'CFFEX.TS', 'Futures', 0.002, 20000.0, 1, 30, 1, 50, NULL, '2年期国债');
INSERT INTO "product_infos" VALUES (69, '2024-11-26 05:09:40', '2024-11-29 12:17:47.9955111+08:00', NULL, 'CZCE', 'UR', 'CZCE.UR', 'Futures', 1.0, 20.0, 1, 200, 1, 1000, 1.0, '尿素');
INSERT INTO "product_infos" VALUES (70, '2024-11-26 05:09:40', '2024-11-29 12:17:48.0825291+08:00', NULL, 'CZCE', 'URC', 'CZCE.URC', 'Options', 0.5, 20.0, 1, 2, 1, 100, 1.0, '尿素看涨期权');
INSERT INTO "product_infos" VALUES (71, '2024-11-26 05:09:40', '2024-11-29 12:17:48.2395924+08:00', NULL, 'CZCE', 'URP', 'CZCE.URP', 'Options', 0.5, 20.0, 1, 2, 1, 100, 1.0, '尿素看跌期权');
INSERT INTO "product_infos" VALUES (72, '2024-11-26 05:09:40', '2024-11-29 12:17:48.3979569+08:00', NULL, 'CZCE', 'WH', 'CZCE.WH', 'Futures', 1.0, 20.0, 1, 200, 1, 1000, NULL, '优质强筋小麦');
INSERT INTO "product_infos" VALUES (73, '2024-11-26 05:09:40', '2024-11-29 12:17:48.5473698+08:00', NULL, 'CZCE', 'WS', 'CZCE.WS', 'Futures', 1.0, 10.0, 1, 200, 1, 1000, NULL, '优质强筋小麦');
INSERT INTO "product_infos" VALUES (74, '2024-11-26 05:09:40', '2024-11-29 12:17:49.6338891+08:00', NULL, 'CZCE', 'WT', 'CZCE.WT', 'Futures', 1.0, 10.0, 1, 200, 1, 1000, NULL, '硬冬白小麦');
INSERT INTO "product_infos" VALUES (75, '2024-11-26 05:09:40', '2024-11-29 12:17:50.8714077+08:00', NULL, 'CZCE', 'ZC', 'CZCE.ZC', 'Futures', 0.2, 100.0, 1, 10, 1, 50, 1.0, '动力煤');
INSERT INTO "product_infos" VALUES (76, '2024-11-26 05:09:40', '2024-11-29 12:17:51.8110252+08:00', NULL, 'CZCE', 'ZCC', 'CZCE.ZCC', 'Options', 0.1, 100.0, 1, 2, 1, 100, 1.0, '动煤看涨期权');
INSERT INTO "product_infos" VALUES (77, '2024-11-26 05:09:40', '2024-11-29 12:17:53.9190671+08:00', NULL, 'CZCE', 'ZCP', 'CZCE.ZCP', 'Options', 0.1, 100.0, 1, 2, 1, 100, 1.0, '动煤看跌期权');
INSERT INTO "product_infos" VALUES (78, '2024-11-26 05:09:40', '2024-11-29 11:54:13.1371057+08:00', NULL, 'DCE', 'a', 'DCE.a', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, NULL, '黄大豆1号');
INSERT INTO "product_infos" VALUES (79, '2024-11-26 05:09:40', '2024-11-29 11:54:13.1912066+08:00', NULL, 'DCE', 'a_o', 'DCE.a_o', 'Options', 0.5, 10.0, 1, 1000, 1, 1000, 1.0, '黄大豆1号期权');
INSERT INTO "product_infos" VALUES (80, '2024-11-26 05:09:40', '2024-11-29 12:17:54.9901074+08:00', NULL, 'SHFE', 'ag', 'SHFE.ag', 'Futures', 1.0, 15.0, 1, 500, 1, 500, NULL, '白银');
INSERT INTO "product_infos" VALUES (81, '2024-11-26 05:09:40', '2024-11-29 12:17:55.0575016+08:00', NULL, 'SHFE', 'ag_o', 'SHFE.ag_o', 'Options', 0.5, 15.0, 1, 100, 1, 100, 1.0, '白银期权');
INSERT INTO "product_infos" VALUES (82, '2024-11-26 05:09:40', '2024-11-29 12:17:56.231571+08:00', NULL, 'SHFE', 'al', 'SHFE.al', 'Futures', 5.0, 5.0, 1, 500, 1, 500, NULL, '铝');
INSERT INTO "product_infos" VALUES (83, '2024-11-26 05:09:40', '2024-11-29 12:17:56.3060591+08:00', NULL, 'SHFE', 'al_o', 'SHFE.al_o', 'Options', 1.0, 5.0, 1, 100, 1, 100, 1.0, '铝期权');
INSERT INTO "product_infos" VALUES (84, '2024-11-26 05:09:40', '2024-11-29 12:17:56.8040533+08:00', NULL, 'SHFE', 'ao', 'SHFE.ao', 'Futures', 1.0, 20.0, 1, 500, 1, 500, 1.0, '氧化铝期货');
INSERT INTO "product_infos" VALUES (85, '2024-11-26 05:09:40', '2024-11-29 12:17:57.8102819+08:00', NULL, 'SHFE', 'ao_o', 'SHFE.ao_o', 'Options', 0.5, 20.0, 1, 100, 1, 100, 1.0, '氧化铝期权');
INSERT INTO "product_infos" VALUES (86, '2024-11-26 05:09:40', '2024-11-29 12:17:58.1186127+08:00', NULL, 'SHFE', 'au', 'SHFE.au', 'Futures', 0.02, 1000.0, 1, 30, 1, 500, 1.0, '黄金');
INSERT INTO "product_infos" VALUES (87, '2024-11-26 05:09:40', '2024-11-29 12:17:59.2664748+08:00', NULL, 'SHFE', 'au_o', 'SHFE.au_o', 'Options', 0.02, 1000.0, 1, 100, 1, 100, 1.0, '黄金期权');
INSERT INTO "product_infos" VALUES (88, '2024-11-26 05:09:40', '2024-11-29 11:54:13.7253174+08:00', NULL, 'DCE', 'b', 'DCE.b', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, NULL, '黄大豆2号');
INSERT INTO "product_infos" VALUES (89, '2024-11-26 05:09:40', '2024-11-29 11:54:13.7871914+08:00', NULL, 'DCE', 'b_o', 'DCE.b_o', 'Options', 0.5, 10.0, 1, 1000, 1, 1000, 1.0, '黄大豆2号期权');
INSERT INTO "product_infos" VALUES (90, '2024-11-26 05:09:40', '2024-11-29 11:54:13.83217+08:00', NULL, 'DCE', 'bb', 'DCE.bb', 'Futures', 0.05, 500.0, 1, 1000, 1, 1000, NULL, '细木工板');
INSERT INTO "product_infos" VALUES (91, '2024-11-26 05:09:40', '2024-11-29 12:17:59.3504579+08:00', NULL, 'INE', 'bc', 'INE.bc', 'Futures', 10.0, 5.0, 1, 500, 1, 500, 1.0, '国际铜');
INSERT INTO "product_infos" VALUES (92, '2024-11-26 05:09:40', '2024-11-29 12:18:00.4909136+08:00', NULL, 'SHFE', 'br', 'SHFE.br', 'Futures', 5.0, 5.0, 1, 500, 1, 500, 1.0, '丁二烯橡胶');
INSERT INTO "product_infos" VALUES (93, '2024-11-26 05:09:40', '2024-11-29 12:18:01.4268733+08:00', NULL, 'SHFE', 'br_o', 'SHFE.br_o', 'Options', 1.0, 5.0, 1, 100, 1, 100, 1.0, '丁二烯橡胶期权');
INSERT INTO "product_infos" VALUES (94, '2024-11-26 05:09:40', '2024-11-29 12:18:01.5252225+08:00', NULL, 'SHFE', 'bu', 'SHFE.bu', 'Futures', 2.0, 10.0, 1, 500, 1, 500, NULL, '石油沥青');
INSERT INTO "product_infos" VALUES (95, '2024-11-26 05:09:40', '2024-11-29 11:54:14.1170653+08:00', NULL, 'DCE', 'c', 'DCE.c', 'Futures', 1.0, 10.0, 1, 2000, 1, 2000, NULL, '黄玉米');
INSERT INTO "product_infos" VALUES (96, '2024-11-26 05:09:40', '2024-11-29 11:54:14.1804168+08:00', NULL, 'DCE', 'c_o', 'DCE.c_o', 'Options', 0.5, 10.0, 1, 100, 1, 100, 1.0, '玉米期权');
INSERT INTO "product_infos" VALUES (97, '2024-11-26 05:09:40', '2024-11-29 11:54:14.2332642+08:00', NULL, 'DCE', 'cs', 'DCE.cs', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, 1.0, '玉米淀粉');
INSERT INTO "product_infos" VALUES (98, '2024-11-26 05:09:40', '2024-11-29 11:54:14.2877729+08:00', NULL, 'DCE', 'cs_o', 'DCE.cs_o', 'Options', 0.5, 10.0, 1, 1000, 1, 1000, 1.0, '玉米淀粉期权');
INSERT INTO "product_infos" VALUES (99, '2024-11-26 05:09:40', '2024-11-29 12:18:02.856548+08:00', NULL, 'SHFE', 'cu', 'SHFE.cu', 'Futures', 10.0, 5.0, 1, 500, 1, 500, NULL, '铜');
INSERT INTO "product_infos" VALUES (100, '2024-11-26 05:09:40', '2024-11-29 12:18:02.9443643+08:00', NULL, 'SHFE', 'cu_o', 'SHFE.cu_o', 'Options', 2.0, 5.0, 1, 100, 1, 100, 1.0, '铜期权');
INSERT INTO "product_infos" VALUES (101, '2024-11-26 05:09:40', '2024-11-29 11:54:14.4828273+08:00', NULL, 'DCE', 'eb', 'DCE.eb', 'Futures', 1.0, 5.0, 1, 1000, 1, 1000, 1.0, '苯乙烯');
INSERT INTO "product_infos" VALUES (102, '2024-11-26 05:09:40', '2024-11-29 11:54:14.5362484+08:00', NULL, 'DCE', 'eb_o', 'DCE.eb_o', 'Options', 0.5, 5.0, 1, 1000, 1, 1000, 1.0, '苯乙烯期权');
INSERT INTO "product_infos" VALUES (103, '2024-11-26 05:09:40', '2024-11-29 12:18:03.7388166+08:00', NULL, 'INE', 'ec', 'INE.ec', 'Futures', 0.1, 50.0, 1, 30, 1, 500, 1.0, 'SCFIS欧线');
INSERT INTO "product_infos" VALUES (104, '2024-11-26 05:09:40', '2024-11-29 11:54:14.6684309+08:00', NULL, 'DCE', 'eg', 'DCE.eg', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, 1.0, '乙二醇');
INSERT INTO "product_infos" VALUES (105, '2024-11-26 05:09:40', '2024-11-29 11:54:14.739103+08:00', NULL, 'DCE', 'eg_o', 'DCE.eg_o', 'Options', 0.5, 10.0, 1, 1000, 1, 1000, 1.0, '乙二醇期权');
INSERT INTO "product_infos" VALUES (106, '2024-11-26 05:09:40', '2024-11-29 11:54:14.8136969+08:00', NULL, 'DCE', 'fb', 'DCE.fb', 'Futures', 0.5, 10.0, 1, 1000, 1, 1000, 1.0, '纤维板');
INSERT INTO "product_infos" VALUES (107, '2024-11-26 05:09:40', '2024-11-29 12:18:04.2685475+08:00', NULL, 'SHFE', 'fu', 'SHFE.fu', 'Futures', 1.0, 10.0, 1, 500, 1, 500, 1.0, '燃料油');
INSERT INTO "product_infos" VALUES (108, '2024-11-26 05:09:40', '2024-11-29 12:18:05.0096698+08:00', NULL, 'SHFE', 'hc', 'SHFE.hc', 'Futures', 1.0, 10.0, 1, 500, 1, 500, 1.0, '热轧卷板');
INSERT INTO "product_infos" VALUES (109, '2024-11-26 05:09:40', '2024-11-29 11:54:15.0117233+08:00', NULL, 'DCE', 'i', 'DCE.i', 'Futures', 0.5, 100.0, 1, 1000, 1, 1000, 1.0, '铁矿石');
INSERT INTO "product_infos" VALUES (110, '2024-11-26 05:09:40', '2024-11-29 11:54:15.0773353+08:00', NULL, 'DCE', 'i_o', 'DCE.i_o', 'Options', 0.1, 100.0, 1, 100, 1, 1000, 1.0, '铁矿石期权');
INSERT INTO "product_infos" VALUES (111, '2024-11-26 05:09:40', '2024-11-29 11:54:15.143133+08:00', NULL, 'DCE', 'j', 'DCE.j', 'Futures', 0.5, 100.0, 1, 1000, 1, 1000, 1.0, '冶金焦炭');
INSERT INTO "product_infos" VALUES (112, '2024-11-26 05:09:40', '2024-11-29 11:54:15.2168672+08:00', NULL, 'DCE', 'jd', 'DCE.jd', 'Futures', 1.0, 10.0, 1, 300, 1, 300, NULL, '鲜鸡蛋');
INSERT INTO "product_infos" VALUES (113, '2024-11-26 05:09:40', '2024-11-29 11:54:15.2918662+08:00', NULL, 'DCE', 'jd_o', 'DCE.jd_o', 'Options', 0.5, 10.0, 1, 300, 1, 300, 1.0, '鸡蛋期权');
INSERT INTO "product_infos" VALUES (114, '2024-11-26 05:09:40', '2024-11-29 11:54:15.3669762+08:00', NULL, 'DCE', 'jm', 'DCE.jm', 'Futures', 0.5, 60.0, 1, 1000, 1, 1000, 1.0, '焦煤');
INSERT INTO "product_infos" VALUES (115, '2024-11-26 05:09:40', '2024-11-29 11:54:15.4333794+08:00', NULL, 'DCE', 'l', 'DCE.l', 'Futures', 1.0, 5.0, 1, 1000, 1, 1000, 1.0, '线型低密度聚乙烯');
INSERT INTO "product_infos" VALUES (116, '2024-11-26 05:09:40', '2024-11-29 11:54:15.5447794+08:00', NULL, 'DCE', 'l_o', 'DCE.l_o', 'Options', 0.5, 5.0, 1, 100, 1, 1000, 1.0, '聚乙烯期权');
INSERT INTO "product_infos" VALUES (117, '2024-11-26 05:09:40', '2024-11-29 12:30:19.5696806+08:00', NULL, 'GFEX', 'lc', 'GFEX.lc', 'Futures', 50.0, 1.0, 1, 1000, 1, 1000, 1.0, '碳酸锂');
INSERT INTO "product_infos" VALUES (118, '2024-11-26 05:09:40', '2024-11-29 12:30:19.6301353+08:00', NULL, 'GFEX', 'lc_o', 'GFEX.lc_o', 'Options', 10.0, 1.0, 1, 100, 1, 100, 1.0, '碳酸锂期权');
INSERT INTO "product_infos" VALUES (119, '2024-11-26 05:09:40', '2024-11-29 11:54:15.7876554+08:00', NULL, 'DCE', 'lg', 'DCE.lg', 'Futures', 0.5, 90.0, 1, 1000, 1, 1000, 1.0, '原木');
INSERT INTO "product_infos" VALUES (120, '2024-11-26 05:09:40', '2024-11-29 11:54:15.8527341+08:00', NULL, 'DCE', 'lg_o', 'DCE.lg_o', 'Options', 0.25, 90.0, 1, 1000, 1, 1000, 1.0, '原木期权');
INSERT INTO "product_infos" VALUES (121, '2024-11-26 05:09:40', '2024-11-29 11:54:15.9188596+08:00', NULL, 'DCE', 'lh', 'DCE.lh', 'Futures', 5.0, 16.0, 1, 50, 1, 50, 1.0, '生猪');
INSERT INTO "product_infos" VALUES (122, '2024-11-26 05:09:40', '2024-11-29 11:54:15.984636+08:00', NULL, 'DCE', 'lh_o', 'DCE.lh_o', 'Options', 2.5, 16.0, 1, 50, 1, 50, 1.0, '生猪期权');
INSERT INTO "product_infos" VALUES (123, '2024-11-26 05:09:40', '2024-11-29 12:18:05.4125254+08:00', NULL, 'INE', 'lu', 'INE.lu', 'Futures', 1.0, 10.0, 1, 500, 1, 500, 1.0, '低硫燃料油');
INSERT INTO "product_infos" VALUES (124, '2024-11-26 05:09:40', '2024-11-29 11:54:16.1337943+08:00', NULL, 'DCE', 'm', 'DCE.m', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, NULL, '豆粕');
INSERT INTO "product_infos" VALUES (125, '2024-11-26 05:09:40', '2024-11-29 11:54:16.2084285+08:00', NULL, 'DCE', 'm_o', 'DCE.m_o', 'Options', 0.5, 10.0, 1, 100, 1, 100, 1.0, '豆粕期权');
INSERT INTO "product_infos" VALUES (126, '2024-11-26 05:09:40', '2024-11-29 12:18:06.7824663+08:00', NULL, 'SHFE', 'ni', 'SHFE.ni', 'Futures', 10.0, 1.0, 1, 500, 1, 500, 1.0, '镍');
INSERT INTO "product_infos" VALUES (127, '2024-11-26 05:09:40', '2024-11-29 12:18:06.8603909+08:00', NULL, 'SHFE', 'ni_o', 'SHFE.ni_o', 'Options', 2.0, 1.0, 1, 100, 1, 100, 1.0, '镍期权');
INSERT INTO "product_infos" VALUES (128, '2024-11-26 05:09:40', '2024-11-29 12:18:06.9431181+08:00', NULL, 'INE', 'nr', 'INE.nr', 'Futures', 5.0, 10.0, 1, 500, 1, 500, 1.0, '20号胶');
INSERT INTO "product_infos" VALUES (129, '2024-11-26 05:09:40', '2024-11-29 11:54:16.4838374+08:00', NULL, 'DCE', 'p', 'DCE.p', 'Futures', 2.0, 10.0, 1, 1000, 1, 1000, NULL, '棕榈油');
INSERT INTO "product_infos" VALUES (130, '2024-11-26 05:09:40', '2024-11-29 11:54:16.558196+08:00', NULL, 'DCE', 'p_o', 'DCE.p_o', 'Options', 0.5, 10.0, 1, 100, 1, 1000, 1.0, '棕榈油期权');
INSERT INTO "product_infos" VALUES (131, '2024-11-26 05:09:40', '2024-11-29 12:18:08.0039479+08:00', NULL, 'SHFE', 'pb', 'SHFE.pb', 'Futures', 5.0, 5.0, 1, 500, 1, 500, NULL, '铅');
INSERT INTO "product_infos" VALUES (132, '2024-11-26 05:09:40', '2024-11-29 12:18:08.0878296+08:00', NULL, 'SHFE', 'pb_o', 'SHFE.pb_o', 'Options', 1.0, 5.0, 1, 100, 1, 100, 1.0, '铅期权');
INSERT INTO "product_infos" VALUES (133, '2024-11-26 05:09:40', '2024-11-29 11:54:16.7481784+08:00', NULL, 'DCE', 'pg', 'DCE.pg', 'Futures', 1.0, 20.0, 1, 1000, 1, 1000, 1.0, '液化石油气');
INSERT INTO "product_infos" VALUES (134, '2024-11-26 05:09:40', '2024-11-29 11:54:16.8043422+08:00', NULL, 'DCE', 'pg_o', 'DCE.pg_o', 'Options', 0.2, 20.0, 1, 1000, 1, 1000, 1.0, 'LPG期权');
INSERT INTO "product_infos" VALUES (135, '2024-11-26 05:09:40', '2024-11-29 11:54:16.8629773+08:00', NULL, 'DCE', 'pp', 'DCE.pp', 'Futures', 1.0, 5.0, 1, 1000, 1, 1000, NULL, '聚丙烯');
INSERT INTO "product_infos" VALUES (136, '2024-11-26 05:09:40', '2024-11-29 11:54:16.9368544+08:00', NULL, 'DCE', 'pp_o', 'DCE.pp_o', 'Options', 0.5, 5.0, 1, 100, 1, 1000, 1.0, '聚丙烯期权');
INSERT INTO "product_infos" VALUES (137, '2024-11-26 05:09:40', '2024-11-29 12:18:08.1705939+08:00', NULL, 'SHFE', 'rb', 'SHFE.rb', 'Futures', 1.0, 10.0, 1, 500, 1, 500, NULL, '螺纹钢');
INSERT INTO "product_infos" VALUES (138, '2024-11-26 05:09:40', '2024-11-29 12:18:08.2536389+08:00', NULL, 'SHFE', 'rb_o', 'SHFE.rb_o', 'Options', 0.5, 10.0, 1, 100, 1, 100, 1.0, '螺纹钢期权');
INSERT INTO "product_infos" VALUES (139, '2024-11-26 05:09:40', '2024-11-29 11:54:17.1259451+08:00', NULL, 'DCE', 'rr', 'DCE.rr', 'Futures', 1.0, 10.0, 1, 1000, 1, 1000, 1.0, '粳米');
INSERT INTO "product_infos" VALUES (140, '2024-11-26 05:09:40', '2024-11-29 12:18:09.5730955+08:00', NULL, 'SHFE', 'ru', 'SHFE.ru', 'Futures', 5.0, 10.0, 1, 500, 1, 500, NULL, '天然橡胶');
INSERT INTO "product_infos" VALUES (141, '2024-11-26 05:09:40', '2024-11-29 12:18:09.6306108+08:00', NULL, 'SHFE', 'ru_o', 'SHFE.ru_o', 'Options', 1.0, 10.0, 1, 100, 1, 100, 1.0, '天胶期权');
INSERT INTO "product_infos" VALUES (142, '2024-11-26 05:09:40', '2024-11-29 12:18:09.6969484+08:00', NULL, 'INE', 'sc', 'INE.sc', 'Futures', 0.1, 1000.0, 1, 500, 1, 500, 1.0, '原油');
INSERT INTO "product_infos" VALUES (143, '2024-11-26 05:09:40', '2024-11-29 12:18:09.7718277+08:00', NULL, 'INE', 'sc_o', 'INE.sc_o', 'Options', 0.05, 1000.0, 1, 100, 1, 100, 1.0, '原油期权');
INSERT INTO "product_infos" VALUES (144, '2024-11-26 05:09:40', '2024-11-29 12:30:19.7094807+08:00', NULL, 'GFEX', 'si', 'GFEX.si', 'Futures', 5.0, 5.0, 1, 1000, 1, 1000, 1.0, '工业硅');
INSERT INTO "product_infos" VALUES (145, '2024-11-26 05:09:40', '2024-11-29 12:30:19.8161486+08:00', NULL, 'GFEX', 'si_o', 'GFEX.si_o', 'Options', 1.0, 5.0, 1, 100, 1, 100, 1.0, '工业硅期权');
INSERT INTO "product_infos" VALUES (146, '2024-11-26 05:09:40', '2024-11-29 12:18:09.9772592+08:00', NULL, 'SHFE', 'sn', 'SHFE.sn', 'Futures', 10.0, 1.0, 1, 500, 1, 500, 1.0, '锡');
INSERT INTO "product_infos" VALUES (147, '2024-11-26 05:09:40', '2024-11-29 12:18:10.0601821+08:00', NULL, 'SHFE', 'sn_o', 'SHFE.sn_o', 'Options', 2.0, 1.0, 1, 100, 1, 100, 1.0, '锡期权');
INSERT INTO "product_infos" VALUES (148, '2024-11-26 05:09:40', '2024-11-29 12:18:10.1351296+08:00', NULL, 'SHFE', 'sp', 'SHFE.sp', 'Futures', 2.0, 10.0, 1, 500, 1, 500, 1.0, '漂针浆');
INSERT INTO "product_infos" VALUES (149, '2024-11-26 05:09:40', '2024-11-29 12:18:10.2260372+08:00', NULL, 'SHFE', 'ss', 'SHFE.ss', 'Futures', 5.0, 5.0, 1, 500, 1, 500, 1.0, '不锈钢');
INSERT INTO "product_infos" VALUES (150, '2024-11-26 05:09:40', '2024-11-29 11:54:18.1781681+08:00', NULL, 'DCE', 'v', 'DCE.v', 'Futures', 1.0, 5.0, 1, 1000, 1, 1000, 1.0, '聚氯乙烯');
INSERT INTO "product_infos" VALUES (151, '2024-11-26 05:09:40', '2024-11-29 11:54:18.2489135+08:00', NULL, 'DCE', 'v_o', 'DCE.v_o', 'Options', 0.5, 5.0, 1, 100, 1, 1000, 1.0, '氯乙烯期权');
INSERT INTO "product_infos" VALUES (152, '2024-11-26 05:09:40', '2024-11-29 12:18:10.2999268+08:00', NULL, 'SHFE', 'wr', 'SHFE.wr', 'Futures', 1.0, 10.0, 1, 500, 1, 500, NULL, '线材');
INSERT INTO "product_infos" VALUES (153, '2024-11-26 05:09:40', '2024-11-29 11:54:18.4230152+08:00', NULL, 'DCE', 'y', 'DCE.y', 'Futures', 2.0, 10.0, 1, 1000, 1, 1000, NULL, '豆油');
INSERT INTO "product_infos" VALUES (154, '2024-11-26 05:09:40', '2024-11-29 11:54:18.5104975+08:00', NULL, 'DCE', 'y_o', 'DCE.y_o', 'Options', 0.5, 10.0, 1, 1000, 1, 1000, 1.0, '豆油期权');
INSERT INTO "product_infos" VALUES (155, '2024-11-26 05:09:40', '2024-11-29 12:18:10.3900253+08:00', NULL, 'SHFE', 'zn', 'SHFE.zn', 'Futures', 5.0, 5.0, 1, 500, 1, 500, NULL, '锌');
INSERT INTO "product_infos" VALUES (156, '2024-11-26 05:09:40', '2024-11-29 12:18:10.7811423+08:00', NULL, 'SHFE', 'zn_o', 'SHFE.zn_o', 'Options', 1.0, 5.0, 1, 100, 1, 100, 1.0, '锌期权');
INSERT INTO "product_infos" VALUES (157, '2024-11-26 05:09:40', '2024-11-29 11:54:18.7051353+08:00', NULL, 'CFFEX', 'MO', 'CFFEX.MO', 'Options', 0.2, 100.0, 1, 20, 1, 20, 1.0, '中证1000股指期权');
INSERT INTO "product_infos" VALUES (158, '2024-11-26 05:09:40', '2024-11-29 11:54:18.7788608+08:00', NULL, 'CFFEX', 'IO', 'CFFEX.IO', 'Options', 0.2, 100.0, 1, 20, 1, 20, 1.0, '沪深300股指期权');
INSERT INTO "product_infos" VALUES (159, '2024-11-26 05:09:40', '2024-11-29 11:54:18.8446974+08:00', NULL, 'CFFEX', 'HO', 'CFFEX.HO', 'Options', 0.2, 100.0, 1, 20, 1, 20, 1.0, '上证50股指期权');

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
-- Records of product_segments
-- ----------------------------
INSERT INTO "product_segments" VALUES ('CFFEX.IC', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.IC', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.IC', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.IF', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.IF', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.IF', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.IH', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.IH', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.IH', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.IM', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.IM', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.IM', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.T', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.T', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.T', '中金白盘1515');
INSERT INTO "product_segments" VALUES ('CFFEX.TF', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.TF', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.TF', '中金白盘1515');
INSERT INTO "product_segments" VALUES ('CFFEX.TL', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.TL', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.TL', '中金白盘1515');
INSERT INTO "product_segments" VALUES ('CFFEX.TS', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.TS', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.TS', '中金白盘1515');
INSERT INTO "product_segments" VALUES ('DCE.a', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.a', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.a', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.a', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.a', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.a_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.a_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.a_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.a_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.a_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.b', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.b', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.b', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.b', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.b', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.b_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.b_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.b_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.b_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.b_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.bb', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.bb', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.bb', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.bb', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.c', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.c', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.c', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.c', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.c', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.c_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.c_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.c_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.c_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.c_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.cs', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.cs', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.cs', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.cs', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.cs', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.cs_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.cs_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.cs_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.cs_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.cs_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.eb', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.eb', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.eb', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.eb', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.eb', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.eb_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.eb_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.eb_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.eb_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.eb_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.eg', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.eg', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.eg', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.eg', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.eg', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.eg_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.eg_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.eg_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.eg_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.eg_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.fb', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.fb', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.fb', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.fb', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.i', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.i', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.i', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.i', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.i', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.i_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.i_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.i_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.i_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.i_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.j', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.j', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.j', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.j', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.j', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.jd', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.jd', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.jd', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.jd', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.jd_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.jd_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.jd_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.jd_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.jm', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.jm', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.jm', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.jm', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.jm', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.l', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.l', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.l', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.l', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.l', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.l_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.l_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.l_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.l_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.l_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.lg', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.lg', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.lg', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.lg', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.lg_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.lg_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.lg_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.lg_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.lh', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.lh', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.lh', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.lh', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.lh_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('DCE.lh_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.lh_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.lh_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.m', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.m', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.m', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.m', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.m', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.m_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.m_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.m_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.m_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.m_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.p', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.p', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.p', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.p', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.p', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.p_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.p_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.p_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.p_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.p_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.pg', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.pg', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.pg', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.pg', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.pg', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.pg_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.pg_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.pg_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.pg_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.pg_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.pp', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.pp', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.pp', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.pp', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.pp', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.pp_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.pp_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.pp_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.pp_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.pp_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.rr', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.rr', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.rr', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.rr', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.rr', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.v', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.v', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.v', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.v', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.v', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.v_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.v_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.v_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.v_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.v_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.y', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.y', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.y', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.y', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.y', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('DCE.y_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('DCE.y_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('DCE.y_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('DCE.y_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('DCE.y_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.MO', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.MO', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.MO', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.IO', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.IO', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.IO', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CFFEX.HO', '中金白盘0930');
INSERT INTO "product_segments" VALUES ('CFFEX.HO', '中金白盘1130');
INSERT INTO "product_segments" VALUES ('CFFEX.HO', '中金白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.AP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.AP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.AP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.AP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.APC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.APC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.APC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.APC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.APP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.APP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.APP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.APP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CF', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.CF', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.CF', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CF', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CF', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CFC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.CFC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.CFC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CFC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CFC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CFP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.CFP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.CFP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CFP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CFP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CJ', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.CJ', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CJ', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CJ', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CJC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.CJC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CJC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CJC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CJP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.CJP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CJP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CJP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.CY', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.CY', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.CY', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.CY', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.CY', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.ER', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.ER', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.ER', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.ER', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.FG', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.FG', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.FG', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.FG', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.FG', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.FGC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.FGC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.FGC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.FGC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.FGC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.FGP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.FGP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.FGP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.FGP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.FGP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.JR', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.JR', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.JR', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.JR', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.LR', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.LR', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.LR', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.LR', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.MA', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.MA', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.MA', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.MA', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.MAC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.MAC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.MAC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.MAC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.MAP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.MAP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.MAP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.MAP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.ME', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.ME', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.ME', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.ME', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.ME', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.OI', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.OI', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.OI', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.OI', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.OI', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.OIC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.OIC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.OIC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.OIC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.OIC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.OIP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.OIP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.OIP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.OIP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.OIP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PF', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.PF', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.PF', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PF', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PF', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PFC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.PFC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.PFC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PFC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PFC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PFP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.PFP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.PFP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PFP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PFP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PK', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.PK', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PK', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PK', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PKC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.PKC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PKC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PKC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PKP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.PKP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PKP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PKP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PM', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.PM', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PM', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PM', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PR', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.PR', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PR', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PR', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PX', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.PX', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.PX', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PX', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PX', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PXC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.PXC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.PXC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PXC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PXC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.PXP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.PXP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.PXP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.PXP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.PXP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.QM', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.QM', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.QM', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.QM', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.RI', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.RI', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.RI', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.RI', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.RM', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.RM', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.RM', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.RM', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.RM', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.RMC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.RMC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.RMC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.RMC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.RMC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.RMP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.RMP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.RMP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.RMP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.RMP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.RO', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.RO', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.RO', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.RO', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.RS', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.RS', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.RS', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.RS', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SA', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SA', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SA', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SA', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SA', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SAC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SAC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SAC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SAC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SAC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SAP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SAP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SAP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SAP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SAP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SF', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.SF', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SF', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SF', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SFC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.SFC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SFC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SFC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SFP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.SFP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SFP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SFP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SH', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SH', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SH', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SH', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SH', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SHC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SHC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SHC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SHC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SHC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SHP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SHP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SHP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SHP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SHP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SM', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.SM', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SM', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SM', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SMC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.SMC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SMC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SMC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SMP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.SMP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SMP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SMP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SR', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SR', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SR', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SR', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SR', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SRC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SRC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SRC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SRC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SRC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.SRP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.SRP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.SRP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.SRP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.SRP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.TA', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.TA', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.TA', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.TA', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.TA', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.TAC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.TAC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.TAC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.TAC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.TAC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.TAP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.TAP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.TAP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.TAP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.TAP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.TC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.TC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.TC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.TC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.UR', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.UR', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.UR', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.UR', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.URC', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.URC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.URC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.URC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.URP', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.URP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.URP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.URP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.WH', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.WH', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.WH', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.WH', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.WS', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.WS', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.WS', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.WS', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.WT', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('CZCE.WT', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.WT', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.WT', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.ZC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.ZC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.ZC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.ZC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.ZC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.ZCC', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.ZCC', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.ZCC', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.ZCC', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.ZCC', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('CZCE.ZCP', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('CZCE.ZCP', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('CZCE.ZCP', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('CZCE.ZCP', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('CZCE.ZCP', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ag', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ag', '期货夜盘0230');
INSERT INTO "product_segments" VALUES ('SHFE.ag', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ag', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ag', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ag_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ag_o', '期货夜盘0230');
INSERT INTO "product_segments" VALUES ('SHFE.ag_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ag_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ag_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.al', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.al', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.al', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.al', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.al', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.al_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.al_o', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.al_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.al_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.al_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ao', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('SHFE.ao', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ao', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ao', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ao_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('SHFE.ao_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ao_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ao_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.au', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.au', '期货夜盘0230');
INSERT INTO "product_segments" VALUES ('SHFE.au', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.au', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.au', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.au_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.au_o', '期货夜盘0230');
INSERT INTO "product_segments" VALUES ('SHFE.au_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.au_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.au_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('INE.bc', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('INE.bc', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('INE.bc', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('INE.bc', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('INE.bc', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.br', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('SHFE.br', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.br', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.br', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.br_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('SHFE.br_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.br_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.br_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.bu', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.bu', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.bu', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.bu', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.bu', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.cu', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.cu', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.cu', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.cu', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.cu', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.cu_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.cu_o', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.cu_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.cu_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.cu_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('INE.ec', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('INE.ec', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('INE.ec', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('INE.ec', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.fu', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.fu', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.fu', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.fu', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.fu', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.hc', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.hc', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.hc', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.hc', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.hc', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('INE.lu', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('INE.lu', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('INE.lu', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('INE.lu', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('INE.lu', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ni', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ni', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.ni', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ni', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ni', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ni_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ni_o', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.ni_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ni_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ni_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('INE.nr', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('INE.nr', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('INE.nr', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('INE.nr', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('INE.nr', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.pb', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.pb', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.pb', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.pb', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.pb', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.pb_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.pb_o', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.pb_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.pb_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.pb_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.rb', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.rb', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.rb', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.rb', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.rb', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.rb_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.rb_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.rb_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.rb_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.rb_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ru', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ru', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.ru', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ru', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ru', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ru_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ru_o', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.ru_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ru_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ru_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('INE.sc', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('INE.sc', '期货夜盘0230');
INSERT INTO "product_segments" VALUES ('INE.sc', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('INE.sc', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('INE.sc', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('INE.sc_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('INE.sc_o', '期货夜盘0230');
INSERT INTO "product_segments" VALUES ('INE.sc_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('INE.sc_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('INE.sc_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.sn', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.sn', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.sn', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.sn', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.sn', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.sn_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.sn_o', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.sn_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.sn_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.sn_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.sp', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.sp', '期货夜盘2300');
INSERT INTO "product_segments" VALUES ('SHFE.sp', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.sp', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.sp', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.ss', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.ss', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.ss', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.ss', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.ss', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.wr', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('SHFE.wr', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.wr', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.wr', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.zn', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.zn', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.zn', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.zn', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.zn', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('SHFE.zn_o', '期货夜盘2100');
INSERT INTO "product_segments" VALUES ('SHFE.zn_o', '期货夜盘0100');
INSERT INTO "product_segments" VALUES ('SHFE.zn_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('SHFE.zn_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('SHFE.zn_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('GFEX.lc', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('GFEX.lc', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('GFEX.lc', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('GFEX.lc', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('GFEX.lc_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('GFEX.lc_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('GFEX.lc_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('GFEX.lc_o', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('GFEX.si', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('GFEX.si', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('GFEX.si', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('GFEX.si', '期货白盘1500');
INSERT INTO "product_segments" VALUES ('GFEX.si_o', '期货白盘0900');
INSERT INTO "product_segments" VALUES ('GFEX.si_o', '期货白盘1015');
INSERT INTO "product_segments" VALUES ('GFEX.si_o', '期货白盘1130');
INSERT INTO "product_segments" VALUES ('GFEX.si_o', '期货白盘1500');

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE "sqlite_sequence" (
  "name",
  "seq"
);

-- ----------------------------
-- Records of sqlite_sequence
-- ----------------------------
INSERT INTO "sqlite_sequence" VALUES ('holidays', 66);
INSERT INTO "sqlite_sequence" VALUES ('product_infos', 159);
INSERT INTO "sqlite_sequence" VALUES ('trading_segments', 16);

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
-- Records of trading_segments
-- ----------------------------
INSERT INTO "trading_segments" VALUES (1, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 929, 930, 'true', '股票白盘0930');
INSERT INTO "trading_segments" VALUES (2, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 930, 1130, 'false', '股票白盘1130');
INSERT INTO "trading_segments" VALUES (3, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 1300, 1500, 'false', '股票白盘1500');
INSERT INTO "trading_segments" VALUES (4, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 929, 930, 'true', '中金白盘0930');
INSERT INTO "trading_segments" VALUES (5, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 930, 1130, 'false', '中金白盘1130');
INSERT INTO "trading_segments" VALUES (6, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 1300, 1515, 'false', '中金白盘1515');
INSERT INTO "trading_segments" VALUES (7, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 2059, 2100, 'true', '期货夜盘2100');
INSERT INTO "trading_segments" VALUES (8, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 2100, 2300, 'false', '期货夜盘2300');
INSERT INTO "trading_segments" VALUES (10, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 2100, 100, 'false', '期货夜盘0100');
INSERT INTO "trading_segments" VALUES (11, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 2100, 230, 'false', '期货夜盘0230');
INSERT INTO "trading_segments" VALUES (12, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 900, 1015, 'false', '期货白盘1015');
INSERT INTO "trading_segments" VALUES (13, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 1030, 1130, 'false', '期货白盘1130');
INSERT INTO "trading_segments" VALUES (14, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 1330, 1500, 'false', '期货白盘1500');
INSERT INTO "trading_segments" VALUES (15, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 1300, 1500, 'false', '中金白盘1500');
INSERT INTO "trading_segments" VALUES (16, '2024-11-29 01:20:30', '2024-11-29 01:20:30', NULL, 859, 900, 'true', '期货白盘0900');

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
