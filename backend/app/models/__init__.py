from sqlalchemy.orm import declarative_base

# Определяем Base первым
Base = declarative_base()

# Импортируем модели ПОСЛЕ определения Base, чтобы избежать циклического импорта
from app.models.achievement import Achievement
from app.models.associations import (
    post_interests,
    user_achievements,
    user_favorite_posts,
    user_friends,
    user_interests,
    user_swiped_posts,
)
from app.models.friend_request import FriendRequest, FriendRequestStatus
from app.models.interest import Interest
from app.models.post import Post
from app.models.review import Review
from app.models.user import User

__all__ = [
    "Achievement",
    "FriendRequest",
    "FriendRequestStatus",
    "Interest",
    "Post",
    "Review",
    "User",
    "post_interests",
    "user_achievements",
    "user_favorite_posts",
    "user_friends",
    "user_interests",
    "user_swiped_posts",
]
