# CampusMate Git Workflow & Contribution Guide

This document outlines branching conventions, commit standards, and quality gates enforced across the CampusMate repository.

---

## 1. Branching Strategy

- `main`: Production-ready branch. All commits must pass static analysis, unit tests, and integration test suites.
- `feature/<phase-name>`: Feature branches for specific master plan phases (e.g. `feature/phase-11-admin`).
- `fix/<defect-name>`: Scoped defect resolution branches.

---

## 2. Conventional Commit Standards

All commits must follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat(<scope>)`: A new user-visible or backend feature (e.g. `feat(admin): implement student management and audit logging`).
- `fix(<scope>)`: A bug fix (e.g. `fix(reader): resolve text overflow in dropdown button`).
- `test(<scope>)`: Adding or refactoring tests without code changes (e.g. `test(integration): add student journey flows`).
- `perf(<scope>)`: Performance improvements (e.g. `perf(app): optimize common list and image rendering`).
- `docs(<scope>)`: Documentation updates (e.g. `docs(security): document application threat model`).
- `chore(<scope>)`: Tooling, configuration, or dependency updates.

---

## 3. Pre-Commit / Pre-Push Quality Gates

Before pushing to `main`, every developer must verify:

```bash
# 1. Format code according to official Dart guidelines
dart format --set-exit-if-changed .

# 2. Run static analysis on backend and shared packages
dart analyze server packages/campusmate_shared packages/campusmate_client

# 3. Run static analysis on mobile client
flutter analyze apps/mobile

# 4. Run automated test suites
dart test server/test/integration/student_e2e_journey_test.dart
flutter test apps/mobile/test/integration/student_application_flow_test.dart
```
