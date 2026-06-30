# Fahem AI worker image.
# Carries the native OCR toolchain (tesseract + ghostscript) and installs the heavy
# pdf/embeddings extras. PDF processing runs as a non-root user with a constrained
# workspace (see docs/09_SECURITY_AND_PRIVACY.md).
# syntax=docker/dockerfile:1
FROM python:3.12-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/app/.venv

# Native dependencies for OCR and PDF rasterization.
RUN apt-get update && apt-get install -y --no-install-recommends \
        tesseract-ocr \
        tesseract-ocr-ara \
        tesseract-ocr-eng \
        ghostscript \
        qpdf \
        poppler-utils \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:0.8 /uv /usr/local/bin/uv

WORKDIR /app

# Install dependencies (core + pdf + embeddings extras) from the lockfile, then app code.
COPY apps/worker/pyproject.toml apps/worker/uv.lock ./
RUN uv sync --frozen --no-install-project --no-dev --extra pdf --extra embeddings

COPY apps/worker/ ./
RUN uv sync --frozen --no-dev --extra pdf --extra embeddings

RUN useradd --create-home --uid 10001 appuser && chown -R appuser:appuser /app
USER appuser

ENV PATH="/app/.venv/bin:${PATH}"

CMD ["celery", "-A", "worker.celery_app:celery_app", "worker", "--loglevel=INFO"]
