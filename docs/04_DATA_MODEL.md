# Temporary Data Model

All tables use UUID/ULID public identifiers, UTC timestamps, and indexed `expires_at`. Sensitive document content is never placed in analytics tables.

## Core entities

### `anonymous_sessions`

- `id`
- `token_hash`
- `created_at`
- `last_activity_at`
- `idle_expires_at`
- `absolute_expires_at`
- `status`: active, deleting, deleted, expired
- `deleted_at`

### `documents`

- `id`, `session_id`
- original filename (sanitized display value only)
- object key
- SHA-256 hash
- byte size, page count, detected languages
- explanation level
- status: uploaded, validating, extracting, ocr, analyzing, indexing, ready, degraded, failed, deleting, deleted
- failure code (non-sensitive)
- `expires_at`, timestamps

### `document_pages`

- `id`, `document_id`, `session_id`
- canonical page number (1-based)
- raw extracted text
- canonical source text
- normalized retrieval text
- text quality score
- OCR status and confidence
- page image object key when generated
- width, height, rotation
- visual-content flags
- `expires_at`

### `document_sections`

- `id`, `document_id`, `session_id`
- parent section ID
- type: unit, lesson, heading, concept
- Arabic title
- source title when available
- start/end page
- order index
- confidence
- `expires_at`

### `document_chunks`

- `id`, `document_id`, `page_id`, `section_id`, `session_id`
- canonical exact source text
- normalized retrieval text
- start/end character offsets
- optional bounding boxes
- token count
- embedding vector
- lexical search vector
- `expires_at`

### `learning_items`

- `id`, `document_id`, `section_id`, `session_id`
- type: explanation, summary, concept
- level, scope, status
- structured content JSON
- source citation IDs
- model/task metadata without prompts or content logs
- `expires_at`

### `chat_threads` and `chat_messages`

- session/document ownership
- role and content
- answerability status
- generated answer JSON
- model/task metadata
- `expires_at`

### `citations`

- `id`, `document_id`, `page_id`, `chunk_id`, `session_id`
- page number
- verified quote
- start/end offsets
- optional bounding boxes
- verification method and timestamp
- `expires_at`

### `quizzes`, `quiz_questions`, `quiz_attempts`

- session/document ownership
- scope and level
- question, choices, correct choice, explanation
- citation IDs
- transient attempt answers and score
- `expires_at`

### `flashcard_sets`, `flashcards`

- session/document ownership
- scope and card type
- front, back, citation IDs
- optional transient review state
- `expires_at`

### `jobs`

- `id`, `session_id`, `document_id`
- job type, stage, status
- attempt count, progress counters, non-sensitive error code
- idempotency key
- started/completed timestamps
- `expires_at`

## Ownership invariant

Every query for document-derived data must include the authenticated anonymous `session_id`. Foreign keys alone are not a substitute for ownership predicates.

## Deletion order

Deletion is idempotent and may use database cascade for relational rows, but object keys must be enumerated before rows disappear:

1. Mark session deleting and reject new operations.
2. Cancel/revoke queued work where possible and acquire cleanup lock.
3. List object keys for PDF, page images, and crops.
4. Delete objects and verify not found.
5. Delete database records in a transaction or cascade.
6. Delete Redis keys and rate-limit/idempotency state.
7. Mark deletion audit metadata without retaining content; then remove the session record after the minimum operational window if policy requires.

Do not use soft deletion as the sole deletion mechanism for document content.
