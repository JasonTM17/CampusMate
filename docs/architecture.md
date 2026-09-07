# CampusMate System Architecture

CampusMate is a Flutter + Serverpod student application. The mobile client owns presentation state and offline read cache only; the backend owns identity, authorization, domain rules, AI provider access, and durable data.

## System Map

```mermaid
flowchart TB
    subgraph device[Student device]
        shell[Flutter Material 3 shell]
        router[go_router protected routes]
        controllers[Riverpod feature controllers]
        drift[(Drift offline pull-cache)]
    end

    subgraph generated[Generated API boundary]
        client[packages/campusmate_client]
        protocol[Serverpod protocol models]
    end

    subgraph backend[Serverpod backend]
        session[Session identity + auth scopes]
        auth[Auth endpoints]
        profile[Student profile]
        academic[Academic endpoints]
        ai[AI assistant endpoints]
        library[Library endpoints planned]
        quota[Quota + prompt guard]
    end

    subgraph data[Stateful services]
        postgres[(PostgreSQL + pgvector)]
        redis[(Redis, phase-gated cache)]
        minio[(MinIO / S3, planned content)]
    end

    subgraph external[External providers]
        llm[OpenAI-compatible / GLM gateway]
    end

    shell --> router
    router --> controllers
    controllers --> drift
    controllers --> client
    client --> protocol
    protocol --> session
    session --> auth
    session --> profile
    session --> academic
    session --> ai
    session --> library
    academic --> postgres
    profile --> postgres
    auth --> postgres
    ai --> quota
    quota --> postgres
    ai --> llm
    library --> postgres
    library --> minio
    backend --> redis

    classDef mobile fill:#d9f99d,stroke:#3f6212,color:#1a2e05
    classDef api fill:#bfdbfe,stroke:#1d4ed8,color:#172554
    classDef store fill:#fde68a,stroke:#b45309,color:#451a03
    classDef provider fill:#fbcfe8,stroke:#be185d,color:#500724
    class shell,router,controllers,drift,client,protocol mobile
    class session,auth,profile,academic,ai,library,quota api
    class postgres,redis,minio store
    class llm provider
```

## Runtime Flow

```mermaid
sequenceDiagram
    autonumber
    participant Student
    participant Mobile as Flutter app
    participant Cache as Drift cache
    participant API as Serverpod API
    participant DB as PostgreSQL
    participant AI as AI provider

    Student->>Mobile: Open protected academic route
    Mobile->>Cache: Read cached overview, timetable, grades
    Cache-->>Mobile: Return account-scoped snapshot when present
    Mobile->>API: Refresh with session token
    API->>API: requireLogin + student scope
    API->>DB: Query by authenticated student profile
    DB-->>API: Courses, timetable, grades, exams, progress
    API-->>Mobile: Server-authoritative DTO snapshot
    Mobile->>Cache: Atomic replace for account + week + semester
    Mobile-->>Student: Render fresh data or offline badge on fallback

    Student->>Mobile: Ask AI
    Mobile->>API: Send message without provider secret
    API->>API: Apply quota and prompt guard
    API->>AI: Server-side provider request
    AI-->>API: Stream response chunks
    API-->>Mobile: Stream sanitized chunks
```

## Trust Boundaries

- The mobile app never stores AI provider keys and never connects directly to the database.
- Client payloads never decide the acting user. Endpoints derive identity from the Serverpod session.
- Offline academic data is a pull-cache. Server data remains authoritative, and cache rows are partitioned by authenticated account, week, and semester.
- Planned library and reader features must keep access checks on the server before issuing book metadata, files, or RAG context.
- Release claims require local gates, independent review, GitHub Actions evidence, and explicit tag/package evidence.

## Component Ownership

| Component | Owner | Current status |
| --- | --- | --- |
| `apps/mobile` | Flutter client, routing, Riverpod controllers, Drift read cache | Active |
| `server` | Serverpod endpoints, auth, migrations, seed data | Active |
| `packages/campusmate_client` | Generated protocol/client | Generated |
| `packages/campusmate_shared` | Pure Dart reusable domain logic | Active |
| `docs/adr` | Architecture decisions | Active |
