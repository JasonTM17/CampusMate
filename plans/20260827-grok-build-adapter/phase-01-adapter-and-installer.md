---
phase: 1
title: "Adapter and installer contract"
status: completed
priority: P1
effort: M
dependencies: []
---

# Phase 1: Adapter and Installer Contract

## Overview

Add a fail-closed Grok project-runtime mapping and a validator that proves the
shared skill registry and Claude-compatible runtime surfaces are complete.

## Requirements

- **Functional**: `-ProjectRuntime Grok` installs exactly the required shared
  and Claude-compatible assets.
- **Non-functional**: No duplicate `.grok/skills` tree, provider config, model
  pin, credential, or host-specific path is introduced.

## Architecture

Grok 1.0.5 was observed reading the project `.agents/skills` registry and
reading Claude Code agents, rules, hooks, settings, and instruction assets
through its compatibility layer. xAI documents `.grok/skills` as the native
root, so the live validator detects future runtime drift. The adapter composes
reviewed existing sources rather than generating a new skill mirror.

## Related Code Files

- **Create**: `engineer/.agentkit/scripts/validate-grok-adapter.py`
- **Modify**: `scripts/install-agentkit.ps1`,
  `scripts/test-install-agentkit.ps1`,
  `engineer/.agentkit/scripts/run-wukong-gate.py`
- **Delete**: None

## Implementation Steps

1. Add `Grok` to the installer runtime enum and define an exact asset map.
2. Extend installer fixtures and assertions for the Grok copy contract.
3. Add the static/copy/live-discovery validator.
4. Register the validator in the combined gate.

## Success Criteria

- [x] Installer tests prove Grok assets are copied and `.grok/skills` is absent.
- [x] Validator proves 104 shared entrypoints and 17 Claude-compatible agents.
- [x] Live `grok inspect --json` discovery passes when the CLI is installed.

## Risk Assessment

- **Risk**: Copying `.claude/skills` alongside `.agents/skills` creates duplicate
  slash-command sources.
- **Mitigation**: Copy only `.claude` agents/rules/hooks/settings/statusline and
  reject `.grok/skills`.
- **Rollback/recovery**: Revert only the new Grok mapping and validator entries.

## Evidence and Handoff

- **Required gate**: Focused PowerShell installer test and Python validator.
- **Owner**: controller
- **Next phase dependency**: Both focused checks pass.

## Additive Execution Lock

- **Next incomplete step**: None; Phase 02 terminal verification is complete.
- **Execution ledger**: `plans/20260827-grok-build-adapter/reports/execution-ledger.md`
- **Allowed escalation**: Tester for independent verification; code-reviewer at
  the terminal review checkpoint.
- **Verification budget**: One installer test and one validator run; rerun only
  after a cause-aligned repair.
- **Repair ceiling**: Two focused attempts plus at most one specialist attempt.
- **Deferred findings**: Live hook trust and authenticated inference.
