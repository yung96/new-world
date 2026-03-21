from app.models.post import Season


async def _auth_headers(client, phone: str) -> tuple[dict[str, str], int]:
    login_resp = await client.post("/api/auth", json={"phone": phone})
    assert login_resp.status_code == 200
    token = login_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    me_resp = await client.get("/api/users/me", headers=headers)
    assert me_resp.status_code == 200
    return headers, me_resp.json()["id"]


async def _create_post_with_interest(
    client, headers: dict[str, str], interest_id: int, *, title: str = "Карточка"
) -> int:
    resp = await client.post(
        "/api/posts",
        json={
            "title": title,
            "description": None,
            "geoLat": None,
            "geoLng": None,
            "interestIds": [interest_id],
            "season": Season.spring.value,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_achievement_granted_after_n_distinct_posts(client):
    admin_interest = await client.post(
        "/api/interests",
        json={"name": "AchRuleInterest-1", "emoji": "🎯"},
        headers=(await _auth_headers(client, "+70000000090"))[0],
    )
    assert admin_interest.status_code == 201
    interest_id = admin_interest.json()["id"]

    ach = await client.post(
        "/api/admin/achievements",
        json={
            "name": "Два отзыва по интересу",
            "description": "Тест",
            "interestId": interest_id,
            "requiredDistinctPosts": 2,
        },
    )
    assert ach.status_code == 201
    ach_id = ach.json()["id"]

    user_h, user_id = await _auth_headers(client, "+70000000091")
    other_h, _ = await _auth_headers(client, "+70000000092")

    p1 = await _create_post_with_interest(client, other_h, interest_id, title="М1")
    p2 = await _create_post_with_interest(client, other_h, interest_id, title="М2")

    prog0 = await client.get("/api/users/me/achievements/progress", headers=user_h)
    assert prog0.status_code == 200
    row0 = next((x for x in prog0.json()["items"] if x["achievementId"] == ach_id), None)
    assert row0 is not None
    assert row0["currentCount"] == 0
    assert row0["unlocked"] is False

    r1 = await client.post(
        f"/api/posts/{p1}/reviews",
        json={"rating": 5, "comment": "А", "mediaUrls": []},
        headers=user_h,
    )
    assert r1.status_code == 201

    prog1 = await client.get("/api/users/me/achievements/progress", headers=user_h)
    row1 = next(x for x in prog1.json()["items"] if x["achievementId"] == ach_id)
    assert row1["currentCount"] == 1
    assert row1["unlocked"] is False

    prof_mid = await client.get(f"/api/users/{user_id}")
    assert prof_mid.status_code == 200
    assert not any(a["id"] == ach_id for a in prof_mid.json()["achievements"])

    r2 = await client.post(
        f"/api/posts/{p2}/reviews",
        json={"rating": 4, "comment": "Б", "mediaUrls": []},
        headers=user_h,
    )
    assert r2.status_code == 201

    prog2 = await client.get("/api/users/me/achievements/progress", headers=user_h)
    row2 = next(x for x in prog2.json()["items"] if x["achievementId"] == ach_id)
    assert row2["currentCount"] == 2
    assert row2["unlocked"] is True
    assert row2["earnedAt"] is not None

    prof = await client.get(f"/api/users/{user_id}")
    assert prof.status_code == 200
    assert any(a["id"] == ach_id for a in prof.json()["achievements"])


async def test_second_review_same_post_does_not_double_count(client):
    interest = await client.post(
        "/api/interests",
        json={"name": "AchRuleInterest-2", "emoji": "📌"},
        headers=(await _auth_headers(client, "+70000000093"))[0],
    )
    assert interest.status_code == 201
    iid = interest.json()["id"]

    acr = await client.post(
        "/api/admin/achievements",
        json={
            "name": "Один пост два отзыва",
            "interestId": iid,
            "requiredDistinctPosts": 2,
        },
    )
    assert acr.status_code == 201
    ach_id_dup = acr.json()["id"]

    u_h, uid = await _auth_headers(client, "+70000000094")
    o_h, _ = await _auth_headers(client, "+70000000095")
    p = await _create_post_with_interest(client, o_h, iid, title="Один")

    await client.post(
        f"/api/posts/{p}/reviews",
        json={"rating": 3, "comment": "1", "mediaUrls": []},
        headers=u_h,
    )
    await client.post(
        f"/api/posts/{p}/reviews",
        json={"rating": 3, "comment": "2", "mediaUrls": []},
        headers=u_h,
    )

    prog = await client.get("/api/users/me/achievements/progress", headers=u_h)
    row = next(x for x in prog.json()["items"] if x["achievementId"] == ach_id_dup)
    assert row["currentCount"] == 1


async def test_admin_duplicate_achievement_name_409(client):
    h, _ = await _auth_headers(client, "+70000000096")
    ir = await client.post("/api/interests", json={"name": "I-dup-ach", "emoji": "x"}, headers=h)
    iid = ir.json()["id"]
    first = await client.post(
        "/api/admin/achievements",
        json={"name": "UniqueNameX", "interestId": iid, "requiredDistinctPosts": 1},
    )
    assert first.status_code == 201
    second = await client.post(
        "/api/admin/achievements",
        json={"name": "UniqueNameX", "interestId": iid, "requiredDistinctPosts": 1},
    )
    assert second.status_code == 409
