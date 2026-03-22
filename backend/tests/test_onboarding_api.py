"""
Tests for /api/onboarding/* endpoints.

Covered:
- POST /api/onboarding/complete  — saves interest IDs for the authenticated user
- POST /api/onboarding/swipe     — records a swipe on a post (left or right)
- Auth guard                     — both endpoints return 401 without a token
"""

import pytest
from app.models.post import Season


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    return {"Authorization": f"Bearer {resp.json()['access_token']}"}


async def _create_interest(client, headers: dict[str, str], name: str = "Природа") -> int:
    resp = await client.post("/api/interests", json={"name": name}, headers=headers)
    assert resp.status_code == 201
    return resp.json()["id"]


async def _create_post(client, headers: dict[str, str], title: str = "Test Place") -> int:
    resp = await client.post(
        "/api/user/posts",
        json={
            "title": title,
            "description": "Test",
            "geoLat": 44.6,
            "geoLng": 37.5,
            "interestIds": [],
            "season": Season.summer.value,
        },
        headers=headers,
    )
    assert resp.status_code == 201
    return resp.json()["id"]


@pytest.mark.asyncio
async def test_onboarding_complete(client):
    """POST /api/onboarding/complete with valid interestIds returns ok=True and count > 0."""
    headers = await _auth_headers(client, "+79990000101")

    # Create an interest so we have a real ID to use
    interest_id = await _create_interest(client, headers, "Архитектура")

    resp = await client.post(
        "/api/onboarding/complete",
        json={"interestIds": [interest_id]},
        headers=headers,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert data["ok"] is True
    assert data["count"] == 1


@pytest.mark.asyncio
async def test_onboarding_complete_empty_interests(client):
    """POST /api/onboarding/complete with empty interestIds returns ok=True, count=0."""
    headers = await _auth_headers(client, "+79990000102")

    resp = await client.post(
        "/api/onboarding/complete",
        json={"interestIds": []},
        headers=headers,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert data["ok"] is True
    assert data["count"] == 0


@pytest.mark.asyncio
async def test_onboarding_complete_idempotent(client):
    """Calling /onboarding/complete twice with the same interest does not double-count."""
    headers = await _auth_headers(client, "+79990000103")
    interest_id = await _create_interest(client, headers, "Гастро")

    first = await client.post(
        "/api/onboarding/complete",
        json={"interestIds": [interest_id]},
        headers=headers,
    )
    assert first.status_code == 200
    assert first.json()["count"] == 1

    # Second call — interest already attached, count should be 0 new insertions
    second = await client.post(
        "/api/onboarding/complete",
        json={"interestIds": [interest_id]},
        headers=headers,
    )
    assert second.status_code == 200
    assert second.json()["ok"] is True
    assert second.json()["count"] == 0


@pytest.mark.asyncio
async def test_onboarding_swipe_right(client):
    """POST /api/onboarding/swipe with direction=right returns ok=True."""
    author_headers = await _auth_headers(client, "+79990000104")
    swiper_headers = await _auth_headers(client, "+79990000105")

    post_id = await _create_post(client, author_headers, "Swipe Place")

    resp = await client.post(
        "/api/onboarding/swipe",
        json={"postId": post_id, "direction": "right"},
        headers=swiper_headers,
    )
    assert resp.status_code == 200
    assert resp.json()["ok"] is True


@pytest.mark.asyncio
async def test_onboarding_swipe_left(client):
    """POST /api/onboarding/swipe with direction=left returns ok=True."""
    author_headers = await _auth_headers(client, "+79990000106")
    swiper_headers = await _auth_headers(client, "+79990000107")

    post_id = await _create_post(client, author_headers, "Left Swipe Place")

    resp = await client.post(
        "/api/onboarding/swipe",
        json={"postId": post_id, "direction": "left"},
        headers=swiper_headers,
    )
    assert resp.status_code == 200
    assert resp.json()["ok"] is True


@pytest.mark.asyncio
async def test_onboarding_swipe_nonexistent_post(client):
    """POST /api/onboarding/swipe with an unknown postId returns 404."""
    headers = await _auth_headers(client, "+79990000108")

    resp = await client.post(
        "/api/onboarding/swipe",
        json={"postId": 999999, "direction": "right"},
        headers=headers,
    )
    assert resp.status_code == 404


@pytest.mark.asyncio
async def test_onboarding_complete_requires_auth(client):
    """POST /api/onboarding/complete without a token returns 401."""
    resp = await client.post(
        "/api/onboarding/complete",
        json={"interestIds": []},
    )
    assert resp.status_code == 401


@pytest.mark.asyncio
async def test_onboarding_swipe_requires_auth(client):
    """POST /api/onboarding/swipe without a token returns 401."""
    resp = await client.post(
        "/api/onboarding/swipe",
        json={"postId": 1, "direction": "right"},
    )
    assert resp.status_code == 401
