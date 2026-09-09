BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "student_profiles" ADD COLUMN "status" text;
CREATE INDEX "status_idx" ON "student_profiles" USING btree ("status");

--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260909025030228-phase11-admin', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909025030228-phase11-admin', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
