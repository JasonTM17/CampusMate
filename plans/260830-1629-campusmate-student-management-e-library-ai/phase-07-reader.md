---
phase: 7
title: "Ebook Reader (PDF/EPUB, progress, annotations, offline)"
status: completed
priority: P1
effort: L
dependencies: [6]
---

# Phase 7: Ebook Reader

## Overview

Reader theo vertical slice chạy thật (§81): Book Detail → Access Check → mở PDF/EPUB → save progress → resume, rồi annotations + offline. **Kongming review gate CHẠY TRƯỚC KHI implement** (offline-download/signed-URL/reader data flow — bảng Execution Review Gates).

## Requirements

- Functional: `ReaderController` abstraction (`open/goTo/saveProgress`); PDF = `pdfrx`; EPUB = `flutter_epub_viewer` (WebView — path chính, Wukong evidence); progress + `Continue from 65%?`; bookmark/note/highlight; EPUB font size + theme light/dark/sepia; TOC; search-in-book chỉ khi package hỗ trợ — không fake; orientation.
- Non-functional: progress sync LWW theo `updatedAt` — **đường client-write sync DUY NHẤT** của app (Kongming C5); offline download chỉ khi policy cho phép; signed URL short-TTL, mint server-side, không log/persist URL vĩnh viễn; re-check policy khi mở file cached.
- **Spike đầu phase** (Wukong residual): mở 1 PDF + 1 EPUB public-domain trên Android emulator; đo granularity highlight EPUB; document limitation thật thay vì fake (§21/§82).

## Architecture

- Tables: `reading_progress` (UNIQUE(user_id, book_id), progressPercent, currentLocation, updatedAt), `bookmarks`, `reader_notes`, `highlights` (§23; màu = semantic token, không hex tuỳ ý).
- Conflict rule: offline queue lưu pending progress có `updatedAt` local; khi sync, giữ bản `updatedAt` mới hơn; kết quả cuối luôn là bản server có `updatedAt` max; **quy tắc được document + unit test** (§22).
- Offline: tải file qua signed URL ngắn hạn về storage riêng app; metadata cached (Drift); mở offline → `BookAccessPolicyService` re-check trạng thái license/loan lần cuối server khi còn online, cache verdict có TTL ngắn.
- ADR-006: EPUB WebView + giới hạn highlight; ADR-007: LWW sync + outbox.

## Related Code Files

- Create: `apps/mobile/lib/features/reader/**` (reader_controller.dart + pdf_reader/ + epub_reader/ + annotations UI), `core/storage` (progress/annotation cache + outbox), `server/src/reader/` (progress sync, annotations, signed-URL mint), migrations; sample books 2 file public-domain.
- Test: progress save/resume roundtrip, LWW conflict unit (cũ/mới/offline queue), annotation CRUD, access-denied offline mở sách không có quyền, log-scrub test (không signed URL trong log).

## Implementation Steps

1. Kongming review gate (offline/signed-URL flow) → ghi điều kiện vào ledger.
2. Spike pdfrx + flutter_epub_viewer với sample thật trên emulator; chốt + pin version; ADR-006; commit `feat(reader): add reader abstraction` (chỉ khi spike đạt).
3. PDF reader + progress; commit `feat(reader): implement PDF reading`.
4. EPUB reader + font/theme/TOC; commit `feat(reader): implement EPUB reading`.
5. Progress persist + resume dialog + LWW sync server + outbox; commits `feat(reader): persist reading progress`, `feat(reader): synchronize reader progress`.
6. Bookmarks/notes/highlights UI + storage; commit `feat(reader): add bookmarks and notes`.
7. Offline download theo policy + re-check + log scrub; commit `feat(offline): add offline ebook downloads with access re-check`.
8. Tests + phase exit gates; commit `test(reader): add reading progress tests`.

## Success Criteria

- [x] Mở PDF thật + EPUB thật trên emulator; đóng app mở lại → resume đúng trang/locations (test PASS).
- [x] Sửa progress offline rồi online ⇒ bản mới hơn thắng; sửa 2 nơi ⇒ `updatedAt` max thắng (unit test PASS).
- [x] metadataOnly/restricted: không tải được file; loan hết hạn: mở offline bị chặn khi re-check (test PASS).
- [x] Log không chứa signed URL/token (log-scrub test PASS).
- [x] Limitation EPUB highlight được ghi rõ trong ADR-006 + README (không fake chức năng).

## Risk Assessment

EPUB single-maintainer dependency → abstraction `ReaderController` cô lập, thay được engine; pdfrx Windows Developer Mode → đã ghi prerequisites phase-01; highlight EPUB granularity thấp → giới hạn ở chapter-level, ghi limitation; signed URL leak → TTL ngắn + scrub test.
