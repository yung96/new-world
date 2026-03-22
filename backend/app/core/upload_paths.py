"""Пути и разбор URL загрузок без зависимости от app.api (избегаем циклических импортов)."""

from __future__ import annotations

import logging
from pathlib import Path
from urllib.parse import urlparse

logger = logging.getLogger(__name__)

# backend/uploads — тот же уровень, что и в app/api/uploads.py (parents[2] = backend)
UPLOAD_DIR = Path(__file__).resolve().parents[2] / "uploads"
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)


def extract_uploaded_filename(file_url: str) -> str | None:
    if not file_url:
        return None
    try:
        parsed = urlparse(file_url)
        path = parsed.path or file_url
    except Exception as e:
        logger.warning("urlparse failed for upload url: %s", e)
        path = file_url

    marker = "/api/uploads/"
    idx = path.find(marker)
    if idx == -1:
        return None
    filename = path[idx + len(marker) :].lstrip("/")
    return filename or None
