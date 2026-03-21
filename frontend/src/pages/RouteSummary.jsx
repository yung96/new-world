import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import {
  MapPin, Clock, Route, ChevronRight, Sparkles, Coffee, Tag,
  LogIn, Plus, ArrowLeft, Trash2, Play, CalendarDays,
} from "lucide-react";
import { useApp } from "../context/AppContext";
import TravelWidgets from "../components/TravelWidgets";
import RouteBuilder from "../components/RouteBuilder";

function RouteDetail({ routeObj, onBack }) {
  const navigate = useNavigate();
  const { setActiveRouteId, deleteRoute, isAuthed } = useApp();
  const { places: rPlaces, placesWithAds, dateStart, dateEnd, name } = routeObj;

  const totalKm = rPlaces.reduce((sum, p) => sum + (p.distanceFromPrev || 0), 0);
  const estimatedHours = Math.round((totalKm / 60) * 10) / 10;

  const handleStories = () => {
    setActiveRouteId(routeObj.id);
    navigate("/stories");
  };

  const handleDelete = () => {
    deleteRoute(routeObj.id);
    onBack();
  };

  const fmtDate = (d) => d ? new Date(d).toLocaleDateString("ru-RU", { day: "numeric", month: "short" }) : null;

  return (
    <div className="min-h-dvh bg-gray-light">
      {/* Header */}
      <div className="bg-white px-4 pt-[env(safe-area-inset-top,16px)] pb-4 border-b border-gray-100">
        <div className="flex items-center gap-3 mt-4">
          <button onClick={onBack} className="w-8 h-8 rounded-full bg-gray-light flex items-center justify-center">
            <ArrowLeft size={18} className="text-gray-500" />
          </button>
          <div className="flex-1 min-w-0">
            <h1 className="text-lg font-bold text-dark truncate">{name}</h1>
            <div className="flex gap-3 mt-1 text-xs text-gray-400">
              <span className="flex items-center gap-1"><MapPin size={12} />{rPlaces.length} мест</span>
              <span className="flex items-center gap-1"><Route size={12} />~{totalKm} км</span>
              <span className="flex items-center gap-1"><Clock size={12} />~{estimatedHours} ч</span>
              {dateStart && dateEnd && (
                <span className="flex items-center gap-1"><CalendarDays size={12} />{fmtDate(dateStart)} – {fmtDate(dateEnd)}</span>
              )}
            </div>
          </div>
        </div>
        <div className="flex gap-2 mt-3">
          <button
            onClick={handleStories}
            className="flex-1 bg-primary text-white font-semibold py-2.5 rounded-xl text-sm flex items-center justify-center gap-1.5"
          >
            <Play size={16} /> Смотреть Stories
          </button>
          <button
            onClick={handleDelete}
            className="w-10 h-10 rounded-xl border border-red-200 flex items-center justify-center"
          >
            <Trash2 size={16} className="text-red-400" />
          </button>
        </div>
      </div>

      {/* Map placeholder */}
      <div className="mx-4 mt-4 bg-white rounded-2xl overflow-hidden shadow-sm border border-gray-100">
        <div className="relative h-40 bg-gradient-to-br from-blue-50 to-green-50">
          <svg viewBox="0 0 400 180" className="w-full h-full absolute inset-0">
            {rPlaces.map((place, i) => {
              const x = 40 + (i * 320) / Math.max(rPlaces.length - 1, 1);
              const y = 30 + Math.sin(i * 1.2) * 40 + 50;
              const next = rPlaces[i + 1];
              const nx = next ? 40 + ((i + 1) * 320) / Math.max(rPlaces.length - 1, 1) : null;
              const ny = next ? 30 + Math.sin((i + 1) * 1.2) * 40 + 50 : null;
              return (
                <g key={place.id}>
                  {nx !== null && <line x1={x} y1={y} x2={nx} y2={ny} stroke="#E1306C" strokeWidth="2" strokeDasharray="6 4" opacity="0.5" />}
                  <circle cx={x} cy={y} r="8" fill="#E1306C" opacity="0.15" />
                  <circle cx={x} cy={y} r="4" fill="#E1306C" />
                  <text x={x} y={y - 12} textAnchor="middle" className="text-[8px] fill-gray-500 font-medium">{place.city}</text>
                </g>
              );
            })}
          </svg>
          <div className="absolute bottom-2 right-2 bg-white/80 backdrop-blur-sm text-[10px] text-gray-400 px-2 py-0.5 rounded-lg">
            Карта-превью · Yandex Maps
          </div>
        </div>
      </div>

      {/* Timeline */}
      <div className="px-4 mt-5 pb-6">
        {placesWithAds.map((item, i) => {
          const isAd = item.isAd;
          let placeNum = 0;
          for (let j = 0; j <= i; j++) {
            if (!placesWithAds[j].isAd) placeNum++;
          }
          return (
            <motion.div
              key={item.id}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: i * 0.08 }}
              className="flex gap-3 relative"
            >
              <div className="flex flex-col items-center">
                <div className={`w-7 h-7 rounded-full flex items-center justify-center text-[10px] font-bold shrink-0 z-10 ${isAd ? "bg-accent text-white" : "bg-primary text-white"}`}>
                  {isAd ? <Coffee size={12} /> : placeNum}
                </div>
                {i < placesWithAds.length - 1 && (
                  <div className={`w-0.5 flex-1 min-h-6 ${isAd ? "bg-accent/20" : "bg-primary/20"}`} />
                )}
              </div>

              {isAd ? (
                <div className="bg-amber-50 rounded-xl overflow-hidden shadow-sm border border-accent/20 mb-3 flex-1">
                  <div className="flex">
                    <img src={item.mediaUrls[0]} alt={item.title} className="w-20 h-20 object-cover" />
                    <div className="p-2.5 flex-1 min-w-0">
                      <span className="text-[9px] bg-accent/15 text-amber-700 px-1.5 py-0.5 rounded-full font-semibold">{item.promoLabel}</span>
                      <h3 className="font-semibold text-xs text-dark truncate mt-1">{item.title}</h3>
                      <p className="text-[10px] text-gray-400">{item.category} · {item.city}</p>
                      {item.discount && (
                        <div className="flex items-center gap-1 mt-1">
                          <Tag size={9} className="text-accent" />
                          <span className="text-[10px] text-amber-700 font-medium">{item.discount}</span>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              ) : (
                <div className="mb-3 flex-1">
                  <div className="bg-white rounded-xl overflow-hidden shadow-sm border border-gray-100">
                    <div className="flex">
                      <img src={item.mediaUrls[0]} alt={item.title} className="w-20 h-20 object-cover" />
                      <div className="p-2.5 flex-1 min-w-0">
                        <h3 className="font-semibold text-xs text-dark truncate">{item.title}</h3>
                        <p className="text-[10px] text-gray-400 mt-0.5">{item.city}</p>
                        <div className="flex items-center gap-1 mt-1">
                          <span className="text-accent text-[10px]">★</span>
                          <span className="text-[10px] text-gray-500">{item.averageRating}</span>
                        </div>
                        {item.distanceFromPrev && (
                          <p className="text-[10px] text-gray-400 mt-0.5">📍 {item.distanceFromPrev} км</p>
                        )}
                      </div>
                    </div>
                  </div>
                  {(() => {
                    const prevPlaces = placesWithAds.slice(0, i).filter(x => !x.isAd);
                    const prevCity = prevPlaces.length > 0 ? prevPlaces[prevPlaces.length - 1].city : null;
                    return item.city !== prevCity ? <TravelWidgets city={item.city} /> : null;
                  })()}
                </div>
              )}
            </motion.div>
          );
        })}
      </div>
    </div>
  );
}

function RouteList({ onSelect, onNew }) {
  const { savedRoutes } = useApp();

  const fmtDate = (d) => d ? new Date(d).toLocaleDateString("ru-RU", { day: "numeric", month: "short" }) : null;

  return (
    <div className="min-h-dvh bg-gray-light">
      <div className="bg-white px-6 pt-[env(safe-area-inset-top,16px)] pb-4 border-b border-gray-100">
        <div className="flex items-center justify-between mt-4">
          <h1 className="text-2xl font-bold text-dark">Маршруты</h1>
          <button
            onClick={onNew}
            className="w-9 h-9 rounded-full bg-primary flex items-center justify-center shadow-md shadow-primary/20"
          >
            <Plus size={20} className="text-white" />
          </button>
        </div>
        <p className="text-sm text-gray-400 mt-1">{savedRoutes.length} маршрут(ов)</p>
      </div>

      <div className="px-4 mt-4 pb-6 space-y-3">
        {savedRoutes.map((r, idx) => {
          const totalKm = r.places.reduce((s, p) => s + (p.distanceFromPrev || 0), 0);
          return (
            <motion.button
              key={r.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.05 }}
              onClick={() => onSelect(r)}
              className="w-full bg-white rounded-2xl overflow-hidden shadow-sm border border-gray-100 text-left"
            >
              {/* Mini preview images */}
              <div className="flex h-24">
                {r.places.slice(0, 4).map((p, i) => (
                  <div key={p.id} className="flex-1 relative">
                    <img src={p.mediaUrls[0]} alt="" className="w-full h-full object-cover" />
                    {i < Math.min(r.places.length, 4) - 1 && (
                      <div className="absolute right-0 top-0 bottom-0 w-px bg-white" />
                    )}
                  </div>
                ))}
              </div>
              <div className="p-3.5">
                <div className="flex items-center gap-2 mb-1.5">
                  {r.type === "ai" && (
                    <span className="text-[10px] bg-indigo-50 text-indigo-500 px-1.5 py-0.5 rounded-full font-semibold flex items-center gap-0.5">
                      <Sparkles size={10} /> AI
                    </span>
                  )}
                  <h3 className="text-sm font-bold text-dark truncate flex-1">{r.name}</h3>
                  <ChevronRight size={16} className="text-gray-300 shrink-0" />
                </div>
                <div className="flex flex-wrap gap-x-3 gap-y-1 text-xs text-gray-400">
                  <span className="flex items-center gap-1"><MapPin size={11} />{r.places.length} мест</span>
                  <span className="flex items-center gap-1"><Route size={11} />~{totalKm} км</span>
                  {r.dateStart && r.dateEnd && (
                    <span className="flex items-center gap-1">
                      <CalendarDays size={11} />
                      {fmtDate(r.dateStart)} – {fmtDate(r.dateEnd)}
                    </span>
                  )}
                </div>
              </div>
            </motion.button>
          );
        })}
      </div>
    </div>
  );
}

export default function RouteSummary() {
  const { savedRoutes, setActiveRouteId } = useApp();
  const [view, setView] = useState("auto");
  const [detailRoute, setDetailRoute] = useState(null);

  const handleSelect = (routeObj) => {
    setActiveRouteId(routeObj.id);
    setDetailRoute(routeObj);
    setView("detail");
  };

  if (view === "detail" && detailRoute) {
    return <RouteDetail routeObj={detailRoute} onBack={() => { setView("auto"); setDetailRoute(null); }} />;
  }

  if (view === "builder" || savedRoutes.length === 0) {
    return (
      <div className="min-h-dvh bg-gray-light">
        <div className="bg-white px-6 pt-[env(safe-area-inset-top,16px)] pb-4 border-b border-gray-100">
          <div className="flex items-center gap-3 mt-4">
            {savedRoutes.length > 0 && (
              <button onClick={() => setView("auto")} className="w-8 h-8 rounded-full bg-gray-light flex items-center justify-center">
                <ArrowLeft size={18} className="text-gray-500" />
              </button>
            )}
            <h1 className="text-xl font-bold text-dark">Новый маршрут</h1>
          </div>
        </div>
        <RouteBuilder onDone={() => setView("auto")} />
      </div>
    );
  }

  return <RouteList onSelect={handleSelect} onNew={() => setView("builder")} />;
}
