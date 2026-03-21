from datetime import timedelta

from app.api.uploads import UPLOAD_DIR
from app.services.uploads_gc import cleanup_orphan_uploads


def _clear_upload_dir() -> None:
    UPLOAD_DIR.mkdir(parents=True, exist_ok=True)
    for path in UPLOAD_DIR.iterdir():
        if path.is_file():
            path.unlink()


async def test_upload_file_and_fetch_it(client):
    _clear_upload_dir()
    content = b"\x89PNG\r\n\x1a\nfakepng"
    upload_resp = await client.post(
        "/api/upload",
        files={"file": ("cover.png", content, "image/png")},
    )
    assert upload_resp.status_code == 200
    body = upload_resp.json()
    assert body["url"].startswith("/api/uploads/")
    assert body["filename"].endswith(".png")

    get_resp = await client.get(body["url"])
    assert get_resp.status_code == 200
    assert get_resp.content == content

    _clear_upload_dir()


async def test_uploads_gc_deletes_old_files():
    _clear_upload_dir()
    old_file = UPLOAD_DIR / "old.jpg"
    old_file.write_bytes(b"old")

    deleted = await cleanup_orphan_uploads(grace_period=timedelta(seconds=0))
    assert deleted >= 1
    assert not old_file.exists()

    _clear_upload_dir()


async def test_upload_rejects_unsupported_extension(client):
    _clear_upload_dir()
    resp = await client.post(
        "/api/upload",
        files={"file": ("notes.txt", b"hello", "text/plain")},
    )
    assert resp.status_code == 400
    _clear_upload_dir()


async def test_get_missing_upload_returns_404(client):
    resp = await client.get("/api/uploads/not-found.png")
    assert resp.status_code == 404
