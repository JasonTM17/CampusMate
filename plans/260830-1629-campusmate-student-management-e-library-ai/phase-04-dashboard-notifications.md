---
phase: 4
title: "Dashboard + Notifications"
status: pending
priority: P1
effort: M
dependencies: [3]
---

# Phase 4: Dashboard + Notifications

## Overview

Dashboard có giá trị sử dụng thật (§11) + notification center với deep link đúng đích. Card chưa có dữ liệu (continue-reading, AI suggestion) phải **render empty/omitted, không fake** (Kongming C3) — wire thật ở phase-06/08.

## Requirements

- Functional dashboard: greeting theo giờ (`Chào buổi chiều, Minh 👋`), next class, academic summary (GPA/tín chỉ tích lũy/tín chỉ kỳ này), today's classes, upcoming exam + countdown, announcements. Continue-reading + AI suggestion: state rỗng chuẩn, wire ở P06/P08.
- Notifications: 6 category (academic/library/system/ai/course/exam), unread count, mark read / mark all, deep link (notification lịch thi mở đúng `ExamDetail`).
- Non-functional: mỗi section độc lập loading/empty/error (1 section lỗi không sập dashboard); Riverpod provider scoped đúng (§58); notification list cursor pagination (§48).

## Architecture

- API `dashboard/getOverview` trả từng section riêng caller-side song song (tránh 1 query khổng lồ); `notifications/*` (list cursor, unreadCount, markRead, markAllRead).
- Tables: `announcements` (audience, publishAt, archived), `notifications` (userId, category, entityType, entityId, readAt); index (user_id, read_at), (user_id, created_at desc).
- Deep link: go_router route `exams/:id` v.v. — notification chứa entityType+entityId, app map sang route; route guard vẫn qua auth.

## Related Code Files

- Create: `server/src/{dashboard,notifications,announcements}/`, migrations, mobile `features/dashboard/**`, `features/notifications/**`, `core/widgets/` (AppSkeleton, AppEmptyState, AppErrorState, AppSectionHeader — extract khi thật sự reuse, §41).
- Test: widget test dashboard states, deep-link routing test, notification mark-read logic test, cursor pagination test.

## Implementation Steps

1. Migration notifications/announcements + index; commit `feat(notification): implement student notifications`.
2. Notification APIs + seed vài notification cho student001; mark read/all.
3. Dashboard APIs đọc từ academic phase-03; announcements seed.
4. Flutter dashboard: section widgets + skeleton/empty/error/retry; commit `feat(dashboard): implement personalized student dashboard`.
5. Notification center UI (badge unread, filter category) + deep link wiring; commit `feat(notification): add notification deep links`.
6. Tests: bấm notification exam → `ExamDetail` đúng id; unread count cập nhật; pagination cuộn; phase exit gates.

## Success Criteria

- [ ] Dashboard hiển thị đủ section từ seed; tắt server → từng section báo lỗi riêng + retry, không white screen.
- [ ] Continue-reading/AI suggestion ở state rỗng rõ ràng (không có nút chết).
- [ ] Deep link exam notification mở đúng ExamDetail (test PASS).
- [ ] Cursor pagination không tải lại trang cũ khi cuộn (test PASS).
- [ ] `flutter analyze`/tests PASS.

## Risk Assessment

Dashboard rebuild lan → provider per-section, test `rebuild` đếm; announcement chưa tới giờ publish → filter ở query; deep link khi app tắt (cold start) → xử lý trong router init, test riêng.
