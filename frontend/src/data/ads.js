export const adSpots = [
  {
    id: "ad-1",
    isAd: true,
    title: "Coffee Like",
    description: "Ароматный раф-лавандовый и свежие круассаны. Идеальная остановка, чтобы набраться сил перед следующей точкой!",
    category: "Кофейня",
    mediaUrls: [
      "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&h=1200&fit=crop"
    ],
    geoLat: 44.89,
    geoLng: 37.32,
    city: "Анапа",
    storyText: "А по дороге заскочим в Coffee Like — здесь делают лучший раф на побережье. Заряжаемся кофеином и едем дальше! ☕",
    promoLabel: "Партнёр маршрута",
    discount: "−15% по промокоду КРАЕВЕД",
  },
  {
    id: "ad-2",
    isAd: true,
    title: "Винотека «Шато де Талю»",
    description: "Дегустация краснодарских вин в атмосферном зале с видом на виноградники. 12 сортов на выбор.",
    category: "Винотека",
    mediaUrls: [
      "https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800&h=1200&fit=crop"
    ],
    geoLat: 44.63,
    geoLng: 37.82,
    city: "Геленджик",
    storyText: "Между точками маршрута — остановка для гурманов! «Шато де Талю» — дегустация местных вин прямо среди виноградников 🍇",
    promoLabel: "Рекомендуем",
    discount: "Бесплатная дегустация при бронировании",
  },
  {
    id: "ad-3",
    isAd: true,
    title: "Ресторан «Баран-Рапан»",
    description: "Авторская кухня с кавказским характером. Панорамный вид на горы, мясо на углях и домашнее вино.",
    category: "Ресторан",
    mediaUrls: [
      "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=1200&fit=crop"
    ],
    geoLat: 43.59,
    geoLng: 39.73,
    city: "Сочи",
    storyText: "Время обеда! «Баран-Рапан» — тут горы на тарелке и за окном. Шашлык, хачапури и вид, который хочется сфоткать 📷",
    promoLabel: "Партнёр маршрута",
    discount: "−10% на всё меню",
  },
  {
    id: "ad-4",
    isAd: true,
    title: "Surf Coffee",
    description: "Кофейня прямо на набережной. Матча-латте, авокадо-тосты и вайб калифорнийского побережья.",
    category: "Кофейня",
    mediaUrls: [
      "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&h=1200&fit=crop"
    ],
    geoLat: 44.56,
    geoLng: 38.08,
    city: "Геленджик",
    storyText: "Быстрая кофе-пауза в Surf Coffee на набережной. Матча и морской бриз — идеальный комбо перед дорогой 🏄‍♂️",
    promoLabel: "Рекомендуем",
    discount: null,
  },
];

export function insertAdsIntoRoute(routePlaces) {
  if (routePlaces.length <= 2) return routePlaces;

  const result = [...routePlaces];
  const shuffled = [...adSpots].sort(() => Math.random() - 0.5);

  const insertPositions = [];
  if (result.length >= 3) insertPositions.push(2);
  if (result.length >= 5) insertPositions.push(4);

  insertPositions.forEach((pos, i) => {
    if (shuffled[i]) {
      result.splice(pos + i, 0, shuffled[i]);
    }
  });

  return result;
}
