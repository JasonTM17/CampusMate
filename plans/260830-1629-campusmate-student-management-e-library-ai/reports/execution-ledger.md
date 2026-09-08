# Execution Ledger — CampusMate

plans/260830-1629-campusmate-student-management-e-library-ai/plan.md

## Active plan identity

- Plan: CampusMate — Student Management + E-Library + Personalized AI (archetype: Feature)
- Created: 2026-08-30 · Status: `in-progress` (phase-08 implemented out-of-order per user authority: chatbot FE/BE fully built)
- Workflow: goal-warmup → scout → plan (+ plan-lock) → cook (code mode) → test → code-review
- Advisory evidence: Kongming GO-WITH-CONDITIONS (7 điều kiện đã nhúng phase); Wukong NOT_FALSIFIED / PROCEED_WITH_RESIDUAL_RISK (2026-08-30)
- Plan delta (user-authorized 2026-09-01): phase-08 implemented before phase-03..07 because the user requested the chatbot interface be completed end-to-end first; phases 03-07 (academic, dashboard, library, reader) remain pending.

## Phase 08 (AI Core) — implemented 2026-09-01/02

| Stage | What | Evidence / commit |
|---|---|---|
| 0 — theme repair | Migrate callers to DESIGN.md tokens, fix lBottom, restore nav/input themes, dark palette, bundle Inter (OFL) | `076df99` |
| 1 — streaming spike | Mock `Stream<String>` endpoint → Flutter client receives token-by-token (live, ~2s). ADR-008 records WebSocket decision. SSE fallback intentionally NOT built. | `de9f2ef` |
| 2 — auth | Serverpod email identity (real): register (code from dev log) → login → JWT refresh. Mobile: Login/Registration screens, typed `AuthFailure`s, `SessionAuthKeyProvider` auto-refresh, restore-across-restart. 41 tests. | `d3f19df` |
| 3 — AI provider | `campusmate_shared` (AiRequest/AiStreamChunk/AiCitation); `AiProvider` + `FakeAiProvider` (deterministic) + real `OpenAiCompatibleProvider` (SSE); factory by `AI_PROVIDER`. 7 unit tests. | `2ff2356` |
| 4 — endpoint | Migration `ai_conversations`/`ai_messages`/`ai_usage`; `AiEndpoint` async* streaming + persistence + per-user isolation (§31 every query). Integration test written (needs Docker to run). | `888f6db` |
| 5 — chat UI | ChatScreen (empty state + 4 suggestion chips, streaming bubble, markdown, safe-area bottom inset), `MessageBubble`, `AiRepository` seam, controller. 48 tests, 0 errors. | `5a53bf7` |

**Live evidence collected (all on this machine, dev server on port 8083/8084 because the `infrastructure` compose stack holds 8080/9090):**
- Streaming spike: token-by-token WebSocket delivery verified by an asserting test.
- Auth spike: registration code `65573159` read from server console log → register → login → JWT refresh (`jwtRefresh.refreshAccessToken`, 3 queries, 395ms).
- Server `dart analyze` clean; mobile `flutter analyze` clean (0 errors, info-level lints only).

## Remaining (resume point)

- **Stage 6 — Quota + injection**: implemented and covered by `server/test/ai_provider_test.dart` plus `server/test/ai/chat_request_builder_test.dart`; quota uses `AI_DAILY_MESSAGE_QUOTA` and prompt-injection baseline now strips stored `system` rows.
- **Stage 7 — hardening**: `flutter analyze`, `flutter test`, `dart analyze`, `dart format --set-exit-if-changed`, and `git diff --check` are PASS. `server/test/integration/ai_endpoint_test.dart` and full `server dart test` remain `NOT_RUN` because Docker engine did not expose `dockerDesktopLinuxEngine`.
- Provider factory now reads runtime `Platform.environment['AI_PROVIDER']` instead of compile-time defines; regression covered by `server/test/ai_provider_test.dart`.
- Runtime AI config now falls back from process environment to `.env`/`../.env` without adding a dependency; provider factory, quota, and OpenAI-compatible provider share this loader.
- `OpenAiCompatibleProvider` now fails fast when `AI_CHAT_MODEL` is missing, so real-provider configuration errors are local and sanitized instead of becoming provider-side 400s.
- OpenAI-compatible provider now throws sanitized HTTP status errors and emits a final done chunk when gateways terminate with `data: [DONE]` only; both regressions are covered by `server/test/ai_provider_test.dart`.
- `AiEndpoint.sendMessage` creates the AI provider after ownership validation but before quota/history/user persistence, so foreign conversation ids do not reveal provider config and misconfigured AI does not persist a user turn.
- Server unit/offline test gate is now explicit: `dart test --exclude-tags integration` PASS, while Docker-backed integration remains separate.
- `serverpod generate` PASS and produced no generated protocol/client diff, confirming generated parity for current endpoint signatures.
- Mobile logger cleanup: `ConsoleAppLogger` now accepts an injectable sink, removing the direct `print` dependency and simplifying tests.
- Auth storage hardening: malformed `auth.accessTokenExpiresAt` now clears the local session instead of throwing during restore.
- Latest mobile verification after these hardenings: `flutter analyze` PASS and full `flutter test` PASS.
- Chat error-state hardening: failed sends now mark the optimistic user turn as `MessageStatus.error` instead of leaving it stuck in `sending`; covered by `apps/mobile/test/chat_controller_test.dart`.
- CI hardening: server workflow now analyzes `packages/campusmate_shared`; mobile workflow now runs `flutter build apk --debug`.
- Android Gradle comments were normalized so the repo no longer advertises template TODOs for `applicationId` and release signing.
- Android build hardening: `kotlin.incremental=false` added to avoid Windows C:/D: cross-drive Kotlin cache failures; `flutter build apk --debug` PASS with `GRADLE_USER_HOME=.dart_tool/gradle-home`.
- Docker service check during this turn: `com.docker.service` reported `Stopped` and could not be started from this session, so the integration blocker is environmental not code-level.
- Integration test `ai_endpoint_test.dart` requires Docker (test postgres on 9090) to run.

## 2026-09-06 AK deep-scan refresh

- Workflow used: `/ak:scout` → `/ak:fix` → `/ak:test` → `/ak:code-review` (project-local `.codex/skills`; no extra registry loaded).
- Server AI hardening completed:
  - `AiEndpoint.sendMessage` validates ownership before provider/quota/history/persistence, preventing provider-config leaks and foreign-conversation side effects.
  - Server-owned prompt assembly now prepends `system_prompt.dart`, strips stored `system` rows, and keeps injection fixtures as user data.
  - `DailyMessageQuota` uses runtime `AI_DAILY_MESSAGE_QUOTA` and camelCase generated DB columns (`userId`, `requestCount`, etc.).
  - Runtime AI config reads process environment first, then `.env` / `../.env`; factory/provider/quota share the loader.
  - `AI_PROVIDER=openai-compatible` and `openai_compatible` both select `OpenAiCompatibleProvider`; factory now passes `environment` and `dotenvContent` through to the provider.
  - OpenAI-compatible streaming handles split SSE delta chunks, sanitized non-2xx errors, missing model/base URL, and `data: [DONE]` without a prior finish reason.
  - `FakeAiProvider` embeddings are now unit-normalized.
- Mobile hardening completed:
  - Auth repository/session storage now share one token storage provider; malformed or identity-incomplete local sessions are cleared instead of throwing during restore.
  - Registration flow no longer calls `completeRegistration` after the code-verification step; completion waits for password confirmation.
  - Chat send failures mark both optimistic user and assistant turns as `MessageStatus.error`; 429 quota messages surface the server message.
  - Chat bootstrap now handles both history-load and create-conversation failures with a visible retry state; stale `conversationId` / `error` can be cleared through `ChatState.copyWith`.
  - `ConsoleAppLogger` accepts an injectable sink, removing direct `print` coupling from tests.
- CI/docs/build hardening completed:
  - Server CI now analyzes `packages/campusmate_shared`; mobile CI now runs `flutter build apk --debug`.
  - Android template TODO comments were replaced with project-specific notes.
  - `kotlin.incremental=false` avoids the observed Windows C:/D: Kotlin cache failure; debug APK builds pass with repo-local `GRADLE_USER_HOME`.
  - Mobile config now uses the Android emulator host bridge (`10.0.2.2`) by default on Android when `CAMPUSMATE_SERVER_URL` is not supplied; README and `.env.example` document AI provider/runtime knobs and separate offline server tests from Docker integration.
- Fresh gates observed:
  - `dart format --output=none --set-exit-if-changed server packages\campusmate_shared packages\campusmate_client apps\mobile\lib apps\mobile\test` — PASS, 94 files, 0 changed.
  - `$env:LOCALAPPDATA = Join-Path (Resolve-Path .).Path '.dart_tool\codex-localappdata'; dart analyze server packages\campusmate_shared packages\campusmate_client` — PASS, no issues.
  - `cd server; dart test --exclude-tags integration` — PASS, 29 tests.
  - `cd apps/mobile; flutter analyze` — PASS, no issues.
  - `cd apps/mobile; flutter test` — PASS, 57 tests, 3 live-spike tests skipped by `CAMPUSMATE_LIVE_SPIKE=1` guard.
  - `cd apps/mobile; $env:GRADLE_USER_HOME = Join-Path (Resolve-Path ..\..).Path '.dart_tool\gradle-home'; flutter build apk --debug` — PASS, built `build\app\outputs\flutter-apk\app-debug.apk`.
  - `cd server; & (Join-Path $env:LOCALAPPDATA 'Pub\Cache\bin\serverpod.bat') generate` — PASS; generated protocol/client files have no diff.
  - `docker info` — FAIL; Docker client is installed, but daemon pipe `npipe:////./pipe/dockerDesktopLinuxEngine` is unavailable.
- Review evidence:
  - Independent `code-reviewer` first pass on branch `main` / HEAD `604200cf07c4f13ce890c45ea1daad4ed6febe5b` returned `FAIL` for three real issues: documented `openai-compatible` alias unsupported, factory config injection dropped for real provider, and stale chat `conversationId` after create failure.
  - All three findings were fixed with regressions in `server/test/ai_provider_test.dart` and `apps/mobile/test/chat_controller_test.dart`.
  - Independent `code-reviewer` re-review returned `PASS`: prior findings `FIXED`, `NEW_FINDINGS: NONE`. It did not rerun broad gates and relied on controller-reported fresh gate evidence.
- Remaining blockers / NOT_RUN:
  - `docker info` still fails against `npipe:////./pipe/dockerDesktopLinuxEngine`; Docker daemon is unavailable from this session.
  - Local Docker-backed `server/test/integration/ai_endpoint_test.dart`, local full `cd server; dart test`, live Serverpod/Postgres quota SQL, live OpenAI/GLM provider, and production cutover are `NOT_RUN`.
  - GitHub CI is no longer `NOT_RUN`; first post-push server run failed on Redis health-check setup and is tracked in the follow-up section below.

## 2026-09-06 CI follow-up after first GitHub push

- `gh run list --repo JasonTM17/CampusMate --limit 5` after push showed:
  - `server` workflow run `34017972178` — `failure`.
  - `mobile` workflow run `34017972168` — `in_progress` at observation time.
- Server CI root cause:
  - Workflow created `redis:6.2.6` without `requirepass`, but its health check used `redis-cli -a ... ping`.
  - GitHub Actions kept `redis_test` in `starting`, then marked it `unhealthy` during `Initialize containers`; Redis logs showed the server was otherwise ready.
- Fix applied:
  - Server CI Redis health check now uses `redis-cli ping | grep PONG`, matching current `server/config/test.yaml` where `redis.enabled: false`.
  - CI-only passwords/peppers were changed to obvious `campusmate_ci_*_not_secret` placeholders while keeping the Postgres service and generated `passwords.yaml` in sync.
  - `AppConfig` now normalizes custom server URLs to a trailing slash and exposes an `isAndroid` override for deterministic Android fallback tests.
  - `apps/mobile/README.md` now documents the actual CampusMate mobile app instead of the Flutter template text.
- Follow-up server CI run `34018323963` passed container init, pub get, format, and analyze, then failed `dart test` with 33 pass / 6 fail.
- Integration-test root cause:
  - `server/test/integration/ai_endpoint_test.dart` asserted stream endpoint failures by passing a `Stream<String>` directly to `throwsA`.
  - Dart's matcher reported the stream "was not a Function or Future"; the un-drained stream then left Serverpod test transactions/savepoints in a bad state, causing the later duplicate-key and concurrent-transaction failures.
- Fix applied:
  - Added `_expectStreamThrows()` that drains the stream future and applies `throwsA` to the resulting `Future`.
  - Updated foreign-conversation, quota-exhausted, and prompt-injection stream error assertions to use that helper.
- Fresh local gates after this follow-up:
  - `dart format --output=none --set-exit-if-changed server packages\campusmate_shared packages\campusmate_client apps\mobile\lib apps\mobile\test` — PASS, 94 files, 0 changed.
  - `$env:LOCALAPPDATA = Join-Path (Resolve-Path .).Path '.dart_tool\codex-localappdata'; dart analyze server packages\campusmate_shared packages\campusmate_client` — PASS, no issues.
  - `cd server; dart test --exclude-tags integration` — PASS, 29 tests.
  - `cd apps/mobile; flutter analyze` — PASS, no issues.
  - `cd apps/mobile; flutter test` — PASS, 59 tests, 3 live-spike tests skipped by `CAMPUSMATE_LIVE_SPIKE=1` guard.
  - `cd apps/mobile; $env:GRADLE_USER_HOME = Join-Path (Resolve-Path ..\..).Path '.dart_tool\gradle-home'; flutter build apk --debug` — PASS, built `build\app\outputs\flutter-apk\app-debug.apk`.
  - `git diff --check` — PASS; line-ending warnings only.
  - `docker info` — FAIL locally; daemon pipe `npipe:////./pipe/dockerDesktopLinuxEngine` unavailable.
- Push `3dbbe01` triggered GitHub Actions:
  - Server run `34018497884` — PASS: containers, workspace pub get, password generation, format, analyze, `dart test`, stop containers.
  - Mobile run `34018497826` — PASS: Flutter workflow completed.
  - Both runs emitted only GitHub's Node.js 20 deprecation annotation for actions internals.
- Code-reviewer pending-diff review after CI returned `FAIL` for incomplete template cleanup:
  - `server/pubspec.yaml` still described the server as a template starting point.
  - `server/web/templates/built_with_serverpod.html` still rendered "Built with Serverpod" branding/copy at `/`.
- Fix applied after reviewer finding:
  - Server package description now names the CampusMate backend.
  - Root web template was renamed to `campusmate_status.html`, route/widget references were updated, and page copy now presents CampusMate Server plus app/repository links.
  - Server README and mobile README now describe actual project commands instead of scaffold text.
  - `/app` fallback page now states that CampusMate currently targets Android/iOS and no longer shows Serverpod template branding or an invalid Flutter web build command.
  - `AppConfig.normalizeServerUrl` now treats blank/whitespace input as empty fallback and keeps deterministic Android/non-Android tests.
  - OpenAI-compatible embeddings now throw a sanitized `OpenAiProviderException(operation: 'embedding')` on non-2xx responses instead of silently returning an empty vector.
- Fresh gates after reviewer-finding fixes:
  - `dart format --output=none --set-exit-if-changed server packages\campusmate_shared packages\campusmate_client apps\mobile\lib apps\mobile\test` — PASS, 94 files, 0 changed.
  - `$env:LOCALAPPDATA = Join-Path (Resolve-Path .).Path '.dart_tool\codex-localappdata'; dart analyze server packages\campusmate_shared packages\campusmate_client` — PASS, no issues.
  - `cd server; dart test --exclude-tags integration` — PASS, 30 tests.
  - `cd apps/mobile; flutter analyze` — PASS, no issues.
  - `cd apps/mobile; flutter test` — PASS, 59 tests, 3 live-spike tests skipped by `CAMPUSMATE_LIVE_SPIKE=1` guard.
  - `cd apps/mobile; $env:GRADLE_USER_HOME = Join-Path (Resolve-Path ..\..).Path '.dart_tool\gradle-home'; flutter build apk --debug` — PASS, built `build\app\outputs\flutter-apk\app-debug.apk`.
  - `rg -n "Built with Serverpod|Starting point for a Serverpod server|starting point for your Serverpod|built_with_serverpod|A new Flutter project|The missing server for Flutter|serverpod-logo" server apps README.md packages docs ...` — PASS, no matches outside ignored generated/test-tool/build paths.
- Final staged re-review after staging replacement files:
  - `PRIOR_FINDING_STATUS: FIXED`; no findings in staged diff.
  - Verdict was `INCONCLUSIVE` only because the reviewer could not observe its own focused test commands finish; controller-run focused tests below closed that gap.
  - `cd server; dart test test\ai_provider_test.dart -n "throws a sanitized embedding error for non-success HTTP responses"` — PASS, 1 test.
  - `cd apps/mobile; flutter test test\app\config\app_config_test.dart` — PASS, 5 tests.

## Completed steps & evidence

## Completed steps & evidence

### Phase 01 — Foundation + stack spike (commits a698de8 → d5e2402 + fix commits sau review)

- **P1.1** `git init -b main` + .gitignore: commit `a698de8`. AGENTS.md giữ untracked theo global gitignore của user (ruling, không force-add).
- **P1.2** Serverpod CLI **3.4.13** cài thành công (pin đúng; executable tại `%LOCALAPPDATA%\Pub\Cache\bin\serverpod.bat`).
- **P1.3 SPIKE (A1–A4) — OBSERVED**:
  - A1 CLI/codegen/boot: `serverpod create campusmate` OK; workspace restructure về `server/` + `packages/campusmate_client` (pub get 93 deps); boot log "Applied database migration: 20260830095733184"; `flutter test test/client_spike_test.dart` **All tests passed** (client gọi `greeting.hello` qua mạng thật).
  - A2 compose: 5/5 container **healthy** (postgres, postgres_test, redis, redis_test, minio) sau khi thêm MinIO + healthchecks — commit `3ad36a4`.
  - A3 streaming: **deferred có chủ đích** sang phase-08 spike (theo kế hoạch; Kongming C1 không yêu cầu ở P1). ADR-002 ghi fallback SSE/polling.
  - A4 pgvector: `CREATE EXTENSION vector` + cosine `<=>` OK (psql); **và** cột `vector(1536)` tạo thật qua model `vector_capability_probe.spy.yaml` → `serverpod generate` → migration `20260830104952147` → apply (đáp ứng code-review finding #1).
- **P1.4** compose + MinIO + healthchecks: `3ad36a4`. **P1.5** design tokens + M3 theme: `2f8066b`. **P1.6** router 5 tab + l10n vi/en: `5661cd2` + `efc21d8`. **P1.7** Failure/Result/Logger/Config: `cea725f` + `.env.example` `688baeb`. **P1.8** CI mobile+server: `da030e7`; ADR 001–004: `57eeeb7`; README: `e087ed4`; spike opt-in guard: `d5e2402`.
- **Verification gates (OBSERVED cuối phase)**: `flutter analyze` = No issues · `dart analyze server` + `dart analyze packages/campusmate_client` = No issues · `dart format --set-exit-if-changed` exit 0 (37 files, 0 changed) · `flutter test` = +2 pass · `dart test` (server, integration) = +1 pass · compose 5/5 healthy.
- **Code review (bắt buộc)**: REQUEST_CHANGES → finding #1 (vector qua model/migration) **FIXED**; finding #2 (ledger) **FIXED** bằng chính bản ghi này; minors #3/#4 và nits #5/#6 xử lý bằng ruling/deferred bên dưới. Reviewer xác nhận checks (b)–(f) PASS.

## Current step

- AK deep-scan hardening is continuing from `main` after push to `origin/main`; current focus is GitHub CI stabilization and documentation drift cleanup before returning to the broader phase backlog.

## Phase 02 — Auth + Student + RBAC (completion session 2026-09-06)

Working tree carries the full phase-02 implementation (server auth idp wiring,
student/admin endpoints, migration `20260906080612724-phase02-auth-student`,
seed script, mobile password-reset + student profile + router guard, l10n).
This session completes, verifies, polishes, commits and pushes it under the
plan-lock overlay (direct user instruction: finish thoroughly + FE UI/UX
polish + commit + push).

### Advisory wave (read-only subagents, 2026-09-06)

- **Advisor**: phase-02 substantially complete; open items = observed DB-backed
  gates, Wukong IDOR verdict, ADR-005 (implementation already chose
  `serverpod_auth_idp`); UI polish bounded to phase-02 surfaces and sequenced
  AFTER green auth baseline; 7-slice commit plan; direct push to main is
  consistent with repo history once all gates are green.
- **Kongming**: GO-WITH-CONDITIONS — (1) server commit must be atomic
  (spy.yaml + migration + registry + generated protocol + client protocol);
  (2) Docker integration tests before push; (3) seed script must stay
  env-password-only and is a footgun from phase-11 onward; polish LAST as its
  own commit.
- **Wukong (independent agent, 2026-09-06)**: C1 IDOR / C2 RBAC / C3 secrets
  all **NOT_FALSIFIED**, GATE PROCEED — endpoint surface exposes no
  client-supplied user id, framework-enforced scopes traced in vendored
  sources, seed env-only; independently re-ran the 6/6 integration suite.
  Residual: dev-mode verification codes stay in server logs; integration
  tests inject identity in-process rather than exercising live JWT
  validation (vendored framework code).
- **UI/UX specialist**: scorecard login 7.5 / registration 7 / reset 6 /
  profile 5.5 / shell 8.5; P0 = dark-mode hint contrast (~1.4:1), error text
  contrast + no live-region, unlabeled reset spinner, save wipes form via
  full-screen loading; P1 = shared FilledButton theme, autofill parity,
  autofocus on step change, email regex, digits-only codes, profile
  validation + token spacing, AppEmptyState-based error view.

### Plan-lock delta (authorized by direct user instruction)

- In scope NOW: finish phase-02 gates (incl. integration), ADR-005, bounded
  UI/UX polish on phase-02 surfaces, ledger/phase status sync, 7-slice
  conventional commits, push origin/main, watch CI.
- Out of scope (LATER): mail provider for codes; faculties/majors/programs
  tables (phase-03); real admin feature (phase-11); seed config guard
  (before phase-11); `.mimosa/`/`.video_agent/` never staged.

### Environmental findings (machine, not repo)

- Pub cache at `%LOCALAPPDATA%\Pub\Cache` was found wiped twice during this
  session (only README.md remains; unknown external cleaner). Workaround:
  repo-local `PUB_CACHE=D:\Mobile_Project\.dart_tool\pub-cache` (gitignored)
  used for all dart/flutter commands this session. Stale cache explains the
  first mobile analyze run showing 256 missing-package issues.

## Phase 02 — completion evidence (2026-09-06)

- Gates observed: server `dart analyze` clean, `dart format --set-exit-if-changed`
  PASS across server/packages/mobile, `dart test` **48/48** (32 offline +
  16 DB-backed integration incl. A↔B isolation and admin 403); mobile
  `flutter analyze` clean, `flutter test` **65 pass / 3 skip**; `git diff --check`
  clean; secret scan of the whole diff only surfaced test fixtures.
- Live E2E (Flutter web build pointed at the local backend on :8083, seeded
  accounts): real login as `student001@campusmate.local` → authenticated
  shell; **session restored across a full page reload**; screenshots of the
  polished login screen (dark) and the home shell recorded via the browser
  automation session.
- Defects found & fixed during verification:
  - `DailyMessageQuota.consume` mixed a local-midnight raw-SQL parameter with
    ORM UTC serialization — quota never blocked on non-UTC hosts (`76ae41d`).
  - Integration expectations for endpoint-level `requireLogin`/`requiredScopes`
    corrected to the framework exception types with an explanatory comment.
- UI/UX polish (Advisor/Kongming/UI-specialist wave): shared FilledButton
  theme, brightness-aware hint/error contrast (was ~1.4:1 in dark),
  `AppErrorBanner` with live-region semantics, strict email validation,
  digits-only code fields with autofocus/autofill, profile save no longer
  wipes the form, profile identity header + AppEmptyState error view,
  `authUseDifferentEmail` escape hatches, en/vi key parity.
- Commit slice: `76ae41d` fix(ai) → `605ae77` feat(auth) server → `c7f4958`
  chore(server) seed → `f347df2` feat(auth) mobile (profile merged into the
  mobile slice: the router imports the profile screen, so separate commits
  would break per-commit builds — plan-lock execution ruling).
- Environmental: pub cache at `%LOCALAPPDATA%\Pub\Cache` wiped twice by an
  unknown external cleaner mid-session; all dart/flutter commands therefore
  ran with `PUB_CACHE=D:\Mobile_Project\.dart_tool\pub-cache`. The 43MB
  stale `server/web/app` build artifact (gitignored) had to be removed
  before the Mimosa commit hook would pass. `server/config/development.yaml`
  was temporarily shifted to port 8083 for the live run and reverted — not
  committed. Flutter `web/` platform files were generated for browser
  verification and remain untracked; committing web support is a user
  decision (LATER).
- Phase-02 status flipped to `completed` with all five Success Criteria
  checked against the evidence above.
- **Independent code review (2026-09-06)** on `1e21a7d..775f22f`:
  SPEC COMPLIANCE PASS, verdict APPROVE-WITH-NITPICKS. Findings applied
  immediately: refresh clears the session only on 401/403 (transient
  failures keep it, regression-tested), failed profile saves keep the form
  and surface a snackbar, client validators mirror the 120-char server cap,
  and concurrent first profile reads tolerate the unique-index race
  (`a1e3a5b`, `9987708`). Post-fix gates: server 48/48, mobile 68 pass /
  3 skip, analyze + format clean. Deferred (LATER, next defect checkpoint):
  GoRouter rebuilt on every auth transition (switch to refreshListenable),
  server-side refresh-token revocation on sign-out, faculties/majors/
  programs tables (phase-03).

## Phase 03 — Academic completion evidence (2026-09-08)

- Implemented DB-backed academic domain: Serverpod schema/models/migration for
  academic years, semesters, courses, offerings, enrollments, schedules, exams,
  grade components, student grades, and read DTOs. `serverpod generate` updated
  `server/lib/src/generated/**`, `server/lib/src/generated/protocol.yaml`, and
  `packages/campusmate_client/lib/src/protocol/**`.
- Implemented student-scoped academic endpoints: overview, courses/detail,
  weekly/daily timetable, semester/cumulative grades, upcoming exams, and
  curriculum progress. Reads derive identity from the authenticated session and
  filter through `StudentProfile`/`Enrollment`; foreign offering detail returns
  404.
- Implemented demo academic seed: 15 fake Vietnamese courses, 25 current
  offerings/schedules, 75 grade components, 50 exams, two enrolled demo
  students with 10 enrollments/30 grades, plus historical semester
  `2025-HK2` for a real semester selector option.
- Added `packages/campusmate_shared/src/gpa_calculator.dart` and
  `packages/campusmate_shared/src/campus_clock.dart`. GPA is policy-injected
  outside UI; `CampusClock` fixes academic day/week projection to Vietnam
  campus time (UTC+7), including the early-Monday-local/Sunday-UTC edge.
- Implemented mobile Academic route: overview metrics/progress, course detail
  bottom sheet, week/day timetable with prev/next/today, current/conflict
  badges, semester-backed grades dropdown, exams list/countdown, loading/error/
  empty/offline states.
- Implemented Drift pull-cache for academic profile/timetable/grades, keyed by
  authenticated account plus week/semester where relevant. Offline fallback and
  account partitioning are covered by tests; physical airplane-mode device proof
  remains `NOT_RUN`.
- Repository docs upgraded for GitHub presentation: README architecture ERD and
  system diagram; `docs/architecture.md`, `docs/database.md`, and
  `docs/release-packages.md` added. Mermaid CLI rendered the Markdown diagrams
  into `.dart_tool/mermaid-proof/**` successfully.
- GitHub About metadata updated with `gh repo edit` for
  `JasonTM17/CampusMate`: description set to "CampusMate — Flutter + Serverpod
  student management, e-library, offline academic dashboard, and personalized
  AI assistant."; topics include `flutter`, `dart`, `serverpod`, `postgresql`,
  `pgvector`, `riverpod`, `drift`, `student-management`, `e-library`,
  `ai-assistant`. `gh repo view` shows `latestRelease: null`.
- Release/package truth boundary: docs now define GitHub Releases and GitHub
  Packages/GHCR policy, but no release or package is claimed/published until
  Phase 12 ship gates, GitHub Actions evidence, tag, and package workflow exist.

Observed gates:

- `docker info` — PASS; Docker Desktop available. `docker compose up -d` in
  `server/` started required Postgres/Redis services; MinIO port 9000 is held by
  an existing external `infrastructure-minio-1` container, so no destructive
  action was taken.
- `serverpod generate` — PASS after adding `AcademicOverview.availableSemesters`.
- `serverpod create-migration --tag phase03-academic` — PASS; migration
  `server/migrations/20260907154030243-phase03-academic`.
- `flutter pub get` in `apps/mobile` — PASS; added local
  `campusmate_shared` dependency.
- `dart run build_runner build --delete-conflicting-outputs` in `apps/mobile`
  — PASS; generated Drift database code.
- `dart format --output=none --set-exit-if-changed server packages apps\mobile\lib apps\mobile\test`
  — PASS, 167 files, 0 changed.
- `$env:LOCALAPPDATA = Join-Path (Resolve-Path .).Path '.dart_tool\codex-localappdata'; dart analyze server packages\campusmate_shared packages\campusmate_client apps\mobile`
  — PASS, no issues.
- `git diff --check` — PASS, CRLF warnings only.
- `dart test` in `packages/campusmate_shared` — PASS, 5/5.
- `dart test test\integration\academic_endpoint_test.dart` in `server` —
  PASS, 9/9.
- `dart test` in `server` — PASS, 57/57.
- `flutter test test\academics` in `apps/mobile` — PASS, 5/5.
- `flutter test` in `apps/mobile` — PASS, 73 pass / 3 skip; skipped tests are
  live dev-server spikes gated by `CAMPUSMATE_LIVE_SPIKE`.
- `flutter build apk --debug` in `apps/mobile` — PASS; generated
  `build/app/outputs/flutter-apk/app-debug.apk`.
- `npx -y @mermaid-js/mermaid-cli` over `docs/architecture.md`,
  `docs/database.md`, and `docs/release-packages.md` — PASS; diagrams rendered
  to `.dart_tool/mermaid-proof`.

Independent review:

- First code-reviewer pass returned `VERDICT: FAIL` for three load-bearing
  issues: no independent semester window enforcement, UTC-based day/week
  handling, and cosmetic one-item semester selector.
- Fixes applied narrowly: timetable now intersects schedule and semester
  windows; server/mobile use shared `CampusClock`; overview exposes
  `availableSemesters`; seed adds historical semester; widget test switches
  selector and asserts requested `semesterId`.
- Second code-reviewer pass returned `VERDICT: PASS`. Reviewer independently
  verified the prior findings as fixed and noted one non-blocking docs mismatch
  (`student_grades.gradeComponentId` vs actual `componentName`), which was fixed
  immediately in `docs/database.md` and re-rendered with Mermaid CLI.

Phase-03 status flipped to `completed`. Current authoritative limitation:
offline behavior is covered by deterministic cache/network-failure tests rather
than a physical device airplane-mode run.

## Phase 04 — Dashboard + Notifications completion evidence (2026-09-08)

- Implemented Serverpod announcement and campus notification schemas,
  generated protocol/client files, and migration
  `20260908004517941-phase04-dashboard-notifications` with indexes for
  audience/publish filtering, unread counts, user cursor paging, and category
  cursor paging.
- Implemented student-scoped dashboard endpoints for greeting, academic
  summary, today classes, next class, upcoming exam, and announcements.
  Dashboard section calls remain separate so one section failure can be shown
  independently on mobile.
- Implemented student-scoped notification endpoints for list, unreadCount,
  markRead, and markAllRead. Identity is always derived from the Serverpod
  session; mobile never sends a user id. Cursor pagination is opaque and bound
  to the active category filter.
- Implemented demo dashboard/notification seed data. Notification seed is
  idempotent and creates one row for each required category:
  academic/library/system/ai/course/exam.
- Implemented Flutter dashboard route at `/home` with real academic sections,
  notification badge, independent loading/error/empty/retry cards, honest empty
  continue-reading and AI suggestion states, and no dead buttons.
- Implemented Flutter notification center at `/notifications` with six category
  filters, unread state, mark-all, load-more pagination, mark-read on tap, and
  exam notifications mapped to guarded `/academic/exams/:examId`.
- Added auth redirect helpers so protected deep links survive login/loading
  routes and external/auth-flow redirect targets are rejected.
- Added `ExamsEndpoint.getDetail` plus mobile `ExamDetailScreen`; exam detail
  access is scoped through the authenticated student's enrollments.
- Repository docs updated so README, `docs/architecture.md`, and
  `docs/database.md` show the dashboard/notification boundary and data model.

Observed gates:

- `dart pub global run serverpod_cli generate` in `server/` — PASS after the
  `DashboardAcademicSummary.semesterCredits` model change and public
  `dashboard.getAnnouncements` signature hardening.
- `dart format --output=none --set-exit-if-changed server packages\campusmate_shared packages\campusmate_client apps\mobile\lib apps\mobile\test`
  — PASS, 201 files, 0 changed.
- `$env:LOCALAPPDATA = Join-Path (Resolve-Path .).Path '.dart_tool\codex-localappdata'; dart analyze server packages\campusmate_shared packages\campusmate_client`
  — PASS, no issues.
- `git diff --check` — PASS, CRLF warnings only.
- `docker compose ps` in `server/` — PASS; Postgres/Redis dev and test
  services healthy.
- `dart test --exclude-tags integration` in `server/` — PASS, 32/32.
- `dart test test/integration/dashboard_notification_endpoint_test.dart` in
  `server/` — PASS, 7/7.
- `dart test` in `server/` — PASS, 64/64.
- `flutter analyze` in `apps/mobile` — PASS, no issues.
- `flutter test` focused Phase 04 route/dashboard/notification/academic shell
  suite — PASS, 14/14 after adding the cold-start exam deep-link regression.
- `flutter test` in `apps/mobile` — PASS, 82 pass / 3 skip; skipped tests are
  live dev-server spikes gated by `CAMPUSMATE_LIVE_SPIKE`.
- `flutter build apk --debug` in `apps/mobile` with repo-local
  `GRADLE_USER_HOME` — PASS; built
  `build\app\outputs\flutter-apk\app-debug.apk`.
- `npx -y @mermaid-js/mermaid-cli` over `README.md`,
  `docs/architecture.md`, and `docs/database.md` — PASS; diagrams rendered
  to `.dart_tool/mermaid-proof`.

Independent review and repairs:

- First Phase-04 code-reviewer pass returned `VERDICT: FAIL` for three
  findings: client-controllable announcement visibility through public
  `DateTime? now`, missing current-semester credits in the dashboard summary,
  and pagination requiring a button instead of scroll-triggered load-more.
- Fixes applied narrowly: `dashboard.getAnnouncements` now uses server time at
  the public endpoint boundary; `DashboardAcademicSummary` exposes
  `semesterCredits` through generated server/client protocol and the mobile UI;
  notification center auto-loads the next cursor page near the scroll end and
  keeps the button as an explicit fallback.
- Second Phase-04 code-reviewer pass verified the prior three findings as
  fixed, then returned `VERDICT: FAIL` for one P2: `appRouterProvider` rebuilt
  `GoRouter` from `authControllerProvider`, so a protected cold-start exam deep
  link could be lost when auth restore changed state.
- Fix applied narrowly: `appRouterProvider` now keeps one `GoRouter` instance
  and drives redirect refreshes through a `ValueNotifier<AuthState>`. Regression
  `test/app_router_guard_test.dart` proves `/academic/exams/41` survives auth
  restore and reaches `ExamDetail`.
- Final Phase-04 code-reviewer pass returned `VERDICT: PASS`: all four prior
  findings fixed, `NEW_FINDINGS: NONE`. The reviewer ran read-only
  `git diff --cached --check` and accepted the controller-observed test/build
  evidence.
- Staged strong-pattern secret scan — PASS; no token/key/private-key patterns
  found. Broader keyword hits are expected generated schema/route names such as
  `refreshToken`/`passwordHash`, not committed secret values.
- Post-push GitHub Actions for code commit
  `1fb259c feat(dashboard): add student notifications` — PASS:
  server run `34197078388` and mobile run `34197078408` both completed
  successfully for head SHA `1fb259ced5dc281821228972b74ee9a22420375e`.

Limitations and degraded gates:

- UI-specialist subagent attempt failed due account usage limit; main-thread
  implementation still applied the project mobile/UI rules and widget tests.
- Live dev-server spike tests remain skipped unless
  `CAMPUSMATE_LIVE_SPIKE=1`; local deterministic and integration gates above
  covered the Phase-04 contracts.

Phase-04 status remains `completed` in the phase file. Code commit `1fb259c`
has local gates, independent review, push, and GitHub Actions evidence.

## Phase 05 — Library catalog + access policy completion evidence (2026-09-08)

- Implemented the Serverpod library catalog domain: access-type enum, DTOs,
  authors/categories/books/link tables/files/course links/favorites, migration
  `20260908075418239-phase05-library-catalog`, generated server/client
  protocol, and idempotent demo seed with 30 clearly sample books.
- Implemented `BookAccessPolicyService` as the single server-side authority for
  read/download/borrow flags. `metadataOnly` never exposes read/download/borrow;
  `restricted` read is limited to librarian/admin; inactive and expired-license
  books block before access-type actions.
- Implemented `LibraryEndpoint` search/explore/detail/toggleFavorite with
  server-side filtering, opaque keyset cursor pagination bound to the filter
  signature, and DTO responses that do not expose file URL or storage key.
- Implemented Flutter library routes: `/library` explore/search/filter/infinite
  scroll and `/library/books/:bookId` detail/favorite/actions. Client debounce
  is 350 ms with stale-result cancellation; `loadMore` is generation-guarded.
- Updated README and docs with professional Mermaid system/data/release
  diagrams, GitHub About metadata truth, and the release/package boundary.

Observed gates:

- `dart pub global run serverpod_cli generate` in `server/` — PASS.
- `dart format --output=none --set-exit-if-changed server packages\campusmate_client packages\campusmate_shared apps\mobile\lib apps\mobile\test`
  — PASS.
- `$env:LOCALAPPDATA = Join-Path (Resolve-Path .).Path '.dart_tool\codex-localappdata'; dart analyze server packages\campusmate_client packages\campusmate_shared`
  — PASS.
- `flutter analyze` in `apps/mobile` — PASS.
- `dart test --reporter=compact` in `server` — PASS, 79/79.
- `flutter test --reporter=compact` in `apps/mobile` — PASS, 89 passed / 3
  skipped; skipped tests remain live dev-server spikes gated by
  `CAMPUSMATE_LIVE_SPIKE`.
- `flutter build apk --debug` in `apps/mobile` — PASS; built
  `build\app\outputs\flutter-apk\app-debug.apk`.
- Mermaid render proof with `npx -y @mermaid-js/mermaid-cli` over `README.md`,
  `docs/architecture.md`, `docs/database.md`, and `docs/release-packages.md`
  — PASS; output written under ignored `.dart_tool/mermaid-proof`.
- Migration metadata parser check — PASS: `book_created_cursor_idx` maps only
  to table `books` in `definition.json`, `definition_project.json`, and
  `migration.json`.
- GitHub metadata verification via `gh`: repo About description and topics are
  set; `latestRelease` is `null`; `releases/latest` returns 404; filtered
  container/npm/maven package queries find no CampusMate package yet.
- Post-push GitHub Actions for code commit
  `5a1c26c feat(library): add catalog access policy` — PASS: server run
  `34224474451` and mobile run `34224474507` both completed successfully for
  head SHA `5a1c26cc697ffdc385818e1226638cb4d6016433`.

Independent agents:

- Explore specialist PASS: `/library` was placeholder-only before this phase;
  recommended repository/controller/presentation layering, nested detail route,
  shared search bar, and fake-repository widget/controller tests.
- Code-reviewer PASS after two targeted repairs. Initial actionable P2s were
  stale `loadMore` result handling and missing `books(createdAt,id)` cursor
  index; both were fixed and retested. Final reviewer verdict: PASS, no
  P0/P1/P2 actionable findings.
- Wukong runtime attempt timed out before verdict; this phase's falsifiable
  high-risk gates were instead covered by controller tests plus code-reviewer.
  Borrow-race Wukong remains required for Phase 06.

Limitations and deferred findings:

- No GitHub Release or GitHub Package has been published for CampusMate. Docs
  intentionally say this remains a Phase 12 ship gate after tag, workflow, CI,
  provenance, and package evidence exist.
- Generated protocol still contains internal model classes with
  `LibraryBookFile.storageKey`; current public endpoints return DTOs and tests
  assert no leak. Reader/download phases must keep storage metadata server-only
  at mint-time.
- Library action buttons currently surface friendly placeholder SnackBars for
  reader/lending operations; actual borrow/read/download execution belongs to
  Phase 06/07 by the accepted plan.
- GitHub Actions annotations note that `actions/checkout@v4` targets deprecated
  Node.js 20 and is currently forced to Node.js 24 by GitHub runners. This did
  not fail server/mobile CI, but Phase 12 should refresh CI action versions.

## Authorized rulings

- AGENTS.md untracked (global gitignore user) — không force-add.
- Tách Library 05/06 + kéo audit_logs lên 06 (Kongming C4); đánh số phase 01–12 thuần số cho CLI.
- Offline = pull-cache + duy nhất reading-progress LWW (Kongming C5).
- EPUB dùng flutter_epub_viewer (WebView) là path chính (Wukong evidence).
- Compose đặt tại `server/docker-compose.yaml` (theo template Serverpod), không phải root — README hướng dẫn `cd server` (review finding #4).
- Windows platform tạm gỡ khỏi apps/mobile chờ Developer Mode; khôi phục bằng `flutter create --platforms windows .` (README Prerequisites).
- Dev credentials do template sinh (compose + passwords.yaml machine-local) chấp nhận cho dev; cấm tái sử dụng staging/prod (README Security note).
- Redis đang `enabled: false` trong config dev/test dù container chạy — bật khi phase cần cache (finding #3, ghi README).

## Deferred findings (LATER — không nằm trên critical path)

- Locale hardcode `vi` trong app.dart — language setting thực tế thuộc phase-12 settings.
- Thư mục `features/` xuất hiện dần từ phase-02 (empty dir không track được).
- A3 streaming spike ở phase-08 trước khi commit kiến trúc chat.
- CI first push evidence exists; server workflow initially failed on Redis health-check mismatch and was fixed in the follow-up commit.
- Docker Desktop previously self-stopped during long tests; Phase 05 final
  server suite and Android debug build completed with Docker/Gradle available.

## Next resume point

- Commit and push Phase 05, watch GitHub Actions for the new head, then resume
  Phase 06: lending + audit. Required next high-risk gate: Wukong borrow-race
  claim with a deterministic two-borrow concurrency test.
