---
description: Verify a Fahem AI milestone or release against acceptance criteria and produce an evidence-based readiness report.
disable-model-invocation: true
---

Review the full diff, specifications, ADRs, and traceability matrix. Use QA, security, PDF/RAG, and Arabic UX subagents where relevant.

Run the complete available verification suite: formatting, linting, type checks, unit tests, integration tests, contract tests, E2E tests, security checks, build, and a real local user flow.

Check that:

- Required features work, not merely exist.
- Grounding and citations are verified.
- Privacy routing is enforced.
- Session deletion is proven.
- Mobile Arabic UX is usable.
- Failure, expired, and deleted states work.
- Documentation and `.env.example` match reality.
- No secrets or real user documents exist in the repository.

Write `docs/reports/release-readiness.md` with pass/fail evidence per acceptance criterion, unresolved blockers, and a release recommendation.
