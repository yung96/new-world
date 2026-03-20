import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useMemo, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { postsApi, reviewsApi } from '../shared/api/endpoints'
import { Card } from '../shared/ui/Card'
import { fileUrl } from '../shared/api/client'
import { formatDateTime } from '../shared/lib/format'
import { normalizeError } from '../shared/lib/errors'
import { useSessionStore } from '../app/store/sessionStore'

export function PostDetailsPage() {
  const { postId } = useParams()
  const navigate = useNavigate()
  const queryClient = useQueryClient()
  const me = useSessionStore((state) => state.user)
  const [editMode, setEditMode] = useState(false)
  const [newInterestId, setNewInterestId] = useState('')
  const [reviewForm, setReviewForm] = useState({ rating: 5, comment: '' })
  const [reviewsPage, setReviewsPage] = useState(1)

  const postQuery = useQuery({
    queryKey: ['post', postId],
    queryFn: () => postsApi.getById(postId),
    enabled: Boolean(postId),
  })
  const reviewsQuery = useQuery({
    queryKey: ['reviews', postId, reviewsPage],
    queryFn: () => reviewsApi.listByPost(postId, { page: reviewsPage, pageSize: 10 }),
    enabled: Boolean(postId),
  })

  const [editPayload, setEditPayload] = useState(null)

  const canEdit = me?.id && postQuery.data?.authorId === me.id
  const resolvedEditPayload = useMemo(() => {
    if (!postQuery.data) {
      return null
    }
    return (
      editPayload ?? {
        title: postQuery.data.title,
        description: postQuery.data.description || '',
        tags: (postQuery.data.tags || []).join(','),
      }
    )
  }, [editPayload, postQuery.data])

  const refetchAll = () => {
    queryClient.invalidateQueries({ queryKey: ['post', postId] })
    queryClient.invalidateQueries({ queryKey: ['posts'] })
    queryClient.invalidateQueries({ queryKey: ['reviews', postId] })
  }

  const updatePostMutation = useMutation({
    mutationFn: () =>
      postsApi.update(postId, {
        title: resolvedEditPayload?.title,
        description: resolvedEditPayload?.description || null,
        tags: (resolvedEditPayload?.tags || '')
          .split(',')
          .map((tag) => tag.trim())
          .filter(Boolean),
      }),
    onSuccess: () => {
      setEditMode(false)
      setEditPayload(null)
      refetchAll()
    },
  })

  const deletePostMutation = useMutation({
    mutationFn: () => postsApi.remove(postId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['posts'] })
      navigate('/feed')
    },
  })

  const addInterestMutation = useMutation({
    mutationFn: () => postsApi.addInterest(postId, Number(newInterestId)),
    onSuccess: () => {
      setNewInterestId('')
      refetchAll()
    },
  })

  const removeInterestMutation = useMutation({
    mutationFn: (interestId) => postsApi.removeInterest(postId, interestId),
    onSuccess: refetchAll,
  })

  const createReviewMutation = useMutation({
    mutationFn: () =>
      reviewsApi.create(postId, {
        rating: Number(reviewForm.rating),
        comment: reviewForm.comment || null,
        mediaUrls: [],
      }),
    onSuccess: () => {
      setReviewForm({ rating: 5, comment: '' })
      refetchAll()
    },
  })

  const deleteReviewMutation = useMutation({
    mutationFn: (reviewId) => reviewsApi.remove(reviewId),
    onSuccess: refetchAll,
  })

  if (postQuery.isLoading) return <Card>Загрузка поста...</Card>
  if (postQuery.isError) return <Card>Ошибка: {normalizeError(postQuery.error)}</Card>

  const post = postQuery.data
  return (
    <div className="space-y-4 pb-24 md:pb-0">
      <Card
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
            <img src={fileUrl(post.mediaUrls[0])} alt={post.title} className="aspect-square w-full object-cover" />
          ) : null}
          <div className="px-4">
            <p className="text-sm font-semibold">{post.title}</p>
            <p className="mt-1 text-sm text-zinc-700">{post.description}</p>
            <p className="mt-2 text-xs text-zinc-500">
              {post.averageRating ? `Rating: ${post.averageRating}/5` : 'Нет рейтинга'}
            </p>
          </div>
          {editMode ? (
            <div className="space-y-2 px-4">
              <input
                value={resolvedEditPayload?.title || ''}
                onChange={(event) =>
                  setEditPayload((prev) => ({ ...(prev ?? resolvedEditPayload), title: event.target.value }))
                }
                className="w-full rounded-xl border border-zinc-300 px-3 py-2"
              />
              <textarea
                value={resolvedEditPayload?.description || ''}
                onChange={(event) =>
                  setEditPayload((prev) => ({ ...(prev ?? resolvedEditPayload), description: event.target.value }))
                }
                className="h-24 w-full rounded-xl border border-zinc-300 px-3 py-2"
              />
              <input
                value={resolvedEditPayload?.tags || ''}
                onChange={(event) =>
                  setEditPayload((prev) => ({ ...(prev ?? resolvedEditPayload), tags: event.target.value }))
                }
                placeholder="tag1, tag2"
                className="w-full rounded-xl border border-zinc-300 px-3 py-2"
              />
            </div>
          ) : (
            <div className="px-4 text-xs text-zinc-500">Пост #{post.id}</div>
          )}

          <div className="flex flex-wrap gap-2 px-4">
            {post.tags?.map((tag) => (
              <span key={tag} className="text-xs font-medium text-sky-700">
                #{tag}
              </span>
            ))}
          </div>
          <p className="px-4 text-xs text-zinc-500">interestIds: {(post.interestIds || []).join(', ') || 'none'}</p>

          {canEdit ? (
            <div className="flex flex-wrap gap-2 px-4 pb-4">
              {!editMode ? (
                <button
                  type="button"
                  className="rounded-md border border-zinc-300 px-4 py-2 text-sm"
                  onClick={() => setEditMode(true)}
                >
                  Редактировать
                </button>
              ) : (
                <button
                  type="button"
                  className="rounded-md bg-zinc-900 px-4 py-2 text-sm text-white"
                  onClick={() => updatePostMutation.mutate()}
                >
                  Сохранить PATCH
                </button>
              )}
              <button
                type="button"
                className="rounded-md border border-rose-300 px-4 py-2 text-sm text-rose-700"
                onClick={() => deletePostMutation.mutate()}
              >
                Удалить пост
              </button>
            </div>
          ) : null}
        </div>
      </Card>

      {canEdit ? (
        <Card title="Interests поста" subtitle="Использует /api/posts/{post_id}/interests/{interest_id}" className="rounded-none border-x-0">
          <div className="flex flex-wrap items-center gap-2">
            <input
              value={newInterestId}
              onChange={(event) => setNewInterestId(event.target.value)}
              placeholder="ID interest"
              className="rounded-xl border border-zinc-300 px-3 py-2"
            />
            <button
              type="button"
              onClick={() => addInterestMutation.mutate()}
              className="rounded-full bg-zinc-900 px-4 py-2 text-sm text-white"
            >
              Добавить interest
            </button>
            {(post.interestIds || []).map((interestId) => (
              <button
                key={interestId}
                type="button"
                onClick={() => removeInterestMutation.mutate(interestId)}
                className="rounded-full border border-zinc-300 px-3 py-1 text-xs"
              >
                remove #{interestId}
              </button>
            ))}
          </div>
        </Card>
      ) : null}

      <Card title="Отзывы" subtitle="create/list/delete review" className="rounded-none border-x-0">
        <form
          className="mb-4 grid gap-2 sm:grid-cols-[120px_1fr_auto]"
          onSubmit={(event) => {
            event.preventDefault()
            createReviewMutation.mutate()
          }}
        >
          <select
            value={reviewForm.rating}
            onChange={(event) => setReviewForm((prev) => ({ ...prev, rating: Number(event.target.value) }))}
            className="rounded-xl border border-zinc-300 px-3 py-2"
          >
            {[5, 4, 3, 2, 1].map((value) => (
              <option key={value} value={value}>
                {value} / 5
              </option>
            ))}
          </select>
          <input
            value={reviewForm.comment}
            onChange={(event) => setReviewForm((prev) => ({ ...prev, comment: event.target.value }))}
            placeholder="Комментарий"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
          <button className="rounded-full bg-indigo-600 px-4 py-2 text-white">Оставить отзыв</button>
        </form>
        <div className="space-y-2">
          {reviewsQuery.data?.items?.map((review) => (
            <div key={review.id} className="rounded-2xl border border-zinc-200 p-3">
              <div className="flex items-center justify-between">
                <p className="text-sm font-medium">
                  {review.author.phone} · {review.rating}/5
                </p>
                {me?.id === review.authorId ? (
                  <button
                    type="button"
                    onClick={() => deleteReviewMutation.mutate(review.id)}
                    className="text-xs text-rose-700"
                  >
                    Удалить
                  </button>
                ) : null}
              </div>
              <p className="mt-1 text-sm text-zinc-600">{review.comment || 'Без комментария'}</p>
            </div>
          ))}
        </div>
        {reviewsQuery.data ? (
          <div className="mt-3 flex items-center justify-between">
            <p className="text-xs text-zinc-500">
              Страница {reviewsQuery.data.page} из {Math.max(1, Math.ceil(reviewsQuery.data.total / reviewsQuery.data.pageSize))}
            </p>
            <div className="flex gap-2">
              <button
                type="button"
                disabled={reviewsPage <= 1}
                onClick={() => setReviewsPage((prev) => Math.max(1, prev - 1))}
                className="rounded-full border border-zinc-300 px-3 py-1 text-xs disabled:opacity-50"
              >
                Назад
              </button>
              <button
                type="button"
                disabled={reviewsPage >= Math.ceil(reviewsQuery.data.total / reviewsQuery.data.pageSize)}
                onClick={() => setReviewsPage((prev) => prev + 1)}
                className="rounded-full border border-zinc-300 px-3 py-1 text-xs disabled:opacity-50"
              >
                Вперед
              </button>
            </div>
          </div>
        ) : null}
      </Card>
    </div>
  )
}

