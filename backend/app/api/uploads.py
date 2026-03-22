from pathlib import Path
import uuid

from fastapi import APIRouter, File, HTTPException, UploadFile
from fastapi.responses import FileResponse
from loguru import logger

from app.api.base_schema import BasePydanticModel
from app.core.config import settings
from app.core.upload_paths import UPLOAD_DIR, extract_uploaded_filename

router = APIRouter()

ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp"}


class UploadResponse(BasePydanticModel):
    url: str
    filename: str


def _safe_file_path(filename: str) -> Path | None:
    file_path = (UPLOAD_DIR / filename).resolve()
    base = UPLOAD_DIR.resolve()
    if not str(file_path).startswith(str(base)):
        return None
    return file_path


def delete_uploaded_file(file_url: str | None) -> None:
    if not file_url:
        return
    filename = extract_uploaded_filename(file_url)
    if not filename:
        return
    file_path = _safe_file_path(filename)
    if file_path is None:
        return
    try:
        if file_path.exists() and file_path.is_file():
            file_path.unlink()
    except Exception as e:
        logger.warning(e)
        pass


@router.post(
    "/upload",
    response_model=UploadResponse,
    summary="Загрузить изображение",
    description=(
        "Загружает файл изображения на сервер.\n\n"
        "Поддерживаемые расширения: `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`."
    ),
    response_description="URL и имя сохраненного файла.",
)
async def upload_image_file(file: UploadFile = File(...)):
    ext = Path(file.filename or "").suffix.lower()
    if ext not in ALLOWED_EXTENSIONS:
        raise HTTPException(
            status_code=400,
            detail=f"Unsupported file type. Allowed: {', '.join(sorted(ALLOWED_EXTENSIONS))}",
        )

    contents = await file.read()
    max_bytes = max(1, int(settings.upload_max_file_size_mb)) * 1024 * 1024
    if len(contents) > max_bytes:
        raise HTTPException(
            status_code=400,
            detail=f"File is too large. Max size: {settings.upload_max_file_size_mb} MB",
        )

    unique_name = f"{uuid.uuid4()}{ext}"
    file_path = _safe_file_path(unique_name)
    if file_path is None:
        raise HTTPException(status_code=500, detail="Failed to resolve file path")

    try:
        with file_path.open("wb") as f:
            f.write(contents)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to save file: {e}") from e

    return UploadResponse(url=f"/api/uploads/{unique_name}", filename=unique_name)


@router.get(
    "/uploads/{filename}",
    summary="Получить загруженный файл",
    description="Возвращает ранее загруженный файл по его имени.",
    response_description="Бинарное содержимое файла.",
)
async def get_uploaded_file(filename: str):
    file_path = _safe_file_path(filename)
    if file_path is None or not file_path.exists() or not file_path.is_file():
        raise HTTPException(status_code=404, detail="File not found")
    return FileResponse(path=file_path)
