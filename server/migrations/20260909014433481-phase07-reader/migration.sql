BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reader_bookmarks" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "bookId" bigint NOT NULL,
    "location" text NOT NULL,
    "title" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "reader_bookmark_user_book_idx" ON "reader_bookmarks" USING btree ("userId", "bookId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reader_highlights" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "bookId" bigint NOT NULL,
    "location" text NOT NULL,
    "text" text NOT NULL,
    "colorToken" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "reader_highlight_user_book_idx" ON "reader_highlights" USING btree ("userId", "bookId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reader_notes" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "bookId" bigint NOT NULL,
    "location" text NOT NULL,
    "content" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "reader_note_user_book_idx" ON "reader_notes" USING btree ("userId", "bookId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reading_progress" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "bookId" bigint NOT NULL,
    "progressPercent" double precision NOT NULL,
    "currentLocation" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reading_progress_user_book_idx" ON "reading_progress" USING btree ("userId", "bookId");
CREATE INDEX "reading_progress_user_idx" ON "reading_progress" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reader_bookmarks"
    ADD CONSTRAINT "reader_bookmarks_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reader_highlights"
    ADD CONSTRAINT "reader_highlights_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reader_notes"
    ADD CONSTRAINT "reader_notes_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reading_progress"
    ADD CONSTRAINT "reading_progress_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260909014433481-phase07-reader', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909014433481-phase07-reader', "timestamp" = now();

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
