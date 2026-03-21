/**
 * Моковые данные виджетов путешествия.
 * Каждый виджет привязан к городу маршрута.
 *
 * === ИСТОЧНИКИ ДАННЫХ (для прода) ===
 *
 * ПОГОДА
 *   API: OpenWeatherMap (api.openweathermap.org/data/2.5/forecast)
 *   или: Яндекс.Погода (api.weather.yandex.ru/v2/forecast)
 *   Данные: прогноз на дату поездки по координатам места
 *
 * БИЛЕТЫ (авиа/жд)
 *   API: Aviasales / Travelpayouts (api.travelpayouts.com)
 *   или: Tutu.ru API, РЖД API
 *   Данные: минимальная цена билета из города пользователя до ближайшего аэропорта/вокзала
 *
 * ОТЕЛИ
 *   API: Ostrovok.ru (partner API) / Booking.com Affiliate API
 *   или: Яндекс.Путешествия (travel.yandex.ru)
 *   Данные: минимальная цена за ночь, рейтинг, ссылка на бронирование
 *
 * АРЕНДА АВТО
 *   API: Localrent.com API / Rentalcars.com Affiliate
 *   Данные: цена/день, класс авто
 *
 * СОБЫТИЯ / МЕРОПРИЯТИЯ
 *   API: KudaGo (kudago.com/public-api) — бесплатный
 *   или: Timepad API, Яндекс.Афиша
 *   Данные: ближайшие события в городе на дату поездки
 *
 * ПОЛЕЗНЫЕ СОВЕТЫ
 *   Статичные данные из CMS / собственной БД
 */

export const weatherData = {
  "Краснодар": { temp: 24, condition: "Солнечно", icon: "☀️", humidity: 45, wind: 3.2 },
  "Абрау-Дюрсо": { temp: 22, condition: "Переменная облачность", icon: "⛅", humidity: 55, wind: 4.1 },
  "Сочи": { temp: 26, condition: "Солнечно", icon: "☀️", humidity: 65, wind: 2.8 },
  "Красная Поляна": { temp: 18, condition: "Облачно", icon: "☁️", humidity: 70, wind: 1.5 },
  "Сукко": { temp: 23, condition: "Ясно", icon: "☀️", humidity: 50, wind: 3.5 },
  "Гуамка": { temp: 20, condition: "Небольшой дождь", icon: "🌦️", humidity: 75, wind: 2.0 },
  "Каменномостский": { temp: 19, condition: "Переменная облачность", icon: "⛅", humidity: 60, wind: 2.5 },
  "Геленджик": { temp: 25, condition: "Солнечно", icon: "☀️", humidity: 52, wind: 4.8 },
  "Утриш": { temp: 24, condition: "Ясно", icon: "☀️", humidity: 48, wind: 3.0 },
  "Кабардинка": { temp: 24, condition: "Солнечно", icon: "☀️", humidity: 50, wind: 3.8 },
  "Анапа": { temp: 25, condition: "Ясно", icon: "☀️", humidity: 47, wind: 5.2 },
};

export const ticketsData = {
  "Краснодар": {
    flight: { from: "Москва (SVO)", price: 3200, airline: "Победа", duration: "2ч 15м", apiSource: "Travelpayouts" },
    train: { from: "Москва (Казанский)", price: 2800, carrier: "РЖД", duration: "18ч 30м", apiSource: "РЖД API" },
  },
  "Сочи": {
    flight: { from: "Москва (VKO)", price: 3800, airline: "S7 Airlines", duration: "2ч 30м", apiSource: "Travelpayouts" },
    train: { from: "Краснодар", price: 900, carrier: "Ласточка", duration: "5ч 20м", apiSource: "РЖД API" },
  },
  "Геленджик": {
    flight: { from: "Москва (SVO)", price: 4500, airline: "Аэрофлот", duration: "2ч 20м", apiSource: "Travelpayouts" },
    train: null,
  },
  "Анапа": {
    flight: { from: "Москва (VKO)", price: 3100, airline: "Победа", duration: "2ч 10м", apiSource: "Travelpayouts" },
    train: { from: "Москва (Казанский)", price: 3200, carrier: "РЖД", duration: "20ч", apiSource: "РЖД API" },
  },
};

export const hotelsData = {
  "Краснодар": [
    { name: "Marriott Краснодар", price: 5200, rating: 4.7, apiSource: "Ostrovok API" },
    { name: "Хостел «Типография»", price: 890, rating: 4.3, apiSource: "Ostrovok API" },
  ],
  "Сочи": [
    { name: "Radisson Blu Resort", price: 8500, rating: 4.8, apiSource: "Ostrovok API" },
    { name: "Бридж Маунтин", price: 3200, rating: 4.5, apiSource: "Ostrovok API" },
  ],
  "Геленджик": [
    { name: "Kempinski Grand Hotel", price: 12000, rating: 4.9, apiSource: "Ostrovok API" },
    { name: "Гостевой дом «Морской»", price: 2100, rating: 4.2, apiSource: "Ostrovok API" },
  ],
  "Красная Поляна": [
    { name: "Novotel Resort", price: 7800, rating: 4.6, apiSource: "Ostrovok API" },
    { name: "Поляна 1389", price: 6400, rating: 4.5, apiSource: "Ostrovok API" },
  ],
  "Абрау-Дюрсо": [
    { name: "Abrau Light Resort", price: 6500, rating: 4.6, apiSource: "Ostrovok API" },
  ],
};

export const carRentalData = {
  economy: { name: "Hyundai Solaris", pricePerDay: 2500, apiSource: "Localrent API" },
  comfort: { name: "Kia K5", pricePerDay: 4200, apiSource: "Localrent API" },
  suv: { name: "Hyundai Creta", pricePerDay: 3800, apiSource: "Localrent API" },
};

export const eventsData = {
  "Краснодар": [
    { name: "Фестиваль уличной еды", date: "12 июля", venue: "Парк Галицкого", apiSource: "KudaGo API" },
    { name: "Концерт «Мумий Тролль»", date: "15 июля", venue: "Стадион ФК Краснодар", apiSource: "KudaGo API" },
  ],
  "Сочи": [
    { name: "Этап Формулы-1", date: "28 сентября", venue: "Олимпийский парк", apiSource: "KudaGo API" },
    { name: "Джаз на пляже", date: "каждую пятницу", venue: "Ривьера", apiSource: "KudaGo API" },
  ],
  "Геленджик": [
    { name: "Карнавал Геленджика", date: "5 июня", venue: "Набережная", apiSource: "KudaGo API" },
  ],
};

export const travelTips = {
  "Краснодар": "Лучшее время для посещения парка Галицкого — вечер, когда включается подсветка.",
  "Сочи": "Берите с собой удобную обувь — много пеших троп. Крем от солнца обязателен.",
  "Геленджик": "Набережную лучше обходить рано утром или после 18:00 — днём жарко и людно.",
  "Красная Поляна": "Даже летом на высоте бывает прохладно — берите ветровку.",
  "Гуамка": "После дождей тропа в ущелье скользкая. Трекинговая обувь обязательна.",
  "Абрау-Дюрсо": "Бронируйте дегустацию заранее — в сезон свободных мест мало.",
  "Каменномостский": "К водопадам Руфабго лучше идти с утра — меньше людей и прохладнее.",
  "Утриш": "Диких пляжей несколько — до дальних добираться 30-40 мин пешком, но они пустые.",
  "Сукко": "Осенью кипарисы окрашиваются в рыжий цвет — пик красоты в октябре-ноябре.",
  "Кабардинка": "Старый парк компактный, 1.5-2 часа хватит на всё. Рядом хорошие пляжи.",
};

export function getTravelWidgets(city) {
  return {
    weather: weatherData[city] || null,
    tickets: ticketsData[city] || null,
    hotels: hotelsData[city] || null,
    carRental: carRentalData,
    events: eventsData[city] || null,
    tip: travelTips[city] || null,
  };
}
