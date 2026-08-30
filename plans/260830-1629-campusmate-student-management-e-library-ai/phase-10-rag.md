---
phase: 10
title: "RAG (ingestion, pgvector, authorized retrieval, citations)"
status: pending
priority: P2
effort: L
dependencies: [9]
---

# Phase 10: RAG

## Overview

Pipeline RAG (§29) với bất biến số 1: **authorization xảy ra ở DB-level TRƯỚC khi bất kỳ text nào rời DB tới LLM** (Kongming C7 — predicate cùng SQL với vector search, KHÔNG Dart post-filter). Test âm bắt buộc: restricted doc không bao giờ được retrieve.

## Requirements

- Functional: ingestion (text extraction từ sample authorized docs → chunking size/overlap config → embedding qua `AiProvider.createEmbedding` → lưu `Vector`); similarity search có lọc quyền; answer kèm citation `[Title - Chapter, page]`; không có nguồn phù hợp ⇒ nói không tìm thấy, **không bịa citation**.
- Non-functional: chỉ Docker Postgres có pgvector (không embedded/SQLite — gate test, Wukong residual); giới hạn số chunk gửi LLM (§58); chunk metadata đầy đủ (documentId, bookId, title, chapter, page, accessLevel, sourceType).

## Architecture

- Tables: `knowledge_documents` (owner scope, accessLevel, sourceType, bookId nullable), `knowledge_chunks` (documentId, chapter, page, content), `knowledge_embeddings` (chunkId, `Vector(1536)` — Serverpod native vector field + index cosine).
- **Retrieval SQL**: chunk JOIN document JOIN entitlement (course-enrollment/book-loan/public scope của user) **trong cùng 1 query** với `ORDER BY embedding <=> queryVec LIMIT n` — sự tồn tại của chunk trái quyền cũng không leak.
- Ingestion job: librarian/admin upload tài liệu authorized → extraction → chunk → embed (batch) → insert; re-ingest = replace theo documentId.
- Citation: LLM được yêu cầu trả theo shape đã chuẩn bị ở phase-08 (`citations jsonb`); server verify citation trỏ tới chunk thật trong retrieved set (không tin mù LLM).
- FakeAiProvider embedding = hashing deterministic ⇒ test retrieval/git bảng vàng chạy được không cần key.

## Related Code Files

- Create: `server/src/rag/` (ingestion/, retrieval/, citations verifier), migrations vector, seed corpus (gồm **injection fixtures** tiếp nối phase-08), mobile: citation chip trong chat + nguồn bấm được mở nguồn tương ứng, "Ask AI about this book" nối chunks theo book.
- Test: retrieval correctness (bảng vàng embedding giả), **negative authorization** (restricted/metadata-only/restricted-book chunks = 0 kết quả qua MỌI path: search, metadata, cache), citation-verify test (citation fake của LLM bị loại), quota tương tác, injection fixture E2E.

## Implementation Steps

1. Migration bảng vector + index; verify `CREATE EXTENSION vector` trên compose Postgres (A4 nếu chưa); commit `feat(rag): store embeddings with pgvector`.
2. Ingestion pipeline extraction→chunk→embed→insert + job re-ingest; commits `feat(rag): add document ingestion pipeline`, `feat(rag): implement document chunking`.
3. Retrieval với authorization predicate DB-level + LIMIT chunk; commit `feat(rag): implement authorized similarity retrieval`.
4. Citations: prompt shape + server verifier + UI chip; commit `feat(ai): add source citations to assistant responses`.
5. **Wukong gate phase-10**: claim "không có retrieval path nào trả chunk trái quyền" — attack + fresh independent confirmation; commit `test(rag): verify restricted documents are not retrieved`.
6. Phase exit gates.

## Success Criteria

- [ ] Hỏi nội dung có trong tài liệu authorized ⇒ trả lời + citation đúng chương/trang thật (bảng vàng test PASS với FakeAiProvider).
- [ ] Hỏi nội dung chỉ có trong restricted doc ⇒ "không tìm thấy tài liệu phù hợp", 0 chunk leak (negative test PASS mọi path).
- [ ] LLM bịa citation ⇒ verifier loại, không hiển thị citation sai (test PASS).
- [ ] Ingest 1 tài liệu lớn ⇒ số chunk gửi LLM ≤ budget config (test PASS).
- [ ] `dart analyze`/tests PASS trên Postgres compose (test đánh dấu skip + ghi lý do nếu chạy không có Docker — không fake PASS).

## Risk Assessment

Authorization predicate sai dấu JOIN ⇒ leak — nhờ đó negative test là gate bắt buộc + Wukong; embedding provider thật tốn tiền → mọi test dùng Fake deterministic, key thật chỉ smoke tùy chọn; pgvector index chậm khi corpus nhỏ — không tối ưu sớm, ghi benchmark cơ bản vào ledger.
