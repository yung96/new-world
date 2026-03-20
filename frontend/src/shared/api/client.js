import { useSessionStore } from '../../app/store/sessionStore'

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL ?? 'https://apikraeved.tw1.su'

export class ApiError extends Error {
  constructor(message, status, payload) {
    super(message)
    this.name = 'ApiError'
    this.status = status
    this.payload = payload
  }
}

const withQueryParams = (path, query) => {
  if (!query) {
    return path
  }

  const params = new URLSearchParams()
  Object.entries(query).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== '') {
      params.append(key, String(value))
    }
  })
  const queryString = params.toString()
  return queryString ? `${path}?${queryString}` : path
}

const parseResponse = async (response) => {
  const contentType = response.headers.get('content-type') || ''
  if (contentType.includes('application/json')) {
    return response.json()
  }
  const text = await response.text()
  return text ? { detail: text } : null
}

export const request = async (path, options = {}) => {
  const { method = 'GET', body, headers = {}, auth = false, query, rawBody = false } = options

  const token = useSessionStore.getState().token
  const url = `${API_BASE_URL}${withQueryParams(path, query)}`
  const requestHeaders = { ...headers }

  if (!rawBody && body !== undefined && body !== null) {
    requestHeaders['Content-Type'] = 'application/json'
  }

  if (auth && token) {
    requestHeaders.Authorization = `Bearer ${token}`
  }

  const response = await fetch(url, {
    method,
    headers: requestHeaders,
    body: rawBody ? body : body ? JSON.stringify(body) : undefined,
  })

  const payload = await parseResponse(response)
  if (!response.ok) {
    const message =
      (payload && (payload.detail || payload.message)) || `Request failed: ${response.status}`
    if (response.status === 401) {
      useSessionStore.getState().clearSession()
    }
    throw new ApiError(message, response.status, payload)
  }

  return payload
}

export const uploadFile = async (file) => {
  const data = new FormData()
  data.append('file', file)
  return request('/api/upload', {
    method: 'POST',
    body: data,
    rawBody: true,
  })
}

export const fileUrl = (value) => {
  if (!value) {
    return ''
  }
  if (value.startsWith('http://') || value.startsWith('https://')) {
    return value
  }
  return `${API_BASE_URL}${value}`
}

