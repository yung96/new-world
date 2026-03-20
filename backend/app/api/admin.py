from datetime import datetime

from fastapi import APIRouter, Depends, Query
from fastapi.responses import HTMLResponse
from pydantic import Field
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel
from app.core.dependencies import get_db_session
from app.models.associations import user_interests
from app.models.interest import Interest
from app.models.post import Post, Season
from app.models.user import User
from app.services.post_service import PostService
from app.services.social_service import SocialService

router = APIRouter(prefix="/admin")


class AdminPostUpdateRequest(BasePydanticModel):
    title: str | None = None
    description: str | None = None
    geoLat: float | None = Field(default=None, ge=-90, le=90)
    geoLng: float | None = Field(default=None, ge=-180, le=180)
    mediaUrls: list[str] | None = None
    season: Season | None = None
    interestIds: list[int] | None = None


class AdminInterestUpdateRequest(BasePydanticModel):
    name: str
    emoji: str | None = None


class AdminInterestCreateRequest(BasePydanticModel):
    name: str
    emoji: str | None = None


class AdminPostCard(BasePydanticModel):
    id: int
    title: str
    description: str | None
    authorId: int
    interestIds: list[int]
    season: Season
    createdAt: datetime
    updatedAt: datetime
    averageRating: float | None


class AdminInterestCard(BasePydanticModel):
    id: int
    name: str
    emoji: str


class AdminDashboardStats(BasePydanticModel):
    totalPosts: int
    totalInterests: int
    totalUsers: int


class AdminUserInterest(BasePydanticModel):
    id: int
    name: str
    weight: int


class AdminUserCard(BasePydanticModel):
    id: int
    phone: str
    createdAt: datetime
    interests: list[AdminUserInterest]


class AdminDashboardResponse(BasePydanticModel):
    stats: AdminDashboardStats
    posts: list[AdminPostCard]
    interests: list[AdminInterestCard]
    users: list[AdminUserCard]
    postsPage: int
    postsPageSize: int
    interestsPage: int
    interestsPageSize: int
    usersPage: int
    usersPageSize: int


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
    :root {
      --bg: #f6f7fb;
      --card: #ffffff;
      --line: #e4e7ec;
      --text: #0f1728;
      --muted: #667085;
      --brand: #1f5eff;
      --danger: #dc2626;
      --ok: #169854;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
      background: var(--bg);
      color: var(--text);
    }
    .layout {
      max-width: 1320px;
      margin: 0 auto;
      padding: 16px;
      display: grid;
      grid-template-columns: 1.45fr 1fr;
      gap: 14px;
      min-height: 100vh;
    }
    .col { display: flex; flex-direction: column; gap: 12px; }
    .card {
      background: var(--card);
      border: 1px solid var(--line);
      border-radius: 12px;
      padding: 12px;
    }
    h1 { margin: 0 0 8px; font-size: 22px; }
    h2 { margin: 0 0 8px; font-size: 16px; }
    p { margin: 0; }
    .muted { color: var(--muted); font-size: 12px; }
    .toolbar {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
      align-items: center;
    }
    input, textarea, select, button {
      font: inherit;
      border-radius: 10px;
      border: 1px solid var(--line);
      padding: 8px 10px;
    }
    input, textarea, select {
      width: 100%;
      background: #fff;
      color: var(--text);
    }
    textarea { min-height: 96px; resize: vertical; }
    button {
      cursor: pointer;
      background: #fff;
      color: var(--text);
      font-weight: 600;
    }
    button.primary {
      border-color: var(--brand);
      background: var(--brand);
      color: #fff;
    }
    button.ghost {
      background: #fff;
      border-color: var(--line);
    }
    button.danger {
      border-color: #f1c0c0;
      color: var(--danger);
      background: #fff;
    }
    .stats {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 8px;
    }
    .stat {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 8px;
      background: #fafcff;
    }
    .stat strong {
      display: block;
      font-size: 19px;
      margin-bottom: 4px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 13px;
    }
    th, td {
      border-bottom: 1px solid var(--line);
      padding: 8px 6px;
      text-align: left;
      vertical-align: top;
    }
    th { color: var(--muted); font-weight: 600; font-size: 12px; }
    tr.active { background: #f2f6ff; }
    .post-title-btn {
      border: 0;
      background: none;
      padding: 0;
      margin: 0;
      color: var(--brand);
      font-weight: 600;
      cursor: pointer;
      text-align: left;
    }
    .chips { display: flex; flex-wrap: wrap; gap: 6px; }
    .chip {
      border: 1px solid var(--line);
      border-radius: 999px;
      padding: 4px 8px;
      font-size: 12px;
      background: #fff;
      cursor: pointer;
      user-select: none;
    }
    .chip.active {
      background: #e9efff;
      border-color: #abc1ff;
      color: #1c46c6;
      font-weight: 600;
    }
    .list {
      max-height: 320px;
      overflow: auto;
      border: 1px solid var(--line);
      border-radius: 10px;
    }
    .list-item {
      display: grid;
      grid-template-columns: 1fr auto;
      align-items: center;
      gap: 8px;
      padding: 8px 10px;
      border-bottom: 1px solid var(--line);
    }
    .list-item:last-child { border-bottom: 0; }
    .user-interest {
      display: inline-flex;
      gap: 4px;
      align-items: center;
      margin: 2px 6px 2px 0;
      padding: 2px 8px;
      border-radius: 999px;
      font-size: 11px;
      border: 1px solid var(--line);
      background: #f8fafc;
    }
    .row { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
    .col-gap { display: flex; flex-direction: column; gap: 8px; }
    .status {
      font-size: 12px;
      color: var(--muted);
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 8px;
      background: #fcfcfd;
      white-space: pre-wrap;
    }
    @media (max-width: 1100px) {
      .layout { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
  <div class="layout">
    <div class="col">
      <div class="card">
        <h1>Kraeved Admin</h1>
        <p class="muted">Удобное управление местами и интересами для MVP.</p>
        <div class="toolbar" style="margin-top: 10px;">
          <button class="primary" onclick="loadDashboard()">Обновить данные</button>
          <span class="muted">Посты: page=<span id="postsPageInfo">1</span>, Интересы: page=<span id="interestsPageInfo">1</span>, Юзеры: page=<span id="usersPageInfo">1</span></span>
        </div>
        <div class="stats" style="margin-top: 10px;">
          <div class="stat"><strong id="statPosts">0</strong><span class="muted">Мест</span></div>
          <div class="stat"><strong id="statInterests">0</strong><span class="muted">Интересов</span></div>
          <div class="stat"><strong id="statUsers">0</strong><span class="muted">Пользователей</span></div>
          <div class="stat"><strong id="statLoaded">0</strong><span class="muted">Загружено в таблицу</span></div>
        </div>
      </div>

      <div class="card">
        <h2>Места (посты)</h2>
        <div class="toolbar" style="margin-bottom: 8px;">
          <input id="postSearch" placeholder="Поиск по title/description/season" oninput="renderPostRows()" />
          <button class="ghost" onclick="clearPostSearch()">Сброс</button>
        </div>
        <div class="list">
          <table>
            <thead>
              <tr>
                <th style="width: 70px;">ID</th>
                <th>Название</th>
                <th style="width: 80px;">Автор</th>
                <th style="width: 90px;">Рейтинг</th>
                <th style="width: 120px;">Действие</th>
              </tr>
            </thead>
            <tbody id="postsTableBody"></tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="col">
      <div class="card">
        <h2>Редактор места</h2>
        <p class="muted" id="editorHint">Выбери место в таблице слева.</p>
        <div class="col-gap" style="margin-top: 8px;">
          <input id="editPostId" disabled placeholder="post_id" />
          <input id="editPostTitle" placeholder="Название места" />
          <textarea id="editPostDescription" placeholder="Описание"></textarea>
          <select id="editPostSeason">
            <option value="spring">spring</option>
            <option value="summer">summer</option>
            <option value="autumn">autumn</option>
            <option value="winter">winter</option>
          </select>
          <div>
            <p class="muted" style="margin-bottom: 6px;">Интересы места (клик для выбора):</p>
            <div id="interestChips" class="chips"></div>
          </div>
          <div class="toolbar">
            <button class="primary" onclick="saveSelectedPost()">Сохранить изменения</button>
            <button class="danger" onclick="deleteSelectedPost()">Удалить место</button>
          </div>
        </div>
      </div>

      <div class="card">
        <h2>Управление интересами</h2>
        <div class="row" style="margin-bottom: 8px;">
          <input id="newInterestName" placeholder="Новый интерес" />
          <input id="newInterestEmoji" placeholder="Emoji (необязательно)" />
          <button class="primary" onclick="createInterest()">Создать</button>
        </div>
        <div class="list" id="interestsList"></div>
      </div>

      <div class="card">
        <h2>Пользователи и их веса интересов</h2>
        <div class="list" id="usersList"></div>
      </div>

      <div class="card">
        <h2>Лог</h2>
        <div id="status" class="status">Готово к работе.</div>
      </div>
    </div>
  </div>

  <script>
    const state = {
      posts: [],
      interests: [],
      users: [],
      selectedPostId: null,
      selectedInterestIds: new Set(),
    };

    const api = async (url, method = 'GET', body = null) => {
      const headers = { 'Content-Type': 'application/json' };
      const res = await fetch(url, {
        method,
        headers,
        body: body ? JSON.stringify(body) : undefined,
      });
      const text = await res.text();
      let payload;
      try { payload = text ? JSON.parse(text) : null; } catch (_) { payload = text; }
      if (!res.ok) throw new Error(typeof payload === 'string' ? payload : JSON.stringify(payload));
      return payload;
    };

    const setStatus = (value, ok = true) => {
      const el = document.getElementById('status');
      el.style.color = ok ? 'var(--ok)' : 'var(--danger)';
      el.textContent = typeof value === 'string' ? value : JSON.stringify(value, null, 2);
    };

    const byId = (id) => document.getElementById(id);

    const normalize = (str) => (str || '').toLowerCase();

    function clearPostSearch() {
      byId('postSearch').value = '';
      renderPostRows();
    }

    function renderStats(payload) {
      byId('statPosts').textContent = String(payload.stats.totalPosts || 0);
      byId('statInterests').textContent = String(payload.stats.totalInterests || 0);
      byId('statUsers').textContent = String(payload.stats.totalUsers || 0);
      byId('statLoaded').textContent = String(payload.posts.length || 0);
      byId('postsPageInfo').textContent = String(payload.postsPage);
      byId('interestsPageInfo').textContent = String(payload.interestsPage);
      byId('usersPageInfo').textContent = String(payload.usersPage);
    }

    function renderPostRows() {
      const tbody = byId('postsTableBody');
      const q = normalize(byId('postSearch').value);
      const rows = state.posts.filter((post) => {
        return normalize(post.title).includes(q) || normalize(post.description).includes(q) || normalize(post.season).includes(q);
      });
      tbody.innerHTML = rows.map((post) => {
        const active = post.id === state.selectedPostId ? ' class="active"' : '';
        return `
          <tr${active}>
            <td>#${post.id}</td>
            <td>
              <button class="post-title-btn" onclick="selectPost(${post.id})">${escapeHtml(post.title || 'Без названия')}</button>
              <div class="muted">season: ${escapeHtml(post.season || '-')}</div>
            </td>
            <td>${post.authorId}</td>
            <td>${post.averageRating == null ? '-' : post.averageRating}</td>
            <td><button class="ghost" onclick="selectPost(${post.id})">Открыть</button></td>
          </tr>
        `;
      }).join('');
    }

    function renderInterestChips() {
      const chips = byId('interestChips');
      chips.innerHTML = state.interests.map((interest) => {
        const active = state.selectedInterestIds.has(interest.id) ? 'active' : '';
        return `<span class="chip ${active}" onclick="toggleInterest(${interest.id})">${escapeHtml(interest.name)}</span>`;
      }).join('');
    }

    function renderInterestsList() {
      const list = byId('interestsList');
      list.innerHTML = state.interests.map((item) => `
        <div class="list-item">
          <div>
            <strong>#${item.id}</strong> ${escapeHtml(item.name)} ${escapeHtml(item.emoji || '')}
          </div>
          <div class="toolbar">
            <button class="ghost" onclick="renameInterestPrompt(${item.id})">Переименовать</button>
            <button class="danger" onclick="deleteInterest(${item.id})">Удалить</button>
          </div>
        </div>
      `).join('') || '<div class="list-item"><span class="muted">Нет интересов на этой странице.</span></div>';
    }

    function renderUsersList() {
      const list = byId('usersList');
      list.innerHTML = state.users.map((user) => {
        const interests = (user.interests || []).map((interest) =>
          `<span class="user-interest">${escapeHtml(interest.name)} · w=${interest.weight}</span>`
        ).join('');
        return `
          <div class="list-item">
            <div>
              <strong>#${user.id}</strong> ${escapeHtml(user.phone)}
              <div class="muted">${new Date(user.createdAt).toLocaleString()}</div>
              <div style="margin-top: 4px;">${interests || '<span class="muted">Нет интересов</span>'}</div>
            </div>
          </div>
        `;
      }).join('') || '<div class="list-item"><span class="muted">Нет пользователей на этой странице.</span></div>';
    }

    function selectPost(postId) {
      const post = state.posts.find((p) => p.id === postId);
      if (!post) return;
      state.selectedPostId = post.id;
      state.selectedInterestIds = new Set(post.interestIds || []);
      byId('editPostId').value = String(post.id);
      byId('editPostTitle').value = post.title || '';
      byId('editPostDescription').value = post.description || '';
      byId('editPostSeason').value = post.season || 'spring';
      byId('editorHint').textContent = `Редактируется место #${post.id}`;
      renderPostRows();
      renderInterestChips();
    }

    function toggleInterest(interestId) {
      if (state.selectedPostId == null) {
        setStatus('Сначала выбери место слева.', false);
        return;
      }
      if (state.selectedInterestIds.has(interestId)) state.selectedInterestIds.delete(interestId);
      else state.selectedInterestIds.add(interestId);
      renderInterestChips();
    }

    async function loadDashboard() {
      try {
        const payload = await api('/api/admin/dashboard');
        state.posts = payload.posts || [];
        state.interests = payload.interests || [];
        state.users = payload.users || [];
        renderStats(payload);
        renderPostRows();
        renderInterestsList();
        renderUsersList();
        renderInterestChips();

        if (state.posts.length && state.selectedPostId == null) {
          selectPost(state.posts[0].id);
        } else if (state.selectedPostId != null) {
          const existing = state.posts.find((p) => p.id === state.selectedPostId);
          if (existing) selectPost(existing.id);
        }
        setStatus('Данные обновлены');
      } catch (e) {
        setStatus('Ошибка загрузки дашборда: ' + e.message, false);
      }
    }

    async function saveSelectedPost() {
      if (state.selectedPostId == null) {
        setStatus('Сначала выбери место для редактирования.', false);
        return;
      }
      const title = byId('editPostTitle').value.trim();
      const description = byId('editPostDescription').value.trim();
      const season = byId('editPostSeason').value;
      const interestIds = Array.from(state.selectedInterestIds.values());
      try {
        const payload = await api(`/api/admin/posts/${state.selectedPostId}`, 'PATCH', {
          title: title || null,
          description: description || undefined,
          season,
          interestIds,
        });
        setStatus(`Место #${payload.id} сохранено`);
        await loadDashboard();
      } catch (e) {
        setStatus('Ошибка сохранения места: ' + e.message, false);
      }
    }

    async function deleteSelectedPost() {
      if (state.selectedPostId == null) {
        setStatus('Сначала выбери место для удаления.', false);
        return;
      }
      const sure = window.confirm(`Удалить место #${state.selectedPostId}?`);
      if (!sure) return;
      try {
        await api(`/api/posts/${state.selectedPostId}`, 'DELETE');
        state.selectedPostId = null;
        byId('editPostId').value = '';
        byId('editPostTitle').value = '';
        byId('editPostDescription').value = '';
        byId('editPostSeason').value = 'spring';
        byId('editorHint').textContent = 'Выбери место в таблице слева.';
        setStatus('Место удалено');
        await loadDashboard();
      } catch (e) {
        setStatus('Ошибка удаления места: ' + e.message, false);
      }
    }

    async function createInterest() {
      const name = byId('newInterestName').value.trim();
      const emoji = byId('newInterestEmoji').value.trim();
      if (!name) {
        setStatus('Введите название интереса.', false);
        return;
      }
      try {
        const payload = await api('/api/admin/interests', 'POST', { name, emoji: emoji || null });
        byId('newInterestName').value = '';
        byId('newInterestEmoji').value = '';
        setStatus(`Создан интерес #${payload.id}: ${payload.name} ${payload.emoji || ''}`);
        await loadDashboard();
      } catch (e) {
        setStatus('Ошибка создания интереса: ' + e.message, false);
      }
    }

    async function renameInterestPrompt(id) {
      const item = state.interests.find((interest) => interest.id === id);
      const oldName = item?.name || '';
      const oldEmoji = item?.emoji || '';
      const name = window.prompt('Новое имя интереса:', oldName);
      if (!name) return;
      const emoji = window.prompt('Emoji интереса (можно оставить пустым):', oldEmoji);
      try {
        const payload = await api(`/api/admin/interests/${id}`, 'PATCH', { name, emoji: emoji || null });
        setStatus(`Интерес #${payload.id} обновлен: "${payload.name}" ${payload.emoji || ''}`);
        await loadDashboard();
      } catch (e) {
        setStatus('Ошибка переименования интереса: ' + e.message, false);
      }
    }

    async function deleteInterest(id) {
      const sure = window.confirm(`Удалить интерес #${id}?`);
      if (!sure) return;
      try {
        await api(`/api/admin/interests/${id}`, 'DELETE');
        setStatus(`Интерес #${id} удален`);
        await loadDashboard();
      } catch (e) {
        setStatus('Ошибка удаления интереса: ' + e.message, false);
      }
    }

    function escapeHtml(value) {
      return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
    }

    window.loadDashboard = loadDashboard;
    window.clearPostSearch = clearPostSearch;
    window.selectPost = selectPost;
    window.toggleInterest = toggleInterest;
    window.saveSelectedPost = saveSelectedPost;
    window.deleteSelectedPost = deleteSelectedPost;
    window.createInterest = createInterest;
    window.renameInterestPrompt = renameInterestPrompt;
    window.deleteInterest = deleteInterest;

    loadDashboard();
  </script>
</body>
</html>
"""


@router.get(
    "/dashboard",
    response_model=AdminDashboardResponse,
    summary="Admin dashboard данные",
    description="Агрегированные данные для обезличенного admin-дашборда MVP.",
    response_description="Статистика, места, интересы и пользователи с весами интересов.",
)
async def get_admin_dashboard(
    postsPage: int = Query(default=1, ge=1),
    postsPageSize: int = Query(default=20, ge=1, le=100),
    interestsPage: int = Query(default=1, ge=1),
    interestsPageSize: int = Query(default=50, ge=1, le=100),
    usersPage: int = Query(default=1, ge=1),
    usersPageSize: int = Query(default=50, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    """
    Возвращает агрегированные данные для админского UI:
    - статистику;
    - список мест;
    - список интересов;
    - список пользователей с интересами и весами.
    """
    post_rows, _ = await _post_service(db).list_posts(page=postsPage, page_size=postsPageSize)
    interests, _ = await _social_service(db).list_interests(
        page=interestsPage, page_size=interestsPageSize
    )
    users_offset = (usersPage - 1) * usersPageSize
    users = (
        await db.execute(
            select(User).order_by(User.id.asc()).offset(users_offset).limit(usersPageSize)
        )
    ).scalars().all()

    posts = [
        AdminPostCard(
            id=post.id,
            title=post.title,
            description=post.description,
            authorId=post.author_id,
            interestIds=[interest.id for interest in post.interests],
            season=post.season,
            createdAt=post.created_at,
            updatedAt=post.updated_at,
            averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
        )
        for post, avg_rating in post_rows
    ]
    interest_cards = [
        AdminInterestCard(id=item.id, name=item.name, emoji=item.emoji or "")
        for item in interests
    ]
    user_ids = [item.id for item in users]
    interest_rows = []
    if user_ids:
        interest_rows = (
            await db.execute(
                select(
                    user_interests.c.user_id,
                    user_interests.c.interest_id,
                    user_interests.c.weight,
                    Interest.name,
                )
                .join(Interest, Interest.id == user_interests.c.interest_id)
                .where(user_interests.c.user_id.in_(user_ids))
                .order_by(user_interests.c.user_id.asc(), Interest.name.asc())
            )
        ).all()

    interests_by_user: dict[int, list[AdminUserInterest]] = {}
    for row in interest_rows:
        interests_by_user.setdefault(row.user_id, []).append(
            AdminUserInterest(id=row.interest_id, name=row.name, weight=row.weight)
        )

    user_cards = [
        AdminUserCard(
            id=item.id,
            phone=item.phone,
            createdAt=item.created_at,
            interests=interests_by_user.get(item.id, []),
        )
        for item in users
    ]
    total_posts = int((await db.execute(select(func.count(Post.id)))).scalar_one() or 0)
    total_interests = int(
        (await db.execute(select(func.count(Interest.id)))).scalar_one() or 0
    )
    total_users = int((await db.execute(select(func.count(User.id)))).scalar_one() or 0)

    return AdminDashboardResponse(
        stats=AdminDashboardStats(
            totalPosts=total_posts, totalInterests=total_interests, totalUsers=total_users
        ),
        posts=posts,
        interests=interest_cards,
        users=user_cards,
        postsPage=postsPage,
        postsPageSize=postsPageSize,
        interestsPage=interestsPage,
        interestsPageSize=interestsPageSize,
        usersPage=usersPage,
        usersPageSize=usersPageSize,
    )


@router.patch(
    "/posts/{post_id}",
    response_model=AdminPostCard,
    summary="Admin: редактировать место",
    description="Частично обновляет место (пост) в административном интерфейсе.",
    response_description="Обновленное место.",
)
async def admin_update_post(
    post_id: int,
    payload: AdminPostUpdateRequest,
    db: AsyncSession = Depends(get_db_session),
):
    """Редактирование места через admin API."""
    post = await _post_service(db).admin_update_post(
        post_id=post_id,
        title=payload.title,
        description=payload.description,
        geo_lat=payload.geoLat,
        geo_lng=payload.geoLng,
        media_urls=payload.mediaUrls,
        season=payload.season,
        interest_ids=payload.interestIds,
    )
    _, avg_rating = await _post_service(db).get_post_or_404(post.id)
    return AdminPostCard(
        id=post.id,
        title=post.title,
        description=post.description,
        authorId=post.author_id,
        interestIds=[interest.id for interest in post.interests],
        season=post.season,
        createdAt=post.created_at,
        updatedAt=post.updated_at,
        averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
    )


@router.post(
    "/interests",
    response_model=AdminInterestCard,
    summary="Admin: создать интерес",
    description="Создает новый интерес в справочнике интересов.",
    response_description="Созданный интерес.",
)
async def admin_create_interest(
    payload: AdminInterestCreateRequest,
    db: AsyncSession = Depends(get_db_session),
):
    """Создание интереса через admin API."""
    interest = await _social_service(db).create_interest(payload.name, payload.emoji)
    return AdminInterestCard(id=interest.id, name=interest.name, emoji=interest.emoji or "")


@router.patch(
    "/interests/{interest_id}",
    response_model=AdminInterestCard,
    summary="Admin: переименовать интерес",
    description="Обновляет название существующего интереса.",
    response_description="Обновленный интерес.",
)
async def admin_update_interest(
    interest_id: int,
    payload: AdminInterestUpdateRequest,
    db: AsyncSession = Depends(get_db_session),
):
    """Переименование интереса через admin API."""
    interest = await _social_service(db).update_interest(
        interest_id=interest_id, name=payload.name
    )
    if payload.emoji is not None:
        interest.emoji = (payload.emoji or "").strip() or "🪁"
        await db.commit()
        await db.refresh(interest)
    return AdminInterestCard(id=interest.id, name=interest.name, emoji=interest.emoji or "")


@router.delete(
    "/interests/{interest_id}",
    status_code=204,
    summary="Admin: удалить интерес",
    description="Удаляет интерес из справочника.",
)
async def admin_delete_interest(
    interest_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    """Удаление интереса через admin API."""
    await _social_service(db).delete_interest(interest_id)

