from __future__ import annotations

import asyncio
from datetime import datetime, timedelta, timezone

from app.api.uploads import ALLOWED_EXTENSIONS, UPLOAD_DIR, delete_uploaded_file


def _utcnow() -> datetime:
    return datetime.now(timezone.utc)


async def cleanup_orphan_uploads(*, grace_period: timedelta) -> int:
    if not UPLOAD_DIR.exists():
        return 0

    now = _utcnow()
    deleted = 0
    for file_path in UPLOAD_DIR.iterdir():
        if not file_path.is_file():
            continue
        if file_path.suffix.lower() not in ALLOWED_EXTENSIONS:
            continue
        try:
            mtime = datetime.fromtimestamp(file_path.stat().st_mtime, tz=timezone.utc)
        except Exception as e:
            continue
        if now - mtime < grace_period:
            continue
        delete_uploaded_file(f"/api/uploads/{file_path.name}")
        deleted += 1
    return deleted


async def uploads_gc_loop(
    *,
    interval_seconds: int = 600,
    grace_period_seconds: int = 3600,
) -> None:
    grace = timedelta(seconds=grace_period_seconds)
    while True:
        try:
            await cleanup_orphan_uploads(grace_period=grace)
        except asyncio.CancelledError:
            raise
        except Exception as e:
            pass
        await asyncio.sleep(interval_seconds)
