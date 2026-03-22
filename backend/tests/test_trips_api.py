"""
Tests for /api/trips/* place-detail endpoints.

Covered:
- GET /api/trips/place/{id}     — full place card with photos, reviews, nearby
- GET /api/trips/place/999999   — 404 for unknown place
- GET /api/trips/place/{id}/ai  — AI recommendation text (fallback path, no real GPT key)
"""

import pytest
from app.models.post import Season


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    return {"Authorization": f"Bearer {resp.json()['access_token']}"}


async def _create_post(client, headers: dict[str, str], title: str = "Test Place") -> int:
    resp = await client.post(
        "/api/user/posts",
        json={
            "title": title,
            "description": "A nice place to visit.",
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
async def test_trip_place_detail(client):
    """GET /api/trips/place/{id} returns a well-structured place card."""
    headers = await _auth_headers(client, "+79990000201")
    post_id = await _create_post(client, headers, "Black Sea Viewpoint")

    resp = await client.get(f"/api/trips/place/{post_id}")
    assert resp.status_code == 200

    data = resp.json()
    assert data["id"] == post_id
    assert data["title"] == "Black Sea Viewpoint"

    # Structural checks — all expected keys must be present
    assert "photos" in data
    assert isinstance(data["photos"], list)

    assert "reviews" in data
    assert isinstance(data["reviews"], list)

    assert "nearby" in data
    assert isinstance(data["nearby"], list)

    assert "rating" in data
    assert "avg" in data["rating"]
    assert "count" in data["rating"]

    assert "schedule" in data
    assert "interests" in data
    assert "season" in data


@pytest.mark.asyncio
async def test_trip_place_detail_has_correct_lat_lng(client):
    """Coordinates stored during creation are returned in the detail response."""
    headers = await _auth_headers(client, "+79990000202")
    post_id = await _create_post(client, headers, "Coordinate Test")

    resp = await client.get(f"/api/trips/place/{post_id}")
    assert resp.status_code == 200
    data = resp.json()
    assert data["lat"] == pytest.approx(44.6, abs=0.001)
    assert data["lng"] == pytest.approx(37.5, abs=0.001)


@pytest.mark.asyncio
async def test_trip_place_detail_nearby_excludes_self(client):
    """The nearby list must not contain the place itself."""
    headers = await _auth_headers(client, "+79990000203")
    post_id = await _create_post(client, headers, "Self-Exclusion Test")

    resp = await client.get(f"/api/trips/place/{post_id}")
    assert resp.status_code == 200

    nearby_ids = {p["id"] for p in resp.json()["nearby"]}
    assert post_id not in nearby_ids


@pytest.mark.asyncio
async def test_trip_place_404(client):
    """GET /api/trips/place/999999 returns 404 when the place does not exist."""
    resp = await client.get("/api/trips/place/999999")
    assert resp.status_code == 404
    assert "detail" in resp.json()


@pytest.mark.asyncio
async def test_trip_place_ai(client):
    """GET /api/trips/place/{id}/ai returns a recommendation text for the place."""
    headers = await _auth_headers(client, "+79990000204")
    post_id = await _create_post(client, headers, "AI Recommendation Test")

    resp = await client.get(f"/api/trips/place/{post_id}/ai")
    assert resp.status_code == 200

    data = resp.json()
    assert data["postId"] == post_id
    assert "title" in data
    assert "recommendation" in data

    # The fallback path is used in tests (no real GPT key).
    # The text must be a non-empty string.
    assert isinstance(data["recommendation"], str)
    assert len(data["recommendation"]) > 0


@pytest.mark.asyncio
async def test_trip_place_ai_404_for_unknown_place(client):
    """GET /api/trips/place/999999/ai returns 404 when the place does not exist."""
    resp = await client.get("/api/trips/place/999999/ai")
    assert resp.status_code == 404
