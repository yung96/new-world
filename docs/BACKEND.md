# Краевед — бэкенд

FastAPI + PostgreSQL + asyncio. Python 3.11.

## Запуск

```bash
# Dev (с hot reload):
docker compose -f docker-compose.dev.yml up -d

# Prod:
docker compose up -d --build

# Локально без Docker:
cd backend
DATABASE_URL="postgresql+asyncpg://kraeved_user:kraeved_password@localhost:15432/kraeved" \
REDIS_URL="redis://localhost:6380" SECRET_KEY="dev-secret" \
TRAVEL_API_KEY="fake" TGIS_API_KEY="fake" DADATA_API_KEY="fake" \
python -m uvicorn main:app --host 0.0.0.0 --port 18000 --reload
```

Swagger: `http://localhost:18000/api/docs`

## База данных

42 таблицы. Схема создаётся автоматически при старте (`Base.metadata.create_all` в entrypoint).

Дамп: `full_dump.sql` в корне репы. Заливка:
```bash
psql -U kraeved_user -d kraeved < full_dump.sql
```

## Структура

```
backend/
  app/
    api/                  # роутеры (тонкие)
      auth.py             # авторизация, профиль, онбординг
      posts.py            # места (CRUD, поиск)
      reviews.py          # отзывы
      filters.py          # конфиг фильтров, города, карта
      route_builder.py    # построение маршрута (pipeline)
      trips.py            # Trip API для фронта (road, schedule, place)
      travel.py           # авиабилеты, погода, 2GIS
      social.py           # подписки, интересы, достижения
      user.py             # избранное, свайпы, лента
      admin.py            # админ-дашборд
      uploads.py          # загрузка файлов
    models/               # SQLAlchemy ORM (42 таблицы)
    services/             # бизнес-логика
      pipeline/           # 7-step route builder
        step_scoring.py
        step_flights.py
        step_distances.py
        step_recommend.py
        step_events.py
        step_weather.py
        step_narrate.py
      scheduler.py        # asyncio job scheduler
      jobs.py             # фоновые задачи
      travel_service.py   # Aviasales, 2GIS, погода
      gpt_service.py      # LLM (DeepSeek/GPT)
    core/
      config.py           # pydantic-settings
      dependencies.py     # Depends()
      security.py         # JWT
    db.py                 # engine + session
  tests/                  # 116 тестов
  scripts/                # seed скрипты
  alembic/                # миграции
  main.py                 # FastAPI app
```

## API (основные эндпоинты)

### Авторизация
```
POST /api/auth {phone}              → {access_token}
GET  /api/users/me                  → профиль
PATCH /api/users/me {name, bio}     → обновить
GET  /api/users/me/interests        → мои интересы
GET  /api/users/me/routes           → мои маршруты
```

### Онбординг
```
POST /api/onboarding/swipe {postId, direction}  → ok
POST /api/onboarding/complete {interestIds}     → ok, count
```

### Места
```
GET  /api/posts?search=&city=&season=&regionId=  → список с фильтрами
GET  /api/posts/{id}                              → карточка
POST /api/posts/{id}/reviews                      → отзыв
GET  /api/user/favorites                          → избранное
POST /api/user/favorites/{id}                     → добавить
```

### Карта
```
GET /api/filters/map-points?zoom=10&place_type=Ресторан
  → {districts[], cities[], places[]}
GET /api/filters/cities          → города с фото и описанием
GET /api/filters/regions?type=city
GET /api/filters/config          → все опции для UI
```

### Построение маршрута
```
POST /api/routes/build {dateFrom, dateTo, groupType, transport, budget, interests, pace}
  → {routeId, shareToken, status: "draft"}

GET /api/routes/{id}/status      → поллить пока != "ready"
```

Пайплайн (7 шагов, async):
1. scoring — подбор мест по интересам
2. flights — билеты Aviasales
3. distances — расстояния 2GIS/OSRM
4. recommend — еда/ночлег/заправки
5. events — события на даты
6. weather — погода
7. narrate — текст от LLM

### Trip (для фронта)
```
GET /api/trips/{id}              → полный Trip (segments → blocks)
GET /api/trips/{id}/road         → GeoJSON дорога (OSRM)
GET /api/trips/{id}/schedule     → расписание + AI tips
GET /api/trips/{id}/day/{n}      → детали дня
GET /api/trips/share/{token}     → публичный маршрут
GET /api/trips/place/{id}        → карточка места (фото, отзывы, nearby)
GET /api/trips/place/{id}/ai     → AI рекомендация
```

### Действия с маршрутом
```
POST /api/routes/{id}/book           → бронирование
POST /api/routes/{id}/refresh-prices → обновить цены
PUT  /api/routes/{id}/pins           → добавить пин
DELETE /api/routes/{id}/pins/{pinId} → удалить пин
GET  /api/routes/{id}/pins           → пины для карты
```

### Фильтры
```
GET  /api/filters/config         → groupTypes, transportTypes, budgetLevels, paceOptions, interests, seasons, pinTypes, placeTypes
GET  /api/filters/presets        → мои пресеты (auth)
POST /api/filters/presets        → сохранить пресет
DELETE /api/filters/presets/{id}
```

## Данные

- 381 место по Краснодарскому краю
- 145 регионов (45 районов с полигонами, 98 городов)
- 12 интересов
- 24 отзыва
- 3 демо-маршрута (demo-wine-weekend, demo-family-sochi, demo-mountain-trek)
- 5 экспертов, 6 событий, 4 акции

## Scheduler

Фоновые задачи без Celery — чистый asyncio:
```python
scheduler.add("recalc_ratings", fn, interval=300)     # каждые 5 мин
scheduler.run_once("route_build_42", builder.run)      # одноразовый
```

## Тесты

116 тестов. Запуск:
```bash
docker compose -f docker-compose.test.yml up --build --abort-on-container-exit
```

## Переменные окружения

```env
DATABASE_URL=postgresql+asyncpg://kraeved_user:kraeved_password@localhost:15432/kraeved
REDIS_URL=redis://localhost:6380
SECRET_KEY=dev-secret
TRAVEL_API_KEY=...        # Aviasales (Travelpayouts)
TGIS_API_KEY=...          # 2GIS
DADATA_API_KEY=...        # DaData
GPT_CLIENT_BASE_URL=...   # OpenRouter/OpenAI
GPT_CLIENT_KEY=...        # API ключ
GPT_MODEL=deepseek-chat   # или gpt-4o-mini
```

## Демо-маршруты

```
GET /api/trips/share/demo-wine-weekend     → Винный weekend, 2 дня
GET /api/trips/share/demo-family-sochi     → Семейный день в Сочи
GET /api/trips/share/demo-mountain-trek    → Горный трекинг, 2 дня
```
