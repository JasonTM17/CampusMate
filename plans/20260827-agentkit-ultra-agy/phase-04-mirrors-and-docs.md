---
phase: 4
title: "Mirrors, manifests, and docs"
status: completed
priority: P1
dependencies: [2, 3]
---

# Phase 4: Mirrors, manifests, and docs

## Overview

Regenerate derived adapters and metadata from canonical source, document the
capability matrix, and ensure ClaudeKit isolation and secret hygiene.

## Requirements

- [x] Four skill mirrors and generated manifests are byte/hash consistent.
- [x] Kit metadata and plugin inventory include exactly the three new skills.
- [x] AGENTS/README/adapter docs state AGY paths, unsupported hooks, and excluded runtimes.

## Implementation Steps

1. Sync canonical skill directories and update plugin/manifest metadata.
2. Run Gemini/OpenCode/Grok generators in check mode and update docs.
3. Scan diff for secrets, host paths, `/ck:` aliases, and ClaudeKit references.

## Success Criteria

- [x] All manifest/generator validators pass.
- [x] ClaudeKit repository has no changed files.
- [x] `test_agentkit_isolation.py` confirms selected-registry parity, no duplicate
  runtime registry, no `/ck:` alias, no local ClaudeKit path, and a clean
  explicit ClaudeKit Git root.
- [x] `git diff --check` and targeted changed-file secret scan pass.

## Packaging ruling

The authoritative runtime capability registry is the committed root
`.agentkit/runtime-capabilities.json`. The installer copies the complete root
`.agentkit/` project asset, while `engineer/.agentkit/install-manifest.json`
continues to describe the inner Engineer kit package. Keeping these two scopes
separate avoids a second registry and preserves the existing distribution
layout.
