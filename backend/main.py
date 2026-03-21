from fastapi import FastAPI, APIRouter, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.trustedhost import TrustedHostMiddleware
from fastapi.openapi.utils import get_openapi
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.core.lifespan import lifespan
from app.core.dependencies import get_db_session
from app.api import admin, auth, filters, ivan_alt_local_routes, posts, reviews, social, uploads, user, travel

OPENAPI_TAGS = [
    {
        "name": "Health Check",
        "description": "Служебные эндпоинты для проверки работоспособности API и БД.",
    },
    {
        "name": "Auth & Users",
        "description": (
            "Авторизация по телефону (`POST /api/auth`), профиль «я» (`GET /api/users/me`), "
            "прогресс достижений (`GET /api/users/me/achievements/progress`), "
            "публичный профиль (`GET /api/users/{user_id}` — подписчики, отзывы, полученные достижения)."
        ),
    },
    {
        "name": "Social",
        "description": (
            "Интересы, достижения, подписки. Управление подписками: "
            "`POST /api/subscriptions` (тело `{\"targetUserId\": number}`), "
            "`GET /api/subscriptions`, `DELETE /api/subscriptions/{target_user_id}`."
        ),
    },
    {
        "name": "Posts",
        "description": "Посты/места: публичный просмотр + административное редактирование и удаление.",
    },
    {
        "name": "Reviews",
        "description": "Отзывы к публикациям: оценка, комментарий и медиа-вложения.",
    },
    {
        "name": "Uploads",
        "description": "Загрузка и получение файлов (изображений) для контента.",
    },
    {
        "name": "User",
        "description": (
            "Действия текущего пользователя: создание мест (`POST /user/posts`), избранное, "
            "персонализированная лента мест (`GET /user/feed`), "
            "**лента активности подписок** (`GET /user/subscriptions/feed` — отзывы от авторов, "
            "на которых вы подписаны, по времени; без рекомендаций), свайпы."
        ),
    },
    {
        "name": "Travel",
        "description": "Маршруты и перелеты: города, глобальные маршруты и route info.",
    },
    {
        "name": "Travel",
        "description": "Роуты для работы с формированием маршрутов",
    },
    {
        "name": "Admin",
        "description": "Обезличенные admin endpoint-ы для MVP (дашборд и управление сущностями).",
    },
]

fastapi_app = FastAPI(
    title="Kraeved API",
    summary="REST API для социальной платформы о локальной культуре и путешествиях.",
    description=(
        "Подробная документация API проекта **Kraeved**.\n\n"
        "### Быстрый старт\n"
        "1. Получите токен через `POST /api/auth`.\n"
        "2. Нажмите `Authorize` и вставьте `Bearer <ваш_токен>`.\n"
        "3. Используйте защищенные эндпоинты для работы с user/social-функциями.\n"
        "4. Лента отзывов от подписок (фронт): `GET /api/user/subscriptions/feed?page=1&pageSize=20` "
        "(тот же токен).\n"
        "5. Для MVP admin-дашборд открыт по `/api/admin` (без привязки к пользователю).\n\n"
        "### Пагинация\n"
        "Во всех list-эндпоинтах используются параметры `page` и `pageSize`.\n\n"
        "### Ошибки\n"
        "Валидационные ошибки возвращаются в стандартном формате FastAPI (`422 Unprocessable Entity`)."
    ),
    version="1.0.0",
    contact={"name": "Kraeved Backend Team"},
    license_info={"name": "Proprietary"},
    terms_of_service="https://example.com/terms",
    openapi_tags=OPENAPI_TAGS,
    servers=[
        {"url": "/", "description": "Current host"},
    ],
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json",
    swagger_ui_parameters={
        "defaultModelsExpandDepth": 2,
        "defaultModelExpandDepth": 2,
        "displayRequestDuration": True,
        "docExpansion": "list",
        "filter": True,
        "showExtensions": True,
        "showCommonExtensions": True,
        "tryItOutEnabled": True,
        "persistAuthorization": True,
        "deepLinking": True,
    },
    lifespan=lifespan,
)

app = fastapi_app

# Фиксируем схему запроса, когда приложение за прокси.
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse


class HttpsProxyFixMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        proto = request.headers.get("x-forwarded-proto")
        if proto:
            request.scope["scheme"] = proto
        return await call_next(request)


fastapi_app.add_middleware(HttpsProxyFixMiddleware)


def custom_openapi():
    if fastapi_app.openapi_schema:
        return fastapi_app.openapi_schema

    openapi_schema = get_openapi(
        title=fastapi_app.title,
        version=fastapi_app.version,
        summary=fastapi_app.summary,
        description=fastapi_app.description,
        routes=fastapi_app.routes,
        tags=OPENAPI_TAGS,
        servers=fastapi_app.servers,
    )
    openapi_schema["info"]["x-logo"] = {
        "url": "https://fastapi.tiangolo.com/img/logo-margin/logo-teal.png"
    }
    fastapi_app.openapi_schema = openapi_schema
    return fastapi_app.openapi_schema


fastapi_app.openapi = custom_openapi


class MaintenanceModeMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # Разрешаем OPTIONS (CORS preflight)
        if request.method.upper() == "OPTIONS":
            return await call_next(request)

        enabled = getattr(fastapi_app.state, "maintenance_mode", False)
        if enabled:
            return JSONResponse(
                status_code=503,
                content={
                    "error": "maintenance",
                    "message": "Technical maintenance in progress. Please try again later.",
                },
            )
        return await call_next(request)


fastapi_app.add_middleware(MaintenanceModeMiddleware)
fastapi_app.add_middleware(TrustedHostMiddleware, allowed_hosts=["*"])
fastapi_app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

api_router = APIRouter(prefix="/api")


@api_router.get(
    "/ping",
    tags=["Health Check"],
    summary="Проверка доступности API и PostgreSQL",
    description="Возвращает `pong` и статус подключения к PostgreSQL.",
    response_description="Результат проверки здоровья приложения.",
)
async def index(
    db_session: AsyncSession = Depends(get_db_session),
):
    """Проверка доступности PostgreSQL"""
    pg_pong_res = await db_session.execute(text("SELECT 1"))
    pg_pong = "ok" if pg_pong_res.scalar_one_or_none() == 1 else "error"
    return {"message": "pong", "postgres": pg_pong}


api_router.include_router(auth.router, tags=["Auth & Users"])
api_router.include_router(social.router, tags=["Social"])
api_router.include_router(posts.router, tags=["Posts"])
api_router.include_router(reviews.router, tags=["Reviews"])
api_router.include_router(uploads.router, tags=["Uploads"])
api_router.include_router(user.router, tags=["User"])
api_router.include_router(travel.router, tags=["Travel"])
api_router.include_router(travel.router, tags=["Travel"])
api_router.include_router(filters.router, tags=["Filters"])
api_router.include_router(ivan_alt_local_routes.router, tags=["Routes"])
api_router.include_router(admin.router, tags=["Admin"])
fastapi_app.include_router(api_router)

OPENAPI_TAGS = [
    {
        "name": "Health Check",
        "description": "Служебные эндпоинты для проверки работоспособности API и БД.",
    },
    {
        "name": "Auth & Users",
        "description": (
            "Авторизация по телефону (`POST /api/auth`), профиль «я» (`GET /api/users/me`), "
            "прогресс достижений (`GET /api/users/me/achievements/progress`), "
            "публичный профиль (`GET /api/users/{user_id}` — подписчики, отзывы, полученные достижения)."
        ),
    },
    {
        "name": "Social",
        "description": (
            "Интересы, достижения, подписки. Управление подписками: "
            "`POST /api/subscriptions` (тело `{\"targetUserId\": number}`), "
            "`GET /api/subscriptions`, `DELETE /api/subscriptions/{target_user_id}`."
        ),
    },
    {
        "name": "Posts",
        "description": "Посты/места: публичный просмотр + административное редактирование и удаление.",
    },
    {
        "name": "Reviews",
        "description": "Отзывы к публикациям: оценка, комментарий и медиа-вложения.",
    },
    {
        "name": "Uploads",
        "description": "Загрузка и получение файлов (изображений) для контента.",
    },
    {
        "name": "User",
        "description": (
            "Действия текущего пользователя: создание мест (`POST /user/posts`), избранное, "
            "персонализированная лента мест (`GET /user/feed`), "
            "**лента активности подписок** (`GET /user/subscriptions/feed` — отзывы от авторов, "
            "на которых вы подписаны, по времени; без рекомендаций), свайпы."
        ),
    },
    {
        "name": "Travel",
        "description": "Маршруты и перелеты: города, глобальные маршруты и route info.",
    },
    {
        "name": "Travel",
        "description": "Роуты для работы с формированием маршрутов",
    },
    {
        "name": "Admin",
        "description": "Обезличенные admin endpoint-ы для MVP (дашборд и управление сущностями).",
    },
]

fastapi_app = FastAPI(
    title="Kraeved API",
    summary="REST API для социальной платформы о локальной культуре и путешествиях.",
    description=(
        "Подробная документация API проекта **Kraeved**.\n\n"
        "### Быстрый старт\n"
        "1. Получите токен через `POST /api/auth`.\n"
        "2. Нажмите `Authorize` и вставьте `Bearer <ваш_токен>`.\n"
        "3. Используйте защищенные эндпоинты для работы с user/social-функциями.\n"
        "4. Лента отзывов от подписок (фронт): `GET /api/user/subscriptions/feed?page=1&pageSize=20` "
        "(тот же токен).\n"
        "5. Для MVP admin-дашборд открыт по `/api/admin` (без привязки к пользователю).\n\n"
        "### Пагинация\n"
        "Во всех list-эндпоинтах используются параметры `page` и `pageSize`.\n\n"
        "### Ошибки\n"
        "Валидационные ошибки возвращаются в стандартном формате FastAPI (`422 Unprocessable Entity`)."
    ),
    version="1.0.0",
    contact={"name": "Kraeved Backend Team"},
    license_info={"name": "Proprietary"},
    terms_of_service="https://example.com/terms",
    openapi_tags=OPENAPI_TAGS,
    servers=[
        {"url": "/", "description": "Current host"},
    ],
    docs_url="/api/docs",
    redoc_url="/api/redoc",
    openapi_url="/api/openapi.json",
    swagger_ui_parameters={
        "defaultModelsExpandDepth": 2,
        "defaultModelExpandDepth": 2,
        "displayRequestDuration": True,
        "docExpansion": "list",
        "filter": True,
        "showExtensions": True,
        "showCommonExtensions": True,
        "tryItOutEnabled": True,
        "persistAuthorization": True,
        "deepLinking": True,
    },
    lifespan=lifespan,
)

app = fastapi_app

# Фиксируем схему запроса, когда приложение за прокси.
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse


class HttpsProxyFixMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        proto = request.headers.get("x-forwarded-proto")
        if proto:
            request.scope["scheme"] = proto
        return await call_next(request)


fastapi_app.add_middleware(HttpsProxyFixMiddleware)


def custom_openapi():
    if fastapi_app.openapi_schema:
        return fastapi_app.openapi_schema

    openapi_schema = get_openapi(
        title=fastapi_app.title,
        version=fastapi_app.version,
        summary=fastapi_app.summary,
        description=fastapi_app.description,
        routes=fastapi_app.routes,
        tags=OPENAPI_TAGS,
        servers=fastapi_app.servers,
    )
    openapi_schema["info"]["x-logo"] = {
        "url": "https://fastapi.tiangolo.com/img/logo-margin/logo-teal.png"
    }
    fastapi_app.openapi_schema = openapi_schema
    return fastapi_app.openapi_schema


fastapi_app.openapi = custom_openapi


class MaintenanceModeMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # Разрешаем OPTIONS (CORS preflight)
        if request.method.upper() == "OPTIONS":
            return await call_next(request)

        enabled = getattr(fastapi_app.state, "maintenance_mode", False)
        if enabled:
            return JSONResponse(
                status_code=503,
                content={
                    "error": "maintenance",
                    "message": "Technical maintenance in progress. Please try again later.",
                },
            )
        return await call_next(request)


fastapi_app.add_middleware(MaintenanceModeMiddleware)
fastapi_app.add_middleware(TrustedHostMiddleware, allowed_hosts=["*"])
fastapi_app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

api_router = APIRouter(prefix="/api")


@api_router.get(
    "/ping",
    tags=["Health Check"],
    summary="Проверка доступности API и PostgreSQL",
    description="Возвращает `pong` и статус подключения к PostgreSQL.",
    response_description="Результат проверки здоровья приложения.",
)
async def index(
    db_session: AsyncSession = Depends(get_db_session),
):
    """Проверка доступности PostgreSQL"""
    pg_pong_res = await db_session.execute(text("SELECT 1"))
    pg_pong = "ok" if pg_pong_res.scalar_one_or_none() == 1 else "error"
    return {"message": "pong", "postgres": pg_pong}


