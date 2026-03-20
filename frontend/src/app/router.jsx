import { Navigate, createBrowserRouter } from 'react-router-dom'
import { AppLayout } from './layout/AppLayout'
import { ProtectedRoute, RootRedirect } from './routerGuards'
import { AuthPage } from '../pages/AuthPage'
import { FeedPage } from '../pages/FeedPage'
import { PostDetailsPage } from '../pages/PostDetailsPage'
import { CreatePostPage } from '../pages/CreatePostPage'
import { SocialPage } from '../pages/SocialPage'
import { ProfilePage } from '../pages/ProfilePage'

export const router = createBrowserRouter([
  { path: '/', element: <RootRedirect /> },
  { path: '/auth', element: <AuthPage /> },
  {
    path: '/',
    element: <AppLayout />,
    children: [
      { path: '/feed', element: <FeedPage /> },
      { path: '/posts/:postId', element: <PostDetailsPage /> },
      {
        path: '/create',
        element: (
          <ProtectedRoute>
            <CreatePostPage />
          </ProtectedRoute>
        ),
      },
      {
        path: '/social',
        element: (
          <ProtectedRoute>
            <SocialPage />
          </ProtectedRoute>
        ),
      },
      {
        path: '/profile',
        element: (
          <ProtectedRoute>
            <ProfilePage />
          </ProtectedRoute>
        ),
      },
    ],
  },
  { path: '*', element: <Navigate to="/" replace /> },
])

