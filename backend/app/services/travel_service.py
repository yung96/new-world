from urllib.parse import quote

import httpx
from loguru import logger

from app.core.config import settings


class TravelService:
    BASE_URL = "https://api.travelpayouts.com/aviasales/v3"

    def __init__(self):
        pass

    def get_client(self) -> httpx.AsyncClient:
        client = httpx.AsyncClient(
            base_url=self.BASE_URL,
            headers={"User-Agent": "Mozilla/5.0"},
            timeout=10.0,
        )
        return client

    async def _resolve_iata(
        self, origin_name: str, destination_name: str
    ) -> tuple[str, str]:
        """
        Получаем IATA-коды города отправления и назначения через widgets_suggest_params
        """
        search_phrase = f"Из {origin_name} в {destination_name}"
        url = f"https://www.travelpayouts.com/widgets_suggest_params?q={quote(search_phrase)}"

        async with httpx.AsyncClient(
            timeout=5.0,
            headers={"User-Agent": "Mozilla/5.0"},
        ) as client:
            try:
                resp = await client.get(url)
                resp.raise_for_status()
                data = resp.json()
                origin_iata = data.get("origin", {}).get("iata", origin_name)
                destination_iata = data.get("destination", {}).get(
                    "iata", destination_name
                )
                return origin_iata, destination_iata
            except Exception as e:
                logger.error("Ошибка получения IATA кодов: {}", e)
                return origin_name, destination_name  # fallback

    async def get_global_route(self, params: dict) -> dict:
        # 1. Конвертация городов в IATA
        origin_name = params.pop("origin")
        destination_name = params.pop("destination")
        origin_iata, destination_iata = await self._resolve_iata(
            origin_name, destination_name
        )

        params["origin"] = origin_iata
        params["destination"] = destination_iata

        # 2. Основной запрос
        params["token"] = settings.TRAVEL_API_KEY
        async with self.get_client() as client:
            response = await client.get("/prices_for_dates", params=params)
            response.raise_for_status()
            return response.json()
