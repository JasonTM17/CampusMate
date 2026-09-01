# Phase 01 — Foundation hardening execution

## Success Criteria

- [ ] `dart format --set-exit-if-changed --output=none apps/mobile` exit 0 và `dart format --set-exit-if-changed --output=none server packages` exit 0 (đúng 2 lệnh format gate của CI).
- [ ] `flutter analyze` + `dart analyze server` + `dart analyze packages/campusmate_client` đều "No issues found".
- [ ] `flutter test` (apps/mobile) xanh với ≥ 15 test mới cho core (Result/Failure/AppLogger/AppConfig/AppEmptyState/tokens/l10n parity); 2 spike test giữ nguyên trạng thái skip.
- [ ] `dart test` (server) xanh 1/1 như hiện trạng.
- [ ] Phase-02 checkbox trạng thái trung thực `[ ]` — không tick không bằng chứng.
- [ ] `.zcode/` trong .gitignore; `DESIGN.md` committed; working tree sạch các thay đổi ngoài scope.
- [ ] `docker compose ps` = 5/5 healthy (hoặc BLOCKER MinIO ghi trung thực kèm nguyên nhân thật).
- [ ] Secret scan trên toàn bộ diff của plan = sạch; `git diff --check` sạch.
- [ ] Commits Conventional, mỗi commit một ý; ledger cập nhật đủ evidence.

## Steps

1. **A1 format fix** — format file spike test; verify bằng đúng lệnh gate CI mobile.
2. **A2 plan integrity** — revert 5 checkbox phase-02 về `[ ]`; ghi ruling vào ledger.
3. **A3 git hygiene** — ignore `.zcode/`; commit DESIGN.md (nguồn design tokens).
4. **B1 logger fix** — AppLogger in stackTrace; warning/error nhận `context`.
5. **B2 lint** — thêm `unawaited_futures` cho mobile; fix vi phạm nếu lộ ra.
6. **B3 core tests** — viết bộ test theo danh mục trong plan.md Stage B3.
7. **C1 MinIO** — dựng container; diagnose thật nếu fail.
8. **C2 config audit** — kiểm tra passwords.yaml không bị track.
9. **C3 terminal gates** — chạy toàn bộ evidence commands, ghi ledger.
10. **C4 commits + code-review** — commit theo nhóm; review diff; sửa finding trong budget 2 fix.

## Exit criterion của phase

Toàn bộ Success Criteria trên PASS bằng evidence thật trong `reports/execution-ledger.md`, hoặc BLOCKER được ghi rõ nguyên nhân + hướng Unblock.
