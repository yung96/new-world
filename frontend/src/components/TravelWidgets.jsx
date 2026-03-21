import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import {
  Cloud, Plane, Train, Hotel, Car, Calendar, Lightbulb,
  ChevronDown, ChevronUp, ExternalLink, Thermometer, Wind, Droplets,
} from "lucide-react";
import { getTravelWidgets } from "../data/travelInfo";

function WidgetSection({ icon: Icon, title, apiSource, children, defaultOpen = false, accentColor = "text-primary" }) {
  const [open, setOpen] = useState(defaultOpen);
  return (
    <div className="border border-gray-100 rounded-xl overflow-hidden">
      <button
        onClick={() => setOpen(!open)}
        className="w-full flex items-center gap-2.5 px-3.5 py-2.5 bg-white hover:bg-gray-50 transition-colors"
      >
        <Icon size={16} className={accentColor} />
        <span className="text-sm font-semibold text-dark flex-1 text-left">{title}</span>
        {apiSource && (
          <span className="text-[9px] text-gray-300 font-mono mr-1">{apiSource}</span>
        )}
        {open ? <ChevronUp size={14} className="text-gray-400" /> : <ChevronDown size={14} className="text-gray-400" />}
      </button>
      <AnimatePresence>
        {open && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.2 }}
            className="overflow-hidden"
          >
            <div className="px-3.5 pb-3 pt-1">{children}</div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

export default function TravelWidgets({ city }) {
  const data = getTravelWidgets(city);
  if (!data.weather && !data.tickets && !data.hotels) return null;

  return (
    <div className="space-y-2 mt-3">
      {/* Weather */}
      {data.weather && (
        <WidgetSection icon={Cloud} title="Погода" apiSource="OpenWeatherMap" defaultOpen={true} accentColor="text-blue-500">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <span className="text-3xl">{data.weather.icon}</span>
              <div>
                <p className="text-xl font-bold text-dark">{data.weather.temp}°C</p>
                <p className="text-xs text-gray-500">{data.weather.condition}</p>
              </div>
            </div>
            <div className="flex gap-3 text-xs text-gray-400">
              <span className="flex items-center gap-1"><Droplets size={12} />{data.weather.humidity}%</span>
              <span className="flex items-center gap-1"><Wind size={12} />{data.weather.wind} м/с</span>
            </div>
          </div>
        </WidgetSection>
      )}

      {/* Tickets */}
      {data.tickets && (
        <WidgetSection icon={Plane} title="Билеты" apiSource="Travelpayouts" accentColor="text-indigo-500">
          <div className="space-y-2">
            {data.tickets.flight && (
              <div className="flex items-center gap-3 bg-indigo-50 rounded-lg p-2.5">
                <Plane size={14} className="text-indigo-500 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-xs font-medium text-dark">{data.tickets.flight.airline}</p>
                  <p className="text-[10px] text-gray-400">{data.tickets.flight.from} · {data.tickets.flight.duration}</p>
                </div>
                <div className="text-right shrink-0">
                  <p className="text-sm font-bold text-indigo-600">от {data.tickets.flight.price} ₽</p>
                  <button className="text-[10px] text-indigo-400 flex items-center gap-0.5">
                    Купить <ExternalLink size={8} />
                  </button>
                </div>
              </div>
            )}
            {data.tickets.train && (
              <div className="flex items-center gap-3 bg-green-50 rounded-lg p-2.5">
                <Train size={14} className="text-green-600 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-xs font-medium text-dark">{data.tickets.train.carrier}</p>
                  <p className="text-[10px] text-gray-400">{data.tickets.train.from} · {data.tickets.train.duration}</p>
                </div>
                <div className="text-right shrink-0">
                  <p className="text-sm font-bold text-green-700">от {data.tickets.train.price} ₽</p>
                  <button className="text-[10px] text-green-500 flex items-center gap-0.5">
                    Купить <ExternalLink size={8} />
                  </button>
                </div>
              </div>
            )}
          </div>
        </WidgetSection>
      )}

      {/* Hotels */}
      {data.hotels && (
        <WidgetSection icon={Hotel} title="Отели" apiSource="Ostrovok API" accentColor="text-rose-500">
          <div className="space-y-2">
            {data.hotels.map((hotel, i) => (
              <div key={i} className="flex items-center gap-3 bg-rose-50 rounded-lg p-2.5">
                <Hotel size={14} className="text-rose-400 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-xs font-medium text-dark truncate">{hotel.name}</p>
                  <p className="text-[10px] text-gray-400">★ {hotel.rating}</p>
                </div>
                <div className="text-right shrink-0">
                  <p className="text-sm font-bold text-rose-600">от {hotel.price} ₽</p>
                  <p className="text-[10px] text-gray-400">за ночь</p>
                </div>
              </div>
            ))}
          </div>
        </WidgetSection>
      )}

      {/* Car rental */}
      {data.carRental && (
        <WidgetSection icon={Car} title="Аренда авто" apiSource="Localrent API" accentColor="text-teal-500">
          <div className="flex gap-2">
            {Object.entries(data.carRental).map(([key, car]) => (
              <div key={key} className="flex-1 bg-teal-50 rounded-lg p-2 text-center">
                <p className="text-[10px] text-teal-600 font-semibold uppercase">{key}</p>
                <p className="text-xs font-medium text-dark mt-0.5">{car.name}</p>
                <p className="text-xs font-bold text-teal-700 mt-1">{car.pricePerDay} ₽/д</p>
              </div>
            ))}
          </div>
        </WidgetSection>
      )}

      {/* Events */}
      {data.events && data.events.length > 0 && (
        <WidgetSection icon={Calendar} title="События" apiSource="KudaGo API" accentColor="text-purple-500">
          <div className="space-y-2">
            {data.events.map((event, i) => (
              <div key={i} className="flex items-center gap-2.5 bg-purple-50 rounded-lg p-2.5">
                <Calendar size={14} className="text-purple-400 shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-xs font-medium text-dark">{event.name}</p>
                  <p className="text-[10px] text-gray-400">{event.date} · {event.venue}</p>
                </div>
              </div>
            ))}
          </div>
        </WidgetSection>
      )}

      {/* Travel tip */}
      {data.tip && (
        <div className="flex items-start gap-2.5 bg-amber-50 border border-amber-100 rounded-xl p-3">
          <Lightbulb size={16} className="text-accent shrink-0 mt-0.5" />
          <div>
            <p className="text-xs font-semibold text-amber-800 mb-0.5">Совет путешественнику</p>
            <p className="text-xs text-amber-700 leading-relaxed">{data.tip}</p>
          </div>
        </div>
      )}
    </div>
  );
}
