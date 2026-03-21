"""Тесты планирования поездки (без реальных Travel/2GIS/GPT при моках)."""

from unittest.mock import AsyncMock, patch

import pytest
from api_paths import api


async def _auth_headers(client, phone: str) -> dict[str, str]:
    login_resp = await client.post(api("/auth"), json={"phone": phone})
    assert login_resp.status_code == 200
    token = login_resp.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}


@pytest.mark.asyncio
async def test_travel_plan_skip_llm_with_mocks(client):
    headers = await _auth_headers(client, "+70000000901")

    create_i = await client.post(
        api("/interests"), json={"name": "Прогулки с детьми"}, headers=headers
    )
    assert create_i.status_code == 201
    interest_id = create_i.json()["id"]

    bind = await client.post(
        api(f"/users/me/interests/{interest_id}"), headers=headers
    )
    assert bind.status_code == 200

    post_body = {
        "title": "Парк Галицкого",
        "city": "Краснодар",
        "description": "Тестовое место",
        "geoLat": 45.0355,
        "geoLng": 38.9753,
        "mediaUrls": [],
        "interestIds": [interest_id],
        "season": "summer",
    }
    post_resp = await client.post(
        api("/user/posts"), json=post_body, headers=headers
    )
    assert post_resp.status_code == 201

    fake_flights = {
        "success": True,
        "currency": "rub",
        "data": [
            {
                "flight_number": "SU123",
                "link": "https://example.com",
                "origin": "MOW",
                "origin_airport": "SVO",
                "destination": "KRR",
                "destination_airport": "KRR",
                "departure_at": "2025-07-01 10:00:00",
                "airline": "Aeroflot",
                "price": 9999,
                "currency": "rub",
                "gate": "aviasales",
                "return_transfers": 0,
                "transfers": 0,
                "duration": 7200,
                "duration_to": 7200,
                "duration_back": 0,
            }
        ],
    }

    with patch(
        "app.services.travel_service.TravelService.get_global_route",
        new_callable=AsyncMock,
        return_value=fake_flights,
    ), patch(
        "app.services.travel_service.TravelService.dgis_search",
        new_callable=AsyncMock,
        return_value=[
            {"name": "Кафе тест", "address": "ул. Примерная, 1"},
        ],
    ):
        plan_resp = await client.post(
            api("/plan"),
            json={
                "originCity": "Москва",
                "destinationCity": "Краснодар",
                "dayCount": 3,
                "skipLlm": True,
            },
            headers=headers,
        )

    assert plan_resp.status_code == 200, plan_resp.text
    data = plan_resp.json()
    assert data["usedLlm"] is False
    assert data["resolvedMode"] == "global_then_local"
    assert len(data["flightOffers"]) >= 1
    assert any(d["dayIndex"] == 1 for d in data["days"])
    # Внутренняя карточка или внешняя точка должны появиться при наличии данных
    all_kinds = [
        b.get("kind")
        for d in data["days"]
        for b in d.get("blocks", [])
    ]
    assert "flight" in all_kinds or "internal_post" in all_kinds or "external_poi" in all_kinds


@pytest.mark.asyncio
async def test_travel_plan_unknown_city_400(client):
    headers = await _auth_headers(client, "+70000000902")
    with patch(
        "app.services.travel_service.TravelService.get_global_route",
        new_callable=AsyncMock,
        return_value={"success": True, "currency": "rub", "data": []},
    ), patch(
        "app.services.travel_service.TravelService.dgis_search",
        new_callable=AsyncMock,
        return_value=[],
    ):
        plan_resp = await client.post(
            api("/plan"),
            json={
                "originCity": "Москва",
                "destinationCity": "Несуществопольск",
                "skipLlm": True,
            },
            headers=headers,
        )
    assert plan_resp.status_code == 400
