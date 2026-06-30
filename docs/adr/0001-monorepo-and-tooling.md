# ADR 0001: Monorepo layout and toolchain

- Status: Accepted
- Date: 2026-06-30
- Owners: Project team
- Related acceptance criteria: AC-00 (clean clone runs), Phase 1 of `docs/11_IMPLEMENTATION_PLAN.md`

## Context

The architecture (`docs/03_ARCHITECTURE.md`) defines three deployables — `apps/web`
(Next.js), `apps/api` (FastAPI), `apps/worker` (Celery) — sharing PostgreSQL+pgvector,
Redis, and S3-compatible storage, with a server-side OpenRouter adapter. Phase 1 requires a
single clone to install, lint, type-check, test, and start locally. We need one repository
holding both a Node and a Python toolchain, with pinned versions (architecture rule:
"Pin dependency versions") and stable root commands (CLAUDE.md "Default local commands").

## Decision

Single Git monorepo with per-app dependency manifests and a root `Makefile` as the task entry
point. No cross-language meta-build tool (Nx/Bazel); each app uses its native toolchain.

- **Node:** Node 22 LTS, **pnpm 10** workspaces (`pnpm-workspace.yaml` lists `apps/web`).
- **Python:** Python 3.12 managed by **uv**, one `pyproject.toml` + `uv.lock` per Python app
  (`apps/api`, `apps/worker`) — independent virtualenvs so the worker's heavy native/ML deps
  do not bloat the API image.
- **Pinned major/minor versions** (patch floats within minor):
  - web: Next.js 15, React 19, TypeScript 5.7, ESLint 9, Prettier 3, pdfjs-dist 4
  - api: FastAPI 0.115, uvicorn 0.34, Pydantic 2.10, pydantic-settings 2.7, SQLAlchemy 2.0,
    psycopg 3.2, Alembic 1.14, pgvector 0.3
  - worker: Celery 5.4, redis 5, PyMuPDF 1.25, ocrmypdf 16, pytesseract 0.3,
    sentence-transformers 3, boto3 1.35, SQLAlchemy 2.0, psycopg 3.2, pgvector 0.3
  - shared dev: ruff 0.8, mypy 1.14, pytest 8
- **Local stack:** Docker Compose (`infra/docker-compose.yml`) with `pgvector/pgvector:pg16`,
  `redis:7`, and `minio/minio`. System OCR packages (tesseract, ocrmypdf) and the local
  embedding model live inside the worker image, not on developer hosts.

## Alternatives considered

- **Poetry / pip-tools for Python** — both viable; uv chosen for speed and a single
  lockfile+venv tool. pip+requirements lacks a resolver lockfile.
- **Nx / Turborepo / Bazel** — rejected as premature; native toolchains are simpler and match
  the "boring, stable technology" rule for a three-app repo.
- **npm/yarn** — pnpm chosen for workspace ergonomics and a content-addressed store.

## Consequences

### Positive

- One clone, one `make setup`; each app keeps an isolated, reproducible, pinned environment.
- Lockfiles (`pnpm-lock.yaml`, `uv.lock`) make builds reproducible for CI and deployment.

### Negative / tradeoffs

- Two package managers to learn (pnpm + uv).
- Shared Python code (e.g. session/citation domain) is currently duplicated between api and
  worker; a shared `libs/` package may be extracted in a later ADR if duplication grows.

## Security, privacy, and deletion impact

- No secrets in the repo; runtime config comes from `.env` (git-ignored) modeled by
  `.env.example`. OpenRouter access stays server-side (api/worker only), never in `apps/web`.
- Pinned versions + lockfiles reduce supply-chain drift and enable dependency scanning.

## Validation plan

- `make setup` from a clean clone installs all three apps.
- `make lint`, `make typecheck`, `make test` pass on the scaffold.
- `docker compose -f infra/docker-compose.yml config` validates; `make dev` starts the stack.

## Rollback or replacement path

- Toolchain is isolated per app; swapping uv→Poetry or pnpm→npm is a manifest-level change.
- Extracting a shared Python lib or adopting a JS monorepo tool would be a follow-up ADR.
