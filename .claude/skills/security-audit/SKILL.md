---
description: Perform a focused Fahem AI security and privacy audit before merge or release.
disable-model-invocation: true
---

Use the `security-reviewer` subagent and independently inspect the diff.

Audit:

- Secrets and client bundles.
- Upload validation and parser isolation.
- Session ownership, cookie, CSRF, CORS, and IDOR.
- Prompt injection and document-as-data boundaries.
- OpenRouter privacy routing and fail-closed behavior.
- Logging and observability content exposure.
- Rate limits, timeouts, retries, and abuse controls.
- Object storage access.
- TTL, manual deletion, cascading deletion, and cleanup races.
- Dependency and container risks.

Run relevant security tests. Produce blockers, high/medium/low findings, evidence, and required fixes. Do not call a risk accepted unless an ADR or owner decision records it.
