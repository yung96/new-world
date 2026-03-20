async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


async def _create_post(client, headers: dict[str, str], title: str) -> int:
    resp = await client.post(
        "/api/user/posts",
        json={
            "mediaUrls": [],
            "title": title,
            "description": "Описание",
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [],
            "tags": ["fav"],
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_user_favorites_add_list_remove_cycle(client):
    creator_headers = await _auth_headers(client, "+79000000001")
    user_headers = await _auth_headers(client, "+79000000002")
    post_id = await _create_post(client, creator_headers, "Favorite target")

    add_resp = await client.post(f"/api/user/favorites/{post_id}", headers=user_headers)
    assert add_resp.status_code == 204

    list_resp = await client.get("/api/user/favorites", headers=user_headers)
    assert list_resp.status_code == 200
    items = list_resp.json()["items"]
    assert any(item["id"] == post_id for item in items)
    target = next(item for item in items if item["id"] == post_id)
    assert "authorId" not in target
    assert "author" not in target

    remove_resp = await client.delete(
        f"/api/user/favorites/{post_id}", headers=user_headers
    )
    assert remove_resp.status_code == 204

    list_after_remove = await client.get("/api/user/favorites", headers=user_headers)
    assert list_after_remove.status_code == 200
    assert all(item["id"] != post_id for item in list_after_remove.json()["items"])


async def test_user_favorites_requires_auth(client):
    resp = await client.get("/api/user/favorites")
    assert resp.status_code == 401

