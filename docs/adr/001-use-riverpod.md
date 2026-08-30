# ADR-001: Use Riverpod for state management

- Status: Accepted (2026-08-30)
- Phase: 01-foundation

## Context

CampusMate needs predictable state management across 13+ feature modules
(auth, academics, library, reader, AI chat, admin) with async data from a
Serverpod backend, offline cache, and per-section loading/error/empty states
on every screen (§11, §73).

## Decision

Use `flutter_riverpod` for all state management. Providers are scoped per
feature; cross-feature state goes through domain interfaces, never another
feature's providers (plan dependency rule 1).

## Alternatives considered

- **BLoC**: verbose boilerplate for this codebase size; no compile-safe
  provider graph.
- **setState / InheritedWidget**: fine for leaves, unmanageable as the sole
  strategy at this scale.
- **MobX**: codegen-heavy, smaller ecosystem in VN university projects.

## Consequences

- Compile-safe DI and testable providers (override in tests).
- Riverpod 3.x pinned via pub; codegen (`riverpod_generator`) is NOT adopted
  in phase 01 — revisit only when provider count makes manual providers a
  burden (deferred decision, YAGNI).
