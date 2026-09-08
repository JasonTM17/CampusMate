BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "authors" (
    "id" bigserial PRIMARY KEY,
    "displayName" text NOT NULL,
    "normalizedName" text NOT NULL,
    "biography" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "author_normalized_name_idx" ON "authors" USING btree ("normalizedName");
CREATE INDEX "author_display_name_idx" ON "authors" USING btree ("displayName");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_authors" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "authorId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_author_unique_idx" ON "book_authors" USING btree ("bookId", "authorId");
CREATE INDEX "book_author_book_idx" ON "book_authors" USING btree ("bookId");
CREATE INDEX "book_author_author_idx" ON "book_authors" USING btree ("authorId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_categories" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_category_slug_idx" ON "book_categories" USING btree ("slug");
CREATE INDEX "book_category_name_idx" ON "book_categories" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_category_links" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "categoryId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_category_unique_idx" ON "book_category_links" USING btree ("bookId", "categoryId");
CREATE INDEX "book_category_book_idx" ON "book_category_links" USING btree ("bookId");
CREATE INDEX "book_category_category_idx" ON "book_category_links" USING btree ("categoryId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_course_links" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "courseId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_course_unique_idx" ON "book_course_links" USING btree ("bookId", "courseId");
CREATE INDEX "book_course_book_idx" ON "book_course_links" USING btree ("bookId");
CREATE INDEX "book_course_course_idx" ON "book_course_links" USING btree ("courseId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_files" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "format" text NOT NULL,
    "storageKey" text NOT NULL,
    "byteSize" bigint NOT NULL,
    "checksum" text NOT NULL,
    "isPrimary" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "book_file_unique_idx" ON "book_files" USING btree ("bookId", "format");
CREATE INDEX "book_file_book_idx" ON "book_files" USING btree ("bookId");
CREATE INDEX "book_file_format_idx" ON "book_files" USING btree ("format");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "books" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "subtitle" text,
    "description" text NOT NULL,
    "isbn" text,
    "publisher" text NOT NULL,
    "publishedYear" bigint NOT NULL,
    "language" text NOT NULL,
    "coverUrl" text,
    "accessType" text NOT NULL,
    "license" text NOT NULL,
    "licenseExpiresAt" timestamp without time zone,
    "keywords" text NOT NULL,
    "searchText" text NOT NULL,
    "popularityScore" bigint NOT NULL,
    "featuredRank" bigint,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "book_title_idx" ON "books" USING btree ("title");
CREATE UNIQUE INDEX "book_isbn_idx" ON "books" USING btree ("isbn");
CREATE INDEX "book_access_type_idx" ON "books" USING btree ("accessType");
CREATE INDEX "book_language_year_idx" ON "books" USING btree ("language", "publishedYear", "id");
CREATE INDEX "book_featured_idx" ON "books" USING btree ("featuredRank");
CREATE INDEX "book_popularity_idx" ON "books" USING btree ("popularityScore", "id");
CREATE INDEX "book_year_cursor_idx" ON "books" USING btree ("publishedYear", "id");
CREATE INDEX "book_created_cursor_idx" ON "books" USING btree ("createdAt", "id");

--
-- ACTION CREATE SEARCH INDEX
--
--
-- ACTION CREATE TABLE
--
CREATE TABLE "favorite_books" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "bookId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "favorite_user_book_idx" ON "favorite_books" USING btree ("userId", "bookId");
CREATE INDEX "favorite_user_idx" ON "favorite_books" USING btree ("userId");
CREATE INDEX "favorite_book_idx" ON "favorite_books" USING btree ("bookId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_authors"
    ADD CONSTRAINT "book_authors_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_authors"
    ADD CONSTRAINT "book_authors_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "authors"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_category_links"
    ADD CONSTRAINT "book_category_links_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_category_links"
    ADD CONSTRAINT "book_category_links_fk_1"
    FOREIGN KEY("categoryId")
    REFERENCES "book_categories"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_course_links"
    ADD CONSTRAINT "book_course_links_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_course_links"
    ADD CONSTRAINT "book_course_links_fk_1"
    FOREIGN KEY("courseId")
    REFERENCES "courses"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_files"
    ADD CONSTRAINT "book_files_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "favorite_books"
    ADD CONSTRAINT "favorite_books_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260908075418239-phase05-library-catalog', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260908075418239-phase05-library-catalog', "timestamp" = now();

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
