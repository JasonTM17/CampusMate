# CampusMate Documentation Hub

Welcome to the central technical documentation portal for **CampusMate** ("Study. Read. Grow."). This documentation suite has been engineered according to the **AgentKit (AK) workflow**, ensuring end-to-end traceability, architectural integrity, and verification rigor across the Flutter mobile frontend, Dart shared packages, and Serverpod backend.

---

## 🗺️ Documentation Sitemap

```mermaid
mindmap
  root((CampusMate Docs))
    Architecture & Systems
      [Architecture Overview](architecture.md)
      [AI Subsystem & Quota](ai-architecture.md)
      [RAG & Knowledge Retrieval](rag.md)
      [Offline Cache & Sync](offline-sync.md)
    Data & Interfaces
      [Database Schema & ERD](database.md)
      [Serverpod API Catalog](api.md)
    Security & Compliance
      [Authentication & RBAC](authentication.md)
      [STRIDE Threat Model](threat-model.md)
    DevOps & Testing
      [Testing Strategy](testing.md)
      [Deployment & Docker](deployment.md)
      [Git Workflow & Commits](git-workflow.md)
      [Release & Packages](release-packages.md)
    Decisions
      [ADR Records 001-008](adr/)
```

---

## 📚 Document Index

### 1. Architecture & Core Systems
- **[System Architecture](architecture.md)**: High-level topology, trust boundaries, client-server contract, and dataflow between Flutter, Serverpod, PostgreSQL + pgvector, Redis, and MinIO.
- **[AI Subsystem Architecture](ai-architecture.md)**: AI assistant provider abstraction (Fake, OpenAI-compatible, GLM), WebSocket streaming protocol, server-side prompt injection guards, and daily message quota enforcement.
- **[RAG Pipeline](rag.md)**: Document ingestion, token chunking, pgvector cosine similarity search, database-level authorization filtering, and citation verification.
- **[Offline Cache & Synchronization](offline-sync.md)**: Local offline pull-caching with Drift SQLite and Last-Write-Wins (LWW) conflict resolution for reading progress.

### 2. Data Models & API Specifications
- **[Database Schema & ERD](database.md)**: Entity-Relationship Diagrams (ERD) covering Academic Management, Library Circulation, and AI Conversations with indexing strategies and foreign key constraints.
- **[Serverpod API Catalog](api.md)**: Complete RPC endpoint inventory across all controllers (`auth`, `profile`, `academic`, `dashboard`, `library`, `lending`, `reader`, `ai`), including parameters, return DTOs, and required auth scopes.

### 3. Security & Governance
- **[Authentication & RBAC](authentication.md)**: Session-based authentication via Serverpod Auth IDP, token lifecycle, secure storage on client, and 4-tier RBAC permission matrix (`student`, `lecturer`, `librarian`, `admin`).
- **[STRIDE Threat Model](threat-model.md)**: In-depth security analysis addressing all 11 critical architectural threats (§83), mitigations, and automated test regression verification.

### 4. Operations, Quality & Releases
- **[Testing Strategy](testing.md)**: Testing pyramid, unit test guidelines, widget tests, mobile integration flows, and server E2E student journeys.
- **[Production Deployment](deployment.md)**: Docker containerization, Docker Compose multi-service topology, environment variables, database migrations, and disaster recovery.
- **[Git Workflow & Contribution](git-workflow.md)**: Branching policy, Conventional Commits standard, and pre-push quality gates.
- **[Release & Packaging Policy](release-packages.md)**: Versioning strategy, GitHub Releases, Android debug/release APK artifacts, and distribution pipeline.

---

## 🏛️ Architectural Decision Records (ADRs)

Key architectural decisions are documented in [`docs/adr/`](adr/):

| ADR | Title | Status | Summary |
|---|---|---|---|
| **[ADR-001](adr/001-use-riverpod.md)** | State Management with Riverpod | Accepted | Adopt Riverpod 2.x for robust, testable, and compile-safe reactive state management. |
| **[ADR-002](adr/002-use-serverpod.md)** | Backend Framework with Serverpod | Accepted | Use Serverpod 3.4.x for end-to-end type safety, code generation, and unified Dart monorepo. |
| **[ADR-003](adr/003-use-postgresql-pgvector.md)** | Relational DB + Vector Embeddings | Accepted | Utilize PostgreSQL 16 with pgvector extension for unified transactional and semantic data. |
| **[ADR-004](adr/004-use-drift-for-offline.md)** | Offline Persistence with Drift | Accepted | Employ Drift SQLite for type-safe offline pull-caching of student timetables and profiles. |
| **[ADR-005](adr/005-use-serverpod-auth-idp.md)** | Authentication & Token Management | Accepted | Implement session tokens with Serverpod Auth IDP, storing tokens in Flutter Secure Storage. |
| **[ADR-006](adr/006-epub-webview-and-reader-engine.md)** | Digital Reader Engine Architecture | Accepted | Use native Flutter PDF rendering and Webview EPUB engine for cross-platform stability. |
| **[ADR-007](adr/007-last-write-wins-reading-progress-sync.md)** | Reading Progress Synchronization | Accepted | Implement Last-Write-Wins (LWW) timestamp conflict resolution for cross-device reading sync. |
| **[ADR-008](adr/008-stream-chat-over-websocket.md)** | Streaming AI Chat over WebSocket | Accepted | Stream LLM token deltas in real-time over Serverpod WebSocket endpoints. |

---

## 🛠️ Verification & Quality Invariants

All code committed to this repository must satisfy the **AK Quality Gates**:

1. **Format Check**: `dart format --set-exit-if-changed .`
2. **Static Analysis**: `flutter analyze` & `dart analyze` (0 errors, 0 warnings, 0 hints)
3. **Automated Tests**: 100% test pass rate across unit, widget, and integration suites (`flutter test`, `dart test`)
4. **Zero Secret Leakage**: No credentials, private keys, or API tokens committed (`.gitignore` enforced)
