---
phase: 11
title: "Admin + Librarian management"
status: pending
priority: P2
effort: M
dependencies: [10]
---

# Phase 11: Admin + Librarian management

## Overview

UI quản trị theo role để demo (§53): admin dashboard aggregates, student management, library management (upload có validation), announcements — mọi endpoint kiểm quyền server-side + audit row cho mutation đặc quyền (AuditService từ phase-06).

## Requirements

- Functional: admin dashboard (total/active students, books, active loans, AI requests today); student list/search/filter/pagination + detail + add/update + activate/deactivate; book management (create metadata, upload file, edit, archive, access policy); announcements (create, target audience, schedule, archive); librarian: metadata sách, upload, access policy, lending admin; admin đọc audit logs (lọc actor/action).
- Non-functional: admin list cursor pagination; mobile là UI demo — **authorization vẫn 100% server-side** (ẩn nút không phải bảo mật §8); upload validation: MIME + extension + max size + ownership; storage key server-generated `books/{bookId}/{uuid}.epub` (không tin filename §51).

## Architecture

- Endpoints `admin/*` (scopes admin), `librarian/*` (scopes librarian) — tái dùng AuditService; announcements publish theo `publishAt` (đã có ở phase-04, thêm quản lý).
- Upload flow: client xin presigned upload URL (short-TTL, metadata ràng buộc) → upload MinIO → server verify (MIME magic bytes/extension/size) → tạo `book_files` row → audit `LIBRARIAN_UPLOAD_BOOK`. Không bao giờ client chỉ định storage key.
- RBAC matrix test mở rộng: librarian KHÔNG gọi được admin/*; student không gọi được cả hai.

## Related Code Files

- Create: `server/src/admin/`, `server/src/librarian/`, migrations (nếu thiếu), mobile `features/admin/**` (dashboard, student mgmt, book mgmt, announcement mgmt, audit viewer), `features/settings/**` bổ sung.
- Test: RBAC matrix (đủ 4 role × nhóm endpoint), upload negative (SAI MIME, quá size, filename `../../evil`, extension giả), activate/deactivate effect ngay trên session hiện hữu, audit assertion từng action, admin aggregates đúng seed.

## Implementation Steps

1. Admin aggregates endpoint + dashboard UI; commit `feat(admin): add admin dashboard`.
2. Student management (list/search/filter/pagination/detail/add/update/activate) + audit `ADMIN_UPDATE_STUDENT`/`ADMIN_DISABLE_USER`; commit `feat(admin): implement student management`.
3. Upload pipeline validation + storage key server-side + librarian book CRUD + access policy + audit; commit `feat(admin): implement library management` + `feat(audit): log privileged administrative actions` (bổ sung action list).
4. Announcement management; commit `feat(admin): implement announcements management`.
5. Audit viewer (admin) + phân trang; RBAC matrix tests; phase exit gates.

## Success Criteria

- [ ] RBAC matrix PASS: mỗi role chỉ tới endpoint được phép; deactivate student ⇒ session tiếp theo bị chặn đúng.
- [ ] Upload `evil.pdf` giả đuôi `.epub` bị chặn; filename traversal không ảnh hưởng storage key (test PASS).
- [ ] Mỗi mutation đặc quyền có audit row đúng actor/action/resource (assert PASS).
- [ ] Admin dashboard số liệu khớp seed (test PASS).
- [ ] `dart analyze`/tests PASS.

## Risk Assessment

Upload abuse → validation 3 lớp + size cap + key server; quên check role ở endpoint mới → matrix test chạy mọi endpoint đăng ký; announcement publish giờ tương lai → query lọc publishAt, test lệch múi giờ.
