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
            "title": title,
            "description": None,
            "geoLat": None,
            "geoLng": None,
            "interestIds": [],
            "season": Season.winter.value,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_subscription_feed_shows_reviews_from_followed_only(client):
    post_author_h, _ = await _auth_headers(client, "+70000000070")
    reviewer_h, reviewer_id = await _auth_headers(client, "+70000000071")
    subscriber_h, _ = await _auth_headers(client, "+70000000072")
    stranger_h, _ = await _auth_headers(client, "+70000000073")

    post_id = await _create_post(client, post_author_h, title="Музей А")

    sub = await client.post(
        "/api/subscriptions",
        json={"targetUserId": reviewer_id},
        headers=subscriber_h,
    )
    assert sub.status_code == 201

    rev = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 4, "comment": "Интересно", "mediaUrls": []},
        headers=reviewer_h,
    )
    assert rev.status_code == 201
    review_id = rev.json()["id"]

    feed_sub = await client.get("/api/user/subscriptions/feed", headers=subscriber_h)
    assert feed_sub.status_code == 200
    payload_sub = feed_sub.json()
    assert payload_sub["total"] >= 1
    ids = [it["id"] for it in payload_sub["items"]]
    assert review_id in ids
    item = next(it for it in payload_sub["items"] if it["id"] == review_id)
    assert item["postId"] == post_id
    assert item["postTitle"] == "Музей А"
    assert item["postCity"] == "Казань"
    assert item["authorId"] == reviewer_id

    feed_stranger = await client.get("/api/user/subscriptions/feed", headers=stranger_h)
    assert feed_stranger.status_code == 200
    assert review_id not in [it["id"] for it in feed_stranger.json()["items"]]

    unsub = await client.delete(f"/api/subscriptions/{reviewer_id}", headers=subscriber_h)
    assert unsub.status_code == 204

    feed_after = await client.get("/api/user/subscriptions/feed", headers=subscriber_h)
    assert feed_after.status_code == 200
    assert review_id not in [it["id"] for it in feed_after.json()["items"]]


async def test_subscription_feed_chronological_order(client):
    author_h, _ = await _auth_headers(client, "+70000000074")
    reviewer_h, reviewer_id = await _auth_headers(client, "+70000000075")
    follower_h, _ = await _auth_headers(client, "+70000000076")

    assert (
        await client.post(
            "/api/subscriptions",
            json={"targetUserId": reviewer_id},
            headers=follower_h,
        )
    ).status_code == 201

    post_a = await _create_post(client, author_h, title="А раньше")
    post_b = await _create_post(client, author_h, title="Б позже")

    r1 = await client.post(
        f"/api/posts/{post_a}/reviews",
        json={"rating": 3, "comment": "Первый", "mediaUrls": []},
        headers=reviewer_h,
    )
    assert r1.status_code == 201
    id_first = r1.json()["id"]

    r2 = await client.post(
        f"/api/posts/{post_b}/reviews",
        json={"rating": 5, "comment": "Второй", "mediaUrls": []},
        headers=reviewer_h,
    )
    assert r2.status_code == 201
    id_second = r2.json()["id"]

    feed = await client.get("/api/user/subscriptions/feed?page=1&pageSize=10", headers=follower_h)
    assert feed.status_code == 200
    items = feed.json()["items"]
    # Новее отзыв — первый в ленте
    ours = [it for it in items if it["id"] in (id_first, id_second)]
    assert len(ours) == 2
    assert ours[0]["id"] == id_second
    assert ours[1]["id"] == id_first
