# Implementation Plan

Each phase ends with a runnable repository, verification evidence, updated traceability, and committed documentation.

## Phase 0 — Repository discovery and decisions

- Read all specifications and Claude Code controls.
- Confirm current stable dependency versions.
- Create ADRs for monorepo/tooling, sessions, storage, queue, embeddings, OpenRouter adapter, and deployment baseline.
- Refine OpenAPI and schemas.
- Create issue/task breakdown mapped to acceptance criteria.

**Exit:** no unresolved contradiction blocks scaffolding; ADRs and task map exist.

## Phase 1 — Monorepo and local platform

- Scaffold web, API, worker, contracts, and infrastructure.
- Add root Makefile/task runner.
- Add Docker Compose for web, API, worker, PostgreSQL/pgvector, Redis, and MinIO.
- Add migrations, health checks, configuration validation, logging policy, and baseline CI.
- Run `/run-skill-generator` after the clean startup works.

**Exit:** clean clone can start; health checks and baseline tests pass.

## Phase 2 — Anonymous sessions and deletion foundation

- Session cookie/token hashing, idle/absolute TTL, activity refresh, ownership middleware.
- Session status and delete endpoints.
- Cleanup service, worker, locks, and tests.
- Security headers, CORS, CSRF, and rate-limit foundation.

**Exit:** session isolation and end-to-end deletion tests pass before document content is added.

## Phase 3 — Upload and document processing

- PDF upload/validation/object storage.
- Document/job state machine and real progress API.
- PyMuPDF extraction and OCR gating.
- Page records, canonical text, images, and degraded states.
- Resource isolation and malformed-file tests.

**Exit:** fixture PDFs reach ready/degraded/failed correctly with source page fidelity.

## Phase 4 — Structure, chunks, and retrieval

- Heading/section inference.
- Units, lessons, concepts, and learning-map API/UI.
- Citation-preserving chunks.
- Local multilingual embeddings, pgvector, lexical index, hybrid fusion, and retrieval tests.

**Exit:** learning map and labeled retrieval metrics meet thresholds.

## Phase 5 — OpenRouter adapter and grounded chat

- Task profiles, primary/fallback models, ZDR/data collection, timeouts, budgets, retries, circuit breaker, and structured outputs.
- Grounded chat prompt and answerability.
- Server-created citations, quote/page verification, repair path, and not-found response.
- PDF viewer citation navigation.

**Exit:** grounded chat evaluation passes with no fabricated citation in fixtures.

## Phase 6 — Explanations and summaries

- Level-adapted explanation service and UI.
- Whole-document and scoped summaries.
- Caching within session and job status.
- Source references and degraded warnings.

**Exit:** all scopes and levels work and remain grounded.

## Phase 7 — Quizzes and flashcards

- Structured quiz generation, validation, scoring, explanation, and citation.
- Structured flashcard generation and interactive review.
- Scope selectors for unit/page range.

**Exit:** generation, scoring, review, and citation E2E tests pass.

## Phase 8 — Arabic UX, accessibility, and mobile hardening

- Refine information architecture and mixed-direction handling.
- Keyboard, focus, status announcements, reduced motion, and responsive layouts.
- Session-expiry/deletion UX and failure states.
- Manual accessibility review.

**Exit:** desktop/mobile journeys and accessibility checks pass.

## Phase 9 — Security, operations, and release

- Full threat-model review and penetration-focused tests.
- Secret/dependency/container scanning.
- Production deployment and rollback runbook.
- Cost metrics, cleanup alerts, backups/retention truth, and privacy verification.
- Arabic user guide and release-readiness report.

**Exit:** all acceptance criteria have evidence and no release blocker remains.
