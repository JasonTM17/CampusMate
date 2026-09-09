# ADR-007: Last-Write-Wins (LWW) Reading Progress Synchronization

- Status: Accepted (2026-09-09)
- Phase: 07-reader

## Context

Reading progress must be tracked so students can resume reading where they left off across app restarts and multiple devices.
Students may read while offline (on campus shuttles, in dead zones, or with poor network connectivity).
When connectivity is restored, local progress must sync with the server. If a student read on two devices, a conflict resolution strategy is required.

## Decision

1. **Client-Write Boundary**: Reading progress is the **only client-write synchronization path** in CampusMate (Kongming C5). All other state mutations (profile, academic, lending) are server-authoritative or strictly server-transactional.
2. **Conflict Resolution Strategy**: Adopt **Last-Write-Wins (LWW)** based on UTC `updatedAt` timestamps:
   - When the client attempts to sync progress, it supplies `clientUpdatedAt`.
   - If `clientUpdatedAt.isAfter(serverRow.updatedAt)`, the client's progress update wins and is persisted to the database.
   - If `serverRow.updatedAt.isAfter(clientUpdatedAt)`, the server's record is newer (e.g. read further on another device). The server returns the newer record with `appliedClientUpdate: false`, and the client updates its local state to match.
3. **Pure Dart Logic**: The conflict resolution predicate and state representation are packaged in `packages/campusmate_shared`, ensuring 100% offline unit-testability without Flutter, Drift, or Serverpod dependencies.

## Consequences

- No complex multi-way merge or operational transformation is needed for single-user reading pointers.
- Clock drift is mitigated by using server time whenever online and UTC epoch timestamps on the device.
- Deterministic, verifiable behavior tested with unit test matrices covering local newer, remote newer, and simultaneous updates.
