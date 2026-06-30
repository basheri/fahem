# Fahem AI — root task runner.
# Stable commands required by CLAUDE.md. Phase 1 scaffold: setup/format/lint/typecheck/test
# are wired to the real toolchains; dev/stop drive Docker Compose. Commands that depend on
# code not yet implemented (migrations, e2e, clean-session-data) are stubbed and fail loudly
# rather than reporting false success.

COMPOSE := docker compose -f infra/docker-compose.yml

.DEFAULT_GOAL := help
.PHONY: help setup dev stop format lint typecheck test test-e2e verify clean-session-data

help: ## List available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-22s %s\n", $$1, $$2}'

setup: ## Install all workspace dependencies (web + api + worker)
	corepack enable
	pnpm install
	cd apps/api && uv sync
	cd apps/worker && uv sync

dev: ## Start the local stack (web, api, worker, postgres, redis, minio)
	$(COMPOSE) up --build

stop: ## Stop the local stack
	$(COMPOSE) down

format: ## Auto-format all code
	pnpm --filter web run format
	cd apps/api && uv run ruff format .
	cd apps/worker && uv run ruff format .

lint: ## Lint all code
	pnpm --filter web run lint
	cd apps/api && uv run ruff check .
	cd apps/worker && uv run ruff check .

typecheck: ## Type-check all code
	pnpm --filter web run typecheck
	cd apps/api && uv run mypy app
	cd apps/worker && uv run mypy worker

test: ## Run unit/integration tests
	cd apps/api && uv run pytest -q
	cd apps/worker && uv run pytest -q

test-e2e: ## Run end-to-end tests (not implemented until Phase 8)
	@echo "test-e2e: no E2E suite yet (Phase 8). Failing closed." >&2; exit 1

verify: lint typecheck test ## Run lint + typecheck + tests

clean-session-data: ## Purge local session artifacts (not implemented until Phase 2)
	@echo "clean-session-data: cleanup service not implemented yet (Phase 2). Failing closed." >&2; exit 1
