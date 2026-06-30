# API Design

Base path: `/api/v1`

## Conventions

- JSON uses camelCase externally and typed models internally.
- Errors use a stable code, Arabic user-safe message, request ID, and optional field errors.
- Never return provider errors, storage keys, stack traces, or internal IDs.
- State-changing endpoints require session ownership and appropriate CSRF controls.
- Use idempotency keys for upload completion, generation requests, and deletion.

## Initial endpoints

### Session

- `POST /sessions` — create or refresh anonymous session cookie.
- `GET /sessions/current` — return remaining TTL and session status.
- `DELETE /sessions/current` — immediately begin idempotent deletion.

### Documents

- `POST /documents/upload` — multipart upload for MVP or create signed upload flow.
- `POST /documents/{documentId}/process` — start processing with selected level.
- `GET /documents/{documentId}` — metadata and status.
- `GET /documents/{documentId}/progress` — stage and counters; SSE may be added.
- `GET /documents/{documentId}/file` — authorized PDF stream/range access.
- `GET /documents/{documentId}/learning-map` — units, lessons, concepts, pages.

### Learning content

- `GET /documents/{documentId}/explanations/{itemId}`
- `POST /documents/{documentId}/summaries`
- `GET /jobs/{jobId}`

### Chat

- `POST /documents/{documentId}/chat/messages`
- `GET /documents/{documentId}/chat/messages`

### Quiz

- `POST /documents/{documentId}/quizzes`
- `GET /quizzes/{quizId}`
- `POST /quizzes/{quizId}/attempts`

### Flashcards

- `POST /documents/{documentId}/flashcard-sets`
- `GET /flashcard-sets/{setId}`

## Answer response invariant

Chat/explanation responses include:

- `status`: answered, partiallyAnswered, notFound.
- Arabic `answer`.
- `supportedClaims` or concise structured sections.
- `citations` created by the server.
- `limitations` when partial or degraded.
- No chain-of-thought or provider metadata.

See `contracts/openapi.yaml` and `schemas/answer.schema.json`.
