"""FastAPI application factory.

Phase 1 scaffold: exposes liveness/readiness probes and a versioned API router. Business
logic (sessions, upload, chat) is added in later phases behind the ``/api/v1`` prefix.
"""

from __future__ import annotations

from fastapi import FastAPI

from app.api.v1 import router as api_v1_router
from app.core.config import get_settings


def create_app() -> FastAPI:
    settings = get_settings()
    app = FastAPI(
        title="Fahem AI API",
        version="0.1.0",
        docs_url="/docs" if settings.app_env != "production" else None,
    )

    @app.get("/healthz", tags=["health"])
    def healthz() -> dict[str, str]:
        """Liveness probe — process is up."""
        return {"status": "ok"}

    @app.get("/readyz", tags=["health"])
    def readyz() -> dict[str, str]:
        """Readiness probe.

        Phase 1 returns ``ready`` unconditionally. Dependency checks (database, Redis,
        object storage) are wired in once those clients exist.
        """
        return {"status": "ready"}

    app.include_router(api_v1_router, prefix="/api/v1")
    return app


app = create_app()
