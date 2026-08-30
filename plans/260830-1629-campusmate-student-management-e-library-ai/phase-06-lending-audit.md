---
phase: 6
title: "Lending (borrow/return) + audit write path (05b)"
status: pending
priority: P1
effort: M
dependencies: [5]
---

# Phase 5b: Lending + audit write path

## Overview

Nửa hai phase-05 gốc (Kongming C4): borrow/return transaction-safe + **đưa `audit_logs` và AuditService về đây** — mutation đặc quyền đầu tiên của hệ thống được audit từ phase này (admin read UI vẫn ở phase-10).

## Requirements

- Functional: borrow/return cho sách `borrowRequired`; loan status `AVAILABLE/BORROWED/OVERDUE/RETURNED` theo **bản sao (copy)**; `borrowedAt/dueAt` do SERVER quyết (không tin client time §20); danh sách "Sách của tôi" + đếm ngày còn lại; librarian thấy loans đang active của sách mình quản lý.
- Non-functional: 2 request borrow song song cùng 1 copy ⇒ **đúng 1 loan thành công**; audit ghi tối thiểu `LIBRARIAN_CHANGE_ACCESS_POLICY`, `ADMIN_*` khung sẵn; metadata audit không chứa password/token (§52).

## Architecture

- Tables: `book_copies` (một book có N copy), `book_loans` (id, userId, copyId, borrowedAt, dueAt, returnedAt, status); **partial unique index: chỉ 1 active loan mỗi copy** (`WHERE status IN ('BORROWED','OVERDUE')`); index loans theo user + status + dueAt.
- Borrow flow: 1 DB transaction (Serverpod `session.db.transaction`) — SELECT copy FOR UPDATE → check policy → INSERT loan; **dùng plain SQL/queries trong transaction, tránh `attachRow`** (quirk #2442 — Wukong evidence).
- `AuditService` (rule 5: chỉ nó được ghi audit_logs): `actorUserId, action, resourceType, resourceId, metadata(jsonb), createdAt`; mọi privileged mutation gọi qua đây.
- Job kiểm quá hạn (lazy đánh OVERDUE khi đọc + scheduled note trong docs; không cần cron thật ở dev).

## Related Code Files

- Create: migrations `book_copies`, `book_loans`, `audit_logs`; `server/src/lending/`, `server/src/audit/AuditService`; mobile "My loans" UI trong `features/library/**`; seed copies cho sách borrowRequired.
- Test: `server/test/lending_concurrency_test.dart` (deterministic: 2 futures borrow cùng copy), policy denial test, overdue transition test, audit row assertion.

## Implementation Steps

1. Migration copies/loans/audit_logs + partial unique index; commit `feat(lending): implement book borrowing schema`.
2. Borrow/return endpoints trong transaction + AuditService; commit `feat(lending): implement book borrowing`, `feat(lending): implement book returns`, `feat(audit): log privileged actions`.
3. **Concurrency test deterministic** (Wukong gate phase-05b): 2 borrow đồng thời ⇒ 1 thành công 1 báo "đã được mượn"; test cả return→borrow lại; commit `test(lending): verify concurrent borrowing rules`.
4. Flutter: nút Borrow/Return trong book detail theo policy + "My loans" list (countdown dueAt server-time); empty/error states.
5. Librarian: đổi access policy ⇒ audit row; UI librarian tối thiểu (metadata edit + loans view); admin read UI để phase-10.
6. Phase exit gates + Wukong verdict claim borrow race.

## Success Criteria

- [ ] Concurrency test PASS trên server thật (không mock DB): đúng 1 loan, request kia nhận lỗi nghiệp vụ rõ.
- [ ] Return → copy AVAILABLE lại, borrow tiếp OK; quá hạn tự đánh OVERDUE khi đọc.
- [ ] Mọi mutation đặc quyền trong phase này có audit row (test assert), metadata sạch secret.
- [ ] Client đổi giờ máy không ảnh hưởng dueAt hiển thị (server time).
- [ ] `dart analyze`/tests PASS.

## Risk Assessment

Race condition → unique index là lưới an toàn cuối cùng KỂ CÓ bug app-layer (test cố tình bỏ lock vẫn không tạo 2 loan); Serverpod transaction quirk → plain SQL trong transaction + test thật với Postgres compose; quên audit ở 1 mutation → helper bắt buộc qua service duy nhất.
