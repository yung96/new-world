import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { useState } from 'react'
import {
  achievementsApi,
  friendsApi,
  interestsApi,
} from '../shared/api/endpoints'
import { Card } from '../shared/ui/Card'
import { normalizeError } from '../shared/lib/errors'

export function SocialPage() {
  const queryClient = useQueryClient()
  const [interestsPage, setInterestsPage] = useState(1)
  const [achievementsPage, setAchievementsPage] = useState(1)
  const [incomingPage, setIncomingPage] = useState(1)
  const [friendsPage, setFriendsPage] = useState(1)
  const [newInterest, setNewInterest] = useState('')
  const [newAchievement, setNewAchievement] = useState({ name: '', description: '' })
  const [receiverId, setReceiverId] = useState('')
  const [cancelRequestId, setCancelRequestId] = useState('')

  const interestsQuery = useQuery({
    queryKey: ['interests', interestsPage],
    queryFn: () => interestsApi.list({ page: interestsPage, pageSize: 10 }),
  })
  const achievementsQuery = useQuery({
    queryKey: ['achievements', achievementsPage],
    queryFn: () => achievementsApi.list({ page: achievementsPage, pageSize: 10 }),
  })
  const incomingQuery = useQuery({
    queryKey: ['incoming-requests', incomingPage],
    queryFn: () => friendsApi.incoming({ page: incomingPage, pageSize: 10 }),
  })
  const friendsQuery = useQuery({
    queryKey: ['friends', friendsPage],
    queryFn: () => friendsApi.list({ page: friendsPage, pageSize: 10 }),
  })

  const refreshSocial = () => {
    queryClient.invalidateQueries({ queryKey: ['interests'] })
    queryClient.invalidateQueries({ queryKey: ['achievements'] })
    queryClient.invalidateQueries({ queryKey: ['incoming-requests'] })
    queryClient.invalidateQueries({ queryKey: ['friends'] })
  }

  const createInterestMutation = useMutation({
    mutationFn: () => interestsApi.create(newInterest),
    onSuccess: () => {
      setNewInterest('')
      refreshSocial()
    },
  })
  const deleteInterestMutation = useMutation({
    mutationFn: interestsApi.remove,
    onSuccess: refreshSocial,
  })
  const addInterestToMeMutation = useMutation({
    mutationFn: interestsApi.addToMe,
    onSuccess: refreshSocial,
  })
  const removeInterestFromMeMutation = useMutation({
    mutationFn: interestsApi.removeFromMe,
    onSuccess: refreshSocial,
  })

  const createAchievementMutation = useMutation({
    mutationFn: () => achievementsApi.create(newAchievement),
    onSuccess: () => {
      setNewAchievement({ name: '', description: '' })
      refreshSocial()
    },
  })
  const deleteAchievementMutation = useMutation({
    mutationFn: achievementsApi.remove,
    onSuccess: refreshSocial,
  })
  const addAchievementToMeMutation = useMutation({
    mutationFn: achievementsApi.addToMe,
    onSuccess: refreshSocial,
  })
  const removeAchievementFromMeMutation = useMutation({
    mutationFn: achievementsApi.removeFromMe,
    onSuccess: refreshSocial,
  })

  const sendRequestMutation = useMutation({
    mutationFn: () => friendsApi.sendRequest(Number(receiverId)),
    onSuccess: () => {
      setReceiverId('')
      refreshSocial()
    },
  })
  const cancelRequestMutation = useMutation({
    mutationFn: () => friendsApi.cancel(Number(cancelRequestId)),
    onSuccess: () => {
      setCancelRequestId('')
      refreshSocial()
    },
  })
  const acceptRequestMutation = useMutation({
    mutationFn: friendsApi.accept,
    onSuccess: refreshSocial,
  })
  const rejectRequestMutation = useMutation({
    mutationFn: friendsApi.reject,
    onSuccess: refreshSocial,
  })
  const removeFriendMutation = useMutation({
    mutationFn: friendsApi.remove,
    onSuccess: refreshSocial,
  })

  return (
    <div className="space-y-4 pb-24 md:pb-0">
      <Card title="Interests" subtitle="create/list/delete + add/remove me">
        <div className="mb-3 flex flex-wrap gap-2">
          <input
            value={newInterest}
            onChange={(event) => setNewInterest(event.target.value)}
            placeholder="Название interest"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
          <button
            type="button"
            onClick={() => createInterestMutation.mutate()}
            className="rounded-full bg-zinc-900 px-4 py-2 text-sm text-white"
          >
            Создать
          </button>
        </div>
        <div className="space-y-2">
          {interestsQuery.isError ? <p>{normalizeError(interestsQuery.error)}</p> : null}
          {interestsQuery.data?.items?.map((item) => (
            <div key={item.id} className="flex flex-wrap items-center gap-2 rounded-xl border border-zinc-200 p-2">
              <span className="text-sm">#{item.id} {item.name}</span>
              <button type="button" onClick={() => addInterestToMeMutation.mutate(item.id)} className="rounded-full bg-indigo-600 px-3 py-1 text-xs text-white">
                + me
              </button>
              <button type="button" onClick={() => removeInterestFromMeMutation.mutate(item.id)} className="rounded-full border border-zinc-300 px-3 py-1 text-xs">
                - me
              </button>
              <button type="button" onClick={() => deleteInterestMutation.mutate(item.id)} className="rounded-full border border-rose-300 px-3 py-1 text-xs text-rose-700">
                delete
              </button>
            </div>
          ))}
        </div>
        {interestsQuery.data ? (
          <div className="mt-3 flex items-center justify-between text-xs text-zinc-500">
            <span>Стр. {interestsQuery.data.page}</span>
            <div className="flex gap-2">
              <button type="button" disabled={interestsPage <= 1} onClick={() => setInterestsPage((prev) => Math.max(1, prev - 1))} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Назад</button>
              <button type="button" disabled={interestsPage >= Math.ceil(interestsQuery.data.total / interestsQuery.data.pageSize)} onClick={() => setInterestsPage((prev) => prev + 1)} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Вперед</button>
            </div>
          </div>
        ) : null}
      </Card>

      <Card title="Achievements" subtitle="create/list/delete + add/remove me">
        <div className="mb-3 grid gap-2 sm:grid-cols-[1fr_1fr_auto]">
          <input
            value={newAchievement.name}
            onChange={(event) =>
              setNewAchievement((prev) => ({ ...prev, name: event.target.value }))
            }
            placeholder="Название"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
          <input
            value={newAchievement.description}
            onChange={(event) =>
              setNewAchievement((prev) => ({ ...prev, description: event.target.value }))
            }
            placeholder="Описание"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
          <button
            type="button"
            onClick={() => createAchievementMutation.mutate()}
            className="rounded-full bg-zinc-900 px-4 py-2 text-sm text-white"
          >
            Создать
          </button>
        </div>
        <div className="space-y-2">
          {achievementsQuery.isError ? <p>{normalizeError(achievementsQuery.error)}</p> : null}
          {achievementsQuery.data?.items?.map((item) => (
            <div key={item.id} className="flex flex-wrap items-center gap-2 rounded-xl border border-zinc-200 p-2">
              <span className="text-sm">#{item.id} {item.name}</span>
              <button type="button" onClick={() => addAchievementToMeMutation.mutate(item.id)} className="rounded-full bg-indigo-600 px-3 py-1 text-xs text-white">
                + me
              </button>
              <button type="button" onClick={() => removeAchievementFromMeMutation.mutate(item.id)} className="rounded-full border border-zinc-300 px-3 py-1 text-xs">
                - me
              </button>
              <button type="button" onClick={() => deleteAchievementMutation.mutate(item.id)} className="rounded-full border border-rose-300 px-3 py-1 text-xs text-rose-700">
                delete
              </button>
            </div>
          ))}
        </div>
        {achievementsQuery.data ? (
          <div className="mt-3 flex items-center justify-between text-xs text-zinc-500">
            <span>Стр. {achievementsQuery.data.page}</span>
            <div className="flex gap-2">
              <button type="button" disabled={achievementsPage <= 1} onClick={() => setAchievementsPage((prev) => Math.max(1, prev - 1))} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Назад</button>
              <button type="button" disabled={achievementsPage >= Math.ceil(achievementsQuery.data.total / achievementsQuery.data.pageSize)} onClick={() => setAchievementsPage((prev) => prev + 1)} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Вперед</button>
            </div>
          </div>
        ) : null}
      </Card>

      <Card title="Friends" subtitle="requests incoming/accept/reject/cancel + list/remove">
        <div className="mb-4 grid gap-2 sm:grid-cols-[1fr_auto]">
          <input
            value={receiverId}
            onChange={(event) => setReceiverId(event.target.value)}
            placeholder="receiver user id"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
          <button
            type="button"
            onClick={() => sendRequestMutation.mutate()}
            className="rounded-full bg-indigo-600 px-4 py-2 text-sm text-white"
          >
            Отправить заявку
          </button>
        </div>

        <h3 className="mb-2 text-sm font-semibold uppercase text-zinc-500">Incoming</h3>
        <div className="space-y-2">
          {incomingQuery.isError ? <p>{normalizeError(incomingQuery.error)}</p> : null}
          {incomingQuery.data?.items?.map((item) => (
            <div key={item.id} className="flex flex-wrap items-center gap-2 rounded-xl border border-zinc-200 p-2 text-sm">
              <span>#{item.id} from {item.requesterId}</span>
              <button type="button" onClick={() => acceptRequestMutation.mutate(item.id)} className="rounded-full bg-emerald-600 px-3 py-1 text-xs text-white">
                accept
              </button>
              <button type="button" onClick={() => rejectRequestMutation.mutate(item.id)} className="rounded-full border border-zinc-300 px-3 py-1 text-xs">
                reject
              </button>
            </div>
          ))}
        </div>
        {incomingQuery.data ? (
          <div className="mt-3 flex items-center justify-between text-xs text-zinc-500">
            <span>Incoming: стр. {incomingQuery.data.page}</span>
            <div className="flex gap-2">
              <button type="button" disabled={incomingPage <= 1} onClick={() => setIncomingPage((prev) => Math.max(1, prev - 1))} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Назад</button>
              <button type="button" disabled={incomingPage >= Math.ceil(incomingQuery.data.total / incomingQuery.data.pageSize)} onClick={() => setIncomingPage((prev) => prev + 1)} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Вперед</button>
            </div>
          </div>
        ) : null}

        <div className="my-4 grid gap-2 sm:grid-cols-[1fr_auto]">
          <input
            value={cancelRequestId}
            onChange={(event) => setCancelRequestId(event.target.value)}
            placeholder="request id для cancel"
            className="rounded-xl border border-zinc-300 px-3 py-2"
          />
          <button
            type="button"
            onClick={() => cancelRequestMutation.mutate()}
            className="rounded-full border border-zinc-300 px-4 py-2 text-sm"
          >
            Cancel request by ID
          </button>
        </div>

        <h3 className="mb-2 text-sm font-semibold uppercase text-zinc-500">Friends</h3>
        <div className="space-y-2">
          {friendsQuery.isError ? <p>{normalizeError(friendsQuery.error)}</p> : null}
          {friendsQuery.data?.items?.map((friend) => (
            <div key={friend.id} className="flex flex-wrap items-center gap-2 rounded-xl border border-zinc-200 p-2 text-sm">
              <span>#{friend.id} {friend.phone}</span>
              <button type="button" onClick={() => removeFriendMutation.mutate(friend.id)} className="rounded-full border border-rose-300 px-3 py-1 text-xs text-rose-700">
                Удалить
              </button>
            </div>
          ))}
        </div>
        {friendsQuery.data ? (
          <div className="mt-3 flex items-center justify-between text-xs text-zinc-500">
            <span>Friends: стр. {friendsQuery.data.page}</span>
            <div className="flex gap-2">
              <button type="button" disabled={friendsPage <= 1} onClick={() => setFriendsPage((prev) => Math.max(1, prev - 1))} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Назад</button>
              <button type="button" disabled={friendsPage >= Math.ceil(friendsQuery.data.total / friendsQuery.data.pageSize)} onClick={() => setFriendsPage((prev) => prev + 1)} className="rounded-full border border-zinc-300 px-3 py-1 disabled:opacity-50">Вперед</button>
            </div>
          </div>
        ) : null}
      </Card>
    </div>
  )
}

