BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_user_memories" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "content" text NOT NULL,
    "source" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "disabledAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "ai_user_memory_user_idx" ON "ai_user_memories" USING btree ("userId", "createdAt", "id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_ai_preferences" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "explanationStyle" text NOT NULL,
    "personalizationEnabled" boolean NOT NULL,
    "memoryEnabled" boolean NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "student_ai_pref_user_idx" ON "student_ai_preferences" USING btree ("userId");


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260909020152277-phase09-personalized-ai', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909020152277-phase09-personalized-ai', "timestamp" = now();

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
