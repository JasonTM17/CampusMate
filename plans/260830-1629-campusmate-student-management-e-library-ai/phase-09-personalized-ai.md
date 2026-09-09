---
phase: 9
title: "Personalized AI (context builder, memory, preferences)"
status: completed
priority: P2
effort: M
dependencies: [8]
---

# Phase 9: Personalized AI

## Overview

AI hiểu từng sinh viên qua `StudentContextBuilder` phía server (§27) — least-data principle, không dump DB vào prompt; long-term memory do user kiểm soát (§28); isolation chéo sinh viên được test nghiêm (§25).

## Requirements

- Functional: context 7 lớp (Identity/Academic/Schedule/Library/Preference/Conversation/RetrievedKnowledge); chat trả lời đúng context hiện tại (ví dụ §77: biết exam sắp tới, môn đang học); dashboard AI suggestion card **wire thật** (thoả Điều kiện 3 của Kongming); Book chat "Ask AI" gửi selected text + nearby authorized content + metadata, KHÔNG gửi cả ebook (§78); AI Memory: view/remove/disable + personalization ON/OFF.
- Non-functional: chỉ đưa dữ liệu cần thiết vào prompt; không tự lưu secret (blocklist); preferences (kiểu giải thích) lưu riêng và inject.

## Architecture

- `StudentContextBuilder` (server, pure Dart core): nhận session user → thu thập qua repository interface → build `StudentAiContext` (currentCourses, upcomingExams, currentBooks+progress, preferences); mỗi lớp context có budget token riêng.
- `ai_user_memories` (userId, content, source, createdAt, disabledAt); ghi nhớ chỉ khi: hữu ích cho học tập + pass blocklist (password/token/payment/auth data) + personalization ON.
- Book chat endpoint: input = {bookId, location, selectedText}; server tự lấy nearby authorized content (qua policy + chunk từ phase-10 — trước phase-10 dùng metadata + selected text).
- Dashboard suggestion: endpoint build prompt nhỏ từ context (exam gần nhất + môn yếu) — render card thật ở dashboard (wire thay empty state phase-04).

## Related Code Files

- Create: `server/src/ai/context/` (builder + providers từng lớp), `server/src/ai/memory/`, endpoints `ai/*Context|memory/*`, mobile: Settings > AI Memory, dashboard suggestion card, book chat entry từ Book Detail + Reader.
- Test: context isolation (context sinh viên A KHÔNG xuất hiện trong prompt của B — assert trên request gửi provider bằng FakeAiProvider capturing), memory CRUD + blocklist + disable, book chat chỉ chứa selected text + metadata (assert payload size/keys), suggestion card từ exam thật của user.

## Implementation Steps

1. Context builder + từng context provider + budget; commit `feat(ai): build personalized student context`.
2. Preferences (explanation style) + settings UI; commit `feat(ai): add student AI preferences`.
3. Memory service + Settings AI Memory (view/remove/disable) + blocklist; commit `feat(ai): implement user-controlled AI memory`.
4. Dashboard suggestion wire + Book chat entry; commits `feat(ai): add book-aware assistant context`, `feat(dashboard): wire AI suggestion card`.
5. Isolation tests (Wukong gate phase-09: "context A không lẫn vào B"); commit `test(ai): verify student context isolation`.
6. Phase exit gates.

## Success Criteria

- [x] Hai student khác nhau hỏi cùng câu ⇒ prompt context khác nhau đúng dữ liệu từng người (capturing test PASS).
- [x] Prompt KHÔNG chứa: dữ liệu sinh viên khác, secret-pattern (blocklist test PASS).
- [x] AI Memory xoá hết → prompt không còn memory; personalization OFF → context rút gọn còn tối thiểu (test PASS).
- [x] Book chat payload không chứa toàn văn sách (size assertion PASS).
- [x] Dashboard card hiển thị exam thật của user, biến mất khi không có exam (empty state test PASS).
- [x] `dart analyze`/tests PASS.

## Risk Assessment

Context phình to → token budget per lớp + test giới hạn; memory lưu nhạy cảm → blocklist + test pattern; leak chéo user → capturing provider test mọi endpoint context; UI chờ context → builder chạy server-side, mobile chỉ nhận result.
