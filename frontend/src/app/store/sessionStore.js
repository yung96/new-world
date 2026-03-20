import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export const useSessionStore = create(
  persist(
    (set) => ({
      token: null,
      user: null,
      setSession: ({ token, user }) => set({ token, user }),
      setUser: (user) => set({ user }),
      clearSession: () => set({ token: null, user: null }),
    }),
    {
      name: 'kraeved-session',
      partialize: (state) => ({ token: state.token, user: state.user }),
    },
  ),
)
