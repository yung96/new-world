from api_paths import api


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post(api("/auth"), json={"phone": phone})
    assert resp.status_code == 200
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


async def test_ivan_alt_panel_returns_html(client):
    r = await client.get(api("/ivan-alt/local-routes/panel"))
    assert r.status_code == 200
    assert "text/html" in r.headers.get("content-type", "")
    assert "Ivan-alt" in r.text


async def test_ivan_alt_generate_requires_auth(client):
    r = await client.post(
        api("/ivan-alt/local-routes/generate"),
        json={
            "startLat": 55.75,
            "startLng": 37.61,
            "n": 2,
            "interestWeights": [{"interestId": 1, "weight": 2}],
            "skipLlm": True,
        },
    )
    assert r.status_code == 401


async def test_ivan_alt_generate_skip_llm_and_save(client):
    h = await _auth_headers(client, "+79000007701")

    ir = await client.post(api("/interests"), json={"name": "Иван-alt тест"}, headers=h)
    assert ir.status_code == 201
    iid = ir.json()["id"]

    pr = await client.post(
        api("/user/posts"),
        json={
            "mediaUrls": [],
            "title": "Точка маршрута 1",
            "city": "Москва",
            "description": "Описание",
            "geoLat": 55.751,
            "geoLng": 37.618,
            "interestIds": [iid],
            "season": "spring",
        },
        headers=h,
    )
    assert pr.status_code == 201
    p1 = pr.json()["id"]

    pr2 = await client.post(
        api("/user/posts"),
        json={
            "mediaUrls": [],
            "title": "Точка маршрута 2",
            "city": "Москва",
            "description": "Описание",
            "geoLat": 55.752,
            "geoLng": 37.619,
            "interestIds": [iid],
            "season": "spring",
        },
        headers=h,
    )
    assert pr2.status_code == 201
    p2 = pr2.json()["id"]

    gen = await client.post(
        api("/ivan-alt/local-routes/generate"),
        json={
            "startLat": 55.7515,
            "startLng": 37.6185,
            "startLabel": "Старт",
            "n": 2,
            "interestWeights": [{"interestId": iid, "weight": 5}],
            "bboxDeltaDegrees": 0.2,
            "save": True,
            "skipLlm": True,
        },
        headers=h,
    )
    assert gen.status_code == 200, gen.text
    body = gen.json()
    assert body["usedLlm"] is False
    assert set(body["candidateIds"]) == {p1, p2}
    assert len(body["stops"]) == 2
    assert "caption" in body["stops"][0]
    rid = body.get("savedRouteId")
    assert isinstance(rid, int)

    one = await client.get(api(f"/user/routes/{rid}"), headers=h)
    assert one.status_code == 200
    route = one.json()
    assert route["aiGenerated"] is True
    assert route["aiRouteMeta"] is not None
    assert route["aiRouteMeta"].get("usedLlm") is False
    assert route["title"] == body["routeTitle"]


async def test_ivan_alt_generate_unknown_interest_400(client):
    h = await _auth_headers(client, "+79000007702")
    r = await client.post(
        api("/ivan-alt/local-routes/generate"),
        json={
            "startLat": 55.75,
            "startLng": 37.61,
            "n": 1,
            "interestWeights": [{"interestId": 999999, "weight": 1}],
            "skipLlm": True,
        },
        headers=h,
    )
    assert r.status_code == 400
