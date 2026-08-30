---
phase: 5
title: "Library catalog + access policy (05a)"
status: pending
priority: P1
effort: M
dependencies: [4]
---

# Phase 5a: Library catalog + access policy

## Overview

Nửa một Library của phase-05 gốc theo Kongming C4: catalog/search/filter/book detail + **BookAccessPolicyService là authority duy nhất**. Lending tách sang 05b để concurrency được test kỹ.

## Requirements

- Functional: Explore (featured/recent/recommended/popular/related-to-courses); search theo title/author/keyword/category/ISBN/course tag; filters (PDF/EPUB, language, category, author, year, access type); book detail đủ metadata §18; action buttons theo access type — `metadataOnly` ⇒ **không có nút Read**, hiện message "Tài liệu này hiện chỉ có thông tin tham khảo."; favorite toggle.
- Non-functional: search debounce 300–500ms client + hủy kết quả stale; **pagination cursor server-side** (không load all rồi filter); ảnh cover cache + placeholder + error; role student/lecturer/librarian/admin thấy đúng action.

## Architecture

- `enum BookAccessType { publicFullText, authenticatedFullText, borrowRequired, metadataOnly, restricted }` (§19).
- `BookAccessPolicyService` (server) — rule 3: authority DUY NHẤT; input = user (session) + book; output = quyền read/download/borrow + lý do; xét role, active status, loan status, license, expiration.
- Tables: `authors`, `book_categories`, `books`, `book_authors`, `book_category_links`, `book_files`, `book_course_links`, `favorite_books` (UNIQUE(user_id, book_id)); index title search (pg_trgm hoặc full-text), (book_id) trên các bảng link.
- APIs: `library/search|explore|getBookDetail|toggleFavorite` — trả DTO, không expose raw DB (§38).

## Related Code Files

- Create: migrations + `server/src/library/` (repositories, access policy service, search endpoint), seed 30 books public-domain/tự tạo + authors/categories/course links, mobile `features/library/**` (explore, search, filters sheet, book card, book detail), `core/widgets/AppSearchBar`.
- Test: policy matrix test (mỗi access type × mỗi role × active/inactive × có/không loan), search pagination + stale-result test, widget test book card + metadataOnly state.

## Implementation Steps

1. Migration library schema + index search; commit `feat(library): implement book catalog domain`.
2. Seed 30 sách public-domain/tự tạo (README ghi rõ sample content §55) + link với courses phase-03.
3. `BookAccessPolicyService` + policy matrix tests **trước** khi UI dùng; commit `feat(library): enforce book access policies` + `test(library): add access policy tests`.
4. Search API cursor pagination + filters server-side; commit `feat(library): implement library search and filters`.
5. Flutter Explore + Search (debounce + cancel stale + infinite scroll) + Filters; commit theo nhóm.
6. Book detail (metadata + actions theo policy) + favorite; commit `feat(library): implement book details`.
7. Phase exit gates + security re-check: endpoint detail của sách `restricted` trả metadata có kiểm soát, không lộ file URL.

## Success Criteria

- [ ] Policy matrix test PASS: `metadataOnly` không bao giờ trả nút Read/file URL cho role nào; `restricted` chỉ librarian/admin nhìn thấy đúng mức cấu hình.
- [ ] Gõ nhanh 10 ký tự ⇒ chỉ 1 request sau debounce, kết quả stale bị hủy (test PASS).
- [ ] Cuộn 100+ sách seed giả lập ⇒ cursor pagination, không tải toàn bộ (API test PASS).
- [ ] Ảnh cover lỗi ⇒ placeholder + error state, không crash.
- [ ] `flutter analyze`/`dart analyze`/tests PASS.

## Risk Assessment

Full-text search chậm → pg_trgm index + EXPLAIN trong dev; sách trùng tác giả/nhiều category → bảng link chuẩn hoá; lộ signed URL qua detail API → detail không bao giờ trả file URL, URL chỉ mint khi read (phase-06).
