"""Trivial task used to prove the queue is wired end to end."""

from __future__ import annotations

from worker.celery_app import celery_app


@celery_app.task(name="ping")
def ping() -> str:
    return "pong"
