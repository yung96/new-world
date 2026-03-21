import { Navigate, useLocation } from "react-router-dom";
import { useApp } from "../context/AppContext";

export default function RequireAuth({ children }) {
  const { isAuthed } = useApp();
  const location = useLocation();

  if (!isAuthed) {
    return <Navigate to="/login" state={{ from: location.pathname }} replace />;
  }

  return children;
}
