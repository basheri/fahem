---
paths:
  - "apps/api/**/*.py"
  - "apps/worker/**/*.py"
---

# Backend Rules

- Use Pydantic models at every external boundary.
- Keep endpoint functions thin; place business logic in services.
- Every endpoint that touches session data must enforce anonymous session ownership.
- Use transactions for state transitions and idempotent job creation.
- Do not keep uploaded PDFs only on local API disk in production.
- Enforce timeouts and bounded retries for OCR, AI, storage, and queue operations.
- Validate AI structured output before using it.
- Verify quotations and citations against canonical extracted source records.
- Do not return stack traces, provider payloads, or secret-bearing headers to clients.
- Maintain deletion services as first-class domain logic and update them with every new data entity.
- Use explicit status enums for documents and jobs.
