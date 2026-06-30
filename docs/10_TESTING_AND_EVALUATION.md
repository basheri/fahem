# Testing and Evaluation Strategy

## Test pyramid

### Unit tests

- Session token generation/hash/expiry.
- Ownership predicates.
- Filename and object-key safety.
- PDF validation.
- Text quality and OCR gating.
- Arabic/English normalization.
- Section/chunk boundaries.
- Retrieval fusion and deduplication.
- Answerability classification.
- AI schema validation.
- Evidence ID resolution.
- Quote and page verification.
- Cost/token budget enforcement.
- Deletion planning and idempotency.

### Integration tests

- Upload to ready using fixture PDFs.
- OCR service and parser integration.
- PostgreSQL/pgvector retrieval.
- Redis job/session TTL.
- Object storage upload/range read/delete.
- Celery job transitions and retries.
- OpenRouter adapter with a deterministic fake server.
- Primary/fallback behavior with identical privacy constraints.
- Database and object cleanup.

### Contract tests

- OpenAPI request/response validation.
- JSON Schema validation for all AI outputs.
- Generated TypeScript/Python types remain synchronized.

### End-to-end tests

- Arabic desktop upload and learning flow.
- Arabic mobile upload and navigation flow.
- Citation click opens correct page.
- Not-found answer.
- Quiz generation and scoring.
- Flashcard review.
- Manual deletion and blocked subsequent access.
- Session expiry.
- Processing failure/degraded state.

### Security tests

- Cross-session object access.
- Guessable or replayed IDs.
- CSRF attempts.
- Stored/reflected XSS from PDF text.
- Prompt injection fixture.
- PDF with wrong extension/signature.
- Corrupt, encrypted, oversized, and excessive-page files.
- Path traversal filename.
- Rate-limit abuse.
- Provider privacy downgrade.
- Secret detection in built client assets and logs.

## RAG evaluation set

Use small synthetic or licensed PDFs with labeled questions and evidence:

1. Arabic clean text.
2. English clean text with Arabic answers.
3. Arabic scanned pages.
4. Mixed Arabic/English.
5. Table-based answer.
6. Diagram-based answer.
7. Equation-heavy page.
8. Conflicting statements on different pages.
9. Unanswerable question.
10. Partially answerable question.
11. Embedded prompt injection.
12. Repeated headers/footers.

For every case record expected status, acceptable answer concepts, source pages, required quote spans, and forbidden claims.

## Quality thresholds for MVP release

- 100% session-isolation tests pass.
- 100% deletion tests pass.
- 100% displayed citations pass page and quote verification.
- 0 known high/critical security findings.
- At least 90% correct status classification on the labeled evaluation set.
- At least 85% retrieval recall@5 on answerable text fixtures; visual fixtures tracked separately.
- 0 unsupported-claim critical failures in release fixtures.
- Accessibility automated checks pass with manual keyboard and screen-reader smoke test.

Thresholds may be tightened after pilot data; lowering them requires a recorded decision.
