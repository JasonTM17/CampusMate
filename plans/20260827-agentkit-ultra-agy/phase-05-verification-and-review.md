---
phase: 5
title: "Terminal verification and review"
status: completed
priority: P1
dependencies: [4]
---

# Phase 5: Terminal verification and review

## Overview

Run the planned focused and existing gates, freeze an exact snapshot, obtain
required independent review findings, and report remaining runtime limitations.

## Requirements

- [x] Focused, repository, adapter, installer, and cross-reference gates are recorded.
- [x] Read-only Kongming/Wukong/code-review checkpoints use the frozen code
  identity; the final documentation-only refresh is recorded below.
- [x] No claim exceeds local/live evidence; commit/push remains separately stated.

## Implementation Steps

1. Run focused tests and repair only cause-aligned in-scope failures. The AGY
   adapter has 33 fixture tests, including CLI round-trip, ownership/HMAC
   tamper, source-removal backup, rollback, hardlink/reparse, filtering,
   marker-only rejection, and backup-integrity cases.
2. Run existing gates and runtime matrix; classify unavailable auth/binaries.
3. Freeze hash, request read-only reviews, integrate only evidence-backed blockers.

## Observed verification

- Focused: Ultra 18/18, AGY 33/33, Grok 18/18, runtime denylist 3/3, and full
  AgentKit unittest 75/75 PASS. ClaudeKit is not a release target and was not
  modified.
- Repository/adapter: project-assets PASS; install manifest 1508 files valid;
  Gemini 107 skills/106 public commands/17 agents PASS; OpenCode 106 public
  skills/17 agents PASS; Grok 107 entrypoints/106 public skills/17 agents and
  live inspect PASS; Wukong integration PASS; `git diff --check` PASS.
- Installer: PowerShell end-to-end PASS, including fresh/idempotent/stale
  backup, junction-to-copy, Grok and AGY project modes, rollback, collision,
  validate-only, and Pi rejection.
- Runtime: `agy` 1.1.22 version/help/models and explicit `--add-dir` workspace
  skill discovery/read-only smoke pass. Default discovery remains
  `BLOCKED_CAPABILITY`; no provider-auth call was attempted (`NOT_RUN`). Global
  `ak` remains 2.7.0; native new-target/flag CLI gates are `BLOCKED_CAPABILITY`.
- Independent read-only review on code snapshot
  `3319e0ccb5a186ca27882fafa5d1ab9a0aeb77f6b10c9f95eed7e2cc9e0b8bc8`
  (`main`, `fe980169`, 7578 files): code review found no P1, Kongming PASS for
  AgentKit-local architecture with the capability blockers above, and Wukong
  returned `NOT_FALSIFIED` for the five load-bearing safety claims.
- ClaudeKit checkout was inspected only for scope isolation; it remains dirty
  and is intentionally excluded from this AgentKit release.

## Success Criteria

- [x] Every acceptance matrix row has PASS, NOT_RUN, or BLOCKED_CAPABILITY evidence.
- [x] Review findings are resolved or explicitly handed off.
- [x] Plan/ledger status and next safe action are truthful after this final
  documentation refresh and exact snapshot recomputation.

## Risk Assessment

- **Residual**: deterministic preflight/recheck coverage protects against
  existing junctions and hardlinks; no claim is made against an adversary that
  swaps a parent reparse point concurrently between the final check and copy.
  Combined `--ultra --debate` uses post-selection red-team review to preserve
  candidate isolation; it does not expose peer output or blend plans.

- **Risk**: stale review after late edits.
- **Mitigation**: rerun identity and affected gate after every review repair.
- **Rollback/recovery**: revert AgentKit changes only; no force push.
