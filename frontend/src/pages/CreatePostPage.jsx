import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { interestsApi, postsApi, uploadApi } from '../shared/api/endpoints'
import { parseCsv } from '../shared/lib/format'
import { normalizeError } from '../shared/lib/errors'
import { Card } from '../shared/ui/Card'

export function CreatePostPage() {
  const queryClient = useQueryClient()
  const navigate = useNavigate()
  const [form, setForm] = useState({
    title: '',
    description: '',
    tags: '',
  })
  const [selectedInterestIds, setSelectedInterestIds] = useState([])
  const [interestSearch, setInterestSearch] = useState('')
  const [file, setFile] = useState(null)
  const [error, setError] = useState('')

  const interestsQuery = useQuery({
    queryKey: ['interests-for-create'],
    queryFn: () => interestsApi.list({ page: 1, pageSize: 100 }),
  })

  const createMutation = useMutation({
    mutationFn: async () => {
      let mediaUrl = null
      if (file) {
        const uploaded = await uploadApi.uploadFile(file)
        mediaUrl = uploaded.url
      }
      const payload = {
        title: form.title,
        description: form.description || null,
        mediaUrls: mediaUrl ? [mediaUrl] : [],
        tags: parseCsv(form.tags),
        interestIds: selectedInterestIds,
      }
      return postsApi.create(payload)
    },
    onSuccess: (createdPost) => {
      queryClient.invalidateQueries({ queryKey: ['posts'] })
      navigate(`/posts/${createdPost.id}`)
    },
    onError: (mutationError) => setError(normalizeError(mutationError)),
  })

  const updateField = (key) => (event) => {
    setForm((prev) => ({ ...prev, [key]: event.target.value }))
  }

  const toggleInterest = (interestId) => {
    setSelectedInterestIds((prev) =>
      prev.includes(interestId) ? prev.filter((id) => id !== interestId) : [...prev, interestId],
    )
  }

  const visibleInterests =
    interestsQuery.data?.items?.filter((item) =>
      item.name.toLowerCase().includes(interestSearch.trim().toLowerCase()),
    ) ?? []

  return (
    <Card title="Новый пост" subtitle="Создание с optional upload и привязкой интересов">
      <form
        onSubmit={(event) => {
          event.preventDefault()
          createMutation.mutate()
        }}
        className="space-y-3"
      >
        <input
          required
          value={form.title}
          onChange={updateField('title')}
          placeholder="Заголовок"
          className="w-full rounded-xl border border-zinc-300 px-3 py-2"
        />
        <textarea
          value={form.description}
          onChange={updateField('description')}
          placeholder="Описание"
          className="h-28 w-full rounded-xl border border-zinc-300 px-3 py-2"
        />
        <div>
          <input
            value={form.tags}
            onChange={updateField('tags')}
            placeholder="Теги через запятую"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
        </div>
        <div className="space-y-2">
          <div className="flex items-center justify-between gap-2">
            <p className="text-sm font-medium text-zinc-700">Интересы</p>
            <p className="text-xs text-zinc-500">Выбрано: {selectedInterestIds.length}</p>
          </div>
          <input
            value={interestSearch}
            onChange={(event) => setInterestSearch(event.target.value)}
            placeholder="Поиск интереса"
            className="w-full rounded-xl border border-zinc-300 px-3 py-2"
          />
          <div className="max-h-48 overflow-y-auto rounded-xl border border-zinc-200 p-2">
            {interestsQuery.isLoading ? (
              <p className="px-2 py-1 text-sm text-zinc-500">Загружаем интересы...</p>
            ) : null}
            {interestsQuery.isError ? (
              <p className="px-2 py-1 text-sm text-rose-600">{normalizeError(interestsQuery.error)}</p>
            ) : null}
            {visibleInterests.map((interest) => {
              const active = selectedInterestIds.includes(interest.id)
              return (
                <button
                  key={interest.id}
                  type="button"
                  onClick={() => toggleInterest(interest.id)}
                  className={`m-1 rounded-full border px-3 py-1.5 text-sm transition ${
                    active
                      ? 'border-zinc-900 bg-zinc-900 text-white'
                      : 'border-zinc-300 bg-white text-zinc-800 hover:bg-zinc-100'
                  }`}
                >
                  {interest.name}
                </button>
              )
            })}
            {!interestsQuery.isLoading && !visibleInterests.length ? (
              <p className="px-2 py-1 text-sm text-zinc-500">Ничего не найдено</p>
            ) : null}
          </div>
        </div>
        <input
          type="file"
          accept="image/png,image/jpeg,image/jpg,image/gif,image/webp"
          onChange={(event) => setFile(event.target.files?.[0] || null)}
          className="w-full rounded-xl border border-zinc-300 px-3 py-2"
        />
        {error ? <p className="text-sm text-rose-600">{error}</p> : null}
        <button
          type="submit"
          disabled={createMutation.isPending}
          className="rounded-full bg-indigo-600 px-5 py-2 font-medium text-white"
        >
          {createMutation.isPending ? 'Сохраняем...' : 'Опубликовать'}
        </button>
      </form>
    </Card>
  )
}

