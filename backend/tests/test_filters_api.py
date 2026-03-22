"""
Tests for /api/filters/* endpoints.

Covered:
- GET /api/filters/config  — static config object with expected keys
- GET /api/filters/cities  — list of city objects with name/photo/description
- GET /api/filters/regions  — list of region objects, filterable by ?type=city
- GET /api/filters/map-points  — multi-layer response (districts, cities, places, routes)
- placesCount по городам — посты с region_id и посты только с Post.city (без FK)
"""

import pytest


async def _auth_headers(client, phone: str) -> dict[str, str]:
    resp = await client.post("/api/auth", json={"phone": phone})
    assert resp.status_code == 200
    return {"Authorization": f"Bearer {resp.json()['access_token']}"}


@pytest.mark.asyncio
async def test_filters_config(client):
    """GET /api/filters/config returns a static config with required top-level keys."""
    resp = await client.get("/api/filters/config")
    assert resp.status_code == 200

    data = resp.json()
    assert "groupTypes" in data
    assert "pinTypes" in data
    assert "placeTypes" in data
    assert "interests" in data

    # groupTypes must be a non-empty list with value/label items
    assert isinstance(data["groupTypes"], list)
    assert len(data["groupTypes"]) > 0
    first = data["groupTypes"][0]
    assert "value" in first
    assert "label" in first

    # placeTypes sanity-check
    assert isinstance(data["placeTypes"], list)
    assert len(data["placeTypes"]) > 0


@pytest.mark.asyncio
async def test_filters_cities(client):
    """GET /api/filters/cities returns a list; each item has expected shape."""
    resp = await client.get("/api/filters/cities")
    assert resp.status_code == 200

    data = resp.json()
    assert isinstance(data, list)

    # The endpoint may return an empty list when the DB is clean — that's fine.
    # When items are present, verify their shape.
    for item in data:
        assert "name" in item
        assert "photo" in item        # may be None but key must exist
        assert "description" in item  # may be None but key must exist


@pytest.mark.asyncio
async def test_filters_cities_places_count_merges_region_id_and_city_name(client, db_session):
    """
    placesCount учитывает:
    - посты с Post.region_id = город;
    - посты с region_id IS NULL, но Post.city (после trim) совпадает с именем города.
    """
    from app.models.geo import GeoRegion, GeoRegionType
    from app.models.post import Season
    from app.services.post_service import PostService
    from app.services.user_service import get_or_create_user

    city = GeoRegion(
        name="Тестоград",
        slug="testograd-places-count-merge",
        type=GeoRegionType.city,
        centroid="45.0,38.0",
    )
    db_session.add(city)
    await db_session.commit()
    await db_session.refresh(city)

    author = await get_or_create_user(db_session, phone="+79990005001")
    posts = PostService(db_session)

    await posts.create_post(
        author=author,
        title="Только FK",
        city=None,
        description=None,
        geo_lat=45.0,
        geo_lng=38.0,
        season=Season.summer,
        interest_ids=[],
        region_id=city.id,
    )
    await posts.create_post(
        author=author,
        title="Только city",
        city="Тестоград",
        description=None,
        geo_lat=45.01,
        geo_lng=38.01,
        season=Season.summer,
        interest_ids=[],
        region_id=None,
    )

    resp = await client.get("/api/filters/cities")
    assert resp.status_code == 200
    row = next((x for x in resp.json() if x["name"] == "Тестоград"), None)
    assert row is not None
    assert row["placesCount"] == 2

    mp = await client.get("/api/filters/map-points", params={"zoom": 10})
    assert mp.status_code == 200
    city_row = next((c for c in mp.json()["cities"] if c["name"] == "Тестоград"), None)
    assert city_row is not None
    assert city_row["placesCount"] == 2


@pytest.mark.asyncio
async def test_filters_regions_type_filter(client):
    """GET /api/filters/regions?type=city returns only city-type regions."""
    resp = await client.get("/api/filters/regions", params={"type": "city"})
    assert resp.status_code == 200

    data = resp.json()
    assert isinstance(data, list)

    for item in data:
        assert item["type"] == "city"
        assert "id" in item
        assert "name" in item
        assert "slug" in item


@pytest.mark.asyncio
async def test_filters_regions_no_filter(client):
    """GET /api/filters/regions without params returns all regions (any type)."""
    resp = await client.get("/api/filters/regions")
    assert resp.status_code == 200
    assert isinstance(resp.json(), list)


@pytest.mark.asyncio
async def test_map_points(client):
    """GET /api/filters/map-points?zoom=10 returns the expected multi-layer structure."""
    resp = await client.get("/api/filters/map-points", params={"zoom": 10})
    assert resp.status_code == 200

    data = resp.json()
    # All four top-level keys must be present
    assert "districts" in data
    assert "cities" in data
    assert "places" in data
    assert "routes" in data

    # Each is a list (may be empty in a clean test DB)
    assert isinstance(data["districts"], list)
    assert isinstance(data["cities"], list)
    assert isinstance(data["places"], list)
    assert isinstance(data["routes"], list)

    # zoom value is echoed back
    assert data["zoom"] == 10


@pytest.mark.asyncio
async def test_map_points_includes_created_post(client):
    """A post created via API appears in /api/filters/map-points places."""
    from app.models.post import Season

    headers = await _auth_headers(client, "+78880000001")
    create_resp = await client.post(
        "/api/user/posts",
        json={
            "title": "Map Point Test Place",
            "description": "desc",
            "geoLat": 44.6,
            "geoLng": 37.5,
            "interestIds": [],
            "season": Season.summer.value,
        },
        headers=headers,
    )
    assert create_resp.status_code == 201
    post_id = create_resp.json()["id"]

    resp = await client.get("/api/filters/map-points", params={"zoom": 10})
    assert resp.status_code == 200
    place_ids = {p["id"] for p in resp.json()["places"]}
    assert post_id in place_ids
