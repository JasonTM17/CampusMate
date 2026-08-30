---
title: "AgentKit stable-compatible: Ultra Verifier, Debate, utility skills và Antigravity CLI"
description: "Add opt-in verifier/debate workflows, utility skills, Antigravity projection, runtime denylist, and Grok interoperability within AgentKit."
status: completed
priority: P1
effort: large
tags: [agentkit, ultra, antigravity, compatibility]
created: 2026-08-27
---

# AgentKit stable-compatible: Ultra Verifier, Debate, utility skills và Antigravity CLI

## Outcome Contract

- **Outcome**: AgentKit có protocol `ak.ultra/v1`, năm skill hiện hữu nhận `--ultra`, `ak:plan` nhận `--debate`, ba utility skill mới, adapter/validator Antigravity CLI, denylist cứng cho DeepSeek Harness/Pi/OMP, và Grok interoperability được kiểm thử trong ranh giới AgentKit.
- **Success signal**: canonical source và bốn mirror parity; focused và existing gates PASS; AGY fixture chuyển đổi an toàn; AgentKit được Grok inspect/live-smoke; capability matrix không quảng bá native runtime khi chưa có bằng chứng.
- **Target identity**: baseline `main` at `fe980169c52443e0d65f78e7ddd95b7fdb9e0902`.
- **In scope**: the current AgentKit checkout, its Grok-compatible project
  surfaces, dispatchers, adapter tests/docs, and read-only runtime inspection.
  ClaudeKit is explicitly outside this release scope and is not modified.
- **Non-goals**: rewriting ClaudeKit canonical skills/workflows; xóa binary/config/dữ liệu Pi/OMP/DeepSeek; provider auth, deployment, production cutover; sửa binary `ak` global.
- **Authority**: repo-local implementation/tests and the explicit AgentKit
  release plan; no push or external publication without a separate explicit
  authorization. No global user configuration or ClaudeKit checkout changes.
- **Stop conditions**: secret/path-safety finding, mirror drift, unsupported AGY contract, failed required gate after bounded repair, or any scope change requires user/authority decision.

## Phases

| # | Phase | Status | Gate |
|---|-------|--------|------|
| 1 | [Foundation and contracts](./phase-01-start.md) | Completed | contract/denylist validator PASS |
| 2 | [Skills and workflow flags](./phase-02-skills-and-workflows.md) | Completed | cross-reference and syntax PASS |
| 3 | [Antigravity adapter and installer](./phase-03-antigravity-adapter.md) | Completed | adapter fixtures PASS; live status honest |
| 4 | [Mirrors, manifests, and docs](./phase-04-mirrors-and-docs.md) | Completed | parity/generator/secret gates PASS |
| 5 | [Terminal verification and review](./phase-05-verification-and-review.md) | Completed | final gates/reviews recorded; release HOLD for capability blockers |

## Acceptance Matrix

| Requirement | Evidence | Required result |
|---|---|---|
| Ultra protocol is immutable, bounded, non-blending | `test_ultra_verifier.py` + contract doc | PASS |
| Five skills support opt-in `--ultra`; plan supports `--debate` | canonical/mirror SKILL.md and crossrefs | PASS; default path unchanged |
| `ak:sumup`, `ak:sowat`, `ak:bro` exist without alias collision | four mirror inventories + validator | PASS |
| AGY project/global projection is safe and portable | adapter tests/fixture + installer tests | PASS or explicit BLOCKED_CAPABILITY |
| DSH/Pi/OMP are unsupported and never silently dispatched | denylist negative tests | PASS |
| ClaudeKit Grok boundary is adapter-only; no canonical workflow drift or secret/host leakage | scoped diff + adapter/hook tests + inspect | PASS |

## Verification and Recovery

- Focused gates: `test_ultra_verifier.py`, `test_antigravity_adapter.py`, `validate-skill-crossrefs.py`.
- Existing gates: project assets, install manifest, Gemini/OpenCode/Grok generators/validators, installer test, `git diff --check`.
- Runtime gates: `ak` 2.7.0 native target/flag checks are `BLOCKED_CAPABILITY` until a supported minimum is installed; `agy` auth failures are `NOT_RUN`.
- Rollback: revert only AgentKit commits/files; remove only ownership-marked AGY outputs; never reset/clean or touch foreign files.

## Handoff

- **Current decision**: HOLD (AgentKit-local gates and independent reviews pass;
  AGY default discovery, `ak` CLI native flags, and provider-auth evidence remain
  capability blockers. ClaudeKit is out of scope and not part of this release.)
- **Commit/push/CI state**: no commit or push authorized yet; report local evidence separately.

## Additive Execution Control

- **Plan lock**: execute the first incomplete phase and preserve all gates.
- **Execution ledger**: `plans/20260827-agentkit-ultra-agy/reports/execution-ledger.md`
- **Replan authority**: direct user instruction or evidence-backed Advisor/Kongming/Wukong finding.
- **Repair ceiling**: two focused attempts plus one specialist-guided attempt per failing gate.
- **Deferred queue**: polish, unrelated cleanup, provider/deployment work, and unsupported runtime implementation.

<!-- slug: agentkit-ultra-agy -->
