from datetime import datetime

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel
from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.achievement import Achievement
from app.models.friend_request import FriendRequest, FriendRequestStatus
from app.models.interest import Interest
from app.models.user import User
from app.services.social_service import SocialService
from slugify import slugify

router = APIRouter()


class UserCompactResponse(BasePydanticModel):
    id: int
    phone: str


class InterestRequest(BasePydanticModel):
    name: str


class InterestResponse(BasePydanticModel):
    id: int
    name: str
    name_en: str


class AchievementRequest(BasePydanticModel):
    name: str
    description: str | None = None


class AchievementResponse(BasePydanticModel):
    id: int
    name: str
    description: str | None
    createdAt: datetime


class FriendRequestCreateRequest(BasePydanticModel):
    receiverUserId: int


class FriendRequestResponse(BasePydanticModel):
    id: int
    requesterId: int
    receiverId: int
    status: FriendRequestStatus
    createdAt: datetime


class PaginatedInterestsResponse(BasePydanticModel):
    items: list[InterestResponse]
    total: int
    page: int
    pageSize: int


class PaginatedAchievementsResponse(BasePydanticModel):
    items: list[AchievementResponse]
    total: int
    page: int
    pageSize: int


class PaginatedFriendRequestsResponse(BasePydanticModel):
    items: list[FriendRequestResponse]
    total: int
    page: int
    pageSize: int


class PaginatedFriendsResponse(BasePydanticModel):
    items: list[UserCompactResponse]
    total: int
    page: int
    pageSize: int


def _service(db: AsyncSession) -> SocialService:
    return SocialService(db)


def _interest_to_response(item: Interest) -> InterestResponse:
    return InterestResponse(
        id=item.id,
        name=item.name,
        name_en=slugify(
            f"{item.name}",
            separator="_",
            allow_unicode=False,
        ),
    )


def _achievement_to_response(item: Achievement) -> AchievementResponse:
    return AchievementResponse(
        id=item.id,
        name=item.name,
        description=item.description,
        createdAt=item.created_at,
    )


def _friend_request_to_response(item: FriendRequest) -> FriendRequestResponse:
    return FriendRequestResponse(
        id=item.id,
        requesterId=item.requester_id,
        receiverId=item.receiver_id,
        status=item.status,
        createdAt=item.created_at,
    )


@router.post(
    "/interests",
    response_model=InterestResponse,
    status_code=status.HTTP_201_CREATED,
)
async def create_interest(
    payload: InterestRequest,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).create_interest(payload.name)
    return _interest_to_response(item)


@router.get("/interests", response_model=PaginatedInterestsResponse)
async def list_interests(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_interests(page=page, page_size=pageSize)
    return PaginatedInterestsResponse(
        items=[_interest_to_response(item) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.post("/interests/bulk_create", response_model=PaginatedInterestsResponse)
async def add_interests(
    interest_ids: list[int] = ...,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).add_interests_to_user(
        user=_current_user,
        interest_ids=interest_ids,
    )
    return PaginatedInterestsResponse(
        items=[_interest_to_response(item) for item in items],
        total=total,
        page=1,
        pageSize=100,
    )


@router.delete(
    "/interests/{interest_id}",
    status_code=status.HTTP_204_NO_CONTENT,
)
async def delete_interest(
    interest_id: int,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).delete_interest(interest_id)


@router.post(
    "/users/me/interests/{interest_id}",
    response_model=UserCompactResponse,
)
async def add_interest_to_me(
    interest_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).add_interest_to_user(
        user=current_user, interest_id=interest_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.delete(
    "/users/me/interests/{interest_id}",
    response_model=UserCompactResponse,
)
async def remove_interest_from_me(
    interest_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).remove_interest_from_user(
        user=current_user, interest_id=interest_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.post(
    "/achievements",
    response_model=AchievementResponse,
    status_code=status.HTTP_201_CREATED,
)
async def create_achievement(
    payload: AchievementRequest,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).create_achievement(
        name=payload.name, description=payload.description
    )
    return _achievement_to_response(item)


@router.get(
    "/achievements",
    response_model=PaginatedAchievementsResponse,
)
async def list_achievements(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_achievements(page=page, page_size=pageSize)
    return PaginatedAchievementsResponse(
        items=[_achievement_to_response(item) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.delete(
    "/achievements/{achievement_id}",
    status_code=status.HTTP_204_NO_CONTENT,
)
async def delete_achievement(
    achievement_id: int,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).delete_achievement(achievement_id)


@router.post(
    "/users/me/achievements/{achievement_id}",
    response_model=UserCompactResponse,
)
async def add_achievement_to_me(
    achievement_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).add_achievement_to_user(
        user=current_user, achievement_id=achievement_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.delete(
    "/users/me/achievements/{achievement_id}",
    response_model=UserCompactResponse,
)
async def remove_achievement_from_me(
    achievement_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).remove_achievement_from_user(
        user=current_user, achievement_id=achievement_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.post(
    "/friends/requests",
    response_model=FriendRequestResponse,
    status_code=status.HTTP_201_CREATED,
)
async def send_friend_request(
    payload: FriendRequestCreateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).send_friend_request(
        requester=current_user, receiver_id=payload.receiverUserId
    )
    return _friend_request_to_response(item)


@router.get(
    "/friends/requests/incoming",
    response_model=PaginatedFriendRequestsResponse,
)
async def list_incoming_friend_requests(
    current_user: User = Depends(get_current_user),
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_incoming_friend_requests(
        user=current_user,
        page=page,
        page_size=pageSize,
    )
    return PaginatedFriendRequestsResponse(
        items=[_friend_request_to_response(item) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.post(
    "/friends/requests/{request_id}/accept",
    response_model=FriendRequestResponse,
)
async def accept_friend_request(
    request_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).accept_friend_request(
        user=current_user, request_id=request_id
    )
    return _friend_request_to_response(item)


@router.post(
    "/friends/requests/{request_id}/reject", response_model=FriendRequestResponse
)
async def reject_friend_request(
    request_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).reject_friend_request(
        user=current_user, request_id=request_id
    )
    return _friend_request_to_response(item)


@router.delete("/friends/requests/{request_id}", status_code=status.HTTP_204_NO_CONTENT)
async def cancel_friend_request(
    request_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).cancel_friend_request(user=current_user, request_id=request_id)


@router.get("/friends", response_model=PaginatedFriendsResponse)
async def list_friends(
    current_user: User = Depends(get_current_user),
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_friends(
        current_user, page=page, page_size=pageSize
    )
    return PaginatedFriendsResponse(
        items=[UserCompactResponse(id=item.id, phone=item.phone) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.delete("/friends/{friend_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_friend(
    friend_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).delete_friend(user=current_user, friend_id=friend_id)
