from app.models.post import Season


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


async def _create_post(client, headers: dict[str, str]) -> int:
    resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": [],
            "title": "Пост под отзыв",
            "description": None,
            "geoLat": None,
            "geoLng": None,
            "interestIds": [],
            "season": "winter",
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_review_create_and_delete_cycle(client):
    author_headers = await _auth_headers(client, "+70000000002")
    reviewer_headers = await _auth_headers(client, "+70000000003")
    post_id = await _create_post(client, author_headers)

    create_resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={
            "rating": 5,
            "comment": "Отличное место",
            "mediaUrls": ["/api/uploads/r1.jpg"],
        },
        headers=reviewer_headers,
    )
    assert create_resp.status_code == 201
    review = create_resp.json()
    assert review["rating"] == 5
    review_id = review["id"]

    list_resp = await client.get(f"/api/posts/{post_id}/reviews")
    assert list_resp.status_code == 200
    payload = list_resp.json()
    assert payload["total"] == 1
    assert any(item["id"] == review_id for item in payload["items"])

    delete_resp = await client.delete(
        f"/api/reviews/{review_id}", headers=reviewer_headers
    )
    assert delete_resp.status_code == 204

    list_after_delete = await client.get(f"/api/posts/{post_id}/reviews")
    assert list_after_delete.status_code == 200
    assert all(item["id"] != review_id for item in list_after_delete.json()["items"])


async def test_review_create_requires_auth(client):
    author_headers = await _auth_headers(client, "+70000000040")
    post_id = await _create_post(client, author_headers)
    resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 4, "comment": "ok", "mediaUrls": []},
    )
    assert resp.status_code == 401


async def test_review_rating_out_of_range_returns_422(client):
    author_headers = await _auth_headers(client, "+70000000041")
    reviewer_headers = await _auth_headers(client, "+70000000042")
    post_id = await _create_post(client, author_headers)
    resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 10, "comment": "bad", "mediaUrls": []},
        headers=reviewer_headers,
    )
    assert resp.status_code == 422


async def test_review_create_for_missing_post_returns_404(client):
    reviewer_headers = await _auth_headers(client, "+70000000043")
    resp = await client.post(
        "/api/posts/999999/reviews",
        json={"rating": 5, "comment": "x", "mediaUrls": []},
        headers=reviewer_headers,
    )
    assert resp.status_code == 404


async def test_review_delete_by_non_author_returns_403(client):
    author_headers = await _auth_headers(client, "+70000000044")
    reviewer_headers = await _auth_headers(client, "+70000000045")
    another_user_headers = await _auth_headers(client, "+70000000046")
    post_id = await _create_post(client, author_headers)

    create_resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 5, "comment": "Отлично", "mediaUrls": []},
        headers=reviewer_headers,
    )
    assert create_resp.status_code == 201
    review_id = create_resp.json()["id"]

    delete_resp = await client.delete(
        f"/api/reviews/{review_id}", headers=another_user_headers
    )
    assert delete_resp.status_code == 403


async def test_reviews_pagination(client):
    author_headers = await _auth_headers(client, "+70000000047")
    reviewer_headers = await _auth_headers(client, "+70000000048")
    post_id = await _create_post(client, author_headers)

    for i in range(3):
        resp = await client.post(
            f"/api/posts/{post_id}/reviews",
            json={"rating": 5, "comment": f"c{i}", "mediaUrls": []},
            headers=reviewer_headers,
        )
        assert resp.status_code == 201

    page1 = await client.get(f"/api/posts/{post_id}/reviews?page=1&pageSize=2")
    assert page1.status_code == 200
    p1 = page1.json()
    assert p1["total"] == 3
    assert len(p1["items"]) == 2

    page2 = await client.get(f"/api/posts/{post_id}/reviews?page=2&pageSize=2")
    assert page2.status_code == 200
    p2 = page2.json()
    assert p2["total"] == 3
    assert len(p2["items"]) == 1
async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    token = resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


async def _create_post(client, headers: dict[str, str]) -> int:
    resp = await client.post(
        "/api/posts",
        json={
            "mediaUrls": [],
            "title": "Пост под отзыв",
            "description": None,
            "geoLat": None,
            "geoLng": None,
            "interestIds": [],
            "season": Season.winter,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_review_create_and_delete_cycle(client):
    author_headers = await _auth_headers(client, "+70000000002")
    reviewer_headers = await _auth_headers(client, "+70000000003")
    post_id = await _create_post(client, author_headers)

    create_resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 5, "comment": "Отличное место", "mediaUrls": ["/api/uploads/r1.jpg"]},
        headers=reviewer_headers,
    )
    assert create_resp.status_code == 201
    review = create_resp.json()
    assert review["rating"] == 5
    review_id = review["id"]

    list_resp = await client.get(f"/api/posts/{post_id}/reviews")
    assert list_resp.status_code == 200
    payload = list_resp.json()
    assert payload["total"] == 1
    assert any(item["id"] == review_id for item in payload["items"])

    delete_resp = await client.delete(f"/api/reviews/{review_id}", headers=reviewer_headers)
    assert delete_resp.status_code == 204

    list_after_delete = await client.get(f"/api/posts/{post_id}/reviews")
    assert list_after_delete.status_code == 200
    assert all(item["id"] != review_id for item in list_after_delete.json()["items"])


async def test_review_create_requires_auth(client):
    author_headers = await _auth_headers(client, "+70000000040")
    post_id = await _create_post(client, author_headers)
    resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 4, "comment": "ok", "mediaUrls": []},
    )
    assert resp.status_code == 401


async def test_review_rating_out_of_range_returns_422(client):
    author_headers = await _auth_headers(client, "+70000000041")
    reviewer_headers = await _auth_headers(client, "+70000000042")
    post_id = await _create_post(client, author_headers)
    resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 10, "comment": "bad", "mediaUrls": []},
        headers=reviewer_headers,
    )
    assert resp.status_code == 422


async def test_review_create_for_missing_post_returns_404(client):
    reviewer_headers = await _auth_headers(client, "+70000000043")
    resp = await client.post(
        "/api/posts/999999/reviews",
        json={"rating": 5, "comment": "x", "mediaUrls": []},
        headers=reviewer_headers,
    )
    assert resp.status_code == 404


async def test_review_delete_by_non_author_returns_403(client):
    author_headers = await _auth_headers(client, "+70000000044")
    reviewer_headers = await _auth_headers(client, "+70000000045")
    another_user_headers = await _auth_headers(client, "+70000000046")
    post_id = await _create_post(client, author_headers)

    create_resp = await client.post(
        f"/api/posts/{post_id}/reviews",
        json={"rating": 5, "comment": "Отлично", "mediaUrls": []},
        headers=reviewer_headers,
    )
    assert create_resp.status_code == 201
    review_id = create_resp.json()["id"]

    delete_resp = await client.delete(f"/api/reviews/{review_id}", headers=another_user_headers)
    assert delete_resp.status_code == 403


async def test_reviews_pagination(client):
    author_headers = await _auth_headers(client, "+70000000047")
    reviewer_headers = await _auth_headers(client, "+70000000048")
    post_id = await _create_post(client, author_headers)

    for i in range(3):
        resp = await client.post(
            f"/api/posts/{post_id}/reviews",
            json={"rating": 5, "comment": f"c{i}", "mediaUrls": []},
            headers=reviewer_headers,
        )
        assert resp.status_code == 201

    page1 = await client.get(f"/api/posts/{post_id}/reviews?page=1&pageSize=2")
    assert page1.status_code == 200
    p1 = page1.json()
    assert p1["total"] == 3
    assert len(p1["items"]) == 2

    page2 = await client.get(f"/api/posts/{post_id}/reviews?page=2&pageSize=2")
    assert page2.status_code == 200
    p2 = page2.json()
    assert p2["total"] == 3
    assert len(p2["items"]) == 1
