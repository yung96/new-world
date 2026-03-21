import { useState, useCallback } from "react";
import { motion, useMotionValue, useTransform, animate, AnimatePresence } from "framer-motion";
import { X, Heart, MapPin, Star, RotateCcw, Bookmark } from "lucide-react";
import { places } from "../data/places";
import { interests } from "../data/interests";
import { useApp } from "../context/AppContext";

function SwipeCard({ place, onSwipe, style, isTop }) {
  const x = useMotionValue(0);
  const rotate = useTransform(x, [-300, 0, 300], [-25, 0, 25]);
  const likeOpacity = useTransform(x, [0, 100], [0, 1]);
  const nopeOpacity = useTransform(x, [-100, 0], [1, 0]);

  const placeInterests = interests.filter((i) =>
    place.interestIds.includes(i.id)
  );

  const handleDragEnd = (_, info) => {
    const threshold = 120;
    if (info.offset.x > threshold) {
      animate(x, 500, { duration: 0.3 });
      onSwipe("right");
    } else if (info.offset.x < -threshold) {
      animate(x, -500, { duration: 0.3 });
      onSwipe("left");
    } else {
      animate(x, 0, { type: "spring", stiffness: 500, damping: 30 });
    }
  };

  return (
    <motion.div
      style={{ x, rotate, ...style }}
      drag={isTop ? "x" : false}
      dragConstraints={{ left: 0, right: 0 }}
      dragElastic={0.9}
      onDragEnd={handleDragEnd}
      className="absolute inset-4 top-4 bottom-24 rounded-3xl overflow-hidden shadow-xl cursor-grab active:cursor-grabbing"
    >
      {/* Background */}
      <div
        className="absolute inset-0 bg-cover bg-center"
        style={{ backgroundImage: `url(${place.mediaUrls[0]})` }}
      />
      <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-transparent" />

      {/* Like / Nope stamps */}
      {isTop && (
        <>
          <motion.div
            style={{ opacity: likeOpacity }}
            className="absolute top-8 left-6 z-10 border-4 border-green-400 rounded-xl px-4 py-2 -rotate-12"
          >
            <span className="text-green-400 font-black text-3xl">LIKE</span>
          </motion.div>
          <motion.div
            style={{ opacity: nopeOpacity }}
            className="absolute top-8 right-6 z-10 border-4 border-red-400 rounded-xl px-4 py-2 rotate-12"
          >
            <span className="text-red-400 font-black text-3xl">NOPE</span>
          </motion.div>
        </>
      )}

      {/* Content */}
      <div className="absolute bottom-0 left-0 right-0 p-6 z-10">
        <div className="flex items-center gap-1.5 mb-2">
          <MapPin size={14} className="text-white/70" />
          <span className="text-white/70 text-sm">{place.city}</span>
        </div>
        <h2 className="text-white text-2xl font-bold mb-2">{place.title}</h2>
        <p className="text-white/80 text-sm leading-relaxed line-clamp-2 mb-3">
          {place.description}
        </p>
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-1">
            <Star size={14} className="text-accent fill-accent" />
            <span className="text-white text-sm font-medium">
              {place.averageRating}
            </span>
          </div>
          <div className="flex gap-1.5">
            {placeInterests.slice(0, 3).map((interest) => (
              <span
                key={interest.id}
                className="text-xs bg-white/20 backdrop-blur-sm text-white px-2 py-0.5 rounded-full"
              >
                {interest.emoji} {interest.name}
              </span>
            ))}
          </div>
        </div>
      </div>
    </motion.div>
  );
}

export default function Swipe() {
  const { addFavorite } = useApp();
  const [currentIndex, setCurrentIndex] = useState(0);
  const [gone, setGone] = useState([]);
  const [toast, setToast] = useState(null);

  const visiblePlaces = places.filter((_, i) => !gone.includes(i));
  const allGone = visiblePlaces.length === 0;

  const handleSwipe = useCallback(
    (direction) => {
      if (direction === "right") {
        addFavorite(places[currentIndex].id);
        setToast(places[currentIndex].title);
        setTimeout(() => setToast(null), 1500);
      }
      setGone((prev) => [...prev, currentIndex]);
      setCurrentIndex((prev) => prev + 1);
    },
    [currentIndex, addFavorite]
  );

  const handleReset = () => {
    setGone([]);
    setCurrentIndex(0);
  };

  const handleButton = (direction) => {
    handleSwipe(direction);
  };

  return (
    <div className="min-h-dvh bg-gray-light flex flex-col">
      {/* Header */}
      <div className="bg-white border-b border-gray-100 px-4 py-3 flex items-center justify-center">
        <h1 className="text-lg font-bold text-dark">Открой новые места</h1>
      </div>

      {/* Card stack */}
      <div className="flex-1 relative overflow-hidden">
        {allGone ? (
          <div className="absolute inset-0 flex flex-col items-center justify-center p-8 text-center">
            <div className="text-6xl mb-4">🎉</div>
            <h2 className="text-xl font-bold text-dark mb-2">
              Ты посмотрел все места!
            </h2>
            <p className="text-gray-medium mb-6">
              Понравившиеся места сохранены в избранном
            </p>
            <button
              onClick={handleReset}
              className="flex items-center gap-2 bg-primary text-white px-6 py-3 rounded-xl font-semibold"
            >
              <RotateCcw size={18} />
              Начать заново
            </button>
          </div>
        ) : (
          <>
            {places
              .slice(currentIndex, currentIndex + 3)
              .reverse()
              .map((place, i, arr) => {
                const isTop = i === arr.length - 1;
                const stackIndex = arr.length - 1 - i;
                return (
                  <SwipeCard
                    key={place.id}
                    place={place}
                    isTop={isTop}
                    onSwipe={handleSwipe}
                    style={{
                      scale: 1 - stackIndex * 0.05,
                      translateY: stackIndex * 8,
                      zIndex: arr.length - stackIndex,
                    }}
                  />
                );
              })}
          </>
        )}
      </div>

      {/* Toast */}
      <AnimatePresence>
        {toast && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            className="absolute top-16 left-1/2 -translate-x-1/2 z-50 bg-dark text-white text-sm font-medium px-4 py-2 rounded-full shadow-lg flex items-center gap-2"
          >
            <Bookmark size={14} className="fill-white" />
            {toast} — в избранном
          </motion.div>
        )}
      </AnimatePresence>

      {/* Action buttons */}
      {!allGone && (
        <div className="flex justify-center gap-6 py-4 bg-white border-t border-gray-100">
          <button
            onClick={() => handleButton("left")}
            className="w-16 h-16 rounded-full border-2 border-red-200 flex items-center justify-center shadow-lg shadow-red-500/10 bg-white active:scale-90 transition-transform"
          >
            <X size={28} className="text-red-400" />
          </button>
          <button
            onClick={() => handleButton("right")}
            className="w-16 h-16 rounded-full border-2 border-green-200 flex items-center justify-center shadow-lg shadow-green-500/10 bg-white active:scale-90 transition-transform"
          >
            <Heart size={28} className="text-green-400" />
          </button>
        </div>
      )}
    </div>
  );
}
