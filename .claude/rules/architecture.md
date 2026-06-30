# Architecture Rules

- Maintain clear boundaries between web UI, API, background processing, domain logic, infrastructure adapters, and AI adapters.
- Domain services must not import framework-specific request/response objects.
- All external systems must be behind interfaces: OpenRouter, embeddings, object storage, OCR, queue, and observability.
- Prefer boring, stable technology over novelty.
- Pin dependency versions and document upgrades.
- Keep the application runnable after every vertical slice.
- Use database migrations for every schema change.
- Store timestamps in UTC and present them in the UI only where needed.
- Use opaque UUID/ULID identifiers; never expose sequential database IDs.
- Every document-derived entity must include `session_id`, `expires_at`, and deletion status or be transitively owned by an entity that does.
- Record material changes in `docs/adr/NNNN-title.md`.
