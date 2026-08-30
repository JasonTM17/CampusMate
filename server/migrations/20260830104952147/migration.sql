BEGIN;

--
-- CREATE VECTOR EXTENSION IF AVAILABLE
--
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'vector') THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS vector';
  ELSE
    RAISE EXCEPTION 'Required extension "vector" is not available on this instance. Please install pgvector. For instructions, see https://docs.serverpod.dev/upgrading/upgrade-to-pgvector.';
  END IF;
END
$$;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "vector_capability_probe" (
    "id" bigserial PRIMARY KEY,
    "embedding" vector(1536) NOT NULL
);


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260830104952147', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260830104952147', "timestamp" = now();

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
