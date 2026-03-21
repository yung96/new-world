import { NavLink } from "react-router-dom";
import { Home, Compass, MapPin, User } from "lucide-react";

const tabs = [
  { to: "/feed", icon: Home, label: "Лента" },
  { to: "/swipe", icon: Compass, label: "Свайп" },
  { to: "/route", icon: MapPin, label: "Маршрут" },
  { to: "/profile", icon: User, label: "Профиль" },
];

export default function BottomNav() {
  return (
    <nav className="fixed bottom-0 left-0 right-0 z-50 bg-white border-t border-gray-200 px-2 pb-[env(safe-area-inset-bottom)]">
      <div className="flex justify-around items-center h-14 max-w-lg mx-auto">
        {tabs.map(({ to, icon: Icon, label }) => (
          <NavLink
            key={to}
            to={to}
            className={({ isActive }) =>
              `flex flex-col items-center gap-0.5 text-xs transition-colors ${
                isActive ? "text-primary" : "text-gray-400"
              }`
            }
          >
            <Icon size={24} strokeWidth={1.5} />
            <span>{label}</span>
          </NavLink>
        ))}
      </div>
    </nav>
  );
}
