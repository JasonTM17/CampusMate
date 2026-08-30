# Execution Ledger

Active plan: `plans/20260827-agentkit-ultra-agy/plan.md`

## Baseline

- Timestamp: 2026-08-27
- Repository: current AgentKit checkout (host path intentionally omitted)
- Branch/HEAD: `main` / `fe980169c52443e0d65f78e7ddd95b7fdb9e0902`
- Remote: `origin` (repository URL intentionally omitted from durable evidence)
- Initial worktree: clean
- Skill counts: canonical and four mirrors each 100 `ak-*` directories
- Known installed CLI evidence: `ak 2.7.0`; current `agy 1.1.22` resolves on PATH
- Scope guard: AgentKit only; ClaudeKit, Pi/OMP/DeepSeek data, credentials, and IDE state protected

## Progress

| Phase | Status | Evidence | Notes |
|---|---|---|---|
| 1 | Completed | `test_ultra_verifier.py` 13 OK; `test_runtime_targets.py` 3 OK | immutable envelope, trusted verifier assessments, hard denylist |
| 2 | Completed | five skill mirrors + three utility skills; crossrefs 107/0/0 in all five trees | flags opt-in; default paths documented unchanged |
| 3 | Completed | `test_antigravity_adapter.py` 27 OK; installer PASS; AGY live discovery/read-only probes PASS | AGY 1.1.22 signed; hooks unsupported; PATH added once, profile unchanged; external HMAC ledger authorizes refresh, hardlink/reparse and backup-integrity guards are active, transient/auth files are filtered, stale removals are backed up, rollback snapshots ownership before removing child files, validates previous-ledger backup integrity, and marker-only API calls are rejected |
| 4 | Completed | Gemini/OpenCode/Grok validators PASS; manifest 1508; project-assets PASS; mirror parity 10x4; `git diff --check` PASS | canonical source remains `engineer/skills`; root `.agentkit/runtime-capabilities.json` is the single project capability registry and is copied with the shared `.agentkit` asset; no duplicate registries; Grok hook settings have 19 unique commands and `scout-block` fail-opens on empty stdin while preserving structured path blocks |
| 5 | In progress | repaired Kongming/Wukong blockers; terminal gates green on repaired snapshot; final independent review pending | freeze exact working-tree identity before review |

## Authorized rulings

- Treat the supplied plan as the locked outcome contract.
- Keep new flags opt-in; preserve no-flag behavior.
- Do not patch the global `ak` binary to simulate unsupported native features.
- AGY auth failures are `NOT_RUN`; unsupported nested-agent behavior is `BLOCKED_CAPABILITY`.
- Isolation ruling: executable/emitted AgentKit surfaces and every `SKILL.md`
  must contain no local ClaudeKit path or `/ck:` alias. The unchanged
  `engineer/.agentkit/schemas/ck-config.schema.json` is an explicit legacy
  `.ck.json` editor/config compatibility artifact; no adapter loads or emits
  it, so changing its URI/storage defaults would create a compatibility and
  data-location risk outside this release.
- AGY preflight: SHA-256 `059B96C1069206158D340EE2A8912894ECA5002195E62B8CD281C26C01CD794E`, Authenticode `Valid`, signer `Google LLC`, `--version` `1.1.22`; `--help`, `agent`, `agents`, `models`, `/skills` with `--add-dir`, allowlisted advisor and read-only fixture probe all exited 0/SUCCESS. No provider-auth call was attempted.
- AGY installer setup added exactly one user PATH entry
  (`%USERPROFILE%\.gemini\bin`); PowerShell profile was absent before/after,
  and no other PATH entry was removed. Rollback requires restoring the
  preflight user PATH snapshot held for this run.

## Deferred findings

- Any provider authentication, deployment, production parity, or further global profile mutation.

## Terminal gate matrix

- `test_ultra_verifier.py`: PASS (14 tests)
- `test_runtime_targets.py`: PASS (3 tests)
- `test_antigravity_adapter.py`: PASS (28 tests)
- `test_agentkit_isolation.py --claudekit-root <explicit ClaudeKit root>`: PASS;
  ClaudeKit status clean
- `validate-skill-crossrefs.py`: PASS for all five registries (107 skills,
  39 outward references, 0 broken, 0 ambiguous each)
- `validate-project-assets.py`: PASS
- `generate-install-manifest.py --check`: PASS (1508 files)
- Gemini/OpenCode/Grok generators and validators: PASS (106/17/107, 106/17,
  and 107/106/17 respectively); Grok live inspect PASS; Grok validator rejects
  duplicate hook commands and requires the `scout-block` empty-stdin guard
- `validate-wukong-integration.py` and `test_install_manifest.py`: PASS
- `test-install-agentkit.ps1`: PASS, including AGY rollback-failure reporting;
  PowerShell parser, Python compile, mirror parity, changed-file secret scan,
  and `git diff --check`: PASS with no line-ending warnings after LF
  normalization
- Full `python -m unittest discover -s engineer/.agentkit/scripts -p "test_*.py"`:
  PASS (55 tests)

## Final-gate preparation

- First final-review wave on snapshot
  `8d11bd84243ea155b344df62cd50b1f5717d81ad3b216b0759336a45c81888d7` is
  superseded. Advisor passed, but Kongming held acceptance on the
  `--ultra --debate` peer-visibility contradiction and AGY rollback failure
  reporting. Wukong returned `INCONCLUSIVE` because the read-only review sandbox
  could not run AGY hostile-fixture tests and requested a reparse-swap probe plus
  broader hook-surface isolation.
- Repairs after that superseded wave:
  - `ak:plan --ultra --debate` now keeps Ultra candidates isolated through the
    verifier and runs debate only as a post-selection challenger/red-team phase.
  - Ultra regression now asserts the combined mode preserves
    `peer_output_visible: false` and forbids blending/mutating the winning
    candidate.
  - AGY installer rollback failures are surfaced with manifest/manual-recovery
    guidance; installer regression injects a failing rollback generator.
- AGY atomic writes record a parent directory identity and recheck it before
  final replace; hostile fixture now swaps a parent to a reparse path between
  preflight and replace and expects fail-closed behavior.
- AgentKit isolation scan now includes active Codex, Claude-compatible/Grok,
  and Cursor hook/config surfaces.
- Repository line-ending policy now pins text files to LF through
  `.gitattributes`, and changed files were normalized so `git diff --check`
  emits no warnings.
- Repaired snapshot for the next review wave is computed outside this ledger and
  passed in the reviewer prompt. Do not write that current content hash into the
  ledger before review, because the ledger edit itself changes the hash. Stable
  identity fields at this point: branch `main`, HEAD
  `fe980169c52443e0d65f78e7ddd95b7fdb9e0902`, 7576 files, 84 Git status
  entries, 0 deleted files.

## Final security and parity checkpoint (2026-08-28)

- Security hook inputs are now fail-closed across all four AgentKit mirrors:
  empty, malformed, null, missing `tool_input`, and array-shaped `tool_input`
  payloads exit 2; safe paths exit 0; blocked paths exit 2. The Claude/Grok
  dispatcher additionally validates the payload shape before dispatch, bounds
  child hooks at 5 seconds, and blocks security-hook timeout/abnormal-exit
  paths while retaining bounded fail-open behavior only for non-security hooks.
- Cursor's shared hook dependency `ak-prefs-client.cjs` was missing from the
  mirror and caused a safe privacy hook to crash. The canonical module is now
  shipped at `.cursor/hooks/lib/ak-prefs-client.cjs`; asset validation asserts
  this dependency and direct Cursor probes pass safe-read and sensitive-read
  cases.
- Focused Grok validator tests pass (16/16), Ultra verifier (18/18),
  Antigravity adapter (28/28), runtime targets (3/3), and the complete AgentKit
  script suite passes (67/67). Project-assets, skill cross-references,
  install-manifest, Gemini, OpenCode, Grok, Antigravity, runtime-denylist,
  PowerShell installer, Python compile, Node syntax, and `git diff --check`
  gates pass. The installer test's intentional rollback-failure warning was
  observed and correctly surfaced by the test oracle.
- High-confidence secret scan found zero AWS/GitHub/Slack/private-key/bearer
  literals. AgentKit-only isolation passes; the explicit external ClaudeKit
  isolation check remains a truthful FAIL because `D:\Claude_Kit\Claude_Kit`
  has pre-existing modified/untracked files. No cleanup or overwrite was done.
- Grok 1.0.5 live inspect from this checkout reports 107 project AgentKit
  skills with unique normalized names, including `ak:plan`, `ak:sumup`,
  `ak:sowat`, and `ak:bro`; read-only smoke returned the expected marker.
  Grok reports zero active hooks in its inspect payload and `projectTrusted`
  false; authenticated provider behavior is not claimed.
- Antigravity 1.1.22 signed binary/version/help/models pass. Default
  `--print /skills` discovers only built-ins; explicit
  `--add-dir D:\Agent_Kit\Agent-Kit\.agents\skills` discovers AgentKit skills
  and the read-only prompt returns the expected marker. Default workspace
  discovery remains `BLOCKED_CAPABILITY`, not a failed adapter.
- The installed `ak` CLI remains 2.7.0, so native CLI flag/target checks for
  the newer release contract remain `BLOCKED_CAPABILITY`; markdown skill
  contracts and static regressions are verified. No commit, push, or provider
  authentication was performed. The next action is a fresh read-only review on
  the exact post-check snapshot after this ledger append.

## Live Antigravity evidence

- Binary preflight: version `1.1.22`, Authenticode `Valid`, signer `Google LLC`,
  SHA-256 recorded in the prior AGY preflight ruling.
- A disposable Git fixture emitted 1414 workspace outputs after transient,
  credential, and cache filtering. `agy --add-dir`
  discovered all 17 projected agents, all three new skills through `/skills`,
  and answered the read-only prompt `READY` with `SUCCESS`.
- After committing only the disposable fixture contents inside that temp Git
  repository, the same read-only AGY prompt left `git status --short` at 0 before
  and after the prompt.
- Authenticated provider routing was not attempted: `NOT_RUN`, not PASS.

## Independent review results

- Pending fresh review on the repaired snapshot identified in the reviewer
  prompt.
- Attempted fresh Advisor/Kongming/Wukong/code-review via `codex exec` on
  2026-08-28. All four attempts failed before model review because the local
  Codex CLI/OpenAI session could not refresh authentication (`token_revoked` /
  `token_invalidated` / `refresh_token_invalidated`). Treat the independent
  review wave as `NOT_RUN_AUTH`, not PASS and not a repository failure.
- A later `codex exec -m gpt-5.6-terra ... "AUTH_OK"` auth probe failed with
  the same 401/token-revoked family before producing model output. Local refresh
  gates rerun after that probe remained green: full unittest discover 55 OK,
  install manifest check PASS, AGY validator PASS (1414 outputs), Grok validator
  PASS (`live_grok_inspect=PASS`), and `git diff --check` emitted no output.
- The earlier review findings are not release-acceptance evidence for the
  repaired snapshot; run Advisor/Kongming/Wukong/code-review again after this
  ledger update and rerun affected gates if any implementation file changes.

## Latest repairs

- AGY rollback now snapshots ownership before mutation so generated owner
  markers are removed/restored together with their managed files.
- AGY relative-path validation rejects drive-relative paths and NTFS alternate
  data stream syntax; hand-edited owner digests cannot authorize a refresh.
- AGY refreshes now use a stable external ledger under the configured state
  root; marker/file tampering blocks preflight, and source-removed managed
  files are backed up before removal and restored by the manifest rollback.
- AGY generated agent bodies sanitize absolute and runtime-specific skill paths
  to the project-local `.agents/skills` registry.
- AGY generated agent bodies also scrub local ClaudeKit storage/config paths;
  the fixture regression covers this boundary without modifying ClaudeKit.
- Marker-only AGY library calls are now rejected before mutation; no destination
  marker can authorize a refresh without the external ownership ledger.
- AGY source and destination hardlinks/reparse paths are rejected; writes use
  atomic replacement, and rollback verifies a recorded backup digest before
  restoring an existing file. Canonical agent descriptions are scrubbed and
  duplicate/unavailable skill references are rejected.
- AGY rollback now rejects a tampered previous external-ledger backup instead
  of silently falling back to the current ledger during restore.
- AGY parent directories are rechecked by identity before final atomic replace,
  and a symlink/junction swap between preflight and replace fails closed.
- AGY project-installer rollback errors are no longer swallowed; they are
  surfaced with the rollback manifest and manual recovery command context.
- `--ultra --debate` is post-selection only, preserving candidate isolation and
  forcing any accepted repair through a new evidence digest.
- Grok hook failures seen as `[hooks: failed]` were traced to the
  Claude-compatible hook layer, not missing AgentKit skills. `scout-block`
  now treats empty stdin as warn/exit 0 for Grok `PreToolUse`, duplicate
  prompt hooks were removed, and the validator/installer tests guard both
  regressions. Structured blocked-path payloads still exit non-zero.

## Packaging ruling

- The committed root `.agentkit/runtime-capabilities.json` is authoritative for
  installer target dispatch. The installer copies the complete root `.agentkit`
  project asset; `engineer/.agentkit/install-manifest.json` remains the inner
  Engineer package manifest and intentionally does not duplicate the root
  project registry.

## Superseded resume point

After the user refreshes Codex CLI/OpenAI auth, recompute the repaired snapshot
identity and rerun the fresh independent review wave. If it returns PASS/no
blocker, mark the plan completed and run the final identity check.

## Current continuation update

- Current local verification rerun: full script unittest PASS (53/53);
  cross-reference audit PASS for all five registries (107 skills, 39 outward
  references, 0 broken, 0 ambiguous each); project-assets PASS; install manifest
  regenerated and validated at 1508 files; Gemini/OpenCode/Grok/AGY validators
  PASS; installer PASS; PowerShell parser, Python compile, secret scan, hook
  smoke, ClaudeKit clean check, and `git diff --check` PASS.
- Grok hook compatibility check: empty `scout-block.cjs` stdin exits 0 with a
  warning, while a structured `Read` payload targeting `node_modules` still
  exits 2 and remains blocked.
- Live AGY rerun: binary `agy 1.1.22` has a valid Google LLC signature and the
  same SHA-256 recorded above; a disposable Git fixture emitted 1414 outputs,
  `/agents` discovered all 17 agents, `/skills` discovered the projected skill
  registry including `ak:bro`, `ak:sowat`, and `ak:sumup`, and the read-only
  prompt returned `READY`.
- Snapshot before this ledger update:
  `023bbfe3e269eda60ff02644a22f0789ebb06da868e532940a6722e3b8aa9cd3`,
  branch `main`, HEAD `fe980169c52443e0d65f78e7ddd95b7fdb9e0902`, 7576 files,
  83 Git status entries.
- Current-hash Advisor/Kongming/Wukong rerun attempts were
  `BLOCKED_CAPABILITY`: the AgentKit runtime path was blocked by Codex
  trusted-directory checks, and direct `codex exec --cd <repo>
  --skip-git-repo-check --ephemeral -s read-only` with `gpt-5.5` then failed
  because the Codex/ChatGPT auth token was revoked (`token_revoked` /
  `refresh_token_invalidated`). No repo files were changed by those review
  attempts.

## Next resume point

Reauthorize the Codex CLI session, then rerun Advisor/Kongming/Wukong and the
final code-review checkpoint on a freshly computed current snapshot. Do not
reuse the prior review snapshot without confirming the hash.

## Post-EOF Grok hook repair

- The dispatcher now keeps the 750ms empty-input fast path, validates buffered
  JSON before dispatch, holds non-empty partial input for a 5s deadline, and
  blocks incomplete payloads for `scout-block.cjs`/`privacy-block.cjs`. Child
  hooks are capped at 5s and timeout with a warning/exit 0 so Grok cannot hang
  on one non-blocking hook.

## Final terminal verification checkpoint (2026-08-28)

- Canonical Ultra verifier hardening now covers short bearer values in addition
  to PEM, cloud access-key, JWT, environment-assignment, and unknown metadata;
  the new regression and the full verifier suite pass (18/18 focused, 63/63
  repository script tests).
- Canonical verifier and all four runtime mirrors have one SHA-256; the
  cross-mirror adversarial probe redacts private-key, AWS, bearer, environment,
  and unknown-field values in every copy.
- Cross-reference, project-assets, runtime-target, isolation, manifest,
  Gemini, OpenCode, Grok, Antigravity, installer, and `git diff --check` gates
  pass. Unsupported DeepSeek Harness/Pi/OMP remain explicit denylisted
  targets; no fallback dispatch is enabled.
- Grok 1.0.5 read-only smoke returned `GROK_AGENTKIT_LIVE_OK` and
  `GROK_AK_PLAN_READ_OK`; project inspect reports hooks empty and AgentKit
  skills from `.agents/skills`. Grok still loads Claude-compatible MCP names
  from the user `.claude.json` even when the documented compat MCP switches
  are false; this is a runtime limitation and no user config was changed.
- Antigravity 1.1.22 is signed and live: `--version`, `--help`, `models`, and
  an explicit `--add-dir .agents/skills` discovery/read-only prompt pass.
  Without `--add-dir`, the CLI lists only five built-in skills; default
  workspace discovery is therefore `BLOCKED_CAPABILITY`, not a claimed pass.
- Wukong independently returned `NOT_FALSIFIED` for verifier, denylist,
  adapter safety, and isolation on the pre-ledger snapshot; code review
  independently returned `PASS` with no findings on that same snapshot. The
  ledger append changes the snapshot, so both reviews must be refreshed before
  release readiness is concluded.

## Security-hook repair checkpoint (2026-08-28)

- A fresh independent code review found a high-severity guardrail regression:
  security hooks could treat empty stdin as allowed. The four AgentKit
  `scout-block.cjs` mirrors now fail closed for empty, malformed, invalid-shape,
  and unexpected-error input; the Claude/Grok dispatcher also fail-closes
  security-hook empty input, partial JSON, child timeout, and abnormal exit,
  while retaining bounded fail-open timeout behavior only for non-security
  hooks.
- Added regression coverage for empty security payloads and security child
  timeout. Focused Grok adapter tests pass (14/14), Ultra verifier tests pass
  (18/18), and the complete AgentKit script suite passes (65/65). Direct hook
  probes confirm empty/malformed/truncated input blocks (exit 2), safe paths
  allow (exit 0), and blocked paths block (exit 2).
- README AGY wording now limits the claim to signed binary, explicit
  `--add-dir` skill discovery, and read-only inference; default discovery,
  nested-agent discovery, and hook parity remain unproven/blocked as
  capability limitations.
- The next frozen snapshot must be reviewed independently after this
  checkpoint; no release or commit readiness is inferred from the prior review.
- Regression coverage now includes a delayed two-chunk blocked `Read` payload
  and a closed/truncated payload; both remain blocked (exit 2). Empty stdin
  remains allow/exit 0 in both installed projects.
- Final local gates after this repair: full AgentKit unittest PASS (57/57),
  Grok validator test PASS (11/11), project-assets PASS, manifest check PASS
  (1508 files), Gemini/OpenCode/Grok/AGY validators PASS, runtime denylist
  PASS, installer PASS under pwsh 7, isolation PASS with ClaudeKit clean,
  secret scan PASS, and `git diff --check` PASS.
- Grok live discovery in `D:\Student_Management` and `D:\HealthCare_Project`
  reports `ak-agentkit` exactly once, 19 hooks, zero same-event duplicates,
  and zero inspect failures. Authenticated model inference was not claimed;
  the host's global Claude MCP set remains an external startup-latency factor.
- The Grok validator now rejects duplicate canonical skill frontmatter names and
  fails live discovery if Grok reports the same project AgentKit name twice.

## Security hook late-input hardening

- The dispatcher now keeps the security-hook grace window open when no first
  byte has arrived at the 750ms fallback. It validates any payload delivered
  before the 5s deadline and blocks an incomplete final buffer; non-security
  hooks retain the fast empty-input path.
- An abnormal child exit with no status is now fail-closed for
  `scout-block.cjs`/`privacy-block.cjs`; non-security hooks keep the documented
  warning/allow behavior. Canonical and both installed project dispatchers are
  byte-identical after the repair.
- Focused regression now covers a first byte delayed beyond the short fallback,
  and the static validator/test guard covers abnormal security-child handling.

## User-authorized ClaudeKit Grok compatibility extension

- Scope was explicitly expanded by the user after the AgentKit-only plan was
  drafted. Changes are limited to `D:\Claude_Kit\Claude_Kit` Grok boundary
  assets: `.claude/hooks/run-claudekit-hook.cjs`, empty-input behavior in
  `scout-block.cjs`, Grok adapter regression tests, README guidance,
  `.grok/config.toml`, and the generated release manifest. ClaudeKit canonical
  skills, workflow rules, and non-Grok mirrors were not rewritten.
- ClaudeKit adapter test is PASS (9/9), the hook dispatcher suite is PASS (3/3),
  and the complete hook suite is PASS (633/633). The adapter generator reports
  178 skills with unique normalized names.
- Grok 1.0.5 live inspect from ClaudeKit is trusted, has 201 total skills,
  zero duplicate names, zero config warnings, and 178 project skills resolved
  from `.grok/skills`. A read-only `grok --single` smoke returned `OK` after a
  clean process start.
- Grok user config was repaired at `C:\Users\Admin\.grok\config.toml`:
  unsupported `[privacy]` was removed, duplicate Cursor skill/hook scanners
  and Claude skill scanner were disabled, and Claude MCP auto-import was
  disabled. `~/.claude.json` and its credentials were not modified.
- Grok 1.0.5 still prints preflight `skill name does not match expected name`
  diagnostics for ClaudeKit's canonical `.agents/skills` mirror before the
  ignore/filter stage. The resolved inspect registry excludes that mirror, so
  this is recorded as an upstream diagnostic limitation, not a kit failure.
- Final focused gates after the extension: AgentKit ultra/AGY/crossref/assets,
  install manifest, Gemini/OpenCode/Grok/runtime validators and `git diff
  --check` PASS; ClaudeKit release-manifest check PASS. Commit/push remain
  unauthorized and therefore not performed.

## Independent review repair checkpoint

- Initial independent Wukong and code-quality review found three verifier gaps:
  the digest was only compared as an arbitrary shared string, metadata redaction
  inspected keys but not scalar values, and redispatch was not bounded globally
  or restricted to failed candidates.
- Canonical `ak-common/scripts/ultra_verifier.py` now requires a trusted
  `evidence` object and recomputes `evidence_sha256`, scrubs credential-shaped
  values including bearer and environment assignments, and enforces one global
  redispatch only for timeout/error/failed candidates.
- The contract and all four mirrors were synchronized. New regression cases
  cover digest tampering, double redispatch, usable-candidate redispatch,
  bearer values, and raw environment assignments.
- Repair verification: Ultra verifier 17/17; full AgentKit unittest 62/62;
  crossrefs, project assets, install manifest, Gemini, OpenCode, Grok,
  Antigravity, runtime denylist, isolation, and `git diff --check` all PASS.
- AGY atomic replacement retains a documented non-kernel TOCTOU residual; no
  absolute sandbox guarantee is claimed. Final independent review must be
  rerun against the repaired snapshot before release status changes.

## Terminal verification rerun (2026-08-28)

- The repaired Antigravity adapter regression suite passes 29/29, including
  UTF-8/BOM/CRLF projection, collision and rollback guards, traversal/link
  rejection, forbidden `.claudekit` path scrubbing, and stale-removal parent
  reparse swap fail-closed coverage.
- The complete AgentKit script suite passes 68/68. Focused Ultra verifier,
  Grok validator, runtime-target, and AgentKit isolation gates pass; the
  install manifest is current at 1508 files.
- Project-assets, cross-reference, Gemini, OpenCode, Grok, Antigravity,
  runtime-target, Wukong integration, installer, targeted Node/Python syntax,
  and `git diff --check` gates pass. Direct security-hook and dispatcher
  probes return exit 2 for empty/malformed/blocked payloads and exit 0 only
  for safe payloads.
- Live Grok 1.0.5 read-only prompt returned `GROK_FINAL_SKILL_OK`. Live AGY
  1.1.22 version/help/models passed; explicit `--add-dir .agents/skills`
  discovered AgentKit skills and returned `AGY_FINAL_SKILL_OK`. AGY default
  discovery still exposes only built-ins and remains `BLOCKED_CAPABILITY`.
- No authenticated provider claim, ClaudeKit cleanliness claim, commit, push,
  or production-readiness claim is made by this checkpoint.

## Terminal verification correction (2026-08-28)

- The prior historical notes describing empty security-hook stdin as allow/exit
  0 are superseded. Current canonical and mirrored security hooks fail closed
  with exit 2 for empty, malformed, incomplete, array, and empty-object
  (`tool_input: {}`) payloads; only non-security hooks retain bounded timeout
  fail-open behavior.
- The Grok validator fixture now restores every patched module global after
  each test and asserts its contract path is the temporary fixture. This
  prevents a validator regression from overwriting the repository `AGENTS.md`.
  The current Grok validator suite is 17/17 and leaves the real contract intact.
- Canonical `.claude/settings.json` now has one deduplicated
  `UserPromptSubmit` group (19 total commands); Grok validator and installer
  duplicate-hook gates pass. Documentation in `README.md`, `docs/INSTALL.md`,
  and the release note now describes the same fail-closed security behavior.
- Current focused/terminal evidence: Antigravity 32/32, Ultra 18/18, complete
  AgentKit unittest 73/73, cross-reference 107/0/0, project-assets PASS,
  install manifest check PASS (1508 files), Gemini/OpenCode/Grok/Antigravity
  validators PASS, runtime denylist 3/3, Wukong integration PASS, installer
  PASS, AgentKit-only isolation PASS, and `git diff --check` PASS.
- AGY explicit `--add-dir .agents/skills` discovery/read-only smoke remains
  proven; default discovery remains `BLOCKED_CAPABILITY`. `ak 2.7.0` cannot
  prove newer native flags/targets. External ClaudeKit remains dirty and is
  outside this AgentKit scope. No commit, push, or production-readiness claim
  is made; freeze and independent review are still required.

## Final security-child correction (2026-08-28)

- Wukong identified that a security child returning status `1` or a non-timeout
  spawn error could escape as exit `1`. The Grok dispatcher now maps those
  unexpected security failures to `blockSecurity(...); exit 2`, while preserving
  ordinary non-security hook behavior and the intentional security status `2`.
- Added a live subprocess regression for a valid payload plus `scout-block`
  `exit 1`; it now returns exit `2` with an explicit blocking diagnostic. The
  Grok validator static contract also requires both spawn-error and unexpected
  status normalization.
- Post-repair evidence: Grok focused suite 18/18, full AgentKit unittest
  74/74, Antigravity 32/32, Ultra 18/18, project-assets PASS, crossrefs
  107/0/0, manifest 1508/check PASS, Gemini/OpenCode/Grok/Antigravity
  validators PASS, runtime targets 3/3, isolation PASS, Wukong integration
  PASS, installer PASS, and `git diff --check` PASS.
- This is the final implementation snapshot for independent review. Remaining
  capability blockers are unchanged: AGY default discovery and `ak 2.7.0`
  native flags are unproven, Grok auth/trusted hooks are not claimed, and the
  external ClaudeKit worktree is dirty and out of scope. No commit or push has
  been authorized or performed.

## Antigravity rollback backup-integrity correction (2026-08-28)

- Independent code review found a P1 rollback gap: after an authenticated
  manifest, deleting a required `existed=true` backup could make rollback fall
  through to deleting the current managed destination. The adapter now
  prevalidates every required backup (scope, reparse/hardlink, existence, and
  digest) and revalidates it immediately before restoration; missing or altered
  backups raise `AdapterError` before any destination mutation. Ownership-state
  backup errors retain their dedicated diagnostic.
- Added a regression that deletes an existing projection backup and proves
  rollback rejects without deleting the destination; the tampered-backup test
  now likewise requires fail-closed rejection. AGY focused tests are 33/33 and
  full AgentKit unittest is 75/75.
- After this repair, manifest regeneration/check remains PASS at 1508 files;
  project-assets, crossrefs, Grok/Gemini/OpenCode/Antigravity/runtime validators,
  AgentKit-only isolation, installer, and `git diff --check` all pass. The
  exact post-ledger snapshot must be recomputed and independently reviewed;
  prior review identities are stale by policy.

## Antigravity path-boundary correction (2026-08-28)

- Independent code review found a P2 projection gap where punctuation directly
  before `foo/Claude_Kit/...` bypassed the sanitizer. The forbidden-path matcher
  now uses an alphanumeric-negative boundary so parenthesized, bracketed,
  braced, and assignment-prefixed ClaudeKit paths are scrubbed without
  consuming the punctuation. Dedicated fixtures cover all four forms plus the
  existing POSIX, UNC, root-relative, drive-relative, and `.claudekit` forms.
- AGY focused tests remain 33/33 and the full AgentKit unittest remains 75/75;
  this correction is limited to projection sanitization and does not alter
  runtime selection or user data. A fresh exact snapshot/review is required
  after the manifest is regenerated.

## Final path-safety corrections (2026-08-28)

- Wukong found Ultra hard-veto coverage gaps for Windows drive-relative,
  root-relative, and UNC path forms. `_UNSAFE_PATH` and all four runtime mirrors
  now reject `C:outside`, `\\outside`, and `//server/share` while preserving
  URI safety for `https://...`; focused Ultra coverage includes these forms and
  mirror parity remains byte-identical.
- Code review found generic project installation could follow an existing
  `.claude` junction outside the project root. `install-agentkit.ps1` now
  rejects any existing reparse-point ancestor during both preflight and copy,
  and the installer regression proves no outside target is written. The
  installer test passes with the new parent-junction case.
- Current verification after these repairs: Ultra 18/18, AGY 33/33, Grok 18/18,
  full AgentKit unittest 75/75, installer PASS, and all adapter/manifest/assets/
  isolation/diff gates previously green. Regenerate the manifest once more and
  obtain fresh independent reviews; no commit or push is authorized.
