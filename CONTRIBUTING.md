# Contributing to CampusMate

Thank you for your interest in contributing to **CampusMate** ("Study. Read. Grow.")! This repository is engineered with strict quality gates, automated verification pipelines, and transparent architecture adhering to the **AgentKit (AK) workflow**.

Please read through this guide before creating a pull request or submitting code.

---

## 🏛️ Development Philosophy & Invariants

All contributions must respect the foundational system invariants:

1. **Server-Side Authorization**: Security and RBAC are strictly evaluated on the Serverpod backend. The Flutter client never makes authorization decisions.
2. **Session Identity Only**: User identity is derived solely from the authenticated session context, never from unverified request payloads.
3. **Zero Client Secrets**: Secrets (AI API keys, database credentials, server private keys) must never be bundled into the mobile client.
4. **Offline First (Pull Cache)**: Mobile features utilize Drift SQLite for local caching, ensuring instant load times and resilient offline behavior.
5. **Traceable Quality Gates**: No untested, unformatted, or unanalyzed code may be merged into `main`.

---

## 🚀 Getting Started

### 1. Prerequisites
- **Flutter SDK**: `^3.44.0` (Dart `^3.12.0`)
- **Serverpod CLI**: `3.4.x` (`dart pub global activate serverpod_cli`)
- **Docker Desktop**: Docker engine running with Linux containers (for PostgreSQL + pgvector and Redis)

### 2. Monorepo Setup
```bash
# 1. Clone repository
git clone https://github.com/JasonTM17/CampusMate.git
cd CampusMate

# 2. Boot development infrastructure
cd server
docker compose up -d
docker compose ps # All containers must report healthy

# 3. Apply migrations and run server
cd ..
dart pub get
cd server
dart run bin/main.dart --apply-migrations

# 4. (Optional) Seed mock data in a separate terminal
$env:CAMPUSMATE_SEED_PASSWORD = 'YourSecureLocalPassword123'
dart run bin/seed.dart --apply-migrations

# 5. Launch mobile application
cd ../apps/mobile
flutter pub get
flutter run -d chrome # Or target Android / iOS emulator
```

---

## 🌿 Branching & Git Workflow

We follow a structured branching and release model:

- `main`: Production-ready branch. Direct pushes are restricted to verified release points.
- `feature/<name>`: New feature implementations or enhancements.
- `fix/<name>`: Scoped bug fixes and regressions.
- `chore/<name>`: Tooling, dependency updates, and maintenance.

### Conventional Commits
All commit messages must adhere to the [Conventional Commits](https://www.conventionalcommits.org/) format:

| Type | Purpose | Example |
|---|---|---|
| `feat` | New feature or user-visible functionality | `feat(library): add book borrowing confirmation modal` |
| `fix` | Bug fix or regression resolution | `fix(auth): clear session storage when token expires` |
| `test` | Adding or refactoring automated tests | `test(dashboard): verify AI suggestion empty state` |
| `perf` | Performance optimization | `perf(mobile): optimize list view image caching` |
| `docs` | Documentation additions or updates | `docs(api): add endpoint schema for student profile` |
| `refactor`| Code change that neither fixes a bug nor adds a feature | `refactor(shared): extract GPA calculation utility` |
| `chore` | Build process, auxiliary tools, or config | `chore(deps): bump serverpod client dependencies` |

---

## 🛡️ Pre-Commit Quality Gates (AK Standard)

Before opening a pull request, run and ensure **100% PASS** on all pre-commit gates:

```bash
# 1. Format code (zero deviations allowed)
dart format --set-exit-if-changed .

# 2. Analyze server and shared packages
dart analyze server packages/campusmate_shared packages/campusmate_client

# 3. Analyze mobile Flutter application
flutter analyze apps/mobile

# 4. Run automated test suites
cd apps/mobile && flutter test
cd ../../server && dart test --exclude-tags integration
```

---

## 🔍 Pull Request Checklist

When submitting a Pull Request:

- [ ] Branch is branched from latest `main`.
- [ ] Code follows official [Dart style guide](https://dart.dev/guides/language/effective-dart/style) and `dart format` passes.
- [ ] No new analyzer warnings, hints, or deprecation notices introduced.
- [ ] Unit and widget tests accompany any new functionality or bug fix.
- [ ] Relevant documentation in `docs/` or `README.md` is updated.
- [ ] No credentials, `.env` files, or API keys are included in the git diff.

---

## 📖 Useful Documentation Links

- [Documentation Hub](docs/README.md)
- [System Architecture](docs/architecture.md)
- [Database Schema & ERD](docs/database.md)
- [Serverpod API Catalog](docs/api.md)
- [Testing Strategy](docs/testing.md)
- [STRIDE Threat Model](docs/threat-model.md)
- [Git Workflow Details](docs/git-workflow.md)
