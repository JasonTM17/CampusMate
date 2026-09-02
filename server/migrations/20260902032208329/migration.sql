BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_conversations" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_id_idx" ON "ai_conversations" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_messages" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "role" text NOT NULL,
    "content" text NOT NULL,
    "citations" text,
    "feedback" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "conversation_id_idx" ON "ai_messages" USING btree ("conversationId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_usage" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "day" timestamp without time zone NOT NULL,
    "requestCount" bigint NOT NULL,
    "inputTokens" bigint NOT NULL,
    "outputTokens" bigint NOT NULL,
    "estimatedCost" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_day_idx" ON "ai_usage" USING btree ("userId", "day");


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260902032208329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260902032208329', "timestamp" = now();

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
