# Risks, Constraints, and Decisions

## Confirmed decisions

- Arabic-only UI for MVP; PDFs may be Arabic or English.
- No accounts or permanent progress.
- OpenRouter is the AI gateway; model IDs remain configurable.
- Answers use no web search or external knowledge.
- Local multilingual embeddings are preferred by default.
- PostgreSQL/pgvector, Redis, and S3-compatible storage support temporary data.
- Deletion uses manual action plus idle TTL, absolute TTL, scheduled cleanup, and storage lifecycle.

## Important constraints

### Browser-close deletion

Browsers do not reliably notify servers when a tab closes. Instant deletion on close cannot be guaranteed. Product copy must accurately describe manual immediate deletion and automatic TTL deletion.

### Scanned equations and diagrams

OCR and vision models can misread equations, labels, or dense diagrams. The MVP must show degraded/approximate indicators and source pages, not claim perfect interpretation.

### “No training” claim

This claim depends on OpenRouter account settings and the exact routed provider endpoint. The application must enforce ZDR/data-collection restrictions and verify deployment policy. Marketing or privacy text must not make a broader promise than the actual configured route guarantees.

### External processing

OpenRouter is an external processor. Even with ZDR, selected retrieved excerpts or page images leave the application environment. The privacy notice must state this accurately.

## Initial risk register

| Risk | Impact | Mitigation |
|---|---|---|
| Citation hallucination | High trust harm | Server-created citations, quote verification, evaluation gates |
| Cross-session access | Critical privacy breach | Opaque tokens, ownership predicates, IDOR tests |
| Malicious PDF | Critical compromise | Validation, isolation, timeouts, non-root workers, scanning option |
| Prompt injection in PDF | High | Document-as-data prompts, no tools, evidence IDs, adversarial tests |
| OCR quality on Arabic scans | Medium/High | Selective OCR, confidence, degraded state, source viewer |
| OpenRouter provider privacy mismatch | High | ZDR + data collection deny, allowlists, fail closed |
| Cost spikes | Medium/High | file/page limits, selective vision, token/cost caps, rate limits |
| Incomplete deletion | High | first-class deletion service, idempotency, reconciliation, lifecycle |
| Large PDF latency | Medium | async pipeline, limits, progress stages, bounded concurrency |
| Accessibility regressions | Medium | component standards, automated + manual checks |

## Open decisions to resolve in ADRs

- Exact hosting platform and region.
- Production object storage and lifecycle implementation.
- Whether PDF file delivery is proxied or uses short-lived signed URLs.
- Exact local embedding runtime and resource requirements.
- OCR/vision queue resource sizing.
- OpenRouter model allowlist and task routing for launch.
- Backup retention and privacy wording.
