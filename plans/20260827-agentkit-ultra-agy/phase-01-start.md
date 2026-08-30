---
phase: 1
title: "Foundation and contracts"
status: completed
priority: P1
dependencies: []
---

# Phase 1: Foundation and contracts

## Overview

Freeze the baseline, define the runtime capability states, and add a shared
`ak.ultra/v1` contract plus negative target policy without changing runtime
behavior by default.

## Requirements

- [x] Contract records immutable evidence digest, bounded candidates/redispatch/debate, rubric, vetoes, and redaction rules.
- [x] Denylist rejects `dsh`, `pi`, and `omp` as AgentKit targets and emits no fallback.
- [x] Baseline snapshot and execution ledger are recorded without secrets.

## Related Code Files

- **Create**: `engineer/skills/ak-common/references/ultra-verifier-contract.md`
- **Create**: `engineer/.agentkit/scripts/test_ultra_verifier.py`
- **Create**: `engineer/.agentkit/scripts/validate-runtime-targets.py`
- **Modify**: capability/installer docs only when exact target ownership is proven.

## Implementation Steps

1. Record HEAD/branch/remotes/counts and initialize the ledger.
2. Implement deterministic contract validation and denylist negative cases.
3. Run focused validators and record evidence before skill edits.

## Success Criteria

- [x] `python engineer/.agentkit/scripts/test_ultra_verifier.py` exits 0 (13 tests).
- [x] Unsupported target tests reject DSH/Pi/OMP and preserve foreign files.
- [x] `git diff --check` is clean for this phase.

## Risk Assessment

- **Risk**: validator accidentally becomes an execution service or accepts untrusted instructions.
- **Mitigation**: schema-only checks, immutable digest, explicit hard vetoes, no subprocess/network.
- **Rollback/recovery**: remove only new contract/test files; no global or user-data mutation.

## Evidence and Handoff

- **Required gate**: focused validator output plus baseline snapshot in ledger.
- **Owner**: integration controller.
- **Next phase dependency**: contract API and denylist names are stable.

## Additive Execution Lock

- **Next incomplete step**: implement contract validator.
- **Verification budget**: focused Python tests only; rerun after contract changes.
- **Repair ceiling**: two focused repairs, then specialist review if still failing.
- **Deferred findings**: runtime-native CLI upgrade and AGY live auth.
