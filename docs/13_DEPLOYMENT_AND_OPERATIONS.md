# Deployment and Operations Runbook Requirements

The implementation must replace this outline with platform-specific, tested commands.

## Environments

- Local: Docker Compose.
- CI: ephemeral PostgreSQL/pgvector, Redis, and object storage or reliable test doubles.
- Staging: production-like privacy and cleanup configuration using synthetic PDFs only.
- Production: TLS, managed secrets, least-privilege service identities, restricted egress, encrypted storage, and backups with documented retention.

## Deployment checklist

- Locked dependencies and reproducible build.
- Migrations reviewed and backward-compatible where possible.
- Environment validation passes.
- OpenRouter models/endpoints support required parameters and privacy policy.
- Bucket lifecycle and cleanup schedules are active.
- Rate limits and cost caps configured.
- Health/readiness checks pass.
- Security, contract, RAG, E2E, and deletion suites pass.
- Rollback version and migration strategy documented.

## Operational alerts

Content-free alerts for:

- Processing failure rate.
- Queue age and worker saturation.
- OCR timeout/error rate.
- OpenRouter error/latency/cost anomalies.
- Citation verification failures.
- Cleanup backlog or deletion lag.
- Database/storage/Redis availability.
- Rate-limit abuse.

## Rollback

- Keep previous deployable image.
- Separate schema expansion from destructive migration.
- Do not roll back in a way that resurrects deleted content.
- Verify cleanup workers remain compatible during mixed-version deployment.

## Incident priorities

1. Stop unauthorized access or secret exposure.
2. Preserve minimum content-free forensic evidence.
3. Revoke/rotate affected credentials.
4. Disable affected paths or models.
5. Complete deletion obligations.
6. Document root cause and prevention.
