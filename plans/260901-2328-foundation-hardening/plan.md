---
title: "CampusMate foundation hardening — gia cố nền móng trước feature nâng cao"
description: "Sửa các defect nền móng tìm được bằng evidence (format gate, plan-state giả, MinIO down, coverage core = 0, logger mất stackTrace), thêm test cho core mobile, git hygiene. Không thêm feature mới."
status: in-progress
priority: P1
effort: M
tags: [hardening, quality, tests, foundation, campusmate]
blockedBy: []
blocks: [260830-1629-campusmate-student-management-e-library-ai]
created: 2026-09-01
---

# CampusMate Foundation Hardening

**Archetype**: Quality/hardening (không thêm user-visible capability).
**Workflow**: `/ak:scout` → `/ak:plan` (plan-lock overlay) → `/ak:fix` + `/ak:test` → `/ak:code-review`.
**Nguồn yêu cầu**: user 2026-09-01 — "dùng ak workflow cải thiện thật kĩ codebase… trụ thật vững thì mới làm chuyện nâng cao hơn". Đây là direct user instruction theo plan-lock, tách khỏi plan 12-phase đang active để không trộn phạm vi feature.

## Outcome Contract

- **Intended result**: Nền móng hiện có của monorepo được chứng minh khỏe bằng evidence: mọi gate CI chạy xanh thật trên máy local, mọi module core có test, plan-state trung thực với thực tế repo, hạ tầng dev compose đúng README.
- **In scope**: (1) sửa format gate đỏ; (2) hoàn tác checkbox phase-02 không có bằng chứng; (3) test cho mobile core — Result/Failure/AppLogger/AppConfig/AppEmptyState/theme tokens/l10n parity; (4) sửa AppLogger mất stackTrace + API context thiếu ở warning/error; (5) git hygiene — .zcode/ ignore, commit DESIGN.md; (6) dựng MinIO container healthy; (7) ledger + code-review + commits Conventional.
- **Out of scope (non-goals)**: không implement phase-02 auth; không đổi kiến trúc/theme/router; không nâng lint lên siêu ngặt (chỉ thêm `unawaited_futures` cho mobile); không deploy; không đụng `packages/campusmate_client` (generated); không rewrite plan 12-phase.
- **Acceptance signals**: `dart format --set-exit-if-changed` exit 0 đúng lệnh CI (mobile + server/packages); `flutter analyze` + `dart analyze` sạch; `flutter test` + `dart test` xanh với coverage core mới; `git grep` secret scan trên diff sạch; containers compose 5/5 healthy; phase-02 file trả về trạng thái `[ ]` trung thực.
- **Constraints**: Windows/Git Bash; không commit secret; giữ nguyên dirty work không liên quan; generated files không sửa tay.
- **Allowed substitutions**: nếu MinIO không dựng được vì lỗi hạ tầng máy → ghi BLOCKER trung thực, không fake healthy.
- **Decision owner**: user. Không replan tự động.

## Evidence — verified facts (OBSERVED 2026-09-01 trên máy)

1. `dart format --set-exit-if-changed --output=none` — **1 file changed**: `apps/mobile/test/ai_stream_spike_test.dart` ⇒ mobile CI gate `dart format --set-exit-if-changed .` sẽ **đỏ** nếu có remote.
2. `plans/260830-1629.../phase-02-auth-student.md` working tree tick `[x]` cả 5 success criteria **chưa commit**, nhưng `git log` không có commit auth nào; ledger ghi phase-02 chưa bắt đầu ⇒ fake progress (vi phạm §91 của chính plan).
3. Mobile tests: chỉ 3 file (2 spike skip + 1 shell smoke) — **Result/Failure/AppLogger/AppConfig/AppEmptyState/theme tokens/l10n không có test nào**; tổng 829 LOC mobile lib.
4. `AppLogger.log` nhận `stackTrace` nhưng **không in ra**; `warning`/`error` không nhận `context` (API lệch nhau giữa các level).
5. `docker compose ps`: 4/5 healthy, **`server-minio-1` chỉ `Created`, không chạy** — README yêu cầu 5/5.
6. `.gitignore` chưa bỏ qua `.zcode/` (runtime state); `DESIGN.md` (nguồn design tokens, được theme code tham chiếu) **untracked**.
7. Analyze sạch cả 3 package; server `dart test` = 1/1 pass (compose test DB healthy).

## Assumptions / prereqs

- Docker engine đang chạy (đã xác nhận 29.7.2, 4 container healthy) — giả định còn đúng trong phiên.
- Không cần AI key, không cần remote git (CI ghi NOT_RUN trung thực như ledger phase-01).

## Implementation Stages

### Stage A — NOW defects (reversible, chặn gate)

| Step | Hành động | Exit criterion |
|---|---|---|
| A1 | `dart format apps/mobile/test/ai_stream_spike_test.dart` | `dart format --set-exit-if-changed --output=none apps/mobile` exit 0 (đúng lệnh CI) |
| A2 | Hoàn tác 5 checkbox `[x]` → `[ ]` trong phase-02-auth-student.md | `git diff plans/...phase-02...` chỉ còn thay đổi đúng 5 dòng; ledger ghi ruling |
| A3 | `.gitignore` += `.zcode/`; commit DESIGN.md | `git status` không còn `.zcode/`; `git ls-files DESIGN.md` = 1 |

### Stage B — Core mobile tests + logger fix

| Step | Hành động | Exit criterion |
|---|---|---|
| B1 | AppLogger: in stackTrace khi có; thêm `context` cho warning/error | `flutter analyze` sạch; test mới chứng minh hành vi |
| B2 | analysis_options mobile += `unawaited_futures` | `flutter analyze` sạch (fix vi phạm nếu có) |
| B3 | Test: result_test, failures_test, app_logger_test (scrub secrets), app_config_test, app_empty_state_test (widget), tokens_test (spacing/radius khớp DESIGN.md), l10n arb parity | `flutter test` xanh, ≥ 15 test mới, 0 skip ngoài 2 spike có sẵn |

### Stage C — Hạ tầng + đóng

| Step | Hành động | Exit criterion |
|---|---|---|
| C1 | `docker compose up -d minio` + diagnose nếu fail | `docker compose ps` 5/5 healthy, hoặc BLOCKER ghi rõ |
| C2 | Kiểm tra `git ls-files server/config` — passwords.yaml không được track | nếu tracked → report, không tự xóa (cần user quyết vì liên quan secret) |
| C3 | Terminal gates: format (2 lệnh CI) + analyze (3 package) + flutter test + dart test + secret scan diff + `git diff --check` | tất cả PASS, ghi command+result vào ledger |
| C4 | Commits Conventional theo nhóm logic; code-review diff | review không còn finding high/critical |

## Risks & rollback

- Mọi thay đổi là git-reversible; rollback = revert commit range của plan.
- Rủi ro thấp nhất: sửa analysis_options có thể lộ vi phạm lint cũ → fix tối thiểu trong cùng commit, không nới lỏng rule.
- Test widget/logger phụ thuộc Flutter framework — nếu API lệch phiên, fix theo lỗi thật, không disable test.

## Documentation impact

- Ledger hardening mới + cập nhật "Next resume point" của ledger campusmate (giữ nguyên: phase-02, nhưng ghi chú hardening đã đóng).
- README không đổi (đã đúng lệnh); nếu MinIO fail → thêm troubleshooting entry.

## Unresolved / blockers

- Không có blocker khi viết plan. C2 có thể sinh ra mục cần user quyết.
