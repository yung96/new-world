from app.models.post import Season


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
            "city": "Москва",
            "description": None,
            "geoLat": 55.75,
            "geoLng": 37.61,
            "interestIds": [],
            "season": Season.summer.value,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


async def test_swipe_right_adds_favorite_and_hides_swiped_card(client):
    author_headers = await _auth_headers(client, "+71110000001")
    swiper_headers = await _auth_headers(client, "+71110000002")

    first_id = await _create_post(client, author_headers, "Карточка 1")
    second_id = await _create_post(client, author_headers, "Карточка 2")
    all_ids = {first_id, second_id}

    next_resp = await client.get("/api/user/swipes/next", headers=swiper_headers)
    assert next_resp.status_code == 200
    first_card = next_resp.json()
    assert first_card["done"] is False
    swiped_id = first_card["post"]["id"]
    assert swiped_id in all_ids

    swipe_resp = await client.post(
        "/api/user/swipes",
        json={"postId": swiped_id, "direction": "right"},
        headers=swiper_headers,
    )
    assert swipe_resp.status_code == 200
    swipe_payload = swipe_resp.json()
    assert swipe_payload["alreadySwiped"] is False
    assert swipe_payload["addedToFavorites"] is True

    favorites = await client.get("/api/user/favorites", headers=swiper_headers)
    assert favorites.status_code == 200
    favorite_ids = {item["id"] for item in favorites.json()["items"]}
    assert swiped_id in favorite_ids

    next_after = await client.get("/api/user/swipes/next", headers=swiper_headers)
    assert next_after.status_code == 200
    payload = next_after.json()
    assert payload["done"] is False
    assert payload["post"]["id"] != swiped_id


async def test_swipe_left_does_not_add_favorite_and_returns_end_message(client):
    author_headers = await _auth_headers(client, "+71110000003")
    swiper_headers = await _auth_headers(client, "+71110000004")

    post_id = await _create_post(client, author_headers, "Одна карточка")

    next_resp = await client.get("/api/user/swipes/next", headers=swiper_headers)
    assert next_resp.status_code == 200
    assert next_resp.json()["post"]["id"] == post_id

    swipe_resp = await client.post(
        "/api/user/swipes",
        json={"postId": post_id, "direction": "left"},
        headers=swiper_headers,
    )
    assert swipe_resp.status_code == 200
    assert swipe_resp.json()["addedToFavorites"] is False

    favorites = await client.get("/api/user/favorites", headers=swiper_headers)
    assert favorites.status_code == 200
    assert favorites.json()["total"] == 0

    end_resp = await client.get("/api/user/swipes/next", headers=swiper_headers)
    assert end_resp.status_code == 200
    end_payload = end_resp.json()
    assert end_payload["done"] is True
    assert end_payload["message"] == "Карточки закончились"
    assert end_payload["post"] is None


async def test_swipe_is_idempotent_for_same_post(client):
    author_headers = await _auth_headers(client, "+71110000005")
    swiper_headers = await _auth_headers(client, "+71110000006")

    post_id = await _create_post(client, author_headers, "Idempotent")

    first = await client.post(
        "/api/user/swipes",
        json={"postId": post_id, "direction": "right"},
        headers=swiper_headers,
    )
    assert first.status_code == 200
    assert first.json()["alreadySwiped"] is False
    assert first.json()["addedToFavorites"] is True

    second = await client.post(
        "/api/user/swipes",
        json={"postId": post_id, "direction": "right"},
        headers=swiper_headers,
    )
    assert second.status_code == 200
    assert second.json()["alreadySwiped"] is True
    assert second.json()["addedToFavorites"] is False
