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
  - Docker-backed `server/test/integration/ai_endpoint_test.dart`, full `cd server; dart test`, live Serverpod/Postgres quota SQL, live OpenAI/GLM provider, CI, and production cutover are `NOT_RUN`.

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

- Phase-01 exit: đóng phase sau khi commit fixes; bước kế = `phase-02-auth-student.md` (spike chọn auth generation + ADR-005).

## Phase 02 — Auth + Student + RBAC (in progress, not yet implemented)

No implementation steps executed yet.

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
- CI = `NOT_RUN` (chưa có git remote) — đã ghi trung thực; sẽ xanh khi user cấp remote.
- Docker Desktop đã tự tắt 2 lần trong phiên (engine chết giữa phase) — theo dõi; nếu lặp lại, kiểm tra WSL2/ram.

## Next resume point

- Re-check Docker engine, then run `server/test/integration/ai_endpoint_test.dart` and full `server dart test`; otherwise hand off with `NOT_RUN` recorded honestly.
