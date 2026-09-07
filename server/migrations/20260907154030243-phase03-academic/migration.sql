BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "academic_years" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "academic_year_code_idx" ON "academic_years" USING btree ("code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course_offerings" (
    "id" bigserial PRIMARY KEY,
    "courseId" bigint NOT NULL,
    "semesterId" bigint NOT NULL,
    "section" text NOT NULL,
    "lecturerName" text NOT NULL,
    "room" text
);

-- Indexes
CREATE INDEX "offering_course_semester_idx" ON "course_offerings" USING btree ("courseId", "semesterId");
CREATE INDEX "offering_semester_idx" ON "course_offerings" USING btree ("semesterId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "course_schedules" (
    "id" bigserial PRIMARY KEY,
    "offeringId" bigint NOT NULL,
    "weekday" bigint NOT NULL,
    "startMinute" bigint NOT NULL,
    "endMinute" bigint NOT NULL,
    "room" text NOT NULL,
    "campus" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "status" text NOT NULL
);

-- Indexes
CREATE INDEX "schedule_offering_idx" ON "course_schedules" USING btree ("offeringId");
CREATE INDEX "schedule_weekday_idx" ON "course_schedules" USING btree ("weekday", "startMinute");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "courses" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "credits" bigint NOT NULL,
    "faculty" text NOT NULL,
    "department" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "course_code_idx" ON "courses" USING btree ("code");
CREATE INDEX "course_title_idx" ON "courses" USING btree ("title");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "enrollments" (
    "id" bigserial PRIMARY KEY,
    "studentProfileId" bigint NOT NULL,
    "offeringId" bigint NOT NULL,
    "status" text NOT NULL,
    "progressPercent" double precision NOT NULL,
    "attendancePercent" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "enrollment_student_offering_idx" ON "enrollments" USING btree ("studentProfileId", "offeringId");
CREATE INDEX "enrollment_student_idx" ON "enrollments" USING btree ("studentProfileId");
CREATE INDEX "enrollment_offering_idx" ON "enrollments" USING btree ("offeringId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exam_schedules" (
    "id" bigserial PRIMARY KEY,
    "offeringId" bigint NOT NULL,
    "examType" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "room" text NOT NULL,
    "notes" text
);

-- Indexes
CREATE INDEX "exam_offering_idx" ON "exam_schedules" USING btree ("offeringId");
CREATE INDEX "exam_starts_at_idx" ON "exam_schedules" USING btree ("startsAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "grade_components" (
    "id" bigserial PRIMARY KEY,
    "offeringId" bigint NOT NULL,
    "name" text NOT NULL,
    "weight" double precision NOT NULL,
    "maxScore" double precision NOT NULL
);

-- Indexes
CREATE INDEX "grade_component_offering_idx" ON "grade_components" USING btree ("offeringId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "semesters" (
    "id" bigserial PRIMARY KEY,
    "academicYearId" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "isCurrent" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "semester_code_idx" ON "semesters" USING btree ("code");
CREATE INDEX "semester_current_idx" ON "semesters" USING btree ("isCurrent");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_grades" (
    "id" bigserial PRIMARY KEY,
    "enrollmentId" bigint NOT NULL,
    "componentName" text NOT NULL,
    "weight" double precision NOT NULL,
    "score" double precision NOT NULL,
    "maxScore" double precision NOT NULL,
    "letter" text,
    "gradedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "student_grade_enrollment_component_idx" ON "student_grades" USING btree ("enrollmentId", "componentName");
CREATE INDEX "student_grade_enrollment_idx" ON "student_grades" USING btree ("enrollmentId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "course_offerings"
    ADD CONSTRAINT "course_offerings_fk_0"
    FOREIGN KEY("courseId")
    REFERENCES "courses"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "course_offerings"
    ADD CONSTRAINT "course_offerings_fk_1"
    FOREIGN KEY("semesterId")
    REFERENCES "semesters"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "course_schedules"
    ADD CONSTRAINT "course_schedules_fk_0"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "enrollments"
    ADD CONSTRAINT "enrollments_fk_0"
    FOREIGN KEY("studentProfileId")
    REFERENCES "student_profiles"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "enrollments"
    ADD CONSTRAINT "enrollments_fk_1"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "exam_schedules"
    ADD CONSTRAINT "exam_schedules_fk_0"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "grade_components"
    ADD CONSTRAINT "grade_components_fk_0"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "semesters"
    ADD CONSTRAINT "semesters_fk_0"
    FOREIGN KEY("academicYearId")
    REFERENCES "academic_years"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "student_grades"
    ADD CONSTRAINT "student_grades_fk_0"
    FOREIGN KEY("enrollmentId")
    REFERENCES "enrollments"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR campusmate
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('campusmate', '20260907154030243-phase03-academic', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260907154030243-phase03-academic', "timestamp" = now();

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
