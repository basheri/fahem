"""Version 1 API router.

Endpoints are added per implementation phase (sessions, upload, status, chat, summaries,
quizzes, flashcards, deletion). The OpenAPI source of truth lives in ``contracts/openapi.yaml``.
"""

from __future__ import annotations

from fastapi import APIRouter

router = APIRouter()


@router.get("/ping", tags=["meta"])
def ping() -> dict[str, str]:
    return {"message": "pong"}
