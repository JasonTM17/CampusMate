# ADR-004: Use Drift for the offline layer

- Status: Accepted (2026-08-30)
- Phase: 01-foundation

## Context

The app must stay usable on weak networks (§24): cached profile, timetable,
grades, book metadata, notifications, and reading progress on device, with a
sync path for reader progress. The offline scope is deliberately narrow:
server-authoritative pull-cache plus exactly ONE client-write sync lane
(reading progress, last-write-wins by `updatedAt`) — Kongming condition C5.

## Decision

Use **Drift** (SQLite) for on-device cache tables, outbox queue, and upsert
semantics (`insertOnConflictUpdate` / `DoUpdate`) powering the LWW sync.
Drift lives only in `data` layers; domain stays pure Dart (dependency rule 4).

## Alternatives considered

- **Hive/Isar**: NoSQL shape mismatches the relational mirror we cache;
  Isar maintenance risk.
- **sqflite raw SQL**: no type-safe queries; Drift gives migrations + tests.
- **Full generic sync framework**: explicitly a non-goal (C5) — YAGNI.

## Consequences

- LWW conflict rule must be unit-tested at phase 07 (reader) before offline
  downloads ship.
- Drift schema changes go through Drift migrations; Serverpod migrations
  stay the only source for server schema.
