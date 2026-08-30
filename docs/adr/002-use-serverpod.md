# ADR-002: Use Serverpod for the Dart backend

- Status: Accepted (2026-08-30)
- Phase: 01-foundation

## Context

The master prompt mandates a Dart-first full stack with typed client codegen,
auth/session handling, database migrations, and streaming for AI chat
(§3, §4, §26). The backend must expose PostgreSQL (with pgvector), Redis, and
S3-compatible storage behind application services.

## Decision

Use **Serverpod 3.4.x** (server + generated client). Version pin: `3.4.13`
(Dart SDK `^3.8.0`, verified compatible with Dart 3.12.0 stable on Windows).
Do **not** drift onto `4.0.0-rc.*` without a new ADR.

## Spike evidence (2026-08-30, this machine)

- `serverpod create` (template `server`) + codegen OK on Windows.
- `docker compose up -d`: Postgres (pgvector image), Redis healthy.
- Migration `20260830095733184` applied on boot (`--apply-migrations`).
- Generated client called `greeting.hello` end-to-end (Flutter test green).
- `CREATE EXTENSION vector` + cosine query verified in the compose Postgres.
- `Vector(1536)` model field (`vector_capability_probe.spy.yaml`) → codegen →
  migration `20260830104952147` applied → column type `vector(1536)` verified
  in `\d` (full model→migration path proven, not just raw SQL).

## Licensing ruling

The main `serverpod` package is SSPL-1.0 (rest of the ecosystem BSD-3).
SSPL restricts *offering Serverpod as a service*, not building an internal
application on it. CampusMate is an internal application → acceptable.
Revisit only if CampusMate is ever sold as a hosted platform.

## Alternatives considered

- **Dart Frog / Shelf**: lighter, but no codegen client, migrations, or auth
  modules — we would rebuild all of it.
- **Firebase**: vendor lock-in, no PostgreSQL/pgvector, weak RAG fit.
- **Node/NestJS**: violates the Dart-first constraint (§3).

## Consequences

- Auth module generation choice is deferred to ADR-005 (phase 02); the 3.4
  template already scaffolds `serverpod_auth_idp_server` (email identity +
  JWT refresh), which is the preferred generation.
- Streaming endpoint pattern (WebSocket) must be spike-verified before
  phase 08 commits the chat architecture; SSE/polling is the designed
  fallback.
