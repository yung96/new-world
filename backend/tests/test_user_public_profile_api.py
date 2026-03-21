from app.models.post import Season


async def _auth_headers(client, phone: str) -> tuple[dict[str, str], int]:
    login_resp = await client.post("/api/auth", json={"phone": phone})
    assert login_resp.status_code == 200
    token = login_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    me_resp = await client.get("/api/users/me", headers=headers)
    assert me_resp.status_code == 200
    return headers, me_resp.json()["id"]


async def _create_post(client, headers: dict[str, str], *, title: str = "Место") -> int:
    resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": [],
            "title": title,
            "city": "Самара",
            "description": None,
            "geoLat": None,
            "geoLng": None,
            "interestIds": [],
            "season": Season.summer.value,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_public_profile_followers_count_and_reviews(client):
    author_h, author_id = await _auth_headers(client, "+70000000080")
    reviewer_h, reviewer_id = await _auth_headers(client, "+70000000081")
    follower_h, _ = await _auth_headers(client, "+70000000082")

    post_id = await _create_post(client, author_h, title="Парк")

    assert (
        await client.post(
            "/api/subscriptions",
            json={"targetUserId": reviewer_id},
            headers=follower_h,
        )
    ).status_code == 201

    rev = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 5, "comment": "Класс", "mediaUrls": []},
        headers=reviewer_h,
    )
    assert rev.status_code == 201
    review_id = rev.json()["id"]

    prof = await client.get(f"/api/users/{reviewer_id}")
    assert prof.status_code == 200
    data = prof.json()
    assert "achievements" in data
    assert isinstance(data["achievements"], list)
    assert data["id"] == reviewer_id
    assert data["followersCount"] == 1
    assert data["total"] >= 1
    assert any(r["id"] == review_id for r in data["reviews"])
    r0 = next(r for r in data["reviews"] if r["id"] == review_id)
    assert r0["postId"] == post_id
    assert r0["postTitle"] == "Парк"
    assert r0["postCity"] == "Самара"

    # без токена
    prof2 = await client.get(f"/api/users/{author_id}")
    assert prof2.status_code == 200
    assert prof2.json()["followersCount"] == 0


async def test_public_profile_unknown_user_404(client):
    resp = await client.get("/api/users/999999")
    assert resp.status_code == 404


async def test_public_profile_reviews_pagination(client):
    headers, uid = await _auth_headers(client, "+70000000083")
    post_id = await _create_post(client, headers, title="Один пост")

    for i in range(3):
        r = await client.post(
            f"/api/posts/{post_id}/reviews",
            json={"rating": 4, "comment": f"R{i}", "mediaUrls": []},
            headers=headers,
        )
        assert r.status_code == 201

    p1 = await client.get(f"/api/users/{uid}?page=1&pageSize=2")
    assert p1.status_code == 200
    assert "achievements" in p1.json()
    assert p1.json()["total"] == 3
    assert len(p1.json()["reviews"]) == 2

    p2 = await client.get(f"/api/users/{uid}?page=2&pageSize=2")
    assert p2.status_code == 200
    assert len(p2.json()["reviews"]) == 1
