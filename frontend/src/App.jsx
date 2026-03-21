import { Routes, Route, Navigate, useLocation } from "react-router-dom";
import BottomNav from "./components/BottomNav";
import RequireAuth from "./components/RequireAuth";
import Onboarding from "./pages/Onboarding";
import Stories from "./pages/Stories";
import RouteSummary from "./pages/RouteSummary";
import Feed from "./pages/Feed";
import Swipe from "./pages/Swipe";
import Profile from "./pages/Profile";
import Login from "./pages/Login";

const HIDE_NAV = ["/", "/onboarding", "/stories", "/login"];

function App() {
  const location = useLocation();
  const showNav = !HIDE_NAV.includes(location.pathname);

  return (
    <div className="flex flex-col min-h-dvh">
      <main className={`flex-1 ${showNav ? "pb-16" : ""}`}>
        <Routes>
          <Route path="/" element={<Navigate to="/onboarding" replace />} />
          <Route path="/onboarding" element={<Onboarding />} />
          <Route path="/stories" element={<Stories />} />
          <Route path="/route" element={<RouteSummary />} />
          <Route path="/login" element={<Login />} />
          <Route path="/feed" element={<RequireAuth><Feed /></RequireAuth>} />
          <Route path="/swipe" element={<RequireAuth><Swipe /></RequireAuth>} />
          <Route path="/profile" element={<RequireAuth><Profile /></RequireAuth>} />
        </Routes>
      </main>
      {showNav && <BottomNav />}
    </div>
  );
}

export default App;
