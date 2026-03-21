from app.models.post import Season


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


async def _create_post(
    client, headers: dict[str, str], *, title: str = "Тестовый пост"
) -> int:
    resp = await client.post(
        "/api/user/posts",
        json={
            "mediaUrls": [],
            "title": title,
            "city": "Сочи",
            "description": "Описание",
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [],
            "season": Season.summer.value,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_post_create_and_delete_cycle(client):
    creator_headers = await _auth_headers(client, "+70000000001")

    interest_resp = await client.post(
        "/api/interests", json={"name": "Пешие маршруты"}, headers=creator_headers
    )
    assert interest_resp.status_code == 201
    interest_id = interest_resp.json()["id"]

    create_resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": ["/api/uploads/x1.jpg"],
            "title": "Тестовый пост",
            "city": "Сочи",
            "description": "Описание",
            "geoLat": 55.7961,
            "geoLng": 49.1064,
            "interestIds": [interest_id],
            "season": Season.summer.value,
        },
        headers=creator_headers,
    )
    assert create_resp.status_code == 201
    post = create_resp.json()
    assert post["title"] == "Тестовый пост"
    assert interest_id in post["interestIds"]
    assert post["geoLat"] == 55.7961
    assert post["geoLng"] == 49.1064
    assert "authorId" not in post
    assert "author" not in post
    post_id = post["id"]

    get_resp = await client.get(f"/api/posts/{post_id}")
    assert get_resp.status_code == 200
    assert get_resp.json()["id"] == post_id
    assert "authorId" not in get_resp.json()
    assert "author" not in get_resp.json()

    list_resp = await client.get("/api/posts")
    assert list_resp.status_code == 200
    payload = list_resp.json()
    assert payload["total"] >= 1
    assert any(item["id"] == post_id for item in payload["items"])
    post_from_list = next(item for item in payload["items"] if item["id"] == post_id)
    assert "authorId" not in post_from_list
    assert "author" not in post_from_list

    delete_resp = await client.delete(f"/api/posts/{post_id}")
    assert delete_resp.status_code == 204

    get_deleted_resp = await client.get(f"/api/posts/{post_id}")
    assert get_deleted_resp.status_code == 404


async def test_post_create_requires_auth(client):
    resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": [],
            "title": "Без токена",
            "city": "Сочи",
            "description": None,
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [],
            "season": Season.winter.value,
        },
    )
    assert resp.status_code == 401


async def test_post_create_invalid_coordinates_returns_422(client):
    headers = await _auth_headers(client, "+70000000004")
    resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": [],
            "title": "Неверные координаты",
            "city": "Сочи",
            "description": None,
            "geoLat": 100.0,
            "geoLng": 200.0,
            "interestIds": [],
            "season": Season.spring.value,
        },
        headers=headers,
    )
    assert resp.status_code == 422


async def test_post_create_with_missing_interest_returns_404(client):
    headers = await _auth_headers(client, "+70000000005")
    resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": [],
            "title": "С несуществующим интересом",
            "city": "Сочи",
            "description": None,
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [999999],
            "season": Season.autumn.value,
        },
        headers=headers,
    )
    assert resp.status_code == 404


async def test_post_update_is_open_for_mvp(client):
    creator_headers = await _auth_headers(client, "+70000000006")
    post_id = await _create_post(client, creator_headers, title="Чужой пост")

    resp = await client.patch(
        f"/api/posts/{post_id}",
        json={"title": "Попытка взлома"},
    )
    assert resp.status_code == 200
    assert resp.json()["title"] == "Попытка взлома"


async def test_post_delete_is_open_for_mvp(client):
    creator_headers = await _auth_headers(client, "+70000000008")
    post_id = await _create_post(client, creator_headers)

    resp = await client.delete(f"/api/posts/{post_id}")
    assert resp.status_code == 204


async def test_post_interest_add_remove_cycle_open_for_mvp(client):
    headers = await _auth_headers(client, "+70000000012")
    interest_resp = await client.post(
        "/api/interests", json={"name": "Архитектура"}, headers=headers
    )
    assert interest_resp.status_code == 201
    interest_id = interest_resp.json()["id"]
    post_id = await _create_post(client, headers)

    add_resp = await client.post(f"/api/posts/{post_id}/interests/{interest_id}")
    assert add_resp.status_code == 200
    assert interest_id in add_resp.json()["interestIds"]

    remove_resp = await client.delete(f"/api/posts/{post_id}/interests/{interest_id}")
    assert remove_resp.status_code == 200
    assert interest_id not in remove_resp.json()["interestIds"]


async def test_posts_average_rating_is_calculated(client):
    creator_headers = await _auth_headers(client, "+70000000013")
    reviewer1_headers = await _auth_headers(client, "+70000000014")
    reviewer2_headers = await _auth_headers(client, "+70000000015")
    post_id = await _create_post(client, creator_headers, title="Пост с оценками")

    r1 = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 5, "comment": "super", "mediaUrls": []},
        headers=reviewer1_headers,
    )
    assert r1.status_code == 201
    r2 = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 3, "comment": "ok", "mediaUrls": []},
        headers=reviewer2_headers,
    )
    assert r2.status_code == 201

    get_resp = await client.get(f"/api/posts/{post_id}")
    assert get_resp.status_code == 200
    assert get_resp.json()["averageRating"] == 4.0

    list_resp = await client.get("/api/posts")
    assert list_resp.status_code == 200
    items = list_resp.json()["items"]
    target = next(item for item in items if item["id"] == post_id)
    assert target["averageRating"] == 4.0
