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
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AcademicYear as table academic_years
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
-- Class AiConversation as table ai_conversations
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
-- Class AiMessage as table ai_messages
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
-- Class AiUsage as table ai_usage
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
-- Class Announcement as table announcements
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
-- Class AuditLog as table audit_logs
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
-- Class LibraryAuthor as table authors
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
-- Class LibraryBookAuthor as table book_authors
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
-- Class LibraryCategory as table book_categories
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
-- Class LibraryBookCategory as table book_category_links
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
-- Class BookCopy as table book_copies
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
-- Class LibraryBookCourse as table book_course_links
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
-- Class LibraryBookFile as table book_files
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
-- Class BookLoan as table book_loans
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
-- Class LibraryBook as table books
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
-- Class CampusNotification as table campus_notifications
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
-- Class CourseOffering as table course_offerings
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
-- Class CourseSchedule as table course_schedules
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
-- Class Course as table courses
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
-- Class Enrollment as table enrollments
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
-- Class ExamSchedule as table exam_schedules
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
-- Class FavoriteBook as table favorite_books
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
-- Class GradeComponent as table grade_components
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
-- Class Semester as table semesters
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
-- Class StudentGrade as table student_grades
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
-- Class StudentProfile as table student_profiles
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
-- Class VectorCapabilityProbe as table vector_capability_probe
--
CREATE TABLE "vector_capability_probe" (
    "id" bigserial PRIMARY KEY,
    "embedding" vector(1536) NOT NULL
);

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "nonce", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "book_authors" table
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
-- Foreign relations for "book_category_links" table
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
-- Foreign relations for "book_copies" table
--
ALTER TABLE ONLY "book_copies"
    ADD CONSTRAINT "book_copies_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "book_course_links" table
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
-- Foreign relations for "book_files" table
--
ALTER TABLE ONLY "book_files"
    ADD CONSTRAINT "book_files_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "book_loans" table
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
-- Foreign relations for "course_offerings" table
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
-- Foreign relations for "course_schedules" table
--
ALTER TABLE ONLY "course_schedules"
    ADD CONSTRAINT "course_schedules_fk_0"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "enrollments" table
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
-- Foreign relations for "exam_schedules" table
--
ALTER TABLE ONLY "exam_schedules"
    ADD CONSTRAINT "exam_schedules_fk_0"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "favorite_books" table
--
ALTER TABLE ONLY "favorite_books"
    ADD CONSTRAINT "favorite_books_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "books"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "grade_components" table
--
ALTER TABLE ONLY "grade_components"
    ADD CONSTRAINT "grade_components_fk_0"
    FOREIGN KEY("offeringId")
    REFERENCES "course_offerings"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "semesters" table
--
ALTER TABLE ONLY "semesters"
    ADD CONSTRAINT "semesters_fk_0"
    FOREIGN KEY("academicYearId")
    REFERENCES "academic_years"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "student_grades" table
--
ALTER TABLE ONLY "student_grades"
    ADD CONSTRAINT "student_grades_fk_0"
    FOREIGN KEY("enrollmentId")
    REFERENCES "enrollments"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
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
