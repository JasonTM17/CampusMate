BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_profiles" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "studentCode" text,
    "fullName" text,
    "faculty" text,
    "major" text,
    "className" text,
    "gpa" double precision,
    "credits" bigint,
    "conductScore" double precision,
    "role" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "auth_user_id_idx" ON "student_profiles" USING btree ("authUserId");
CREATE UNIQUE INDEX "student_code_idx" ON "student_profiles" USING btree ("studentCode");


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260906080612724-phase02-auth-student', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260906080612724-phase02-auth-student', "timestamp" = now();

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
