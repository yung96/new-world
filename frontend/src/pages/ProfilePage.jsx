import { useMutation, useQuery } from '@tanstack/react-query'
import { useSessionStore } from '../app/store/sessionStore'
import { authApi } from '../shared/api/endpoints'
import { Card } from '../shared/ui/Card'
import { formatDateTime } from '../shared/lib/format'
import { normalizeError } from '../shared/lib/errors'

export function ProfilePage() {
  const user = useSessionStore((state) => state.user)
  const token = useSessionStore((state) => state.token)
  const setUser = useSessionStore((state) => state.setUser)
  const clearSession = useSessionStore((state) => state.clearSession)

  const meQuery = useQuery({
    queryKey: ['me'],
    queryFn: authApi.me,
    enabled: Boolean(token),
    initialData: user || undefined,
  })

  const refreshMeMutation = useMutation({
    mutationFn: authApi.me,
    onSuccess: (freshUser) => setUser(freshUser),
  })

  return (
    <div className="space-y-4 pb-24 md:pb-0">
      <Card title="Профиль" subtitle="Текущий пользователь из /api/users/me">
        {meQuery.isError ? <p className="text-sm text-rose-600">{normalizeError(meQuery.error)}</p> : null}
        {meQuery.data ? (
          <dl className="grid gap-2 text-sm sm:grid-cols-2">
            <div>
              <dt className="text-zinc-500">ID</dt>
              <dd className="font-medium">{meQuery.data.id}</dd>
            </div>
            <div>
              <dt className="text-zinc-500">Телефон</dt>
              <dd className="font-medium">{meQuery.data.phone}</dd>
            </div>
            <div>
              <dt className="text-zinc-500">Создан</dt>
              <dd className="font-medium">{formatDateTime(meQuery.data.created_at)}</dd>
            </div>
          </dl>
        ) : (
          <p className="text-sm text-zinc-600">Пользователь еще не загружен.</p>
        )}
      </Card>
      <Card title="Сессия">
        <p className="mb-3 break-all text-xs text-zinc-500">JWT: {token || 'no token'}</p>
        <div className="flex flex-wrap gap-2">
          <button
            type="button"
            onClick={() => refreshMeMutation.mutate()}
            className="rounded-full border border-zinc-300 px-4 py-2 text-sm"
          >
            Обновить me
          </button>
          <button
            type="button"
            onClick={clearSession}
            className="rounded-full border border-rose-300 px-4 py-2 text-sm text-rose-700"
          >
            Очистить сессию
          </button>
        </div>
      </Card>
    </div>
  )
}

