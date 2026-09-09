# CampusMate Testing Strategy & Verification Guide

This document outlines the testing pyramid, automated test suites, and honest verification standards (§91/§92) across the CampusMate monorepo.

---

## 1. Testing Pyramid

```
                ▲
               / \
              /   \
             / E2E \       <-- Mobile App Shell Flows & Server End-to-End Journey
            /-------\
           / Integr. \     <-- Serverpod Endpoint Tests (Real DB), RBAC, RAG
          /-----------\
         /    Widget   \   <-- Screen Rendering, Golden Tests, User Gestures
        /---------------\
       /      Unit       \ <-- GPA Calculator, Access Policy, LWW, Services
      /-------------------\
```

---

## 2. Test Suites Overview

### 2.1 Server-Side Tests (`server/test/`)
- **Unit Tests (`server/test/academic/`, `server/test/lending/`, etc.)**:
  - Validates `GpaCalculator`, policy evaluation, and domain algorithms in isolation.
- **Integration Tests (`server/test/integration/`)**:
  - Run using `withServerpod` against a real PostgreSQL 16 test database (`server-postgres_test-1`).
  - Automated per-test transaction rollbacks guarantee zero state pollution.
  - Key suites:
    - `rbac_matrix_test.dart`: Complete 4-role scope verification.
    - `academic_endpoint_test.dart`: Timetable projections, semester boundary checks.
    - `lending_endpoint_test.dart`: Deterministic concurrency borrow race test.
    - `rag_test.dart`: Vector similarity search + negative security test for restricted docs.
    - `admin_audit_test.dart`: Mutation audit log verification.
    - `student_e2e_journey_test.dart`: End-to-end multi-step student lifecycle test.

### 2.2 Mobile Client Tests (`apps/mobile/test/`)
- **Unit & Controller Tests (`apps/mobile/test/features/`)**:
  - Riverpod StateNotifier / AsyncNotifier unit tests using fake repositories.
- **Widget Tests**:
  - Verifies screen rendering, empty states, error states, and user interaction.
- **Integration Journey Tests (`apps/mobile/test/integration/`)**:
  - `student_application_flow_test.dart`:
    - **Flow 1**: Login → Dashboard → Library → Book Detail → Reader → Sync Progress.
    - **Flow 2**: Login → AI Assistant → Send Prompt → AI Settings & Memory.
    - **Flow 3**: Morning Flow (§76) - Dashboard → Notifications → Academic Timetable.

---

## 3. Running Automated Tests Locally

```bash
# 1. Start Test Database (Docker)
cd server
docker compose up -d postgres_test

# 2. Run Server Test Suite
dart test test/integration/student_e2e_journey_test.dart
dart test test/integration/academic_endpoint_test.dart
dart test test/integration/lending_endpoint_test.dart
dart test test/integration/rag_test.dart

# 3. Run Mobile Test Suite
cd ../apps/mobile
flutter test test/integration/student_application_flow_test.dart
flutter test
```
