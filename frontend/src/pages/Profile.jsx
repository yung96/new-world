import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { MapPin, Star, Route, Settings, ChevronRight } from "lucide-react";
import { achievements } from "../data/achievements";
import { places } from "../data/places";
import { useApp } from "../context/AppContext";

export default function Profile() {
  const navigate = useNavigate();
  const { favorites, savedRoutes, setOnboardingDone } = useApp();
  const favPlaces = places.filter((p) => favorites.includes(p.id));
  const unlockedCount = achievements.filter((a) => a.unlocked).length;

  return (
    <div className="min-h-dvh bg-gray-light">
      {/* Header */}
      <div className="bg-white px-6 pt-[env(safe-area-inset-top,16px)] pb-6 border-b border-gray-100">
        <div className="flex items-center justify-between mt-4">
          <h1 className="text-xl font-bold text-dark">Профиль</h1>
          <button className="w-9 h-9 rounded-full bg-gray-light flex items-center justify-center">
            <Settings size={18} className="text-gray-500" />
          </button>
        </div>

        {/* User info */}
        <div className="flex items-center gap-4 mt-5">
          <div className="w-20 h-20 rounded-full instagram-gradient p-0.5">
            <div className="w-full h-full rounded-full bg-white flex items-center justify-center text-2xl">
              🧭
            </div>
          </div>
          <div className="flex-1">
            <h2 className="text-lg font-bold text-dark">Путешественник</h2>
            <p className="text-sm text-gray-medium">Краснодарский край</p>
          </div>
        </div>

        {/* Stats */}
        <div className="flex gap-6 mt-5">
          <div className="text-center">
            <p className="text-lg font-bold text-dark">{favPlaces.length}</p>
            <p className="text-xs text-gray-medium">Избранное</p>
          </div>
          <div className="text-center">
            <p className="text-lg font-bold text-dark">{unlockedCount}</p>
            <p className="text-xs text-gray-medium">Достижения</p>
          </div>
          <div className="text-center">
            <p className="text-lg font-bold text-dark">{savedRoutes.length}</p>
            <p className="text-xs text-gray-medium">Маршрута</p>
          </div>
          <div className="text-center">
            <p className="text-lg font-bold text-dark">12</p>
            <p className="text-xs text-gray-medium">Отзывов</p>
          </div>
        </div>
      </div>

      {/* New route button */}
      <div className="px-4 mt-4 space-y-2">
        <button
          onClick={() => navigate("/route")}
          className="w-full bg-gradient-to-r from-primary to-secondary text-white font-semibold py-3.5 rounded-2xl flex items-center justify-center gap-2 shadow-lg shadow-primary/20"
        >
          <Route size={20} />
          Сгенерировать новый маршрут
        </button>
        <button
          onClick={() => {
            setOnboardingDone(false);
            navigate("/onboarding");
          }}
          className="w-full border-2 border-gray-200 text-gray-500 font-semibold py-3 rounded-2xl flex items-center justify-center gap-2 hover:border-primary hover:text-primary transition-all"
        >
          🌟 Пройти онбординг заново
        </button>
      </div>

      {/* Achievements */}
      <div className="px-4 mt-6">
        <h3 className="text-base font-bold text-dark mb-3">Достижения</h3>
        <div className="grid grid-cols-2 gap-2.5">
          {achievements.map((ach, i) => (
            <motion.div
              key={ach.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.05 }}
              className={`bg-white rounded-2xl p-3.5 border transition-all ${
                ach.unlocked
                  ? "border-primary/20 shadow-sm"
                  : "border-gray-100 opacity-50"
              }`}
            >
              <div className="flex items-start gap-2.5">
                <span className="text-2xl">{ach.icon}</span>
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-semibold text-dark truncate">
                    {ach.name}
                  </p>
                  <p className="text-xs text-gray-medium mt-0.5 line-clamp-2">
                    {ach.description}
                  </p>
                </div>
              </div>
              {ach.unlocked && (
                <div className="mt-2 text-xs text-primary font-medium">
                  ✓ Получено
                </div>
              )}
            </motion.div>
          ))}
        </div>
      </div>

      {/* Favorites */}
      <div className="px-4 mt-6 pb-8">
        <h3 className="text-base font-bold text-dark mb-3">
          Избранное ({favPlaces.length})
        </h3>
        {favPlaces.length === 0 ? (
          <div className="bg-white rounded-2xl p-6 text-center border border-gray-100">
            <p className="text-3xl mb-2">💫</p>
            <p className="text-sm text-gray-medium">
              Свайпайте места вправо, чтобы добавить в избранное
            </p>
          </div>
        ) : (
          <div className="space-y-2.5">
            {favPlaces.map((place, i) => (
              <motion.div
                key={place.id}
                initial={{ opacity: 0, x: -10 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: i * 0.05 }}
                className="bg-white rounded-2xl overflow-hidden border border-gray-100 flex"
              >
                <img
                  src={place.mediaUrls[0]}
                  alt={place.title}
                  className="w-20 h-20 object-cover"
                />
                <div className="flex-1 p-3 min-w-0 flex items-center">
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-semibold text-dark truncate">
                      {place.title}
                    </p>
                    <div className="flex items-center gap-1.5 mt-1">
                      <MapPin size={12} className="text-gray-medium" />
                      <span className="text-xs text-gray-medium">
                        {place.city}
                      </span>
                    </div>
                    <div className="flex items-center gap-1 mt-1">
                      <Star
                        size={12}
                        className="text-accent fill-accent"
                      />
                      <span className="text-xs text-gray-500">
                        {place.averageRating}
                      </span>
                    </div>
                  </div>
                  <ChevronRight size={16} className="text-gray-300" />
                </div>
              </motion.div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
