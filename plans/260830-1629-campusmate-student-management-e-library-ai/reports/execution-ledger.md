# Execution Ledger — CampusMate

plans/260830-1629-campusmate-student-management-e-library-ai/plan.md

## Active plan identity

- Plan: CampusMate — Student Management + E-Library + Personalized AI (archetype: Feature)
- Created: 2026-08-30 · Status: `in-progress` (phase-01 đã implement, chờ close sau code-review fixes)
- Workflow: goal-warmup → scout → plan (+ plan-lock) → cook (code mode) → test → code-review
- Advisory evidence: Kongming GO-WITH-CONDITIONS (7 điều kiện đã nhúng phase); Wukong NOT_FALSIFIED / PROCEED_WITH_RESIDUAL_RISK (2026-08-30)

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

- `ak plan check` phase-01 → đọc `phase-02-auth-student.md` từ Implementation Steps 1 (spike auth generation, ADR-005).
