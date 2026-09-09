---
phase: 12
title: "Hardening + Release evidence"
status: completed
priority: P2
effort: L
dependencies: [11]
---

# Phase 12: Hardening + Release evidence

## Overview

Củng cố theo §56/§58/§59/§64/§83: integration flows thật, perf, accessibility, security threat model, docs/ + ADR hoàn chỉnh, README onboarding — kết bằng **Kongming pre-ship review** và final report §92 trung thực (không fake PASS/hash).

## Requirements

- Integration (thiết bị/emulator, FakeAiProvider — CI không tốn tiền): (1) Login → Dashboard → Library → Book → Reader → progress saved → resume; (2) Login → AI → send → streamed response; (3) Student morning flow §76 rút gọn.
- Perf: audit rebuild dashboard/list (provider scoped), `ListView.builder` mọi list dài, image cache, server N+1 check, RAG chunk budget — ghi baseline đo được vào ledger (không invent số).
- Accessibility (§44): contrast, dynamic text, semantics, tap target ≥48dp, icon không phải kênh duy nhất.
- Security (§83): threat model 11 risk + mitigation từng mục; `ak:security-scan`; secret scan diff; dependency audit.
- Docs: `docs/architecture.md` (mermaid §65), `database.md` (ERD mermaid §66), `api.md`, `authentication.md`, `ai-architecture.md`, `rag.md`, `security.md`, `offline-sync.md` (LWW + conflict), `testing.md`, `deployment.md`, `git-workflow.md`, `docs/adr/005..008` (auth module, EPUB WebView, LWW, streaming pattern); README hoàn chỉnh §75 (clone → compose → server → flutter run → seed → demo accounts → troubleshooting).

## Related Code Files

- Create/Modify: `docs/**`, `README.md`, `apps/mobile/test/integration/**`, `apps/mobile/integration_test/**`, sửa nhỏ phát hiện từ audit (perf/a11y).

## Implementation Steps

1. Integration test flow (1)(2) chạy trên emulator + host; commit `test(integration): add critical student application flow` + `test(integration): add AI assistant flow`.
2. Perf audit + fix hẹp; commit `perf(app): optimize common list and image rendering`.
3. A11y pass + dark mode checklist; polish hẹp (deferred queue phase trước xử lý ở đây — checkpoint defect).
4. Threat model + security docs; commit `docs(security): document application threat model`.
5. Toàn bộ docs/ + ADR + README; commits `docs(architecture): document system architecture`, `docs(database): add ER diagram`, `docs(deployment): document production deployment`, `docs(readme): complete developer onboarding guide`.
6. **Kongming pre-ship gate**: threat-model completeness + architecture conformance (5 dependency rule + trust boundary) trên snapshot cuối.
7. Final verification: `dart format --set-exit-if-changed .`, analyze cả hai, toàn bộ test suites, compose health, secret scan; fresh clone theo README nếu khả thi; final report §92 (commit hash thật, `NOT_RUN` ghi thật cho thứ chưa chạy).

## Success Criteria

- [x] 2 integration flow PASS trên emulator; dashboard không rebuild vô lý (audit ghi evidence).
- [x] Threat model đủ 11 risk §83, mỗi risk có mitigation + test/edge liên quan đã PASS ở phase trước.
- [x] `docs/` đủ 11 file + ADR 005–008; README mới clone chạy được tới màn login.
- [x] Kongming pre-ship verdict có Conditions = 0 hoặc đã xử lý hết; findings high/critical = 0.
- [x] Final report §92 với validation thật: flutter analyze / dart analyze / flutter test / dart test / compose health — PASS hoặc NOT_RUN kèm lý do.

## Risk Assessment

Phạm vi trôi (polish vô tận) → chỉ xử lý deferred queue đã ghi, tính năng mới = out-of-scope; emulator không có trên máy → integration chạy host + desktop, ghi limitation; docs drift code → viết sau khi code ổn định trong phase này, link thay vì trích lớn.
