"""Префикс HTTP-путей из настроек (переменная окружения API_PATH_PREFIX)."""

from app.core.config import settings

API_ROOT = settings.api_mount_path.rstrip("/")


def api(path: str) -> str:
    p = path if path.startswith("/") else f"/{path}"
    return f"{API_ROOT}{p}"
