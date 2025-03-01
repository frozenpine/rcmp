PRAGMA foreign_keys = false;

CREATE TEMPORARY TABLE IF NOT EXISTS "holidays_0_1_3" AS
    SELECT * FROM "holidays";

DROP TABLE IF EXISTS "holidays";
CREATE TABLE "holidays" (
  "year" integer NOT NULL,
  "name" text NOT NULL,
  "start" integer NOT NULL,
  "end" integer NOT NULL,
  "created_at" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted_at" datetime,
  PRIMARY KEY ("year", "name", "start", "end")
);

INSERT INTO "holidays" SELECT year,name,start,end,created_at,deleted_at FROM "holidays_0_1_3";

PRAGMA foreign_keys = true;