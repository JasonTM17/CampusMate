---
type: tester
date: 2026-08-27
---

# Tester Report: Grok Build Integration

## Summary

Grok Build nhận đúng registry AgentKit trong source checkout và trong một
project cài mới: 104 entrypoint skill duy nhất và 17 Claude-compatible agent.
Installer Grok đạt happy path, idempotency và fail-closed collision; một lệnh
`/ak:help` chạy thật trả sentinel `GROK_AK_COLON_OK`.

## Findings

### Discovery và live runtime

- `grok version`: `1.0.5 (5115b46bc9) [stable]`.
- `grok inspect --json` tại AgentKit: 104 skill project từ `.agents/skills`,
  17 agent project từ `.claude/agents`.
- Project E2E cài bằng `-ProjectRuntime Grok`: 104 file `SKILL.md`, 17 agent;
  `grok inspect --json` thấy 104 skill project, 104 tên unique, 17 agent.
- Headless live smoke trong project E2E: exit 0, `/ak:help` trả
  `GROK_AK_COLON_OK`.
- Không có `.grok/skills` hoặc `.claude/skills` trong project E2E.

### Installer và failure paths

- `scripts/test-install-agentkit.ps1`: PASS toàn bộ fixture suite, gồm Grok
  adapter, stale cleanup, junction/copy, collision safety và validate-only.
- Project E2E reinstall: PASS; fingerprint byte của project không đổi.
- Project E2E collision với agent người dùng: PASS fail-closed, exit 1; file
  người dùng giữ nguyên và không có ghi dở `.agents`.
- `test_validate_grok_adapter.py`: PASS, 5 regression tests covering clean
  discovery fallback, duplicate `.grok/skills`, project model/key config,
  missing agent/host path/wrapper drift, and runtime name normalization.

### Static, parity và regression gates

| Gate | Result |
|---|---|
| Python AST/bytecode + manifest JSON parse | PASS |
| PowerShell parser (`install-agentkit.ps1`, test script) | PASS |
| Credential-like pattern scan trên file thay đổi | PASS; không có secret |
| `validate-grok-adapter.py` | PASS; 104/103/17, live inspect PASS |
| `validate-project-assets.py` | PASS |
| Gemini generator/check + validator | PASS; 104/103/17 |
| OpenCode generator/check + validator | PASS; 103/17 |
| Manifest unit tests | PASS; 2 tests |
| Manifest generation check | PASS; 1495 files |
| `git diff --check` | PASS; chỉ cảnh báo chuyển LF/CRLF của Git |
| Combined Wukong gate (including `grok-adapter-tests`) | PASS_WITH_BLOCKED_CAPABILITY; errors 0, failed steps 0 |

### Review evidence

- Independent tester evidence: PASS.
- Independent code-reviewer worker: `BLOCKED_CAPABILITY`/not returned because
  of the worker usage limit. Controller performed a read-only exact-scope audit;
  no out-of-scope file or credential was found. This is not equivalent to an
  independent code-review approval.

## Coverage and build status

- Code coverage: N/A; đây là installer/adapter contract, không có test runner
  coverage instrumentation. Critical paths được phủ bằng acceptance E2E,
  idempotency và negative collision tests.
- Build: PASS cho các script Python/PowerShell qua parse, validator và gate.
- UI/browser: N/A; không có giao diện thuộc thay đổi này.

## Critical issues

1. Combined gate ghi nhận `evaluation-portability` là
   `BLOCKED_CAPABILITY` vì Windows host không có symlink privilege (EPERM).
   Đây là giới hạn môi trường có sẵn, không phải failure của Grok adapter.
2. Lượt headless live có cảnh báo cấu hình toàn cục Claude/MCP của máy
   (`privacy` không nhận diện, một số MCP handshake/auth timeout), nhưng model
   vẫn trả sentinel và không có lỗi adapter. Hook trust và mọi provider khác
   vẫn là evidence gate riêng.

## Recommendations

1. Đã chạy lại `validate-grok-adapter.py` và combined gate trên release HEAD;
   review độc lập vẫn là residual gate do worker bị quota.
2. Nếu cần chứng minh hook lifecycle, trust hook trong Grok rồi chạy một probe
   riêng; không suy diễn từ `inspect`.

## Unresolved Questions

- Chưa có bằng chứng cross-machine hoặc CI cho quyền symlink Windows.
- Chưa xác nhận toàn bộ model/provider matrix; smoke hiện chỉ xác nhận skill
  `/ak:help` được nạp và gọi thành công.
