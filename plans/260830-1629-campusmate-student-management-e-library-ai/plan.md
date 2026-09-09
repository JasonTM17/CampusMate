---
title: "CampusMate student management + e-library + AI"
description: "Greenfield Flutter + Serverpod monorepo: quan ly sinh vien, thu vien ebook online (PDF/EPUB, muon/tra, offline) va AI assistant ca nhan hoa voi RAG. 12 phase, co gate Kongming/Wukong."
status: completed
priority: P1
effort: XL
tags: [flutter, serverpod, campusmate, feature, mobile, ai, rag]
blockedBy: []
blocks: []
created: 2026-08-30
---

# CampusMate — Student Management + E-Library + Personalized AI

**Archetype**: Feature (greenfield, end-to-end user-visible capability).
**Workflow**: `/ak:goal-warmup` → `/ak:scout` → `/ak:plan` (+ overlay `/ak:plan-lock` khi thực thi) → `/ak:cook` → `/ak:test` → `/ak:code-review`.
**Advisory evidence (2026-08-30)**: Kongming = **GO-WITH-CONDITIONS** (7 điều kiện — đã nhúng vào phase tương ứng); Wukong = **NOT_FALSIFIED / PROCEED_WITH_RESIDUAL_RISK** (3 probes R0, evidence pub.dev + docs chính thức). Không finding nào thuộc lớp `outcome-change-request` hay `blocker`.
**Yêu cầu nguồn**: Master prompt 95 mục của user (bản dán 2026-08-30) = Outcome Contract do chính user khóa.

## Executive Summary

Xây **CampusMate** ("Study. Read. Grow.") — app Flutter cho sinh viên đại học gộp 3 trụ: quản lý học tập (hồ sơ, thời khóa biểu, điểm/GPA, lịch thi, tiến độ), thư viện ebook online (PDF/EPUB, chính sách truy cập, mượn/trả, ghi chú/đánh dấu, đồng bộ tiến độ, offline) và AI assistant cá nhân hóa (context theo từng sinh viên, chat streaming, RAG có lọc quyền + citation). Backend Dart full-stack (Serverpod + PostgreSQL/pgvector + Redis + MinIO), mobile không bao giờ giữ AI key hay chạm DB trực tiếp. 12 phase độc lập kiểm chứng được, mỗi phase khép kín `implement → format → analyze → test → fix → commit` với gate Advisor/Kongming/Wukong tại các điểm rủi ro cao.

## Outcome Contract (user-locked)

- **Intended result**: Monorepo production-grade chạy được cục bộ theo README: `docker compose up -d` → server boot → `flutter run` → demo student đăng nhập → toàn bộ 30 tiêu chí nghiệm thu của master prompt §90 đạt.
- **In scope**: Auth + RBAC 4 role (student/lecturer/librarian/admin, kiểm quyền ở SERVER); student profile; academic (courses/timetable/grades+GPA/exams/progress); dashboard cá nhân hóa + notifications + deep link; library (catalog, search debounce + cursor pagination, filter, book detail, access policy 5 mức, borrow/return an toàn concurrency); reader (PDF+EPUB, progress LWW sync, bookmark/note/highlight, offline có kiểm quyền); AI core (provider abstraction, streaming, hội thoại, quota); personalized AI (StudentContextBuilder, memory user-controlled); RAG (ingestion → chunk → embed → pgvector → retrieval có lọc quyền trước LLM → citation); admin + audit log; offline pull-cache; test/unit+widget+integration; CI; docs + ADR; git history Conventional Commits ý nghĩa.
- **Out of scope (non-goals)**: tích hợp API thật HCMUTE (chỉ chuẩn bị Adapter/Repository seam), logo/branding/dữ liệu thật HCMUTE, ebook có bản quyền, scrape website trường; generic offline-sync framework (chỉ pull-cache server-authoritative + đúng 1 đường client-write: reading-progress LWW — điều kiện Kongming C5); push notification FCM; deploy production; dịch English UI (chỉ architecture-ready); payment; Sentry thật (chỉ để seam).
- **Acceptance signals**: 30 điểm §90 master prompt; mỗi phase có exit criterion + lệnh kiểm chứng cụ thể trong phase file; không fake PASS/commit hash (§91).
- **Constraints**: dev trên Windows (Git Bash); không cần AI key thật — FakeAiProvider mặc định (§94); dữ liệu trường = mock/seed giả rõ ràng; sách mẫu public-domain/tự tạo; secrets không commit.
- **Allowed substitutions**: chỉ những gì user chỉ định sẵn (FakeAiProvider/MockAiProvider; MinIO dev ↔ S3-compatible prod sau).
- **Decision owner**: user. Replan chỉ theo Advisor/Kongming/Wukong evidence-backed hoặc lệnh trực tiếp của user (plan-lock).

## Evidence — verified facts vs assumptions

**OBSERVED trên máy (2026-08-30)**: Flutter 3.44.0 stable / Dart 3.12.0; Docker 29.7.2; git, node, `ak` CLI, `gh` PRESENT; **Serverpod CLI ABSENT**; **chưa phải git repo**.
**OBSERVED online (Wukong, evidence = pub.dev/docs chính thức)**: Serverpod **3.4.13** (2026-08-28, SDK ^3.8.0 ⇒ khớp Dart 3.12; **4.0.0-rc.1 đã phát hành — phải pin 3.4.x**); Serverpod 3.x có auth module thế hệ mới (`serverpod_auth_core`, email identity, scopes, token refresh) + streaming endpoints (WebSocket) + `session.db.transaction` + **vector fields native** (`Vector(1536)`, distance operators, vector index); Docker image `pgvector/pgvector` (0.8.6-pg18) maintained; Serverpod default Docker Postgres đã kèm pgvector; **pdfrx 2.5.0** (PDF: Android/iOS/desktop, text selection/search; Windows build cần Developer Mode/symlink); **flutter_epub_viewer 2.0.0** (Epub.js + flutter_inappwebview — WebView là path chính cho EPUB, không phải fallback); `epubx 4.0.0` (parser-only, cũ nhưng dùng được); Drift `insertOnConflictUpdate`/`DoUpdate` = upsert đủ cho LWW outbox; quirk Serverpod transaction [#2442](https://github.com/serverpod/serverpod/issues/2442) (tránh `attachRow` trong transaction — borrow test dùng plain SQL).
**ASSUMED (phải verify ở Phase 1, trước khi build trên đó)**: (A1) `dart pub global activate serverpod_cli` + codegen chạy sạch trên Windows/Dart 3.12; (A2) `docker compose up` healthy cả 3 service trên host này; (A3) streaming endpoint pattern chạy cho chat; (A4) `CREATE EXTENSION vector`/vector column qua đường migration Serverpod. Mỗi assumption có bước verify = exit evidence của phase-01.
**UNRESOLVED DECISIONS (không block, có gate riêng)**: chọn thế hệ auth module (ADR-005, spike ở phase-02); prod storage (defer — dev dùng MinIO).

## Phase Index

| # | Phase | Independently verifiable outcome | Deps | Priority | Owner |
|---|---|---|---|---|---|
| 01 | [Foundation + stack spike](./phase-01-foundation.md) | Monorepo boot: mobile shell lên, server health OK, compose healthy, 1 migration + client call thật, CI run xanh thật | [] | P1 | controller |
| 02 | [Auth + Student + RBAC](./phase-02-auth-student.md) | Login/session restore/profile; **test isolation: A không đọc được B** | [01] | P1 | controller |
| 03 | [Academic](./phase-03-academic.md) | Courses/timetable/grades+GPA service/exams/progress + seed + offline pull-cache | [02] | P1 | controller |
| 04 | [Dashboard + Notifications](./phase-04-dashboard-notifications.md) | Dashboard đủ state + notification center + deep link đúng đích | [03] | P1 | controller |
| 05 | [Library catalog + access policy](./phase-05-library-catalog.md) | Tìm kiếm/filter/pagination/book detail; BookAccessPolicyService là authority duy nhất | [04] | P1 | controller |
| 06 | [Lending + audit](./phase-06-lending-audit.md) | Borrow/return transaction-safe; **2 borrow song song ⇒ đúng 1 loan**; audit_logs ghi từ mutation đầu tiên | [05] | P1 | controller |
| 07 | [Ebook Reader](./phase-07-reader.md) | Mở PDF+EPUB thật, progress resume, bookmark/note/highlight, offline có kiểm quyền | [06] | P1 | controller |
| 08 | [AI Core](./phase-08-ai-core.md) | Chat streaming qua backend, hội thoại persist, quota server-side, prompt-injection baseline | [07] | P1 | controller |
| 09 | [Personalized AI](./phase-09-personalized-ai.md) | Context theo student, không leak chéo; AI Memory user-controlled | [08] | P2 | controller |
| 10 | [RAG](./phase-10-rag.md) | Retrieval có lọc quyền DB-level TRƯỚC LLM + citation; **test âm: restricted doc không bao giờ được retrieve** | [09] | P2 | controller |
| 11 | [Admin + Audit](./phase-11-admin.md) | Quản lý student/book/announcement + upload validation + audit read UI | [10] | P2 | controller |
| 12 | [Hardening + Release evidence](./phase-12-hardening.md) | Integration flow thật, threat model, docs/ + ADR đầy đủ, README onboarding, Kongming pre-ship | [11] | P2 | controller |

*(Số phase 05/06 là kết quả tách "Library" theo điều kiện Kongming C4. Ưu tiên P1/P2 ở đây map P0/P1/P2 của master prompt §93: phase 01–08 = P0, 09–11 = P1, 12 = P1/P2.)*

## Acceptance Matrix (trích từ §90, đầy đủ nằm trong phase files)

| Requirement | Authoritative evidence | Owner | Required result |
|---|---|---|---|
| Backend start bằng documented commands | `docker compose up -d` + server health OK trên host này | controller | PASS, ghi log thật |
| Login demo student / session restore | integration test + manual `flutter run` | controller | PASS |
| A không xem dữ liệu B (profile/grades/notes/conversation/RAG) | security test suite phase-02/08/09/10 | Wukong gate | 403/404, không leak |
| Timetable/grades/exams/progress đúng seed | widget + unit test + demo | controller | PASS |
| GPA không hard-code ở UI | `GpaCalculator` unit test nhiều policy | controller | PASS |
| Search/filter/pagination library | API test cursor pagination + debounce unit test | controller | PASS |
| Access policy 5 mức đúng | policy matrix test phase-05a | controller | PASS |
| Borrow race an toàn | deterministic concurrency test phase-05b | Wukong gate | đúng 1 active loan |
| Đọc PDF/EPUB + resume + bookmark/note | reader integration test + demo | controller | PASS |
| Offline re-check policy khi mở file cached | phase-06 test | controller | PASS |
| AI chat streaming + quota | FakeAiProvider integration test | controller | PASS |
| RAG citation + không retrieve doc trái quyền | negative test phase-09 | Wukong gate | restricted = 0 chunk |
| Librarian/Admin quản lý + audit log | admin API test + audit row assertion | controller | PASS |
| Static analysis + tests | `flutter analyze` / `dart analyze` / test suites | controller | PASS, không disable lint |
| Git history ý nghĩa, không secret | `git log --oneline` + secret scan | controller | Conventional Commits |

## Architecture & Risk Summary

**Cấu trúc monorepo** (theo §6 master prompt): `apps/mobile` (lib: app/, core/, features/<feature>/{data,domain,presentation}), `packages/shared_models`, `server` (Serverpod: src endpoints/models + migrations + config), `docker-compose.yml`, `.github/workflows/`, `docs/`, `docs/adr/`.

**Trust boundaries (cứng)**: (a) mobile ↔ API — mobile là untrusted, identity CHỈ từ authenticated server session, không bao giờ tin `userId` từ payload; (b) LLM boundary — nội dung tài liệu là dữ liệu không tin cậy, authorization resolve xong mới cho text rời DB tới provider; (c) storage boundary — signed URL chỉ được mint ở server SAU KHI `BookAccessPolicyService` duyệt.

**Dependency rules (Kongming — viết vào plan như ràng buộc cứng)**:
1. Feature không import presentation/data của feature khác; giao chéo chỉ qua domain interface/core service.
2. Mobile không chứa AI key, không gọi AI provider trực tiếp, không mở DB connection; mọi flow AI/storage đi qua Serverpod endpoint.
3. `BookAccessPolicyService` là authority DUY NHẤT cho mọi đường đọc tài liệu (stream, download, offline gate, RAG retrieval, signed URL); ẩn nút ở client chỉ là cosmetic.
4. Domain layer pure Dart (không import Flutter/Material/Drift/Serverpod) để `GpaCalculator`, policy, LWW logic test được.
5. Chỉ AuditService được ghi `audit_logs`.

**Highest risks → gate**: RAG authorization bypass → phase-10 (Wukong + fresh confirmation) · IDOR chéo sinh viên → phase-02, tái chứng minh 08/09/10 · Serverpod/Windows/pgvector friction → phase-01 spike · borrow race → phase-06 (Wukong) · prompt injection → phase-08 baseline + phase-10 fixtures · signed-URL/offline leakage → phase-07 (Kongming review trước khi code) · EPUB single-maintainer + pdfrx Developer Mode → phase-07 spike + README · SSPL license + auth module churn + Serverpod 4.0-rc → ADR ở phase-01/02 (pin 3.4.x).

**Residual limits**: local/deterministic evidence không chứng minh được deploy production, thiết bị iOS thật, chi phí LLM thật, hay hành vi provider thật — ghi ở phase-11 final report (§91/§92: không fake PASS).

## Agent roster & authority map (theo yêu cầu user)

| Role | Kích hoạt khi | Quyền | Gate |
|---|---|---|---|
| **Advisor** (`/ak:advise`) | outcome/scope/trade-off nhập nhằng TRƯỚC khi đổi path code | tư vấn, không code | mọi scope change → user quyết |
| **Kongming** (subagent, advisory) | review kiến trúc/trình tự; gate: phase-01 exit, phase-07 pre-implementation, phase-12 pre-ship | counsel + điều kiện, không tự sửa plan | GO-WITH-CONDITIONS đã thu; tái trigger theo bảng gates |
| **Wukong** (`/ak:wukong`, read-only R0) | claim giả falsifiable load-bearing: IDOR (02), borrow race (06), RAG authz bypass (10), release claim (12) | điều tra + verdict FALSIFIED/NOT_FALSIFIED; không tự sửa, không tự duyệt | high/critical finding phải có fresh independent confirmation |
| **ak:mobile-development / ak:backend-development / ak:databases** | specialist slice Flutter / Serverpod / schema-migration-pgvector trong phase tương ứng | implement trong file set được giao | worker không lồng delegate |
| **ak:security + ak:security-scan** | phase-02 (auth), phase-10 (RAG), phase-12 (threat model + scan) | review + scan, read-only | finding high/critical → chặn ship |
| **ak:frontend-design / ak:ui-ux-pro-max** | phase-01 design tokens, phase-06 reader UI | design system + UI spec | — |
| **ak:test** | mỗi phase exit + phase-11 integration | chạy/đọc kết quả gate, không chỉnh oracle | không weaken gate |
| **ak:code-review** | sau mỗi phase trước commit đóng phase | review diff, read-only | finding → bounded repair circuit (≤2 fix + 1 specialist) |
| **ak:debug / ak:git** | khi gate fail có nguyên nhân / thao tác git | diagnose / commit đúng quy trình | — |

Nguyên tắc: 1 wave mỗi lần, role bắt buộc của workflow giữ nguyên; không thêm agent để "cho đủ"; worker không spawn con; controller tích hợp toàn bộ finding và là người duy nhất đổi trạng thái plan.

## Preflight Matrix

**Must provide trước khi vào long-run**: git init + identity config (phase-01 bước 1) · Serverpod CLI 3.4.x cài được (A1) · `docker compose up -d` healthy (A2) · streaming spike (A3) · vector extension (A4) · FakeAiProvider (không cần key). Mục nào chưa verify → chấm `unknown` và coi là blocker của phase-01, không fake Ready.
**Should decide trước long-run**: thế hệ auth module (ADR-005, phase-02) · pin package reader sau spike (phase-06).
**Có thể defer**: chọn prod storage (S3/R2/Supabase), Sentry DSN, bản dịch en, FCM, local reminder lịch thi.

## Delivery & Recovery

- **Rollout**: theo thứ tự phase; mỗi phase là vertical slice chạy được; không commit khi analyze/test đỏ (§2).
- **Rollback**: revert theo commit range của phase (Conventional Commits, atomic per §70 roadmap); migration chỉ đi tới, reset bằng seed script trong dev; không force-push, không rewrite history.
- **Observability**: logging abstraction 4 mức, sanitize (không log password/token/AI key/signed URL); seam Sentry để trống.
- **Release identity**: tag `phase-XX` sau mỗi phase PASS; final report §92 với commit hash thật.

## Handoff

- **Current decision**: READY chờ user duyệt plan (plan-lock: implementation KHÔNG tự khởi động).
- **Next phase/owner**: phase-01-foundation → controller.
- **Required gates**: xem bảng roster + cột gate trong phase files.
- **Commit/push/CI state**: repo chưa init (phase-01 bước 1); chưa có remote → CI chạy khi user cấp remote; nếu không có remote thì CI = `NOT_RUN` ghi thật, không fake.

## Additive Execution Control (plan-lock overlay)

- **Plan lock**: resume từ bước chưa hoàn thành đầu tiên; giữ mọi gate; không replan tự động; ledger bắt buộc.
- **Execution ledger**: `reports/execution-ledger.md` (dòng đầu non-heading = đường dẫn plan này).
- **Verification budget**: trong lúc code chỉ chạy check rẻ nhất giữ bước an toàn (format/analyze file đổi, 1 regression liên quan); full suite chỉ ở phase exit; không rerun gate xanh không đổi; sửa lỗi = ≤2 lần fix tập trung + ≤1 lần specialist-guided, sau đó chặn lại report blocker.
- **Spawn budget**: đúng roster trên; không spawn trùng evidence.
- **Deferred queue**: finding không chặn → ghi ledger, xử lý ở checkpoint defect của phase-11.
- **Drift tripwire**: dùng bảng NOW/LATER/BLOCKER của AGENTS.md; ambiguity từ ngữ = execution ruling và ghi ledger.
