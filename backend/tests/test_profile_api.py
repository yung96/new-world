"""
Tests for /api/users/me/* profile endpoints.

Covered:
- POST /api/users/me/interests/{id}  — add interest to current user's profile
- GET  /api/users/me/interests       — returns the user's interests
- GET  /api/users/me/routes          — returns the user's AI-generated routes list
- PATCH /api/users/me {name: "..."}  — updates and returns the new name
- PATCH without token                — 401
"""

import pytest
from app.models.post import Season


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    return {"Authorization": f"Bearer {resp.json()['access_token']}"}


async def _create_interest(client, headers: dict[str, str], name: str) -> int:
    resp = await client.post("/api/interests", json={"name": name}, headers=headers)
    assert resp.status_code == 201
    return resp.json()["id"]


@pytest.mark.asyncio
async def test_my_interests_add_and_get(client):
    """POST /api/users/me/interests/{id} then GET /api/users/me/interests returns it."""
    headers = await _auth_headers(client, "+79990000301")

    # Create an interest to work with
    interest_id = await _create_interest(client, headers, "Экология")

    # Attach interest to current user's profile
    add_resp = await client.post(
        f"/api/users/me/interests/{interest_id}",
        headers=headers,
    )
    assert add_resp.status_code == 200

    # Retrieve the user's interests
    get_resp = await client.get("/api/users/me/interests", headers=headers)
    assert get_resp.status_code == 200

    data = get_resp.json()
    assert isinstance(data, list)
    interest_ids = [i["id"] for i in data]
    assert interest_id in interest_ids
    row = next(i for i in data if i["id"] == interest_id)
    assert "weight" in row
    assert isinstance(row["weight"], int)


@pytest.mark.asyncio
async def test_my_interests_empty_for_new_user(client):
    """A freshly created user has no interests attached."""
    headers = await _auth_headers(client, "+79990000302")

    resp = await client.get("/api/users/me/interests", headers=headers)
    assert resp.status_code == 200
    assert resp.json() == []


@pytest.mark.asyncio
async def test_my_interests_remove(client):
    """DELETE /api/users/me/interests/{id} detaches the interest."""
    headers = await _auth_headers(client, "+79990000303")
    interest_id = await _create_interest(client, headers, "Вино")

    # Attach first
    await client.post(f"/api/users/me/interests/{interest_id}", headers=headers)

    # Detach
    del_resp = await client.delete(
        f"/api/users/me/interests/{interest_id}",
        headers=headers,
    )
    assert del_resp.status_code == 200

    # Interest is gone from the list
    get_resp = await client.get("/api/users/me/interests", headers=headers)
    assert get_resp.status_code == 200
    interest_ids = [i["id"] for i in get_resp.json()]
    assert interest_id not in interest_ids


@pytest.mark.asyncio
async def test_my_routes_returns_list(client):
    """GET /api/users/me/routes returns a list (empty for a new user)."""
    headers = await _auth_headers(client, "+79990000304")

    resp = await client.get("/api/users/me/routes", headers=headers)
    assert resp.status_code == 200
    assert isinstance(resp.json(), list)


@pytest.mark.asyncio
async def test_my_routes_requires_auth(client):
    """GET /api/users/me/routes without a token returns 401."""
    resp = await client.get("/api/users/me/routes")
    assert resp.status_code == 401


@pytest.mark.asyncio
async def test_patch_me_updates_name(client):
    """PATCH /api/users/me {name: "Test"} returns the updated name."""
    headers = await _auth_headers(client, "+79990000305")

    resp = await client.patch(
        "/api/users/me",
        json={"name": "Test User"},
        headers=headers,
    )
    assert resp.status_code == 200

    data = resp.json()
    assert data["name"] == "Test User"
    assert "id" in data
    assert "phone" in data


@pytest.mark.asyncio
async def test_patch_me_updates_bio(client):
    """PATCH /api/users/me {bio: "..."} returns the updated bio."""
    headers = await _auth_headers(client, "+79990000306")

    resp = await client.patch(
        "/api/users/me",
        json={"bio": "Traveller from Krasnodar"},
        headers=headers,
    )
    assert resp.status_code == 200
    assert resp.json()["bio"] == "Traveller from Krasnodar"


@pytest.mark.asyncio
async def test_patch_me_ignores_unknown_fields(client):
    """PATCH /api/users/me with an unknown field does not raise an error."""
    headers = await _auth_headers(client, "+79990000307")

    resp = await client.patch(
        "/api/users/me",
        json={"name": "Safe", "unknown_field": "ignored"},
        headers=headers,
    )
    assert resp.status_code == 200
    assert resp.json()["name"] == "Safe"


@pytest.mark.asyncio
async def test_patch_me_requires_auth(client):
    """PATCH /api/users/me without a token returns 401."""
    resp = await client.patch(
        "/api/users/me",
        json={"name": "Hacker"},
    )
    assert resp.status_code == 401


@pytest.mark.asyncio
async def test_get_me_returns_profile(client):
    """GET /api/users/me returns the current user's id and phone."""
    headers = await _auth_headers(client, "+79990000308")

    resp = await client.get("/api/users/me", headers=headers)
    assert resp.status_code == 200
    data = resp.json()
    assert "id" in data
    assert "phone" in data
    assert data["phone"] == "+79990000308"


@pytest.mark.asyncio
async def test_get_me_requires_auth(client):
    """GET /api/users/me without a token returns 401."""
    resp = await client.get("/api/users/me")
    assert resp.status_code == 401
