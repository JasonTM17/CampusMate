---
title: "Grok Build project adapter"
description: "Add bounded, credential-free Grok Build support by composing AgentKit's shared skills with Claude-compatible runtime assets."
status: completed
priority: P1
effort: M
issue: null
branch: main
tags: [feature, adapter, grok]
blockedBy: []
blocks: []
created: 2026-08-27
---

# Grok Build Project Adapter Plan

**Archetype**: Feature
**Workflow**: `/ak:plan-lock` + `/ak:cook --auto` -> `/ak:test` -> `/ak:code-review`

## Executive Summary

Formalize Grok Build as a supported AgentKit project runtime without creating a
fifth skill mirror. Grok must consume the canonical `.agents/skills` registry
and the reviewed Claude-compatible agent, rule, hook, and settings assets.

## Outcome Contract

- **Outcome**: A consuming project can install AgentKit with
  `-ProjectRuntime Grok`, then Grok Build discovers AgentKit skills, agents, and
  instructions from project-local assets.
- **Success signal**: The installer test passes and `grok inspect --json`
  reports all 104 unique AgentKit skill entrypoints plus all 17 project agents.
- **Target identity**: Current `main` based on `33ed631` and Grok CLI `1.0.5`.
- **In scope**: Project installer asset mapping, Grok validator, combined gate,
  root operating contract, README/install docs, and install manifest.
- **Non-goals**: Installing Grok CLI, authenticating xAI, configuring models,
  storing `XAI_API_KEY`, adding `.grok/skills`, or claiming trusted hook/live
  provider execution.
- **Authority**: Modify repository files and run local/static verification. No
  commit, push, release, account login, or external mutation is implied.
- **Stop conditions**: Any required design would duplicate skills, expose a
  credential, overwrite unrelated work, or contradict Grok's documented
  project configuration boundary.

## Requirements and Context

- **Actors and primary flow**: Maintainer installs the Grok adapter into a
  project; Grok discovers `.agents/skills`, `AGENTS.md`, and Claude-compatible
  agents/rules/hooks without a duplicate registry.
- **Failure/empty/permission states**: Installer collisions remain fail-closed;
  missing Grok CLI makes live discovery `NOT_RUN`, not a static failure.
- **Affected contracts**: `ProjectRuntime` enum, project asset map, adapter
  validator inventory, combined gate, and public installation documentation.
- **Compatibility/migration**: Existing Codex, Claude, Cursor, Gemini, and
  OpenCode mappings remain unchanged.
- **Current evidence**: Official xAI docs describe Claude Code and `AGENTS.md`
  compatibility; local `grok inspect --json` sees 104 unique AgentKit skills
  from `.agents/skills` and 17 project agents from `.claude/agents`.
- **Decisions still required**: None inside the accepted scope.

## Phase Index

| Phase | File | Independently verifiable outcome | Dependencies | Owner |
|---|---|---|---|---|
| 01 | [phase-01-adapter-and-installer.md](./phase-01-adapter-and-installer.md) | Grok adapter contract installs and validates without a duplicate skill tree | [] | controller |
| 02 | [phase-02-docs-and-verification.md](./phase-02-docs-and-verification.md) | Public docs, manifest, focused tests, and combined gates agree | [01] | controller |

## Acceptance Matrix

| Requirement | Authoritative evidence | Owner | Required result |
|---|---|---|---|
| Grok project install | `scripts/test-install-agentkit.ps1` | tester | PASS |
| Unique AgentKit catalog | `validate-grok-adapter.py` + `grok inspect --json` | tester | 104 unique skills, 17 agents |
| Existing adapter safety | Gemini/OpenCode generator checks and validators | tester | PASS |
| Repository parity | project-assets, manifest check, `git diff --check` | tester | PASS |

## Architecture and Risk Summary

- **State/data flow**: `engineer/skills` -> `.agents/skills` -> the observed
  Grok 1.0.5 project discovery path; `.claude/{agents,rules,hooks,settings.json}`
  -> Grok's documented Claude compatibility layer. xAI documents `.grok/skills`
  as the native root, so live discovery remains a required drift check.
- **Trust boundaries**: Provider login and `XAI_API_KEY` remain user-owned;
  project hooks require explicit Grok trust before live execution.
- **Highest risks**: Duplicate skill commands, model/credential leakage, and
  overclaiming hook persistence. Validator and docs explicitly gate all three.
- **Residual limits**: `grok inspect` proves discovery, not authenticated model
  inference or trusted hook execution.

## Delivery and Recovery

- **Rollout**: Additive `Grok` runtime choice; no migration for existing users.
- **Rollback**: Revert only the Grok-specific installer, validator, gate, docs,
  and plan changes; other runtime assets are unchanged.
- **Observability**: Validator JSON records discovered counts and live-smoke
  status without emitting credentials.
- **Release identity**: User-authorized release commit is
  `9f742b1f48310fc5108a7c177fc2021867f1375d`; the post-release gate was rerun
  against this exact HEAD.

## Handoff

- **Current decision**: COMPLETE_WITH_RESIDUAL_GATES
- **Next phase/owner**: None; implementation and terminal verification are
  complete. Follow-up work is limited to the documented residual gates.
- **Required Advisor/Kongming/Wukong gate**: Combined Wukong gate completed with
  `PASS_WITH_BLOCKED_CAPABILITY`; the only block is the pre-existing
  `evaluation-portability` capability marker.
- **Review state**: Tester review PASS. The independent code-reviewer worker was
  unavailable because of a usage-limit error; a bounded retry did not return
  before timeout. The controller performed a read-only exact-scope diff audit
  and found no out-of-scope changes.
- **Commit/push/CI state**: Commit `9f742b1f48310fc5108a7c177fc2021867f1375d`
  was pushed successfully to `origin/main`; local and remote HEAD match.
  CI execution remains a separate, unobserved gate.

## Additive Execution Control

- **Plan lock**: Resume the first incomplete step; preserve every gate above.
- **Execution ledger**: `plans/20260827-grok-build-adapter/reports/execution-ledger.md`
- **Replan authority**: User or evidence-backed specialist finding.
- **Verification budget**: Focused installer/validator checks during build;
  combined gate once at the terminal checkpoint.
- **Spawn budget**: Required tester and code-reviewer only; no speculative agents.
- **Deferred queue**: Authenticated Grok model call, trusted live hook receipt,
  and an independent code-reviewer pass when that capability is available.
