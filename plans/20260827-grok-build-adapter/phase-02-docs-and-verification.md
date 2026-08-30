---
phase: 2
title: "Documentation and terminal verification"
status: completed
priority: P1
effort: S
dependencies: [1]
---

# Phase 2: Documentation and Terminal Verification

## Overview

Document the exact Grok installation/discovery contract, regenerate derived
metadata, and run the bounded terminal verification matrix.

## Requirements

- **Functional**: Maintainers can install and verify Grok support from README
  and `docs/INSTALL.md` without adding a credential to the project.
- **Non-functional**: Existing runtime documentation and adapter gates remain
  truthful and green.

## Architecture

Documentation names the shared skill registry and Claude compatibility layer as
the authoritative sources. Provider authentication stays in the Grok user
profile or environment and is outside project adapter state.

## Related Code Files

- **Create**: None
- **Modify**: `AGENTS.md`, `README.md`, `docs/INSTALL.md`,
  `engineer/.agentkit/install-manifest.json`, plan/ledger files
- **Delete**: None

## Implementation Steps

1. Update the root contract and public install documentation.
2. Regenerate the install manifest.
3. Run focused adapter gates, independent review, and the combined gate.
4. Synchronize plan and ledger evidence.

## Success Criteria

- [x] Docs distinguish discovery proof from authenticated inference and hooks.
- [x] Manifest check and project asset validation pass.
- [x] Existing Gemini/OpenCode checks and combined Wukong gate pass or report a
  pre-existing capability block explicitly.

## Risk Assessment

- **Risk**: Documentation overstates provider or hook readiness.
- **Mitigation**: Keep auth and trusted hook execution as explicit `NOT_RUN`
  boundaries unless observed.
- **Rollback/recovery**: Revert Grok-specific docs and regenerated manifest.

## Evidence and Handoff

- **Required gate**: `git diff --check`, focused adapter validators, manifest
  check, and combined Wukong gate.
- **Owner**: controller
- **Next phase dependency**: Final handoff only after evidence is recorded.

## Additive Execution Lock

- **Next incomplete step**: None; terminal verification and handoff are complete.
- **Execution ledger**: `plans/20260827-grok-build-adapter/reports/execution-ledger.md`
- **Allowed escalation**: Code reviewer for terminal review.
- **Verification budget**: One terminal matrix; rerun only failed affected gates.
- **Repair ceiling**: Two focused attempts plus at most one specialist attempt.
- **Deferred findings**: CI and authenticated provider execution.
