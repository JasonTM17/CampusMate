# CampusMate API Reference

This document outlines the Serverpod API endpoints exposed by `campusmate_server` and consumed by `campusmate_client`.

All endpoints are accessed via Serverpod RPC over HTTP/WebSocket. Requests must include authentication tokens when required.

---

## 1. Authentication & Identity

### `AuthEndpoint`
Provides session authentication and user onboarding.

- `login(String email, String password) -> AuthenticationResponse`
  - Validates credentials against hashed passwords.
  - Returns auth key, user ID, and granted scopes (`campusMateStudentScope`, `campusMateAdminScope`, etc.).
- `register(String email, String password, String studentCode, String fullName) -> AuthenticationResponse`
  - Creates authentication record and default `StudentProfile`.
- `logout() -> void`
  - Terminates caller's session.

---

## 2. Student Profile & Academic

### `StudentProfileEndpoint`
- **Scope required**: `campusMateStudentScope` or `campusMateAdminScope`
- `getMyProfile() -> StudentProfile`
  - Returns caller's profile (student code, name, class, faculty, major, GPA).
- `updateProfile(StudentProfile profile) -> StudentProfile`
  - Updates mutable profile fields (phone, avatar, bio).

### `AcademicEndpoint`
- **Scope required**: `campusMateStudentScope`
- `getOverview() -> AcademicSnapshot`
  - Returns current semester summary, today's schedule, GPA, upcoming exams, and curriculum progress.
- `getCourseDetail(int offeringId) -> CourseDetail`
  - Returns course syllabus, lecturer details, weekly schedules, and grade components.
- `getWeeklyTimetable(DateTime weekStart) -> List<TimetableEntry>`
  - Returns daily timetable entries for the requested week.
- `getGrades() -> GradeSummary`
  - Returns official grades, GPA calculation, and credits earned.

---

## 3. Library & Lending

### `LibraryEndpoint`
- **Scope required**: Public / Student
- `explore({int limitPerSection = 8}) -> LibraryExplore`
  - Returns featured books, new arrivals, recommended reads, and filter facets.
- `search({String? query, String? cursor, int limit = 20, LibraryFilters filters}) -> LibrarySearchPage`
  - Full-text search with debounce and cursor-based pagination.
- `getBookDetail(int bookId) -> BookDetail`
  - Returns metadata, author list, available copies, format list, and user-specific `BookAccessDecision`.

### `LendingEndpoint`
- **Scope required**: `campusMateStudentScope`
- `borrowBook(int bookId) -> BookLoanSummary`
  - Concurrently safe borrowing of an available copy. Creates active loan with 14-day duration.
- `returnLoan(int loanId) -> BookLoanSummary`
  - Marks loan as returned and increments available copies.
- `myLoans({String? cursor, int limit = 20, bool activeOnly = true}) -> BookLoanPage`
  - Returns current active or historical loans for the student.

---

## 4. Digital Ebook Reader

### `ReaderEndpoint`
- **Scope required**: `campusMateStudentScope`
- `getReaderAsset({required int bookId, required String format}) -> ReaderAsset`
  - Validates `BookAccessPolicyService`. Returns short-lived signed asset URL (PDF or EPUB).
- `syncProgress({required int bookId, required double progressPercent, required String currentLocation, required DateTime clientUpdatedAt}) -> ReadingProgressSyncResult`
  - Last-Write-Wins (LWW) synchronized reading progress.
- `getProgress({required int bookId}) -> ReadingProgress?`
  - Returns latest synced position.
- `addBookmark({required int bookId, required String location, required String title}) -> ReaderBookmark`
- `getBookmarks({required int bookId}) -> List<ReaderBookmark>`
- `saveNote({required int bookId, required String location, required String content, int? noteId}) -> ReaderNote`
- `addHighlight({required int bookId, required String location, required String text, required String colorToken}) -> ReaderHighlight`

---

## 5. AI Assistant & RAG

### `AiEndpoint`
- **Scope required**: `campusMateStudentScope`
- `createConversation({required String title}) -> ConversationSummary`
  - Creates a new isolated chat thread for the user.
- `listConversations() -> List<ConversationSummary>`
  - Lists user's conversations ordered by last active.
- `getMessages(int conversationId) -> List<ChatMessage>`
  - Retrieves chronological messages for conversation.
- `sendMessage({required int conversationId, required String userMessage, int? bookId, String? selectedText}) -> Stream<String>`
  - Streams AI response chunks over WebSocket. Enforces daily quotas and performs RAG context augmentation.
- `getStudySuggestion() -> StudySuggestion?`
  - Synthesizes student timetable, upcoming exams, and recent reading into proactive study tips.
- `getPreferences() -> StudentAiPreference`
- `updatePreferences({required String explanationStyle, required bool personalizationEnabled, required bool memoryEnabled}) -> StudentAiPreference`

---

## 6. Administration & Privileged Operations

### `AdminEndpoint`
- **Scope required**: `campusMateAdminScope`
- `createStudent(...) -> StudentProfile`
  - Onboards new student and records `ADMIN_CREATE_STUDENT` audit log.
- `updateStudent(...) -> StudentProfile`
  - Modifies student profile/academic standing and logs `ADMIN_UPDATE_STUDENT`.
- `listStudents(...) -> AdminStudentListPage`
  - Paginated student catalog with search and filtering.
- `listAuditLogs({String? action, String? resourceType, int limit = 50}) -> AdminAuditLogPage`
  - Reads append-only immutable audit trail.
- `requestBookUploadTicket(...) -> BookUploadTicket`
  - Validates file format/size and grants presigned upload ticket.
- `createAnnouncement(...) -> CampusNotificationSummary`
  - Broadcasts announcement to students or campus-wide.
