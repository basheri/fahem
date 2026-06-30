# Testing Rules

- Critical behavior requires tests before or with implementation.
- Do not mock the business logic under test.
- Use unit tests for deterministic domain logic and integration tests for boundaries.
- Maintain fixtures for Arabic text, English text, scanned pages, tables, equations, empty pages, malformed PDFs, and embedded prompt injection.
- Use synthetic or licensed documents only.
- RAG evaluations must include answerable, partially answerable, unanswerable, conflicting, and citation-quote verification cases.
- E2E tests must cover desktop and mobile Arabic flows.
- Tests must prove session isolation and deletion, not merely successful HTTP status codes.
- A flaky test is a defect; do not hide it with broad retries.
- Update the traceability matrix with test evidence.
