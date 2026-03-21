import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import {
  Sparkles, ListChecks, CalendarDays, MapPin, Search,
  Check, ChevronRight, Navigation,
} from "lucide-react";
import { places } from "../data/places";
import { interests } from "../data/interests";
import { useApp } from "../context/AppContext";

const CITIES = [
  "Краснодар", "Сочи", "Геленджик", "Анапа",
  "Красная Поляна", "Абрау-Дюрсо", "Новороссийск",
];

function today() {
  return new Date().toISOString().split("T")[0];
}
function addDays(d, n) {
  const dt = new Date(d);
  dt.setDate(dt.getDate() + n);
  return dt.toISOString().split("T")[0];
}

export default function RouteBuilder({ onDone }) {
  const [tab, setTab] = useState("ai");
  const [dateStart, setDateStart] = useState(today());
  const [dateEnd, setDateEnd] = useState(addDays(today(), 3));
  const [location, setLocation] = useState("Краснодар");
  const [selectedPlaces, setSelectedPlaces] = useState([]);
  const [filterText, setFilterText] = useState("");
  const [filterInterest, setFilterInterest] = useState(null);

  const navigate = useNavigate();
  const { selectedInterests, generateRoute, createCustomRoute } = useApp();

  const togglePlace = (id) => {
    setSelectedPlaces((prev) =>
      prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
    );
  };

  const filteredPlaces = places.filter((p) => {
    const matchText = !filterText || p.title.toLowerCase().includes(filterText.toLowerCase()) || p.city.toLowerCase().includes(filterText.toLowerCase());
    const matchInterest = !filterInterest || p.interestIds.includes(filterInterest);
    return matchText && matchInterest;
  });

  const handleAiGenerate = () => {
    generateRoute(selectedInterests, { dateStart, dateEnd, location });
    navigate("/stories");
    onDone?.();
  };

  const handleCustomCreate = () => {
    if (selectedPlaces.length < 2) return;
    createCustomRoute(selectedPlaces, { dateStart, dateEnd, location });
    navigate("/stories");
    onDone?.();
  };

  return (
    <div className="px-4 py-5">
      {/* Tabs */}
      <div className="flex bg-gray-100 rounded-xl p-1 mb-5">
        <button
          onClick={() => setTab("ai")}
          className={`flex-1 flex items-center justify-center gap-1.5 py-2.5 rounded-lg text-sm font-semibold transition-all ${
            tab === "ai" ? "bg-white text-primary shadow-sm" : "text-gray-400"
          }`}
        >
          <Sparkles size={16} />
          AI маршрут
        </button>
        <button
          onClick={() => setTab("custom")}
          className={`flex-1 flex items-center justify-center gap-1.5 py-2.5 rounded-lg text-sm font-semibold transition-all ${
            tab === "custom" ? "bg-white text-primary shadow-sm" : "text-gray-400"
          }`}
        >
          <ListChecks size={16} />
          Свой маршрут
        </button>
      </div>

      {/* Shared: dates + location */}
      <div className="space-y-3 mb-5">
        <div className="flex gap-3">
          <div className="flex-1">
            <label className="text-xs text-gray-400 font-medium mb-1 block">Начало</label>
            <div className="relative">
              <CalendarDays size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-300" />
              <input
                type="date"
                value={dateStart}
                onChange={(e) => setDateStart(e.target.value)}
                className="w-full pl-10 pr-3 py-2.5 bg-white border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
              />
            </div>
          </div>
          <div className="flex-1">
            <label className="text-xs text-gray-400 font-medium mb-1 block">Конец</label>
            <div className="relative">
              <CalendarDays size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-300" />
              <input
                type="date"
                value={dateEnd}
                min={dateStart}
                onChange={(e) => setDateEnd(e.target.value)}
                className="w-full pl-10 pr-3 py-2.5 bg-white border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
              />
            </div>
          </div>
        </div>

        <div>
          <label className="text-xs text-gray-400 font-medium mb-1 block">Текущее местоположение</label>
          <div className="relative">
            <Navigation size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-300" />
            <select
              value={location}
              onChange={(e) => setLocation(e.target.value)}
              className="w-full pl-10 pr-3 py-2.5 bg-white border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 appearance-none"
            >
              {CITIES.map((c) => (
                <option key={c} value={c}>{c}</option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {/* AI tab */}
      {tab === "ai" && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <p className="text-xs text-gray-400 font-medium mb-2">Твои интересы</p>
          {selectedInterests.length > 0 ? (
            <div className="flex flex-wrap gap-1.5 mb-5">
              {interests
                .filter((i) => selectedInterests.includes(i.id))
                .map((interest) => (
                  <span
                    key={interest.id}
                    className="text-xs bg-primary/10 text-primary px-2.5 py-1 rounded-full font-medium"
                  >
                    {interest.emoji} {interest.name}
                  </span>
                ))}
            </div>
          ) : (
            <p className="text-xs text-gray-300 mb-5">
              Интересы не выбраны — маршрут будет случайным
            </p>
          )}

          <div className="bg-gradient-to-r from-indigo-50 to-purple-50 border border-indigo-100 rounded-2xl p-4 mb-5">
            <div className="flex items-start gap-3">
              <Sparkles size={20} className="text-indigo-500 shrink-0 mt-0.5" />
              <div>
                <p className="text-sm font-semibold text-dark mb-1">Нейросеть подберёт маршрут</p>
                <p className="text-xs text-gray-500 leading-relaxed">
                  На основе твоих интересов, дат и местоположения мы составим
                  оптимальный маршрут с учётом расстояний и сезонности.
                </p>
                <p className="text-[10px] text-gray-300 mt-2 font-mono">
                  API: POST /api/routes/generate → GPT-4o / собственная модель
                </p>
              </div>
            </div>
          </div>

          <button
            onClick={handleAiGenerate}
            className="w-full bg-gradient-to-r from-primary to-secondary text-white font-semibold py-3.5 rounded-2xl flex items-center justify-center gap-2 shadow-lg shadow-primary/20"
          >
            <Sparkles size={18} />
            Сгенерировать маршрут
          </button>
        </motion.div>
      )}

      {/* Custom tab */}
      {tab === "custom" && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
        >
          {/* Filter */}
          <div className="flex gap-2 mb-3">
            <div className="relative flex-1">
              <Search size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-300" />
              <input
                type="text"
                placeholder="Поиск мест..."
                value={filterText}
                onChange={(e) => setFilterText(e.target.value)}
                className="w-full pl-10 pr-3 py-2.5 bg-white border border-gray-200 rounded-xl text-sm focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
              />
            </div>
          </div>

          {/* Interest filter chips */}
          <div className="flex gap-1.5 overflow-x-auto pb-2 mb-3 -mx-1 px-1 scrollbar-hide">
            <button
              onClick={() => setFilterInterest(null)}
              className={`shrink-0 text-xs px-2.5 py-1 rounded-full font-medium transition-all ${
                !filterInterest ? "bg-primary text-white" : "bg-gray-100 text-gray-400"
              }`}
            >
              Все
            </button>
            {interests.map((i) => (
              <button
                key={i.id}
                onClick={() => setFilterInterest(filterInterest === i.id ? null : i.id)}
                className={`shrink-0 text-xs px-2.5 py-1 rounded-full font-medium transition-all whitespace-nowrap ${
                  filterInterest === i.id ? "bg-primary text-white" : "bg-gray-100 text-gray-400"
                }`}
              >
                {i.emoji} {i.name}
              </button>
            ))}
          </div>

          {/* Places list */}
          <div className="space-y-2 max-h-[40vh] overflow-y-auto mb-5">
            {filteredPlaces.map((place) => {
              const isSelected = selectedPlaces.includes(place.id);
              return (
                <button
                  key={place.id}
                  onClick={() => togglePlace(place.id)}
                  className={`w-full flex items-center gap-3 p-2.5 rounded-xl border transition-all text-left ${
                    isSelected
                      ? "border-primary bg-primary/5"
                      : "border-gray-100 bg-white hover:border-gray-200"
                  }`}
                >
                  <img
                    src={place.mediaUrls[0]}
                    alt={place.title}
                    className="w-14 h-14 rounded-lg object-cover shrink-0"
                  />
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-semibold text-dark truncate">{place.title}</p>
                    <div className="flex items-center gap-1.5 mt-0.5">
                      <MapPin size={10} className="text-gray-300" />
                      <span className="text-xs text-gray-400">{place.city}</span>
                      <span className="text-xs text-accent ml-1">★ {place.averageRating}</span>
                    </div>
                  </div>
                  <div className={`w-6 h-6 rounded-full border-2 flex items-center justify-center shrink-0 transition-all ${
                    isSelected ? "border-primary bg-primary" : "border-gray-200"
                  }`}>
                    {isSelected && <Check size={14} className="text-white" />}
                  </div>
                </button>
              );
            })}
          </div>

          <button
            onClick={handleCustomCreate}
            disabled={selectedPlaces.length < 2}
            className={`w-full py-3.5 rounded-2xl font-semibold flex items-center justify-center gap-2 transition-all ${
              selectedPlaces.length >= 2
                ? "bg-primary text-white shadow-lg shadow-primary/20"
                : "bg-gray-100 text-gray-300 cursor-not-allowed"
            }`}
          >
            Создать маршрут ({selectedPlaces.length} мест)
            <ChevronRight size={18} />
          </button>
        </motion.div>
      )}
    </div>
  );
}
