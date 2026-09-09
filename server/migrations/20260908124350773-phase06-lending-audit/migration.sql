BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_logs" (
    "id" bigserial PRIMARY KEY,
    "actorUserId" uuid NOT NULL,
    "action" text NOT NULL,
    "resourceType" text NOT NULL,
    "resourceId" text NOT NULL,
    "metadataJson" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "audit_actor_created_idx" ON "audit_logs" USING btree ("actorUserId", "createdAt", "id");
CREATE INDEX "audit_resource_created_idx" ON "audit_logs" USING btree ("resourceType", "resourceId", "createdAt", "id");
CREATE INDEX "audit_action_created_idx" ON "audit_logs" USING btree ("action", "createdAt", "id");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_copies" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "barcode" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "book_copy_book_status_idx" ON "book_copies" USING btree ("bookId", "status", "id");
CREATE UNIQUE INDEX "book_copy_barcode_idx" ON "book_copies" USING btree ("barcode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_loans" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "bookId" bigint NOT NULL,
    "copyId" bigint NOT NULL,
    "borrowedAt" timestamp without time zone NOT NULL,
    "dueAt" timestamp without time zone NOT NULL,
    "returnedAt" timestamp without time zone,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "book_loan_user_status_due_idx" ON "book_loans" USING btree ("userId", "status", "dueAt", "id");
CREATE INDEX "book_loan_book_status_due_idx" ON "book_loans" USING btree ("bookId", "status", "dueAt", "id");
CREATE INDEX "book_loan_copy_status_idx" ON "book_loans" USING btree ("copyId", "status", "id");
CREATE UNIQUE INDEX "book_loans_active_copy_idx" ON "book_loans" USING btree ("copyId") WHERE "status" IN ('borrowed', 'overdue');

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_copies"
    ADD CONSTRAINT "book_copies_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_loans"
    ADD CONSTRAINT "book_loans_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_loans"
    ADD CONSTRAINT "book_loans_fk_1"
    FOREIGN KEY("copyId")
    REFERENCES "book_copies"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260908124350773-phase06-lending-audit', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260908124350773-phase06-lending-audit', "timestamp" = now();

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
