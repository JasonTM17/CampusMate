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

## Verification

```bash
dart format --set-exit-if-changed .
dart analyze
dart test --exclude-tags integration
dart test
```

`dart test` requires Docker-backed test services on the ports configured in
`config/test.yaml`.
