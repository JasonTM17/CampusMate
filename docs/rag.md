# CampusMate RAG (Retrieval-Augmented Generation) Architecture

CampusMate implements an enterprise-grade, authorization-aware Retrieval-Augmented Generation (RAG) pipeline to ground AI responses in university course materials, regulations, and e-library textbooks.

---

## 1. RAG Pipeline Stages

```mermaid
flowchart LR
    subgraph Ingestion["1. Ingestion & Indexing"]
        Doc["Document (PDF / EPUB / Reg)"] --> Chunking["Recursive Chunker (512 tokens, 64 overlap)"]
        Chunking --> Embedding["Embedding Model (text-embedding-3-small)"]
        Embedding --> VectorDB[("PostgreSQL pgvector (knowledge_chunks)")]
    end

    subgraph Retrieval["2. Authorized Retrieval"]
        Query["Student Query"] --> QueryEmbed["Embed Query"]
        QueryEmbed --> Filter["DB-Level Auth Filter (Course Enrollment + Access Policy)"]
        Filter --> Similarity["Cosine Vector Search (1 - cosine_distance)"]
        Similarity --> TopK["Top-K Chunks (Score >= 0.72)"]
    end

    subgraph Generation["3. Generation & Verification"]
        TopK --> Prompt["Grounded System Prompt + Context"]
        Prompt --> LLM["LLM Synthesis"]
        LLM --> Citation["Citation Verification (Verifies chunk ID references)"]
    end
```

---

## 2. Authorization-Aware Vector Search (DB-Level Filtering)

A critical vulnerability in typical RAG systems is cross-tenant information leakage (Risk R4). CampusMate prevents this by executing access checks directly within the PostgreSQL query:

```sql
SELECT c.id, c.content, c.metadata, (1 - (c.embedding <=> $1)) as similarity
FROM knowledge_chunks c
JOIN knowledge_documents d ON c.document_id = d.id
WHERE (
    d.access_type = 'public'
    OR (d.access_type = 'course_restricted' AND d.course_id IN (
        SELECT offering_id FROM enrollments WHERE student_profile_id = $2 AND status = 'active'
    ))
    OR (d.access_type = 'borrow_required' AND d.book_id IN (
        SELECT book_id FROM book_loans WHERE student_id = $3 AND status = 'borrowed'
    ))
)
ORDER BY c.embedding <=> $1
LIMIT 5;
```

**Security Invariant**: If a student is not enrolled in a course or does not hold an active loan for a restricted book, the corresponding chunks are excluded at the database layer. The LLM never sees unauthorized text.

---

## 3. Citation Verification & Anti-Hallucination

1. **Source Grounding**: Prompts instruct the LLM to tag factual claims with inline bracketed source IDs: `[Doc #12, Page 45]`.
2. **Post-Processing Verifier**: `CitationVerifier` scans the generated response, cross-references tagged citation tokens against the retrieved chunk metadata, and flags or removes fabricated citations before delivering the text to the client.
