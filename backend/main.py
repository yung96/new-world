from fastapi import FastAPI, APIRouter, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.trustedhost import TrustedHostMiddleware
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.core.lifespan import lifespan
from app.core.dependencies import get_db_session
from app.api import auth, posts, reviews, social, uploads

fastapi_app = FastAPI(lifespan=lifespan)

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
                    "message": "Technical maintenance in progress. Please try again later."
                }
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


@api_router.get("/ping", tags=["Health Check"]) 
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
fastapi_app.include_router(api_router)

