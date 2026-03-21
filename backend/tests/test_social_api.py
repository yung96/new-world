async def _auth_headers(client, phone: str) -> tuple[dict[str, str], int]:
    login_resp = await client.post("/api/auth", json={"phone": phone})
    assert login_resp.status_code == 200
    token = login_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    me_resp = await client.get("/api/users/me", headers=headers)
    assert me_resp.status_code == 200
    return headers, me_resp.json()["id"]


async def test_interest_create_bind_unbind_delete_cycle(client):
    headers, _ = await _auth_headers(client, "+70000000010")

    create_resp = await client.post("/api/interests", json={"name": "Краеведение"}, headers=headers)
    assert create_resp.status_code == 201
    interest_id = create_resp.json()["id"]

    bind_resp = await client.post(f"/api/users/me/interests/{interest_id}", headers=headers)
    assert bind_resp.status_code == 200

    unbind_resp = await client.delete(f"/api/users/me/interests/{interest_id}", headers=headers)
    assert unbind_resp.status_code == 200

    delete_resp = await client.delete(f"/api/interests/{interest_id}", headers=headers)
    assert delete_resp.status_code == 204

    list_resp = await client.get("/api/interests", headers=headers)
    assert list_resp.status_code == 200
    assert list_resp.json()["total"] >= 0


async def test_achievement_create_bind_unbind_delete_cycle(client):
    headers, _ = await _auth_headers(client, "+70000000011")

    create_resp = await client.post(
        "/api/achievements",
        json={"name": "Покоритель маршрутов", "description": "Прошел 10 маршрутов"},
        headers=headers,
    )
    assert create_resp.status_code == 201
    achievement_id = create_resp.json()["id"]

    bind_resp = await client.post(f"/api/users/me/achievements/{achievement_id}", headers=headers)
    assert bind_resp.status_code == 200

    unbind_resp = await client.delete(f"/api/users/me/achievements/{achievement_id}", headers=headers)
    assert unbind_resp.status_code == 200

    delete_resp = await client.delete(f"/api/achievements/{achievement_id}", headers=headers)
    assert delete_resp.status_code == 204

    list_resp = await client.get("/api/achievements", headers=headers)
    assert list_resp.status_code == 200
    assert list_resp.json()["total"] >= 0


async def test_subscription_subscribe_list_unsubscribe_cycle(client):
    user1_headers, _user1_id = await _auth_headers(client, "+70000000020")
    _user2_headers, user2_id = await _auth_headers(client, "+70000000021")

    sub_resp = await client.post(
        "/api/subscriptions",
        json={"targetUserId": user2_id},
        headers=user1_headers,
    )
    assert sub_resp.status_code == 201

    list_resp = await client.get("/api/subscriptions", headers=user1_headers)
    assert list_resp.status_code == 200
    assert any(item["id"] == user2_id for item in list_resp.json()["items"])

    unsub_resp = await client.delete(f"/api/subscriptions/{user2_id}", headers=user1_headers)
    assert unsub_resp.status_code == 204

    after = await client.get("/api/subscriptions", headers=user1_headers)
    assert after.status_code == 200
    assert all(item["id"] != user2_id for item in after.json()["items"])


async def test_subscribe_to_self_returns_400(client):
    headers, user_id = await _auth_headers(client, "+70000000055")
    resp = await client.post("/api/subscriptions", json={"targetUserId": user_id}, headers=headers)
    assert resp.status_code == 400


async def test_subscribe_to_unknown_user_returns_404(client):
    headers, _ = await _auth_headers(client, "+70000000056")
    resp = await client.post("/api/subscriptions", json={"targetUserId": 999999}, headers=headers)
    assert resp.status_code == 404


async def test_duplicate_subscription_returns_409(client):
    user1_headers, _ = await _auth_headers(client, "+70000000057")
    _user2_headers, user2_id = await _auth_headers(client, "+70000000058")
    first = await client.post("/api/subscriptions", json={"targetUserId": user2_id}, headers=user1_headers)
    second = await client.post("/api/subscriptions", json={"targetUserId": user2_id}, headers=user1_headers)
    assert first.status_code == 201
    assert second.status_code == 409


async def test_interest_duplicate_name_returns_same_entity(client):
    headers, _ = await _auth_headers(client, "+70000000050")
    r1 = await client.post("/api/interests", json={"name": "Этнография"}, headers=headers)
    r2 = await client.post("/api/interests", json={"name": "Этнография"}, headers=headers)
    assert r1.status_code == 201
    assert r2.status_code == 201
    assert r1.json()["id"] == r2.json()["id"]


async def test_interest_empty_name_returns_400(client):
    headers, _ = await _auth_headers(client, "+70000000051")
    resp = await client.post("/api/interests", json={"name": "   "}, headers=headers)
    assert resp.status_code == 400


async def test_bind_unknown_interest_returns_404(client):
    headers, _ = await _auth_headers(client, "+70000000052")
    resp = await client.post("/api/users/me/interests/999999", headers=headers)
    assert resp.status_code == 404


async def test_achievement_duplicate_name_returns_same_entity(client):
    headers, _ = await _auth_headers(client, "+70000000053")
    r1 = await client.post("/api/achievements", json={"name": "Локальный гид"}, headers=headers)
    r2 = await client.post("/api/achievements", json={"name": "Локальный гид"}, headers=headers)
    assert r1.status_code == 201
    assert r2.status_code == 201
    assert r1.json()["id"] == r2.json()["id"]


async def test_achievement_empty_name_returns_400(client):
    headers, _ = await _auth_headers(client, "+70000000054")
    resp = await client.post("/api/achievements", json={"name": " "}, headers=headers)
    assert resp.status_code == 400


async def test_social_lists_pagination(client):
    headers, _ = await _auth_headers(client, "+70000000068")
    for idx in range(3):
        interest_resp = await client.post("/api/interests", json={"name": f"Interest-{idx}"}, headers=headers)
        assert interest_resp.status_code == 201
        ach_resp = await client.post("/api/achievements", json={"name": f"Ach-{idx}"}, headers=headers)
        assert ach_resp.status_code == 201

    i_page1 = await client.get("/api/interests?page=1&pageSize=2", headers=headers)
    assert i_page1.status_code == 200
    assert i_page1.json()["total"] >= 3
    assert len(i_page1.json()["items"]) == 2

    a_page2 = await client.get("/api/achievements?page=2&pageSize=2", headers=headers)
    assert a_page2.status_code == 200
    assert a_page2.json()["total"] >= 3
    assert len(a_page2.json()["items"]) >= 1
