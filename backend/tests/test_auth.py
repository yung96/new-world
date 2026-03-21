async def test_auth_login_phone_returns_token_and_users_me_works(client):
    r = await client.post("/api/auth", json={"phone": "+79990001122"})
    assert r.status_code == 200
    token = r.json()["access_token"]
    assert isinstance(token, str) and token

    me = await client.get("/api/users/me", headers={"Authorization": f"Bearer {token}"})
    assert me.status_code == 200
    body = me.json()
    assert body["id"] > 0
    assert body["phone"] == "+79990001122"


async def test_auth_empty_phone_returns_400(client):
    r = await client.post("/api/auth", json={"phone": "   "})
    assert r.status_code == 400


async def test_auth_missing_phone_returns_422(client):
    r = await client.post("/api/auth", json={})
    assert r.status_code == 422


async def test_users_me_invalid_token_returns_401(client):
    r = await client.get("/api/users/me", headers={"Authorization": "Bearer not-a-jwt"})
    assert r.status_code == 401


async def test_users_me_token_for_missing_user_returns_401(client):
    from app.core.security import create_access_token

    token = create_access_token(subject=999999)
    r = await client.get("/api/users/me", headers={"Authorization": f"Bearer {token}"})
    assert r.status_code == 401


async def test_auth_login_same_phone_returns_existing_user(client):
    r1 = await client.post("/api/auth", json={"phone": "+79990002233"})
    assert r1.status_code == 200

    r2 = await client.post("/api/auth", json={"phone": "+79990002233"})
    assert r2.status_code == 200
    token2 = r2.json()["access_token"]

    me = await client.get("/api/users/me", headers={"Authorization": f"Bearer {token2}"})
    assert me.status_code == 200
    assert me.json()["phone"] == "+79990002233"


async def test_users_me_without_token_returns_401(client):
    r = await client.get("/api/users/me")
    assert r.status_code == 401


async def test_auth_phone_is_trimmed(client):
    r1 = await client.post("/api/auth", json={"phone": "+79990003344"})
    assert r1.status_code == 200

    r2 = await client.post("/api/auth", json={"phone": "   +79990003344   "})
    assert r2.status_code == 200
    token = r2.json()["access_token"]

    me = await client.get("/api/users/me", headers={"Authorization": f"Bearer {token}"})
    assert me.status_code == 200
    assert me.json()["phone"] == "+79990003344"

