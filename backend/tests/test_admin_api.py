def _admin_headers() -> dict[str, str]:
    return {"X-Admin-Key": "dev-admin-key"}


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    return {"Authorization": f"Bearer {resp.json()['access_token']}"}


async def test_admin_dashboard_requires_key(client):
    resp = await client.get("/api/admin/dashboard")
    assert resp.status_code == 401


async def test_admin_can_edit_post_and_interest_set(client):
    user_headers = await _auth_headers(client, "+79990000001")
    create_interest = await client.post(
        "/api/interests",
        json={"name": "Старый интерес"},
        headers=user_headers,
    )
    assert create_interest.status_code == 201
    interest_id = create_interest.json()["id"]

    post_resp = await client.post(
        "/api/user/posts",
        json={
            "mediaUrls": [],
            "title": "Старое место",
            "description": "старое описание",
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [interest_id],
            "tags": ["old"],
        },
        headers=user_headers,
    )
    assert post_resp.status_code == 201
    post_id = post_resp.json()["id"]

    create_interest2 = await client.post(
        "/api/admin/interests",
        json={"name": "Новый интерес"},
        headers=_admin_headers(),
    )
    assert create_interest2.status_code == 200
    new_interest_id = create_interest2.json()["id"]

    patch_resp = await client.patch(
        f"/api/admin/posts/{post_id}",
        json={
            "title": "Новое место",
            "description": "описание admin",
            "interestIds": [new_interest_id],
            "tags": ["edited"],
        },
        headers=_admin_headers(),
    )
    assert patch_resp.status_code == 200
    payload = patch_resp.json()
    assert payload["title"] == "Новое место"
    assert payload["interestIds"] == [new_interest_id]


async def test_admin_can_rename_interest(client):
    user_headers = await _auth_headers(client, "+79990000002")
    create_interest = await client.post(
        "/api/interests",
        json={"name": "Переименовать"},
        headers=user_headers,
    )
    assert create_interest.status_code == 201
    interest_id = create_interest.json()["id"]

    patch_resp = await client.patch(
        f"/api/admin/interests/{interest_id}",
        json={"name": "Переименовано"},
        headers=_admin_headers(),
    )
    assert patch_resp.status_code == 200
    assert patch_resp.json()["name"] == "Переименовано"

