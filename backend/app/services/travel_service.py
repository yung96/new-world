import asyncio
import json
import math
import urllib
from urllib.parse import quote

import httpx
from loguru import logger

from app.core.config import settings

cities = [
    "Краснодар", "Сочи", "Новороссийск", "Армавир", "Анапа",
    "Геленджик", "Туапсе", "Ейск", "Крымск", "Кропоткин",
    "Славянск-на-Кубани", "Лабинск", "Тимашёвск", "Тихорецк",
    "Курганинск", "Кореновск", "Темрюк", "Усть-Лабинск",
    "Белореченск", "Абинск", "Приморско-Ахтарск", "Апшеронск",
    "Гулькевичи", "Новокубанск", "Горячий Ключ", "Хадыженск",
    "Красная Поляна", "Дагомыс", "Тамань", "Архипо-Осиповка",
    "Кабардинка", "Джубга", "Псебай", "Мостовской", "Сириус",
]

WEATHER_CODE_MAP = {
    0: "Ясно",
    1: "Преимущественно ясно",
    2: "Переменная облачность",
    3: "Пасмурно",
    45: "Туман",
    48: "Туман с инеем",
    51: "Лёгкая морось",
    53: "Морось",
    55: "Сильная морось",
    61: "Лёгкий дождь",
    63: "Дождь",
    65: "Сильный дождь",
    71: "Лёгкий снег",
    73: "Снег",
    75: "Сильный снег",
    80: "Ливень",
    81: "Сильный ливень",
    82: "Очень сильный ливень",
    95: "Гроза",
    96: "Гроза с градом",
    99: "Сильная гроза с градом",
}


class TravelService:
    # API TRAVEL PAYOUTS
    BASE_URL_TRAVEL = "https://api.travelpayouts.com/aviasales/v3"
    # API 2GIS
    BASE_URL_2GIS = "https://routing.api.2gis.com"
    # https://openrouteservice.org/ (SDK)

    # API OPEN METEO
    BASE_URL_OM = "https://api.open-meteo.com/v1/forecast"

    def __init__(self):
        pass

    def get_client(self) -> httpx.AsyncClient:
        client = httpx.AsyncClient(
            base_url=self.BASE_URL_TRAVEL,
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
        """
        Возвращает список доступных билетов для покупки до конкретного города.
        API: API TRAVEL PAYOUTS
        """

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

    def get_available_cities(self) -> list[str]:
        """
        Возвращает доступный список городов.
        Пока просто статический список.
        """
        return cities

    async def get_route_matrix_info(self, body: dict) -> dict:
        """
        Возвращает расстояние и затрачиваемое время между конечными остановками.
        API: 2GIS
        """
        async with httpx.AsyncClient(timeout=10.0) as client:
            response = await client.post(
                self.BASE_URL_2GIS + "/get_dist_matrix",
                params={
                    "key": settings.TGIS_API_KEY,
                    "version": "2.0",
                    "response_format": "json",
                },
                json=body,
            )
            response.raise_for_status()
            return response.json()

    async def get_weather_info(self, lat: float, lon: float) -> dict:
        """
        Получение текущей погоды по координатам.
        API: Open-Meteo
        """

        params = {
            "latitude": lat,
            "longitude": lon,
            "current_weather": True,
            "timezone": "auto",
        }

        async with httpx.AsyncClient(timeout=10.0) as client:
            response = await client.get(self.BASE_URL_OM, params=params)
            response.raise_for_status()
            data = response.json()

            current = data.get("current_weather", {})
            code = current.get("weathercode")

            return {
                "temperature": current.get("temperature"),
                "windspeed": current.get("windspeed"),
                "winddirection": current.get("winddirection"),
                "weathercode": code,
                "weather": WEATHER_CODE_MAP.get(code, "Неизвестно"),
                "time": current.get("time"),
            }

    async def get_route_full_info(self, body: dict) -> dict:
        """
        Построение маршрута со всеми его свойствами и интересными точками.
        API: 2GIS + DaData + Wikipedia
        """
        coords_tuples: list[tuple[float, float]] = [
            (float(point["lon"]), float(point["lat"])) for point in body["points"]
        ]
        interval_km: int = int(body["interval"])

        waypoints = self.find_waypoints(coords_tuples, interval_km)
        result = []

        for idx, wp in enumerate(waypoints):
            poi = {}
            for pref in body["user_prefs"]:
                poi[pref] = await self.dgis_search(
                    query=pref,
                    lat=float(wp["lat"]),
                    lon=float(wp["lon"]),
                    radius_m=int(body["radius"]),
                    limit=body["limit"],
                )
                await asyncio.sleep(0.3)

            address = await self.dadata_address(
                lat=float(wp["lat"]),
                lon=float(wp["lon"]),
                radius_m=int(body["radius"]),
            )

            titles = await self.wikipedia_nearby(float(wp["lat"]), float(wp["lon"]))
            wikipedia = []
            for title in titles:
                summary = await self.wikipedia_summary(title)
                wikipedia.append({"title": title, **(summary or {})})

            result.append(
                {
                    "stop": idx + 1,
                    "km": wp["total_km"],
                    "coords": [wp["lon"], wp["lat"]],
                    "address": address,
                    "poi": poi,
                    "wikipedia": wikipedia,
                }
            )

            await asyncio.sleep(0.5)
        return {"waypoints": result}

    def haversine(self, lat1: float, lon1: float, lat2: float, lon2: float):
        r = 6371.0
        dlat = math.radians(lat2 - lat1)
        dlon = math.radians(lon2 - lon1)
        a = (
            math.sin(dlat / 2) ** 2
            + math.cos(math.radians(lat1))
            * math.cos(math.radians(lat2))
            * math.sin(dlon / 2) ** 2
        )
        return 2 * r * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    def find_waypoints(self, coords: list[float], interval_km: int):
        """Нарезка точек"""
        if not coords:
            return []

        waypoints = []
        accumulated = 0.0
        total_km = 0.0
        prev_lon, prev_lat = coords[0]

        waypoints.append({"total_km": 0.0, "lat": prev_lat, "lon": prev_lon})

        for lon, lat in coords[1:]:
            d = self.haversine(prev_lat, prev_lon, lat, lon)
            accumulated += d
            total_km += d

            if accumulated >= interval_km:
                waypoints.append(
                    {"total_km": round(total_km, 1), "lat": lat, "lon": lon}
                )
                accumulated = 0.0

            prev_lon, prev_lat = lon, lat

        return waypoints

    async def dgis_search(
        self,
        query: str,
        lat: float,
        lon: float,
        radius_m: int,
        limit: int = 5,
    ) -> list:
        try:
            async with httpx.AsyncClient(timeout=10.0) as client:
                r = await client.get(
                    "https://catalog.api.2gis.com/3.0/items",
                    params={
                        "q": query,
                        "location": f"{lon},{lat}",
                        "radius": radius_m,
                        "sort_by": "distance",
                        "page_size": limit,
                        "key": settings.TGIS_API_KEY,
                        "lang": "ru",
                    },
                )
                r.raise_for_status()
                logger.info(r.text)
                items = r.json().get("result", {}).get("items", [])
                return [
                    {"name": i.get("name"), "address": i.get("address_name")}
                    for i in items
                ]
        except Exception as e:
            logger.error(e)
            return []

    async def wikipedia_nearby(self, lat, lon, radius_m=10000, limit=3):
        try:
            async with httpx.AsyncClient(timeout=10.0) as client:
                headers = {"User-Agent": "MyAppName/1.0 (contact@example.com)"}

                r = await client.get(
                    "https://ru.wikipedia.org/w/api.php",
                    params={
                        "action": "query",
                        "list": "geosearch",
                        "gscoord": f"{lat}|{lon}",
                        "gsradius": radius_m,
                        "gslimit": limit,
                        "format": "json",
                    },
                    headers=headers,
                )
                logger.info(r.text)
                r.raise_for_status()
                return [
                    a["title"] for a in r.json().get("query", {}).get("geosearch", [])
                ]
        except Exception as e:
            logger.error(e)
            return []

    async def wikipedia_summary(self, title: str) -> dict | None:
        try:
            url = f"https://ru.wikipedia.org/api/rest_v1/page/summary/{urllib.parse.quote(title)}"
            async with httpx.AsyncClient(timeout=10.0) as client:
                r = await client.get(url)
                logger.info(r.text)
                r.raise_for_status()
                data = r.json()
                return {
                    "text": data.get("extract", "")[:300],
                    "photo": data.get("thumbnail", {}).get("source"),
                    "original": data.get("originalimage", {}).get("source"),
                }
        except Exception as e:
            logger.error(e)
            return None

    async def dadata_address(self, lat: float, lon: float, radius_m: int):
        try:
            async with httpx.AsyncClient(timeout=10.0) as client:
                r = await client.post(
                    "https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address",
                    json={
                        "lat": lat,
                        "lon": lon,
                        "radius_meters": radius_m,
                        "count": 1,
                    },
                    headers={
                        "Authorization": f"Token {settings.DADATA_API_KEY}",
                        "Content-Type": "application/json",
                    },
                )
                logger.info(r.text)
                r.raise_for_status()
                suggestions = r.json().get("suggestions", [])
                return suggestions[0]["value"] if suggestions else None
        except Exception as e:
            logger.error(e)
            return None
