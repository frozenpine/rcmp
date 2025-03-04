PRAGMA foreign_keys = false;

CREATE TEMPORARY TABLE IF NOT EXISTS "investor_group_0_1_2" AS
    SELECT * FROM "investor_group";

DROP TABLE IF EXISTS "investor_group";
CREATE TABLE "investor_group" (
    "group_name" text NOT NULL,
    "broker_id" text NOT NULL,
    "investor_id" text NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" DATETIME,
    PRIMARY KEY ("group_name", "broker_id", "investor_id")
);

INSERT INTO "investor_group" SELECT * FROM "investor_group_0_1_2";

PRAGMA foreign_keys = true;