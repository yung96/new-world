import { createContext, useContext, useState, useCallback, useMemo } from "react";
import { places } from "../data/places";
import { insertAdsIntoRoute } from "../data/ads";

const AppContext = createContext(null);

let routeIdCounter = 0;

function orderByNearest(selected) {
  if (selected.length <= 1) return selected;
  const ordered = [selected[0]];
  const remaining = selected.slice(1);
  while (remaining.length > 0) {
    const last = ordered[ordered.length - 1];
    let nearestIdx = 0;
    let nearestDist = Infinity;
    remaining.forEach((p, i) => {
      const dist = Math.sqrt(
        Math.pow(p.geoLat - last.geoLat, 2) +
        Math.pow(p.geoLng - last.geoLng, 2)
      );
      if (dist < nearestDist) {
        nearestDist = dist;
        nearestIdx = i;
      }
    });
    ordered.push(remaining.splice(nearestIdx, 1)[0]);
  }
  return ordered;
}

function autoName(routePlaces, type) {
  const cities = [...new Set(routePlaces.map((p) => p.city))];
  const prefix = type === "ai" ? "AI: " : "";
  return prefix + cities.slice(0, 3).join(" → ") + (cities.length > 3 ? " …" : "");
}

export function AppProvider({ children }) {
  const [selectedInterests, setSelectedInterests] = useState([]);
  const [savedRoutes, setSavedRoutes] = useState([]);
  const [activeRouteId, setActiveRouteId] = useState(null);
  const [favorites, setFavorites] = useState([2, 5, 9]);
  const [onboardingDone, setOnboardingDone] = useState(false);
  const [isAuthed, setIsAuthed] = useState(false);

  const login = useCallback((phone) => {
    setIsAuthed(true);
  }, []);

  const logout = useCallback(() => {
    setIsAuthed(false);
  }, []);

  const activeRoute = useMemo(
    () => savedRoutes.find((r) => r.id === activeRouteId) || null,
    [savedRoutes, activeRouteId]
  );

  const route = activeRoute?.places || [];
  const routeWithAds = activeRoute?.placesWithAds || [];

  const saveRoute = useCallback((routeObj) => {
    setSavedRoutes((prev) => [routeObj, ...prev]);
    setActiveRouteId(routeObj.id);
  }, []);

  const deleteRoute = useCallback((id) => {
    setSavedRoutes((prev) => prev.filter((r) => r.id !== id));
    setActiveRouteId((prev) => (prev === id ? null : prev));
  }, []);

  const generateRoute = useCallback((interestIds, { dateStart, dateEnd, location } = {}) => {
    const matched = places.filter((p) =>
      p.interestIds.some((id) => interestIds.includes(id))
    );

    const sorted = [...matched].sort((a, b) => {
      const aScore = a.interestIds.filter((id) => interestIds.includes(id)).length;
      const bScore = b.interestIds.filter((id) => interestIds.includes(id)).length;
      return bScore - aScore;
    });

    let maxPlaces = 6;
    if (dateStart && dateEnd) {
      const days = Math.max(1, Math.round((new Date(dateEnd) - new Date(dateStart)) / 86400000));
      if (days <= 2) maxPlaces = 3;
      else if (days <= 4) maxPlaces = 5;
      else maxPlaces = 7;
    }

    const selected = sorted.slice(0, maxPlaces);
    const ordered = orderByNearest(selected);

    const id = `route-${++routeIdCounter}-${Date.now()}`;
    const routeObj = {
      id,
      name: autoName(ordered, "ai"),
      places: ordered,
      placesWithAds: insertAdsIntoRoute(ordered),
      dateStart: dateStart || null,
      dateEnd: dateEnd || null,
      location: location || null,
      createdAt: new Date().toISOString(),
      type: "ai",
    };

    saveRoute(routeObj);
    return routeObj;
  }, [saveRoute]);

  const createCustomRoute = useCallback((placeIds, { dateStart, dateEnd, location, name } = {}) => {
    const selected = placeIds.map((pid) => places.find((p) => p.id === pid)).filter(Boolean);
    const ordered = orderByNearest(selected);

    const id = `route-${++routeIdCounter}-${Date.now()}`;
    const routeObj = {
      id,
      name: name || autoName(ordered, "custom"),
      places: ordered,
      placesWithAds: insertAdsIntoRoute(ordered),
      dateStart: dateStart || null,
      dateEnd: dateEnd || null,
      location: location || null,
      createdAt: new Date().toISOString(),
      type: "custom",
    };

    saveRoute(routeObj);
    return routeObj;
  }, [saveRoute]);

  const toggleFavorite = useCallback((placeId) => {
    setFavorites((prev) =>
      prev.includes(placeId)
        ? prev.filter((id) => id !== placeId)
        : [...prev, placeId]
    );
  }, []);

  const addFavorite = useCallback((placeId) => {
    setFavorites((prev) =>
      prev.includes(placeId) ? prev : [...prev, placeId]
    );
  }, []);

  return (
    <AppContext.Provider
      value={{
        selectedInterests,
        setSelectedInterests,
        savedRoutes,
        activeRouteId,
        setActiveRouteId,
        activeRoute,
        route,
        routeWithAds,
        generateRoute,
        createCustomRoute,
        saveRoute,
        deleteRoute,
        favorites,
        toggleFavorite,
        addFavorite,
        onboardingDone,
        setOnboardingDone,
        isAuthed,
        login,
        logout,
      }}
    >
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const ctx = useContext(AppContext);
  if (!ctx) throw new Error("useApp must be inside AppProvider");
  return ctx;
}
