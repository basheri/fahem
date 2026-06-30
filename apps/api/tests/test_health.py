"""Health-endpoint smoke tests for the Phase 1 scaffold."""

from __future__ import annotations

from fastapi.testclient import TestClient

from app.main import create_app

client = TestClient(create_app())


def test_healthz() -> None:
    response = client.get("/healthz")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_readyz() -> None:
    response = client.get("/readyz")
    assert response.status_code == 200
    assert response.json() == {"status": "ready"}


def test_v1_ping() -> None:
    response = client.get("/api/v1/ping")
    assert response.status_code == 200
    assert response.json() == {"message": "pong"}
