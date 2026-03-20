import { request, uploadFile } from './client'

export const authApi = {
  login: (phone) => request('/api/auth', { method: 'POST', body: { phone } }),
  me: () => request('/api/users/me', { auth: true }),
}

export const postsApi = {
  list: ({ page = 1, pageSize = 20 } = {}) =>
    request('/api/posts', { query: { page, pageSize } }),
  getById: (postId) => request(`/api/posts/${postId}`),
  create: (payload) => request('/api/user/posts', { method: 'POST', body: payload, auth: true }),
  update: (postId, payload) =>
    request(`/api/posts/${postId}`, { method: 'PATCH', body: payload, auth: true }),
  remove: (postId) => request(`/api/posts/${postId}`, { method: 'DELETE', auth: true }),
  addInterest: (postId, interestId) =>
    request(`/api/posts/${postId}/interests/${interestId}`, { method: 'POST', auth: true }),
  removeInterest: (postId, interestId) =>
    request(`/api/posts/${postId}/interests/${interestId}`, { method: 'DELETE', auth: true }),
}

export const reviewsApi = {
  listByPost: (postId, { page = 1, pageSize = 20 } = {}) =>
    request(`/api/posts/${postId}/reviews`, { query: { page, pageSize } }),
  create: (postId, payload) =>
    request(`/api/posts/${postId}/reviews`, { method: 'POST', body: payload, auth: true }),
  remove: (reviewId) => request(`/api/reviews/${reviewId}`, { method: 'DELETE', auth: true }),
}

export const interestsApi = {
  list: ({ page = 1, pageSize = 20 } = {}) =>
    request('/api/interests', { query: { page, pageSize } }),
  create: (name) => request('/api/interests', { method: 'POST', body: { name }, auth: true }),
  remove: (interestId) => request(`/api/interests/${interestId}`, { method: 'DELETE', auth: true }),
  addToMe: (interestId) =>
    request(`/api/users/me/interests/${interestId}`, { method: 'POST', auth: true }),
  removeFromMe: (interestId) =>
    request(`/api/users/me/interests/${interestId}`, { method: 'DELETE', auth: true }),
}

export const achievementsApi = {
  list: ({ page = 1, pageSize = 20 } = {}) =>
    request('/api/achievements', { query: { page, pageSize } }),
  create: (payload) =>
    request('/api/achievements', { method: 'POST', body: payload, auth: true }),
  remove: (achievementId) =>
    request(`/api/achievements/${achievementId}`, { method: 'DELETE', auth: true }),
  addToMe: (achievementId) =>
    request(`/api/users/me/achievements/${achievementId}`, { method: 'POST', auth: true }),
  removeFromMe: (achievementId) =>
    request(`/api/users/me/achievements/${achievementId}`, { method: 'DELETE', auth: true }),
}

export const friendsApi = {
  sendRequest: (receiverUserId) =>
    request('/api/friends/requests', {
      method: 'POST',
      body: { receiverUserId: Number(receiverUserId) },
      auth: true,
    }),
  incoming: ({ page = 1, pageSize = 20 } = {}) =>
    request('/api/friends/requests/incoming', { query: { page, pageSize }, auth: true }),
  accept: (requestId) =>
    request(`/api/friends/requests/${requestId}/accept`, { method: 'POST', auth: true }),
  reject: (requestId) =>
    request(`/api/friends/requests/${requestId}/reject`, { method: 'POST', auth: true }),
  cancel: (requestId) =>
    request(`/api/friends/requests/${requestId}`, { method: 'DELETE', auth: true }),
  list: ({ page = 1, pageSize = 20 } = {}) =>
    request('/api/friends', { query: { page, pageSize }, auth: true }),
  remove: (friendId) => request(`/api/friends/${friendId}`, { method: 'DELETE', auth: true }),
}

export const uploadApi = { uploadFile }
export const systemApi = {
  ping: () => request('/api/ping'),
}

