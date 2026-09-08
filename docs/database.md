# CampusMate Database Model

The database is Serverpod-owned. Mobile clients receive DTOs through generated clients and cache selected read models locally with Drift.

## Academic ERD

```mermaid
erDiagram
    STUDENT_PROFILES ||--o{ ENROLLMENTS : owns
    ACADEMIC_YEARS ||--o{ SEMESTERS : contains
    SEMESTERS ||--o{ COURSE_OFFERINGS : schedules
    COURSES ||--o{ COURSE_OFFERINGS : opens
    COURSE_OFFERINGS ||--o{ COURSE_SCHEDULES : meets
    COURSE_OFFERINGS ||--o{ EXAM_SCHEDULES : assesses
    COURSE_OFFERINGS ||--o{ GRADE_COMPONENTS : defines
    COURSE_OFFERINGS ||--o{ ENROLLMENTS : enrolls
    ENROLLMENTS ||--o{ STUDENT_GRADES : records

    STUDENT_PROFILES {
        int id PK
        int authUserId
        string studentCode
    }

    ACADEMIC_YEARS {
        int id PK
        string code
        datetime startsAt
        datetime endsAt
    }

    SEMESTERS {
        int id PK
        int academicYearId FK
        string code
        datetime startsAt
        datetime endsAt
    }

    COURSES {
        int id PK
        string code
        string title
        int credits
    }

    COURSE_OFFERINGS {
        int id PK
        int courseId FK
        int semesterId FK
        string section
        string lecturerName
    }

    ENROLLMENTS {
        int id PK
        int studentProfileId FK
        int offeringId FK
        string status
    }

    COURSE_SCHEDULES {
        int id PK
        int offeringId FK
        int weekday
        datetime startsAt
        datetime endsAt
    }

    EXAM_SCHEDULES {
        int id PK
        int offeringId FK
        datetime startsAt
        datetime endsAt
        string room
    }

    GRADE_COMPONENTS {
        int id PK
        int offeringId FK
        string name
        double weight
    }

    STUDENT_GRADES {
        int id PK
        int enrollmentId FK
        string componentName
        double score
    }
```

## Dashboard And Notifications

```mermaid
erDiagram
    STUDENT_PROFILES ||--o{ CAMPUS_NOTIFICATIONS : receives
    COURSE_OFFERINGS ||--o{ CAMPUS_NOTIFICATIONS : targets_course
    EXAM_SCHEDULES ||--o{ CAMPUS_NOTIFICATIONS : targets_exam

    STUDENT_PROFILES {
        int id PK
        uuid authUserId
    }

    ANNOUNCEMENTS {
        int id PK
        string audience
        datetime publishAt
        datetime expiresAt
        bool archived
    }

    CAMPUS_NOTIFICATIONS {
        int id PK
        uuid userId
        string category
        string targetType
        int targetId
        datetime readAt
        datetime createdAt
    }
```

## Data Rules

- Academic rows are demo data only. They are intentionally fake and must not imply an official university integration.
- Foreign keys are explicit in the Serverpod schema and generated migration.
- Read APIs scope from `StudentProfile.authUserId`, never from a caller-supplied student id.
- Weekly and daily timetable queries project recurring schedules only inside the semester/course schedule window.
- Grade summaries use `packages/campusmate_shared` so policy changes are tested outside UI code.
- `student_grades.componentName` stores the component label used for the recorded score; the canonical component plan remains attached to the course offering through `grade_components`.
- Dashboard announcements are filtered by audience, publish window, and archive
  state before they reach mobile.
- Notifications support the allowed category set
  `academic/library/system/ai/course/exam`; list pagination is keyset-based by
  `(createdAt, id)` and scoped to the authenticated user.

## Local Cache Shape

```mermaid
flowchart LR
    profile[(CachedAcademicProfiles)]
    timetable[(CachedTimetables)]
    grades[(CachedGrades)]
    key[accountId + weekStart + semester]

    key --> profile
    key --> timetable
    key --> grades
    profile --> snapshot[AcademicSnapshot]
    timetable --> snapshot
    grades --> snapshot
```

The Drift cache is replaced transactionally after a successful server refresh. Logout or account switch must never read another account's cached rows.
