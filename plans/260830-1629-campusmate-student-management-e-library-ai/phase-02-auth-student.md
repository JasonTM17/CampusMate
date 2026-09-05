---
phase: 2
title: "Auth + Student + RBAC"
status: in-progress
priority: P1
effort: M
dependencies: [1]
---

# Phase 2: Auth + Student + RBAC

## Overview

Authentication hoàn chỉnh + RBAC 4 role kiểm quyền ở SERVER + student profile, kèm **bộ test isolation nền tảng** (A không bao giờ đọc được B) — cơ sở cho mọi phase sau.

## Requirements

- Functional: login/logout/refresh/session restore/forgot-password architecture (seam, chưa gửi mail); protected routes; role-aware navigation; profile xem/sửa field được phép.
- Non-functional: token lưu `flutter_secure_storage`; mọi endpoint authorization server-side; seed password chỉ trong seed script dev + README cảnh báo local-only.

## Architecture

- **ADR-005 (quyết ở đây)**: chọn 1 thế hệ auth Serverpod — ưu tiên `serverpod_auth_core` (3.x identity provider + scopes + token refresh); spike nhỏ rồi pin. Legacy `serverpod_auth_email` chỉ dùng nếu module mới thiếu requirement bắt buộc.
- Tables: `users`, `roles`, `user_roles`, `student_profiles` (đủ field §10: studentCode…conductScore), `faculties`, `majors`, `programs` (seed tối thiểu).
- Endpoints: `auth/*` (login, refresh, logout, me), `studentProfile/getMyProfile|updateMyProfile`. Identity LUÔN lấy từ session; từ chối mọi `userId` từ payload.
- Flutter: `features/auth` (login, session restore khi mở app, route guard), `features/student_profile`, `core/auth` (token store + interceptor).

## Related Code Files

- Create: `server/src/auth/`, `server/src/student/`, migrations tương ứng, `apps/mobile/lib/features/auth/**`, `features/student_profile/**`, `core/auth/**`, seed script `server/migrations/seed` hoặc `server/bin/seed.dart`.
- Test: `server/test/auth_test.dart`, `server/test/student_isolation_test.dart`, `apps/mobile/test/features/auth/`.

## Implementation Steps

1. Spike + ADR-005 chọn auth module generation; pin version; commit `feat(auth): implement backend authentication`.
2. Schema users/roles/user_roles/student_profiles + migration; UNIQUE(email), UNIQUE(student_code); index email/student_code; commit kèm schema.
3. Seed: admin/librarian/student001 `@campusmate.local` + 20 sinh viên fake tên Việt; password dev sinh trong seed script; commit `chore(server): seed development demo accounts`.
4. Endpoints auth + profile với role check server-side (scopes); lỗi trả structure `{code, message}` user-safe (§38), technical log giữ ở server.
5. Flutter login flow + session restore + route guard theo role; commit `feat(auth): implement Flutter login flow`, `feat(auth): restore authenticated session on startup`, `feat(auth): enforce role-aware navigation`.
6. Student profile screen (avatar, MSSV, khoa/ngành/lớp, GPA, tín chỉ, shortcut settings) với loading/error/empty; commit `feat(student): implement student profile screen`.
7. **Security test isolation (Wukong gate)**: với token của A, gọi mọi endpoint kèm id của B (profile, và khung cho grades/notes/conversation sau này) ⇒ 403/404; thêm negative case role sai. Commit `test(auth): add authentication and authorization tests`.
8. Phase exit: format/analyze/test cả hai phía + `ak:test` checkpoint + `ak:code-review` diff phase.

## Success Criteria

- [ ] Login demo student bằng tài khoản seed; kill app → mở lại vẫn giữ session; logout sạch.
- [ ] Student đăng nhập KHÔNG gọi được endpoint admin/librarian (403 có structure).
- [ ] Isolation suite PASS: mọi đường "lấy dữ liệu user khác" trả 403/404, không bao giờ 200.
- [ ] `dart analyze`/`flutter analyze`/tests PASS; secrets scan sạch (`git grep` trên diff cho password/token thật).
- [ ] Wukong verdict phase-02 (claim IDOR) = NOT_FALSIFIED hoặc finding đã fix + retest.

## Risk Assessment

Auth module churn (legacy vs core) → ADR-005 chốt 1 lần + pin; forgot-password chỉ dựng seam để không fake tính năng gửi mail; seed password lộ → chỉ tồn tại trong seed script local, README cảnh báo, không commit secret thật.
