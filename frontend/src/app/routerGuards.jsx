import { Navigate } from 'react-router-dom'
import { useSessionStore } from './store/sessionStore'

export function ProtectedRoute({ children }) {
  const token = useSessionStore((state) => state.token)
  if (!token) {
    return <Navigate to="/auth" replace />
  }
  return children
}

export function RootRedirect() {
  const token = useSessionStore((state) => state.token)
  return <Navigate to={token ? '/feed' : '/auth'} replace />
}

