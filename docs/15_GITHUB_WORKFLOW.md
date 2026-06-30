# GitHub Workflow

## Branching

- Protect `main`.
- Use short-lived feature branches.
- Require pull requests, CI, and at least one review for material changes.
- Prohibit force pushes and direct secret commits.

## Issue structure

Each implementation issue should include:

- User outcome.
- Acceptance criterion IDs.
- In-scope and out-of-scope items.
- Security/privacy/deletion implications.
- Test evidence required.
- Dependencies and blockers.

## Pull request quality

A pull request must include:

- Why the change is needed.
- What changed.
- Architecture/ADR impact.
- Data migration and deletion impact.
- API/schema impact.
- Security/privacy impact.
- Arabic UX/accessibility impact.
- Test commands and actual results.
- Screenshots for user-visible changes.
- Rollback approach.

## CI target after Phase 1

- Formatting.
- TypeScript lint/typecheck/unit tests/build.
- Python lint/typecheck/unit/integration tests.
- OpenAPI/JSON Schema contract checks.
- Playwright E2E.
- Secret scanning.
- Dependency review and vulnerability scanning.
- Container build and scan.
- Synthetic RAG evaluation gate at release milestones.

Do not allow Claude Code or any automation to push directly to protected `main`.
