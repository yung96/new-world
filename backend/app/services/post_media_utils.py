"""Проверка URL загруженных файлов перед привязкой к посту."""

from __future__ import annotations

from pathlib import Path

from fastapi import HTTPException, status

from app.api.uploads import UPLOAD_DIR, extract_uploaded_filename

MAX_POST_PHOTOS = 20


def normalize_existing_upload_url(raw: str) -> str | None:
    """
    Принимает строку вида /api/uploads/name.ext или полный URL с таким path.
    Возвращает канонический /api/uploads/... если файл есть на диске, иначе None.
    """
    s = (raw or "").strip()
    if not s:
        return None
    fn = extract_uploaded_filename(s)
    if not fn:
        return None
    base = UPLOAD_DIR.resolve()
    file_path = (UPLOAD_DIR / fn).resolve()
    if not str(file_path).startswith(str(base)):
        return None
    if not file_path.is_file():
        return None
    return f"/api/uploads/{fn}"


def validate_and_normalize_post_photos(urls: list[str] | None) -> list[str]:
    """
    Уникальные URL до MAX_POST_PHOTOS, только существующие файлы из uploads/.
    Пустые строки пропускаются. Невалидные непустые — 400.
    """
    if not urls:
        return []
    out: list[str] = []
    seen: set[str] = set()
    for u in urls:
        n = normalize_existing_upload_url(u)
        if n:
            if n not in seen:
                seen.add(n)
                out.append(n)
                if len(out) >= MAX_POST_PHOTOS:
                    break
            continue
        if (u or "").strip():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Файл загрузки не найден или неверный URL: {u!r}",
            )
    return out
