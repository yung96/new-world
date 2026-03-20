async def test_docs_and_redoc_are_available(client):
    docs = await client.get("/api/docs")
    assert docs.status_code == 200
    assert "text/html" in docs.headers.get("content-type", "")
    assert "swagger" in docs.text.lower()

    redoc = await client.get("/api/redoc")
    assert redoc.status_code == 200
    assert "text/html" in redoc.headers.get("content-type", "")
    assert "redoc" in redoc.text.lower()


async def test_openapi_json_has_expected_metadata(client):
    r = await client.get("/api/openapi.json")
    assert r.status_code == 200
    body = r.json()

    assert body["openapi"].startswith("3.")
    assert body["info"]["title"] == "Kraeved API"
    assert body["info"]["version"] == "1.0.0"
    assert "Подробная документация API проекта" in body["info"]["description"]

    tag_names = {tag["name"] for tag in body.get("tags", [])}
    assert {"Auth & Users", "Social", "Posts", "Reviews", "Uploads", "Health Check"} <= tag_names

    paths = body.get("paths", {})
    assert "/api/auth" in paths
    assert "/api/users/me" in paths
    assert "/api/ping" in paths
