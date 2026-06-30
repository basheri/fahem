# Security and Privacy Design

## Threat model summary

### Assets

- Uploaded PDFs and derived page images.
- Extracted text, embeddings, questions, answers, quizzes, flashcards, and summaries.
- Anonymous session tokens.
- OpenRouter and infrastructure credentials.
- Deletion guarantees and citation integrity.

### Trust boundaries

- Browser to web/API.
- API to database, Redis, and object storage.
- API/worker to OpenRouter.
- Worker to untrusted PDF parsers and OCR processes.
- CI/CD to deployment environment.

### Principal threats

- IDOR or session-token theft exposing another student's document.
- Malicious PDF exploiting parser/OCR/image libraries.
- Prompt injection embedded in document content.
- API key leakage into browser, logs, errors, or Git history.
- Cross-site scripting from extracted PDF text.
- Path traversal or unsafe object keys.
- CSRF on deletion/generation endpoints.
- Abuse through oversized files, repeated expensive jobs, or long prompts.
- Privacy downgrade when a preferred OpenRouter endpoint is unavailable.
- Incomplete deletion across database, Redis, object storage, queue results, logs, or backups.
- Fabricated or mismatched citations.

## Required controls

### Sessions and browser security

- Opaque high-entropy token in Secure, HttpOnly, SameSite cookie.
- Store only a token hash server-side.
- Rotate token when session is created or privilege/state changes justify it.
- Strict CORS allowlist.
- CSRF token or same-origin double-submit pattern for cookie-authenticated state changes.
- CSP, frame-ancestors restriction, nosniff, referrer policy, and permissions policy.
- Escape/sanitize all extracted text. Never render model HTML without a strict sanitizer.

### Upload and processing

- Streamed size enforcement and content signature validation.
- Parser timeouts, process/container isolation, CPU/memory quotas, non-root runtime, read-only root filesystem, and bounded temporary disk.
- Reject encrypted PDFs in MVP.
- Production option for malware scanning.
- Keep processing workers away from unrelated internal networks.

### Authorization

- Every document, page, chunk, job, message, quiz, flashcard, summary, and object operation must include the current session ownership predicate.
- Return not found rather than revealing resource existence across sessions.
- Use short-lived signed URLs only when unavoidable; proxying through authorization is preferred for the MVP PDF viewer.

### AI and prompt injection

- Evidence delimiters and explicit instruction hierarchy.
- No tools, browsing, or arbitrary URL retrieval in answer-generation calls.
- No secrets or unrelated user data in context.
- Model references opaque evidence IDs only.
- Server verifies schema, evidence IDs, claims, quotations, and page relationships.
- Adversarial evaluation fixtures.

### OpenRouter privacy

- Keep the API key server-side.
- Set provider data collection to deny.
- Require Zero Data Retention when configured.
- Apply the same privacy requirement to primary and fallback models/providers.
- Fail closed with a user-safe temporary-unavailability message if no compliant route exists.
- Disable prompt logging in OpenRouter account settings and do not enable application prompt logging.
- Verify deployment model endpoints satisfy the chosen policy before release.

### Logging and observability

Allowed fields: request ID, route name, status, duration, stage, page count, byte count, model ID, token counts, cost estimate, retry count, and non-sensitive error code.

Forbidden fields: file text, filename when sensitive, questions, answers, prompts, model response bodies, quotes, signed URLs, cookies, authorization headers, API keys, object keys, and database connection strings.

### Deletion

- Manual deletion endpoint is idempotent.
- Session state changes to deleting before cleanup begins.
- New work is rejected after deletion starts.
- Cleanup locks prevent races.
- Object storage, database, Redis, queue results, temporary files, and caches are included.
- Lifecycle policies and periodic reconciliation provide defense in depth.
- Metrics track cleanup lag and failures without retaining content.
- Backups must have documented encryption and retention. MVP claims must clearly exclude immediate deletion from immutable backups unless architecture actually guarantees it.

## Security verification gates

- Secret scanning and dependency scanning in CI.
- Static analysis for Python and TypeScript.
- Container image scanning before deployment.
- Tests for IDOR, CSRF, XSS, malicious upload, prompt injection, rate limits, privacy fail-closed behavior, and deletion.
- No high or critical unresolved finding at release.
