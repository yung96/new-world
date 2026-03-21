import { useState, useEffect, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { MapPin, ChevronRight, Navigation, Coffee, Tag } from "lucide-react";
import { useApp } from "../context/AppContext";

const DURATION = 5000;

export default function Stories() {
  const { route, routeWithAds, activeRoute } = useApp();
  const navigate = useNavigate();
  const [current, setCurrent] = useState(0);
  const [progress, setProgress] = useState(0);
  const [paused, setPaused] = useState(false);

  const slides = routeWithAds;
  const totalSlides = slides.length + 1;

  const goNext = useCallback(() => {
    if (current < totalSlides - 1) {
      setCurrent((p) => p + 1);
      setProgress(0);
    }
  }, [current, totalSlides]);

  const goPrev = useCallback(() => {
    if (current > 0) {
      setCurrent((p) => p - 1);
      setProgress(0);
    }
  }, [current]);

  useEffect(() => {
    if (paused) return;
    const interval = setInterval(() => {
      setProgress((p) => {
        if (p >= 100) {
          goNext();
          return 0;
        }
        return p + 100 / (DURATION / 50);
      });
    }, 50);
    return () => clearInterval(interval);
  }, [paused, goNext, current]);

  const handleTap = (e) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const x = e.clientX - rect.left;
    if (x < rect.width / 3) {
      goPrev();
    } else {
      goNext();
    }
  };

  if (route.length === 0) {
    navigate("/onboarding", { replace: true });
    return null;
  }

  const isLast = current >= slides.length;
  const item = isLast ? null : slides[current];
  const isAd = item?.isAd;

  const storyPrefixes = [
    "Начнём наше путешествие с",
    "Дальше заглянем в",
    "А потом нас ждёт",
    "Следующая остановка —",
    "На закате отправимся в",
    "И напоследок —",
  ];

  let placeIndex = 0;
  for (let i = 0; i < current && i < slides.length; i++) {
    if (!slides[i].isAd) placeIndex++;
  }

  return (
    <div
      className="fixed inset-0 bg-black z-50 select-none"
      onClick={handleTap}
      onMouseDown={() => setPaused(true)}
      onMouseUp={() => setPaused(false)}
      onTouchStart={() => setPaused(true)}
      onTouchEnd={() => setPaused(false)}
    >
      {/* Progress bars */}
      <div className="absolute top-0 left-0 right-0 z-30 flex gap-1 p-2 pt-[env(safe-area-inset-top,8px)]">
        {Array.from({ length: totalSlides }).map((_, i) => {
          const slideIsAd = i < slides.length && slides[i]?.isAd;
          return (
            <div key={i} className={`flex-1 h-0.5 rounded-full overflow-hidden ${slideIsAd ? "bg-accent/30" : "bg-white/30"}`}>
              <div
                className={`h-full rounded-full transition-all duration-75 ${slideIsAd ? "bg-accent" : "bg-white"}`}
                style={{
                  width:
                    i < current ? "100%" : i === current ? `${progress}%` : "0%",
                }}
              />
            </div>
          );
        })}
      </div>

      <AnimatePresence mode="wait">
        {!isLast && isAd ? (
          /* ===== AD CARD ===== */
          <motion.div
            key={item.id}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.3 }}
            className="absolute inset-0"
          >
            <div
              className="absolute inset-0 bg-cover bg-center"
              style={{ backgroundImage: `url(${item.mediaUrls[0]})` }}
            />
            <div className="absolute inset-0 bg-gradient-to-t from-amber-900/90 via-amber-900/30 to-black/50" />

            <div className="absolute inset-0 flex flex-col justify-end p-6 pb-12 z-20">
              {/* Ad badge */}
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.2 }}
                className="flex items-center gap-1.5 bg-accent/90 backdrop-blur-md px-3 py-1.5 rounded-full w-fit mb-4 text-sm text-white font-semibold"
              >
                <Coffee size={14} />
                {item.promoLabel}
              </motion.div>

              <motion.p
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
                className="text-accent text-sm font-semibold uppercase tracking-wider mb-1"
              >
                А по дороге заедем в
              </motion.p>

              <motion.h1
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4 }}
                className="text-white text-3xl font-bold mb-1 leading-tight"
              >
                {item.title}
              </motion.h1>

              <motion.p
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.45 }}
                className="text-white/50 text-sm mb-3"
              >
                {item.category} · {item.city}
              </motion.p>

              <motion.p
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.5 }}
                className="text-white/85 text-base leading-relaxed"
              >
                {item.storyText}
              </motion.p>

              {item.discount && (
                <motion.div
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ delay: 0.6 }}
                  className="mt-4 flex items-center gap-2 bg-white/15 backdrop-blur-md px-4 py-2.5 rounded-xl w-fit"
                >
                  <Tag size={16} className="text-accent" />
                  <span className="text-white text-sm font-medium">{item.discount}</span>
                </motion.div>
              )}
            </div>
          </motion.div>
        ) : !isLast ? (
          /* ===== PLACE CARD ===== */
          <motion.div
            key={item.id}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.3 }}
            className="absolute inset-0"
          >
            <div
              className="absolute inset-0 bg-cover bg-center"
              style={{ backgroundImage: `url(${item.mediaUrls[0]})` }}
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-black/40" />

            <div className="absolute inset-0 flex flex-col justify-end p-6 pb-12 z-20">
              {item.distanceFromPrev && (
                <motion.div
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: 0.3 }}
                  className="flex items-center gap-1.5 bg-white/20 backdrop-blur-md px-3 py-1.5 rounded-full w-fit mb-4 text-sm text-white/90"
                >
                  <Navigation size={14} />
                  {item.distanceFromPrev} км от предыдущей точки
                </motion.div>
              )}

              <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.2 }}
                className="text-white/60 text-sm mb-2 font-medium"
              >
                {placeIndex + 1} из {route.length} · {item.city}
              </motion.div>

              <motion.p
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
                className="text-secondary text-sm font-semibold uppercase tracking-wider mb-1"
              >
                {storyPrefixes[placeIndex % storyPrefixes.length]}
              </motion.p>

              <motion.h1
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4 }}
                className="text-white text-3xl font-bold mb-3 leading-tight"
              >
                {item.title}
              </motion.h1>

              <motion.p
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.5 }}
                className="text-white/85 text-base leading-relaxed"
              >
                {item.storyText}
              </motion.p>

              <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.6 }}
                className="flex items-center gap-2 mt-4"
              >
                <div className="flex">
                  {Array.from({ length: 5 }).map((_, i) => (
                    <span
                      key={i}
                      className={`text-sm ${
                        i < Math.round(item.averageRating)
                          ? "text-accent"
                          : "text-white/30"
                      }`}
                    >
                      ★
                    </span>
                  ))}
                </div>
                <span className="text-white/60 text-sm">
                  {item.averageRating}
                </span>
              </motion.div>
            </div>
          </motion.div>
        ) : (
          /* ===== FINAL CARD ===== */
          <motion.div
            key="final"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0 }}
            className="absolute inset-0 bg-gradient-to-br from-primary via-primary-dark to-purple-900 flex flex-col items-center justify-center p-8 text-white text-center z-20"
          >
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ type: "spring", stiffness: 200, delay: 0.2 }}
              className="text-7xl mb-6"
            >
              🗺️
            </motion.div>
            <h1 className="text-3xl font-bold mb-3">Маршрут готов!</h1>
            <p className="text-white/80 text-lg mb-2">
              {route.length} мест · ~
              {route.reduce((sum, p) => sum + (p.distanceFromPrev || 0), 0)} км
            </p>
            {activeRoute?.dateStart && activeRoute?.dateEnd && (
              <p className="text-white/70 text-sm mb-2">
                📅 {new Date(activeRoute.dateStart).toLocaleDateString("ru-RU", { day: "numeric", month: "long" })} – {new Date(activeRoute.dateEnd).toLocaleDateString("ru-RU", { day: "numeric", month: "long" })}
              </p>
            )}
            <p className="text-white/60 mb-8">
              Мы собрали для тебя идеальное путешествие по Краснодарскому краю
            </p>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={(e) => {
                e.stopPropagation();
                navigate("/route");
              }}
              className="bg-white text-primary font-semibold px-8 py-4 rounded-2xl text-lg flex items-center gap-2 shadow-xl"
            >
              Посмотреть маршрут
              <ChevronRight size={20} />
            </motion.button>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Location pin indicator */}
      {!isLast && (
        <div className={`absolute top-12 left-4 z-30 flex items-center gap-2 backdrop-blur-md rounded-full px-3 py-1.5 ${isAd ? "bg-accent/30" : "bg-black/30"}`}>
          {isAd ? (
            <Coffee size={14} className="text-accent" />
          ) : (
            <MapPin size={14} className="text-primary" />
          )}
          <span className="text-white text-xs font-medium">{item.city}</span>
        </div>
      )}
    </div>
  );
}
