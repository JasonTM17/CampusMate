---
phase: 3
title: "Academic (courses, timetable, grades, exams, progress)"
status: pending
priority: P1
effort: L
dependencies: [2]
---

# Phase 3: Academic

## Overview

Khối học tập cho student: courses, timetable (week/day), grades + **GpaCalculator domain service**, exam schedule + countdown, academic progress, kèm seed dữ liệu demo và offline **pull-cache**.

## Requirements

- Functional: xem môn học + detail (description, lecturer, schedule, documents placeholder, grade breakdown, related books placeholder, Ask AI placeholder — các placeholder này chỉ render khi phase sau có dữ liệu, không nút chết §82); timetable week+day với prev/next/today + chỉ lớp đang diễn ra; xử lý trùng lịch/hủy/đổi phòng; grades theo học kỳ selector + GPA kỳ + tích lũy; exams upcoming + countdown; progress theo block curriculum (seed demo, không giả định chương trình HCMUTE).
- Non-functional: timezone-safe timestamps; date utilities dùng chung; offline = cache server-authoritative (profile/timetable/grades hiện tại) qua Drift; mọi màn hình có loading/skeleton/empty/error/retry (§79).

## Architecture

- Tables: `academic_years`, `semesters`, `courses`, `course_offerings`, `enrollments`, `course_schedules`, `exam_schedules`, `grades`, `grade_components`; index theo semester/course_code; FK rõ.
- **`GpaCalculator` nằm ở domain, pure Dart (rule 4)**, grading policy inject được (không hard-code ở UI — §14); unit test nhiều policy.
- APIs: `courses/getMyCourses|getCourseDetail`, `timetable/getWeekly|getDaily`, `grades/getBySemester|getCumulative`, `exams/getUpcoming`, `progress/getCurriculumProgress`.
- Drift cache tables mirror + đánh dấu `syncedAt`; chiến lược: mở app → render cache → refresh server → cập nhật.

## Related Code Files

- Create: migrations + `server/src/{academic,timetable,grades,exams,progress}/`, `packages/shared_models` (course/grade/exam models), seed curriculum + 15 courses/25 offerings/grades/schedules/exams (tên Việt giả), mobile `features/{academics,timetable,courses,grades,exams}`, `core/storage` (Drift schema + cache repos), `core/utils/date_utils.dart`, domain `GpaCalculator`.
- Test: `GpaCalculator` (3+ grading policies, edge 0 tín chỉ/F/D), timetable conflict logic, date utils timezone, widget tests grades + exam countdown.

## Implementation Steps

1. Migration academic schema + index; commit `feat(academic): add semester and course models`.
2. Seed semesters/courses/offerings/enrollments/schedules/exams/grades (fake rõ ràng); commit `chore(server): seed academic demo data`.
3. `GpaCalculator` + unit tests trước khi UI dùng; commit `feat(grades): add GPA calculation domain service` + `test(grades): add GPA calculation tests`.
4. APIs academic (đã check role + isolation từ phase-02); commit theo nhóm.
5. Timetable week/day views + logic đổi tuần/lớp hiện tại; commit `feat(timetable): implement student timetable`.
6. Grades screen (semester selector, GPA cards, breakdown per course) + Exams (list + countdown + exam detail) + Progress (credits theo block + %); commits `feat(grades)…`, `feat(exams): implement exam schedule`, `feat(progress): implement academic progress`.
7. Drift pull-cache cho profile/timetable/grades/notifications-đối tượng; trạng thái online/offline hiển thị; commit `feat(offline): cache student academic data`.
8. Widget/unit tests các state rỗng ("No grades yet", "Empty timetable") — §79; phase exit gates như phase-02.

## Success Criteria

- [ ] Student thấy đúng courses/timetable/grades/exams của chính mình (isolation vẫn PASS trên endpoint mới).
- [ ] Đổi grading policy trong test ⇒ GPA đổi theo, không sửa UI (chứng minh không hard-code).
- [ ] Week/day navigation + "current class" đúng theo múi giờ máy; lịch trùng hiển thị được cả hai.
- [ ] Offline: máy bay → mở app vẫn thấy timetable/grades từ cache, có badge offline.
- [ ] `flutter analyze`/`dart analyze`/tests PASS; empty/error state có test.

## Risk Assessment

Timezone bug lịch học → date utilities tập trung + test múi giờ; seed data thiếu thực → đủ số lượng §54 nhưng ghi rõ demo; N+1 query khi join offerings → query có eager join, kiểm bằng log query trong test.
