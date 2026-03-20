import { Link, NavLink, Outlet } from 'react-router-dom'
import { useSessionStore } from '../store/sessionStore'

const navLinkClass = ({ isActive }) =>
  `flex items-center gap-3 rounded-lg px-3 py-2 text-base transition ${
    isActive ? 'font-semibold text-zinc-950' : 'text-zinc-700 hover:bg-zinc-100'
  }`

export function AppLayout() {
  const user = useSessionStore((state) => state.user)
  const clearSession = useSessionStore((state) => state.clearSession)

  return (
    <div className="min-h-screen bg-zinc-50 text-zinc-900">
      <header className="sticky top-0 z-10 border-b border-zinc-200 bg-white md:hidden">
        <div className="mx-auto flex w-full max-w-6xl items-center justify-between px-4 py-3">
          <Link to="/feed" className="text-2xl font-black tracking-tight text-zinc-950">
            kraeved
          </Link>
          <div className="flex items-center gap-3">
            {user ? <span className="text-xs text-zinc-500">{user.phone}</span> : null}
          </div>
        </div>
      </header>

      <div className="mx-auto grid w-full max-w-[1100px] grid-cols-1 gap-6 px-0 md:grid-cols-[220px_1fr] md:px-4 md:py-6">
        <aside className="hidden md:block">
          <div className="sticky top-6">
            <Link to="/feed" className="mb-6 block px-3 text-2xl font-black tracking-tight text-zinc-950">
              kraeved
            </Link>
            <nav className="flex flex-col gap-1">
              <NavLink to="/feed" className={navLinkClass}>
                <span className="text-sm">[H]</span> Лента
              </NavLink>
              <NavLink to="/create" className={navLinkClass}>
                <span className="text-sm">[+]</span> Создать
              </NavLink>
              <NavLink to="/social" className={navLinkClass}>
                <span className="text-sm">[S]</span> Social
              </NavLink>
              <NavLink to="/profile" className={navLinkClass}>
                <span className="text-sm">[P]</span> Профиль
              </NavLink>
            </nav>

            <div className="mt-8 px-3 text-sm text-zinc-500">
              {user ? <p className="mb-2 truncate">{user.phone}</p> : null}
              {user ? (
                <button
                  type="button"
                  onClick={clearSession}
                  className="rounded-md px-2 py-1 text-sm text-zinc-700 hover:bg-zinc-100"
                >
                  Выйти
                </button>
              ) : (
                <Link className="text-sm text-zinc-700 hover:underline" to="/auth">
                  Войти
                </Link>
              )}
            </div>
          </div>
        </aside>

        <main className="min-h-[70vh] max-w-[640px] px-2 pb-20 pt-4 sm:px-0 md:pb-0 md:pt-0">
          <Outlet />
        </main>
      </div>

      <nav className="fixed bottom-0 left-0 right-0 z-20 flex justify-around border-t border-zinc-200 bg-white py-2 md:hidden">
        <NavLink to="/feed" className={navLinkClass}>
          Home
        </NavLink>
        <NavLink to="/create" className={navLinkClass}>
          New
        </NavLink>
        <NavLink to="/social" className={navLinkClass}>
          Social
        </NavLink>
        <NavLink to="/profile" className={navLinkClass}>
          Me
        </NavLink>
      </nav>
    </div>
  )
}

