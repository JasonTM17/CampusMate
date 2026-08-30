---
phase: 2
title: "Skills and workflow flags"
status: completed
priority: P1
dependencies: [1]
---

# Phase 2: Skills and workflow flags

## Overview

Add opt-in Ultra and Debate instructions while preserving the existing default
workflow, then author the three utility skills with separate aliases.

## Requirements

- [x] `ak:brainstorm`, `ak:advise`, `ak:plan`, `ak:test`, and `ak:code-review` document `--ultra` behavior.
- [x] `ak:plan` documents `--debate`, invalid `--two --ultra`, bounded rounds, and no implementation authority.
- [x] `ak:sumup`, `ak:sowat`, and `ak:bro` have portable metadata, security boundaries, and fixed outputs.

## Implementation Steps

1. Update canonical SKILL.md and shared references.
2. Validate names, line/description limits, and cross-references.
3. Synchronize only these skill directories to four mirrors.

## Success Criteria

- [x] Unknown flags and incompatible combinations have explicit stop/help text.
- [x] Default no-flag path is explicitly unchanged.
- [x] `validate-skill-crossrefs.py` passes for canonical source and all four mirrors.

## Risk Assessment

- **Risk**: prompt text implies verifier truth or blends candidates.
- **Mitigation**: shared contract reference and hard veto language.
- **Rollback/recovery**: revert only canonical/mirror skill files.

## Evidence and Handoff

- **Required gate**: quick validation plus mirror hash parity.
- **Owner**: integration controller.
- **Next phase dependency**: adapter consumes stable skill tree.
