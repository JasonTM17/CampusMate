---
phase: 8
title: "AI Core (provider abstraction, streaming chat, quota)"
status: pending
priority: P1
effort: L
dependencies: [7]
---

# Phase 8: AI Core

## Overview

Nền AI đi qua backend 100% (§4): `AiProvider` abstraction + adapter OpenAI-compatible (GLM qua env) + **FakeAiProvider mặc định**; streaming chat, hội thoại persist, quota server-side, prompt-injection baseline. **Streaming spike 30 phút chạy TRƯỚC** khi commit kiến trúc (Wukong recommendation).

## Requirements

- Functional: chat stream token-by-token; conversation list + new chat + suggested prompts (📚 Giải thích bài học / 🧠 Tạo quiz / 📅 Lập kế hoạch học / 📖 Gợi ý sách); stop/regenerate/copy/retry/feedback; markdown + code block + copy code; quota dev 50 messages/day/student (config-driven, không hard-code).
- Non-functional: không block UI thread; optimistic UI + typing state; mọi conversation query có `WHERE user_id = sessionUser` (§31); không log AI key/signed URL; lịch sử chat hiển thị lại được.

## Architecture

- `abstract interface class AiProvider { Stream<AiStreamChunk> streamChat(AiRequest); Future<List<double>> createEmbedding(String); }` — implementation: `OpenAiCompatibleProvider` (AI_BASE_URL/AI_API_KEY/AI_CHAT_MODEL/AI_EMBEDDING_MODEL/AI_PROVIDER qua env server), `FakeAiProvider` (stream giả lập deterministic, **embedding hashing deterministic** để phase-10 test retrieval không cần key).
- Serverpod streaming endpoint (WebSocket) trả `Stream<String>`; spike xác nhận pattern, fallback có chủ đích = SSE/poll chunk nếu WebSocket friction (ghi ADR-008).
- Tables: `ai_conversations`, `ai_messages` (role, content, **`citations jsonb` — shape chuẩn `{documentId, bookId, title, chapter, page}` từ đầu, Kongming C6**), `ai_usage` (userId, date, requestCount, inputTokens, outputTokens, estimatedCost).
- Quota check TRƯỚC context building + trước gọi provider (C6); admin chỉ thấy aggregate usage, không đọc content private (§32).
- Prompt-injection baseline (§30): system prompt khai báo document = reference data; không execute instruction lồng trong tài liệu; không reveal secret; không override authorization; seed corpus có injection fixture để test.

## Related Code Files

- Create: `server/src/ai/` (provider/, endpoints, quota, context placeholder), `.env.example` (tên biến, không giá trị), mobile `features/ai_assistant/**` (chat UI, conversation list, markdown renderer + citation chip placeholder), `packages/shared_models` (AiRequest/AiStreamChunk).
- Test: streaming contract test với FakeAiProvider; quota exhausted test; tenant isolation (A không đọc conversation B — tái chứng minh); injection fixture test (câu lệnh lồng trong fixture KHÔNG đổi hành vi authz); UI widget test markdown/code block/empty/error.

## Implementation Steps

1. Streaming spike (mock provider → stream endpoint → Flutter hiển thị token); ADR-008 chốt pattern; commit `feat(ai): stream assistant responses` (skeleton).
2. AiProvider abstraction + FakeAiProvider + OpenAiCompatibleProvider (chưa cần key thật); commits `feat(ai): introduce AI provider abstraction`, `feat(ai): integrate configurable AI provider`.
3. Conversation/message persistence + endpoints (isolation từ session); commit `feat(ai): add AI conversation persistence`.
4. Chat UI đầy đủ states + quick actions; commit `feat(ai): implement AI chat interface`.
5. Quota `ai_usage` + check server-side + response lỗi thân thiện khi hết quota; commit `feat(ai): implement usage quota`.
6. Injection baseline + fixtures; commit `feat(ai): add prompt injection safeguards`.
7. Phase exit gates (test gates + code-review).

## Success Criteria

- [ ] Chat chạy với FakeAiProvider KHÔNG cần AI key: stream hiện dần, stop/regenerate/copy hoạt động.
- [ ] Đổi env sang OpenAI-compatible endpoint thật (nếu user cấp key) chỉ đổi config, không đổi code (adapter test PASS).
- [ ] Message thứ 51 trong ngày bị chặn bằng lỗi thân thiện; counter reset theo ngày (test PASS).
- [ ] A không đọc được conversation của B (isolation re-test PASS).
- [ ] Injection fixture không khiến assistant thực hiện lệnh lồng (test PASS).
- [ ] `dart analyze`/`flutter analyze`/tests PASS; `.env` không commit, chỉ `.env.example`.

## Risk Assessment

WebSocket streaming friction trên Serverpod/Windows → spike sớm, fallback SSE/polling là thiết kế chứ không phải surprise; chi phí LLM thật → mặc định FakeAiProvider, key thật opt-in; markdown renderer nặng UI → isolate widget + benchmark nhẹ.
