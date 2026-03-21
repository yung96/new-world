import json
from typing import Any

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.responses import HTMLResponse
from pydantic import Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.api.base_schema import BasePydanticModel
from app.core.config import settings
from app.core.dependencies import get_db_session
from app.models.user import User
from app.services.ivan_alt_local_route_service import IvanAltLocalRouteService

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
