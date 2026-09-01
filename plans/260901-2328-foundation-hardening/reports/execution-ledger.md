# Execution Ledger — Foundation Hardening

plans/260901-2328-foundation-hardening/plan.md

## Active plan identity

- Plan: CampusMate foundation hardening (archetype: Quality)
- Created: 2026-09-01 · Status: `in-progress`
- Workflow: scout → plan (plan-lock) → fix + test → code-review
- Authorization: direct user instruction 2026-09-01 ("cải thiện thật kĩ codebase, trụ vững trước khi nâng cao") — tách plan riêng, không đụng plan 12-phase.

## Completed steps & evidence

- **A1 format fix** — commit `edd0039`: `dart format apps/mobile/test/ai_stream_spike_test.dart`. Gate riêng file này PASS. Gate toàn package `apps/mobile` vẫn đỏ **vì 6 file auth dang dở của session song song** (auth_controller_test, auth_spike_test, login_screen_test, 3 file features/auth) — không thuộc quyền sở hữu của plan này.
- **A3 git hygiene** — commit `71866f2`: `.gitignore` += `.zcode/`; `DESIGN.md` (nguồn design tokens) đã tracked; kèm plan + ledger hardening.
- **B1 logger** — commits `377f3cc` + `c7d3335`: AppLogger giờ (1) in stackTrace khi truyền vào, (2) warning/error nhận `context` (API đồng bộ giữa các level), (3) scrub secret **case-insensitive + snake_case** (`api_key`, `access_token`, `refresh_token`, `signed_url`, `secret`) — self-review phát hiện doc hứa `API_KEY` nhưng set cũ chỉ chứa camelCase, đã sửa + test chứng minh.
- **B2 lint** — commit `0c45ca3`: mobile `analysis_options.yaml` += `unawaited_futures`; `dart analyze` scoped vùng core/theme/config/test của plan = **No issues found**.
- **B3 core tests** — commit `aa28fb7`: 7 file test mới (result, failures, app_logger, app_config, app_empty_state widget, theme tokens khớp DESIGN.md, l10n arb parity vi/en) = **32 test, 32 pass** (`flutter test test/core test/theme test/l10n test/app` → `+32 All tests passed`). 0 skip mới; 2 spike có sẵn giữ nguyên.
- **C1 MinIO** — **BLOCKER hạ tầng máy**: `server-minio-1` không start được, `Bind for 127.0.0.1:9000 failed: port is already allocated`. Chủ port: container `infrastructure-minio-1` (compose project `infrastructure`, KHÔNG thuộc repo, đang healthy) — PID 21652 `com.docker.backend.exe`. Không tự stop project Docker của user. Server dev hiện không tham chiếu MinIO trong `config/development.yaml` (chuẩn bị cho phase-07) nên mọi thứ vẫn chạy bình thường. Unblock: (a) khi không còn cần project `infrastructure` → `docker stop infrastructure-minio-1` rồi `docker compose -f server/docker-compose.yaml up -d minio`; hoặc (b) phase-07 remap port CampusMate compose (vd 9100/9101) + cập nhật storage endpoint.
- **C2 config audit** — PASS: `git check-ignore -v server/config/passwords.yaml` → ignored bởi `server/.gitignore:15`; `git ls-files server/config` = 5 yaml, passwords.yaml KHÔNG được track. (Lần check đầu false-negative do chạy sai đường dẫn tương đối — đã chạy lại từ root.)
- **C3 terminal gates (OBSERVED)**:
  - `dart format --set-exit-if-changed --output=none server packages` → 0 changed, PASS.
  - `dart test` (server, compose test DB healthy) → **+1 All tests passed**.
  - `git diff --check` → sạch (chỉ CRLF warning chuẩn Windows).
  - Secret scan `git diff de9f2ef..HEAD` → chỉ false positive từ chuỗi test/logger, **sạch secret thật**.
  - `flutter analyze` toàn package: vùng plan này = 0 issue; 79 issue còn lại **toàn bộ** thuộc file dang dở của session song song.
  - `flutter test` toàn package: hiện không compile được vì test dang dở của session kia (`login_screen_test.dart` const list lỗi, `registration_screen.dart` tham chiếu l10n key chưa thêm vào arb) — ghi nhận trung thực, sẽ xanh khi họ xong.
- **C4 code-review** — self-review controller trên diff `de9f2ef..HEAD` (8 commit, +905/−16), đọc đầy đủ phần lib + test; 1 finding (snake_case scrub) đã fix `c7d3335`. Giới hạn ghi nhận: review này là self-review, không phải agent độc lập — không có claim high-risk nào cần Wukong.

## Current step

- Đóng plan. Không còn bước implementation.

## Deferred findings (LATER)

- Mobile CI format gate sẽ xanh khi session phase-02 format 6 file của họ (đã format file spike test của mình — `edd0039`).
- `unawaited_futures` chỉ mới bật cho mobile; server đã có sẵn. Cân nhắc thêm `avoid_dynamic_calls`/`prefer_final_locals` ở checkpoint defect phase-11 (không gấp, tránh noise).
- Router/app_shell/providers chưa có widget test riêng — app_shell_smoke_test có sẵn; phần router guard thuộc phase-02/04 (session kia đang implement), tránh trùng.
- Server web routes (`root.dart`, `app_config_route.dart`) chưa có test — LATER, review khi phase-08 đụng web layer.

## Authorized rulings

- Goal-warmup pipeline (ask_user gate) không chạy full: user đã khóa outcome bằng chính lời yêu cầu + budget tự động; plan này là hiện thân của contract đó. Ghi nhận theo plan-lock "direct user instruction may revise the plan".
- Plan 12-phase giữ nguyên trạng thái; ledger của nó chỉ cập nhật dòng Next resume point nếu cần.
- **[23:32 2026-09-01] CONCURRENT SESSION DETECTED**: một session song song đang implement phase-02 auth trên cùng working tree (file mới `apps/mobile/lib/features/auth/**`, sửa `app/providers.dart`, `app_router.dart`, `lib/l10n/*.arb`, `pubspec.yaml`; mtime 23:26–23:31+; chưa commit; chưa có commit mới). Đây là chủ nhân của checkbox `[x]` chưa commit trong phase-02.
- **Ownership ruling**: thu hẹp file set của plan này thành vùng rời biệt: `apps/mobile/lib/core/**`, `apps/mobile/lib/app/theme/**`, `apps/mobile/lib/app/config/**`, `apps/mobile/test/{core,theme,l10n,app/config}/**`, `apps/mobile/analysis_options.yaml`, `.gitignore`, `DESIGN.md`, hạ tầng Docker, `plans/260901-2328-foundation-hardening/**`. CẤM đụng: `features/**`, `app/providers.dart`, `app/router/**`, `lib/l10n/*.arb`, `pubspec.yaml`, `plans/260830-1629.../phase-02-auth-student.md`.
- **A2 DROPPED** (hoàn tác checkbox phase-02): file thuộc session song song đang chạy; chỉnh sẽ clobber công việc của họ. Chuyển thành quan sát báo user: checkbox tick TRƯỚC khi có code/evidence (vi phạm §91 plan gốc) — session kia đang bù code thật; nếu session đó chết giữa chừng, checkbox phải hoàn tác về `[ ]`.
- Commit chỉ stage explicit paths của mình; không commit file dirty của session khác; terminal gate nếu đỏ do file auth dang dở của họ thì ghi nhận trung thực, không tính là defect của plan này.

## Deferred findings (LATER)

- (điền khi xuất hiện)

## Next resume point

- Plan này ĐÓNG ở mức "hardening phần sở hữu hoàn tất, 1 BLOCKER hạ tầng MinIO chờ user". Không có bước kế tiếp nội bộ.
- Việc tiếp theo của dự án vẫn theo plan 12-phase: phase-02 auth (session song song đang chạy) — chờ họ commit xong rồi verify các Success Criteria của họ có evidence thật trước khi tick.
