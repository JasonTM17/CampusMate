# ADR-003: PostgreSQL + pgvector as the primary database and vector store

- Status: Accepted (2026-08-30)
- Phase: 01-foundation

## Context

CampusMate needs one relational database for academic/library/AI data plus
vector similarity search for RAG (§29, §35). Running a separate vector DB
would add an operational boundary before product-market fit.

## Decision

Use **PostgreSQL 16 with the pgvector extension** (`pgvector/pgvector:pg16`
Docker image — already the Serverpod template default) for relational data
AND embeddings. Serverpod 3.4 supports native `Vector` model columns with
distance operators and vector indexes.

## Evidence

- `CREATE EXTENSION vector`, `vector(3)` column, and `<=>` cosine ordering
  verified inside the compose container (2026-08-30).
- Healthchecks green for both dev and test Postgres services.

## Alternatives considered

- **Dedicated vector DB (Qdrant/Milvus/Pinecone)**: one more service to
  operate; authorization filtering (§29) would then span two stores — the
  DB-level authorization predicate (Kongming C7) is safer in one store.
- **SQLite/VSS**: dev-only limitation; no Serverpod integration.

## Consequences

- RAG tests require the Dockerized Postgres (embedded/SQLite cannot serve
  vector columns) — test gate documented in phase 10.
- Vector index tuning is deferred until corpus size justifies it.
