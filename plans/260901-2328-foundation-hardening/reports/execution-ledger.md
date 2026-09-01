# Execution Ledger — Foundation Hardening

plans/260901-2328-foundation-hardening/plan.md

## Active plan identity

- Plan: CampusMate foundation hardening (archetype: Quality)
- Created: 2026-09-01 · Status: `in-progress`
- Workflow: scout → plan (plan-lock) → fix + test → code-review
- Authorization: direct user instruction 2026-09-01 ("cải thiện thật kĩ codebase, trụ vững trước khi nâng cao") — tách plan riêng, không đụng plan 12-phase.

## Completed steps & evidence

- **A1 format fix** — `dart format apps/mobile/test/ai_stream_spike_test.dart` (1 changed). Gate riêng file này = PASS. Lưu ý: `dart format --set-exit-if-changed apps/mobile` toàn package còn lộ 5 file auth **của session song song** chưa format — không thuộc phạm vi plan này, không can thiệp; gate CI mobile sẽ xanh khi session kia format xong file của họ.

## Current step

- A3 git hygiene → B1 logger fix.

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

- Stage A1.
