# Краевед — модели данных (v3)

---

## Пользователи

### User

- id
- phone (уникальный)
- name
- **~~role~~** — tourist | owner | both
- created_at
- updated_at

**has many** Post, Review, Route, **~~Booking~~** (кеширование страницы поста), **FilterPreset** (фильтры для сортировки букинга)

---

### UserPlaceStatus

- user_id → User
- post_id → Post
- status — visited | want | planned
- planned_date (nullable)
- created_at

**PK** (user_id, post_id)

Заменяет user_favorite_posts.

---

### UserSwipedPost

- user_id → User
- post_id → Post
- direction — left | right
- created_at

**PK** (user_id, post_id)

---

### FilterPreset

- id
- user_id → User
- name
- date_from
- date_to
- group_type
- group_size
- transport
- budget
- interests — jsonb
- pace
- created_at

---

### Report

- id
- reporter_id → User
- target_type — user | post | review
- target_id
- reason
- status — pending | resolved | rejected
- created_at

---

## Места

### Post

- id
- author_id → User
- title
- description
- geo_lat
- geo_lng
- ~~**region_id**~~ → **~~GeoRegion~~**
- city
- season — spring | summer | autumn | winter
- ~~**address**~~
- **~~need_car~~** — bool
- **~~price_level~~** — low | mid | high
- **~~duration_hours~~**
- partner_id → User (nullable, владелец заведения)
- **~~verified~~** — bool
- **~~rating_avg~~** — кэш
- **~~reviews_count~~** — кэш
- created_at
- updated_at

**belongs to** User (автор), User (партнёр), GeoRegion
**has many** PostMedia, Review, PlaceSchedule, PlaceScheduleOverride, Event, Offer
**has many to many** Tag (через PlaceTag)
**has many to many** Post (через SimilarPlace)

---

### PostMedia (Иван глянет)

- id
- post_id → Post
- url
- alt
- position
- created_at

---

### Review

- id
- author_id → User
- post_id → Post
- rating — 1..5
- comment
- media_urls — jsonb
- created_at

**UNIQUE** (author_id, post_id)

---

### **~~PlaceSchedule~~**

- id
- post_id → Post
- day_of_week — 0..6
- open_time
- close_time
- is_closed — bool

---

### SimilarPlace

- place_id → Post
- similar_place_id → Post
- score

**PK** (place_id, similar_place_id)

---

## Теги

### Tag

- id
- name (уникальный)
- emoji
- category — interest | audience | format | season
- created_at

Единый справочник. Заменяет interests + posts.tags jsonb.

---

### PlaceTag

- post_id → Post
- tag_id → Tag
- weight

**PK** (post_id, tag_id)

---

### UserTag

- user_id → User
- tag_id → Tag
- weight

**PK** (user_id, tag_id)

---

## Туры и услуги

### Tour

- id
- post_id → Post
- title
- description
- price
- duration_min
- max_group_size
- guide_id → User
- publisher_id → User
- created_at

---

### Service

- id
- name
- type — transport | food | activity | guide | other
- duration_min
- description

---

### TourService

- tour_id → Tour
- service_id → Service
- position

**PK** (tour_id, service_id)

---

## Эксперты, события, предложения

### Expert

- id
- user_id → User (nullable)
- name
- photo_url
- specialization
- price_from
- bio
- contacts — jsonb
- region_id → GeoRegion
- created_at

---

### Event

- id
- post_id → Post
- title
- description
- date_from
- date_to
- photo_url
- created_at

---

### Offer

- id
- post_id → Post
- title
- description
- discount_percent
- valid_from
- valid_to
- created_at

---

## Гео-справочник

### **GeoRegion**

- id
- name
- slug (уникальный)
- type — country | region | city | district
- parent_id → GeoRegion
- polygon — MultiPolygon (PostGIS)
- centroid — Point (PostGIS)
- population
- timezone
- created_at

**has many** GeoRegion (дочерние)
**has many** Route, Expert, WeatherMonthly
**has many to many** GeoRegion (через TransportLink)

---

## Кэш внешних сервисов

### WeatherMonthly

- region_id → GeoRegion
- month — 1..12
- temp_min
- temp_max
- rain_mm
- sunny_days
- description
- fetched_at

**PK** (region_id, month)

---

### TransportLink

- id
- from_id → GeoRegion
- to_id → GeoRegion
- kind — plane | train | bus | ferry
- duration_min
- price_from
- aviasales_url
- tutu_url
- updated_at

**UNIQUE** (from_id, to_id, kind)

---

## Маршруты

### Route

- id
- author_id → User (nullable, null = системный)
- title
- description
- cover_url
- narrative — text (AI, общий текст про весь тур)
- total_days
- total_price
- total_price_status — fresh | stale | partially_expired
- total_experiences — int, кэш-счётчик
- total_hotels — int, кэш-счётчик
- total_transports — int, кэш-счётчик
- share_token (уникальный)
- params — jsonb (dates, group, transport, budget, interests, pace)
- status — draft | ready | stale | booking | partially_booked | booked | completed | cancelled
- created_at
- updated_at

**belongs to** User
**has many** RouteSegment, RoutePin, Booking

---

### RouteSegment

- id
- route_id → Route
- position
- city_id → GeoRegion
- title
- description
- narrative — text (AI, текст про этот город/блок)
- date_from
- date_to
- photos — jsonb
- created_at

**belongs to** Route, GeoRegion
**has many** SegmentItem, RoutePin

---

### SegmentItem

- id
- segment_id → RouteSegment
- parent_id → SegmentItem (nullable, experience → day)
- type — leg | stay | transfer | car_rental | day | experience
- position
- price (nullable)
- price_currency
- price_original — цена на момент построения
- price_fetched_at
- price_status — fresh | stale | expired | unavailable
- provider_name (nullable)
- provider_url (nullable)
- ai_comment — text (nullable, AI-комментарий)
- details — jsonb (структура зависит от type)
- created_at

**belongs to** RouteSegment, SegmentItem (parent)
**has many** SegmentItem (children), BookingItem, RoutePin

#### details по типам:

**leg**: from, to, transport, duration_min, stops, departure_at, arrival_at, carrier, status
**stay**: name, stars, rating, review_count, source, nights, photo_url, check_in, check_out
**transfer**: from, to, duration_min, provider, vehicle_type
**car_rental**: model, class, transmission, doors, photo_url, pickup_at, return_at
**day**: day_number, date, title, photo_url, temp_c, weather_icon
**experience**: name, time, duration_min, lat, lng, post_id, description, photo_url

---

### RoutePin

- id
- route_id → Route
- segment_id → RouteSegment (nullable)
- segment_item_id → SegmentItem (nullable)
- label — varchar ("1", "A", "W Amman Hotel")
- pin_type — city | stay | experience | transport_hub | photo_spot | food | custom
- lat
- lng
- icon (nullable) — hotel | camera | fork | plane | pin | star
- color (nullable)
- position — int, порядок нумерации на карте
- zoom_level (nullable) — на каком зуме показывать
- is_visible — bool, default true
- source — auto | user | editor | ai
- is_persistent — bool, default true (auto = false, остальные = true; auto пересоздаются при пересборке)
- created_by → User (nullable, null для auto и ai)
- notes — text (nullable, подпись при наведении)
- created_at

**belongs to** Route
**belongs to** RouteSegment (опционально)
**belongs to** SegmentItem (опционально)
**belongs to** User (создатель, опционально)

---

## Workflow-блоки (промпты)

### PromptTemplate

- id
- slug (уникальный) — "honeymoon_intro", "rainy_day_plan", "budget_leg_comment"
- category — narrative_intro | segment_intro | day_title | stay_comment | experience_description | leg_comment | weather_adaptation
- scenario — jsonb массив: ["honeymoon", "family", "solo", "budget", "luxury", "adventure", "cultural"]
- transport_context (nullable) — flight | drive | train | bus | ferry
- weather_context (nullable) — hot | cold | rainy | snow
- group_context (nullable) — solo | couple | family | friends | group
- template_text — текст с плейсхолдерами ({user_name}, {city}, {hotel_name}, {temp_c}, {interests}, {partner_name}, {children_count})
- priority — int, вес при конкуренции
- is_active — bool
- version — int (для A/B-тестов)
- created_at
- updated_at

---

### PromptComposition

- id
- name — "Luxury Honeymoon Full Pack", "Budget Solo Backpacking"
- scenario — jsonb (для матчинга с routes.params)
- created_at

**has many** PromptCompositionItem

---

### PromptCompositionItem

- composition_id → PromptComposition
- template_id → PromptTemplate
- position

**PK** (composition_id, template_id)

---

### PromptLog

- id
- route_id → Route
- composition_id → PromptComposition (nullable)
- template_ids — jsonb (какие блоки использовались)
- assembled_prompt — text (итоговый промпт)
- llm_response — text (сырой ответ)
- model — varchar (claude-sonnet-4, gpt-4o)
- tokens_in
- tokens_out
- latency_ms
- created_at

---

## Букинг

### Booking

- id
- route_id → Route
- user_id → User
- status — pending | confirmed | paid | cancelled | refunded
- total_price
- currency
- payment_method
- payment_id — внешний ID (Stripe, ЮKassa)
- paid_at (nullable)
- created_at
- updated_at

**belongs to** Route, User
**has many** BookingItem

---

### BookingItem

- id
- booking_id → Booking
- segment_item_id → SegmentItem
- external_booking_ref — номер бронирования у провайдера
- status — pending | confirmed | failed | cancelled | refunded
- price_locked — цена на момент бронирования
- confirmation_url
- error_message (nullable)
- created_at
- updated_at

**belongs to** Booking, SegmentItem

---

## Справочники

### Achievement

- id
- name (уникальный)
- description
- icon_url
- category
- condition — jsonb (правила выдачи)
- created_at

---

### UserAchievement

- user_id → User
- achievement_id → Achievement

**PK** (user_id, achievement_id)

---

## Удалено из старой схемы

- ~~user_favorite_posts~~ → UserPlaceStatus
- ~~friend_requests~~ → Follow
- ~~user_friends~~ → Follow
- ~~post_interests~~ → PlaceTag
- ~~user_interests~~ → UserTag
- ~~interests~~ → Tag
- ~~posts.tags jsonb~~ → PlaceTag
- ~~posts.media_urls jsonb~~ → PostMedia
- ~~posts.city varchar~~ → Post.region_id → GeoRegion
- ~~routes.city_id~~ → убрано, города живут в RouteSegment.city_id
