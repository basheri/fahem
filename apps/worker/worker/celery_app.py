"""Celery application.

Phase 1 scaffold: wires the broker/result backend to Redis and registers the task modules.
Separate queues with per-queue resource limits (CPU-heavy OCR vs. network AI tasks) are
configured in later phases per `docs/03_ARCHITECTURE.md`.
"""

from __future__ import annotations

import os

from celery import Celery

REDIS_URL = os.environ.get("REDIS_URL", "redis://localhost:6379/0")

celery_app = Celery(
    "fahem",
    broker=REDIS_URL,
    backend=REDIS_URL,
    include=["worker.tasks.ping"],
)

celery_app.conf.update(
    task_acks_late=True,
    worker_prefetch_multiplier=1,
    task_track_started=True,
    result_expires=3600,
)
