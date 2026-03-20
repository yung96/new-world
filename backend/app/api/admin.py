from datetime import datetime

from fastapi import APIRouter, Depends, Query
from fastapi.responses import HTMLResponse
from pydantic import Field
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.admin_auth import require_admin_key
from app.api.base_schema import BasePydanticModel
from app.core.dependencies import get_db_session
from app.models.interest import Interest
from app.models.post import Post
from app.services.post_service import PostService
from app.services.social_service import SocialService

router = APIRouter(prefix="/admin")


class AdminPostUpdateRequest(BasePydanticModel):
    title: str | None = None
    description: str | None = None
    geoLat: float | None = Field(default=None, ge=-90, le=90)
    geoLng: float | None = Field(default=None, ge=-180, le=180)
    mediaUrls: list[str] | None = None
    tags: list[str] | None = None
    interestIds: list[int] | None = None


class AdminInterestUpdateRequest(BasePydanticModel):
    name: str


class AdminInterestCreateRequest(BasePydanticModel):
    name: str


class AdminPostCard(BasePydanticModel):
    id: int
    title: str
    description: str | None
    authorId: int
    interestIds: list[int]
    tags: list[str]
    createdAt: datetime
    updatedAt: datetime
    averageRating: float | None


class AdminInterestCard(BasePydanticModel):
    id: int
    name: str
    createdAt: datetime


class AdminDashboardStats(BasePydanticModel):
    totalPosts: int
    totalInterests: int


class AdminDashboardResponse(BasePydanticModel):
    stats: AdminDashboardStats
    posts: list[AdminPostCard]
    interests: list[AdminInterestCard]
    postsPage: int
    postsPageSize: int
    interestsPage: int
    interestsPageSize: int


def _post_service(db: AsyncSession) -> PostService:
    return PostService(db)


def _social_service(db: AsyncSession) -> SocialService:
    return SocialService(db)


@router.get("", response_class=HTMLResponse, include_in_schema=False)
async def admin_editor_page():
    return """
<!doctype html>
<html lang="ru">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Kraeved Admin</title>
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, sans-serif; margin: 0; background: #f5f5f5; color: #111; }
    .wrap { max-width: 980px; margin: 0 auto; padding: 16px; }
    .card { background: #fff; border: 1px solid #ddd; border-radius: 10px; padding: 14px; margin-bottom: 12px; }
    h1, h2 { margin: 0 0 10px; }
    h1 { font-size: 24px; }
    h2 { font-size: 18px; }
    input, textarea, button { font: inherit; }
    input, textarea { width: 100%; box-sizing: border-box; margin-bottom: 8px; padding: 8px; border: 1px solid #bbb; border-radius: 8px; }
    textarea { min-height: 80px; resize: vertical; }
    .row { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
    .row3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 8px; }
    button { padding: 8px 12px; border-radius: 8px; border: 1px solid #222; background: #111; color: #fff; cursor: pointer; }
    button.secondary { background: #fff; color: #111; }
    pre { background: #fafafa; border: 1px solid #ddd; padding: 10px; border-radius: 8px; overflow: auto; }
    .muted { color: #666; font-size: 12px; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <h1>Admin Dashboard (MVP)</h1>
      <p class="muted">Обезличенный редактор admin endpoint-ов. Все запросы идут в <code>/api/admin/*</code>.</p>
      <div class="row">
        <input id="adminKey" placeholder="X-Admin-Key" />
        <button onclick="loadDashboard()">Загрузить дашборд</button>
      </div>
    </div>

    <div class="card">
      <h2>Редактировать пост (место)</h2>
      <div class="row3">
        <input id="postId" placeholder="post_id" />
        <input id="postTitle" placeholder="title" />
        <input id="postTags" placeholder="tags через запятую" />
      </div>
      <textarea id="postDescription" placeholder="description"></textarea>
      <div class="row">
        <input id="postInterestIds" placeholder="interestIds через запятую: 1,2" />
        <button onclick="updatePost()">PATCH /api/admin/posts/{id}</button>
      </div>
    </div>

    <div class="card">
      <h2>Интересы</h2>
      <div class="row3">
        <input id="newInterestName" placeholder="Новый interest name" />
        <button onclick="createInterest()">POST /api/admin/interests</button>
        <div></div>
      </div>
      <div class="row3">
        <input id="interestId" placeholder="interest_id" />
        <input id="interestName" placeholder="Новое имя" />
        <button onclick="updateInterest()">PATCH /api/admin/interests/{id}</button>
      </div>
      <div class="row">
        <input id="deleteInterestId" placeholder="interest_id для удаления" />
        <button class="secondary" onclick="deleteInterest()">DELETE /api/admin/interests/{id}</button>
      </div>
    </div>

    <div class="card">
      <h2>Ответ</h2>
      <pre id="result">Готово.</pre>
    </div>

    <div class="card">
      <h2>Дашборд JSON</h2>
      <pre id="dashboard">Нажми "Загрузить дашборд".</pre>
    </div>
  </div>

  <script>
    const getKey = () => document.getElementById('adminKey').value.trim();

    const api = async (url, method = 'GET', body = null) => {
      const res = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
          'X-Admin-Key': getKey(),
        },
        body: body ? JSON.stringify(body) : undefined,
      });
      const text = await res.text();
      let payload;
      try { payload = text ? JSON.parse(text) : null; } catch (_) { payload = text; }
      if (!res.ok) throw new Error(typeof payload === 'string' ? payload : JSON.stringify(payload));
      return payload;
    };

    const setResult = (value) => {
      document.getElementById('result').textContent =
        typeof value === 'string' ? value : JSON.stringify(value, null, 2);
    };

    async function loadDashboard() {
      try {
        const payload = await api('/api/admin/dashboard');
        document.getElementById('dashboard').textContent = JSON.stringify(payload, null, 2);
        setResult('Dashboard loaded');
      } catch (e) {
        setResult('Ошибка: ' + e.message);
      }
    }

    async function updatePost() {
      const postId = document.getElementById('postId').value.trim();
      const title = document.getElementById('postTitle').value;
      const description = document.getElementById('postDescription').value;
      const tags = document.getElementById('postTags').value
        .split(',').map(v => v.trim()).filter(Boolean);
      const interestIds = document.getElementById('postInterestIds').value
        .split(',').map(v => Number(v.trim())).filter(v => Number.isFinite(v));
      try {
        const payload = await api(`/api/admin/posts/${postId}`, 'PATCH', {
          title: title || undefined,
          description: description || undefined,
          tags: tags.length ? tags : undefined,
          interestIds: interestIds.length ? interestIds : undefined,
        });
        setResult(payload);
      } catch (e) {
        setResult('Ошибка: ' + e.message);
      }
    }

    async function createInterest() {
      const name = document.getElementById('newInterestName').value.trim();
      try {
        const payload = await api('/api/admin/interests', 'POST', { name });
        setResult(payload);
      } catch (e) {
        setResult('Ошибка: ' + e.message);
      }
    }

    async function updateInterest() {
      const id = document.getElementById('interestId').value.trim();
      const name = document.getElementById('interestName').value.trim();
      try {
        const payload = await api(`/api/admin/interests/${id}`, 'PATCH', { name });
        setResult(payload);
      } catch (e) {
        setResult('Ошибка: ' + e.message);
      }
    }

    async function deleteInterest() {
      const id = document.getElementById('deleteInterestId').value.trim();
      try {
        await api(`/api/admin/interests/${id}`, 'DELETE');
        setResult({ ok: true, deletedInterestId: id });
      } catch (e) {
        setResult('Ошибка: ' + e.message);
      }
    }
  </script>
</body>
</html>
"""


@router.get("/dashboard", response_model=AdminDashboardResponse)
async def get_admin_dashboard(
    _: None = Depends(require_admin_key),
    postsPage: int = Query(default=1, ge=1),
    postsPageSize: int = Query(default=20, ge=1, le=100),
    interestsPage: int = Query(default=1, ge=1),
    interestsPageSize: int = Query(default=50, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    post_rows, _ = await _post_service(db).list_posts(page=postsPage, page_size=postsPageSize)
    interests, _ = await _social_service(db).list_interests(
        page=interestsPage, page_size=interestsPageSize
    )

    posts = [
        AdminPostCard(
            id=post.id,
            title=post.title,
            description=post.description,
            authorId=post.author_id,
            interestIds=[interest.id for interest in post.interests],
            tags=list(post.tags or []),
            createdAt=post.created_at,
            updatedAt=post.updated_at,
            averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
        )
        for post, avg_rating in post_rows
    ]
    interest_cards = [
        AdminInterestCard(id=item.id, name=item.name, createdAt=item.created_at)
        for item in interests
    ]
    total_posts = int((await db.execute(select(func.count(Post.id)))).scalar_one() or 0)
    total_interests = int(
        (await db.execute(select(func.count(Interest.id)))).scalar_one() or 0
    )

    return AdminDashboardResponse(
        stats=AdminDashboardStats(totalPosts=total_posts, totalInterests=total_interests),
        posts=posts,
        interests=interest_cards,
        postsPage=postsPage,
        postsPageSize=postsPageSize,
        interestsPage=interestsPage,
        interestsPageSize=interestsPageSize,
    )


@router.patch("/posts/{post_id}", response_model=AdminPostCard)
async def admin_update_post(
    post_id: int,
    payload: AdminPostUpdateRequest,
    _: None = Depends(require_admin_key),
    db: AsyncSession = Depends(get_db_session),
):
    post = await _post_service(db).admin_update_post(
        post_id=post_id,
        title=payload.title,
        description=payload.description,
        geo_lat=payload.geoLat,
        geo_lng=payload.geoLng,
        media_urls=payload.mediaUrls,
        tags=payload.tags,
        interest_ids=payload.interestIds,
    )
    _, avg_rating = await _post_service(db).get_post_or_404(post.id)
    return AdminPostCard(
        id=post.id,
        title=post.title,
        description=post.description,
        authorId=post.author_id,
        interestIds=[interest.id for interest in post.interests],
        tags=list(post.tags or []),
        createdAt=post.created_at,
        updatedAt=post.updated_at,
        averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
    )


@router.post("/interests", response_model=AdminInterestCard)
async def admin_create_interest(
    payload: AdminInterestCreateRequest,
    _: None = Depends(require_admin_key),
    db: AsyncSession = Depends(get_db_session),
):
    interest = await _social_service(db).create_interest(payload.name)
    return AdminInterestCard(id=interest.id, name=interest.name, createdAt=interest.created_at)


@router.patch("/interests/{interest_id}", response_model=AdminInterestCard)
async def admin_update_interest(
    interest_id: int,
    payload: AdminInterestUpdateRequest,
    _: None = Depends(require_admin_key),
    db: AsyncSession = Depends(get_db_session),
):
    interest = await _social_service(db).update_interest(
        interest_id=interest_id, name=payload.name
    )
    return AdminInterestCard(id=interest.id, name=interest.name, createdAt=interest.created_at)


@router.delete("/interests/{interest_id}", status_code=204)
async def admin_delete_interest(
    interest_id: int,
    _: None = Depends(require_admin_key),
    db: AsyncSession = Depends(get_db_session),
):
    await _social_service(db).delete_interest(interest_id)

