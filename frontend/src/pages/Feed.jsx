import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Heart, MessageCircle, Bookmark, Star, Send, Image, ChevronDown, ChevronUp } from "lucide-react";
import { places } from "../data/places";
import { reviews } from "../data/reviews";
import { interests } from "../data/interests";
import { useApp } from "../context/AppContext";

function PostCard({ place, isFav, onToggleFav }) {
  const [showReviews, setShowReviews] = useState(false);
  const [liked, setLiked] = useState(false);
  const postReviews = reviews.filter((r) => r.postId === place.id);
  const placeInterests = interests.filter((i) => place.interestIds.includes(i.id));

  return (
    <div className="bg-white border-b border-gray-100">
      {/* Header */}
      <div className="flex items-center gap-3 px-4 py-3">
        <div className="w-9 h-9 rounded-full instagram-gradient flex items-center justify-center text-white text-xs font-bold">
          {place.title[0]}
        </div>
        <div className="flex-1 min-w-0">
          <p className="font-semibold text-sm text-dark truncate">{place.title}</p>
          <p className="text-xs text-gray-medium">{place.city}</p>
        </div>
        <div className="flex items-center gap-1">
          <Star size={14} className="text-accent fill-accent" />
          <span className="text-sm font-medium">{place.averageRating}</span>
        </div>
      </div>

      {/* Image */}
      <div className="relative aspect-square bg-gray-100">
        <img
          src={place.mediaUrls[0]}
          alt={place.title}
          className="w-full h-full object-cover"
          loading="lazy"
        />
      </div>

      {/* Actions */}
      <div className="flex items-center px-4 py-3">
        <div className="flex items-center gap-4 flex-1">
          <button onClick={() => setLiked(!liked)}>
            <Heart
              size={24}
              className={`transition-colors ${liked ? "text-red-500 fill-red-500" : "text-dark"}`}
              strokeWidth={1.5}
            />
          </button>
          <button onClick={() => setShowReviews(!showReviews)}>
            <MessageCircle size={24} className="text-dark" strokeWidth={1.5} />
          </button>
          <Send size={24} className="text-dark" strokeWidth={1.5} />
        </div>
        <button onClick={() => onToggleFav(place.id)}>
          <Bookmark
            size={24}
            className={`transition-colors ${isFav ? "text-dark fill-dark" : "text-dark"}`}
            strokeWidth={1.5}
          />
        </button>
      </div>

      {/* Description */}
      <div className="px-4 pb-2">
        <p className="text-sm">
          <span className="font-semibold">{place.title}</span>{" "}
          <span className="text-gray-700">{place.description}</span>
        </p>
      </div>

      {/* Interest tags */}
      <div className="flex flex-wrap gap-1.5 px-4 pb-3">
        {placeInterests.slice(0, 4).map((interest) => (
          <span
            key={interest.id}
            className="text-xs bg-gray-light text-gray-500 px-2 py-0.5 rounded-full"
          >
            {interest.emoji} {interest.name}
          </span>
        ))}
      </div>

      {/* Reviews toggle */}
      {postReviews.length > 0 && (
        <button
          onClick={() => setShowReviews(!showReviews)}
          className="px-4 pb-3 text-sm text-gray-medium flex items-center gap-1"
        >
          {showReviews ? "Скрыть" : "Показать"} отзывы ({postReviews.length})
          {showReviews ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
        </button>
      )}

      {/* Reviews section */}
      <AnimatePresence>
        {showReviews && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.3 }}
            className="overflow-hidden"
          >
            <div className="px-4 pb-4 space-y-3">
              {postReviews.map((review) => (
                <div key={review.id} className="bg-gray-light rounded-xl p-3">
                  <div className="flex items-center gap-2 mb-1.5">
                    <div className="w-6 h-6 rounded-full bg-gray-300 flex items-center justify-center text-[10px] font-bold text-white">
                      {review.author.name[0]}
                    </div>
                    <span className="text-xs font-semibold">{review.author.name}</span>
                    <div className="flex ml-auto">
                      {Array.from({ length: 5 }).map((_, i) => (
                        <Star
                          key={i}
                          size={10}
                          className={i < review.rating ? "text-accent fill-accent" : "text-gray-300"}
                        />
                      ))}
                    </div>
                  </div>
                  <p className="text-xs text-gray-600 leading-relaxed">{review.comment}</p>
                  {review.mediaUrls.length > 0 && (
                    <div className="flex gap-2 mt-2">
                      {review.mediaUrls.map((url, i) => (
                        <img
                          key={i}
                          src={url}
                          alt=""
                          className="w-16 h-16 rounded-lg object-cover"
                        />
                      ))}
                    </div>
                  )}
                </div>
              ))}

              {/* Add review button */}
              <button className="w-full flex items-center justify-center gap-2 py-2.5 border-2 border-dashed border-gray-200 rounded-xl text-sm text-gray-400 hover:border-primary hover:text-primary transition-colors">
                <Image size={16} />
                Добавить отзыв с фото
              </button>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default function Feed() {
  const { favorites, toggleFavorite } = useApp();

  return (
    <div className="min-h-dvh bg-white">
      {/* Header */}
      <div className="sticky top-0 z-40 bg-white border-b border-gray-100 px-4 py-3 flex items-center">
        <h1 className="text-xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
          Краевед
        </h1>
      </div>

      {/* Posts */}
      <div>
        {places.map((place) => (
          <PostCard
            key={place.id}
            place={place}
            isFav={favorites.includes(place.id)}
            onToggleFav={toggleFavorite}
          />
        ))}
      </div>
    </div>
  );
}
