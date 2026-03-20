import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import { useSessionStore } from '../app/store/sessionStore'
import { authApi, favoritesApi } from '../shared/api/endpoints'
import { Card } from '../shared/ui/Card'
import { formatDateTime } from '../shared/lib/format'
import { normalizeError } from '../shared/lib/errors'

export function ProfilePage() {
  const queryClient = useQueryClient()
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
  const favoritesQuery = useQuery({
    queryKey: ['favorites', 'profile'],
    queryFn: () => favoritesApi.list({ page: 1, pageSize: 50 }),
    enabled: Boolean(token),
  })
  const removeFavoriteMutation = useMutation({
    mutationFn: (postId) => favoritesApi.remove(postId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['favorites'] })
    },
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
      <Card title="Избранные места" subtitle="Список из /api/user/favorites">
        {favoritesQuery.isLoading ? <p className="text-sm text-zinc-500">Загрузка...</p> : null}
        {favoritesQuery.isError ? (
          <p className="text-sm text-rose-600">{normalizeError(favoritesQuery.error)}</p>
        ) : null}
        <div className="space-y-2">
          {favoritesQuery.data?.items?.map((post) => (
            <div key={post.id} className="rounded-xl border border-zinc-200 p-3">
              <p className="text-sm font-semibold">{post.title}</p>
              <p className="text-xs text-zinc-500">#{post.id}</p>
              <div className="mt-2 flex items-center gap-3">
                <Link to={`/posts/${post.id}`} className="inline-block text-xs text-indigo-700">
                  Открыть
                </Link>
                <button
                  type="button"
                  onClick={() => removeFavoriteMutation.mutate(post.id)}
                  className="text-xs text-rose-700"
                >
                  Убрать из избранного
                </button>
              </div>
            </div>
          ))}
          {!favoritesQuery.isLoading && !favoritesQuery.data?.items?.length ? (
            <p className="text-sm text-zinc-500">Избранное пока пустое.</p>
          ) : null}
        </div>
      </Card>
    </div>
  )
}

