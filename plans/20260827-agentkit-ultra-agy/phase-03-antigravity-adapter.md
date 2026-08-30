---
phase: 3
title: "Antigravity adapter and installer"
status: completed
priority: P1
dependencies: [1, 2]
---

# Phase 3: Antigravity adapter and installer

## Overview

Project the existing `.agents/skills` tree and allowlisted agents into
Antigravity workspace/global roots with ownership markers, collision safety,
backup, and rollback.

## Requirements

- [x] No `.gemini/skills` or copied Claude hooks/commands are generated.
- [x] AGY agent projection strips unsupported metadata and blocks traversal.
- [x] Installer accepts an explicit Antigravity target without touching foreign files.
- [x] `agy.exe` preflight records version/help; no provider-auth call was attempted.
- [x] External ownership ledger blocks marker/file tampering and safely backs up
  stale managed files before source-removal updates.
- [x] Marker-only `preflight`/`emit` calls are rejected before any write.
- [x] HMAC key, ledger, destination, source, and backup hardlink/reparse guards
  are covered; transient/cache/credential files are excluded from projections.

## Implementation Steps

1. Add generator, validator, and fixture tests for encoding/path/collision cases
   (27 focused tests, including marker-only, HMAC, hardlink, filtering, and
   backup-integrity rejection regressions).
2. Extend installer and static test harness with explicit AGY mode.
3. Run binary preflight and optional PATH setup only after snapshot; do not mutate profile.

## Success Criteria

- [x] `test_antigravity_adapter.py` exits 0 (27 tests).
- [x] Project/global dry-run and rollback fixtures pass.
- [x] Live commands are recorded as PASS, NOT_RUN, or BLOCKED_CAPABILITY honestly.

## Risk Assessment

- **Risk**: AGY version rejects nested agents or unsupported fields.
- **Mitigation**: allowlist projection and explicit capability result.
- **Rollback/recovery**: ownership-marked files only; preserve foreign/modified files.
