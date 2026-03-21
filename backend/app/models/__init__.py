from sqlalchemy.orm import declarative_base

# Base must be defined first to avoid circular imports
Base = declarative_base()

# Models imported AFTER Base is defined
from app.models.achievement import Achievement
from app.models.associations import (
    FilterPreset,
    Follow,
    Invite,
    Report,
    UserAchievement,
    UserPlaceStatus,
    UserSwipedPost,
    post_interests,
    user_achievements,
    user_favorite_posts,
    user_interests,
    user_subscriptions,
    user_swiped_posts,
)
from app.models.interest import Interest
from app.models.post import Post, PriceLevel, Season
from app.models.prompt import (
    PromptComposition,
    PromptCompositionItem,
    PromptLog,
    PromptTemplate,
)
from app.models.review import Review
from app.models.route import (
    PinSource,
    PinType,
    PriceStatus,
    Route,
    RoutePin,
    RouteSegment,
    RouteStatus,
    SegmentItem,
    SegmentItemType,
)
from app.models.booking import Booking, BookingItem, BookingItemStatus, BookingStatus
from app.models.event import Event, Offer
from app.models.expert import Expert
from app.models.geo import GeoRegion, GeoRegionType, TransportLink, WeatherMonthly
from app.models.schedule import PlaceSchedule, PlaceScheduleOverride, PostMedia, SimilarPlace
from app.models.tag import PlaceTag, Tag, TagCategory, UserTag
from app.models.tour import Service, ServiceType, Tour, TourService
from app.models.user import User

__all__ = [
    # Core models
    "Achievement",
    "Interest",
    "PlaceSchedule",
    "PlaceScheduleOverride",
    "Post",
    "PostMedia",
    "PriceLevel",
    "Review",
    "Season",
    "SimilarPlace",
    "User",
    # New ORM association models
    "FilterPreset",
    "Follow",
    "Invite",
    "Report",
    "UserAchievement",
    "UserPlaceStatus",
    "UserSwipedPost",
    # Route models
    "PinSource",
    "PinType",
    "PriceStatus",
    "Route",
    "RoutePin",
    "RouteSegment",
    "RouteStatus",
    "SegmentItem",
    "SegmentItemType",
    # Booking models
    "Booking",
    "BookingItem",
    "BookingItemStatus",
    "BookingStatus",
    # Prompt models
    "PromptComposition",
    "PromptCompositionItem",
    "PromptLog",
    "PromptTemplate",
    # Geo models
    "GeoRegion",
    "GeoRegionType",
    "TransportLink",
    "WeatherMonthly",
    # Tag models
    "Tag",
    "TagCategory",
    "PlaceTag",
    "UserTag",
    # Tour models
    "Tour",
    "TourService",
    "Service",
    "ServiceType",
    # Expert model
    "Expert",
    # Event / Offer models
    "Event",
    "Offer",
    # Plain Table objects — kept for secondary= and migration compatibility
    "post_interests",
    "user_achievements",
    "user_favorite_posts",
    "user_interests",
    "user_subscriptions",
    "user_swiped_posts",
]
