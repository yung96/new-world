import { useMutation } from '@tanstack/react-query'
import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { authApi } from '../shared/api/endpoints'
import { useSessionStore } from '../app/store/sessionStore'
import { normalizeError } from '../shared/lib/errors'

export function AuthPage() {
  const [phone, setPhone] = useState('')
  const [error, setError] = useState('')
  const navigate = useNavigate()
  const setSession = useSessionStore((state) => state.setSession)

  const loginMutation = useMutation({
    mutationFn: async (value) => {
      const auth = await authApi.login(value)
      const token = auth.access_token
      useSessionStore.setState({ token })
      const user = await authApi.me()
      return { token, user }
    },
    onSuccess: ({ token, user }) => {
      setSession({ token, user })
      setError('')
      navigate('/feed')
    },
    onError: (mutationError) => setError(normalizeError(mutationError)),
  })

  const submit = (event) => {
    event.preventDefault()
    loginMutation.mutate(phone.trim())
  }

  return (
    <div className="mx-auto flex min-h-screen w-full max-w-md items-center px-4">
      <div className="w-full rounded-3xl border border-zinc-200 bg-white p-6 shadow-sm">
        <h1 className="text-2xl font-bold">Вход в kraeved</h1>
        <p className="mt-2 text-sm text-zinc-500">Введи номер телефона, чтобы получить JWT и доступ к API.</p>
        <form className="mt-6 space-y-4" onSubmit={submit}>
          <label className="block">
            <span className="mb-1 block text-sm font-medium">Телефон</span>
            <input
              required
              value={phone}
              onChange={(event) => setPhone(event.target.value)}
              placeholder="+79991234567"
              className="w-full rounded-xl border border-zinc-300 px-3 py-2 outline-none focus:border-indigo-500"
            />
          </label>
          {error ? <p className="text-sm text-rose-600">{error}</p> : null}
          <button
            type="submit"
            disabled={loginMutation.isPending}
            className="w-full rounded-xl bg-indigo-600 px-4 py-2 font-medium text-white hover:bg-indigo-500 disabled:opacity-70"
          >
            {loginMutation.isPending ? 'Входим...' : 'Войти'}
          </button>
        </form>
        <p className="mt-4 text-sm text-zinc-500">
          После входа откроется <Link to="/feed" className="text-indigo-700">лента</Link> и все защищенные функции.
        </p>
      </div>
    </div>
  )
}

