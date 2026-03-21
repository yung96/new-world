import json
import uuid
from typing import Any

from fastapi import APIRouter, Depends, Header, HTTPException, Query, status
from fastapi.responses import HTMLResponse
from pydantic import Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.api.base_schema import BasePydanticModel
from app.core.config import settings
from app.core.dependencies import get_db_session
from app.models.post import Season
from app.models.user import User
from app.services.ivan_alt_local_route_service import IvanAltLocalRouteService
from app.services.post_service import PostService
from app.services.social_service import SocialService
from app.services.user_service import get_or_create_user

router = APIRouter(prefix="/ivan-alt")


class InterestWeightItem(BasePydanticModel):
    interestId: int
    weight: int = Field(ge=1, le=1000, description="Вес интереса для скоринга мест")


class IvanAltLocalRouteGenerateRequest(BasePydanticModel):
    startLat: float = Field(ge=-90, le=90)
    startLng: float = Field(ge=-180, le=180)
    startLabel: str | None = None
    n: int = Field(default=8, ge=1, le=30, description="Сколько самых релевантных мест отдать в LLM")
    interestWeights: list[InterestWeightItem]
    bboxDeltaDegrees: float = Field(
        default=0.55,
        ge=0.05,
        le=3.0,
        description="Полуразмер bbox вокруг точки А (градусы широты/долготы)",
    )
    save: bool = Field(default=False, description="Сохранить маршрут в профиль пользователя")
    skipLlm: bool = Field(default=False, description="Черновик без вызова нейросети (для тестов)")


_IVAN_ALT_PANEL_HTML = """
<!doctype html>
<html lang="ru">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Ivan-alt: LLM маршрут</title>
  <style>
    :root { --bg:#f6f7fb; --card:#fff; --line:#e4e7ec; --text:#0f1728; --muted:#667085; --brand:#1f5eff; }
    body { font-family: system-ui, sans-serif; margin: 0; background: var(--bg); color: var(--text); }
    .wrap { max-width: 920px; margin: 0 auto; padding: 24px; }
    h1 { font-size: 1.25rem; }
    .card { background: var(--card); border: 1px solid var(--line); border-radius: 12px; padding: 16px; margin-bottom: 16px; }
    label { display: block; font-size: 0.85rem; color: var(--muted); margin-top: 10px; }
    input, textarea, button { width: 100%; box-sizing: border-box; padding: 8px 10px; margin-top: 4px; border-radius: 8px; border: 1px solid var(--line); }
    button.primary { background: var(--brand); color: #fff; border: none; cursor: pointer; font-weight: 600; }
    button.primary:disabled { opacity: 0.5; }
    .row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
    pre { background: #0f1728; color: #e2e8f0; padding: 12px; border-radius: 8px; overflow: auto; font-size: 12px; max-height: 420px; }
    .stop { border-bottom: 1px solid var(--line); padding: 10px 0; }
    .muted { color: var(--muted); font-size: 0.85rem; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Ivan-alt — тест LLM-маршрута</h1>
    <p class="muted">База API: <code id="apiBase"></code>. Нужен JWT из <code>POST …/auth</code> (Bearer).</p>

    <div class="card">
      <label>Bearer токен</label>
      <input type="password" id="token" placeholder="вставьте access_token" autocomplete="off" />
      <div class="row">
        <div>
          <label>startLat</label>
          <input type="number" id="startLat" value="45.0355" step="any" />
        </div>
        <div>
          <label>startLng</label>
          <input type="number" id="startLng" value="38.9753" step="any" />
        </div>
      </div>
      <label>startLabel (опционально)</label>
      <input type="text" id="startLabel" placeholder="Краснодар, центр" />
      <div class="row">
        <div>
          <label>n (мест в маршрут)</label>
          <input type="number" id="n" value="5" min="1" max="30" />
        </div>
        <div>
          <label>bboxDeltaDegrees</label>
          <input type="number" id="bboxDelta" value="0.55" step="0.05" min="0.05" />
        </div>
      </div>
      <label>interestWeights JSON, например [{"interestId":1,"weight":5},{"interestId":2,"weight":3}]</label>
      <textarea id="weights" rows="4">[]</textarea>
      <label><input type="checkbox" id="save" /> save — сохранить маршрут в профиль</label>
      <label><input type="checkbox" id="skipLlm" checked /> skipLlm — без нейросети (черновик)</label>
      <br/><br/>
      <button class="primary" type="button" id="go">Сгенерировать</button>
    </div>

    <div class="card">
      <h2>Результат</h2>
      <div id="stops"></div>
      <label>JSON</label>
      <pre id="out">{}</pre>
    </div>
  </div>
  <script>
    const API_ROOT = __API_MOUNT__;
    document.getElementById('apiBase').textContent = API_ROOT;

    document.getElementById('go').onclick = async () => {
      const btn = document.getElementById('go');
      btn.disabled = true;
      const token = document.getElementById('token').value.trim();
      let weights;
      try { weights = JSON.parse(document.getElementById('weights').value || '[]'); }
      catch (e) {
        alert('Невалидный JSON интересов');
        btn.disabled = false;
        return;
      }
      const body = {
        startLat: parseFloat(document.getElementById('startLat').value),
        startLng: parseFloat(document.getElementById('startLng').value),
        startLabel: document.getElementById('startLabel').value || null,
        n: parseInt(document.getElementById('n').value, 10),
        bboxDeltaDegrees: parseFloat(document.getElementById('bboxDelta').value),
        interestWeights: weights,
        save: document.getElementById('save').checked,
        skipLlm: document.getElementById('skipLlm').checked,
      };
      try {
        const res = await fetch(API_ROOT + '/ivan-alt/local-routes/generate', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: token ? 'Bearer ' + token : '',
          },
          body: JSON.stringify(body),
        });
        const data = await res.json().catch(() => ({}));
        document.getElementById('out').textContent = JSON.stringify(data, null, 2);
        const stopsEl = document.getElementById('stops');
        stopsEl.innerHTML = '';
        if (!res.ok) {
          stopsEl.innerHTML = '<p class="muted">Ошибка: ' + (data.detail || res.status) + '</p>';
        } else {
          const title = document.createElement('h3');
          title.textContent = data.routeTitle || '';
          stopsEl.appendChild(title);
          if (data.intro) {
            const p = document.createElement('p');
            p.textContent = data.intro;
            stopsEl.appendChild(p);
          }
          (data.stops || []).forEach((s, i) => {
            const d = document.createElement('div');
            d.className = 'stop';
            d.innerHTML = '<strong>#' + (i+1) + ' postId ' + s.postId + '</strong><p>' + (s.caption || '') + '</p>';
            stopsEl.appendChild(d);
          });
          if (data.savedRouteId) {
            const x = document.createElement('p');
            x.className = 'muted';
            x.textContent = 'Сохранено: route id ' + data.savedRouteId;
            stopsEl.appendChild(x);
          }
        }
      } catch (e) {
        document.getElementById('out').textContent = String(e);
      }
      btn.disabled = false;
    };
  </script>
</body>
</html>
"""

_IVAN_ALT_TEST_PANEL_HTML = """
<!doctype html>
<html lang="ru">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Ivan-alt: E2E тест LLM</title>
  <style>
    :root { --bg:#0f1419; --card:#1a2332; --line:#2d3a4f; --text:#e8eef7; --muted:#8b9cb3; --ok:#3dd68c; --err:#f87171; }
    body { font-family: ui-sans-serif, system-ui, sans-serif; margin: 0; background: var(--bg); color: var(--text); }
    .wrap { max-width: 1100px; margin: 0 auto; padding: 24px; }
    h1 { font-size: 1.35rem; font-weight: 600; }
    .card { background: var(--card); border: 1px solid var(--line); border-radius: 12px; padding: 16px; margin-bottom: 16px; }
    label { display: block; font-size: 0.8rem; color: var(--muted); margin-top: 12px; }
    input, button { width: 100%; box-sizing: border-box; padding: 10px 12px; margin-top: 6px; border-radius: 8px; border: 1px solid var(--line); background: #0d1218; color: var(--text); }
    button.primary { background: #2563eb; color: #fff; border: none; font-weight: 600; cursor: pointer; }
    button.primary:disabled { opacity: 0.45; cursor: not-allowed; }
    pre { background: #070b10; border: 1px solid var(--line); color: #cbd5e1; padding: 14px; border-radius: 8px; overflow: auto; font-size: 11px; line-height: 1.45; max-height: 480px; margin: 8px 0 0; }
    .row { display: flex; align-items: center; gap: 10px; margin-top: 12px; flex-wrap: wrap; }
    .row label { margin: 0; display: flex; align-items: center; gap: 8px; }
    .muted { color: var(--muted); font-size: 0.9rem; }
    .warn { color: var(--err); font-size: 0.9rem; }
    h2 { font-size: 1rem; margin: 0 0 8px; color: var(--muted); font-weight: 600; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Ivan-alt — один клик: юзер, интересы, карточки → LLM</h1>
    <p class="muted">API: <code id="apiBase"></code> · <code>POST …/test-run</code> с заголовком <code>X-Ivan-Alt-Test-Secret</code></p>
    <p id="noSecret" class="warn" style="display:none">На сервере не задан <code>IVAN_ALT_TEST_SECRET</code> — endpoint отключён.</p>

    <div class="card">
      <label>Секрет (как в .env <code>IVAN_ALT_TEST_SECRET</code>)</label>
      <input type="password" id="secret" autocomplete="off" placeholder="вставьте секрет" />
      <div class="row">
        <label><input type="checkbox" id="skipLlm" /> skipLlm — без вызова нейросети (черновик)</label>
      </div>
      <br/>
      <button class="primary" type="button" id="go">Запустить тест</button>
    </div>

    <div class="card">
      <h2>Вход в модель (system + user + JSON контекст)</h2>
      <pre id="inp">{}</pre>
    </div>
    <div class="card">
      <h2>Ответ (setup + результат генерации)</h2>
      <pre id="out">{}</pre>
    </div>
  </div>
  <script>
    const API_ROOT = __API_MOUNT__;
    const SECRET_OK = __TEST_SECRET_CONFIGURED__;
    document.getElementById('apiBase').textContent = API_ROOT;
    if (!SECRET_OK) document.getElementById('noSecret').style.display = 'block';

    document.getElementById('go').onclick = async () => {
      const btn = document.getElementById('go');
      const secret = document.getElementById('secret').value.trim();
      document.getElementById('inp').textContent = '…';
      document.getElementById('out').textContent = '…';
      if (!SECRET_OK) {
        alert('Сервер без IVAN_ALT_TEST_SECRET');
        return;
      }
      if (!secret) {
        alert('Нужен секрет');
        return;
      }
      btn.disabled = true;
      const q = new URLSearchParams();
      if (document.getElementById('skipLlm').checked) q.set('skipLlm', 'true');
      try {
        const res = await fetch(API_ROOT + '/ivan-alt/local-routes/test-run?' + q.toString(), {
          method: 'POST',
          headers: { 'X-Ivan-Alt-Test-Secret': secret },
        });
        const data = await res.json().catch(() => ({}));
        const llmIn = data.llmInput || {};
        document.getElementById('inp').textContent = JSON.stringify(llmIn, null, 2);
        document.getElementById('out').textContent = JSON.stringify(data, null, 2);
        if (!res.ok) {
          document.getElementById('out').textContent = JSON.stringify({ status: res.status, body: data }, null, 2);
          document.getElementById('inp').textContent = '{}';
        }
      } catch (e) {
        document.getElementById('out').textContent = String(e);
        document.getElementById('inp').textContent = '{}';
      }
      btn.disabled = false;
    };
  </script>
</body>
</html>
"""


@router.get(
    "/local-routes/panel",
    include_in_schema=False,
    summary="HTML-панель для теста LLM-маршрута",
)
async def ivan_alt_local_route_panel():
    html = _IVAN_ALT_PANEL_HTML.replace(
        "__API_MOUNT__",
        json.dumps(settings.api_mount_path.rstrip("/")),
    )
    return HTMLResponse(content=html)


@router.get(
    "/local-routes/test-panel",
    include_in_schema=False,
    summary="HTML: один клик — сценарий + инпут/аутпут LLM",
)
async def ivan_alt_test_panel():
    html = (
        _IVAN_ALT_TEST_PANEL_HTML.replace(
            "__API_MOUNT__",
            json.dumps(settings.api_mount_path.rstrip("/")),
        ).replace(
            "__TEST_SECRET_CONFIGURED__",
            "true" if settings.IVAN_ALT_TEST_SECRET else "false",
        )
    )
    return HTMLResponse(content=html)


@router.post(
    "/local-routes/test-run",
    include_in_schema=False,
    summary="E2E: создать юзера, интересы, посты, вызвать генерацию (только с секретом)",
)
async def ivan_alt_test_run(
    skip_llm: bool = Query(False, alias="skipLlm"),
    x_ivan_alt_test_secret: str | None = Header(None, alias="X-Ivan-Alt-Test-Secret"),
    db: AsyncSession = Depends(get_db_session),
) -> dict[str, Any]:
    if not settings.IVAN_ALT_TEST_SECRET or x_ivan_alt_test_secret != settings.IVAN_ALT_TEST_SECRET:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Not Found")

    suffix = uuid.uuid4().hex[:10]
    phone = f"+7900e2e{suffix}"
    user = await get_or_create_user(db, phone=phone)

    social = SocialService(db)
    post_svc = PostService(db)

    intr_a = await social.create_interest(f"E2E парк [{suffix}]", "🌳")
    intr_b = await social.create_interest(f"E2E музей [{suffix}]", "🏛")
    await social.add_interests_to_user(user=user, interest_ids=[intr_a.id, intr_b.id])
    await social.set_interest_weight_for_user(user=user, interest_id=intr_a.id, weight=10)
    await social.set_interest_weight_for_user(user=user, interest_id=intr_b.id, weight=5)

    start_lat, start_lng = 45.0355, 38.9753
    p1 = await post_svc.create_post(
        author=user,
        title=f"E2E место А [{suffix}]",
        city="Краснодар",
        description="Авто-тест Ivan-alt: парк",
        geo_lat=45.03565,
        geo_lng=38.97545,
        season=Season.spring,
        interest_ids=[intr_a.id, intr_b.id],
    )
    p2 = await post_svc.create_post(
        author=user,
        title=f"E2E место Б [{suffix}]",
        city="Краснодар",
        description="Авто-тест Ivan-alt: музей",
        geo_lat=45.03535,
        geo_lng=38.97515,
        season=Season.spring,
        interest_ids=[intr_a.id, intr_b.id],
    )

    route_svc = IvanAltLocalRouteService(db)
    pairs = [(intr_a.id, 10), (intr_b.id, 5)]
    try:
        result, _saved = await route_svc.build_and_maybe_save(
            user=user,
            start_lat=start_lat,
            start_lng=start_lng,
            start_label="E2E старт",
            n=2,
            interest_weights=pairs,
            bbox_delta_degrees=0.08,
            save=False,
            skip_llm=skip_llm,
            include_trace=True,
        )
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e)) from e

    llm_input = result.trace or {}
    gen_body: dict[str, Any] = {
        "routeTitle": result.route_title,
        "intro": result.intro,
        "candidateIds": result.candidate_ids,
        "stops": result.stops,
        "warnings": result.warnings,
        "usedLlm": result.used_llm,
    }
    setup = {
        "phone": phone,
        "userId": user.id,
        "interestIds": [intr_a.id, intr_b.id],
        "interestNames": [intr_a.name, intr_b.name],
        "postIds": [p1.id, p2.id],
        "startLat": start_lat,
        "startLng": start_lng,
        "bboxDeltaDegrees": 0.08,
        "interestWeights": [{"interestId": intr_a.id, "weight": 10}, {"interestId": intr_b.id, "weight": 5}],
    }
    return {
        "setup": setup,
        "llmInput": llm_input,
        "generateResult": gen_body,
    }


@router.post(
    "/local-routes/generate",
    status_code=status.HTTP_200_OK,
    summary="Сгенерировать локальный маршрут (LLM, ivan-alt)",
    description=(
        "Топ-N мест рядом с точкой А по весам интересов → LLM строит порядок и подписи. "
        "Точка А только гео, не пост. При save=true сохраняется в user_saved_routes с aiGenerated."
    ),
    response_model=None,
)
async def ivan_alt_generate_local_route(
    body: IvanAltLocalRouteGenerateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
) -> dict[str, Any]:
    svc = IvanAltLocalRouteService(db)
    pairs = [(x.interestId, x.weight) for x in body.interestWeights]
    try:
        result, saved_id = await svc.build_and_maybe_save(
            user=current_user,
            start_lat=body.startLat,
            start_lng=body.startLng,
            start_label=body.startLabel,
            n=body.n,
            interest_weights=pairs,
            bbox_delta_degrees=body.bboxDeltaDegrees,
            save=body.save,
            skip_llm=body.skipLlm,
        )
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e)) from e

    out: dict[str, Any] = {
        "routeTitle": result.route_title,
        "intro": result.intro,
        "candidateIds": result.candidate_ids,
        "stops": result.stops,
        "warnings": result.warnings,
        "usedLlm": result.used_llm,
    }
    if saved_id is not None:
        out["savedRouteId"] = saved_id
    return out
