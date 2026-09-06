# ADR-005: Use the Serverpod 3.x auth-idp module (EmailIdp + JWT) for authentication

- Status: Accepted (2026-09-06)
- Phase: 02-auth-student

## Context

Phase-02 requires email/password login, session restore, token refresh, and
role-based access control (student / lecturer / librarian / admin) enforced
server-side. ADR-002 chose Serverpod but left the auth generation open:
Serverpod 3.x ships the new modular `serverpod_auth_idp` family, while the
legacy `serverpod_auth_email` module still exists. The plan reserved ADR-005
for this choice and required a spike before pinning.

## Decision

Use the **Serverpod 3.4.x auth-idp module**, pinned with the rest of the
stack at `3.4.13`:

- Server: `serverpod_auth_idp_server` with the **EmailIdp** identity provider
  and **JWT** token management (`JwtConfigFromPasswords`), wired once in
  `server/lib/src/auth/auth_setup.dart` so the API server and dev tooling
  (seed) share identical auth behavior.
- Client: `serverpod_auth_idp_client` + `serverpod_auth_core_client`; the app
  stores tokens in `flutter_secure_storage` and refreshes transparently via
  `SessionAuthKeyProvider`.

The legacy `serverpod_auth_email` module is not used.

## Role model

Scopes are the single source of truth for roles
(`server/lib/src/auth/campusmate_auth.dart`):
`campusmate.student` / `.lecturer` / `.librarian` / `.admin`. Rules:

- Public email registration receives the **least-privileged student scope**
  by default (`AuthUsersConfig.onBeforeAuthUserCreated`); a registration
  request cannot request a trusted role.
- Only trusted server-side flows (the dev seed script) pass explicit role
  scopes, and the seed re-asserts scopes on existing accounts.
- Endpoints declare `requiredScopes` (enforced by Serverpod before handlers
  run) and derive identity **only from the authenticated session** — no
  client-supplied user id is ever trusted. The mobile app treats the role as
  presentation-only and re-checks nothing client-side.

## Spike evidence

- 2026-09-01 live spike (plan ledger, commit `d3f19df`): registration with
  the dev-log verification code → login → JWT refresh succeeded end-to-end
  against the local server; mobile restore-across-restart covered by 41
  tests.
- 2026-09-06: `server/test/auth_scope_test.dart` proves the registration
  default scope and the trusted-role passthrough;
  `server/test/integration/student_profile_endpoint_test.dart` proves
  cross-user profile isolation (A↔B) and admin 403 against a real database.

## Alternatives considered

- **Legacy `serverpod_auth_email`**: frozen feature set, no scope model that
  fits four roles; would force a second migration later.
- **Hand-rolled auth on `serverpod_auth_core` primitives**: re-implements
  password hashing, verification codes, and token rotation already solved by
  the idp module; rejected as maintenance cost without a requirement gap.

## Consequences

- Registration/password-reset verification codes are emitted through a
  server-log seam (`sendRegistrationCode` / `sendPasswordResetCode`) until a
  mail provider is connected — this is a **development-only** affordance and
  a precondition to revisit before enabling real registrations.
- JWT secrets come from `config/passwords.yaml` (git-ignored); no auth
  secret is committed.
- Upgrades of the auth family must stay on 3.4.x until the whole Serverpod
  stack is upgraded together.
