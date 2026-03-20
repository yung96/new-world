from fastapi import HTTPException, status
from sqlalchemy import and_, func, or_, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.achievement import Achievement
from app.models.associations import user_achievements, user_friends, user_interests
from app.models.friend_request import FriendRequest, FriendRequestStatus
from app.models.interest import Interest
from app.models.user import User


class SocialService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_user_or_404(self, user_id: int) -> User:
        user = await self.db.get(User, user_id)
        if user is None:
            raise HTTPException(status_code=404, detail="User not found")
        return user

    async def create_interest(self, name: str) -> Interest:
        normalized = (name or "").strip()
        if not normalized:
            raise HTTPException(status_code=400, detail="Interest name is required")
        exists = (
            await self.db.execute(select(Interest).where(Interest.name == normalized))
        ).scalar_one_or_none()
        if exists is not None:
            return exists
        interest = Interest(name=normalized)
        self.db.add(interest)
        await self.db.commit()
        await self.db.refresh(interest)
        return interest

    async def list_interests(
        self, *, page: int, page_size: int
    ) -> tuple[list[Interest], int]:
        offset = (page - 1) * page_size
        total = int(
            (await self.db.execute(select(func.count(Interest.id)))).scalar_one() or 0
        )
        items = (
            (
                await self.db.execute(
                    select(Interest)
                    .order_by(Interest.name.asc())
                    .offset(offset)
                    .limit(page_size)
                )
            )
            .scalars()
            .all()
        )
        return items, total

    async def delete_interest(self, interest_id: int) -> None:
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        await self.db.delete(interest)
        await self.db.commit()

    async def update_interest(self, *, interest_id: int, name: str) -> Interest:
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        normalized = (name or "").strip()
        if not normalized:
            raise HTTPException(status_code=400, detail="Interest name is required")
        duplicate = (
            await self.db.execute(
                select(Interest).where(
                    Interest.name == normalized, Interest.id != interest_id
                )
            )
        ).scalar_one_or_none()
        if duplicate is not None:
            raise HTTPException(
                status_code=409, detail="Interest with this name already exists"
            )
        interest.name = normalized
        await self.db.commit()
        await self.db.refresh(interest)
        return interest

    async def add_interest_to_user(self, *, user: User, interest_id: int) -> User:
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        exists_stmt = select(user_interests.c.user_id).where(
            user_interests.c.user_id == user.id,
            user_interests.c.interest_id == interest_id,
        )
        exists = (await self.db.execute(exists_stmt)).first() is not None
        if not exists:
            await self.db.execute(
                user_interests.insert().values(user_id=user.id, interest_id=interest_id)
            )
            await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def add_interests_to_user(
        self,
        *,
        user: User,
        interest_ids: list[int],
    ) -> User:
        if not interest_ids:
            return user

        stmt = select(Interest.id).where(Interest.id.in_(interest_ids))
        result = await self.db.execute(stmt)
        existing_ids = {row[0] for row in result.fetchall()}

        if not existing_ids:
            raise HTTPException(status_code=404, detail="Interests not found")

        exists_stmt = select(user_interests.c.interest_id).where(
            user_interests.c.user_id == user.id,
            user_interests.c.interest_id.in_(existing_ids),
        )
        result = await self.db.execute(exists_stmt)
        already_added = {row[0] for row in result.fetchall()}

        to_insert = existing_ids - already_added

        if to_insert:
            await self.db.execute(
                user_interests.insert(),
                [{"user_id": user.id, "interest_id": i} for i in to_insert],
            )
            await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def remove_interest_from_user(self, *, user: User, interest_id: int) -> User:
        await self.db.execute(
            user_interests.delete().where(
                user_interests.c.user_id == user.id,
                user_interests.c.interest_id == interest_id,
            )
        )
        await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def set_interest_weight_for_user(
        self, *, user: User, interest_id: int, weight: int
    ) -> None:
        stmt = (
            user_interests.update()
            .where(
                user_interests.c.user_id == user.id,
                user_interests.c.interest_id == interest_id,
            )
            .values(weight=weight)
        )
        result = await self.db.execute(stmt)
        if result.rowcount == 0:
            interest = await self.db.get(Interest, interest_id)
            if interest is None:
                raise HTTPException(status_code=404, detail="Interest not found")
            raise HTTPException(status_code=404, detail="Interest is not bound to user")
        await self.db.commit()

    async def get_interest_weights_for_user(self, *, user: User) -> dict[int, int]:
        stmt = select(user_interests.c.interest_id, user_interests.c.weight).where(
            user_interests.c.user_id == user.id
        )
        rows = (await self.db.execute(stmt)).all()
        return {row.interest_id: row.weight for row in rows}

    async def create_achievement(
        self, *, name: str, description: str | None
    ) -> Achievement:
        normalized = (name or "").strip()
        if not normalized:
            raise HTTPException(status_code=400, detail="Achievement name is required")
        exists = (
            await self.db.execute(
                select(Achievement).where(Achievement.name == normalized)
            )
        ).scalar_one_or_none()
        if exists is not None:
            return exists
        achievement = Achievement(name=normalized, description=description)
        self.db.add(achievement)
        await self.db.commit()
        await self.db.refresh(achievement)
        return achievement

    async def list_achievements(
        self, *, page: int, page_size: int
    ) -> tuple[list[Achievement], int]:
        offset = (page - 1) * page_size
        total = int(
            (await self.db.execute(select(func.count(Achievement.id)))).scalar_one()
            or 0
        )
        stmt = (
            select(Achievement)
            .order_by(Achievement.id.asc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return items, total

    async def delete_achievement(self, achievement_id: int) -> None:
        achievement = await self.db.get(Achievement, achievement_id)
        if achievement is None:
            raise HTTPException(status_code=404, detail="Achievement not found")
        await self.db.delete(achievement)
        await self.db.commit()

    async def add_achievement_to_user(self, *, user: User, achievement_id: int) -> User:
        achievement = await self.db.get(Achievement, achievement_id)
        if achievement is None:
            raise HTTPException(status_code=404, detail="Achievement not found")
        exists_stmt = select(user_achievements.c.user_id).where(
            user_achievements.c.user_id == user.id,
            user_achievements.c.achievement_id == achievement_id,
        )
        exists = (await self.db.execute(exists_stmt)).first() is not None
        if not exists:
            await self.db.execute(
                user_achievements.insert().values(
                    user_id=user.id,
                    achievement_id=achievement_id,
                )
            )
            await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def remove_achievement_from_user(
        self, *, user: User, achievement_id: int
    ) -> User:
        await self.db.execute(
            user_achievements.delete().where(
                user_achievements.c.user_id == user.id,
                user_achievements.c.achievement_id == achievement_id,
            )
        )
        await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def list_friends(
        self, user: User, *, page: int, page_size: int
    ) -> tuple[list[User], int]:
        offset = (page - 1) * page_size
        total_stmt = (
            select(func.count())
            .select_from(user_friends)
            .where(user_friends.c.user_id == user.id)
        )
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)
        stmt = (
            select(User)
            .join(user_friends, user_friends.c.friend_id == User.id)
            .where(user_friends.c.user_id == user.id)
            .order_by(User.id.asc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return items, total

    async def send_friend_request(
        self, *, requester: User, receiver_id: int
    ) -> FriendRequest:
        if requester.id == receiver_id:
            raise HTTPException(status_code=400, detail="Cannot add yourself")
        receiver = await self.get_user_or_404(receiver_id)

        if await self._are_friends(requester.id, receiver.id):
            raise HTTPException(status_code=409, detail="Users are already friends")

        existing = (
            await self.db.execute(
                select(FriendRequest).where(
                    or_(
                        and_(
                            FriendRequest.requester_id == requester.id,
                            FriendRequest.receiver_id == receiver.id,
                        ),
                        and_(
                            FriendRequest.requester_id == receiver.id,
                            FriendRequest.receiver_id == requester.id,
                        ),
                    ),
                    FriendRequest.status == FriendRequestStatus.pending,
                )
            )
        ).scalar_one_or_none()
        if existing is not None:
            raise HTTPException(
                status_code=409, detail="Pending request already exists"
            )

        request = FriendRequest(
            requester_id=requester.id,
            receiver_id=receiver.id,
            status=FriendRequestStatus.pending,
        )
        self.db.add(request)
        await self.db.commit()
        await self.db.refresh(request)
        return request

    async def list_incoming_friend_requests(
        self, *, user: User, page: int, page_size: int
    ) -> tuple[list[FriendRequest], int]:
        offset = (page - 1) * page_size
        total_stmt = select(func.count(FriendRequest.id)).where(
            FriendRequest.receiver_id == user.id,
            FriendRequest.status == FriendRequestStatus.pending,
        )
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)
        stmt = (
            select(FriendRequest)
            .where(
                FriendRequest.receiver_id == user.id,
                FriendRequest.status == FriendRequestStatus.pending,
            )
            .order_by(FriendRequest.created_at.desc(), FriendRequest.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return items, total

    async def cancel_friend_request(self, *, user: User, request_id: int) -> None:
        req = await self._get_friend_request_or_404(request_id)
        if req.requester_id != user.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Cannot cancel this request",
            )
        if req.status != FriendRequestStatus.pending:
            raise HTTPException(
                status_code=409, detail="Only pending request can be cancelled"
            )
        await self.db.delete(req)
        await self.db.commit()

    async def accept_friend_request(
        self, *, user: User, request_id: int
    ) -> FriendRequest:
        req = await self._get_friend_request_or_404(request_id)
        if req.receiver_id != user.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Cannot accept this request",
            )
        if req.status != FriendRequestStatus.pending:
            raise HTTPException(status_code=409, detail="Request already handled")

        req.status = FriendRequestStatus.accepted
        await self.db.execute(
            user_friends.insert().values(
                user_id=req.requester_id, friend_id=req.receiver_id
            )
        )
        await self.db.execute(
            user_friends.insert().values(
                user_id=req.receiver_id, friend_id=req.requester_id
            )
        )
        await self.db.commit()
        await self.db.refresh(req)
        return req

    async def reject_friend_request(
        self, *, user: User, request_id: int
    ) -> FriendRequest:
        req = await self._get_friend_request_or_404(request_id)
        if req.receiver_id != user.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Cannot reject this request",
            )
        if req.status != FriendRequestStatus.pending:
            raise HTTPException(status_code=409, detail="Request already handled")
        req.status = FriendRequestStatus.rejected
        await self.db.commit()
        await self.db.refresh(req)
        return req

    async def delete_friend(self, *, user: User, friend_id: int) -> None:
        await self.get_user_or_404(friend_id)
        await self.db.execute(
            user_friends.delete().where(
                or_(
                    and_(
                        user_friends.c.user_id == user.id,
                        user_friends.c.friend_id == friend_id,
                    ),
                    and_(
                        user_friends.c.user_id == friend_id,
                        user_friends.c.friend_id == user.id,
                    ),
                )
            )
        )
        await self.db.commit()

    async def _are_friends(self, user_id: int, friend_id: int) -> bool:
        stmt = select(user_friends.c.user_id).where(
            user_friends.c.user_id == user_id, user_friends.c.friend_id == friend_id
        )
        return (await self.db.execute(stmt)).first() is not None

    async def _get_friend_request_or_404(self, request_id: int) -> FriendRequest:
        req = await self.db.get(FriendRequest, request_id)
        if req is None:
            raise HTTPException(status_code=404, detail="Friend request not found")
        return req
