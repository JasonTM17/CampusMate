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
CREATE TABLE "knowledge_chunks" (
    "id" bigserial PRIMARY KEY,
    "documentId" bigint NOT NULL,
    "bookId" bigint,
    "title" text NOT NULL,
    "chapter" text,
    "page" bigint,
    "content" text NOT NULL,
    "embedding" vector(1536) NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "knowledge_chunks_doc_idx" ON "knowledge_chunks" USING btree ("documentId");
CREATE INDEX "knowledge_chunks_book_idx" ON "knowledge_chunks" USING btree ("bookId");
CREATE INDEX "knowledge_chunks_embedding_cosine_idx" ON "knowledge_chunks" USING hnsw ("embedding" vector_cosine_ops);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "knowledge_documents" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "sourceType" text NOT NULL,
    "bookId" bigint,
    "accessLevel" text NOT NULL,
    "requiredCourseId" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "knowledge_documents_book_idx" ON "knowledge_documents" USING btree ("bookId");
CREATE INDEX "knowledge_documents_course_idx" ON "knowledge_documents" USING btree ("requiredCourseId");


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260909022535792-phase10-rag', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909022535792-phase10-rag', "timestamp" = now();

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
