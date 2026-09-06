# CampusMate Server

Serverpod backend for CampusMate. It owns authentication, authorization,
conversation persistence, AI provider calls, and all database access.

## Run Locally

```bash
docker compose up -d
dart run bin/main.dart --apply-migrations
```

The development stack exposes PostgreSQL/pgvector, Redis, and MinIO. Redis is
currently disabled in `config/development.yaml` until a phase needs caching.

## Seed Demo Accounts

Stop the running backend first so the one-shot seed process can use the same
development ports. Set `CAMPUSMATE_SEED_PASSWORD` locally (at least 12
characters, never commit it), then run:

```powershell
$env:CAMPUSMATE_SEED_PASSWORD = '<local-only-password>'
dart run bin/seed.dart --apply-migrations
```

The command is idempotent and creates `student001@campusmate.local`,
`librarian@campusmate.local`, `admin@campusmate.local`, and 20 Vietnamese demo
student profiles. It is for local development only.

## Verification

```bash
dart format --set-exit-if-changed .
dart analyze
dart test --exclude-tags integration
dart test
```

`dart test` requires Docker-backed test services on the ports configured in
`config/test.yaml`.
