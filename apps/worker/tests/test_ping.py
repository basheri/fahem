"""Verify the ping task is registered and runs in-process."""

from __future__ import annotations

from worker.celery_app import celery_app
from worker.tasks.ping import ping


def test_ping_returns_pong() -> None:
    assert ping() == "pong"


def test_ping_registered() -> None:
    assert "ping" in celery_app.tasks
