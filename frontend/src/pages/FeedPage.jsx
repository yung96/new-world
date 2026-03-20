import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useState } from 'react'
import { Link } from 'react-router-dom'
import { postsApi, systemApi } from '../shared/api/endpoints'
import { Card } from '../shared/ui/Card'
import { fileUrl } from '../shared/api/client'
import { formatDateTime } from '../shared/lib/format'
import { normalizeError } from '../shared/lib/errors'
import { useSessionStore } from '../app/store/sessionStore'

const stories = [
  'ivan',
  'olga',
  'maria',
  'alex',
  'pavel',
  'anna',
]

export function FeedPage() {
  const queryClient = useQueryClient()
  const me = useSessionStore((state) => state.user)
  const [page, setPage] = useState(1)

  const pingQuery = useQuery({
    queryKey: ['ping'],
    queryFn: systemApi.ping,
  })

  const postsQuery = useQuery({
    queryKey: ['posts', page],
    queryFn: () => postsApi.list({ page, pageSize: 10 }),
  })

  const deletePostMutation = useMutation({
    mutationFn: postsApi.remove,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['posts'] })
    },
  })

  return (
    <div className="space-y-4 pb-24 md:pb-0">
      <Card
        title="Лента"
        subtitle="Поток публикаций"
        right={
          <span className="rounded-full border border-zinc-200 bg-white px-3 py-1 text-xs text-zinc-600">
            API: {pingQuery.isSuccess ? 'online' : 'checking'}
          </span>
        }
        className="rounded-none border-x-0"
      >
        <div className="flex gap-3 overflow-x-auto pb-1">
          {stories.map((name) => (
            <div key={name} className="min-w-[64px] text-center">
              <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-full bg-gradient-to-tr from-amber-400 via-rose-500 to-fuchsia-600 p-[2px]">
                <div className="flex h-full w-full items-center justify-center rounded-full bg-white text-xs font-semibold text-zinc-700">
                  {name.slice(0, 2).toUpperCase()}
                </div>
              </div>
              <p className="mt-1 truncate text-[11px] text-zinc-600">{name}</p>
            </div>
          ))}
        </div>
        <div className="mt-3 flex flex-wrap gap-2">
          <Link className="rounded-md bg-zinc-900 px-4 py-2 text-sm font-medium text-white" to="/create">
            Создать пост
          </Link>
          <Link className="rounded-md border border-zinc-300 bg-white px-4 py-2 text-sm font-medium text-zinc-900" to="/social">
            Social
          </Link>
        </div>
      </Card>

      {postsQuery.isLoading ? <Card>Загрузка ленты...</Card> : null}
      {postsQuery.isError ? <Card>Ошибка: {normalizeError(postsQuery.error)}</Card> : null}

      {postsQuery.data?.items?.map((post) => (
        <Card
          key={post.id}
          title={null}
          subtitle={null}
          right={
            <button type="button" className="text-zinc-500">...</button>
          }
          className="rounded-none border-x-0"
          contentClassName="p-0"
        >
          <div className="border-b border-zinc-100 px-4 py-3">
            <div className="flex items-center gap-3">
              <div className="flex h-8 w-8 items-center justify-center rounded-full bg-zinc-200 text-xs font-semibold">
                {post.author.phone.slice(-2)}
              </div>
              <div>
                <p className="text-sm font-semibold">@{post.author.phone}</p>
                <p className="text-xs text-zinc-500">{formatDateTime(post.createdAt)}</p>
              </div>
            </div>
          </div>
          <div className="space-y-3">
            {post.mediaUrls?.[0] ? (
              <img
                src={fileUrl(post.mediaUrls[0])}
                alt={post.title}
                className="aspect-square w-full object-cover"
              />
            ) : null}
            <div className="px-4">
              <div className="mb-2 flex items-center gap-4 text-xl">
                <span>like</span>
                <span>comment</span>
                <span>share</span>
              </div>
              <p className="text-sm font-semibold">{post.title}</p>
              {post.description ? <p className="mt-1 text-sm text-zinc-700">{post.description}</p> : null}
              <p className="mt-2 text-xs text-zinc-500">
                {post.averageRating ? `Rating: ${post.averageRating} / 5` : 'Пока без оценок'}
              </p>
            </div>
            <div className="flex flex-wrap gap-2 px-4 pb-2">
              {post.tags?.map((tag) => (
                <span key={tag} className="text-xs font-medium text-sky-700">
                  #{tag}
                </span>
              ))}
            </div>
            <div className="flex flex-wrap gap-2 px-4 pb-4">
              <Link
                to={`/posts/${post.id}`}
                className="rounded-md border border-zinc-300 px-3 py-1.5 text-sm font-medium hover:bg-zinc-100"
              >
                Подробнее
              </Link>
              {me?.id === post.authorId ? (
                <button
                  type="button"
                  onClick={() => deletePostMutation.mutate(post.id)}
                  className="rounded-md border border-rose-300 px-3 py-1.5 text-sm font-medium text-rose-700 hover:bg-rose-50"
                >
                  Удалить
                </button>
              ) : null}
            </div>
          </div>
        </Card>
      ))}
      {postsQuery.data ? (
        <Card className="rounded-none border-x-0">
          <div className="flex items-center justify-between">
            <p className="text-sm text-zinc-500">
              Страница {postsQuery.data.page} из {Math.max(1, Math.ceil(postsQuery.data.total / postsQuery.data.pageSize))}
            </p>
            <div className="flex gap-2">
              <button
                type="button"
                disabled={page <= 1}
                onClick={() => setPage((prev) => Math.max(1, prev - 1))}
                className="rounded-full border border-zinc-300 px-3 py-1 text-sm disabled:opacity-50"
              >
                Назад
              </button>
              <button
                type="button"
                disabled={page >= Math.ceil(postsQuery.data.total / postsQuery.data.pageSize)}
                onClick={() => setPage((prev) => prev + 1)}
                className="rounded-full border border-zinc-300 px-3 py-1 text-sm disabled:opacity-50"
              >
                Вперед
              </button>
            </div>
          </div>
        </Card>
      ) : null}
    </div>
  )
}

