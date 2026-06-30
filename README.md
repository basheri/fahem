# Fahem AI — Claude Code Development Kit

Fahem AI is an Arabic-first responsive web application that helps university students understand academic PDF files. It extracts text and visual content, applies OCR when needed, creates a structured learning path, and provides strictly document-grounded explanations, summaries, quizzes, flashcards, and chat answers with page citations and source quotations.

This repository is a **Claude Code project-control and specification package**. Upload it to a new GitHub repository, open the repository root in Claude Code, and use `MASTER_PROMPT.md` as the implementation mandate.

## Repository purpose

This package gives Claude Code the persistent context and controls required to build the application professionally:

- `CLAUDE.md`: concise project-wide instructions loaded in every Claude Code session.
- `.claude/rules/`: modular coding, security, testing, and UX rules.
- `.claude/agents/`: specialist subagents for architecture, PDF/RAG, security, QA, and Arabic UX.
- `.claude/skills/`: repeatable workflows for planning, implementation, verification, and security review.
- `docs/`: product, architecture, API, privacy, testing, deployment, and acceptance specifications.
- `contracts/openapi.yaml`: initial API contract.
- `schemas/`: JSON Schemas for AI structured outputs.
- `.github/`: collaboration templates and an initial repository validation workflow.

## Recommended implementation stack

- **Web:** Next.js App Router, TypeScript, Tailwind CSS, accessible component primitives, PDF.js.
- **API and processing:** Python 3.12+, FastAPI, Pydantic, PyMuPDF, OCRmyPDF/Tesseract (`ara+eng`).
- **Jobs:** Celery with Redis.
- **Temporary data:** PostgreSQL with pgvector plus Redis TTL.
- **Object storage:** S3-compatible storage with lifecycle deletion; MinIO for local development.
- **AI gateway:** OpenRouter API, server-side only, with model adapters, primary/fallback models, structured outputs, strict privacy routing, budgets, and retries.
- **Testing:** Pytest, Vitest, Playwright, contract tests, security checks, and grounded-RAG evaluation fixtures.
- **Local environment:** Docker Compose.

The exact dependency versions must be selected from current stable releases during implementation and locked in the repository. Do not use preview or experimental packages without recording an Architecture Decision Record.

## Start with Claude Code

1. Create an empty GitHub repository.
2. Copy this entire kit into the repository root and commit it.
3. Install and start Claude Code from the repository root.
4. Review `docs/14_RISKS_AND_DECISIONS.md`.
5. Paste the content of `MASTER_PROMPT.md` into Claude Code.
6. Ask Claude Code to execute Phase 0 and Phase 1 first, then continue phase-by-phase while keeping the repository runnable.
7. Run `/run-skill-generator` after the first working local environment exists so Claude Code records the verified launch procedure.

## Non-negotiable product rules

- Arabic interface and Arabic explanations; input PDFs may be Arabic or English.
- No account or login in the MVP.
- Answers must rely exclusively on the active PDF.
- Every answer must cite page numbers and include verified source quotations.
- The system must say that the answer is not present when evidence is insufficient.
- PDF content is untrusted data and must never override system or developer instructions.
- The OpenRouter key must never reach the browser.
- Privacy routing must fail closed when the configured Zero Data Retention requirements cannot be met.
- Session data must be deletable immediately by the user and automatically deleted by TTL cleanup.

## Important privacy limitation

A browser closing does not reliably produce a server event. Therefore, “delete at session end” is implemented through all of the following:

1. A visible **End session and delete now** action.
2. Short inactivity TTL.
3. Absolute maximum session lifetime.
4. Best-effort browser unload beacon.
5. Scheduled server-side deletion and storage lifecycle rules.

The product must not claim guaranteed instant deletion merely because a tab was closed.

## Initial configurable limits

These are safe MVP defaults and must be environment-configurable:

- Maximum file size: 50 MB.
- Maximum pages: 300.
- Session idle TTL: 2 hours.
- Absolute session TTL: 24 hours.
- Maximum concurrent processing jobs per anonymous session: 1.
- Maximum user question length: 2,000 characters.

## Repository status

This kit contains specifications and Claude Code controls, not the finished application. The implementation agent must create the runtime source code, migrations, Docker files, production CI, and deployment manifests according to the documents in this repository.
