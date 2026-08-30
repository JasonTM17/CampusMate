---
phase: 1
title: "Foundation + stack spike"
status: pending
priority: P1
effort: L
dependencies: []
---

# Phase 1: Foundation + stack spike

## Overview

Dựng monorepo và **chứng minh stack chạy thật trên Windows trước khi build lên nó** (Kongming C1/C2, Wukong residual A1–A4): git init, Flutter app + Serverpod server + shared package, Docker compose (Postgres+pgvector, Redis, MinIO), CI, design tokens, router, l10n, lint. Exit của phase = spike evidence, không phải "CI config exists".

## Requirements

- Functional: mobile shell chạy (Material 3, 5 tab placeholder); server health endpoint trả OK; 1 migration áp dụng thành công; generated client gọi 1 test endpoint từ Flutter.
- Non-functional: lint bật, `.env.example` không chứa secret, secrets không commit; compose services có healthcheck.

## Architecture

- Thư mục: `apps/mobile` (lib: `app/` `core/` `features/`), `server/` (Serverpod), `packages/shared_models`, `docker-compose.yml`, `.github/workflows/`, `docs/adr/`.
- Compose: dùng Postgres image đã kèm pgvector (Serverpod default) hoặc `pgvector/pgvector:0.8.x-pg16`; Redis; MinIO. Ghi rõ image tag đã chạy.
- ADR: `001-use-riverpod`, `002-use-serverpod` (**ghi ruling license SSPL-1.0 của package `serverpod` chính: hạn chế offer-as-a-service, không cản internal app use**), `003-use-postgresql-pgvector`, `004-use-drift-for-offline`.

## Related Code Files

- Create: `.gitignore`, `docker-compose.yml`, `.env.example`, `.github/workflows/mobile.yml`, `.github/workflows/server.yml`, `apps/mobile/**` (bootstrap, router shell, theme tokens, l10n), `server/**` (health endpoint + 1 demo migration), `packages/shared_models/**`, `docs/adr/001..004`, `README.md` (khung).

## Implementation Steps

1. `git init` (branch `main`), cấu hình identity, `.gitignore` Flutter/Dart/Serverpod/`.env`; commit `chore(repo): initialize monorepo project structure`.
2. Cài Serverpod CLI: `dart pub global activate serverpod_cli`; **pin 3.4.x** (cấm drift lên 4.0.0-rc); ghi version vào ADR-002.
3. **SPIKE (exit evidence)**: `serverpod create` → server boot → compose up healthy → tạo + chạy 1 migration → tạo cột `Vector(1536)` qua model/migration → generated client gọi test endpoint từ Flutter. Ghi kết quả + version thật vào ADR-002 và ledger. Spike fail = BLOCKER, dừng report user.
4. `docker-compose.yml` + healthcheck + script setup; ghi chú **pdfrx cần Windows Developer Mode (symlink)** vào README prerequisites (Wukong residual).
5. Flutter scaffold feature-first (§6): `app/bootstrap` + `core/{constants,errors,result,network,storage,utils,widgets}` + `features/` rỗng theo module; design tokens `AppSpacing/AppRadius/AppColors/AppTypography` (spacing 4/8/12/16/24/32); Material 3 theme light/dark skeleton; commit `feat(theme): implement CampusMate Material 3 design system`.
6. `go_router` shell + bottom nav 5 tab (Home/Academic/Library/AI/Profile); l10n foundation `vi` mặc định, `en` ready; commit `feat(router): configure application navigation` + `feat(localization): add Vietnamese localization foundation`.
7. analysis_options (flutter_lints + server), typed `Failure`/`Result` skeleton (`NetworkFailure/UnauthorizedFailure/ForbiddenFailure/ValidationFailure/NotFoundFailure/ServerFailure/OfflineFailure`); logging abstraction 4 mức có sanitize; commit `feat(core): add shared error and result handling`.
8. CI 2 pipeline (§62): mobile = `flutter pub get` + `dart format --set-exit-if-changed` + `flutter analyze` + `flutter test`; server tương tự với `dart`. **Đẩy 1 lần lên remote nếu user cấp; không có remote → chạy local tương đương + ghi `NOT_RUN` thật.** Commit `ci(github): add mobile and server quality checks`.
9. Cập nhật README khung + ledger.

## Success Criteria

- [ ] `git log --oneline` ≥ 6 commit Conventional hợp lệ; `git status` sạch sau mỗi commit.
- [ ] `flutter run` lên shell 5 tab; `dart format --set-exit-if-changed .` PASS (cả mobile+server).
- [ ] `flutter analyze` + `dart analyze` PASS (0 error).
- [ ] `docker compose ps` → postgres/redis/minio **healthy**; health endpoint curl OK.
- [ ] Migration + `Vector` column tồn tại (`\d` hoặc query information_schema); client call trả OK.
- [ ] CI: ≥1 run xanh thật HOẶC ghi rõ `NOT_RUN` + lý do (không remote).
- [ ] A1–A4 mỗi mục có evidence OBSERVED trong ledger.

## Risk Assessment

Serverpod CLI/codegen friction trên Windows → spike là bước 3, fail sớm thành BLOCKER rõ ràng; CI không có remote → `NOT_RUN` trung thực, không chặn phase; pgvector image sai tag → chọn lại theo ADR-003 rồi mới tiếp tục.
