BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "announcements" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "audience" text NOT NULL,
    "publishAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone,
    "archived" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "announcement_audience_publish_idx" ON "announcements" USING btree ("audience", "publishAt");
CREATE INDEX "announcement_publish_idx" ON "announcements" USING btree ("publishAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "campus_notifications" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "category" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "targetType" text,
    "targetId" bigint,
    "readAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notification_user_read_idx" ON "campus_notifications" USING btree ("userId", "readAt");
CREATE INDEX "notification_user_created_idx" ON "campus_notifications" USING btree ("userId", "createdAt", "id");
CREATE INDEX "notification_user_category_created_idx" ON "campus_notifications" USING btree ("userId", "category", "createdAt", "id");


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260908004517941-phase04-dashboard-notifications', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260908004517941-phase04-dashboard-notifications', "timestamp" = now();

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
