from fastapi import status
from api_paths import api


# Пример: «я в Питере» как точка А (не пост)
SPB_LAT = 59.9343
SPB_LNG = 30.3351


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post(api("/auth"), json={"phone": phone})
    assert resp.status_code == 200
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


async def _create_post(client, headers: dict[str, str], title: str) -> int:
    resp = await client.post(
        api("/user/posts"),
        json={
            "mediaUrls": [],
            "title": title,
            "city": "Москва",
            "description": "Описание",
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [],
            "season": "spring",
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_user_route_create_list_get_patch_delete(client):
    h = await _auth_headers(client, "+79000000011")
    b = await _create_post(client, h, "Место B")
    c = await _create_post(client, h, "Место C")
    a_post = await _create_post(client, h, "Место A")

    create_resp = await client.post(
        api("/user/routes"),
        json={
            "title": "Прогулка",
            "startLat": SPB_LAT,
            "startLng": SPB_LNG,
            "startLabel": "Санкт-Петербург",
            "postIds": [b, c],
        },
        headers=h,
    )
    assert create_resp.status_code == 201
    body = create_resp.json()
    rid = body["id"]
    assert body["startLat"] == SPB_LAT
    assert body["startLng"] == SPB_LNG
    assert body["startLabel"] == "Санкт-Петербург"
    assert body["postIds"] == [b, c]
    assert len(body["posts"]) == 2
    assert body["posts"][0]["title"] == "Место B"
    assert body.get("aiGenerated") is False

    list_resp = await client.get(api("/user/routes"), headers=h)
    assert list_resp.status_code == 200
    assert list_resp.json()["total"] == 1

    one = await client.get(api(f"/user/routes/{rid}"), headers=h)
    assert one.status_code == 200
    assert one.json()["postIds"] == [b, c]

    patch_title = await client.patch(
        api(f"/user/routes/{rid}"),
        json={"title": "Новое имя"},
        headers=h,
    )
    assert patch_title.status_code == 200
    assert patch_title.json()["title"] == "Новое имя"
    assert patch_title.json()["postIds"] == [b, c]

    patch_chain = await client.patch(
        api(f"/user/routes/{rid}"),
        json={"postIds": [c, a_post]},
        headers=h,
    )
    assert patch_chain.status_code == 200
    assert patch_chain.json()["postIds"] == [c, a_post]

    dup = await client.post(
        api("/user/routes"),
        json={
            "startLat": SPB_LAT,
            "startLng": SPB_LNG,
            "postIds": [b, b],
        },
        headers=h,
    )
    assert dup.status_code == 422

    del_resp = await client.delete(api(f"/user/routes/{rid}"), headers=h)
    assert del_resp.status_code == 204

    missing = await client.get(api(f"/user/routes/{rid}"), headers=h)
    assert missing.status_code == 404


async def test_user_route_point_a_only_no_posts(client):
    h = await _auth_headers(client, "+79000000012")

    r = await client.post(
        api("/user/routes"),
        json={"startLat": SPB_LAT, "startLng": SPB_LNG, "postIds": []},
        headers=h,
    )
    assert r.status_code == 201
    data = r.json()
    assert data["postIds"] == []
    assert data["posts"] == []


async def test_user_route_requires_auth(client):
    resp = await client.get(api("/user/routes"))
    assert resp.status_code == 401


async def test_user_route_patch_geo_requires_both_coords(client):
    h = await _auth_headers(client, "+79000000013")
    cr = await client.post(
        api("/user/routes"),
        json={"startLat": 55.75, "startLng": 37.61, "postIds": []},
        headers=h,
    )
    rid = cr.json()["id"]

    bad = await client.patch(
        api(f"/user/routes/{rid}"),
        json={"startLat": 59.0},
        headers=h,
    )
    assert bad.status_code == 422
