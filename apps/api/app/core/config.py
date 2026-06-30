"""Application configuration.

Settings are loaded from environment variables (see `.env.example` for the canonical
names). Secrets such as ``OPENROUTER_API_KEY`` are read here on the server only and must
never be forwarded to client code. Values fail closed: missing required settings raise at
startup rather than defaulting to insecure behavior.
"""

from __future__ import annotations

from functools import lru_cache

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Runtime configuration sourced from the environment."""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
        case_sensitive=False,
    )

    app_env: str = Field(default="development")
    app_base_url: str = Field(default="http://localhost:3000")
    api_base_url: str = Field(default="http://localhost:8000")

    # Session policy
    session_idle_ttl_seconds: int = Field(default=7200)
    session_absolute_ttl_seconds: int = Field(default=86400)
    session_cookie_secure: bool = Field(default=False)

    # Upload limits
    max_pdf_bytes: int = Field(default=52_428_800)
    max_pdf_pages: int = Field(default=300)
    max_question_chars: int = Field(default=2000)
    max_active_jobs_per_session: int = Field(default=1)

    # Infrastructure
    database_url: str = Field(default="postgresql+psycopg://fahem:fahem@localhost:5432/fahem")
    redis_url: str = Field(default="redis://localhost:6379/0")

    # Observability
    log_level: str = Field(default="INFO")
    log_content: bool = Field(default=False)


@lru_cache
def get_settings() -> Settings:
    """Return a cached Settings instance."""
    return Settings()
