--
-- PostgreSQL database dump
--

\restrict jeFRjB6cMDWyrRHn6ATBmVRKsx7cY2XcAPCCuO8aHpX9Utb7Vr6aFUW4MoXPthF

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 18.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: booking_item_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.booking_item_status_enum AS ENUM (
    'pending',
    'confirmed',
    'failed',
    'cancelled',
    'refunded'
);


ALTER TYPE public.booking_item_status_enum OWNER TO kraeved_user;

--
-- Name: booking_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.booking_status_enum AS ENUM (
    'pending',
    'confirmed',
    'paid',
    'cancelled',
    'refunded'
);


ALTER TYPE public.booking_status_enum OWNER TO kraeved_user;

--
-- Name: geo_region_type_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.geo_region_type_enum AS ENUM (
    'country',
    'region',
    'city',
    'district'
);


ALTER TYPE public.geo_region_type_enum OWNER TO kraeved_user;

--
-- Name: pin_source_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.pin_source_enum AS ENUM (
    'auto',
    'user',
    'editor',
    'ai'
);


ALTER TYPE public.pin_source_enum OWNER TO kraeved_user;

--
-- Name: pin_type_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.pin_type_enum AS ENUM (
    'city',
    'stay',
    'experience',
    'transport_hub',
    'photo_spot',
    'food',
    'custom'
);


ALTER TYPE public.pin_type_enum OWNER TO kraeved_user;

--
-- Name: place_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.place_status_enum AS ENUM (
    'visited',
    'want',
    'planned'
);


ALTER TYPE public.place_status_enum OWNER TO kraeved_user;

--
-- Name: price_level_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.price_level_enum AS ENUM (
    'low',
    'mid',
    'high'
);


ALTER TYPE public.price_level_enum OWNER TO kraeved_user;

--
-- Name: report_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.report_status_enum AS ENUM (
    'pending',
    'resolved',
    'rejected'
);


ALTER TYPE public.report_status_enum OWNER TO kraeved_user;

--
-- Name: route_price_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.route_price_status_enum AS ENUM (
    'fresh',
    'stale',
    'expired',
    'unavailable'
);


ALTER TYPE public.route_price_status_enum OWNER TO kraeved_user;

--
-- Name: route_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.route_status_enum AS ENUM (
    'draft',
    'ready',
    'stale',
    'booking',
    'partially_booked',
    'booked',
    'completed',
    'cancelled',
    'scoring',
    'distances',
    'enriching',
    'weather',
    'narrating',
    'events',
    'flights'
);


ALTER TYPE public.route_status_enum OWNER TO kraeved_user;

--
-- Name: season_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.season_enum AS ENUM (
    'spring',
    'summer',
    'autumn',
    'winter'
);


ALTER TYPE public.season_enum OWNER TO kraeved_user;

--
-- Name: segment_item_price_status_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.segment_item_price_status_enum AS ENUM (
    'fresh',
    'stale',
    'expired',
    'unavailable'
);


ALTER TYPE public.segment_item_price_status_enum OWNER TO kraeved_user;

--
-- Name: segment_item_type_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.segment_item_type_enum AS ENUM (
    'leg',
    'stay',
    'transfer',
    'car_rental',
    'day',
    'experience'
);


ALTER TYPE public.segment_item_type_enum OWNER TO kraeved_user;

--
-- Name: service_type_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.service_type_enum AS ENUM (
    'transport',
    'food',
    'activity',
    'guide',
    'other'
);


ALTER TYPE public.service_type_enum OWNER TO kraeved_user;

--
-- Name: swipe_direction_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.swipe_direction_enum AS ENUM (
    'left',
    'right',
    'up'
);


ALTER TYPE public.swipe_direction_enum OWNER TO kraeved_user;

--
-- Name: tag_category_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.tag_category_enum AS ENUM (
    'interest',
    'audience',
    'format',
    'season'
);


ALTER TYPE public.tag_category_enum OWNER TO kraeved_user;

--
-- Name: user_role_enum; Type: TYPE; Schema: public; Owner: kraeved_user
--

CREATE TYPE public.user_role_enum AS ENUM (
    'tourist',
    'owner',
    'both'
);


ALTER TYPE public.user_role_enum OWNER TO kraeved_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.achievements (
    id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    interest_id integer,
    required_distinct_posts integer
);


ALTER TABLE public.achievements OWNER TO kraeved_user;

--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.achievements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.achievements_id_seq OWNER TO kraeved_user;

--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO kraeved_user;

--
-- Name: booking_items; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.booking_items (
    id integer NOT NULL,
    booking_id integer NOT NULL,
    segment_item_id integer NOT NULL,
    external_booking_ref character varying,
    status public.booking_item_status_enum DEFAULT 'pending'::public.booking_item_status_enum NOT NULL,
    price_locked double precision,
    confirmation_url character varying,
    error_message text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.booking_items OWNER TO kraeved_user;

--
-- Name: booking_items_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.booking_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_items_id_seq OWNER TO kraeved_user;

--
-- Name: booking_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.booking_items_id_seq OWNED BY public.booking_items.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    route_id integer NOT NULL,
    user_id integer NOT NULL,
    status public.booking_status_enum DEFAULT 'pending'::public.booking_status_enum NOT NULL,
    total_price double precision,
    currency character varying(3),
    payment_method character varying,
    payment_id character varying,
    paid_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.bookings OWNER TO kraeved_user;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO kraeved_user;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.events (
    id integer NOT NULL,
    post_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    date_from date NOT NULL,
    date_to date NOT NULL,
    photo_url character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.events OWNER TO kraeved_user;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO kraeved_user;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: experts; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.experts (
    id integer NOT NULL,
    user_id integer,
    name character varying NOT NULL,
    photo_url character varying,
    specialization character varying,
    price_from integer,
    bio text,
    contacts jsonb,
    region_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.experts OWNER TO kraeved_user;

--
-- Name: experts_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.experts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experts_id_seq OWNER TO kraeved_user;

--
-- Name: experts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.experts_id_seq OWNED BY public.experts.id;


--
-- Name: filter_presets; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.filter_presets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying NOT NULL,
    date_from date,
    date_to date,
    group_type character varying,
    group_size integer,
    transport character varying,
    budget character varying,
    interests jsonb,
    pace character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.filter_presets OWNER TO kraeved_user;

--
-- Name: filter_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.filter_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filter_presets_id_seq OWNER TO kraeved_user;

--
-- Name: filter_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.filter_presets_id_seq OWNED BY public.filter_presets.id;


--
-- Name: geo_regions; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.geo_regions (
    id bigint NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    type public.geo_region_type_enum NOT NULL,
    parent_id bigint,
    polygon text,
    centroid text,
    population integer,
    timezone character varying,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.geo_regions OWNER TO kraeved_user;

--
-- Name: geo_regions_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.geo_regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.geo_regions_id_seq OWNER TO kraeved_user;

--
-- Name: geo_regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.geo_regions_id_seq OWNED BY public.geo_regions.id;


--
-- Name: interests; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.interests (
    id integer NOT NULL,
    name character varying NOT NULL,
    emoji character varying NOT NULL
);


ALTER TABLE public.interests OWNER TO kraeved_user;

--
-- Name: interests_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.interests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interests_id_seq OWNER TO kraeved_user;

--
-- Name: interests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.interests_id_seq OWNED BY public.interests.id;


--
-- Name: invites; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.invites (
    id integer NOT NULL,
    inviter_id integer NOT NULL,
    invitee_id integer,
    code character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.invites OWNER TO kraeved_user;

--
-- Name: invites_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.invites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invites_id_seq OWNER TO kraeved_user;

--
-- Name: invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.invites_id_seq OWNED BY public.invites.id;


--
-- Name: offers; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.offers (
    id integer NOT NULL,
    post_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    discount_percent integer,
    valid_from date NOT NULL,
    valid_to date NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.offers OWNER TO kraeved_user;

--
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.offers_id_seq OWNER TO kraeved_user;

--
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.offers_id_seq OWNED BY public.offers.id;


--
-- Name: place_schedule_overrides; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.place_schedule_overrides (
    id integer NOT NULL,
    post_id integer NOT NULL,
    date date NOT NULL,
    is_closed boolean NOT NULL,
    open_time time without time zone,
    close_time time without time zone,
    reason character varying
);


ALTER TABLE public.place_schedule_overrides OWNER TO kraeved_user;

--
-- Name: place_schedule_overrides_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.place_schedule_overrides_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.place_schedule_overrides_id_seq OWNER TO kraeved_user;

--
-- Name: place_schedule_overrides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.place_schedule_overrides_id_seq OWNED BY public.place_schedule_overrides.id;


--
-- Name: place_schedules; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.place_schedules (
    id integer NOT NULL,
    post_id integer NOT NULL,
    day_of_week smallint NOT NULL,
    open_time time without time zone,
    close_time time without time zone,
    is_closed boolean NOT NULL,
    CONSTRAINT ck_place_schedules_day_of_week CHECK (((day_of_week >= 0) AND (day_of_week <= 6)))
);


ALTER TABLE public.place_schedules OWNER TO kraeved_user;

--
-- Name: place_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.place_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.place_schedules_id_seq OWNER TO kraeved_user;

--
-- Name: place_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.place_schedules_id_seq OWNED BY public.place_schedules.id;


--
-- Name: place_tags; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.place_tags (
    post_id integer NOT NULL,
    tag_id integer NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.place_tags OWNER TO kraeved_user;

--
-- Name: post_interests; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.post_interests (
    post_id integer NOT NULL,
    interest_id integer NOT NULL
);


ALTER TABLE public.post_interests OWNER TO kraeved_user;

--
-- Name: post_media; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.post_media (
    id integer NOT NULL,
    post_id integer NOT NULL,
    url character varying NOT NULL,
    alt character varying,
    "position" smallint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.post_media OWNER TO kraeved_user;

--
-- Name: post_media_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.post_media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.post_media_id_seq OWNER TO kraeved_user;

--
-- Name: post_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.post_media_id_seq OWNED BY public.post_media.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    author_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    geo_lat double precision,
    geo_lng double precision,
    season public.season_enum NOT NULL,
    region_id integer,
    address character varying,
    phone character varying,
    email character varying,
    website character varying,
    need_car boolean NOT NULL,
    price_level public.price_level_enum,
    duration_hours double precision,
    best_angle text,
    partner_id integer,
    verified boolean NOT NULL,
    rating_avg numeric(3,2) NOT NULL,
    reviews_count integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    city character varying
);


ALTER TABLE public.posts OWNER TO kraeved_user;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO kraeved_user;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: prompt_composition_items; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.prompt_composition_items (
    composition_id integer NOT NULL,
    template_id integer NOT NULL,
    "position" smallint DEFAULT '0'::smallint NOT NULL
);


ALTER TABLE public.prompt_composition_items OWNER TO kraeved_user;

--
-- Name: prompt_compositions; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.prompt_compositions (
    id integer NOT NULL,
    name character varying NOT NULL,
    scenario jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.prompt_compositions OWNER TO kraeved_user;

--
-- Name: prompt_compositions_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.prompt_compositions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prompt_compositions_id_seq OWNER TO kraeved_user;

--
-- Name: prompt_compositions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.prompt_compositions_id_seq OWNED BY public.prompt_compositions.id;


--
-- Name: prompt_logs; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.prompt_logs (
    id integer NOT NULL,
    route_id integer NOT NULL,
    composition_id integer,
    template_ids jsonb,
    assembled_prompt text,
    llm_response text,
    model character varying,
    tokens_in integer,
    tokens_out integer,
    latency_ms integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.prompt_logs OWNER TO kraeved_user;

--
-- Name: prompt_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.prompt_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prompt_logs_id_seq OWNER TO kraeved_user;

--
-- Name: prompt_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.prompt_logs_id_seq OWNED BY public.prompt_logs.id;


--
-- Name: prompt_templates; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.prompt_templates (
    id integer NOT NULL,
    slug character varying NOT NULL,
    category character varying NOT NULL,
    scenario jsonb,
    transport_context character varying,
    weather_context character varying,
    group_context character varying,
    template_text text NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.prompt_templates OWNER TO kraeved_user;

--
-- Name: prompt_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.prompt_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prompt_templates_id_seq OWNER TO kraeved_user;

--
-- Name: prompt_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.prompt_templates_id_seq OWNED BY public.prompt_templates.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    reporter_id integer NOT NULL,
    target_type character varying NOT NULL,
    target_id integer NOT NULL,
    reason text NOT NULL,
    status public.report_status_enum DEFAULT 'pending'::public.report_status_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reports OWNER TO kraeved_user;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reports_id_seq OWNER TO kraeved_user;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    author_id integer NOT NULL,
    post_id integer NOT NULL,
    rating integer NOT NULL,
    comment text,
    media_urls jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_reviews_rating_1_5 CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO kraeved_user;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO kraeved_user;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: route_pins; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.route_pins (
    id integer NOT NULL,
    route_id integer NOT NULL,
    segment_id integer,
    segment_item_id integer,
    label character varying,
    pin_type public.pin_type_enum NOT NULL,
    lat double precision NOT NULL,
    lng double precision NOT NULL,
    icon character varying,
    color character varying,
    "position" integer DEFAULT 0 NOT NULL,
    zoom_level smallint,
    is_visible boolean DEFAULT true NOT NULL,
    source public.pin_source_enum DEFAULT 'auto'::public.pin_source_enum NOT NULL,
    is_persistent boolean DEFAULT true NOT NULL,
    created_by integer,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.route_pins OWNER TO kraeved_user;

--
-- Name: route_pins_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.route_pins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_pins_id_seq OWNER TO kraeved_user;

--
-- Name: route_pins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.route_pins_id_seq OWNED BY public.route_pins.id;


--
-- Name: route_segments; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.route_segments (
    id integer NOT NULL,
    route_id integer NOT NULL,
    "position" smallint NOT NULL,
    city_id integer,
    title character varying,
    description text,
    narrative text,
    date_from date,
    date_to date,
    photos jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.route_segments OWNER TO kraeved_user;

--
-- Name: route_segments_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.route_segments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.route_segments_id_seq OWNER TO kraeved_user;

--
-- Name: route_segments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.route_segments_id_seq OWNED BY public.route_segments.id;


--
-- Name: routes; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.routes (
    id integer NOT NULL,
    author_id integer,
    title character varying NOT NULL,
    description text,
    cover_url character varying,
    narrative text,
    total_days integer,
    total_price double precision,
    total_price_status public.route_price_status_enum DEFAULT 'fresh'::public.route_price_status_enum NOT NULL,
    total_experiences integer DEFAULT 0 NOT NULL,
    total_hotels integer DEFAULT 0 NOT NULL,
    total_transports integer DEFAULT 0 NOT NULL,
    share_token character varying,
    params jsonb,
    status public.route_status_enum DEFAULT 'draft'::public.route_status_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.routes OWNER TO kraeved_user;

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.routes_id_seq OWNER TO kraeved_user;

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.routes_id_seq OWNED BY public.routes.id;


--
-- Name: segment_items; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.segment_items (
    id integer NOT NULL,
    segment_id integer NOT NULL,
    parent_id integer,
    type public.segment_item_type_enum NOT NULL,
    "position" smallint DEFAULT '0'::smallint NOT NULL,
    price double precision,
    price_currency character varying(3),
    price_original double precision,
    price_fetched_at timestamp with time zone,
    price_status public.segment_item_price_status_enum DEFAULT 'fresh'::public.segment_item_price_status_enum NOT NULL,
    provider_name character varying,
    provider_url character varying,
    ai_comment text,
    details jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.segment_items OWNER TO kraeved_user;

--
-- Name: segment_items_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.segment_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.segment_items_id_seq OWNER TO kraeved_user;

--
-- Name: segment_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.segment_items_id_seq OWNED BY public.segment_items.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.services (
    id integer NOT NULL,
    name character varying NOT NULL,
    type public.service_type_enum NOT NULL,
    duration_min integer,
    description text
);


ALTER TABLE public.services OWNER TO kraeved_user;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO kraeved_user;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: similar_places; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.similar_places (
    place_id integer NOT NULL,
    similar_place_id integer NOT NULL,
    score double precision NOT NULL
);


ALTER TABLE public.similar_places OWNER TO kraeved_user;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying NOT NULL,
    emoji character varying,
    category public.tag_category_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tags OWNER TO kraeved_user;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO kraeved_user;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: tour_services; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.tour_services (
    tour_id integer NOT NULL,
    service_id integer NOT NULL,
    "position" smallint NOT NULL
);


ALTER TABLE public.tour_services OWNER TO kraeved_user;

--
-- Name: tours; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.tours (
    id integer NOT NULL,
    post_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    price double precision,
    duration_min integer,
    max_group_size integer,
    guide_id integer,
    publisher_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tours OWNER TO kraeved_user;

--
-- Name: tours_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.tours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tours_id_seq OWNER TO kraeved_user;

--
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;


--
-- Name: transport_links; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.transport_links (
    id integer NOT NULL,
    from_id bigint NOT NULL,
    to_id bigint NOT NULL,
    kind character varying NOT NULL,
    duration_min integer,
    price_from integer,
    aviasales_url character varying,
    tutu_url character varying,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT transport_links_kind_check CHECK (((kind)::text = ANY ((ARRAY['plane'::character varying, 'train'::character varying, 'bus'::character varying, 'ferry'::character varying])::text[])))
);


ALTER TABLE public.transport_links OWNER TO kraeved_user;

--
-- Name: transport_links_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.transport_links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transport_links_id_seq OWNER TO kraeved_user;

--
-- Name: transport_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.transport_links_id_seq OWNED BY public.transport_links.id;


--
-- Name: user_achievements; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_achievements (
    user_id integer NOT NULL,
    achievement_id integer NOT NULL,
    earned_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_achievements OWNER TO kraeved_user;

--
-- Name: user_interests; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_interests (
    user_id integer NOT NULL,
    interest_id integer NOT NULL,
    weight integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.user_interests OWNER TO kraeved_user;

--
-- Name: user_place_statuses; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_place_statuses (
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    status public.place_status_enum NOT NULL,
    planned_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_place_statuses OWNER TO kraeved_user;

--
-- Name: user_saved_route_items; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_saved_route_items (
    id integer NOT NULL,
    route_id integer NOT NULL,
    post_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE public.user_saved_route_items OWNER TO kraeved_user;

--
-- Name: user_saved_route_items_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.user_saved_route_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_saved_route_items_id_seq OWNER TO kraeved_user;

--
-- Name: user_saved_route_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.user_saved_route_items_id_seq OWNED BY public.user_saved_route_items.id;


--
-- Name: user_saved_routes; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_saved_routes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying,
    start_lat double precision NOT NULL,
    start_lng double precision NOT NULL,
    start_label character varying,
    ai_generated boolean DEFAULT false NOT NULL,
    ai_route_meta jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_routes OWNER TO kraeved_user;

--
-- Name: user_saved_routes_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.user_saved_routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_saved_routes_id_seq OWNER TO kraeved_user;

--
-- Name: user_saved_routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.user_saved_routes_id_seq OWNED BY public.user_saved_routes.id;


--
-- Name: user_subscriptions; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_subscriptions (
    follower_id integer NOT NULL,
    following_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_user_subscriptions_no_self CHECK ((follower_id <> following_id))
);


ALTER TABLE public.user_subscriptions OWNER TO kraeved_user;

--
-- Name: user_swiped_posts; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_swiped_posts (
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    direction public.swipe_direction_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_swiped_posts OWNER TO kraeved_user;

--
-- Name: user_tags; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.user_tags (
    user_id integer NOT NULL,
    tag_id integer NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.user_tags OWNER TO kraeved_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    phone character varying NOT NULL,
    name character varying,
    avatar_url character varying,
    bio text,
    role public.user_role_enum DEFAULT 'tourist'::public.user_role_enum NOT NULL,
    taste_profile jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO kraeved_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: kraeved_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO kraeved_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kraeved_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: weather_monthly; Type: TABLE; Schema: public; Owner: kraeved_user
--

CREATE TABLE public.weather_monthly (
    region_id bigint NOT NULL,
    month smallint NOT NULL,
    temp_min double precision,
    temp_max double precision,
    rain_mm double precision,
    sunny_days smallint,
    description character varying,
    fetched_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT weather_monthly_month_check CHECK (((month >= 1) AND (month <= 12)))
);


ALTER TABLE public.weather_monthly OWNER TO kraeved_user;

--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: booking_items id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.booking_items ALTER COLUMN id SET DEFAULT nextval('public.booking_items_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: experts id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.experts ALTER COLUMN id SET DEFAULT nextval('public.experts_id_seq'::regclass);


--
-- Name: filter_presets id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.filter_presets ALTER COLUMN id SET DEFAULT nextval('public.filter_presets_id_seq'::regclass);


--
-- Name: geo_regions id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.geo_regions ALTER COLUMN id SET DEFAULT nextval('public.geo_regions_id_seq'::regclass);


--
-- Name: interests id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.interests ALTER COLUMN id SET DEFAULT nextval('public.interests_id_seq'::regclass);


--
-- Name: invites id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.invites ALTER COLUMN id SET DEFAULT nextval('public.invites_id_seq'::regclass);


--
-- Name: offers id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.offers ALTER COLUMN id SET DEFAULT nextval('public.offers_id_seq'::regclass);


--
-- Name: place_schedule_overrides id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_schedule_overrides ALTER COLUMN id SET DEFAULT nextval('public.place_schedule_overrides_id_seq'::regclass);


--
-- Name: place_schedules id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_schedules ALTER COLUMN id SET DEFAULT nextval('public.place_schedules_id_seq'::regclass);


--
-- Name: post_media id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.post_media ALTER COLUMN id SET DEFAULT nextval('public.post_media_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: prompt_compositions id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_compositions ALTER COLUMN id SET DEFAULT nextval('public.prompt_compositions_id_seq'::regclass);


--
-- Name: prompt_logs id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_logs ALTER COLUMN id SET DEFAULT nextval('public.prompt_logs_id_seq'::regclass);


--
-- Name: prompt_templates id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_templates ALTER COLUMN id SET DEFAULT nextval('public.prompt_templates_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: route_pins id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_pins ALTER COLUMN id SET DEFAULT nextval('public.route_pins_id_seq'::regclass);


--
-- Name: route_segments id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_segments ALTER COLUMN id SET DEFAULT nextval('public.route_segments_id_seq'::regclass);


--
-- Name: routes id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.routes ALTER COLUMN id SET DEFAULT nextval('public.routes_id_seq'::regclass);


--
-- Name: segment_items id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.segment_items ALTER COLUMN id SET DEFAULT nextval('public.segment_items_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tours id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);


--
-- Name: transport_links id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.transport_links ALTER COLUMN id SET DEFAULT nextval('public.transport_links_id_seq'::regclass);


--
-- Name: user_saved_route_items id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_route_items ALTER COLUMN id SET DEFAULT nextval('public.user_saved_route_items_id_seq'::regclass);


--
-- Name: user_saved_routes id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_routes ALTER COLUMN id SET DEFAULT nextval('public.user_saved_routes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.achievements (id, name, description, created_at, interest_id, required_distinct_posts) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.alembic_version (version_num) FROM stdin;
590c3d83b803
\.


--
-- Data for Name: booking_items; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.booking_items (id, booking_id, segment_item_id, external_booking_ref, status, price_locked, confirmation_url, error_message, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.bookings (id, route_id, user_id, status, total_price, currency, payment_method, payment_id, paid_at, created_at, updated_at) FROM stdin;
1	79	2	pending	\N	RUB	\N	\N	\N	2026-03-21 22:38:28.359721+00	2026-03-21 22:38:28.359721+00
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.events (id, post_id, title, description, date_from, date_to, photo_url, created_at) FROM stdin;
1	1	Фестиваль молодого вина	Дегустация 20 виноделен края	2026-04-15	2026-04-17	https://loremflickr.com/800/400/festival,event,celebration?random=1	2026-03-21 21:02:46.297305+00
2	1	Краснодар Jazz	Джазовый фестиваль под открытым небом	2026-05-01	2026-05-03	https://loremflickr.com/800/400/festival,event,celebration?random=2	2026-03-21 21:02:46.297305+00
3	1	Горный марафон Фишт	Трейл 42км по горам	2026-06-07	2026-06-07	https://loremflickr.com/800/400/festival,event,celebration?random=3	2026-03-21 21:02:46.297305+00
4	1	Ночь музеев	Бесплатный вход во все музеи	2026-05-16	2026-05-16	https://loremflickr.com/800/400/festival,event,celebration?random=4	2026-03-21 21:02:46.297305+00
5	1	Сочи Surf Fest	Фестиваль серфинга	2026-07-10	2026-07-12	https://loremflickr.com/800/400/festival,event,celebration?random=5	2026-03-21 21:02:46.297305+00
6	1	Фермерский рынок Абрау	Еженедельный рынок фермеров	2026-04-05	2026-10-25	https://loremflickr.com/800/400/festival,event,celebration?random=6	2026-03-21 21:02:46.297305+00
\.


--
-- Data for Name: experts; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.experts (id, user_id, name, photo_url, specialization, price_from, bio, contacts, region_id, created_at) FROM stdin;
1	\N	Алексей Горный	https://loremflickr.com/400/400/hiking,guide,mountain+man?random=1	hiking	3000	Горный гид, 10 лет опыта	\N	2	2026-03-21 21:02:46.262551+00
2	\N	Мария Виноградова	https://loremflickr.com/400/400/sommelier,wine+tasting?random=2	wine	5000	Сомелье, винные туры	\N	2	2026-03-21 21:02:46.262551+00
3	\N	Игорь Фотограф	https://loremflickr.com/400/400/photographer,camera?random=3	photo	7000	Travel-фотограф, Instagram 50K	\N	2	2026-03-21 21:02:46.262551+00
4	\N	Елена Историк	https://loremflickr.com/400/400/tour+guide,museum+guide?random=4	culture	2500	Экскурсовод по Краснодару	\N	2	2026-03-21 21:02:46.262551+00
5	\N	Дмитрий Рафтинг	https://loremflickr.com/400/400/rafting,kayak,instructor?random=5	sport	4000	Инструктор по рафтингу	\N	2	2026-03-21 21:02:46.262551+00
\.


--
-- Data for Name: filter_presets; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.filter_presets (id, user_id, name, date_from, date_to, group_type, group_size, transport, budget, interests, pace, created_at) FROM stdin;
1	2	Вино-гастро weekend	\N	\N	couple	\N	car	mid	["wine", "gastro"]	balanced	2026-03-21 21:33:21.244398+00
\.


--
-- Data for Name: geo_regions; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.geo_regions (id, name, slug, type, parent_id, polygon, centroid, population, timezone, created_at) FROM stdin;
1	Россия	russia	country	\N	https://loremflickr.com/800/400/russia,flag,kremlin?random=1	60.0,90.0	\N	\N	2026-03-21 20:50:38.711698+00
2	Краснодарский край	krasnodarskiy-kray	region	1	https://loremflickr.com/800/400/krasnodar,kuban,south+russia?random=2	44.77788090018502,40.06460274817761	5842238	Europe/Moscow	2026-03-21 20:50:38.711698+00
3	городской округ Краснодар	gorodskoy-okrug-krasnodar	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=3	45.0937763,39.0164697	\N	\N	2026-03-21 20:52:33.744698+00
4	Динской район	dinskoy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=4	45.2512976,39.0729717	\N	\N	2026-03-21 20:52:33.744698+00
5	Красноармейский район	krasnoarmeyskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=5	45.3258944,38.4107362	\N	\N	2026-03-21 20:52:33.744698+00
6	Северский район	severskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=6	44.7870953,38.7177143	\N	\N	2026-03-21 20:52:33.744698+00
7	Абинский район	abinskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=7	44.8849241,38.2878967	\N	\N	2026-03-21 20:52:33.744698+00
8	Славянский район	slavyanskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=8	45.4322275,37.8912155	\N	\N	2026-03-21 20:52:33.744698+00
9	Крымский район	krymskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=9	44.9625269,37.8329466	\N	\N	2026-03-21 20:52:33.744698+00
10	Темрюкский район	temryukskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=10	45.2643139,37.1537616	\N	\N	2026-03-21 20:52:33.744698+00
11	муниципальный округ Анапа	munitsipalnyy-okrug-anapa	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=11	44.9513051,37.2719538	\N	\N	2026-03-21 20:52:33.744698+00
12	городской округ Новороссийск	gorodskoy-okrug-novorossiysk	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=12	44.8305287,37.6731303	\N	\N	2026-03-21 20:52:33.744698+00
13	городской округ Геленджик	gorodskoy-okrug-gelendzhik	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=13	44.5483408,38.2775379	\N	\N	2026-03-21 20:52:33.744698+00
14	муниципальный округ Горячий Ключ	munitsipalnyy-okrug-goryachiy-klyuch	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=14	44.6128185,39.2430691	\N	\N	2026-03-21 20:52:33.744698+00
15	Белореченский район	belorechenskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=15	44.7819868,39.7497583	\N	\N	2026-03-21 20:52:33.744698+00
16	Апшеронский район	apsheronskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=16	44.3012439,39.6819443	\N	\N	2026-03-21 20:52:33.744698+00
17	Туапсинский муниципальный округ	tuapsinskiy-munitsipalnyy-okrug	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=17	44.2686691,39.0958981	\N	\N	2026-03-21 20:52:33.744698+00
18	городской округ Сочи	gorodskoy-okrug-sochi	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=18	43.7611586,39.9055726	\N	\N	2026-03-21 20:52:33.744698+00
19	Мостовский район	mostovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=19	44.147479,40.6360521	\N	\N	2026-03-21 20:52:33.744698+00
20	Ейский район	eyskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=20	46.440845,38.1621064	\N	\N	2026-03-21 20:52:33.744698+00
21	Щербиновский район	scherbinovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=21	46.6270554,38.6635572	\N	\N	2026-03-21 20:52:33.744698+00
22	Староминский район	starominskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=22	46.500066,39.0339113	\N	\N	2026-03-21 20:52:33.744698+00
23	Приморско-Ахтарский муниципальный округ	primorsko-ahtarskiy-munitsipalnyy-okrug	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=23	45.9658004,38.2458817	\N	\N	2026-03-21 20:52:33.744698+00
24	Калининский район	kalininskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=24	45.5305453,38.3965172	\N	\N	2026-03-21 20:52:33.744698+00
25	Тимашёвский район	timashyovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=25	45.5674671,38.9780234	\N	\N	2026-03-21 20:52:33.744698+00
26	Брюховецкий район	bryuhovetskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=26	45.8546073,39.0608558	\N	\N	2026-03-21 20:52:33.744698+00
27	Кущёвский район	kuschyovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=27	46.5645301,39.6863422	\N	\N	2026-03-21 20:52:33.744698+00
28	Крыловский район	krylovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=28	46.398871,40.0499186	\N	\N	2026-03-21 20:52:33.744698+00
29	Каневской район	kanevskoy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=29	46.137344,39.0081287	\N	\N	2026-03-21 20:52:33.744698+00
30	Ленинградский муниципальный округ	leningradskiy-munitsipalnyy-okrug	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=30	46.2259654,39.417124	\N	\N	2026-03-21 20:52:33.744698+00
31	Лабинский район	labinskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=31	44.4408676,40.9405803	\N	\N	2026-03-21 20:52:33.744698+00
32	Отрадненский район	otradnenskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=32	44.308353,41.3975382	\N	\N	2026-03-21 20:52:33.744698+00
33	Успенский район	uspenskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=33	44.8334244,41.4054616	\N	\N	2026-03-21 20:52:33.744698+00
34	городской округ Армавир	gorodskoy-okrug-armavir	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=34	44.9207619,41.0792476	\N	\N	2026-03-21 20:52:33.744698+00
35	Новокубанский район	novokubanskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=35	44.8909105,41.086172	\N	\N	2026-03-21 20:52:33.744698+00
36	Курганинский район	kurganinskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=36	44.9583917,40.5554569	\N	\N	2026-03-21 20:52:33.744698+00
37	Гулькевичский район	gulkevichskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=37	45.2512851,40.6553703	\N	\N	2026-03-21 20:52:33.744698+00
38	Кавказский район	kavkazskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=38	45.523757,40.5997104	\N	\N	2026-03-21 20:52:33.744698+00
39	Белоглинский район	beloglinskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=39	45.9864011,40.9013374	\N	\N	2026-03-21 20:52:33.744698+00
40	Новопокровский район	novopokrovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=40	45.968912,40.6050434	\N	\N	2026-03-21 20:52:33.744698+00
41	Павловский район	pavlovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=41	46.0803824,39.9225048	\N	\N	2026-03-21 20:52:33.744698+00
42	Кореновский район	korenovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=42	45.5610498,39.3911936	\N	\N	2026-03-21 20:52:33.744698+00
43	Тбилисский район	tbilisskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=43	45.3846998,40.1606622	\N	\N	2026-03-21 20:52:33.744698+00
44	Тихорецкий район	tihoretskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=44	45.8283988,40.1901302	\N	\N	2026-03-21 20:52:33.744698+00
45	Выселковский район	vyselkovskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=45	45.6643217,39.8382777	\N	\N	2026-03-21 20:52:33.744698+00
46	Усть-Лабинский район	ust-labinskiy-rayon	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=46	45.2697602,39.7456249	\N	\N	2026-03-21 20:52:33.744698+00
47	городской округ Сириус	gorodskoy-okrug-sirius	district	2	https://loremflickr.com/800/400/landscape,rural,countryside?random=47	43.4067304,39.9664535	\N	\N	2026-03-21 20:52:33.744698+00
48	Краснодар	krasnodar	city	2	https://loremflickr.com/800/400/city,town,street?random=48	45.0351532,38.9772396	1154885	\N	2026-03-21 20:52:49.875179+00
49	Славянск-на-Кубани	slavyansk-na-kubani	city	2	https://loremflickr.com/800/400/city,town,street?random=49	45.2590875,38.1244609	61449	\N	2026-03-21 20:52:49.875179+00
50	Темрюк	temryuk	city	2	https://loremflickr.com/800/400/city,town,street?random=50	45.2823609,37.3658235	39164	\N	2026-03-21 20:52:49.875179+00
51	Анапа	anapa	city	2	https://loremflickr.com/800/400/city,town,street?random=51	44.894272,37.316887	82695	\N	2026-03-21 20:52:49.875179+00
52	Приморско-Ахтарск	primorsko-ahtarsk	city	2	https://loremflickr.com/800/400/city,town,street?random=52	46.0433467,38.1560033	30465	\N	2026-03-21 20:52:49.875179+00
53	Ейск	eysk	city	2	https://loremflickr.com/800/400/city,town,street?random=53	46.7112094,38.2747987	82534	\N	2026-03-21 20:52:49.875179+00
54	Сочи	sochi	city	2	https://loremflickr.com/800/400/city,town,street?random=54	43.5854823,39.723109	446599	\N	2026-03-21 20:52:49.875179+00
55	Геленджик	gelendzhik	city	2	https://loremflickr.com/800/400/city,town,street?random=55	44.5609447,38.0766832	80296	\N	2026-03-21 20:52:49.875179+00
56	Кабардинка	kabardinka	city	2	https://loremflickr.com/800/400/city,town,street?random=56	44.6515718,37.9395292	7550	\N	2026-03-21 20:52:49.875179+00
57	Горячий Ключ	goryachiy-klyuch	city	2	https://loremflickr.com/800/400/city,town,street?random=57	44.6342653,39.1363613	34585	\N	2026-03-21 20:52:49.875179+00
58	Туапсе	tuapse	city	2	https://loremflickr.com/800/400/city,town,street?random=58	44.0984747,39.0718875	60707	\N	2026-03-21 20:52:49.875179+00
59	Новороссийск	novorossiysk	city	2	https://loremflickr.com/800/400/city,town,street?random=59	44.7239578,37.7690711	261973	\N	2026-03-21 20:52:49.875179+00
60	Армавир	armavir	city	2	https://loremflickr.com/800/400/city,town,street?random=60	44.9993585,41.1294061	187215	\N	2026-03-21 20:52:49.875179+00
61	Тимашёвск	timashyovsk	city	2	https://loremflickr.com/800/400/city,town,street?random=61	45.6129685,38.9357743	52641	\N	2026-03-21 20:52:49.875179+00
62	Павловская	pavlovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=62	46.1352,39.783	\N	\N	2026-03-21 20:52:49.875179+00
63	Витязево	vityazevo	city	2	https://loremflickr.com/800/400/city,town,street?random=63	44.9897066,37.2607195	7936	\N	2026-03-21 20:52:49.875179+00
64	Джубга	dzhubga	city	2	https://loremflickr.com/800/400/city,town,street?random=64	44.3170538,38.7043664	7024	\N	2026-03-21 20:52:49.875179+00
65	Дагомыс	dagomys	city	2	https://loremflickr.com/800/400/city,town,street?random=65	43.6590048,39.6544373	17841	\N	2026-03-21 20:52:49.875179+00
66	Усть-Лабинск	ust-labinsk	city	2	https://loremflickr.com/800/400/city,town,street?random=66	45.2094926,39.6901178	42062	\N	2026-03-21 20:52:49.875179+00
67	Васюринская	vasyurinskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=67	45.1183262,39.4200463	13339	\N	2026-03-21 20:52:49.875179+00
68	Воронежская	voronezhskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=68	45.2120476,39.5670828	8562	\N	2026-03-21 20:52:49.875179+00
69	Пластуновская	plastunovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=69	45.2962422,39.2662799	10264	\N	2026-03-21 20:52:49.875179+00
70	Платнировская	platnirovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=70	45.391981,39.3903857	12004	\N	2026-03-21 20:52:49.875179+00
71	Елизаветинская	elizavetinskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=71	45.0480573,38.7928963	24755	\N	2026-03-21 20:52:49.875179+00
72	Новомышастовская	novomyshastovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=72	45.1987319,38.5795212	10032	\N	2026-03-21 20:52:49.875179+00
73	Динская	dinskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=73	45.2168713,39.2249757	34848	\N	2026-03-21 20:52:49.875179+00
74	Белореченск	belorechensk	city	2	https://loremflickr.com/800/400/city,town,street?random=74	44.7614149,39.8712943	52322	\N	2026-03-21 20:52:49.875179+00
75	Выселки	vyselki	city	2	https://loremflickr.com/800/400/city,town,street?random=75	45.5806221,39.6574237	19426	\N	2026-03-21 20:52:49.875179+00
76	Афипский	afipskiy	city	2	https://loremflickr.com/800/400/city,town,street?random=76	44.9040435,38.8426821	19956	\N	2026-03-21 20:52:49.875179+00
77	Северская	severskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=77	44.853421,38.6781253	24867	\N	2026-03-21 20:52:49.875179+00
78	Ильский	ilskiy	city	2	https://loremflickr.com/800/400/city,town,street?random=78	44.8458544,38.5608255	24831	\N	2026-03-21 20:52:49.875179+00
79	Крымск	krymsk	city	2	https://loremflickr.com/800/400/city,town,street?random=79	44.9295889,37.9880177	54420	\N	2026-03-21 20:52:49.875179+00
80	Курганинск	kurganinsk	city	2	https://loremflickr.com/800/400/city,town,street?random=80	44.8851635,40.5894674	48194	\N	2026-03-21 20:52:49.875179+00
81	Калининская	kalininskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=81	45.4856626,38.6598137	13391	\N	2026-03-21 20:52:49.875179+00
82	Брюховецкая	bryuhovetskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=82	45.8006933,39.0006977	22024	\N	2026-03-21 20:52:49.875179+00
83	Переясловская	pereyaslovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=83	45.844673,39.021858	8424	\N	2026-03-21 20:52:49.875179+00
84	Каневская	kanevskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=84	46.0845999,38.9721929	41721	\N	2026-03-21 20:52:49.875179+00
85	Стародеревянковская	staroderevyankovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=85	46.1277738,38.9713729	13482	\N	2026-03-21 20:52:49.875179+00
86	Варениковская	varenikovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=86	45.121292,37.638737	14881	\N	2026-03-21 20:52:49.875179+00
87	Старотитаровская	starotitarovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=87	45.2188185,37.1480059	12164	\N	2026-03-21 20:52:49.875179+00
88	Тбилисская	tbilisskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=88	45.3635681,40.1898342	25317	\N	2026-03-21 20:52:49.875179+00
89	Ладожская	ladozhskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=89	45.3076593,39.9268511	14828	\N	2026-03-21 20:52:49.875179+00
90	Медвёдовская	medvyodovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=90	45.4525812,39.0167858	16793	\N	2026-03-21 20:52:49.875179+00
91	Холмская	holmskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=91	44.8432658,38.3950178	17585	\N	2026-03-21 20:52:49.875179+00
92	Ахтырский	ahtyrskiy	city	2	https://loremflickr.com/800/400/city,town,street?random=92	44.8559341,38.2941737	20863	\N	2026-03-21 20:52:49.875179+00
93	Абинск	abinsk	city	2	https://loremflickr.com/800/400/city,town,street?random=93	44.8649528,38.1578189	36986	\N	2026-03-21 20:52:49.875179+00
94	Старощербиновская	staroscherbinovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=94	46.6284506,38.6624971	18010	\N	2026-03-21 20:52:49.875179+00
95	Новотитаровская	novotitarovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=95	45.2360889,38.9712606	24754	\N	2026-03-21 20:52:49.875179+00
96	Апшеронск	apsheronsk	city	2	https://loremflickr.com/800/400/city,town,street?random=96	44.4674401,39.733173	40244	\N	2026-03-21 20:52:49.875179+00
97	Тихорецк	tihoretsk	city	2	https://loremflickr.com/800/400/city,town,street?random=97	45.854679,40.128124	54582	\N	2026-03-21 20:52:49.875179+00
98	Роговская	rogovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=98	45.734535,38.739555	7864	\N	2026-03-21 20:52:49.875179+00
99	Новопокровская	novopokrovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=99	45.953815,40.707203	19684	\N	2026-03-21 20:52:49.875179+00
100	Белая Глина	belaya-glina	city	2	https://loremflickr.com/800/400/city,town,street?random=100	46.0778137,40.8739482	17320	\N	2026-03-21 20:52:49.875179+00
101	Архангельская	arhangelskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=101	45.6725524,40.2796117	8714	\N	2026-03-21 20:52:49.875179+00
102	Нижнебаканская	nizhnebakanskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=102	44.8646355,37.8608578	8277	\N	2026-03-21 20:52:49.875179+00
103	Анапская	anapskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=103	44.9002856,37.3832216	16107	\N	2026-03-21 20:52:49.875179+00
104	Псебай	psebay	city	2	https://loremflickr.com/800/400/city,town,street?random=104	44.1092655,40.7902989	10613	\N	2026-03-21 20:52:49.875179+00
105	Лабинск	labinsk	city	2	https://loremflickr.com/800/400/city,town,street?random=105	44.6347953,40.7242185	60971	\N	2026-03-21 20:52:49.875179+00
106	Мостовской	mostovskoy	city	2	https://loremflickr.com/800/400/city,town,street?random=106	44.4138041,40.7899446	25006	\N	2026-03-21 20:52:49.875179+00
107	Архипо-Осиповка	arhipo-osipovka	city	2	https://loremflickr.com/800/400/city,town,street?random=107	44.3703184,38.533611	7853	\N	2026-03-21 20:52:49.875179+00
108	Новомихайловский	novomihaylovskiy	city	2	https://loremflickr.com/800/400/city,town,street?random=108	44.2533593,38.8447977	10792	\N	2026-03-21 20:52:49.875179+00
109	Нефтегорск	neftegorsk	city	2	https://loremflickr.com/800/400/city,town,street?random=109	44.3555651,39.7034985	5188	\N	2026-03-21 20:52:49.875179+00
110	Крыловская	krylovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=110	46.321865,39.962914	13621	\N	2026-03-21 20:52:49.875179+00
111	Ленинградская	leningradskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=111	46.3212449,39.389554	36940	\N	2026-03-21 20:52:49.875179+00
112	Новоминская	novominskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=112	46.317478,38.955532	11595	\N	2026-03-21 20:52:49.875179+00
113	Кущёвская	kuschyovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=113	46.5650084,39.6273712	30200	\N	2026-03-21 20:52:49.875179+00
114	Староминская	starominskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=114	46.5359488,39.0625056	29809	\N	2026-03-21 20:52:49.875179+00
115	Михайловская	mihaylovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=115	44.990738,40.5999124	8245	\N	2026-03-21 20:52:49.875179+00
116	Фастовецкая	fastovetskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=116	45.917324,40.154659	8573	\N	2026-03-21 20:52:49.875179+00
117	Казанская	kazanskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=117	45.4074844,40.4406018	10991	\N	2026-03-21 20:52:49.875179+00
118	Кавказская	kavkazskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=118	45.4393405,40.6697566	11164	\N	2026-03-21 20:52:49.875179+00
119	Петровская	petrovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=119	45.430317,37.956711	13554	\N	2026-03-21 20:52:49.875179+00
120	Новокубанск	novokubansk	city	2	https://loremflickr.com/800/400/city,town,street?random=120	45.1083184,41.0366896	35251	\N	2026-03-21 20:52:49.875179+00
121	Гулькевичи	gulkevichi	city	2	https://loremflickr.com/800/400/city,town,street?random=121	45.3565119,40.6962256	34347	\N	2026-03-21 20:52:49.875179+00
122	Советская	sovetskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=122	44.7836633,41.1711179	9021	\N	2026-03-21 20:52:49.875179+00
123	Тамань	taman	city	2	https://loremflickr.com/800/400/city,town,street?random=123	45.2158646,36.7191326	10827	\N	2026-03-21 20:52:49.875179+00
124	Марьянская	maryanskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=124	45.0991226,38.6367903	10643	\N	2026-03-21 20:52:49.875179+00
125	Октябрьская	oktyabrskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=125	46.2837923,39.8102996	11252	\N	2026-03-21 20:52:49.875179+00
126	Красносельский	krasnoselskiy	city	2	https://loremflickr.com/800/400/city,town,street?random=126	45.3934779,40.598473	7676	\N	2026-03-21 20:52:49.875179+00
127	Успенское	uspenskoe	city	2	https://loremflickr.com/800/400/city,town,street?random=127	44.8346548,41.3850485	12409	\N	2026-03-21 20:52:49.875179+00
128	Коноково	konokovo	city	2	https://loremflickr.com/800/400/city,town,street?random=128	44.8617355,41.325343	7880	\N	2026-03-21 20:52:49.875179+00
129	Черноморский	chernomorskiy	city	2	https://loremflickr.com/800/400/city,town,street?random=129	44.849996,38.4944065	8512	\N	2026-03-21 20:52:49.875179+00
130	Родниковская	rodnikovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=130	44.7685255,40.6579706	8346	\N	2026-03-21 20:52:49.875179+00
131	Отрадная	otradnaya	city	2	https://loremflickr.com/800/400/city,town,street?random=131	44.3975687,41.5263169	23204	\N	2026-03-21 20:52:49.875179+00
132	Кропоткин	kropotkin	city	2	https://loremflickr.com/800/400/city,town,street?random=132	45.4344413,40.5750274	79795	\N	2026-03-21 20:52:49.875179+00
133	Кореновск	korenovsk	city	2	https://loremflickr.com/800/400/city,town,street?random=133	45.4635863,39.4487565	41828	\N	2026-03-21 20:52:49.875179+00
134	Старокорсунская	starokorsunskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=134	45.0506551,39.3130266	12238	\N	2026-03-21 20:52:49.875179+00
135	Хадыженск	hadyzhensk	city	2	https://loremflickr.com/800/400/city,town,street?random=135	44.4231032,39.5369484	22430	\N	2026-03-21 20:52:49.875179+00
136	Гирей	girey	city	2	https://loremflickr.com/800/400/city,town,street?random=136	45.4024641,40.6581862	6441	\N	2026-03-21 20:52:49.875179+00
137	Владимирская	vladimirskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=137	44.5446631,40.8043345	7217	\N	2026-03-21 20:52:49.875179+00
138	Старомышастовская	staromyshastovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=138	45.3419471,39.0729692	10610	\N	2026-03-21 20:52:49.875179+00
139	Гостагаевская	gostagaevskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=139	45.024044,37.502266	9772	\N	2026-03-21 20:52:49.875179+00
140	Нововеличковская	novovelichkovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=140	45.2787805,38.8377083	9169	\N	2026-03-21 20:52:49.875179+00
141	Ивановская	ivanovskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=141	45.2672191,38.4653294	9473	\N	2026-03-21 20:52:49.875179+00
142	Старая Станица	staraya-stanitsa	city	2	https://loremflickr.com/800/400/city,town,street?random=142	45.0143064,41.1490284	7612	\N	2026-03-21 20:52:49.875179+00
143	Красная Поляна	krasnaya-polyana	city	2	https://loremflickr.com/800/400/city,town,street?random=143	43.6779574,40.2069574	9165	\N	2026-03-21 20:52:49.875179+00
144	Полтавская	poltavskaya	city	2	https://loremflickr.com/800/400/city,town,street?random=144	45.366794,38.2115057	26490	\N	2026-03-21 20:52:49.875179+00
145	Сириус	sirius	city	2	https://loremflickr.com/800/400/city,town,street?random=145	43.4062071,39.9545377	\N	\N	2026-03-21 20:52:49.875179+00
\.


--
-- Data for Name: interests; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.interests (id, name, emoji) FROM stdin;
1	Гастро	🍽
2	Вино	🍷
3	Эко	🌿
4	Природа	🏔
5	Культура	🏛
6	Отдых	🏖
7	Активность	🚴
8	Workation	💻
9	Семья	👨‍👩‍👧‍👦
10	Романтика	❤️
11	Фото	📸
12	История	📜
\.


--
-- Data for Name: invites; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.invites (id, inviter_id, invitee_id, code, created_at) FROM stdin;
\.


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.offers (id, post_id, title, description, discount_percent, valid_from, valid_to, created_at) FROM stdin;
1	1	Скидка 20% на дегустацию	При бронировании через приложение	20	2026-04-01	2026-06-30	2026-03-21 21:02:46.314785+00
2	1	Бесплатный трансфер	При заказе тура от 2 дней	\N	2026-04-01	2026-05-31	2026-03-21 21:02:46.314785+00
3	1	2=3 ночи в глэмпинге	Третья ночь в подарок	33	2026-05-01	2026-08-31	2026-03-21 21:02:46.314785+00
4	1	Детям до 7 бесплатно	На все экскурсии	100	2026-04-01	2026-12-31	2026-03-21 21:02:46.314785+00
\.


--
-- Data for Name: place_schedule_overrides; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.place_schedule_overrides (id, post_id, date, is_closed, open_time, close_time, reason) FROM stdin;
\.


--
-- Data for Name: place_schedules; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.place_schedules (id, post_id, day_of_week, open_time, close_time, is_closed) FROM stdin;
\.


--
-- Data for Name: place_tags; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.place_tags (post_id, tag_id, weight) FROM stdin;
\.


--
-- Data for Name: post_interests; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.post_interests (post_id, interest_id) FROM stdin;
\.


--
-- Data for Name: post_media; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.post_media (id, post_id, url, alt, "position", created_at) FROM stdin;
437	417	https://loremflickr.com/800/600/picnic,park,nature?random=4170	Место для пикника	0	2026-03-22 00:03:02.780557+00
438	417	https://loremflickr.com/800/600/picnic,park,nature?random=4171	Место для пикника	1	2026-03-22 00:03:02.780557+00
439	80	https://loremflickr.com/800/600/restaurant,food,dining?random=800	Kuvee Karsov	0	2026-03-22 00:03:02.780557+00
423	193	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1930	Катюша	0	2026-03-22 00:03:02.780557+00
424	193	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1931	Катюша	1	2026-03-22 00:03:02.780557+00
425	134	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1340	У Джафара	0	2026-03-22 00:03:02.780557+00
426	134	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1341	У Джафара	1	2026-03-22 00:03:02.780557+00
427	12	https://loremflickr.com/800/600/restaurant,food,dining?random=120	Казачок	0	2026-03-22 00:03:02.780557+00
428	12	https://loremflickr.com/800/600/restaurant,food,dining?random=121	Казачок	1	2026-03-22 00:03:02.780557+00
429	312	https://loremflickr.com/800/600/hotel,resort,room?random=3120	Золотая колесница	0	2026-03-22 00:03:02.780557+00
430	312	https://loremflickr.com/800/600/hotel,resort,room?random=3121	Золотая колесница	1	2026-03-22 00:03:02.780557+00
431	271	https://loremflickr.com/800/600/gas+station,fuel?random=2710	Уфимнефть	0	2026-03-22 00:03:02.780557+00
432	271	https://loremflickr.com/800/600/gas+station,fuel?random=2711	Уфимнефть	1	2026-03-22 00:03:02.780557+00
433	270	https://loremflickr.com/800/600/gas+station,fuel?random=2700	Роснефть	0	2026-03-22 00:03:02.780557+00
434	270	https://loremflickr.com/800/600/gas+station,fuel?random=2701	Роснефть	1	2026-03-22 00:03:02.780557+00
435	158	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1580	Закусочная	0	2026-03-22 00:03:02.780557+00
436	158	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1581	Закусочная	1	2026-03-22 00:03:02.780557+00
440	80	https://loremflickr.com/800/600/restaurant,food,dining?random=801	Kuvee Karsov	1	2026-03-22 00:03:02.780557+00
441	480	https://loremflickr.com/800/600/winery,vineyard,wine?random=4800	Шато Ле Гран Восток	0	2026-03-22 00:03:02.780557+00
442	480	https://loremflickr.com/800/600/winery,vineyard,wine?random=4801	Шато Ле Гран Восток	1	2026-03-22 00:03:02.780557+00
443	219	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2190	Грязевой вулкан Азовское пекло (Плевак)	0	2026-03-22 00:03:02.780557+00
444	219	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2191	Грязевой вулкан Азовское пекло (Плевак)	1	2026-03-22 00:03:02.780557+00
445	187	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1870	грязевой вулкан Тиздар	0	2026-03-22 00:03:02.780557+00
446	187	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1871	грязевой вулкан Тиздар	1	2026-03-22 00:03:02.780557+00
447	432	https://loremflickr.com/800/600/beach,sea,coast?random=4320	Пляж	0	2026-03-22 00:03:02.780557+00
448	432	https://loremflickr.com/800/600/beach,sea,coast?random=4321	Пляж	1	2026-03-22 00:03:02.780557+00
449	429	https://loremflickr.com/800/600/beach,sea,coast?random=4290	Подмаячный	0	2026-03-22 00:03:02.780557+00
450	429	https://loremflickr.com/800/600/beach,sea,coast?random=4291	Подмаячный	1	2026-03-22 00:03:02.780557+00
451	428	https://loremflickr.com/800/600/beach,sea,coast?random=4280	У Джокера	0	2026-03-22 00:03:02.780557+00
452	428	https://loremflickr.com/800/600/beach,sea,coast?random=4281	У Джокера	1	2026-03-22 00:03:02.780557+00
453	421	https://loremflickr.com/800/600/beach,sea,coast?random=4210	Фанагорийский пляж	0	2026-03-22 00:03:02.780557+00
454	421	https://loremflickr.com/800/600/beach,sea,coast?random=4211	Фанагорийский пляж	1	2026-03-22 00:03:02.780557+00
455	420	https://loremflickr.com/800/600/beach,sea,coast?random=4200	Центральный пляж	0	2026-03-22 00:03:02.780557+00
456	420	https://loremflickr.com/800/600/beach,sea,coast?random=4201	Центральный пляж	1	2026-03-22 00:03:02.780557+00
457	419	https://loremflickr.com/800/600/beach,sea,coast?random=4190	"Лурьевский" пляж	0	2026-03-22 00:03:02.780557+00
458	419	https://loremflickr.com/800/600/beach,sea,coast?random=4191	"Лурьевский" пляж	1	2026-03-22 00:03:02.780557+00
459	418	https://loremflickr.com/800/600/beach,sea,coast?random=4180	"Адвокатский" пляж	0	2026-03-22 00:03:02.780557+00
460	418	https://loremflickr.com/800/600/beach,sea,coast?random=4181	"Адвокатский" пляж	1	2026-03-22 00:03:02.780557+00
461	356	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3560	Подмаячное	0	2026-03-22 00:03:02.780557+00
462	356	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3561	Подмаячное	1	2026-03-22 00:03:02.780557+00
463	481	https://loremflickr.com/800/600/winery,vineyard,wine?random=4810	Раевское	0	2026-03-22 00:03:02.780557+00
464	481	https://loremflickr.com/800/600/winery,vineyard,wine?random=4811	Раевское	1	2026-03-22 00:03:02.780557+00
465	315	https://loremflickr.com/800/600/hotel,resort,room?random=3150	Жемчужина	0	2026-03-22 00:03:02.780557+00
466	315	https://loremflickr.com/800/600/hotel,resort,room?random=3151	Жемчужина	1	2026-03-22 00:03:02.780557+00
467	211	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2110	Дольмен	0	2026-03-22 00:03:02.780557+00
468	211	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2111	Дольмен	1	2026-03-22 00:03:02.780557+00
469	210	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2100	Дольмен	0	2026-03-22 00:03:02.780557+00
470	210	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2101	Дольмен	1	2026-03-22 00:03:02.780557+00
471	116	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1160	«Куманек» (не работает)	0	2026-03-22 00:03:02.780557+00
472	116	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1161	«Куманек» (не работает)	1	2026-03-22 00:03:02.780557+00
473	494	https://loremflickr.com/800/600/camping,glamping,tent?random=4940	приют Альпинистский (У Наташи)	0	2026-03-22 00:03:02.780557+00
474	494	https://loremflickr.com/800/600/camping,glamping,tent?random=4941	приют Альпинистский (У Наташи)	1	2026-03-22 00:03:02.780557+00
475	477	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4770	Большой Пшадский (Оляпкин)	0	2026-03-22 00:03:02.780557+00
476	477	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4771	Большой Пшадский (Оляпкин)	1	2026-03-22 00:03:02.780557+00
477	476	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4760	Водопад	0	2026-03-22 00:03:02.780557+00
478	476	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4761	Водопад	1	2026-03-22 00:03:02.780557+00
479	475	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4750	Плесецкие	0	2026-03-22 00:03:02.780557+00
480	475	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4751	Плесецкие	1	2026-03-22 00:03:02.780557+00
481	474	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4740	Изумрудный	0	2026-03-22 00:03:02.780557+00
482	474	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4741	Изумрудный	1	2026-03-22 00:03:02.780557+00
483	430	https://loremflickr.com/800/600/beach,sea,coast?random=4300	Пляж	0	2026-03-22 00:03:02.780557+00
484	430	https://loremflickr.com/800/600/beach,sea,coast?random=4301	Пляж	1	2026-03-22 00:03:02.780557+00
485	413	https://loremflickr.com/800/600/picnic,park,nature?random=4130	Место для пикника	0	2026-03-22 00:03:02.780557+00
486	413	https://loremflickr.com/800/600/picnic,park,nature?random=4131	Место для пикника	1	2026-03-22 00:03:02.780557+00
487	410	https://loremflickr.com/800/600/picnic,park,nature?random=4100	Место для пикника	0	2026-03-22 00:03:02.780557+00
488	410	https://loremflickr.com/800/600/picnic,park,nature?random=4101	Место для пикника	1	2026-03-22 00:03:02.780557+00
489	352	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3520	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
490	352	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3521	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
491	350	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3500	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
492	350	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3501	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
493	343	https://loremflickr.com/800/600/hotel,resort,room?random=3430	База отдыха	0	2026-03-22 00:03:02.780557+00
494	343	https://loremflickr.com/800/600/hotel,resort,room?random=3431	База отдыха	1	2026-03-22 00:03:02.780557+00
495	511	https://loremflickr.com/800/600/camping,glamping,tent?random=5110	Кемпинг	0	2026-03-22 00:03:02.780557+00
496	511	https://loremflickr.com/800/600/camping,glamping,tent?random=5111	Кемпинг	1	2026-03-22 00:03:02.780557+00
497	510	https://loremflickr.com/800/600/camping,glamping,tent?random=5100	Кемпинг	0	2026-03-22 00:03:02.780557+00
498	510	https://loremflickr.com/800/600/camping,glamping,tent?random=5101	Кемпинг	1	2026-03-22 00:03:02.780557+00
499	509	https://loremflickr.com/800/600/camping,glamping,tent?random=5090	Кемпинг	0	2026-03-22 00:03:02.780557+00
500	509	https://loremflickr.com/800/600/camping,glamping,tent?random=5091	Кемпинг	1	2026-03-22 00:03:02.780557+00
501	508	https://loremflickr.com/800/600/camping,glamping,tent?random=5080	Кемпинг	0	2026-03-22 00:03:02.780557+00
502	508	https://loremflickr.com/800/600/camping,glamping,tent?random=5081	Кемпинг	1	2026-03-22 00:03:02.780557+00
503	307	https://loremflickr.com/800/600/hotel,resort,room?random=3070	Царина Поляна	0	2026-03-22 00:03:02.780557+00
504	307	https://loremflickr.com/800/600/hotel,resort,room?random=3071	Царина Поляна	1	2026-03-22 00:03:02.780557+00
505	266	https://loremflickr.com/800/600/gas+station,fuel?random=2660	Лукойл	0	2026-03-22 00:03:02.780557+00
506	266	https://loremflickr.com/800/600/gas+station,fuel?random=2661	Лукойл	1	2026-03-22 00:03:02.780557+00
507	196	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1960	Чаша	0	2026-03-22 00:03:02.780557+00
508	196	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1961	Чаша	1	2026-03-22 00:03:02.780557+00
509	505	https://loremflickr.com/800/600/camping,glamping,tent?random=5050	Полянка нежная	0	2026-03-22 00:03:02.780557+00
510	505	https://loremflickr.com/800/600/camping,glamping,tent?random=5051	Полянка нежная	1	2026-03-22 00:03:02.780557+00
511	504	https://loremflickr.com/800/600/camping,glamping,tent?random=5040	Эдельвейс	0	2026-03-22 00:03:02.780557+00
512	504	https://loremflickr.com/800/600/camping,glamping,tent?random=5041	Эдельвейс	1	2026-03-22 00:03:02.780557+00
513	503	https://loremflickr.com/800/600/camping,glamping,tent?random=5030	Альпико	0	2026-03-22 00:03:02.780557+00
514	503	https://loremflickr.com/800/600/camping,glamping,tent?random=5031	Альпико	1	2026-03-22 00:03:02.780557+00
515	496	https://loremflickr.com/800/600/camping,glamping,tent?random=4960	тур приют	0	2026-03-22 00:03:02.780557+00
516	496	https://loremflickr.com/800/600/camping,glamping,tent?random=4961	тур приют	1	2026-03-22 00:03:02.780557+00
517	465	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4650	Чинарев	0	2026-03-22 00:03:02.780557+00
518	465	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4651	Чинарев	1	2026-03-22 00:03:02.780557+00
519	464	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4640	Монахов	0	2026-03-22 00:03:02.780557+00
520	464	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4641	Монахов	1	2026-03-22 00:03:02.780557+00
521	463	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4630	Чинарский	0	2026-03-22 00:03:02.780557+00
522	463	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4631	Чинарский	1	2026-03-22 00:03:02.780557+00
523	462	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4620	Университетский	0	2026-03-22 00:03:02.780557+00
524	462	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4621	Университетский	1	2026-03-22 00:03:02.780557+00
525	408	https://loremflickr.com/800/600/picnic,park,nature?random=4080	Место для пикника	0	2026-03-22 00:03:02.780557+00
526	408	https://loremflickr.com/800/600/picnic,park,nature?random=4081	Место для пикника	1	2026-03-22 00:03:02.780557+00
527	407	https://loremflickr.com/800/600/picnic,park,nature?random=4070	Столик	0	2026-03-22 00:03:02.780557+00
528	407	https://loremflickr.com/800/600/picnic,park,nature?random=4071	Столик	1	2026-03-22 00:03:02.780557+00
529	391	https://loremflickr.com/800/600/picnic,park,nature?random=3910	Альпико парк	0	2026-03-22 00:03:02.780557+00
530	391	https://loremflickr.com/800/600/picnic,park,nature?random=3911	Альпико парк	1	2026-03-22 00:03:02.780557+00
531	389	https://loremflickr.com/800/600/picnic,park,nature?random=3890	Место для пикника	0	2026-03-22 00:03:02.780557+00
532	389	https://loremflickr.com/800/600/picnic,park,nature?random=3891	Место для пикника	1	2026-03-22 00:03:02.780557+00
533	366	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3660	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
534	366	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3661	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
535	365	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3650	Михайлов камень	0	2026-03-22 00:03:02.780557+00
536	365	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3651	Михайлов камень	1	2026-03-22 00:03:02.780557+00
537	364	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3640	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
538	364	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3641	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
539	362	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3620	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
540	362	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3621	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
541	361	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3610	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
542	361	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3611	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
543	360	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3600	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
544	360	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3601	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
545	349	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3490	Чай с мёдом	0	2026-03-22 00:03:02.780557+00
546	349	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3491	Чай с мёдом	1	2026-03-22 00:03:02.780557+00
547	223	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2230	Дольмен	0	2026-03-22 00:03:02.780557+00
548	223	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2231	Дольмен	1	2026-03-22 00:03:02.780557+00
549	222	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2220	Дольмен	0	2026-03-22 00:03:02.780557+00
550	222	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2221	Дольмен	1	2026-03-22 00:03:02.780557+00
551	221	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2210	Дольмен	0	2026-03-22 00:03:02.780557+00
552	221	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2211	Дольмен	1	2026-03-22 00:03:02.780557+00
553	209	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2090	Два дольмена (разрушены)	0	2026-03-22 00:03:02.780557+00
554	209	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2091	Два дольмена (разрушены)	1	2026-03-22 00:03:02.780557+00
555	208	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2080	кам-море	0	2026-03-22 00:03:02.780557+00
556	208	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2081	кам-море	1	2026-03-22 00:03:02.780557+00
557	199	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1990	Дольмены	0	2026-03-22 00:03:02.780557+00
558	199	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1991	Дольмены	1	2026-03-22 00:03:02.780557+00
559	195	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1950	Двубратский каньон	0	2026-03-22 00:03:02.780557+00
560	195	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1951	Двубратский каньон	1	2026-03-22 00:03:02.780557+00
561	522	https://loremflickr.com/800/600/camping,glamping,tent?random=5220	Тотем шаманов	0	2026-03-22 00:03:02.780557+00
562	522	https://loremflickr.com/800/600/camping,glamping,tent?random=5221	Тотем шаманов	1	2026-03-22 00:03:02.780557+00
563	521	https://loremflickr.com/800/600/camping,glamping,tent?random=5210	Кемпинг	0	2026-03-22 00:03:02.780557+00
564	521	https://loremflickr.com/800/600/camping,glamping,tent?random=5211	Кемпинг	1	2026-03-22 00:03:02.780557+00
565	502	https://loremflickr.com/800/600/camping,glamping,tent?random=5020	Кемпинг	0	2026-03-22 00:03:02.780557+00
566	502	https://loremflickr.com/800/600/camping,glamping,tent?random=5021	Кемпинг	1	2026-03-22 00:03:02.780557+00
567	501	https://loremflickr.com/800/600/camping,glamping,tent?random=5010	Кемпинг	0	2026-03-22 00:03:02.780557+00
568	501	https://loremflickr.com/800/600/camping,glamping,tent?random=5011	Кемпинг	1	2026-03-22 00:03:02.780557+00
569	500	https://loremflickr.com/800/600/camping,glamping,tent?random=5000	Кемпинг	0	2026-03-22 00:03:02.780557+00
570	500	https://loremflickr.com/800/600/camping,glamping,tent?random=5001	Кемпинг	1	2026-03-22 00:03:02.780557+00
571	499	https://loremflickr.com/800/600/camping,glamping,tent?random=4990	Кемпинг	0	2026-03-22 00:03:02.780557+00
572	499	https://loremflickr.com/800/600/camping,glamping,tent?random=4991	Кемпинг	1	2026-03-22 00:03:02.780557+00
573	498	https://loremflickr.com/800/600/camping,glamping,tent?random=4980	Кемпинг	0	2026-03-22 00:03:02.780557+00
574	498	https://loremflickr.com/800/600/camping,glamping,tent?random=4981	Кемпинг	1	2026-03-22 00:03:02.780557+00
575	497	https://loremflickr.com/800/600/camping,glamping,tent?random=4970	Кемпинг	0	2026-03-22 00:03:02.780557+00
576	497	https://loremflickr.com/800/600/camping,glamping,tent?random=4971	Кемпинг	1	2026-03-22 00:03:02.780557+00
577	473	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4730	Двухкаскадный	0	2026-03-22 00:03:02.780557+00
578	473	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4731	Двухкаскадный	1	2026-03-22 00:03:02.780557+00
579	472	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4720	Водопад	0	2026-03-22 00:03:02.780557+00
580	472	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4721	Водопад	1	2026-03-22 00:03:02.780557+00
581	456	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4560	Водопад	0	2026-03-22 00:03:02.780557+00
582	456	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4561	Водопад	1	2026-03-22 00:03:02.780557+00
583	448	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4480	Кесух	0	2026-03-22 00:03:02.780557+00
584	448	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4481	Кесух	1	2026-03-22 00:03:02.780557+00
585	392	https://loremflickr.com/800/600/picnic,park,nature?random=3920	Место для пикника	0	2026-03-22 00:03:02.780557+00
586	392	https://loremflickr.com/800/600/picnic,park,nature?random=3921	Место для пикника	1	2026-03-22 00:03:02.780557+00
587	387	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3870	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
588	387	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3871	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
589	386	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3860	Вид на каньон	0	2026-03-22 00:03:02.780557+00
590	386	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3861	Вид на каньон	1	2026-03-22 00:03:02.780557+00
591	385	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3850	Вид на водопад Сказка	0	2026-03-22 00:03:02.780557+00
592	385	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3851	Вид на водопад Сказка	1	2026-03-22 00:03:02.780557+00
593	375	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3750	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
594	375	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3751	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
595	354	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3540	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
596	354	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3541	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
597	520	https://loremflickr.com/800/600/camping,glamping,tent?random=5200	Развалины пастушьего укрытия	0	2026-03-22 00:03:02.780557+00
598	520	https://loremflickr.com/800/600/camping,glamping,tent?random=5201	Развалины пастушьего укрытия	1	2026-03-22 00:03:02.780557+00
599	453	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4530	Пшехский	0	2026-03-22 00:03:02.780557+00
600	453	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4531	Пшехский	1	2026-03-22 00:03:02.780557+00
601	409	https://loremflickr.com/800/600/picnic,park,nature?random=4090	Ночёвка запрещена. Штраф 5000р	0	2026-03-22 00:03:02.780557+00
602	409	https://loremflickr.com/800/600/picnic,park,nature?random=4091	Ночёвка запрещена. Штраф 5000р	1	2026-03-22 00:03:02.780557+00
603	377	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3770	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
604	377	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3771	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
605	376	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3760	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
606	376	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3761	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
607	367	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3670	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
608	367	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3671	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
609	353	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3530	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
610	353	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3531	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
611	351	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3510	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
612	351	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3511	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
613	327	https://loremflickr.com/800/600/hotel,resort,room?random=3270	Энектур	0	2026-03-22 00:03:02.780557+00
614	327	https://loremflickr.com/800/600/hotel,resort,room?random=3271	Энектур	1	2026-03-22 00:03:02.780557+00
615	202	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2020	Шум	0	2026-03-22 00:03:02.780557+00
616	202	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2021	Шум	1	2026-03-22 00:03:02.780557+00
617	198	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1980	Гришкина яма	0	2026-03-22 00:03:02.780557+00
618	198	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1981	Гришкина яма	1	2026-03-22 00:03:02.780557+00
619	192	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1920	Казачий камень	0	2026-03-22 00:03:02.780557+00
620	192	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1921	Казачий камень	1	2026-03-22 00:03:02.780557+00
621	523	https://loremflickr.com/800/600/camping,glamping,tent?random=5230	Кемпинг	0	2026-03-22 00:03:02.780557+00
622	523	https://loremflickr.com/800/600/camping,glamping,tent?random=5231	Кемпинг	1	2026-03-22 00:03:02.780557+00
623	515	https://loremflickr.com/800/600/camping,glamping,tent?random=5150	Кемпинг	0	2026-03-22 00:03:02.780557+00
624	515	https://loremflickr.com/800/600/camping,glamping,tent?random=5151	Кемпинг	1	2026-03-22 00:03:02.780557+00
625	513	https://loremflickr.com/800/600/camping,glamping,tent?random=5130	Кемпинг	0	2026-03-22 00:03:02.780557+00
626	513	https://loremflickr.com/800/600/camping,glamping,tent?random=5131	Кемпинг	1	2026-03-22 00:03:02.780557+00
627	512	https://loremflickr.com/800/600/camping,glamping,tent?random=5120	Кемпинг	0	2026-03-22 00:03:02.780557+00
628	512	https://loremflickr.com/800/600/camping,glamping,tent?random=5121	Кемпинг	1	2026-03-22 00:03:02.780557+00
629	507	https://loremflickr.com/800/600/camping,glamping,tent?random=5070	Кемпинг	0	2026-03-22 00:03:02.780557+00
630	507	https://loremflickr.com/800/600/camping,glamping,tent?random=5071	Кемпинг	1	2026-03-22 00:03:02.780557+00
631	467	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4670	Шум	0	2026-03-22 00:03:02.780557+00
632	467	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4671	Шум	1	2026-03-22 00:03:02.780557+00
633	466	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4660	Водопад	0	2026-03-22 00:03:02.780557+00
634	466	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4661	Водопад	1	2026-03-22 00:03:02.780557+00
635	458	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4580	Раскол	0	2026-03-22 00:03:02.780557+00
636	458	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4581	Раскол	1	2026-03-22 00:03:02.780557+00
637	457	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4570	Три Брата	0	2026-03-22 00:03:02.780557+00
638	457	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4571	Три Брата	1	2026-03-22 00:03:02.780557+00
639	390	https://loremflickr.com/800/600/picnic,park,nature?random=3900	Навес	0	2026-03-22 00:03:02.780557+00
640	390	https://loremflickr.com/800/600/picnic,park,nature?random=3901	Навес	1	2026-03-22 00:03:02.780557+00
641	382	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3820	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
642	382	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3821	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
643	381	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3810	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
644	381	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3811	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
645	380	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3800	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
646	380	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3801	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
647	379	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3790	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
648	379	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3791	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
649	371	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3710	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
650	371	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3711	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
651	370	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3700	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
652	370	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3701	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
653	369	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3690	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
654	369	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3691	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
655	368	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3680	Даховская панорама	0	2026-03-22 00:03:02.780557+00
656	368	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3681	Даховская панорама	1	2026-03-22 00:03:02.780557+00
657	292	https://loremflickr.com/800/600/museum,art,gallery?random=2920	Музей станицы Бриньковской имени Г.Я. Бахчиванджи	0	2026-03-22 00:03:02.780557+00
658	292	https://loremflickr.com/800/600/museum,art,gallery?random=2921	Музей станицы Бриньковской имени Г.Я. Бахчиванджи	1	2026-03-22 00:03:02.780557+00
659	288	https://loremflickr.com/800/600/museum,art,gallery?random=2880	Краеведческий музей	0	2026-03-22 00:03:02.780557+00
660	288	https://loremflickr.com/800/600/museum,art,gallery?random=2881	Краеведческий музей	1	2026-03-22 00:03:02.780557+00
661	317	https://loremflickr.com/800/600/hotel,resort,room?random=3170	Академия	0	2026-03-22 00:03:02.780557+00
662	317	https://loremflickr.com/800/600/hotel,resort,room?random=3171	Академия	1	2026-03-22 00:03:02.780557+00
663	422	https://loremflickr.com/800/600/beach,sea,coast?random=4220	Пляж	0	2026-03-22 00:03:02.780557+00
664	422	https://loremflickr.com/800/600/beach,sea,coast?random=4221	Пляж	1	2026-03-22 00:03:02.780557+00
665	216	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2160	Форелевое хозяйство	0	2026-03-22 00:03:02.780557+00
666	216	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2161	Форелевое хозяйство	1	2026-03-22 00:03:02.780557+00
667	25	https://loremflickr.com/800/600/restaurant,food,dining?random=250	Таверна Каньон	0	2026-03-22 00:03:02.780557+00
668	25	https://loremflickr.com/800/600/restaurant,food,dining?random=251	Таверна Каньон	1	2026-03-22 00:03:02.780557+00
669	185	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1850	Цветочные часы	0	2026-03-22 00:03:02.780557+00
670	185	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1851	Цветочные часы	1	2026-03-22 00:03:02.780557+00
671	181	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1810	У трех берез	0	2026-03-22 00:03:02.780557+00
672	181	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1811	У трех берез	1	2026-03-22 00:03:02.780557+00
673	180	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1800	Лиза	0	2026-03-22 00:03:02.780557+00
674	180	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1801	Лиза	1	2026-03-22 00:03:02.780557+00
675	177	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1770	Три берёзы	0	2026-03-22 00:03:02.780557+00
676	177	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1771	Три берёзы	1	2026-03-22 00:03:02.780557+00
677	153	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1530	Pankiss	0	2026-03-22 00:03:02.780557+00
678	153	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1531	Pankiss	1	2026-03-22 00:03:02.780557+00
679	139	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1390	Zohan bar	0	2026-03-22 00:03:02.780557+00
680	139	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1391	Zohan bar	1	2026-03-22 00:03:02.780557+00
681	138	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1380	Сармат	0	2026-03-22 00:03:02.780557+00
682	138	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1381	Сармат	1	2026-03-22 00:03:02.780557+00
683	133	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1330	5 Авеню	0	2026-03-22 00:03:02.780557+00
684	133	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1331	5 Авеню	1	2026-03-22 00:03:02.780557+00
685	131	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1310	Жар-Пицца	0	2026-03-22 00:03:02.780557+00
686	131	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1311	Жар-Пицца	1	2026-03-22 00:03:02.780557+00
687	129	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1290	Мир Любви	0	2026-03-22 00:03:02.780557+00
688	129	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1291	Мир Любви	1	2026-03-22 00:03:02.780557+00
689	128	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1280	Off-Road Кафе	0	2026-03-22 00:03:02.780557+00
690	128	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1281	Off-Road Кафе	1	2026-03-22 00:03:02.780557+00
691	126	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1260	Шашлык	0	2026-03-22 00:03:02.780557+00
692	126	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1261	Шашлык	1	2026-03-22 00:03:02.780557+00
693	122	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1220	Пицца-Лав	0	2026-03-22 00:03:02.780557+00
694	122	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1221	Пицца-Лав	1	2026-03-22 00:03:02.780557+00
695	121	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1210	Сгущёнка	0	2026-03-22 00:03:02.780557+00
696	121	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1211	Сгущёнка	1	2026-03-22 00:03:02.780557+00
697	118	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1180	Патрик & Мари	0	2026-03-22 00:03:02.780557+00
698	118	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1181	Патрик & Мари	1	2026-03-22 00:03:02.780557+00
699	117	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1170	Don Cappuccino	0	2026-03-22 00:03:02.780557+00
700	117	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1171	Don Cappuccino	1	2026-03-22 00:03:02.780557+00
701	115	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1150	Sweet Beans	0	2026-03-22 00:03:02.780557+00
702	115	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1151	Sweet Beans	1	2026-03-22 00:03:02.780557+00
703	114	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1140	Квартира	0	2026-03-22 00:03:02.780557+00
704	114	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1141	Квартира	1	2026-03-22 00:03:02.780557+00
705	113	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1130	Жар-пицца	0	2026-03-22 00:03:02.780557+00
706	113	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1131	Жар-пицца	1	2026-03-22 00:03:02.780557+00
707	112	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1120	Т-кафе	0	2026-03-22 00:03:02.780557+00
708	112	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1121	Т-кафе	1	2026-03-22 00:03:02.780557+00
709	111	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1110	Жаровня	0	2026-03-22 00:03:02.780557+00
710	111	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1111	Жаровня	1	2026-03-22 00:03:02.780557+00
711	110	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1100	Столовая	0	2026-03-22 00:03:02.780557+00
712	110	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1101	Столовая	1	2026-03-22 00:03:02.780557+00
713	109	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1090	Заря	0	2026-03-22 00:03:02.780557+00
714	109	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1091	Заря	1	2026-03-22 00:03:02.780557+00
715	108	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1080	Уни пицца	0	2026-03-22 00:03:02.780557+00
716	108	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1081	Уни пицца	1	2026-03-22 00:03:02.780557+00
717	107	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1070	Уни Пицца	0	2026-03-22 00:03:02.780557+00
718	107	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1071	Уни Пицца	1	2026-03-22 00:03:02.780557+00
719	106	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1060	Куба	0	2026-03-22 00:03:02.780557+00
720	106	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1061	Куба	1	2026-03-22 00:03:02.780557+00
721	105	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1050	Столовая	0	2026-03-22 00:03:02.780557+00
722	105	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1051	Столовая	1	2026-03-22 00:03:02.780557+00
723	104	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1040	Мэни Пельмени	0	2026-03-22 00:03:02.780557+00
724	104	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1041	Мэни Пельмени	1	2026-03-22 00:03:02.780557+00
725	103	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1030	Любо Кондитерская	0	2026-03-22 00:03:02.780557+00
726	103	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1031	Любо Кондитерская	1	2026-03-22 00:03:02.780557+00
727	102	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1020	Холостядзе	0	2026-03-22 00:03:02.780557+00
728	102	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1021	Холостядзе	1	2026-03-22 00:03:02.780557+00
729	101	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1010	Плезир	0	2026-03-22 00:03:02.780557+00
730	101	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1011	Плезир	1	2026-03-22 00:03:02.780557+00
731	100	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1000	The Печь	0	2026-03-22 00:03:02.780557+00
732	100	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1001	The Печь	1	2026-03-22 00:03:02.780557+00
733	99	https://loremflickr.com/800/600/cafe,coffee,bakery?random=990	Холостяк	0	2026-03-22 00:03:02.780557+00
734	99	https://loremflickr.com/800/600/cafe,coffee,bakery?random=991	Холостяк	1	2026-03-22 00:03:02.780557+00
735	98	https://loremflickr.com/800/600/cafe,coffee,bakery?random=980	Кафе "Любо"	0	2026-03-22 00:03:02.780557+00
736	98	https://loremflickr.com/800/600/cafe,coffee,bakery?random=981	Кафе "Любо"	1	2026-03-22 00:03:02.780557+00
737	97	https://loremflickr.com/800/600/cafe,coffee,bakery?random=970	Леди Мармелад	0	2026-03-22 00:03:02.780557+00
738	97	https://loremflickr.com/800/600/cafe,coffee,bakery?random=971	Леди Мармелад	1	2026-03-22 00:03:02.780557+00
739	96	https://loremflickr.com/800/600/cafe,coffee,bakery?random=960	Дворик	0	2026-03-22 00:03:02.780557+00
740	96	https://loremflickr.com/800/600/cafe,coffee,bakery?random=961	Дворик	1	2026-03-22 00:03:02.780557+00
741	90	https://loremflickr.com/800/600/restaurant,food,dining?random=900	Пена	0	2026-03-22 00:03:02.780557+00
742	90	https://loremflickr.com/800/600/restaurant,food,dining?random=901	Пена	1	2026-03-22 00:03:02.780557+00
743	74	https://loremflickr.com/800/600/restaurant,food,dining?random=740	Восьмое небо	0	2026-03-22 00:03:02.780557+00
744	74	https://loremflickr.com/800/600/restaurant,food,dining?random=741	Восьмое небо	1	2026-03-22 00:03:02.780557+00
745	73	https://loremflickr.com/800/600/restaurant,food,dining?random=730	Prosushi	0	2026-03-22 00:03:02.780557+00
746	73	https://loremflickr.com/800/600/restaurant,food,dining?random=731	Prosushi	1	2026-03-22 00:03:02.780557+00
747	72	https://loremflickr.com/800/600/restaurant,food,dining?random=720	Сатин	0	2026-03-22 00:03:02.780557+00
748	72	https://loremflickr.com/800/600/restaurant,food,dining?random=721	Сатин	1	2026-03-22 00:03:02.780557+00
749	71	https://loremflickr.com/800/600/restaurant,food,dining?random=710	СушиWok	0	2026-03-22 00:03:02.780557+00
750	71	https://loremflickr.com/800/600/restaurant,food,dining?random=711	СушиWok	1	2026-03-22 00:03:02.780557+00
751	70	https://loremflickr.com/800/600/restaurant,food,dining?random=700	Диканька	0	2026-03-22 00:03:02.780557+00
752	70	https://loremflickr.com/800/600/restaurant,food,dining?random=701	Диканька	1	2026-03-22 00:03:02.780557+00
753	184	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1840	Mocco	0	2026-03-22 00:03:02.780557+00
754	184	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1841	Mocco	1	2026-03-22 00:03:02.780557+00
755	225	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2250	Лотосы	0	2026-03-22 00:03:02.780557+00
756	225	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2251	Лотосы	1	2026-03-22 00:03:02.780557+00
757	230	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2300	Дольмен (разрушен)	0	2026-03-22 00:03:02.780557+00
758	230	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2301	Дольмен (разрушен)	1	2026-03-22 00:03:02.780557+00
759	228	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2280	водопад в Кручёной щели	0	2026-03-22 00:03:02.780557+00
760	228	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2281	водопад в Кручёной щели	1	2026-03-22 00:03:02.780557+00
761	224	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2240	Дольмен	0	2026-03-22 00:03:02.780557+00
762	224	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2241	Дольмен	1	2026-03-22 00:03:02.780557+00
763	66	https://loremflickr.com/800/600/restaurant,food,dining?random=660	Пиноккио Djan	0	2026-03-22 00:03:02.780557+00
764	66	https://loremflickr.com/800/600/restaurant,food,dining?random=661	Пиноккио Djan	1	2026-03-22 00:03:02.780557+00
765	56	https://loremflickr.com/800/600/restaurant,food,dining?random=560	Москва	0	2026-03-22 00:03:02.780557+00
766	56	https://loremflickr.com/800/600/restaurant,food,dining?random=561	Москва	1	2026-03-22 00:03:02.780557+00
767	55	https://loremflickr.com/800/600/restaurant,food,dining?random=550	McKEY	0	2026-03-22 00:03:02.780557+00
768	55	https://loremflickr.com/800/600/restaurant,food,dining?random=551	McKEY	1	2026-03-22 00:03:02.780557+00
769	53	https://loremflickr.com/800/600/restaurant,food,dining?random=530	Суши-бар "Минами"	0	2026-03-22 00:03:02.780557+00
770	53	https://loremflickr.com/800/600/restaurant,food,dining?random=531	Суши-бар "Минами"	1	2026-03-22 00:03:02.780557+00
771	51	https://loremflickr.com/800/600/restaurant,food,dining?random=510	Баден-Баден	0	2026-03-22 00:03:02.780557+00
772	51	https://loremflickr.com/800/600/restaurant,food,dining?random=511	Баден-Баден	1	2026-03-22 00:03:02.780557+00
773	49	https://loremflickr.com/800/600/restaurant,food,dining?random=490	Таверна у Замка	0	2026-03-22 00:03:02.780557+00
774	49	https://loremflickr.com/800/600/restaurant,food,dining?random=491	Таверна у Замка	1	2026-03-22 00:03:02.780557+00
775	48	https://loremflickr.com/800/600/restaurant,food,dining?random=480	Грац	0	2026-03-22 00:03:02.780557+00
776	48	https://loremflickr.com/800/600/restaurant,food,dining?random=481	Грац	1	2026-03-22 00:03:02.780557+00
777	43	https://loremflickr.com/800/600/restaurant,food,dining?random=430	Духанъ	0	2026-03-22 00:03:02.780557+00
778	43	https://loremflickr.com/800/600/restaurant,food,dining?random=431	Духанъ	1	2026-03-22 00:03:02.780557+00
779	41	https://loremflickr.com/800/600/restaurant,food,dining?random=410	Старый город	0	2026-03-22 00:03:02.780557+00
780	41	https://loremflickr.com/800/600/restaurant,food,dining?random=411	Старый город	1	2026-03-22 00:03:02.780557+00
781	22	https://loremflickr.com/800/600/restaurant,food,dining?random=220	Amsterdam Bar	0	2026-03-22 00:03:02.780557+00
782	22	https://loremflickr.com/800/600/restaurant,food,dining?random=221	Amsterdam Bar	1	2026-03-22 00:03:02.780557+00
783	11	https://loremflickr.com/800/600/restaurant,food,dining?random=110	У Близнецов	0	2026-03-22 00:03:02.780557+00
784	11	https://loremflickr.com/800/600/restaurant,food,dining?random=111	У Близнецов	1	2026-03-22 00:03:02.780557+00
785	10	https://loremflickr.com/800/600/restaurant,food,dining?random=100	Мадьяр	0	2026-03-22 00:03:02.780557+00
786	10	https://loremflickr.com/800/600/restaurant,food,dining?random=101	Мадьяр	1	2026-03-22 00:03:02.780557+00
787	7	https://loremflickr.com/800/600/restaurant,food,dining?random=70	Пивница	0	2026-03-22 00:03:02.780557+00
788	7	https://loremflickr.com/800/600/restaurant,food,dining?random=71	Пивница	1	2026-03-22 00:03:02.780557+00
789	6	https://loremflickr.com/800/600/restaurant,food,dining?random=60	Сербский ресторан	0	2026-03-22 00:03:02.780557+00
790	6	https://loremflickr.com/800/600/restaurant,food,dining?random=61	Сербский ресторан	1	2026-03-22 00:03:02.780557+00
791	4	https://loremflickr.com/800/600/restaurant,food,dining?random=40	Хванчкара	0	2026-03-22 00:03:02.780557+00
792	4	https://loremflickr.com/800/600/restaurant,food,dining?random=41	Хванчкара	1	2026-03-22 00:03:02.780557+00
793	3	https://loremflickr.com/800/600/restaurant,food,dining?random=30	Старина Герман	0	2026-03-22 00:03:02.780557+00
794	3	https://loremflickr.com/800/600/restaurant,food,dining?random=31	Старина Герман	1	2026-03-22 00:03:02.780557+00
795	2	https://loremflickr.com/800/600/restaurant,food,dining?random=20	Ресторан	0	2026-03-22 00:03:02.780557+00
796	2	https://loremflickr.com/800/600/restaurant,food,dining?random=21	Ресторан	1	2026-03-22 00:03:02.780557+00
797	326	https://loremflickr.com/800/600/hotel,resort,room?random=3260	Forum	0	2026-03-22 00:03:02.780557+00
798	326	https://loremflickr.com/800/600/hotel,resort,room?random=3261	Forum	1	2026-03-22 00:03:02.780557+00
799	325	https://loremflickr.com/800/600/hotel,resort,room?random=3250	Марс	0	2026-03-22 00:03:02.780557+00
800	325	https://loremflickr.com/800/600/hotel,resort,room?random=3251	Марс	1	2026-03-22 00:03:02.780557+00
801	316	https://loremflickr.com/800/600/hotel,resort,room?random=3160	Genoff	0	2026-03-22 00:03:02.780557+00
802	316	https://loremflickr.com/800/600/hotel,resort,room?random=3161	Genoff	1	2026-03-22 00:03:02.780557+00
803	308	https://loremflickr.com/800/600/hotel,resort,room?random=3080	Пилот	0	2026-03-22 00:03:02.780557+00
804	308	https://loremflickr.com/800/600/hotel,resort,room?random=3081	Пилот	1	2026-03-22 00:03:02.780557+00
805	306	https://loremflickr.com/800/600/hotel,resort,room?random=3060	Карамболь	0	2026-03-22 00:03:02.780557+00
806	306	https://loremflickr.com/800/600/hotel,resort,room?random=3061	Карамболь	1	2026-03-22 00:03:02.780557+00
807	304	https://loremflickr.com/800/600/hotel,resort,room?random=3040	Динамо	0	2026-03-22 00:03:02.780557+00
808	304	https://loremflickr.com/800/600/hotel,resort,room?random=3041	Динамо	1	2026-03-22 00:03:02.780557+00
809	303	https://loremflickr.com/800/600/hotel,resort,room?random=3030	Кавказ	0	2026-03-22 00:03:02.780557+00
810	303	https://loremflickr.com/800/600/hotel,resort,room?random=3031	Кавказ	1	2026-03-22 00:03:02.780557+00
811	302	https://loremflickr.com/800/600/hotel,resort,room?random=3020	Южный	0	2026-03-22 00:03:02.780557+00
812	302	https://loremflickr.com/800/600/hotel,resort,room?random=3021	Южный	1	2026-03-22 00:03:02.780557+00
813	273	https://loremflickr.com/800/600/museum,art,gallery?random=2730	Краснодарский государственный историко-археологический музей-заповедник им. Е.Д. Фелицина	0	2026-03-22 00:03:02.780557+00
814	273	https://loremflickr.com/800/600/museum,art,gallery?random=2731	Краснодарский государственный историко-археологический музей-заповедник им. Е.Д. Фелицина	1	2026-03-22 00:03:02.780557+00
815	269	https://loremflickr.com/800/600/gas+station,fuel?random=2690	Лукойл	0	2026-03-22 00:03:02.780557+00
816	269	https://loremflickr.com/800/600/gas+station,fuel?random=2691	Лукойл	1	2026-03-22 00:03:02.780557+00
817	263	https://loremflickr.com/800/600/gas+station,fuel?random=2630	Rusoil	0	2026-03-22 00:03:02.780557+00
818	263	https://loremflickr.com/800/600/gas+station,fuel?random=2631	Rusoil	1	2026-03-22 00:03:02.780557+00
819	147	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1470	Кафе	0	2026-03-22 00:03:02.780557+00
820	147	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1471	Кафе	1	2026-03-22 00:03:02.780557+00
821	52	https://loremflickr.com/800/600/restaurant,food,dining?random=520	Амара	0	2026-03-22 00:03:02.780557+00
822	52	https://loremflickr.com/800/600/restaurant,food,dining?random=521	Амара	1	2026-03-22 00:03:02.780557+00
823	50	https://loremflickr.com/800/600/restaurant,food,dining?random=500	Бомонд	0	2026-03-22 00:03:02.780557+00
824	50	https://loremflickr.com/800/600/restaurant,food,dining?random=501	Бомонд	1	2026-03-22 00:03:02.780557+00
825	42	https://loremflickr.com/800/600/restaurant,food,dining?random=420	Чайка	0	2026-03-22 00:03:02.780557+00
826	42	https://loremflickr.com/800/600/restaurant,food,dining?random=421	Чайка	1	2026-03-22 00:03:02.780557+00
827	201	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2010	Грязевой вулкан Гнилая гора	0	2026-03-22 00:03:02.780557+00
828	201	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2011	Грязевой вулкан Гнилая гора	1	2026-03-22 00:03:02.780557+00
829	91	https://loremflickr.com/800/600/restaurant,food,dining?random=910	У Бочки	0	2026-03-22 00:03:02.780557+00
830	91	https://loremflickr.com/800/600/restaurant,food,dining?random=911	У Бочки	1	2026-03-22 00:03:02.780557+00
831	89	https://loremflickr.com/800/600/restaurant,food,dining?random=890	Меридиан	0	2026-03-22 00:03:02.780557+00
832	89	https://loremflickr.com/800/600/restaurant,food,dining?random=891	Меридиан	1	2026-03-22 00:03:02.780557+00
833	88	https://loremflickr.com/800/600/restaurant,food,dining?random=880	Литораль	0	2026-03-22 00:03:02.780557+00
834	88	https://loremflickr.com/800/600/restaurant,food,dining?random=881	Литораль	1	2026-03-22 00:03:02.780557+00
835	491	https://loremflickr.com/800/600/winery,vineyard,wine?random=4910	Абрау-Дюрсо	0	2026-03-22 00:03:02.780557+00
836	491	https://loremflickr.com/800/600/winery,vineyard,wine?random=4911	Абрау-Дюрсо	1	2026-03-22 00:03:02.780557+00
837	490	https://loremflickr.com/800/600/winery,vineyard,wine?random=4900	Шумринка	0	2026-03-22 00:03:02.780557+00
838	490	https://loremflickr.com/800/600/winery,vineyard,wine?random=4901	Шумринка	1	2026-03-22 00:03:02.780557+00
839	489	https://loremflickr.com/800/600/winery,vineyard,wine?random=4890	Fanagoria	0	2026-03-22 00:03:02.780557+00
840	489	https://loremflickr.com/800/600/winery,vineyard,wine?random=4891	Fanagoria	1	2026-03-22 00:03:02.780557+00
841	324	https://loremflickr.com/800/600/hotel,resort,room?random=3240	Отель "Плаза"	0	2026-03-22 00:03:02.780557+00
842	324	https://loremflickr.com/800/600/hotel,resort,room?random=3241	Отель "Плаза"	1	2026-03-22 00:03:02.780557+00
843	183	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1830	Палуба Ресторан	0	2026-03-22 00:03:02.780557+00
844	183	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1831	Палуба Ресторан	1	2026-03-22 00:03:02.780557+00
845	182	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1820	Бали	0	2026-03-22 00:03:02.780557+00
846	182	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1821	Бали	1	2026-03-22 00:03:02.780557+00
847	172	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1720	Неро	0	2026-03-22 00:03:02.780557+00
848	172	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1721	Неро	1	2026-03-22 00:03:02.780557+00
849	171	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1710	Шанталь	0	2026-03-22 00:03:02.780557+00
850	171	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1711	Шанталь	1	2026-03-22 00:03:02.780557+00
851	165	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1650	Seafood market	0	2026-03-22 00:03:02.780557+00
852	165	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1651	Seafood market	1	2026-03-22 00:03:02.780557+00
853	164	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1640	Эдем	0	2026-03-22 00:03:02.780557+00
854	164	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1641	Эдем	1	2026-03-22 00:03:02.780557+00
855	163	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1630	Бабаева	0	2026-03-22 00:03:02.780557+00
856	163	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1631	Бабаева	1	2026-03-22 00:03:02.780557+00
857	162	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1620	Калифорния	0	2026-03-22 00:03:02.780557+00
858	162	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1621	Калифорния	1	2026-03-22 00:03:02.780557+00
859	161	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1610	Чёрный жемчуг	0	2026-03-22 00:03:02.780557+00
860	161	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1611	Чёрный жемчуг	1	2026-03-22 00:03:02.780557+00
861	160	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1600	Белые ночи	0	2026-03-22 00:03:02.780557+00
862	160	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1601	Белые ночи	1	2026-03-22 00:03:02.780557+00
863	159	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1590	Восток	0	2026-03-22 00:03:02.780557+00
864	159	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1591	Восток	1	2026-03-22 00:03:02.780557+00
865	154	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1540	Маяк	0	2026-03-22 00:03:02.780557+00
866	154	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1541	Маяк	1	2026-03-22 00:03:02.780557+00
867	151	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1510	Столовая на Роз	0	2026-03-22 00:03:02.780557+00
868	151	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1511	Столовая на Роз	1	2026-03-22 00:03:02.780557+00
869	150	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1500	Банкир	0	2026-03-22 00:03:02.780557+00
870	150	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1501	Банкир	1	2026-03-22 00:03:02.780557+00
871	144	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1440	Coffee	0	2026-03-22 00:03:02.780557+00
872	144	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1441	Coffee	1	2026-03-22 00:03:02.780557+00
873	132	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1320	Сенатор	0	2026-03-22 00:03:02.780557+00
874	132	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1321	Сенатор	1	2026-03-22 00:03:02.780557+00
875	85	https://loremflickr.com/800/600/restaurant,food,dining?random=850	Кофемания	0	2026-03-22 00:03:02.780557+00
876	85	https://loremflickr.com/800/600/restaurant,food,dining?random=851	Кофемания	1	2026-03-22 00:03:02.780557+00
877	84	https://loremflickr.com/800/600/restaurant,food,dining?random=840	Причал №1	0	2026-03-22 00:03:02.780557+00
878	84	https://loremflickr.com/800/600/restaurant,food,dining?random=841	Причал №1	1	2026-03-22 00:03:02.780557+00
879	82	https://loremflickr.com/800/600/restaurant,food,dining?random=820	La Vash	0	2026-03-22 00:03:02.780557+00
880	82	https://loremflickr.com/800/600/restaurant,food,dining?random=821	La Vash	1	2026-03-22 00:03:02.780557+00
881	64	https://loremflickr.com/800/600/restaurant,food,dining?random=640	Золотой Якорь	0	2026-03-22 00:03:02.780557+00
882	64	https://loremflickr.com/800/600/restaurant,food,dining?random=641	Золотой Якорь	1	2026-03-22 00:03:02.780557+00
883	63	https://loremflickr.com/800/600/restaurant,food,dining?random=630	Чешское пиво	0	2026-03-22 00:03:02.780557+00
884	63	https://loremflickr.com/800/600/restaurant,food,dining?random=631	Чешское пиво	1	2026-03-22 00:03:02.780557+00
885	45	https://loremflickr.com/800/600/restaurant,food,dining?random=450	Восток	0	2026-03-22 00:03:02.780557+00
886	45	https://loremflickr.com/800/600/restaurant,food,dining?random=451	Восток	1	2026-03-22 00:03:02.780557+00
887	40	https://loremflickr.com/800/600/restaurant,food,dining?random=400	Чайхона №1	0	2026-03-22 00:03:02.780557+00
888	40	https://loremflickr.com/800/600/restaurant,food,dining?random=401	Чайхона №1	1	2026-03-22 00:03:02.780557+00
889	39	https://loremflickr.com/800/600/restaurant,food,dining?random=390	Малый Ахун	0	2026-03-22 00:03:02.780557+00
890	39	https://loremflickr.com/800/600/restaurant,food,dining?random=391	Малый Ахун	1	2026-03-22 00:03:02.780557+00
891	38	https://loremflickr.com/800/600/restaurant,food,dining?random=380	Дом 1934 г	0	2026-03-22 00:03:02.780557+00
892	38	https://loremflickr.com/800/600/restaurant,food,dining?random=381	Дом 1934 г	1	2026-03-22 00:03:02.780557+00
893	35	https://loremflickr.com/800/600/restaurant,food,dining?random=350	London	0	2026-03-22 00:03:02.780557+00
894	35	https://loremflickr.com/800/600/restaurant,food,dining?random=351	London	1	2026-03-22 00:03:02.780557+00
895	34	https://loremflickr.com/800/600/restaurant,food,dining?random=340	Япона Мама	0	2026-03-22 00:03:02.780557+00
896	34	https://loremflickr.com/800/600/restaurant,food,dining?random=341	Япона Мама	1	2026-03-22 00:03:02.780557+00
897	33	https://loremflickr.com/800/600/restaurant,food,dining?random=330	Прайд	0	2026-03-22 00:03:02.780557+00
898	33	https://loremflickr.com/800/600/restaurant,food,dining?random=331	Прайд	1	2026-03-22 00:03:02.780557+00
899	30	https://loremflickr.com/800/600/restaurant,food,dining?random=300	Фидан	0	2026-03-22 00:03:02.780557+00
900	30	https://loremflickr.com/800/600/restaurant,food,dining?random=301	Фидан	1	2026-03-22 00:03:02.780557+00
901	29	https://loremflickr.com/800/600/restaurant,food,dining?random=290	Индус	0	2026-03-22 00:03:02.780557+00
902	29	https://loremflickr.com/800/600/restaurant,food,dining?random=291	Индус	1	2026-03-22 00:03:02.780557+00
903	28	https://loremflickr.com/800/600/restaurant,food,dining?random=280	Cinema	0	2026-03-22 00:03:02.780557+00
904	28	https://loremflickr.com/800/600/restaurant,food,dining?random=281	Cinema	1	2026-03-22 00:03:02.780557+00
905	27	https://loremflickr.com/800/600/restaurant,food,dining?random=270	Аурум	0	2026-03-22 00:03:02.780557+00
906	27	https://loremflickr.com/800/600/restaurant,food,dining?random=271	Аурум	1	2026-03-22 00:03:02.780557+00
907	24	https://loremflickr.com/800/600/restaurant,food,dining?random=240	Nippon House	0	2026-03-22 00:03:02.780557+00
908	24	https://loremflickr.com/800/600/restaurant,food,dining?random=241	Nippon House	1	2026-03-22 00:03:02.780557+00
909	23	https://loremflickr.com/800/600/restaurant,food,dining?random=230	Пальма	0	2026-03-22 00:03:02.780557+00
910	23	https://loremflickr.com/800/600/restaurant,food,dining?random=231	Пальма	1	2026-03-22 00:03:02.780557+00
911	20	https://loremflickr.com/800/600/restaurant,food,dining?random=200	Катюша	0	2026-03-22 00:03:02.780557+00
912	20	https://loremflickr.com/800/600/restaurant,food,dining?random=201	Катюша	1	2026-03-22 00:03:02.780557+00
913	19	https://loremflickr.com/800/600/restaurant,food,dining?random=190	Восточный квартал	0	2026-03-22 00:03:02.780557+00
914	19	https://loremflickr.com/800/600/restaurant,food,dining?random=191	Восточный квартал	1	2026-03-22 00:03:02.780557+00
915	18	https://loremflickr.com/800/600/restaurant,food,dining?random=180	Федина дача	0	2026-03-22 00:03:02.780557+00
916	18	https://loremflickr.com/800/600/restaurant,food,dining?random=181	Федина дача	1	2026-03-22 00:03:02.780557+00
917	17	https://loremflickr.com/800/600/restaurant,food,dining?random=170	Оливье	0	2026-03-22 00:03:02.780557+00
918	17	https://loremflickr.com/800/600/restaurant,food,dining?random=171	Оливье	1	2026-03-22 00:03:02.780557+00
919	16	https://loremflickr.com/800/600/restaurant,food,dining?random=160	Старый Базар	0	2026-03-22 00:03:02.780557+00
920	16	https://loremflickr.com/800/600/restaurant,food,dining?random=161	Старый Базар	1	2026-03-22 00:03:02.780557+00
921	15	https://loremflickr.com/800/600/restaurant,food,dining?random=150	Променад	0	2026-03-22 00:03:02.780557+00
922	15	https://loremflickr.com/800/600/restaurant,food,dining?random=151	Променад	1	2026-03-22 00:03:02.780557+00
923	436	https://loremflickr.com/800/600/beach,sea,coast?random=4360	Жемчужина	0	2026-03-22 00:03:02.780557+00
924	436	https://loremflickr.com/800/600/beach,sea,coast?random=4361	Жемчужина	1	2026-03-22 00:03:02.780557+00
925	435	https://loremflickr.com/800/600/beach,sea,coast?random=4350	Пляж санатория "Русь"	0	2026-03-22 00:03:02.780557+00
926	435	https://loremflickr.com/800/600/beach,sea,coast?random=4351	Пляж санатория "Русь"	1	2026-03-22 00:03:02.780557+00
927	321	https://loremflickr.com/800/600/hotel,resort,room?random=3210	City Park Hotel	0	2026-03-22 00:03:02.780557+00
928	321	https://loremflickr.com/800/600/hotel,resort,room?random=3211	City Park Hotel	1	2026-03-22 00:03:02.780557+00
929	320	https://loremflickr.com/800/600/hotel,resort,room?random=3200	MIRROR	0	2026-03-22 00:03:02.780557+00
930	320	https://loremflickr.com/800/600/hotel,resort,room?random=3201	MIRROR	1	2026-03-22 00:03:02.780557+00
931	297	https://loremflickr.com/800/600/museum,art,gallery?random=2970	A.A.C. Art Gallery of Wood Plastic	0	2026-03-22 00:03:02.780557+00
932	297	https://loremflickr.com/800/600/museum,art,gallery?random=2971	A.A.C. Art Gallery of Wood Plastic	1	2026-03-22 00:03:02.780557+00
933	275	https://loremflickr.com/800/600/museum,art,gallery?random=2750	Музей истории Сочи	0	2026-03-22 00:03:02.780557+00
934	275	https://loremflickr.com/800/600/museum,art,gallery?random=2751	Музей истории Сочи	1	2026-03-22 00:03:02.780557+00
935	125	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1250	Кубань	0	2026-03-22 00:03:02.780557+00
936	125	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1251	Кубань	1	2026-03-22 00:03:02.780557+00
937	124	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1240	Эдем	0	2026-03-22 00:03:02.780557+00
938	124	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1241	Эдем	1	2026-03-22 00:03:02.780557+00
939	123	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1230	Saloon Western	0	2026-03-22 00:03:02.780557+00
940	123	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1231	Saloon Western	1	2026-03-22 00:03:02.780557+00
941	92	https://loremflickr.com/800/600/restaurant,food,dining?random=920	Виола	0	2026-03-22 00:03:02.780557+00
942	92	https://loremflickr.com/800/600/restaurant,food,dining?random=921	Виола	1	2026-03-22 00:03:02.780557+00
943	77	https://loremflickr.com/800/600/restaurant,food,dining?random=770	Трофей	0	2026-03-22 00:03:02.780557+00
944	77	https://loremflickr.com/800/600/restaurant,food,dining?random=771	Трофей	1	2026-03-22 00:03:02.780557+00
945	76	https://loremflickr.com/800/600/restaurant,food,dining?random=760	Мария	0	2026-03-22 00:03:02.780557+00
946	76	https://loremflickr.com/800/600/restaurant,food,dining?random=761	Мария	1	2026-03-22 00:03:02.780557+00
947	75	https://loremflickr.com/800/600/restaurant,food,dining?random=750	Music Hall	0	2026-03-22 00:03:02.780557+00
948	75	https://loremflickr.com/800/600/restaurant,food,dining?random=751	Music Hall	1	2026-03-22 00:03:02.780557+00
949	62	https://loremflickr.com/800/600/restaurant,food,dining?random=620	Магнолия	0	2026-03-22 00:03:02.780557+00
950	62	https://loremflickr.com/800/600/restaurant,food,dining?random=621	Магнолия	1	2026-03-22 00:03:02.780557+00
951	54	https://loremflickr.com/800/600/restaurant,food,dining?random=540	Хижина рыбака	0	2026-03-22 00:03:02.780557+00
952	54	https://loremflickr.com/800/600/restaurant,food,dining?random=541	Хижина рыбака	1	2026-03-22 00:03:02.780557+00
953	443	https://loremflickr.com/800/600/beach,sea,coast?random=4430	Нудистский  пляж	0	2026-03-22 00:03:02.780557+00
954	443	https://loremflickr.com/800/600/beach,sea,coast?random=4431	Нудистский  пляж	1	2026-03-22 00:03:02.780557+00
955	437	https://loremflickr.com/800/600/beach,sea,coast?random=4370	Пляж ДОЛ "Североморец"	0	2026-03-22 00:03:02.780557+00
956	437	https://loremflickr.com/800/600/beach,sea,coast?random=4371	Пляж ДОЛ "Североморец"	1	2026-03-22 00:03:02.780557+00
957	424	https://loremflickr.com/800/600/beach,sea,coast?random=4240	Нудистский пляж	0	2026-03-22 00:03:02.780557+00
958	424	https://loremflickr.com/800/600/beach,sea,coast?random=4241	Нудистский пляж	1	2026-03-22 00:03:02.780557+00
959	348	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3480	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
960	348	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3481	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
961	347	https://loremflickr.com/800/600/hotel,resort,room?random=3470	б.о. Юнармеец	0	2026-03-22 00:03:02.780557+00
962	347	https://loremflickr.com/800/600/hotel,resort,room?random=3471	б.о. Юнармеец	1	2026-03-22 00:03:02.780557+00
963	346	https://loremflickr.com/800/600/hotel,resort,room?random=3460	Чайка	0	2026-03-22 00:03:02.780557+00
964	346	https://loremflickr.com/800/600/hotel,resort,room?random=3461	Чайка	1	2026-03-22 00:03:02.780557+00
965	345	https://loremflickr.com/800/600/hotel,resort,room?random=3450	б.о. Радуга	0	2026-03-22 00:03:02.780557+00
966	345	https://loremflickr.com/800/600/hotel,resort,room?random=3451	б.о. Радуга	1	2026-03-22 00:03:02.780557+00
967	344	https://loremflickr.com/800/600/hotel,resort,room?random=3440	База отдыха "Северянка"	0	2026-03-22 00:03:02.780557+00
968	344	https://loremflickr.com/800/600/hotel,resort,room?random=3441	База отдыха "Северянка"	1	2026-03-22 00:03:02.780557+00
969	342	https://loremflickr.com/800/600/hotel,resort,room?random=3420	Санаторий "Голубая волна"	0	2026-03-22 00:03:02.780557+00
970	342	https://loremflickr.com/800/600/hotel,resort,room?random=3421	Санаторий "Голубая волна"	1	2026-03-22 00:03:02.780557+00
971	341	https://loremflickr.com/800/600/hotel,resort,room?random=3410	б.о. Вагончик	0	2026-03-22 00:03:02.780557+00
972	341	https://loremflickr.com/800/600/hotel,resort,room?random=3411	б.о. Вагончик	1	2026-03-22 00:03:02.780557+00
973	340	https://loremflickr.com/800/600/hotel,resort,room?random=3400	Пансионат "Строитель"	0	2026-03-22 00:03:02.780557+00
974	340	https://loremflickr.com/800/600/hotel,resort,room?random=3401	Пансионат "Строитель"	1	2026-03-22 00:03:02.780557+00
975	339	https://loremflickr.com/800/600/hotel,resort,room?random=3390	База отдыха "Ромашка"	0	2026-03-22 00:03:02.780557+00
976	339	https://loremflickr.com/800/600/hotel,resort,room?random=3391	База отдыха "Ромашка"	1	2026-03-22 00:03:02.780557+00
977	338	https://loremflickr.com/800/600/hotel,resort,room?random=3380	Пансионат "Приветливый берег"	0	2026-03-22 00:03:02.780557+00
978	338	https://loremflickr.com/800/600/hotel,resort,room?random=3381	Пансионат "Приветливый берег"	1	2026-03-22 00:03:02.780557+00
979	337	https://loremflickr.com/800/600/hotel,resort,room?random=3370	Александрия	0	2026-03-22 00:03:02.780557+00
980	337	https://loremflickr.com/800/600/hotel,resort,room?random=3371	Александрия	1	2026-03-22 00:03:02.780557+00
981	336	https://loremflickr.com/800/600/hotel,resort,room?random=3360	т\\б Дивна	0	2026-03-22 00:03:02.780557+00
982	336	https://loremflickr.com/800/600/hotel,resort,room?random=3361	т\\б Дивна	1	2026-03-22 00:03:02.780557+00
983	335	https://loremflickr.com/800/600/hotel,resort,room?random=3350	База отдыха "Светлячок"	0	2026-03-22 00:03:02.780557+00
984	335	https://loremflickr.com/800/600/hotel,resort,room?random=3351	База отдыха "Светлячок"	1	2026-03-22 00:03:02.780557+00
985	334	https://loremflickr.com/800/600/hotel,resort,room?random=3340	д.о. Баргузин	0	2026-03-22 00:03:02.780557+00
986	334	https://loremflickr.com/800/600/hotel,resort,room?random=3341	д.о. Баргузин	1	2026-03-22 00:03:02.780557+00
987	333	https://loremflickr.com/800/600/hotel,resort,room?random=3330	База отдыха «Ростсельмаш»	0	2026-03-22 00:03:02.780557+00
988	333	https://loremflickr.com/800/600/hotel,resort,room?random=3331	База отдыха «Ростсельмаш»	1	2026-03-22 00:03:02.780557+00
989	332	https://loremflickr.com/800/600/hotel,resort,room?random=3320	База отдыха "Здоровье"	0	2026-03-22 00:03:02.780557+00
990	332	https://loremflickr.com/800/600/hotel,resort,room?random=3321	База отдыха "Здоровье"	1	2026-03-22 00:03:02.780557+00
991	331	https://loremflickr.com/800/600/hotel,resort,room?random=3310	База отдыха "Авиатор"	0	2026-03-22 00:03:02.780557+00
992	331	https://loremflickr.com/800/600/hotel,resort,room?random=3311	База отдыха "Авиатор"	1	2026-03-22 00:03:02.780557+00
993	330	https://loremflickr.com/800/600/hotel,resort,room?random=3300	Пансионат "Лазурный берег"	0	2026-03-22 00:03:02.780557+00
994	330	https://loremflickr.com/800/600/hotel,resort,room?random=3301	Пансионат "Лазурный берег"	1	2026-03-22 00:03:02.780557+00
995	329	https://loremflickr.com/800/600/hotel,resort,room?random=3290	Дом отдыха «Звёздочка»	0	2026-03-22 00:03:02.780557+00
996	329	https://loremflickr.com/800/600/hotel,resort,room?random=3291	Дом отдыха «Звёздочка»	1	2026-03-22 00:03:02.780557+00
997	328	https://loremflickr.com/800/600/hotel,resort,room?random=3280	Пансионат "Северянка"	0	2026-03-22 00:03:02.780557+00
998	328	https://loremflickr.com/800/600/hotel,resort,room?random=3281	Пансионат "Северянка"	1	2026-03-22 00:03:02.780557+00
999	311	https://loremflickr.com/800/600/hotel,resort,room?random=3110	Music Hall	0	2026-03-22 00:03:02.780557+00
1000	311	https://loremflickr.com/800/600/hotel,resort,room?random=3111	Music Hall	1	2026-03-22 00:03:02.780557+00
1001	310	https://loremflickr.com/800/600/hotel,resort,room?random=3100	Кино	0	2026-03-22 00:03:02.780557+00
1002	310	https://loremflickr.com/800/600/hotel,resort,room?random=3101	Кино	1	2026-03-22 00:03:02.780557+00
1003	309	https://loremflickr.com/800/600/hotel,resort,room?random=3090	Самара	0	2026-03-22 00:03:02.780557+00
1004	309	https://loremflickr.com/800/600/hotel,resort,room?random=3091	Самара	1	2026-03-22 00:03:02.780557+00
1005	293	https://loremflickr.com/800/600/museum,art,gallery?random=2930	Музей мусора «Белая лошадь»	0	2026-03-22 00:03:02.780557+00
1006	293	https://loremflickr.com/800/600/museum,art,gallery?random=2931	Музей мусора «Белая лошадь»	1	2026-03-22 00:03:02.780557+00
1007	286	https://loremflickr.com/800/600/museum,art,gallery?random=2860	Морской музей	0	2026-03-22 00:03:02.780557+00
1008	286	https://loremflickr.com/800/600/museum,art,gallery?random=2861	Морской музей	1	2026-03-22 00:03:02.780557+00
1009	284	https://loremflickr.com/800/600/museum,art,gallery?random=2840	Краеведческий музей	0	2026-03-22 00:03:02.780557+00
1010	284	https://loremflickr.com/800/600/museum,art,gallery?random=2841	Краеведческий музей	1	2026-03-22 00:03:02.780557+00
1011	281	https://loremflickr.com/800/600/museum,art,gallery?random=2810	Дом-музей В. Г. Короленко	0	2026-03-22 00:03:02.780557+00
1012	281	https://loremflickr.com/800/600/museum,art,gallery?random=2811	Дом-музей В. Г. Короленко	1	2026-03-22 00:03:02.780557+00
1013	229	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2290	Дольмен Лунный	0	2026-03-22 00:03:02.780557+00
1014	229	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2291	Дольмен Лунный	1	2026-03-22 00:03:02.780557+00
1015	197	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1970	Грязевой вулкан	0	2026-03-22 00:03:02.780557+00
1016	197	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1971	Грязевой вулкан	1	2026-03-22 00:03:02.780557+00
1017	188	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1880	Погибшим на пароходе "Адмирал Нахимов"	0	2026-03-22 00:03:02.780557+00
1018	188	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1881	Погибшим на пароходе "Адмирал Нахимов"	1	2026-03-22 00:03:02.780557+00
1019	487	https://loremflickr.com/800/600/winery,vineyard,wine?random=4870	Усадьба Маркотх	0	2026-03-22 00:03:02.780557+00
1020	487	https://loremflickr.com/800/600/winery,vineyard,wine?random=4871	Усадьба Маркотх	1	2026-03-22 00:03:02.780557+00
1021	295	https://loremflickr.com/800/600/museum,art,gallery?random=2950	Выставка изделий из стекла	0	2026-03-22 00:03:02.780557+00
1022	295	https://loremflickr.com/800/600/museum,art,gallery?random=2951	Выставка изделий из стекла	1	2026-03-22 00:03:02.780557+00
1023	218	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2180	скала Петушок	0	2026-03-22 00:03:02.780557+00
1024	218	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2181	скала Петушок	1	2026-03-22 00:03:02.780557+00
1025	217	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2170	Дантово ущелье	0	2026-03-22 00:03:02.780557+00
1026	217	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2171	Дантово ущелье	1	2026-03-22 00:03:02.780557+00
1027	215	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2150	Столб Мира	0	2026-03-22 00:03:02.780557+00
1028	215	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2151	Столб Мира	1	2026-03-22 00:03:02.780557+00
1029	205	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2050	Желтые монастыри	0	2026-03-22 00:03:02.780557+00
1030	205	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2051	Желтые монастыри	1	2026-03-22 00:03:02.780557+00
1031	170	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1700	Золотое руно	0	2026-03-22 00:03:02.780557+00
1032	170	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1701	Золотое руно	1	2026-03-22 00:03:02.780557+00
1033	169	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1690	Синьор Помидор	0	2026-03-22 00:03:02.780557+00
1034	169	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1691	Синьор Помидор	1	2026-03-22 00:03:02.780557+00
1035	168	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1680	«Привал»	0	2026-03-22 00:03:02.780557+00
1036	168	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1681	«Привал»	1	2026-03-22 00:03:02.780557+00
1037	167	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1670	Вкусноежка	0	2026-03-22 00:03:02.780557+00
1038	167	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1671	Вкусноежка	1	2026-03-22 00:03:02.780557+00
1039	166	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1660	Молодежное	0	2026-03-22 00:03:02.780557+00
1040	166	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1661	Молодежное	1	2026-03-22 00:03:02.780557+00
1041	148	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1480	Кафе	0	2026-03-22 00:03:02.780557+00
1042	148	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1481	Кафе	1	2026-03-22 00:03:02.780557+00
1043	21	https://loremflickr.com/800/600/restaurant,food,dining?random=210	«Ё-Моё»	0	2026-03-22 00:03:02.780557+00
1044	21	https://loremflickr.com/800/600/restaurant,food,dining?random=211	«Ё-Моё»	1	2026-03-22 00:03:02.780557+00
1045	518	https://loremflickr.com/800/600/camping,glamping,tent?random=5180	Кемпинг	0	2026-03-22 00:03:02.780557+00
1046	518	https://loremflickr.com/800/600/camping,glamping,tent?random=5181	Кемпинг	1	2026-03-22 00:03:02.780557+00
1047	506	https://loremflickr.com/800/600/camping,glamping,tent?random=5060	Каштановая Роща	0	2026-03-22 00:03:02.780557+00
1048	506	https://loremflickr.com/800/600/camping,glamping,tent?random=5061	Каштановая Роща	1	2026-03-22 00:03:02.780557+00
1049	394	https://loremflickr.com/800/600/picnic,park,nature?random=3940	Место для пикника	0	2026-03-22 00:03:02.780557+00
1050	394	https://loremflickr.com/800/600/picnic,park,nature?random=3941	Место для пикника	1	2026-03-22 00:03:02.780557+00
1051	322	https://loremflickr.com/800/600/hotel,resort,room?random=3220	«Ё-Моё»	0	2026-03-22 00:03:02.780557+00
1052	322	https://loremflickr.com/800/600/hotel,resort,room?random=3221	«Ё-Моё»	1	2026-03-22 00:03:02.780557+00
1053	265	https://loremflickr.com/800/600/gas+station,fuel?random=2650	Газпромнефть	0	2026-03-22 00:03:02.780557+00
1054	265	https://loremflickr.com/800/600/gas+station,fuel?random=2651	Газпромнефть	1	2026-03-22 00:03:02.780557+00
1055	234	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2340	Медвежьи ворота	0	2026-03-22 00:03:02.780557+00
1056	234	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2341	Медвежьи ворота	1	2026-03-22 00:03:02.780557+00
1057	231	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2310	Волчьи Ворота	0	2026-03-22 00:03:02.780557+00
1058	231	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2311	Волчьи Ворота	1	2026-03-22 00:03:02.780557+00
1059	179	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1790	Натали	0	2026-03-22 00:03:02.780557+00
1060	179	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1791	Натали	1	2026-03-22 00:03:02.780557+00
1061	178	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1780	Небеса	0	2026-03-22 00:03:02.780557+00
1062	178	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1781	Небеса	1	2026-03-22 00:03:02.780557+00
1063	95	https://loremflickr.com/800/600/cafe,coffee,bakery?random=950	Пингвин	0	2026-03-22 00:03:02.780557+00
1064	95	https://loremflickr.com/800/600/cafe,coffee,bakery?random=951	Пингвин	1	2026-03-22 00:03:02.780557+00
1065	68	https://loremflickr.com/800/600/restaurant,food,dining?random=680	Пиццерия Пьеtро	0	2026-03-22 00:03:02.780557+00
1066	68	https://loremflickr.com/800/600/restaurant,food,dining?random=681	Пиццерия Пьеtро	1	2026-03-22 00:03:02.780557+00
1067	60	https://loremflickr.com/800/600/restaurant,food,dining?random=600	Кавказ	0	2026-03-22 00:03:02.780557+00
1068	60	https://loremflickr.com/800/600/restaurant,food,dining?random=601	Кавказ	1	2026-03-22 00:03:02.780557+00
1069	58	https://loremflickr.com/800/600/restaurant,food,dining?random=580	Прибой	0	2026-03-22 00:03:02.780557+00
1070	58	https://loremflickr.com/800/600/restaurant,food,dining?random=581	Прибой	1	2026-03-22 00:03:02.780557+00
1071	57	https://loremflickr.com/800/600/restaurant,food,dining?random=570	Русское застолье	0	2026-03-22 00:03:02.780557+00
1072	57	https://loremflickr.com/800/600/restaurant,food,dining?random=571	Русское застолье	1	2026-03-22 00:03:02.780557+00
1073	37	https://loremflickr.com/800/600/restaurant,food,dining?random=370	Шереметьево-4 (самолет)	0	2026-03-22 00:03:02.780557+00
1074	37	https://loremflickr.com/800/600/restaurant,food,dining?random=371	Шереметьево-4 (самолет)	1	2026-03-22 00:03:02.780557+00
1075	26	https://loremflickr.com/800/600/restaurant,food,dining?random=260	Прохлада	0	2026-03-22 00:03:02.780557+00
1076	26	https://loremflickr.com/800/600/restaurant,food,dining?random=261	Прохлада	1	2026-03-22 00:03:02.780557+00
1077	1	https://loremflickr.com/800/600/restaurant,food,dining?random=10	Кавказская кухня "Хаш"	0	2026-03-22 00:03:02.780557+00
1078	1	https://loremflickr.com/800/600/restaurant,food,dining?random=11	Кавказская кухня "Хаш"	1	2026-03-22 00:03:02.780557+00
1079	471	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4710	Водопад	0	2026-03-22 00:03:02.780557+00
1080	471	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4711	Водопад	1	2026-03-22 00:03:02.780557+00
1081	461	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4610	Вид на водопад на ручье (дальше дороги нет)	0	2026-03-22 00:03:02.780557+00
1082	461	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4611	Вид на водопад на ручье (дальше дороги нет)	1	2026-03-22 00:03:02.780557+00
1083	455	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4550	Водопад	0	2026-03-22 00:03:02.780557+00
1084	455	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4551	Водопад	1	2026-03-22 00:03:02.780557+00
1085	454	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4540	Водопад	0	2026-03-22 00:03:02.780557+00
1086	454	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4541	Водопад	1	2026-03-22 00:03:02.780557+00
1087	447	https://loremflickr.com/800/600/beach,sea,coast?random=4470	мыс Эльмира	0	2026-03-22 00:03:02.780557+00
1088	447	https://loremflickr.com/800/600/beach,sea,coast?random=4471	мыс Эльмира	1	2026-03-22 00:03:02.780557+00
1089	416	https://loremflickr.com/800/600/picnic,park,nature?random=4160	Место для пикника	0	2026-03-22 00:03:02.780557+00
1090	416	https://loremflickr.com/800/600/picnic,park,nature?random=4161	Место для пикника	1	2026-03-22 00:03:02.780557+00
1091	301	https://loremflickr.com/800/600/hotel,resort,room?random=3010	Гизель-Дере	0	2026-03-22 00:03:02.780557+00
1092	301	https://loremflickr.com/800/600/hotel,resort,room?random=3011	Гизель-Дере	1	2026-03-22 00:03:02.780557+00
1093	300	https://loremflickr.com/800/600/hotel,resort,room?random=3000	Гизель-Дере	0	2026-03-22 00:03:02.780557+00
1094	300	https://loremflickr.com/800/600/hotel,resort,room?random=3001	Гизель-Дере	1	2026-03-22 00:03:02.780557+00
1095	232	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2320	Скала "Тренировочная"	0	2026-03-22 00:03:02.780557+00
1096	232	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2321	Скала "Тренировочная"	1	2026-03-22 00:03:02.780557+00
1097	127	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1270	барракуда	0	2026-03-22 00:03:02.780557+00
1098	127	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1271	барракуда	1	2026-03-22 00:03:02.780557+00
1099	120	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1200	Корсар	0	2026-03-22 00:03:02.780557+00
1100	120	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1201	Корсар	1	2026-03-22 00:03:02.780557+00
1101	492	https://loremflickr.com/800/600/winery,vineyard,wine?random=4920	Шато Дюрсо	0	2026-03-22 00:03:02.780557+00
1102	492	https://loremflickr.com/800/600/winery,vineyard,wine?random=4921	Шато Дюрсо	1	2026-03-22 00:03:02.780557+00
1103	486	https://loremflickr.com/800/600/winery,vineyard,wine?random=4860	Мысхако	0	2026-03-22 00:03:02.780557+00
1104	486	https://loremflickr.com/800/600/winery,vineyard,wine?random=4861	Мысхако	1	2026-03-22 00:03:02.780557+00
1105	485	https://loremflickr.com/800/600/winery,vineyard,wine?random=4850	Шато Пино	0	2026-03-22 00:03:02.780557+00
1106	485	https://loremflickr.com/800/600/winery,vineyard,wine?random=4851	Шато Пино	1	2026-03-22 00:03:02.780557+00
1107	427	https://loremflickr.com/800/600/beach,sea,coast?random=4270	Дачный	0	2026-03-22 00:03:02.780557+00
1108	427	https://loremflickr.com/800/600/beach,sea,coast?random=4271	Дачный	1	2026-03-22 00:03:02.780557+00
1109	383	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3830	Кяфар	0	2026-03-22 00:03:02.780557+00
1110	383	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3831	Кяфар	1	2026-03-22 00:03:02.780557+00
1111	359	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3590	Семь ветров	0	2026-03-22 00:03:02.780557+00
1112	359	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3591	Семь ветров	1	2026-03-22 00:03:02.780557+00
1113	358	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3580	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
1114	358	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3581	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
1115	357	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3570	Смотровая на озеро.	0	2026-03-22 00:03:02.780557+00
1116	357	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3571	Смотровая на озеро.	1	2026-03-22 00:03:02.780557+00
1117	305	https://loremflickr.com/800/600/hotel,resort,room?random=3050	Корсар	0	2026-03-22 00:03:02.780557+00
1118	305	https://loremflickr.com/800/600/hotel,resort,room?random=3051	Корсар	1	2026-03-22 00:03:02.780557+00
1119	298	https://loremflickr.com/800/600/museum,art,gallery?random=2980	В гостях у винодела	0	2026-03-22 00:03:02.780557+00
1120	298	https://loremflickr.com/800/600/museum,art,gallery?random=2981	В гостях у винодела	1	2026-03-22 00:03:02.780557+00
1121	156	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1560	У мельника	0	2026-03-22 00:03:02.780557+00
1122	156	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1561	У мельника	1	2026-03-22 00:03:02.780557+00
1123	155	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1550	ВУЛКАН	0	2026-03-22 00:03:02.780557+00
1124	155	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1551	ВУЛКАН	1	2026-03-22 00:03:02.780557+00
1125	93	https://loremflickr.com/800/600/restaurant,food,dining?random=930	"Pesto" "Песто"	0	2026-03-22 00:03:02.780557+00
1126	93	https://loremflickr.com/800/600/restaurant,food,dining?random=931	"Pesto" "Песто"	1	2026-03-22 00:03:02.780557+00
1127	87	https://loremflickr.com/800/600/restaurant,food,dining?random=870	кафе "Молодежное"	0	2026-03-22 00:03:02.780557+00
1128	87	https://loremflickr.com/800/600/restaurant,food,dining?random=871	кафе "Молодежное"	1	2026-03-22 00:03:02.780557+00
1129	83	https://loremflickr.com/800/600/restaurant,food,dining?random=830	Астория	0	2026-03-22 00:03:02.780557+00
1130	83	https://loremflickr.com/800/600/restaurant,food,dining?random=831	Астория	1	2026-03-22 00:03:02.780557+00
1131	9	https://loremflickr.com/800/600/restaurant,food,dining?random=90	Грааль	0	2026-03-22 00:03:02.780557+00
1132	9	https://loremflickr.com/800/600/restaurant,food,dining?random=91	Грааль	1	2026-03-22 00:03:02.780557+00
1133	8	https://loremflickr.com/800/600/restaurant,food,dining?random=80	Версаль	0	2026-03-22 00:03:02.780557+00
1134	8	https://loremflickr.com/800/600/restaurant,food,dining?random=81	Версаль	1	2026-03-22 00:03:02.780557+00
1135	319	https://loremflickr.com/800/600/hotel,resort,room?random=3190	КОМФОРТ	0	2026-03-22 00:03:02.780557+00
1136	319	https://loremflickr.com/800/600/hotel,resort,room?random=3191	КОМФОРТ	1	2026-03-22 00:03:02.780557+00
1137	313	https://loremflickr.com/800/600/hotel,resort,room?random=3130	Северная	0	2026-03-22 00:03:02.780557+00
1138	313	https://loremflickr.com/800/600/hotel,resort,room?random=3131	Северная	1	2026-03-22 00:03:02.780557+00
1139	130	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1300	Кафе Пицца	0	2026-03-22 00:03:02.780557+00
1140	130	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1301	Кафе Пицца	1	2026-03-22 00:03:02.780557+00
1141	32	https://loremflickr.com/800/600/restaurant,food,dining?random=320	Флагман	0	2026-03-22 00:03:02.780557+00
1142	32	https://loremflickr.com/800/600/restaurant,food,dining?random=321	Флагман	1	2026-03-22 00:03:02.780557+00
1143	31	https://loremflickr.com/800/600/restaurant,food,dining?random=310	Алекс	0	2026-03-22 00:03:02.780557+00
1144	31	https://loremflickr.com/800/600/restaurant,food,dining?random=311	Алекс	1	2026-03-22 00:03:02.780557+00
1145	426	https://loremflickr.com/800/600/beach,sea,coast?random=4260	Пляж	0	2026-03-22 00:03:02.780557+00
1146	426	https://loremflickr.com/800/600/beach,sea,coast?random=4261	Пляж	1	2026-03-22 00:03:02.780557+00
1147	314	https://loremflickr.com/800/600/hotel,resort,room?random=3140	Изумруд	0	2026-03-22 00:03:02.780557+00
1148	314	https://loremflickr.com/800/600/hotel,resort,room?random=3141	Изумруд	1	2026-03-22 00:03:02.780557+00
1149	280	https://loremflickr.com/800/600/museum,art,gallery?random=2800	Музей семьи Степановых	0	2026-03-22 00:03:02.780557+00
1150	280	https://loremflickr.com/800/600/museum,art,gallery?random=2801	Музей семьи Степановых	1	2026-03-22 00:03:02.780557+00
1151	81	https://loremflickr.com/800/600/restaurant,food,dining?random=810	Банкет	0	2026-03-22 00:03:02.780557+00
1152	81	https://loremflickr.com/800/600/restaurant,food,dining?random=811	Банкет	1	2026-03-22 00:03:02.780557+00
1153	289	https://loremflickr.com/800/600/museum,art,gallery?random=2890	Историко-краеведческий музей	0	2026-03-22 00:03:02.780557+00
1154	289	https://loremflickr.com/800/600/museum,art,gallery?random=2891	Историко-краеведческий музей	1	2026-03-22 00:03:02.780557+00
1155	79	https://loremflickr.com/800/600/restaurant,food,dining?random=790	Столовая	0	2026-03-22 00:03:02.780557+00
1156	79	https://loremflickr.com/800/600/restaurant,food,dining?random=791	Столовая	1	2026-03-22 00:03:02.780557+00
1157	482	https://loremflickr.com/800/600/winery,vineyard,wine?random=4820	Винодельня Бердяева	0	2026-03-22 00:03:02.780557+00
1158	482	https://loremflickr.com/800/600/winery,vineyard,wine?random=4821	Винодельня Бердяева	1	2026-03-22 00:03:02.780557+00
1159	445	https://loremflickr.com/800/600/beach,sea,coast?random=4450	Пляж	0	2026-03-22 00:03:02.780557+00
1160	445	https://loremflickr.com/800/600/beach,sea,coast?random=4451	Пляж	1	2026-03-22 00:03:02.780557+00
1161	194	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1940	Динозавр	0	2026-03-22 00:03:02.780557+00
1162	194	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1941	Динозавр	1	2026-03-22 00:03:02.780557+00
1163	433	https://loremflickr.com/800/600/beach,sea,coast?random=4330	Чайка	0	2026-03-22 00:03:02.780557+00
1164	433	https://loremflickr.com/800/600/beach,sea,coast?random=4331	Чайка	1	2026-03-22 00:03:02.780557+00
1165	226	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2260	Тенгинские водопады	0	2026-03-22 00:03:02.780557+00
1166	226	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2261	Тенгинские водопады	1	2026-03-22 00:03:02.780557+00
1167	36	https://loremflickr.com/800/600/restaurant,food,dining?random=360	На Краю Земли	0	2026-03-22 00:03:02.780557+00
1168	36	https://loremflickr.com/800/600/restaurant,food,dining?random=361	На Краю Земли	1	2026-03-22 00:03:02.780557+00
1169	405	https://loremflickr.com/800/600/picnic,park,nature?random=4050	Место для пикника	0	2026-03-22 00:03:02.780557+00
1170	405	https://loremflickr.com/800/600/picnic,park,nature?random=4051	Место для пикника	1	2026-03-22 00:03:02.780557+00
1171	404	https://loremflickr.com/800/600/picnic,park,nature?random=4040	Место для пикника	0	2026-03-22 00:03:02.780557+00
1172	404	https://loremflickr.com/800/600/picnic,park,nature?random=4041	Место для пикника	1	2026-03-22 00:03:02.780557+00
1173	403	https://loremflickr.com/800/600/picnic,park,nature?random=4030	Место для пикника	0	2026-03-22 00:03:02.780557+00
1174	403	https://loremflickr.com/800/600/picnic,park,nature?random=4031	Место для пикника	1	2026-03-22 00:03:02.780557+00
1175	402	https://loremflickr.com/800/600/picnic,park,nature?random=4020	Место для пикника	0	2026-03-22 00:03:02.780557+00
1176	402	https://loremflickr.com/800/600/picnic,park,nature?random=4021	Место для пикника	1	2026-03-22 00:03:02.780557+00
1177	401	https://loremflickr.com/800/600/picnic,park,nature?random=4010	Место для пикника	0	2026-03-22 00:03:02.780557+00
1178	401	https://loremflickr.com/800/600/picnic,park,nature?random=4011	Место для пикника	1	2026-03-22 00:03:02.780557+00
1179	400	https://loremflickr.com/800/600/picnic,park,nature?random=4000	Место для пикника	0	2026-03-22 00:03:02.780557+00
1180	400	https://loremflickr.com/800/600/picnic,park,nature?random=4001	Место для пикника	1	2026-03-22 00:03:02.780557+00
1181	399	https://loremflickr.com/800/600/picnic,park,nature?random=3990	Место для пикника	0	2026-03-22 00:03:02.780557+00
1182	399	https://loremflickr.com/800/600/picnic,park,nature?random=3991	Место для пикника	1	2026-03-22 00:03:02.780557+00
1183	398	https://loremflickr.com/800/600/picnic,park,nature?random=3980	Место для пикника	0	2026-03-22 00:03:02.780557+00
1184	398	https://loremflickr.com/800/600/picnic,park,nature?random=3981	Место для пикника	1	2026-03-22 00:03:02.780557+00
1185	397	https://loremflickr.com/800/600/picnic,park,nature?random=3970	Место для пикника	0	2026-03-22 00:03:02.780557+00
1186	397	https://loremflickr.com/800/600/picnic,park,nature?random=3971	Место для пикника	1	2026-03-22 00:03:02.780557+00
1187	396	https://loremflickr.com/800/600/picnic,park,nature?random=3960	Место для пикника	0	2026-03-22 00:03:02.780557+00
1188	396	https://loremflickr.com/800/600/picnic,park,nature?random=3961	Место для пикника	1	2026-03-22 00:03:02.780557+00
1189	395	https://loremflickr.com/800/600/picnic,park,nature?random=3950	Место для пикника	0	2026-03-22 00:03:02.780557+00
1190	395	https://loremflickr.com/800/600/picnic,park,nature?random=3951	Место для пикника	1	2026-03-22 00:03:02.780557+00
1191	296	https://loremflickr.com/800/600/museum,art,gallery?random=2960	Дом музей И. А. Кошмана "Родина Русского Чая"	0	2026-03-22 00:03:02.780557+00
1192	296	https://loremflickr.com/800/600/museum,art,gallery?random=2961	Дом музей И. А. Кошмана "Родина Русского Чая"	1	2026-03-22 00:03:02.780557+00
1193	272	https://loremflickr.com/800/600/gas+station,fuel?random=2720	Роснефть	0	2026-03-22 00:03:02.780557+00
1194	272	https://loremflickr.com/800/600/gas+station,fuel?random=2721	Роснефть	1	2026-03-22 00:03:02.780557+00
1195	439	https://loremflickr.com/800/600/beach,sea,coast?random=4390	Пляж	0	2026-03-22 00:03:02.780557+00
1196	439	https://loremflickr.com/800/600/beach,sea,coast?random=4391	Пляж	1	2026-03-22 00:03:02.780557+00
1197	157	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1570	Родничок	0	2026-03-22 00:03:02.780557+00
1198	157	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1571	Родничок	1	2026-03-22 00:03:02.780557+00
1199	294	https://loremflickr.com/800/600/museum,art,gallery?random=2940	Дом музей А.П. Артюха	0	2026-03-22 00:03:02.780557+00
1200	294	https://loremflickr.com/800/600/museum,art,gallery?random=2941	Дом музей А.П. Артюха	1	2026-03-22 00:03:02.780557+00
1201	438	https://loremflickr.com/800/600/beach,sea,coast?random=4380	Пляж	0	2026-03-22 00:03:02.780557+00
1202	438	https://loremflickr.com/800/600/beach,sea,coast?random=4381	Пляж	1	2026-03-22 00:03:02.780557+00
1203	237	https://loremflickr.com/800/600/gas+station,fuel?random=2370	ТНК	0	2026-03-22 00:03:02.780557+00
1204	237	https://loremflickr.com/800/600/gas+station,fuel?random=2371	ТНК	1	2026-03-22 00:03:02.780557+00
1205	247	https://loremflickr.com/800/600/gas+station,fuel?random=2470	Роснефть	0	2026-03-22 00:03:02.780557+00
1206	247	https://loremflickr.com/800/600/gas+station,fuel?random=2471	Роснефть	1	2026-03-22 00:03:02.780557+00
1207	254	https://loremflickr.com/800/600/gas+station,fuel?random=2540	Газпром	0	2026-03-22 00:03:02.780557+00
1208	254	https://loremflickr.com/800/600/gas+station,fuel?random=2541	Газпром	1	2026-03-22 00:03:02.780557+00
1209	258	https://loremflickr.com/800/600/gas+station,fuel?random=2580	Profoil	0	2026-03-22 00:03:02.780557+00
1210	258	https://loremflickr.com/800/600/gas+station,fuel?random=2581	Profoil	1	2026-03-22 00:03:02.780557+00
1211	235	https://loremflickr.com/800/600/gas+station,fuel?random=2350	Роснефть	0	2026-03-22 00:03:02.780557+00
1212	235	https://loremflickr.com/800/600/gas+station,fuel?random=2351	Роснефть	1	2026-03-22 00:03:02.780557+00
1213	248	https://loremflickr.com/800/600/gas+station,fuel?random=2480	АГЗС	0	2026-03-22 00:03:02.780557+00
1214	248	https://loremflickr.com/800/600/gas+station,fuel?random=2481	АГЗС	1	2026-03-22 00:03:02.780557+00
1215	238	https://loremflickr.com/800/600/gas+station,fuel?random=2380	Кубанский топливный союз	0	2026-03-22 00:03:02.780557+00
1216	238	https://loremflickr.com/800/600/gas+station,fuel?random=2381	Кубанский топливный союз	1	2026-03-22 00:03:02.780557+00
1217	236	https://loremflickr.com/800/600/gas+station,fuel?random=2360	Лукойл	0	2026-03-22 00:03:02.780557+00
1218	236	https://loremflickr.com/800/600/gas+station,fuel?random=2361	Лукойл	1	2026-03-22 00:03:02.780557+00
1219	249	https://loremflickr.com/800/600/gas+station,fuel?random=2490	Лукойл	0	2026-03-22 00:03:02.780557+00
1220	249	https://loremflickr.com/800/600/gas+station,fuel?random=2491	Лукойл	1	2026-03-22 00:03:02.780557+00
1221	251	https://loremflickr.com/800/600/gas+station,fuel?random=2510	Роснефть	0	2026-03-22 00:03:02.780557+00
1222	251	https://loremflickr.com/800/600/gas+station,fuel?random=2511	Роснефть	1	2026-03-22 00:03:02.780557+00
1223	257	https://loremflickr.com/800/600/gas+station,fuel?random=2570	Газпромнефть	0	2026-03-22 00:03:02.780557+00
1224	257	https://loremflickr.com/800/600/gas+station,fuel?random=2571	Газпромнефть	1	2026-03-22 00:03:02.780557+00
1225	256	https://loremflickr.com/800/600/gas+station,fuel?random=2560	Рассвет	0	2026-03-22 00:03:02.780557+00
1226	256	https://loremflickr.com/800/600/gas+station,fuel?random=2561	Рассвет	1	2026-03-22 00:03:02.780557+00
1227	259	https://loremflickr.com/800/600/gas+station,fuel?random=2590	Юг-Нефтьх⁰	0	2026-03-22 00:03:02.780557+00
1228	259	https://loremflickr.com/800/600/gas+station,fuel?random=2591	Юг-Нефтьх⁰	1	2026-03-22 00:03:02.780557+00
1229	255	https://loremflickr.com/800/600/gas+station,fuel?random=2550	Уфимнефть	0	2026-03-22 00:03:02.780557+00
1230	255	https://loremflickr.com/800/600/gas+station,fuel?random=2551	Уфимнефть	1	2026-03-22 00:03:02.780557+00
1231	242	https://loremflickr.com/800/600/gas+station,fuel?random=2420	Лукойл	0	2026-03-22 00:03:02.780557+00
1232	242	https://loremflickr.com/800/600/gas+station,fuel?random=2421	Лукойл	1	2026-03-22 00:03:02.780557+00
1233	241	https://loremflickr.com/800/600/gas+station,fuel?random=2410	Газпромнефть	0	2026-03-22 00:03:02.780557+00
1234	241	https://loremflickr.com/800/600/gas+station,fuel?random=2411	Газпромнефть	1	2026-03-22 00:03:02.780557+00
1235	268	https://loremflickr.com/800/600/gas+station,fuel?random=2680	Лукойл	0	2026-03-22 00:03:02.780557+00
1236	268	https://loremflickr.com/800/600/gas+station,fuel?random=2681	Лукойл	1	2026-03-22 00:03:02.780557+00
1237	220	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2200	Источник Пророка Илии	0	2026-03-22 00:03:02.780557+00
1238	220	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2201	Источник Пророка Илии	1	2026-03-22 00:03:02.780557+00
1239	176	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1760	Усадьба	0	2026-03-22 00:03:02.780557+00
1240	176	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1761	Усадьба	1	2026-03-22 00:03:02.780557+00
1241	119	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1190	Пиццерия "Сатурн"	0	2026-03-22 00:03:02.780557+00
1242	119	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1191	Пиццерия "Сатурн"	1	2026-03-22 00:03:02.780557+00
1243	274	https://loremflickr.com/800/600/museum,art,gallery?random=2740	Музей	0	2026-03-22 00:03:02.780557+00
1244	274	https://loremflickr.com/800/600/museum,art,gallery?random=2741	Музей	1	2026-03-22 00:03:02.780557+00
1245	214	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2140	Дольмен	0	2026-03-22 00:03:02.780557+00
1246	214	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2141	Дольмен	1	2026-03-22 00:03:02.780557+00
1247	406	https://loremflickr.com/800/600/picnic,park,nature?random=4060	Место для пикника	0	2026-03-22 00:03:02.780557+00
1248	406	https://loremflickr.com/800/600/picnic,park,nature?random=4061	Место для пикника	1	2026-03-22 00:03:02.780557+00
1249	393	https://loremflickr.com/800/600/picnic,park,nature?random=3930	Партизанская поляна	0	2026-03-22 00:03:02.780557+00
1250	393	https://loremflickr.com/800/600/picnic,park,nature?random=3931	Партизанская поляна	1	2026-03-22 00:03:02.780557+00
1251	143	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1430	Встреча	0	2026-03-22 00:03:02.780557+00
1252	143	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1431	Встреча	1	2026-03-22 00:03:02.780557+00
1253	142	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1420	Надежда	0	2026-03-22 00:03:02.780557+00
1254	142	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1421	Надежда	1	2026-03-22 00:03:02.780557+00
1255	141	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1410	Слоёнка	0	2026-03-22 00:03:02.780557+00
1256	141	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1411	Слоёнка	1	2026-03-22 00:03:02.780557+00
1257	140	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1400	Уют	0	2026-03-22 00:03:02.780557+00
1258	140	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1401	Уют	1	2026-03-22 00:03:02.780557+00
1259	46	https://loremflickr.com/800/600/restaurant,food,dining?random=460	Калинка	0	2026-03-22 00:03:02.780557+00
1260	46	https://loremflickr.com/800/600/restaurant,food,dining?random=461	Калинка	1	2026-03-22 00:03:02.780557+00
1261	44	https://loremflickr.com/800/600/restaurant,food,dining?random=440	Белый рояль	0	2026-03-22 00:03:02.780557+00
1262	44	https://loremflickr.com/800/600/restaurant,food,dining?random=441	Белый рояль	1	2026-03-22 00:03:02.780557+00
1263	14	https://loremflickr.com/800/600/restaurant,food,dining?random=140	Big Bull	0	2026-03-22 00:03:02.780557+00
1264	14	https://loremflickr.com/800/600/restaurant,food,dining?random=141	Big Bull	1	2026-03-22 00:03:02.780557+00
1265	318	https://loremflickr.com/800/600/hotel,resort,room?random=3180	Bon Hotel	0	2026-03-22 00:03:02.780557+00
1266	318	https://loremflickr.com/800/600/hotel,resort,room?random=3181	Bon Hotel	1	2026-03-22 00:03:02.780557+00
1267	59	https://loremflickr.com/800/600/restaurant,food,dining?random=590	Кафе "Старая мельница"	0	2026-03-22 00:03:02.780557+00
1268	59	https://loremflickr.com/800/600/restaurant,food,dining?random=591	Кафе "Старая мельница"	1	2026-03-22 00:03:02.780557+00
1269	290	https://loremflickr.com/800/600/museum,art,gallery?random=2900	Краеведческий музей	0	2026-03-22 00:03:02.780557+00
1270	290	https://loremflickr.com/800/600/museum,art,gallery?random=2901	Краеведческий музей	1	2026-03-22 00:03:02.780557+00
1271	94	https://loremflickr.com/800/600/restaurant,food,dining?random=940	Банкет-холл "Гости"	0	2026-03-22 00:03:02.780557+00
1272	94	https://loremflickr.com/800/600/restaurant,food,dining?random=941	Банкет-холл "Гости"	1	2026-03-22 00:03:02.780557+00
1273	282	https://loremflickr.com/800/600/museum,art,gallery?random=2820	Краеведческий музей	0	2026-03-22 00:03:02.780557+00
1274	282	https://loremflickr.com/800/600/museum,art,gallery?random=2821	Краеведческий музей	1	2026-03-22 00:03:02.780557+00
1275	488	https://loremflickr.com/800/600/winery,vineyard,wine?random=4880	Olymp Winery	0	2026-03-22 00:03:02.780557+00
1276	488	https://loremflickr.com/800/600/winery,vineyard,wine?random=4881	Olymp Winery	1	2026-03-22 00:03:02.780557+00
1277	441	https://loremflickr.com/800/600/beach,sea,coast?random=4410	Пляж	0	2026-03-22 00:03:02.780557+00
1278	441	https://loremflickr.com/800/600/beach,sea,coast?random=4411	Пляж	1	2026-03-22 00:03:02.780557+00
1279	440	https://loremflickr.com/800/600/beach,sea,coast?random=4400	Пляж	0	2026-03-22 00:03:02.780557+00
1280	440	https://loremflickr.com/800/600/beach,sea,coast?random=4401	Пляж	1	2026-03-22 00:03:02.780557+00
1281	484	https://loremflickr.com/800/600/winery,vineyard,wine?random=4840	Прохлада	0	2026-03-22 00:03:02.780557+00
1282	484	https://loremflickr.com/800/600/winery,vineyard,wine?random=4841	Прохлада	1	2026-03-22 00:03:02.780557+00
1283	250	https://loremflickr.com/800/600/gas+station,fuel?random=2500	Газпром	0	2026-03-22 00:03:02.780557+00
1284	250	https://loremflickr.com/800/600/gas+station,fuel?random=2501	Газпром	1	2026-03-22 00:03:02.780557+00
1285	246	https://loremflickr.com/800/600/gas+station,fuel?random=2460	Газпромнефть	0	2026-03-22 00:03:02.780557+00
1286	246	https://loremflickr.com/800/600/gas+station,fuel?random=2461	Газпромнефть	1	2026-03-22 00:03:02.780557+00
1287	213	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2130	Столбы	0	2026-03-22 00:03:02.780557+00
1288	213	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2131	Столбы	1	2026-03-22 00:03:02.780557+00
1289	207	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2070	Зеркало	0	2026-03-22 00:03:02.780557+00
1290	207	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2071	Зеркало	1	2026-03-22 00:03:02.780557+00
1291	206	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2060	Дольмен	0	2026-03-22 00:03:02.780557+00
1292	206	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2061	Дольмен	1	2026-03-22 00:03:02.780557+00
1293	233	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2330	Каменные Грибы	0	2026-03-22 00:03:02.780557+00
1294	233	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2331	Каменные Грибы	1	2026-03-22 00:03:02.780557+00
1295	212	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2120	Дольмен	0	2026-03-22 00:03:02.780557+00
1296	212	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2121	Дольмен	1	2026-03-22 00:03:02.780557+00
1297	137	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1370	Берёзка	0	2026-03-22 00:03:02.780557+00
1298	137	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1371	Берёзка	1	2026-03-22 00:03:02.780557+00
1299	136	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1360	Пицерия "Сеньора"	0	2026-03-22 00:03:02.780557+00
1300	136	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1361	Пицерия "Сеньора"	1	2026-03-22 00:03:02.780557+00
1301	5	https://loremflickr.com/800/600/restaurant,food,dining?random=50	Пенальти	0	2026-03-22 00:03:02.780557+00
1302	5	https://loremflickr.com/800/600/restaurant,food,dining?random=51	Пенальти	1	2026-03-22 00:03:02.780557+00
1303	243	https://loremflickr.com/800/600/gas+station,fuel?random=2430	Роснефть	0	2026-03-22 00:03:02.780557+00
1304	243	https://loremflickr.com/800/600/gas+station,fuel?random=2431	Роснефть	1	2026-03-22 00:03:02.780557+00
1305	267	https://loremflickr.com/800/600/gas+station,fuel?random=2670	Нефть России	0	2026-03-22 00:03:02.780557+00
1306	267	https://loremflickr.com/800/600/gas+station,fuel?random=2671	Нефть России	1	2026-03-22 00:03:02.780557+00
1307	264	https://loremflickr.com/800/600/gas+station,fuel?random=2640	Лукойл	0	2026-03-22 00:03:02.780557+00
1308	264	https://loremflickr.com/800/600/gas+station,fuel?random=2641	Лукойл	1	2026-03-22 00:03:02.780557+00
1309	240	https://loremflickr.com/800/600/gas+station,fuel?random=2400	Лукойл	0	2026-03-22 00:03:02.780557+00
1310	240	https://loremflickr.com/800/600/gas+station,fuel?random=2401	Лукойл	1	2026-03-22 00:03:02.780557+00
1311	239	https://loremflickr.com/800/600/gas+station,fuel?random=2390	Газпром	0	2026-03-22 00:03:02.780557+00
1312	239	https://loremflickr.com/800/600/gas+station,fuel?random=2391	Газпром	1	2026-03-22 00:03:02.780557+00
1313	479	https://loremflickr.com/800/600/winery,vineyard,wine?random=4790	Шумринка	0	2026-03-22 00:03:02.780557+00
1314	479	https://loremflickr.com/800/600/winery,vineyard,wine?random=4791	Шумринка	1	2026-03-22 00:03:02.780557+00
1315	478	https://loremflickr.com/800/600/winery,vineyard,wine?random=4780	Усадьба-винодельня Кантина	0	2026-03-22 00:03:02.780557+00
1316	478	https://loremflickr.com/800/600/winery,vineyard,wine?random=4781	Усадьба-винодельня Кантина	1	2026-03-22 00:03:02.780557+00
1317	449	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4490	Водопад	0	2026-03-22 00:03:02.780557+00
1318	449	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4491	Водопад	1	2026-03-22 00:03:02.780557+00
1319	253	https://loremflickr.com/800/600/gas+station,fuel?random=2530	Роснефть	0	2026-03-22 00:03:02.780557+00
1320	253	https://loremflickr.com/800/600/gas+station,fuel?random=2531	Роснефть	1	2026-03-22 00:03:02.780557+00
1321	252	https://loremflickr.com/800/600/gas+station,fuel?random=2520	Роснефть	0	2026-03-22 00:03:02.780557+00
1322	252	https://loremflickr.com/800/600/gas+station,fuel?random=2521	Роснефть	1	2026-03-22 00:03:02.780557+00
1323	135	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1350	Хычины	0	2026-03-22 00:03:02.780557+00
1324	135	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1351	Хычины	1	2026-03-22 00:03:02.780557+00
1325	516	https://loremflickr.com/800/600/camping,glamping,tent?random=5160	Кемпинг	0	2026-03-22 00:03:02.780557+00
1326	516	https://loremflickr.com/800/600/camping,glamping,tent?random=5161	Кемпинг	1	2026-03-22 00:03:02.780557+00
1327	514	https://loremflickr.com/800/600/camping,glamping,tent?random=5140	сгоревший дом	0	2026-03-22 00:03:02.780557+00
1328	514	https://loremflickr.com/800/600/camping,glamping,tent?random=5141	сгоревший дом	1	2026-03-22 00:03:02.780557+00
1329	470	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4700	Водопад	0	2026-03-22 00:03:02.780557+00
1330	470	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4701	Водопад	1	2026-03-22 00:03:02.780557+00
1331	460	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4600	Водопад	0	2026-03-22 00:03:02.780557+00
1332	460	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4601	Водопад	1	2026-03-22 00:03:02.780557+00
1333	411	https://loremflickr.com/800/600/picnic,park,nature?random=4110	Место для пикника	0	2026-03-22 00:03:02.780557+00
1334	411	https://loremflickr.com/800/600/picnic,park,nature?random=4111	Место для пикника	1	2026-03-22 00:03:02.780557+00
1335	384	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3840	Блыбский перевал	0	2026-03-22 00:03:02.780557+00
1336	384	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3841	Блыбский перевал	1	2026-03-22 00:03:02.780557+00
1337	378	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3780	Казанка	0	2026-03-22 00:03:02.780557+00
1338	378	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3781	Казанка	1	2026-03-22 00:03:02.780557+00
1339	191	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1910	Лев	0	2026-03-22 00:03:02.780557+00
1340	191	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1911	Лев	1	2026-03-22 00:03:02.780557+00
1341	190	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1900	грот Высоцкого	0	2026-03-22 00:03:02.780557+00
1342	190	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1901	грот Высоцкого	1	2026-03-22 00:03:02.780557+00
1343	189	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1890	Шнурок	0	2026-03-22 00:03:02.780557+00
1344	189	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1891	Шнурок	1	2026-03-22 00:03:02.780557+00
1345	146	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1460	«Пирожковое»	0	2026-03-22 00:03:02.780557+00
1346	146	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1461	«Пирожковое»	1	2026-03-22 00:03:02.780557+00
1347	483	https://loremflickr.com/800/600/winery,vineyard,wine?random=4830	Винодельня Криница	0	2026-03-22 00:03:02.780557+00
1348	483	https://loremflickr.com/800/600/winery,vineyard,wine?random=4831	Винодельня Криница	1	2026-03-22 00:03:02.780557+00
1349	452	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4520	Лев	0	2026-03-22 00:03:02.780557+00
1350	452	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4521	Лев	1	2026-03-22 00:03:02.780557+00
1351	451	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4510	грот Высоцкого	0	2026-03-22 00:03:02.780557+00
1352	451	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4511	грот Высоцкого	1	2026-03-22 00:03:02.780557+00
1353	450	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4500	Шнурок	0	2026-03-22 00:03:02.780557+00
1354	450	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4501	Шнурок	1	2026-03-22 00:03:02.780557+00
1355	434	https://loremflickr.com/800/600/beach,sea,coast?random=4340	BLAGO BEACH	0	2026-03-22 00:03:02.780557+00
1356	434	https://loremflickr.com/800/600/beach,sea,coast?random=4341	BLAGO BEACH	1	2026-03-22 00:03:02.780557+00
1357	204	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2040	Каскадный	0	2026-03-22 00:03:02.780557+00
1358	204	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2041	Каскадный	1	2026-03-22 00:03:02.780557+00
1359	203	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2030	Девичья Коса	0	2026-03-22 00:03:02.780557+00
1360	203	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2031	Девичья Коса	1	2026-03-22 00:03:02.780557+00
1361	469	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4690	Каскадный	0	2026-03-22 00:03:02.780557+00
1362	469	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4691	Каскадный	1	2026-03-22 00:03:02.780557+00
1363	468	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4680	Девичья Коса	0	2026-03-22 00:03:02.780557+00
1364	468	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4681	Девичья Коса	1	2026-03-22 00:03:02.780557+00
1365	446	https://loremflickr.com/800/600/beach,sea,coast?random=4460	Пляж Тропическая лагуна	0	2026-03-22 00:03:02.780557+00
1366	446	https://loremflickr.com/800/600/beach,sea,coast?random=4461	Пляж Тропическая лагуна	1	2026-03-22 00:03:02.780557+00
1367	425	https://loremflickr.com/800/600/beach,sea,coast?random=4250	Пляж	0	2026-03-22 00:03:02.780557+00
1368	425	https://loremflickr.com/800/600/beach,sea,coast?random=4251	Пляж	1	2026-03-22 00:03:02.780557+00
1369	388	https://loremflickr.com/800/600/picnic,park,nature?random=3880	Столик	0	2026-03-22 00:03:02.780557+00
1370	388	https://loremflickr.com/800/600/picnic,park,nature?random=3881	Столик	1	2026-03-22 00:03:02.780557+00
1371	363	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3630	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
1372	363	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3631	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
1373	175	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1750	Тихий омут	0	2026-03-22 00:03:02.780557+00
1374	175	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1751	Тихий омут	1	2026-03-22 00:03:02.780557+00
1375	174	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1740	Курьер	0	2026-03-22 00:03:02.780557+00
1376	174	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1741	Курьер	1	2026-03-22 00:03:02.780557+00
1377	173	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1730	Белая Русь	0	2026-03-22 00:03:02.780557+00
1378	173	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1731	Белая Русь	1	2026-03-22 00:03:02.780557+00
1379	323	https://loremflickr.com/800/600/hotel,resort,room?random=3230	Уют	0	2026-03-22 00:03:02.780557+00
1380	323	https://loremflickr.com/800/600/hotel,resort,room?random=3231	Уют	1	2026-03-22 00:03:02.780557+00
1381	276	https://loremflickr.com/800/600/museum,art,gallery?random=2760	Музей	0	2026-03-22 00:03:02.780557+00
1382	276	https://loremflickr.com/800/600/museum,art,gallery?random=2761	Музей	1	2026-03-22 00:03:02.780557+00
1383	283	https://loremflickr.com/800/600/museum,art,gallery?random=2830	сельский музей	0	2026-03-22 00:03:02.780557+00
1384	283	https://loremflickr.com/800/600/museum,art,gallery?random=2831	сельский музей	1	2026-03-22 00:03:02.780557+00
1385	299	https://loremflickr.com/800/600/museum,art,gallery?random=2990	Музей конного завода "Восход"	0	2026-03-22 00:03:02.780557+00
1386	299	https://loremflickr.com/800/600/museum,art,gallery?random=2991	Музей конного завода "Восход"	1	2026-03-22 00:03:02.780557+00
1387	67	https://loremflickr.com/800/600/restaurant,food,dining?random=670	Венец	0	2026-03-22 00:03:02.780557+00
1388	67	https://loremflickr.com/800/600/restaurant,food,dining?random=671	Венец	1	2026-03-22 00:03:02.780557+00
1389	186	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1860	Турецкий фонтан	0	2026-03-22 00:03:02.780557+00
1390	186	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=1861	Турецкий фонтан	1	2026-03-22 00:03:02.780557+00
1391	69	https://loremflickr.com/800/600/restaurant,food,dining?random=690	Экзотик	0	2026-03-22 00:03:02.780557+00
1392	69	https://loremflickr.com/800/600/restaurant,food,dining?random=691	Экзотик	1	2026-03-22 00:03:02.780557+00
1393	47	https://loremflickr.com/800/600/restaurant,food,dining?random=470	Спортбар	0	2026-03-22 00:03:02.780557+00
1394	47	https://loremflickr.com/800/600/restaurant,food,dining?random=471	Спортбар	1	2026-03-22 00:03:02.780557+00
1395	519	https://loremflickr.com/800/600/camping,glamping,tent?random=5190	Кемпинг	0	2026-03-22 00:03:02.780557+00
1396	519	https://loremflickr.com/800/600/camping,glamping,tent?random=5191	Кемпинг	1	2026-03-22 00:03:02.780557+00
1397	442	https://loremflickr.com/800/600/beach,sea,coast?random=4420	Кизилташ	0	2026-03-22 00:03:02.780557+00
1398	442	https://loremflickr.com/800/600/beach,sea,coast?random=4421	Кизилташ	1	2026-03-22 00:03:02.780557+00
1399	412	https://loremflickr.com/800/600/picnic,park,nature?random=4120	Место для пикника	0	2026-03-22 00:03:02.780557+00
1400	412	https://loremflickr.com/800/600/picnic,park,nature?random=4121	Место для пикника	1	2026-03-22 00:03:02.780557+00
1401	355	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3550	Смотровая площадка	0	2026-03-22 00:03:02.780557+00
1402	355	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3551	Смотровая площадка	1	2026-03-22 00:03:02.780557+00
1403	291	https://loremflickr.com/800/600/museum,art,gallery?random=2910	Лапидарий	0	2026-03-22 00:03:02.780557+00
1404	291	https://loremflickr.com/800/600/museum,art,gallery?random=2911	Лапидарий	1	2026-03-22 00:03:02.780557+00
1405	285	https://loremflickr.com/800/600/museum,art,gallery?random=2850	Краеведческий музей	0	2026-03-22 00:03:02.780557+00
1406	285	https://loremflickr.com/800/600/museum,art,gallery?random=2851	Краеведческий музей	1	2026-03-22 00:03:02.780557+00
1407	279	https://loremflickr.com/800/600/museum,art,gallery?random=2790	Музей обороны Аджимушкайских каменоломен	0	2026-03-22 00:03:02.780557+00
1408	279	https://loremflickr.com/800/600/museum,art,gallery?random=2791	Музей обороны Аджимушкайских каменоломен	1	2026-03-22 00:03:02.780557+00
1409	278	https://loremflickr.com/800/600/museum,art,gallery?random=2780	Дом-музей М.Ю. Лермонтова	0	2026-03-22 00:03:02.780557+00
1410	278	https://loremflickr.com/800/600/museum,art,gallery?random=2781	Дом-музей М.Ю. Лермонтова	1	2026-03-22 00:03:02.780557+00
1411	277	https://loremflickr.com/800/600/museum,art,gallery?random=2770	Археологический музей	0	2026-03-22 00:03:02.780557+00
1412	277	https://loremflickr.com/800/600/museum,art,gallery?random=2771	Археологический музей	1	2026-03-22 00:03:02.780557+00
1413	200	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2000	Лотосы	0	2026-03-22 00:03:02.780557+00
1414	200	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2001	Лотосы	1	2026-03-22 00:03:02.780557+00
1415	423	https://loremflickr.com/800/600/beach,sea,coast?random=4230	Пляж	0	2026-03-22 00:03:02.780557+00
1416	423	https://loremflickr.com/800/600/beach,sea,coast?random=4231	Пляж	1	2026-03-22 00:03:02.780557+00
1417	244	https://loremflickr.com/800/600/gas+station,fuel?random=2440	Не работает	0	2026-03-22 00:03:02.780557+00
1418	244	https://loremflickr.com/800/600/gas+station,fuel?random=2441	Не работает	1	2026-03-22 00:03:02.780557+00
1419	415	https://loremflickr.com/800/600/picnic,park,nature?random=4150	Карьер сосны	0	2026-03-22 00:03:02.780557+00
1420	415	https://loremflickr.com/800/600/picnic,park,nature?random=4151	Карьер сосны	1	2026-03-22 00:03:02.780557+00
1421	414	https://loremflickr.com/800/600/picnic,park,nature?random=4140	Ореховая роща	0	2026-03-22 00:03:02.780557+00
1422	414	https://loremflickr.com/800/600/picnic,park,nature?random=4141	Ореховая роща	1	2026-03-22 00:03:02.780557+00
1423	65	https://loremflickr.com/800/600/restaurant,food,dining?random=650	Кальвадос	0	2026-03-22 00:03:02.780557+00
1424	65	https://loremflickr.com/800/600/restaurant,food,dining?random=651	Кальвадос	1	2026-03-22 00:03:02.780557+00
1425	262	https://loremflickr.com/800/600/gas+station,fuel?random=2620	Petrol	0	2026-03-22 00:03:02.780557+00
1426	262	https://loremflickr.com/800/600/gas+station,fuel?random=2621	Petrol	1	2026-03-22 00:03:02.780557+00
1427	261	https://loremflickr.com/800/600/gas+station,fuel?random=2610	Орснефть	0	2026-03-22 00:03:02.780557+00
1428	261	https://loremflickr.com/800/600/gas+station,fuel?random=2611	Орснефть	1	2026-03-22 00:03:02.780557+00
1429	260	https://loremflickr.com/800/600/gas+station,fuel?random=2600	S-oil	0	2026-03-22 00:03:02.780557+00
1430	260	https://loremflickr.com/800/600/gas+station,fuel?random=2601	S-oil	1	2026-03-22 00:03:02.780557+00
1431	431	https://loremflickr.com/800/600/beach,sea,coast?random=4310	нудистский пляж	0	2026-03-22 00:03:02.780557+00
1432	431	https://loremflickr.com/800/600/beach,sea,coast?random=4311	нудистский пляж	1	2026-03-22 00:03:02.780557+00
1433	245	https://loremflickr.com/800/600/gas+station,fuel?random=2450	Лукойл	0	2026-03-22 00:03:02.780557+00
1434	245	https://loremflickr.com/800/600/gas+station,fuel?random=2451	Лукойл	1	2026-03-22 00:03:02.780557+00
1435	493	https://loremflickr.com/800/600/winery,vineyard,wine?random=4930	Винодельня LETO	0	2026-03-22 00:03:02.780557+00
1436	493	https://loremflickr.com/800/600/winery,vineyard,wine?random=4931	Винодельня LETO	1	2026-03-22 00:03:02.780557+00
1437	287	https://loremflickr.com/800/600/museum,art,gallery?random=2870	Краеведческий музей	0	2026-03-22 00:03:02.780557+00
1438	287	https://loremflickr.com/800/600/museum,art,gallery?random=2871	Краеведческий музей	1	2026-03-22 00:03:02.780557+00
1439	152	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1520	Кафе	0	2026-03-22 00:03:02.780557+00
1440	152	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1521	Кафе	1	2026-03-22 00:03:02.780557+00
1441	86	https://loremflickr.com/800/600/restaurant,food,dining?random=860	Флагман	0	2026-03-22 00:03:02.780557+00
1442	86	https://loremflickr.com/800/600/restaurant,food,dining?random=861	Флагман	1	2026-03-22 00:03:02.780557+00
1443	78	https://loremflickr.com/800/600/restaurant,food,dining?random=780	Трикони	0	2026-03-22 00:03:02.780557+00
1444	78	https://loremflickr.com/800/600/restaurant,food,dining?random=781	Трикони	1	2026-03-22 00:03:02.780557+00
1445	61	https://loremflickr.com/800/600/restaurant,food,dining?random=610	Водолей	0	2026-03-22 00:03:02.780557+00
1446	61	https://loremflickr.com/800/600/restaurant,food,dining?random=611	Водолей	1	2026-03-22 00:03:02.780557+00
1447	517	https://loremflickr.com/800/600/camping,glamping,tent?random=5170	Кемпинг	0	2026-03-22 00:03:02.780557+00
1448	517	https://loremflickr.com/800/600/camping,glamping,tent?random=5171	Кемпинг	1	2026-03-22 00:03:02.780557+00
1449	495	https://loremflickr.com/800/600/camping,glamping,tent?random=4950	Кемпинг	0	2026-03-22 00:03:02.780557+00
1450	495	https://loremflickr.com/800/600/camping,glamping,tent?random=4951	Кемпинг	1	2026-03-22 00:03:02.780557+00
1451	459	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4590	Верхний Имеретинский	0	2026-03-22 00:03:02.780557+00
1452	459	https://loremflickr.com/800/600/waterfall,nature,cascade?random=4591	Верхний Имеретинский	1	2026-03-22 00:03:02.780557+00
1453	374	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3740	Озерный	0	2026-03-22 00:03:02.780557+00
1454	374	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3741	Озерный	1	2026-03-22 00:03:02.780557+00
1455	373	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3730	Кутехеку 2	0	2026-03-22 00:03:02.780557+00
1456	373	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3731	Кутехеку 2	1	2026-03-22 00:03:02.780557+00
1457	372	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3720	Квата	0	2026-03-22 00:03:02.780557+00
1458	372	https://loremflickr.com/800/600/viewpoint,mountain+view,panorama?random=3721	Квата	1	2026-03-22 00:03:02.780557+00
1459	227	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2270	Красная Поляна	0	2026-03-22 00:03:02.780557+00
1460	227	https://loremflickr.com/800/600/landmark,monument,sightseeing?random=2271	Красная Поляна	1	2026-03-22 00:03:02.780557+00
1461	149	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1490	Арбат	0	2026-03-22 00:03:02.780557+00
1462	149	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1491	Арбат	1	2026-03-22 00:03:02.780557+00
1463	145	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1450	Оазис	0	2026-03-22 00:03:02.780557+00
1464	145	https://loremflickr.com/800/600/cafe,coffee,bakery?random=1451	Оазис	1	2026-03-22 00:03:02.780557+00
1465	13	https://loremflickr.com/800/600/restaurant,food,dining?random=130	Кафе молодежное	0	2026-03-22 00:03:02.780557+00
1466	13	https://loremflickr.com/800/600/restaurant,food,dining?random=131	Кафе молодежное	1	2026-03-22 00:03:02.780557+00
1467	444	https://loremflickr.com/800/600/beach,sea,coast?random=4440	Хоста Марина	0	2026-03-22 00:03:02.780557+00
1468	444	https://loremflickr.com/800/600/beach,sea,coast?random=4441	Хоста Марина	1	2026-03-22 00:03:02.780557+00
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.posts (id, author_id, title, description, geo_lat, geo_lng, season, region_id, address, phone, email, website, need_car, price_level, duration_hours, best_angle, partner_id, verified, rating_avg, reviews_count, created_at, updated_at, city) FROM stdin;
193	1	Катюша	Достопримечательность	45.1262513	39.0107533	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	городской округ Краснодар
134	1	У Джафара	Кафе	45.1077891	38.9843819	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	городской округ Краснодар
12	1	Казачок	Ресторан	45.1265958	39.0119969	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	городской округ Краснодар
312	1	Золотая колесница	Гостиница	45.1256248	39.0066871	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	городской округ Краснодар
271	1	Уфимнефть	Автозаправочная станция	45.1338199	39.0244543	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	городской округ Краснодар
270	1	Роснефть	Автозаправочная станция	45.0916513	38.9923262	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	городской округ Краснодар
158	1	Закусочная	Кафе	45.2814174	38.3581604	summer	5	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Красноармейский район
417	1	Место для пикника	Место для пикника	44.6707449	38.7610557	summer	6	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Северский район
80	1	Kuvee Karsov	Ресторан	45.015743	37.7545527	summer	9	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Крымский район
480	1	Шато Ле Гран Восток	Винодельня	45.0010209	37.7452316	autumn	9	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Крымский район
219	1	Грязевой вулкан Азовское пекло (Плевак)	Достопримечательность	45.4317654	36.9221696	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Темрюкский район
187	1	грязевой вулкан Тиздар	Достопримечательность	45.3570405	37.0992622	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Темрюкский район
432	1	Пляж	Пляж	45.3354314	37.2007089	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
429	1	Подмаячный	Пляж	45.333009	37.2191323	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
428	1	У Джокера	Пляж	45.3395458	37.1807259	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
421	1	Фанагорийский пляж	Пляж	45.2941097	36.9936445	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
420	1	Центральный пляж	Пляж	45.2857624	36.9883781	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
419	1	"Лурьевский" пляж	Пляж	45.2909865	36.9928716	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
418	1	"Адвокатский" пляж	Пляж	45.2974312	36.9933241	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Темрюкский район
356	1	Подмаячное	Смотровая площадка	45.3305264	37.2287142	summer	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Темрюкский район
481	1	Раевское	Винодельня	44.9057375	37.5637933	autumn	12	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	городской округ Новороссийск
315	1	Жемчужина	Гостиница	44.7865842	37.6740711	summer	12	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	городской округ Новороссийск
211	1	Дольмен	Достопримечательность	44.4564816	38.3513497	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	городской округ Геленджик
210	1	Дольмен	Достопримечательность	44.5527405	38.2476301	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	городской округ Геленджик
116	1	«Куманек» (не работает)	Кафе	44.5259035	38.2952382	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	городской округ Геленджик
494	1	приют Альпинистский (У Наташи)	Кемпинг / Глэмпинг	44.591733	38.3918906	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
477	1	Большой Пшадский (Оляпкин)	Водопад	44.6033963	38.4706147	spring	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
476	1	Водопад	Водопад	44.6402206	38.3987151	spring	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
475	1	Плесецкие	Водопад	44.5657039	38.3213559	spring	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
474	1	Изумрудный	Водопад	44.5608162	38.2567526	spring	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
430	1	Пляж	Пляж	44.5589759	38.4452336	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
413	1	Место для пикника	Место для пикника	44.5452703	38.482182	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
410	1	Место для пикника	Место для пикника	44.5272954	38.3734181	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
352	1	Смотровая площадка	Смотровая площадка	44.6174289	38.2138298	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
350	1	Смотровая площадка	Смотровая площадка	44.5866098	38.2505257	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
343	1	База отдыха	Гостиница	44.4367572	38.1914129	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
511	1	Кемпинг	Кемпинг / Глэмпинг	44.4534594	39.1463022	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	муниципальный округ Горячий Ключ
510	1	Кемпинг	Кемпинг / Глэмпинг	44.4531832	39.1429931	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	муниципальный округ Горячий Ключ
509	1	Кемпинг	Кемпинг / Глэмпинг	44.453618	39.1508955	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	муниципальный округ Горячий Ключ
508	1	Кемпинг	Кемпинг / Глэмпинг	44.453524	39.1483519	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	муниципальный округ Горячий Ключ
307	1	Царина Поляна	Гостиница	44.4986535	39.141439	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	муниципальный округ Горячий Ключ
266	1	Лукойл	Автозаправочная станция	44.7064357	39.2292375	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	муниципальный округ Горячий Ключ
196	1	Чаша	Достопримечательность	44.1824387	39.9702424	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Апшеронский район
505	1	Полянка нежная	Кемпинг / Глэмпинг	44.1508869	40.0733917	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Апшеронский район
504	1	Эдельвейс	Кемпинг / Глэмпинг	44.121599	40.0233556	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Апшеронский район
503	1	Альпико	Кемпинг / Глэмпинг	44.121825	40.022835	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Апшеронский район
496	1	тур приют	Кемпинг / Глэмпинг	44.1994581	39.9577082	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Апшеронский район
465	1	Чинарев	Водопад	44.1681268	39.9644726	spring	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Апшеронский район
464	1	Монахов	Водопад	44.2152364	39.9177315	spring	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Апшеронский район
463	1	Чинарский	Водопад	44.2059874	40.0353057	spring	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Апшеронский район
462	1	Университетский	Водопад	44.1991005	40.0375249	spring	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Апшеронский район
408	1	Место для пикника	Место для пикника	44.1447414	40.052523	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Апшеронский район
407	1	Столик	Место для пикника	44.2056907	39.8857917	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Апшеронский район
391	1	Альпико парк	Место для пикника	44.1589489	40.0681113	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Апшеронский район
389	1	Место для пикника	Место для пикника	44.075471	39.8056803	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Апшеронский район
366	1	Смотровая площадка	Смотровая площадка	44.0671088	39.8108085	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
365	1	Михайлов камень	Смотровая площадка	44.2174467	39.9644104	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
364	1	Смотровая площадка	Смотровая площадка	44.1505918	40.0736939	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
362	1	Смотровая площадка	Смотровая площадка	44.167672	40.0718423	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
361	1	Смотровая площадка	Смотровая площадка	44.156471	40.0743364	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
360	1	Смотровая площадка	Смотровая площадка	44.2141184	39.9067407	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
349	1	Чай с мёдом	Смотровая площадка	44.1084092	40.0114202	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Апшеронский район
223	1	Дольмен	Достопримечательность	44.2618666	39.0383189	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
222	1	Дольмен	Достопримечательность	44.262232	39.0378736	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
221	1	Дольмен	Достопримечательность	44.2621213	39.0380129	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
209	1	Два дольмена (разрушены)	Достопримечательность	44.1831079	39.3080866	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
208	1	кам-море	Достопримечательность	44.1879161	39.2860763	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
199	1	Дольмены	Достопримечательность	44.176818	39.2922658	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
195	1	Двубратский каньон	Достопримечательность	44.1925502	39.3252121	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
522	1	Тотем шаманов	Кемпинг / Глэмпинг	44.2630578	39.196584	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
521	1	Кемпинг	Кемпинг / Глэмпинг	44.2621625	39.1973551	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
502	1	Кемпинг	Кемпинг / Глэмпинг	44.192765	39.331914	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
501	1	Кемпинг	Кемпинг / Глэмпинг	44.1878748	39.3155145	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
500	1	Кемпинг	Кемпинг / Глэмпинг	44.1926691	39.3328818	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
499	1	Кемпинг	Кемпинг / Глэмпинг	44.192126	39.3335723	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
498	1	Кемпинг	Кемпинг / Глэмпинг	44.1919202	39.3339807	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
497	1	Кемпинг	Кемпинг / Глэмпинг	44.1922063	39.3287271	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
473	1	Двухкаскадный	Водопад	44.19247	39.3295377	spring	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
472	1	Водопад	Водопад	44.1925282	39.3293155	spring	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
456	1	Водопад	Водопад	44.2875992	39.3279221	spring	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
448	1	Кесух	Водопад	44.4390299	39.0315663	spring	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
392	1	Место для пикника	Место для пикника	44.1920705	39.3287132	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
387	1	Смотровая площадка	Смотровая площадка	44.1890575	39.3152654	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
386	1	Вид на каньон	Смотровая площадка	44.1887821	39.3148054	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
385	1	Вид на водопад Сказка	Смотровая площадка	44.1886739	39.312561	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
375	1	Смотровая площадка	Смотровая площадка	44.2518992	39.1966182	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
354	1	Смотровая площадка	Смотровая площадка	44.2739137	39.2252281	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Туапсинский муниципальный округ
520	1	Развалины пастушьего укрытия	Кемпинг / Глэмпинг	44.0422144	39.9423612	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
453	1	Пшехский	Водопад	43.9788021	39.8811069	spring	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
409	1	Ночёвка запрещена. Штраф 5000р	Место для пикника	44.0168529	39.9494445	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
377	1	Смотровая площадка	Смотровая площадка	43.8827241	39.9596617	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
376	1	Смотровая площадка	Смотровая площадка	43.9811984	39.9039104	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
367	1	Смотровая площадка	Смотровая площадка	43.9999487	39.8481314	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
353	1	Смотровая площадка	Смотровая площадка	43.975328	39.5729927	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
351	1	Смотровая площадка	Смотровая площадка	44.0628819	40.0189951	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
327	1	Энектур	Гостиница	43.9912908	40.1301744	summer	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	городской округ Сочи
202	1	Шум	Достопримечательность	44.2686684	40.1840922	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Мостовский район
198	1	Гришкина яма	Достопримечательность	44.0417236	40.6338847	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Мостовский район
192	1	Казачий камень	Достопримечательность	44.2606288	40.2006502	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Мостовский район
523	1	Кемпинг	Кемпинг / Глэмпинг	44.0475634	40.3423698	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Мостовский район
515	1	Кемпинг	Кемпинг / Глэмпинг	43.9665152	40.6074575	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Мостовский район
513	1	Кемпинг	Кемпинг / Глэмпинг	43.9714878	40.4715268	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Мостовский район
512	1	Кемпинг	Кемпинг / Глэмпинг	44.0379355	40.4296764	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Мостовский район
507	1	Кемпинг	Кемпинг / Глэмпинг	44.0731569	40.4207335	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Мостовский район
467	1	Шум	Водопад	44.2686684	40.1840922	spring	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Мостовский район
466	1	Водопад	Водопад	44.0318312	40.4373686	spring	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Мостовский район
458	1	Раскол	Водопад	44.1627417	40.2980847	spring	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Мостовский район
457	1	Три Брата	Водопад	44.1742391	40.2997667	spring	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Мостовский район
390	1	Навес	Место для пикника	44.2815809	40.4867453	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Мостовский район
382	1	Смотровая площадка	Смотровая площадка	44.2567187	40.6584553	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
381	1	Смотровая площадка	Смотровая площадка	44.0232124	40.532681	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
380	1	Смотровая площадка	Смотровая площадка	44.0304332	40.5513146	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
379	1	Смотровая площадка	Смотровая площадка	44.0579558	40.5128246	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
371	1	Смотровая площадка	Смотровая площадка	44.0271734	40.4129707	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
370	1	Смотровая площадка	Смотровая площадка	44.0390357	40.3693184	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
369	1	Смотровая площадка	Смотровая площадка	44.1783397	40.2969576	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
368	1	Даховская панорама	Смотровая площадка	44.23863	40.1697814	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Мостовский район
292	1	Музей станицы Бриньковской имени Г.Я. Бахчиванджи	Музей	46.0357306	38.5844275	summer	23	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Приморско-Ахтарский муниципальный округ
288	1	Краеведческий музей	Музей	46.1079407	39.3080327	summer	30	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Ленинградский муниципальный округ
317	1	Академия	Гостиница	43.6774303	41.4587443	summer	32	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Отрадненский район
422	1	Пляж	Пляж	45.4138467	40.0171811	summer	43	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Тбилисский район
216	1	Форелевое хозяйство	Достопримечательность	43.5163689	39.9931638	summer	47	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	городской округ Сириус
25	1	Таверна Каньон	Ресторан	43.5178941	39.9932417	summer	47	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	городской округ Сириус
185	1	Цветочные часы	Достопримечательность	45.0540225	38.9799687	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Краснодар
181	1	У трех берез	Кафе	45.0172159	39.0370072	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
180	1	Лиза	Кафе	45.0169536	39.0374419	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
177	1	Три берёзы	Кафе	45.0158718	39.0544444	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
153	1	Pankiss	Кафе	45.0360132	38.976192	summer	48	Красноармейская улица, 103	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
139	1	Zohan bar	Кафе	45.0286105	38.9707933	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
138	1	Сармат	Кафе	45.0600076	38.977284	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
133	1	5 Авеню	Кафе	45.037189	38.9754926	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
131	1	Жар-Пицца	Кафе	45.0511482	38.9583754	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
129	1	Мир Любви	Кафе	45.012877	38.9707164	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
128	1	Off-Road Кафе	Кафе	45.0364442	39.0021861	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
126	1	Шашлык	Кафе	45.0554619	38.9602437	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
122	1	Пицца-Лав	Кафе	45.033924	38.9667055	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
121	1	Сгущёнка	Кафе	45.0283518	38.9723536	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
118	1	Патрик & Мари	Кафе	45.0695461	38.9815937	summer	48	шоссе Нефтяников, 63	+7 918 1199955	\N	http://patrik.madyar.ru	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
117	1	Don Cappuccino	Кафе	45.0488627	38.9837166	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
115	1	Sweet Beans	Кафе	45.0390907	38.9760928	summer	48	\N	+7 918 0561806	\N	http://sweetbeans.ru	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
114	1	Квартира	Кафе	45.0405014	38.9766818	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
113	1	Жар-пицца	Кафе	45.0164604	39.0472853	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
112	1	Т-кафе	Кафе	45.0180693	38.9684338	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
111	1	Жаровня	Кафе	45.0208084	38.9686524	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
110	1	Столовая	Кафе	45.0306025	38.9668823	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
109	1	Заря	Кафе	45.0396018	38.9940004	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
108	1	Уни пицца	Кафе	45.0282437	38.9740123	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
107	1	Уни Пицца	Кафе	45.0503272	39.0023028	summer	48	\N	+7 861 2531818	\N	http://unipizza.ru/	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
106	1	Куба	Кафе	45.0292558	38.9712972	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
105	1	Столовая	Кафе	45.0252434	38.9912995	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
104	1	Мэни Пельмени	Кафе	45.0233424	38.969614	summer	48	\N	+78612743103	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
103	1	Любо Кондитерская	Кафе	45.0546741	38.98235	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
102	1	Холостядзе	Кафе	45.0312423	38.9746396	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
101	1	Плезир	Кафе	45.0311877	38.9725344	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
100	1	The Печь	Кафе	45.0240812	38.967865	summer	48	\N	+7 989 8587111	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
99	1	Холостяк	Кафе	45.0284227	38.9719668	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
98	1	Кафе "Любо"	Кафе	45.0520165	38.9794327	summer	48	Красная улица, 165/3	\N	\N	www.lubodorogo.ru	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
97	1	Леди Мармелад	Кафе	45.0428303	38.9775329	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
96	1	Дворик	Кафе	45.043329	38.9777008	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Краснодар
90	1	Пена	Ресторан	45.0239593	38.9658524	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
74	1	Восьмое небо	Ресторан	45.0159646	38.9634568	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
73	1	Prosushi	Ресторан	45.0316396	38.917235	summer	48	\N	\N	\N	http://probeshka.ru	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
72	1	Сатин	Ресторан	45.0489203	38.986309	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
71	1	СушиWok	Ресторан	45.0297754	38.9130368	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
70	1	Диканька	Ресторан	45.0412609	38.9877863	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
184	1	Mocco	Кафе	43.5784046	39.7287965	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
225	1	Лотосы	Достопримечательность	45.3826098	38.4371098	summer	5	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Красноармейский район
230	1	Дольмен (разрушен)	Достопримечательность	44.5504169	38.193933	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	городской округ Геленджик
228	1	водопад в Кручёной щели	Достопримечательность	44.6334563	38.1885353	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	городской округ Геленджик
224	1	Дольмен	Достопримечательность	44.2618782	39.0381407	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсинский муниципальный округ
66	1	Пиноккио Djan	Ресторан	45.0620426	38.9935308	summer	48	Зиповская улица, 5/4	+7 861 2031110;+7 918 2191919	\N	https://madyar.ru/ru/restaurants/pinocchio-djan	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
56	1	Москва	Ресторан	45.0262016	38.9713665	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
55	1	McKEY	Ресторан	45.0493313	38.9677184	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
53	1	Суши-бар "Минами"	Ресторан	45.0304078	38.9105279	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
51	1	Баден-Баден	Ресторан	45.0686422	38.9788729	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
49	1	Таверна у Замка	Ресторан	45.0591697	38.9626714	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
48	1	Грац	Ресторан	45.0594596	38.9640856	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
43	1	Духанъ	Ресторан	45.0186018	38.9680247	summer	48	\N	+7 918 6797610;+7 988 2433121	\N	https://www.duckhan.ru	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
41	1	Старый город	Ресторан	45.0286528	38.9680284	summer	48	Карасунская улица, 60	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
22	1	Amsterdam Bar	Ресторан	45.0288339	38.9741391	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
11	1	У Близнецов	Ресторан	45.0495751	38.969108	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
10	1	Мадьяр	Ресторан	45.0498342	38.9661759	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
7	1	Пивница	Ресторан	45.0416725	38.9807424	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
6	1	Сербский ресторан	Ресторан	45.0288449	38.9694763	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
4	1	Хванчкара	Ресторан	45.0272866	38.9984618	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
3	1	Старина Герман	Ресторан	45.0149741	38.9866572	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
2	1	Ресторан	Ресторан	45.0259714	38.9868878	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Краснодар
326	1	Forum	Гостиница	45.0362405	39.0692167	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
325	1	Марс	Гостиница	45.0307237	39.0322247	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
316	1	Genoff	Гостиница	45.0178194	38.9960357	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
308	1	Пилот	Гостиница	45.0404309	38.9930328	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
306	1	Карамболь	Гостиница	45.0181258	38.9960879	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
304	1	Динамо	Гостиница	45.050376	38.9808309	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
303	1	Кавказ	Гостиница	45.044171	38.9784224	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
302	1	Южный	Гостиница	45.0562915	39.0032328	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Краснодар
273	1	Краснодарский государственный историко-археологический музей-заповедник им. Е.Д. Фелицина	Музей	45.0251552	38.9723115	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Краснодар
269	1	Лукойл	Автозаправочная станция	45.0091078	39.1219156	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Краснодар
263	1	Rusoil	Автозаправочная станция	44.9215688	39.1439378	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Краснодар
147	1	Кафе	Кафе	45.2157783	37.8962935	summer	49	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Славянск-на-Кубани
52	1	Амара	Ресторан	45.2649128	38.1480452	summer	49	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Славянск-на-Кубани
50	1	Бомонд	Ресторан	45.2430236	38.15843	summer	49	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Славянск-на-Кубани
42	1	Чайка	Ресторан	45.2535879	38.1171604	summer	49	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Славянск-на-Кубани
201	1	Грязевой вулкан Гнилая гора	Достопримечательность	45.2517448	37.4357067	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Темрюк
91	1	У Бочки	Ресторан	45.328402	37.2807022	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Темрюк
89	1	Меридиан	Ресторан	45.327225	37.2987288	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Темрюк
88	1	Литораль	Ресторан	45.3256824	37.2799588	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Темрюк
491	1	Абрау-Дюрсо	Винодельня	44.8770928	37.3111542	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Анапа
490	1	Шумринка	Винодельня	44.877187	37.3110563	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Анапа
489	1	Fanagoria	Винодельня	44.8773243	37.3109261	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Анапа
324	1	Отель "Плаза"	Гостиница	44.9007732	37.3209396	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Анапа
183	1	Палуба Ресторан	Кафе	43.548037	39.7771632	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
182	1	Бали	Кафе	43.5485109	39.7921781	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
172	1	Неро	Кафе	43.587661	39.722845	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
171	1	Шанталь	Кафе	43.5652652	39.7601496	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
165	1	Seafood market	Кафе	43.5804601	39.719329	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
164	1	Эдем	Кафе	43.5881293	39.7220127	summer	54	Зелёный переулок, 13	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
163	1	Бабаева	Кафе	43.5755216	39.7239976	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
162	1	Калифорния	Кафе	43.5757024	39.723905	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
161	1	Чёрный жемчуг	Кафе	43.5757829	39.7237263	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
160	1	Белые ночи	Кафе	43.576863	39.7260936	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
159	1	Восток	Кафе	43.6272298	39.7182977	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
154	1	Маяк	Кафе	43.6090031	39.7071465	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
151	1	Столовая на Роз	Кафе	43.5931916	39.7274294	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
150	1	Банкир	Кафе	43.5872433	39.7195095	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
144	1	Coffee	Кафе	43.5492829	39.78249	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
132	1	Сенатор	Кафе	43.5859212	39.7254409	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Сочи
85	1	Кофемания	Ресторан	43.5804043	39.7188144	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
84	1	Причал №1	Ресторан	43.5790949	39.717561	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
82	1	La Vash	Ресторан	43.614046	39.7139361	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
64	1	Золотой Якорь	Ресторан	43.5879452	39.7230655	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
63	1	Чешское пиво	Ресторан	43.6088672	39.7280538	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
45	1	Восток	Ресторан	43.6214187	39.7186565	summer	54	Виноградная улица	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
40	1	Чайхона №1	Ресторан	43.5738775	39.7279572	summer	54	Приморская улица, 16, Сочи	+7 862 2901660	\N	https://chaihona1.ru	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
39	1	Малый Ахун	Ресторан	43.5443822	39.8284932	summer	54	дорога на Большой Ахун	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
38	1	Дом 1934 г	Ресторан	43.5763724	39.7254205	summer	54	Морской переулок, 3	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
35	1	London	Ресторан	43.5820684	39.7189501	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
34	1	Япона Мама	Ресторан	43.574821	39.728738	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
33	1	Прайд	Ресторан	43.6140274	39.739208	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
30	1	Фидан	Ресторан	43.5774093	39.730954	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
29	1	Индус	Ресторан	43.5727625	39.7352536	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
28	1	Cinema	Ресторан	43.5757584	39.725387	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
27	1	Аурум	Ресторан	43.5763	39.723794	summer	54	\N	\N	\N	https://aurumrest.ru/	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
24	1	Nippon House	Ресторан	43.589573	39.722576	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
23	1	Пальма	Ресторан	43.5614913	39.760543	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
20	1	Катюша	Ресторан	43.5578359	39.7654887	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
19	1	Восточный квартал	Ресторан	43.5713275	39.7288786	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
18	1	Федина дача	Ресторан	43.5678854	39.7353245	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
17	1	Оливье	Ресторан	43.5922468	39.7228599	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
16	1	Старый Базар	Ресторан	43.5833881	39.7180436	summer	54	Несебрская улица, 4	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
15	1	Променад	Ресторан	43.5859403	39.7192139	summer	54	\N	+78622643867	\N	https://promenad-sochi.ru/	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Сочи
436	1	Жемчужина	Пляж	43.5692949	39.730652	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Сочи
435	1	Пляж санатория "Русь"	Пляж	43.6092573	39.7044117	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Сочи
321	1	City Park Hotel	Гостиница	43.5761102	39.7258462	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Сочи
320	1	MIRROR	Гостиница	43.5729017	39.7350363	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Сочи
297	1	A.A.C. Art Gallery of Wood Plastic	Музей	43.5267615	39.8379475	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Сочи
275	1	Музей истории Сочи	Музей	43.5902931	39.7234503	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Сочи
125	1	Кубань	Кафе	44.5554634	38.0724843	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Геленджик
124	1	Эдем	Кафе	44.5556899	38.0725835	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Геленджик
123	1	Saloon Western	Кафе	44.5555638	38.0719438	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Геленджик
92	1	Виола	Ресторан	44.5040587	38.1290053	summer	55	Черноморская улица, 4	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Геленджик
77	1	Трофей	Ресторан	44.5663322	38.0758562	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Геленджик
76	1	Мария	Ресторан	44.5557674	38.0728749	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Геленджик
75	1	Music Hall	Ресторан	44.5557943	38.0730619	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Геленджик
62	1	Магнолия	Ресторан	44.5776165	38.0640595	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Геленджик
54	1	Хижина рыбака	Ресторан	44.5602473	38.0288666	summer	55	\N	+7 928 4430509	\N	https://хижина-рыбака.рф	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Геленджик
443	1	Нудистский  пляж	Пляж	44.4756772	38.1431674	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Геленджик
437	1	Пляж ДОЛ "Североморец"	Пляж	44.5655403	38.0018781	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Геленджик
424	1	Нудистский пляж	Пляж	44.5120742	38.1121692	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Геленджик
348	1	Смотровая площадка	Смотровая площадка	44.59682	38.0849285	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Геленджик
347	1	б.о. Юнармеец	Гостиница	44.5026732	38.1373429	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
346	1	Чайка	Гостиница	44.5753985	38.0222925	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
345	1	б.о. Радуга	Гостиница	44.5057406	38.1296599	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
344	1	База отдыха "Северянка"	Гостиница	44.5788559	38.0199148	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
342	1	Санаторий "Голубая волна"	Гостиница	44.5869811	38.0293636	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
341	1	б.о. Вагончик	Гостиница	44.5023328	38.1273624	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
340	1	Пансионат "Строитель"	Гостиница	44.5864817	38.0334504	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
339	1	База отдыха "Ромашка"	Гостиница	44.5824986	38.0234407	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
338	1	Пансионат "Приветливый берег"	Гостиница	44.582118	38.061538	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
337	1	Александрия	Гостиница	44.571051	38.0724121	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
336	1	т\\б Дивна	Гостиница	44.510407	38.1307134	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
335	1	База отдыха "Светлячок"	Гостиница	44.5843941	38.0228653	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
334	1	д.о. Баргузин	Гостиница	44.5118761	38.1325143	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
333	1	База отдыха «Ростсельмаш»	Гостиница	44.5540179	38.0560375	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
332	1	База отдыха "Здоровье"	Гостиница	44.5820311	38.0201309	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
331	1	База отдыха "Авиатор"	Гостиница	44.5827583	38.0228629	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
330	1	Пансионат "Лазурный берег"	Гостиница	44.5874466	38.0482676	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
329	1	Дом отдыха «Звёздочка»	Гостиница	44.5711853	38.078841	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
328	1	Пансионат "Северянка"	Гостиница	44.5780989	38.0202217	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
311	1	Music Hall	Гостиница	44.5558691	38.0730317	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
310	1	Кино	Гостиница	44.5548413	38.0706309	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
309	1	Самара	Гостиница	44.5554433	38.0722736	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Геленджик
293	1	Музей мусора «Белая лошадь»	Музей	44.5742057	37.9974009	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Геленджик
286	1	Морской музей	Музей	44.5858663	38.0752546	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Геленджик
284	1	Краеведческий музей	Музей	44.5631606	38.0773233	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Геленджик
281	1	Дом-музей В. Г. Короленко	Музей	44.4667876	38.1643355	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Геленджик
229	1	Дольмен Лунный	Достопримечательность	44.5612491	38.1561065	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Геленджик
197	1	Грязевой вулкан	Достопримечательность	44.7273245	38.071839	summer	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Кабардинка
188	1	Погибшим на пароходе "Адмирал Нахимов"	Достопримечательность	44.6299551	37.9073614	summer	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Кабардинка
487	1	Усадьба Маркотх	Винодельня	44.6401211	37.9856073	autumn	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Кабардинка
295	1	Выставка изделий из стекла	Музей	44.6502273	37.9440477	summer	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Кабардинка
218	1	скала Петушок	Достопримечательность	44.6220494	39.0918184	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
217	1	Дантово ущелье	Достопримечательность	44.6202047	39.0942172	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
215	1	Столб Мира	Достопримечательность	44.5972119	39.1082955	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
205	1	Желтые монастыри	Достопримечательность	44.5414848	38.8314474	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
170	1	Золотое руно	Кафе	44.7165612	39.2105	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
169	1	Синьор Помидор	Кафе	44.7168897	39.2106585	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
168	1	«Привал»	Кафе	44.7171978	39.2108337	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
167	1	Вкусноежка	Кафе	44.7174428	39.2116227	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
166	1	Молодежное	Кафе	44.7173926	39.211588	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
148	1	Кафе	Кафе	44.6056778	39.0751051	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
21	1	«Ё-Моё»	Ресторан	44.7182967	39.2113212	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
518	1	Кемпинг	Кемпинг / Глэмпинг	44.5003275	38.9515498	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Горячий Ключ
506	1	Каштановая Роща	Кемпинг / Глэмпинг	44.5970569	38.8809084	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Горячий Ключ
394	1	Место для пикника	Место для пикника	44.6140778	39.1638899	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Горячий Ключ
322	1	«Ё-Моё»	Гостиница	44.718224	39.211267	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Горячий Ключ
265	1	Газпромнефть	Автозаправочная станция	44.6410552	39.1157171	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Горячий Ключ
234	1	Медвежьи ворота	Достопримечательность	44.6701262	38.9723541	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
231	1	Волчьи Ворота	Достопримечательность	44.6682168	38.9768312	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Горячий Ключ
179	1	Натали	Кафе	43.9043479	39.3352839	summer	58	Речная улица, 3/2	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Туапсе
178	1	Небеса	Кафе	43.8966944	39.3487903	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Туапсе
95	1	Пингвин	Кафе	43.9082238	39.3322306	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Туапсе
68	1	Пиццерия Пьеtро	Ресторан	44.174371	38.9620471	summer	58	\N	+7 918 1444157	\N	http://пьетро.рф	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
60	1	Кавказ	Ресторан	43.9066765	39.3258735	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
58	1	Прибой	Ресторан	43.9056091	39.3264909	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
57	1	Русское застолье	Ресторан	43.9108017	39.3251871	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
37	1	Шереметьево-4 (самолет)	Ресторан	44.043349	39.1401869	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
26	1	Прохлада	Ресторан	43.8961472	39.3473324	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
1	1	Кавказская кухня "Хаш"	Ресторан	44.0050645	39.1923648	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Туапсе
471	1	Водопад	Водопад	44.1255128	39.1016704	spring	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсе
461	1	Вид на водопад на ручье (дальше дороги нет)	Водопад	43.9632144	39.4221703	spring	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсе
455	1	Водопад	Водопад	44.1284749	39.1044785	spring	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсе
454	1	Водопад	Водопад	44.125091	39.1017375	spring	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Туапсе
447	1	мыс Эльмира	Пляж	43.9727917	39.2462065	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Туапсе
416	1	Место для пикника	Место для пикника	44.1501358	39.0192644	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Туапсе
301	1	Гизель-Дере	Гостиница	44.0877201	39.1243748	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Туапсе
300	1	Гизель-Дере	Гостиница	44.0966055	39.1110281	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Туапсе
232	1	Скала "Тренировочная"	Достопримечательность	44.1189868	39.1327381	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Туапсе
127	1	барракуда	Кафе	44.6844651	37.7948738	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Новороссийск
120	1	Корсар	Кафе	44.7135832	37.8449	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Новороссийск
492	1	Шато Дюрсо	Винодельня	44.6825331	37.5653392	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Новороссийск
486	1	Мысхако	Винодельня	44.6593432	37.7557776	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Новороссийск
485	1	Шато Пино	Винодельня	44.6849231	37.708925	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Новороссийск
427	1	Дачный	Пляж	44.6700625	37.6445392	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Новороссийск
383	1	Кяфар	Смотровая площадка	43.6197093	41.1655118	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Псебай
359	1	Семь ветров	Смотровая площадка	44.7255282	37.8668158	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Новороссийск
358	1	Смотровая площадка	Смотровая площадка	44.7105591	37.5935911	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Новороссийск
357	1	Смотровая на озеро.	Смотровая площадка	44.7079182	37.5844779	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Новороссийск
305	1	Корсар	Гостиница	44.7133051	37.8449395	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Новороссийск
298	1	В гостях у винодела	Музей	44.6756662	37.6352542	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Новороссийск
156	1	У мельника	Кафе	44.9903233	41.0905633	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Армавир
155	1	ВУЛКАН	Кафе	44.9622576	41.1416687	summer	60	Урупская улица	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Армавир
93	1	"Pesto" "Песто"	Ресторан	44.996011	41.0864657	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Армавир
87	1	кафе "Молодежное"	Ресторан	44.9999208	41.1367706	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Армавир
83	1	Астория	Ресторан	44.9967327	41.1310779	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Армавир
9	1	Грааль	Ресторан	44.9879957	41.1200933	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Армавир
8	1	Версаль	Ресторан	45.0005246	41.1328514	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Армавир
319	1	КОМФОРТ	Гостиница	44.9834415	41.0864068	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Армавир
313	1	Северная	Гостиница	44.9990618	41.125411	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Армавир
130	1	Кафе Пицца	Кафе	45.6152966	38.9587817	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Тимашёвск
32	1	Флагман	Ресторан	45.618911	38.9373718	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Тимашёвск
31	1	Алекс	Ресторан	45.6161633	38.9350306	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Тимашёвск
426	1	Пляж	Пляж	45.6021172	38.9139423	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Тимашёвск
314	1	Изумруд	Гостиница	45.6126031	38.9585804	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Тимашёвск
280	1	Музей семьи Степановых	Музей	45.6126297	38.9367781	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Тимашёвск
81	1	Банкет	Ресторан	46.1359909	39.7830534	summer	62	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Павловская
289	1	Историко-краеведческий музей	Музей	46.1358173	39.7832496	summer	62	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Павловская
79	1	Столовая	Ресторан	44.978699	37.271429	summer	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Витязево
482	1	Винодельня Бердяева	Винодельня	44.981751	37.3125481	autumn	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Витязево
445	1	Пляж	Пляж	45.0605607	37.055218	summer	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Витязево
194	1	Динозавр	Достопримечательность	44.3079312	38.7083715	summer	64	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Джубга
433	1	Чайка	Пляж	44.3137283	38.6663588	summer	64	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Джубга
226	1	Тенгинские водопады	Достопримечательность	44.3362719	38.8075614	summer	64	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Джубга
36	1	На Краю Земли	Ресторан	43.7999806	39.6327548	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Дагомыс
405	1	Место для пикника	Место для пикника	43.6634082	39.759703	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
404	1	Место для пикника	Место для пикника	43.6638719	39.7596233	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
403	1	Место для пикника	Место для пикника	43.6657595	39.7591784	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
402	1	Место для пикника	Место для пикника	43.6631626	39.7597054	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
401	1	Место для пикника	Место для пикника	43.6625279	39.7593939	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
400	1	Место для пикника	Место для пикника	43.6652582	39.7593835	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
399	1	Место для пикника	Место для пикника	43.6648113	39.7595704	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
398	1	Место для пикника	Место для пикника	43.6636226	39.7596379	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
397	1	Место для пикника	Место для пикника	43.664073	39.7595782	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
396	1	Место для пикника	Место для пикника	43.664502	39.759554	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
395	1	Место для пикника	Место для пикника	43.6642991	39.7596129	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Дагомыс
296	1	Дом музей И. А. Кошмана "Родина Русского Чая"	Музей	43.8028515	39.6834586	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Дагомыс
272	1	Роснефть	Автозаправочная станция	43.633247	39.7080935	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Дагомыс
439	1	Пляж	Пляж	45.0608035	39.4501584	summer	67	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Васюринская
157	1	Родничок	Кафе	45.2227513	38.5116434	summer	72	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Новомышастовская
294	1	Дом музей А.П. Артюха	Музей	45.2048595	38.577082	summer	72	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Новомышастовская
438	1	Пляж	Пляж	44.4046416	39.4130762	summer	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Хадыженск
237	1	ТНК	Автозаправочная станция	45.0330672	39.1351747	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	городской округ Краснодар
247	1	Роснефть	Автозаправочная станция	45.1780687	39.1058003	summer	4	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Динской район
254	1	Газпром	Автозаправочная станция	44.9038922	37.5829082	summer	12	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	городской округ Новороссийск
258	1	Profoil	Автозаправочная станция	44.4580095	38.3646229	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	городской округ Геленджик
235	1	Роснефть	Автозаправочная станция	45.3659705	40.1277387	summer	43	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Тбилисский район
248	1	АГЗС	Автозаправочная станция	45.0147092	38.9963686	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Краснодар
238	1	Кубанский топливный союз	Автозаправочная станция	45.0217882	38.9843633	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Краснодар
236	1	Лукойл	Автозаправочная станция	45.0198613	39.0242254	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Краснодар
249	1	Лукойл	Автозаправочная станция	45.3165897	37.293303	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Темрюк
251	1	Роснефть	Автозаправочная станция	44.9105977	37.3285363	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Анапа
257	1	Газпромнефть	Автозаправочная станция	44.5854346	38.0709932	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Геленджик
256	1	Рассвет	Автозаправочная станция	44.5931247	38.0569998	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Геленджик
259	1	Юг-Нефтьх⁰	Автозаправочная станция	44.8260036	39.2250993	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Горячий Ключ
255	1	Уфимнефть	Автозаправочная станция	44.7656109	37.7231727	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Новороссийск
242	1	Лукойл	Автозаправочная станция	45.2428171	39.6879786	summer	66	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Усть-Лабинск
241	1	Газпромнефть	Автозаправочная станция	45.2439766	39.6886354	summer	66	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Усть-Лабинск
268	1	Лукойл	Автозаправочная станция	44.737921	39.8574439	summer	74	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Белореченск
220	1	Источник Пророка Илии	Достопримечательность	45.6844609	39.5869244	summer	75	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Выселки
176	1	Усадьба	Кафе	44.8862702	38.8372998	summer	76	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Афипский
119	1	Пиццерия "Сатурн"	Кафе	44.921976	38.9088611	summer	76	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Афипский
274	1	Музей	Музей	44.1797104	40.0805016	summer	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Апшеронский район
214	1	Дольмен	Достопримечательность	44.6921043	38.5260346	summer	78	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Ильский
406	1	Место для пикника	Место для пикника	44.8074217	38.5805752	summer	78	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Ильский
393	1	Партизанская поляна	Место для пикника	44.6706467	38.5066419	summer	78	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Ильский
143	1	Встреча	Кафе	44.8730721	40.5829907	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Курганинск
142	1	Надежда	Кафе	44.8838345	40.5893202	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Курганинск
141	1	Слоёнка	Кафе	44.8852907	40.5884314	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Курганинск
140	1	Уют	Кафе	44.8970689	40.5972337	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Курганинск
46	1	Калинка	Ресторан	44.907713	40.5826323	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Курганинск
44	1	Белый рояль	Ресторан	44.8923789	40.591698	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Курганинск
14	1	Big Bull	Ресторан	44.8829045	40.5912203	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Курганинск
318	1	Bon Hotel	Гостиница	44.9082582	40.5976152	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Курганинск
59	1	Кафе "Старая мельница"	Ресторан	45.7460384	39.0182673	summer	82	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Брюховецкая
290	1	Краеведческий музей	Музей	45.8039895	39.0048325	summer	82	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Брюховецкая
94	1	Банкет-холл "Гости"	Ресторан	46.0815415	38.9692266	summer	84	\N	+7 960 490-40-70	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Каневская
282	1	Краеведческий музей	Музей	46.083183	38.9753703	summer	84	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Каневская
488	1	Olymp Winery	Винодельня	45.071449	37.7749593	autumn	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Варениковская
441	1	Пляж	Пляж	45.1625071	37.6607827	summer	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Варениковская
440	1	Пляж	Пляж	45.1415906	37.6444844	summer	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Варениковская
484	1	Прохлада	Винодельня	45.2009121	37.1394733	autumn	87	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Старотитаровская
250	1	Газпром	Автозаправочная станция	45.1752616	37.2875842	summer	87	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Старотитаровская
246	1	Газпромнефть	Автозаправочная станция	45.3151926	39.9253437	summer	89	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Ладожская
213	1	Столбы	Достопримечательность	44.741609	38.3570646	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Холмская
207	1	Зеркало	Достопримечательность	44.7424581	38.3511015	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Холмская
206	1	Дольмен	Достопримечательность	44.7399985	38.3689248	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Холмская
233	1	Каменные Грибы	Достопримечательность	44.7434418	38.3494566	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Холмская
212	1	Дольмен	Достопримечательность	44.7266405	38.2909206	summer	92	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Ахтырский
137	1	Берёзка	Кафе	45.2371449	38.9744153	summer	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Новотитаровская
136	1	Пицерия "Сеньора"	Кафе	45.2367197	38.9724153	summer	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Новотитаровская
5	1	Пенальти	Ресторан	45.2268225	38.999498	summer	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Новотитаровская
243	1	Роснефть	Автозаправочная станция	45.2432674	38.9434439	summer	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Новотитаровская
267	1	Нефть России	Автозаправочная станция	44.4994285	40.1601798	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:14:13.709934+00	Апшеронск
264	1	Лукойл	Автозаправочная станция	44.4863708	39.7194663	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Апшеронск
240	1	Лукойл	Автозаправочная станция	46.4202519	41.4649389	summer	100	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Белая Глина
239	1	Газпром	Автозаправочная станция	46.0650311	40.8802951	summer	100	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Белая Глина
479	1	Шумринка	Винодельня	44.8509508	37.4425334	autumn	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Анапская
478	1	Усадьба-винодельня Кантина	Винодельня	44.8661441	37.4627079	autumn	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Анапская
449	1	Водопад	Водопад	44.7481218	37.407392	spring	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Анапская
253	1	Роснефть	Автозаправочная станция	44.898448	37.449008	summer	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Анапская
252	1	Роснефть	Автозаправочная станция	44.8994488	37.3914293	summer	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Анапская
135	1	Хычины	Кафе	43.5629048	41.280706	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Псебай
516	1	Кемпинг	Кемпинг / Глэмпинг	43.8039459	40.6448014	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Псебай
514	1	сгоревший дом	Кемпинг / Глэмпинг	43.9582855	40.6602971	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Псебай
470	1	Водопад	Водопад	43.9598149	40.7301726	spring	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Псебай
460	1	Водопад	Водопад	43.9666886	40.6871112	spring	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Псебай
411	1	Место для пикника	Место для пикника	43.6577427	41.3978504	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Псебай
384	1	Блыбский перевал	Смотровая площадка	43.793943	40.76995	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Псебай
378	1	Казанка	Смотровая площадка	43.6500763	41.431868	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Псебай
191	1	Лев	Достопримечательность	44.3825337	38.6285025	summer	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Архипо-Осиповка
190	1	грот Высоцкого	Достопримечательность	44.3822245	38.6281959	summer	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Архипо-Осиповка
189	1	Шнурок	Достопримечательность	44.3811323	38.6285303	summer	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Архипо-Осиповка
146	1	«Пирожковое»	Кафе	44.3707819	38.533421	summer	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Архипо-Осиповка
483	1	Винодельня Криница	Винодельня	44.3938256	38.3399476	autumn	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Архипо-Осиповка
452	1	Лев	Водопад	44.3825337	38.6285025	spring	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Архипо-Осиповка
451	1	грот Высоцкого	Водопад	44.3822245	38.6281959	spring	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Архипо-Осиповка
450	1	Шнурок	Водопад	44.3811323	38.6285303	spring	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Архипо-Осиповка
434	1	BLAGO BEACH	Пляж	44.2044193	38.8619088	summer	108	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Новомихайловский
204	1	Каскадный	Достопримечательность	44.2645993	40.1744427	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Нефтегорск
203	1	Девичья Коса	Достопримечательность	44.2631851	40.1721199	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Нефтегорск
469	1	Каскадный	Водопад	44.2645993	40.1744427	spring	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Нефтегорск
468	1	Девичья Коса	Водопад	44.2631851	40.1721199	spring	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Нефтегорск
446	1	Пляж Тропическая лагуна	Пляж	44.2846941	40.1756472	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Нефтегорск
425	1	Пляж	Пляж	44.2973407	40.174842	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Нефтегорск
388	1	Столик	Место для пикника	44.3777519	39.7522621	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Нефтегорск
363	1	Смотровая площадка	Смотровая площадка	44.2874129	40.1742812	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Нефтегорск
175	1	Тихий омут	Кафе	46.320264	39.3980275	summer	111	Набережная улица, Ленинградская	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Ленинградская
174	1	Курьер	Кафе	46.3259434	39.378533	summer	111	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Ленинградская
173	1	Белая Русь	Кафе	46.3234872	39.3969259	summer	111	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Ленинградская
323	1	Уют	Гостиница	46.3230196	39.3959562	summer	111	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:54:06.346003+00	2026-03-21 21:13:50.079053+00	Ленинградская
276	1	Музей	Музей	46.3230229	39.3973224	summer	111	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Ленинградская
283	1	сельский музей	Музей	45.5660332	40.9075156	summer	118	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Кавказская
299	1	Музей конного завода "Восход"	Музей	45.2334679	40.9743277	summer	120	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Новокубанск
67	1	Венец	Ресторан	45.3534373	40.6947081	summer	121	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Гулькевичи
186	1	Турецкий фонтан	Достопримечательность	45.2109988	36.7291095	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Тамань
69	1	Экзотик	Ресторан	45.3900742	36.6295289	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Тамань
47	1	Спортбар	Ресторан	45.2139606	36.7188345	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Тамань
519	1	Кемпинг	Кемпинг / Глэмпинг	45.4381336	36.8883865	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Тамань
442	1	Кизилташ	Пляж	45.1079539	36.8896176	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Тамань
412	1	Место для пикника	Место для пикника	45.3640528	36.5009967	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Тамань
355	1	Смотровая площадка	Смотровая площадка	45.1616601	36.6213979	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Тамань
291	1	Лапидарий	Музей	45.3637205	36.5318069	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Тамань
285	1	Краеведческий музей	Музей	45.2186872	36.722671	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Тамань
279	1	Музей обороны Аджимушкайских каменоломен	Музей	45.3810588	36.5234884	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Тамань
278	1	Дом-музей М.Ю. Лермонтова	Музей	45.2180072	36.7253798	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Тамань
277	1	Археологический музей	Музей	45.2171508	36.7225406	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Тамань
200	1	Лотосы	Достопримечательность	45.0806447	38.7006688	summer	124	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Марьянская
423	1	Пляж	Пляж	45.0622637	38.6587761	summer	124	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Марьянская
244	1	Не работает	Автозаправочная станция	46.3284379	39.7917186	summer	125	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Октябрьская
415	1	Карьер сосны	Место для пикника	45.3825542	40.6044251	summer	126	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Красносельский
414	1	Ореховая роща	Место для пикника	45.3824749	40.6049571	summer	126	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:25.44371+00	2026-03-21 21:13:50.079053+00	Красносельский
65	1	Кальвадос	Ресторан	45.4343774	40.5902992	summer	132	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Кропоткин
262	1	Petrol	Автозаправочная станция	44.8976496	39.1654318	summer	134	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Старокорсунская
261	1	Орснефть	Автозаправочная станция	44.8845097	39.1759388	summer	134	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Старокорсунская
260	1	S-oil	Автозаправочная станция	44.8581095	39.1978211	summer	134	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Старокорсунская
431	1	нудистский пляж	Пляж	44.5244766	39.482409	summer	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Хадыженск
245	1	Лукойл	Автозаправочная станция	44.4346936	39.5137883	summer	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:52:51.120928+00	2026-03-21 21:13:50.079053+00	Хадыженск
493	1	Винодельня LETO	Винодельня	45.0732822	37.4463748	autumn	139	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:55.736686+00	2026-03-21 21:13:50.079053+00	Гостагаевская
287	1	Краеведческий музей	Музей	45.1146559	37.4074716	summer	139	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:53:16.972932+00	2026-03-21 21:13:50.079053+00	Гостагаевская
152	1	Кафе	Кафе	45.261703	38.4488921	summer	141	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Ивановская
86	1	Флагман	Ресторан	45.2984654	41.4976909	summer	142	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Старая Станица
78	1	Трикони	Ресторан	43.6829178	40.2147675	summer	143	\N	+7 918 0011974	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Красная Поляна
61	1	Водолей	Ресторан	43.6747067	40.2857435	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Красная Поляна
517	1	Кемпинг	Кемпинг / Глэмпинг	43.8309808	40.5803242	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Красная Поляна
495	1	Кемпинг	Кемпинг / Глэмпинг	43.5849754	40.6472348	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:02:46.329703+00	2026-03-21 21:13:50.079053+00	Красная Поляна
459	1	Верхний Имеретинский	Водопад	43.63625	40.7364767	spring	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:44.609275+00	2026-03-21 21:13:50.079053+00	Красная Поляна
374	1	Озерный	Смотровая площадка	43.5594805	40.6550452	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Красная Поляна
373	1	Кутехеку 2	Смотровая площадка	43.549472	40.6318553	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Красная Поляна
372	1	Квата	Смотровая площадка	43.542029	40.7168326	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:16.771534+00	2026-03-21 21:13:50.079053+00	Красная Поляна
227	1	Красная Поляна	Достопримечательность	43.6677608	40.1860526	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:19.652906+00	2026-03-21 21:14:13.709934+00	Красная Поляна
149	1	Арбат	Кафе	45.3445825	38.2098485	summer	144	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Полтавская
145	1	Оазис	Кафе	45.3671007	38.2127138	summer	144	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:51:00.39959+00	2026-03-21 21:14:13.709934+00	Полтавская
13	1	Кафе молодежное	Ресторан	45.3690397	38.2126917	summer	144	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 20:50:42.568619+00	2026-03-21 21:14:13.709934+00	Полтавская
444	1	Хоста Марина	Пляж	43.5031997	39.8727412	summer	145	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-21 21:01:31.879+00	2026-03-21 21:13:50.079053+00	Сириус
\.


--
-- Data for Name: prompt_composition_items; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.prompt_composition_items (composition_id, template_id, "position") FROM stdin;
\.


--
-- Data for Name: prompt_compositions; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.prompt_compositions (id, name, scenario, created_at) FROM stdin;
\.


--
-- Data for Name: prompt_logs; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.prompt_logs (id, route_id, composition_id, template_ids, assembled_prompt, llm_response, model, tokens_in, tokens_out, latency_ms, created_at) FROM stdin;
\.


--
-- Data for Name: prompt_templates; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.prompt_templates (id, slug, category, scenario, transport_context, weather_context, group_context, template_text, priority, is_active, version, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.reports (id, reporter_id, target_type, target_id, reason, status, created_at) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.reviews (id, author_id, post_id, rating, comment, media_urls, created_at) FROM stdin;
\.


--
-- Data for Name: route_pins; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.route_pins (id, route_id, segment_id, segment_item_id, label, pin_type, lat, lng, icon, color, "position", zoom_level, is_visible, source, is_persistent, created_by, notes, created_at) FROM stdin;
\.


--
-- Data for Name: route_segments; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.route_segments (id, route_id, "position", city_id, title, description, narrative, date_from, date_to, photos, created_at) FROM stdin;
1	1	0	2	Через перевал Аишха к Черному морю	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
2	2	0	2	Дорога к зоне	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
3	3	0	2	Тропа к водопаду	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
4	4	0	2	Тропа к водопаду	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
5	5	0	2	Малое кольцо	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
6	6	0	2	Большое кольцо	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
7	7	0	2	30-ка	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
8	8	0	2	Через Фишт-Оштеновский перевал	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
9	9	0	2	Через водопадный	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
10	10	0	2	каньон	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
11	11	0	2	Тропа здоровья Малое кольцо	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
12	12	0	2	Тропа здоровья Большое и среднее кольцо	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
13	13	0	2	водопад Кейву	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
14	14	0	2	Тропа здоровья	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
15	15	0	2	Урочище Медвежьи ворота – Бзерпинский карниз - Лагерь Холодный	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
16	16	0	2	Реликтовый лес	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
17	17	0	2	Каверзинские водопады	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
18	18	0	2	Индюк тропа.	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
19	19	0	2	Дантово ущелье - гора Сапун	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
20	20	0	2	Вододопады на Мальцевом ручье	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
21	21	0	2	Тропа здоровья	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
22	22	0	2	Бор-дол	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
23	23	0	2	тропа	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
24	24	0	2	Харгинский лес	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
25	25	0	2	Водопад Поликаря	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
26	26	0	2	Тропа здоровья	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
27	27	0	2	Путь к водопадам	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
28	28	0	2	Каменный столб	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
29	29	0	2	Юрьев Хутор	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
30	30	0	2	Озёрный траверс	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
31	31	0	2	10 памятников ВОВ	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
32	32	0	2	к Купели	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
33	33	0	2	К Ачипсинским водопадам	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
34	34	0	2	Черничная тропа	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
35	35	0	2	Альпийские луга	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
36	36	0	2	Два водопада	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
37	37	0	2	Черная пирамида	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
38	38	0	2	Перевал Седой	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
39	39	0	2	Перевал Аибга	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
40	40	0	2	Два Озера	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
41	41	0	2	Беседка любви	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
42	42	0	2	От снежников к Водопадам "Менделиха"	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
43	43	0	2	Урочище Энгельмановы поляны – озеро Кардывач	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
44	44	0	2	Воопад Хрустальный	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
45	45	0	2	Хмелевские озера + 2 смотровых площадки	\N	\N	\N	\N	\N	2026-03-21 20:58:39.442378+00
46	46	0	2	Ресторан + Кафе + Автозаправочная станция near Ресторан	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
47	47	0	2	Ресторан + Автозаправочная станция + Гостиница near Старина Герман	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
48	48	0	2	Ресторан + Кафе + Автозаправочная станция near Пенальти	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
49	49	0	2	Ресторан + Кафе near Сербский ресторан	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
50	50	0	2	Ресторан + Кафе + Гостиница near Пивница	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
51	51	0	2	Ресторан + Гостиница near Версаль	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
52	52	0	2	Ресторан + Кафе near Мадьяр	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
53	53	0	2	Ресторан + Достопримечательность + Гостиница near Казачок	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
54	54	0	2	Ресторан + Кафе near Кафе молодежное	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
55	55	0	2	Ресторан + Кафе near Big Bull	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
56	56	0	2	Ресторан + Кафе near Променад	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
57	57	0	2	Ресторан + Музей + Кафе near Оливье	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
58	58	0	2	Ресторан + Гостиница near Федина дача	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
59	59	0	2	Ресторан + Кафе near Катюша	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
60	60	0	2	Ресторан + Гостиница + Кафе near «Ё-Моё»	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
61	61	0	2	Ресторан + Кафе near Amsterdam Bar	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
62	62	0	2	Ресторан + Кафе near Прохлада	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
63	63	0	2	Ресторан + Кафе near Аурум	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
64	64	0	2	Ресторан + Гостиница + Кафе near Cinema	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
65	65	0	2	Ресторан + Кафе near Фидан	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
66	66	0	2	Ресторан + Музей + Кафе near Алекс	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
67	67	0	2	Ресторан + Кафе near Прайд	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
68	68	0	2	Ресторан + Музей + Кафе near Малый Ахун	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
69	69	0	2	Ресторан near Чайка	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
70	70	0	2	Ресторан + Кафе near Духанъ	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
71	71	0	2	Ресторан + Гостиница + Кафе near Калинка	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
72	72	0	2	Ресторан + Музей + Достопримечательность near Спортбар	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
73	73	0	2	Ресторан + Кафе + Достопримечательность near Грац	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
74	74	0	2	Ресторан + Кафе + Гостиница near Баден-Баден	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
75	75	0	2	Ресторан + Кафе near Суши-бар "Минами"	\N	\N	\N	\N	\N	2026-03-21 20:58:39.672952+00
76	77	0	\N	Маршрут couple	\N	\N	\N	\N	\N	2026-03-21 22:23:35.487601+00
77	78	0	\N	Маршрут couple	\N	\N	\N	\N	\N	2026-03-21 22:32:41.652374+00
78	79	0	\N	Маршрут couple	\N	\N	\N	\N	\N	2026-03-21 22:38:23.293983+00
79	80	0	\N	Маршрут couple	\N	\N	\N	\N	\N	2026-03-21 23:05:49.459884+00
80	81	0	\N	Маршрут couple	\N	\N	\N	\N	\N	2026-03-21 23:09:28.310372+00
81	82	0	\N	Маршрут couple	\N	\N	\N	\N	\N	2026-03-21 23:10:16.939097+00
82	86	0	\N	День 1	\N	\N	2026-04-15	2026-04-15	\N	2026-03-21 23:14:52.031907+00
83	86	1	\N	День 2	\N	\N	2026-04-16	2026-04-16	\N	2026-03-21 23:14:52.031907+00
84	86	2	\N	День 3	\N	\N	2026-04-17	2026-04-17	\N	2026-03-21 23:14:52.031907+00
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.routes (id, author_id, title, description, cover_url, narrative, total_days, total_price, total_price_status, total_experiences, total_hotels, total_transports, share_token, params, status, created_at, updated_at) FROM stdin;
2	1	Дорога к зоне	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=2	\N	1	\N	fresh	0	0	0	osm-1842873	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
26	1	Тропа здоровья	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=26	\N	1	\N	fresh	0	0	0	osm-13030392	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
27	1	Путь к водопадам	foot, 7.1 km	https://loremflickr.com/1200/600/travel,road,journey?random=27	\N	1	\N	fresh	0	0	0	osm-13232467	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
28	1	Каменный столб	foot, 4.4 km	https://loremflickr.com/1200/600/travel,road,journey?random=28	\N	1	\N	fresh	0	0	0	osm-13232468	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
29	1	Юрьев Хутор	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=29	\N	1	\N	fresh	0	0	0	osm-13232469	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
30	1	Озёрный траверс	foot, 6.7 km	https://loremflickr.com/1200/600/travel,road,journey?random=30	\N	1	\N	fresh	0	0	0	osm-13232470	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
31	1	10 памятников ВОВ	hiking, 12.3 km	https://loremflickr.com/1200/600/travel,road,journey?random=31	\N	1	\N	fresh	0	0	0	osm-14270035	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
32	1	к Купели	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=32	\N	1	\N	fresh	0	0	0	osm-14376203	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
33	1	К Ачипсинским водопадам	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=33	\N	1	\N	fresh	0	0	0	osm-14376257	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
34	1	Черничная тропа	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=34	\N	1	\N	fresh	0	0	0	osm-14376382	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
35	1	Альпийские луга	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=35	\N	1	\N	fresh	0	0	0	osm-14376417	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
36	1	Два водопада	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=36	\N	1	\N	fresh	0	0	0	osm-14376574	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
37	1	Черная пирамида	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=37	\N	1	\N	fresh	0	0	0	osm-14376588	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
38	1	Перевал Седой	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=38	\N	1	\N	fresh	0	0	0	osm-14376599	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
39	1	Перевал Аибга	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=39	\N	1	\N	fresh	0	0	0	osm-14376615	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
40	1	Два Озера	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=40	\N	1	\N	fresh	0	0	0	osm-14376633	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
41	1	Беседка любви	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=41	\N	1	\N	fresh	0	0	0	osm-14376657	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
42	1	От снежников к Водопадам "Менделиха"	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=42	\N	1	\N	fresh	0	0	0	osm-14376701	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
43	1	Урочище Энгельмановы поляны – озеро Кардывач	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=43	\N	1	\N	fresh	0	0	0	osm-14376817	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
44	1	Воопад Хрустальный	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=44	\N	1	\N	fresh	0	0	0	osm-14378644	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
45	1	Хмелевские озера + 2 смотровых площадки	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=45	\N	1	\N	fresh	0	0	0	osm-14378669	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
46	1	Ресторан + Кафе + Автозаправочная станция near Ресторан	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=46	\N	1	\N	fresh	0	0	0	auto-2	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
47	1	Ресторан + Автозаправочная станция + Гостиница near Старина Герман	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=47	\N	1	\N	fresh	0	0	0	auto-3	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
48	1	Ресторан + Кафе + Автозаправочная станция near Пенальти	4 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=48	\N	1	\N	fresh	0	0	0	auto-5	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
49	1	Ресторан + Кафе near Сербский ресторан	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=49	\N	1	\N	fresh	0	0	0	auto-6	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
50	1	Ресторан + Кафе + Гостиница near Пивница	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=50	\N	1	\N	fresh	0	0	0	auto-7	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
51	1	Ресторан + Гостиница near Версаль	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=51	\N	1	\N	fresh	0	0	0	auto-8	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
52	1	Ресторан + Кафе near Мадьяр	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=52	\N	1	\N	fresh	0	0	0	auto-10	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
53	1	Ресторан + Достопримечательность + Гостиница near Казачок	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=53	\N	1	\N	fresh	0	0	0	auto-12	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
54	1	Ресторан + Кафе near Кафе молодежное	3 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=54	\N	1	\N	fresh	0	0	0	auto-13	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
55	1	Ресторан + Кафе near Big Bull	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=55	\N	1	\N	fresh	0	0	0	auto-14	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
56	1	Ресторан + Кафе near Променад	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=56	\N	1	\N	fresh	0	0	0	auto-15	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
57	1	Ресторан + Музей + Кафе near Оливье	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=57	\N	1	\N	fresh	0	0	0	auto-17	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
58	1	Ресторан + Гостиница near Федина дача	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=58	\N	1	\N	fresh	0	0	0	auto-18	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
59	1	Ресторан + Кафе near Катюша	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=59	\N	1	\N	fresh	0	0	0	auto-20	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
60	1	Ресторан + Гостиница + Кафе near «Ё-Моё»	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=60	\N	1	\N	fresh	0	0	0	auto-21	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
61	1	Ресторан + Кафе near Amsterdam Bar	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=61	\N	1	\N	fresh	0	0	0	auto-22	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
62	1	Ресторан + Кафе near Прохлада	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=62	\N	1	\N	fresh	0	0	0	auto-26	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
63	1	Ресторан + Кафе near Аурум	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=63	\N	1	\N	fresh	0	0	0	auto-27	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
64	1	Ресторан + Гостиница + Кафе near Cinema	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=64	\N	1	\N	fresh	0	0	0	auto-28	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
65	1	Ресторан + Кафе near Фидан	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=65	\N	1	\N	fresh	0	0	0	auto-30	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
66	1	Ресторан + Музей + Кафе near Алекс	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=66	\N	1	\N	fresh	0	0	0	auto-31	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
67	1	Ресторан + Кафе near Прайд	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=67	\N	1	\N	fresh	0	0	0	auto-33	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
68	1	Ресторан + Музей + Кафе near Малый Ахун	3 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=68	\N	1	\N	fresh	0	0	0	auto-39	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
69	1	Ресторан near Чайка	3 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=69	\N	1	\N	fresh	0	0	0	auto-42	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
70	1	Ресторан + Кафе near Духанъ	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=70	\N	1	\N	fresh	0	0	0	auto-43	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
71	1	Ресторан + Гостиница + Кафе near Калинка	3 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=71	\N	1	\N	fresh	0	0	0	auto-46	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
72	1	Ресторан + Музей + Достопримечательность near Спортбар	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=72	\N	1	\N	fresh	0	0	0	auto-47	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
73	1	Ресторан + Кафе + Достопримечательность near Грац	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=73	\N	1	\N	fresh	0	0	0	auto-48	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
74	1	Ресторан + Кафе + Гостиница near Баден-Баден	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=74	\N	1	\N	fresh	0	0	0	auto-51	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
75	1	Ресторан + Кафе near Суши-бар "Минами"	5 spots within 5km	https://loremflickr.com/1200/600/travel,road,journey?random=75	\N	1	\N	fresh	0	0	0	auto-53	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-22 00:37:18.062604+00
76	2	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=76	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 22:22:26.137707+00	2026-03-22 00:37:18.062604+00
77	2	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=77	Маршрут для solo по 5 точкам.\nПогода: Переменная облачность, 9.7°C.\n1. Mocco: Кафе\n2. Усадьба-винодельня Кантина: Винодельня\n3. Шумринка: Винодельня\n4. Шато Ле Гран Восток: Винодельня\n5. Раевское: Винодельня	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "weather": {"time": "2026-03-22T01:15", "weather": "Переменная облачность", "windspeed": 3.8, "temperature": 9.7, "weathercode": 2, "winddirection": 49}, "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	ready	2026-03-21 22:23:35.419471+00	2026-03-22 00:37:18.062604+00
78	2	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=78	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Переменная облачность, 9.7°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}]}	ready	2026-03-21 22:32:41.597564+00	2026-03-22 00:37:18.062604+00
79	2	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=79	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Переменная облачность, 9.7°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}]}	ready	2026-03-21 22:38:23.241927+00	2026-03-22 00:37:18.062604+00
80	2	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=80	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Преимущественно ясно, 9.9°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}]}	ready	2026-03-21 23:05:49.410342+00	2026-03-22 00:37:18.062604+00
5	1	Малое кольцо	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=5	\N	1	\N	fresh	0	0	0	osm-3748147	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
6	1	Большое кольцо	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=6	\N	1	\N	fresh	0	0	0	osm-3748250	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
1	1	Через перевал Аишха к Черному морю	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=1	\N	1	\N	fresh	0	0	0	osm-1474673	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
3	1	Тропа к водопаду	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=3	\N	1	\N	fresh	0	0	0	osm-1842953	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
4	1	Тропа к водопаду	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=4	\N	1	\N	fresh	0	0	0	osm-1842954	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
7	1	30-ка	hiking, 93 km	https://loremflickr.com/1200/600/travel,road,journey?random=7	\N	1	\N	fresh	0	0	0	osm-4509282	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
8	1	Через Фишт-Оштеновский перевал	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=8	\N	1	\N	fresh	0	0	0	osm-4509283	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
9	1	Через водопадный	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=9	\N	1	\N	fresh	0	0	0	osm-4509285	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
10	1	каньон	foot	https://loremflickr.com/1200/600/travel,road,journey?random=10	\N	1	\N	fresh	0	0	0	osm-7400123	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
11	1	Тропа здоровья Малое кольцо	foot	https://loremflickr.com/1200/600/travel,road,journey?random=11	\N	1	\N	fresh	0	0	0	osm-9403239	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
12	1	Тропа здоровья Большое и среднее кольцо	foot	https://loremflickr.com/1200/600/travel,road,journey?random=12	\N	1	\N	fresh	0	0	0	osm-9403246	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
13	1	водопад Кейву	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=13	\N	1	\N	fresh	0	0	0	osm-10626407	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
14	1	Тропа здоровья	foot	https://loremflickr.com/1200/600/travel,road,journey?random=14	\N	1	\N	fresh	0	0	0	osm-10928641	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
15	1	Урочище Медвежьи ворота – Бзерпинский карниз - Лагерь Холодный	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=15	\N	1	\N	fresh	0	0	0	osm-11566519	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
16	1	Реликтовый лес	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=16	\N	1	\N	fresh	0	0	0	osm-11681960	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
17	1	Каверзинские водопады	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=17	\N	1	\N	fresh	0	0	0	osm-12328003	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
18	1	Индюк тропа.	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=18	\N	1	\N	fresh	0	0	0	osm-12350723	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
19	1	Дантово ущелье - гора Сапун	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=19	\N	1	\N	fresh	0	0	0	osm-12404970	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
20	1	Вододопады на Мальцевом ручье	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=20	\N	1	\N	fresh	0	0	0	osm-12404988	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
21	1	Тропа здоровья	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=21	\N	1	\N	fresh	0	0	0	osm-12406143	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
22	1	Бор-дол	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=22	\N	1	\N	fresh	0	0	0	osm-13014211	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
23	1	тропа	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=23	\N	1	\N	fresh	0	0	0	osm-13014212	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
24	1	Харгинский лес	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=24	\N	1	\N	fresh	0	0	0	osm-13021062	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
25	1	Водопад Поликаря	hiking	https://loremflickr.com/1200/600/travel,road,journey?random=25	\N	1	\N	fresh	0	0	0	osm-13025082	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-22 00:37:18.062604+00
81	5	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=81	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Преимущественно ясно, 9.9°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}]}	ready	2026-03-21 23:09:28.29761+00	2026-03-22 00:37:18.062604+00
82	6	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=82	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Преимущественно ясно, 9.9°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}]}	ready	2026-03-21 23:10:16.925514+00	2026-03-22 00:37:18.062604+00
83	7	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=83	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 23:11:06.108409+00	2026-03-22 00:37:18.062604+00
84	8	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=84	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 23:11:49.295217+00	2026-03-22 00:37:18.062604+00
85	9	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=85	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 23:13:43.578494+00	2026-03-22 00:37:18.062604+00
86	10	Маршрут couple	\N	https://loremflickr.com/1200/600/travel,road,journey?random=86	Маршрут для couple, 12 точек, 77.9 км.\nПогода: Переменная облачность, 7.8°C.\n\n1. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n2. Шумринка — Винодельня (→ 10.8 км, ~11 мин)\n3. Абрау-Дюрсо — Винодельня\n4. \n5. \n6. \n7. Шумринка — Винодельня\n8. Fanagoria — Винодельня (→ 11.6 км, ~12 мин)\n9. Винодельня Бердяева — Винодельня (→ 14.6 км, ~15 мин)\n10. Винодельня LETO — Винодельня (→ 20.8 км, ~21 мин)\n11. Раевское — Винодельня (→ 17.8 км, ~18 мин)\n12. Шато Ле Гран Восток — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	3	\N	fresh	9	3	1	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Переменная облачность", "windspeed": 19.6, "temperature": 7.8, "weathercode": 2, "winddirection": 84}, "dateFrom": "2026-04-15", "total_km": 77.9, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 10.8, "duration_to_next_min": 11}, {"lat": 44.8770928, "lng": 37.3111542, "name": "Абрау-Дюрсо", "description": "Винодельня", "distance_to_next_km": 0.0, "duration_to_next_min": 0}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": 44.877187, "lng": 37.3110563, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 0.0, "duration_to_next_min": 0}, {"lat": 44.8773243, "lng": 37.3109261, "name": "Fanagoria", "description": "Винодельня", "distance_to_next_km": 11.6, "duration_to_next_min": 12}, {"lat": 44.981751, "lng": 37.3125481, "name": "Винодельня Бердяева", "description": "Винодельня", "distance_to_next_km": 14.6, "duration_to_next_min": 15}, {"lat": 45.0732822, "lng": 37.4463748, "name": "Винодельня LETO", "description": "Винодельня", "distance_to_next_km": 20.8, "duration_to_next_min": 21}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 77.9, "weather": {"time": "2026-03-22T02:00", "weather": "Переменная облачность", "windspeed": 19.6, "temperature": 7.8, "weathercode": 2, "winddirection": 84}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}], "recommendations": [{"type": "food", "options": [{"lat": 44.978699, "lng": 37.271429, "name": "Столовая", "type": "Ресторан", "post_id": 79, "distance_km": 3.3}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}, {"type": "fuel", "options": [{"lat": 44.9105977, "lng": 37.3285363, "name": "Роснефть", "post_id": 251, "distance_km": 4.0}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}]}	ready	2026-03-21 23:14:51.966681+00	2026-03-22 00:37:18.062604+00
\.


--
-- Data for Name: segment_items; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.segment_items (id, segment_id, parent_id, type, "position", price, price_currency, price_original, price_fetched_at, price_status, provider_name, provider_url, ai_comment, details, created_at) FROM stdin;
1	1	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0440\\\\u0435\\\\u0437 \\\\u043f\\\\u0435\\\\u0440\\\\u0435\\\\u0432\\\\u0430\\\\u043b \\\\u0410\\\\u0438\\\\u0448\\\\u0445\\\\u0430 \\\\u043a \\\\u0427\\\\u0435\\\\u0440\\\\u043d\\\\u043e\\\\u043c\\\\u0443 \\\\u043c\\\\u043e\\\\u0440\\\\u044e\\", \\"lat\\": 43.7893617, \\"lng\\": 40.5579139}"	2026-03-21 20:58:39.442378+00
2	2	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u043e\\\\u0440\\\\u043e\\\\u0433\\\\u0430 \\\\u043a \\\\u0437\\\\u043e\\\\u043d\\\\u0435\\", \\"lat\\": 44.5735754, \\"lng\\": 38.4227033}"	2026-03-21 20:58:39.442378+00
3	3	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u043a \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u0443\\", \\"lat\\": 44.5846268, \\"lng\\": 38.282095}"	2026-03-21 20:58:39.442378+00
4	4	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u043a \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u0443\\", \\"lat\\": 44.5846268, \\"lng\\": 38.282095}"	2026-03-21 20:58:39.442378+00
5	5	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u0430\\\\u043b\\\\u043e\\\\u0435 \\\\u043a\\\\u043e\\\\u043b\\\\u044c\\\\u0446\\\\u043e\\", \\"lat\\": 43.5302751, \\"lng\\": 39.8758341}"	2026-03-21 20:58:39.442378+00
6	6	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u043e\\\\u043b\\\\u044c\\\\u0448\\\\u043e\\\\u0435 \\\\u043a\\\\u043e\\\\u043b\\\\u044c\\\\u0446\\\\u043e\\", \\"lat\\": 43.5342076, \\"lng\\": 39.8785149}"	2026-03-21 20:58:39.442378+00
7	7	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"30-\\\\u043a\\\\u0430\\", \\"lat\\": 43.9395523, \\"lng\\": 39.8519237}"	2026-03-21 20:58:39.442378+00
8	8	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0440\\\\u0435\\\\u0437 \\\\u0424\\\\u0438\\\\u0448\\\\u0442-\\\\u041e\\\\u0448\\\\u0442\\\\u0435\\\\u043d\\\\u043e\\\\u0432\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u043f\\\\u0435\\\\u0440\\\\u0435\\\\u0432\\\\u0430\\\\u043b\\", \\"lat\\": 43.985507, \\"lng\\": 39.9156881}"	2026-03-21 20:58:39.442378+00
9	9	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0440\\\\u0435\\\\u0437 \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u043d\\\\u044b\\\\u0439\\", \\"lat\\": 43.9815604, \\"lng\\": 39.9167068}"	2026-03-21 20:58:39.442378+00
10	10	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u043a\\\\u0430\\\\u043d\\\\u044c\\\\u043e\\\\u043d\\", \\"lat\\": 43.54557, \\"lng\\": 39.9311999}"	2026-03-21 20:58:39.442378+00
11	11	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u0437\\\\u0434\\\\u043e\\\\u0440\\\\u043e\\\\u0432\\\\u044c\\\\u044f \\\\u041c\\\\u0430\\\\u043b\\\\u043e\\\\u0435 \\\\u043a\\\\u043e\\\\u043b\\\\u044c\\\\u0446\\\\u043e\\", \\"lat\\": 43.6742177, \\"lng\\": 40.3002969}"	2026-03-21 20:58:39.442378+00
12	12	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u0437\\\\u0434\\\\u043e\\\\u0440\\\\u043e\\\\u0432\\\\u044c\\\\u044f \\\\u0411\\\\u043e\\\\u043b\\\\u044c\\\\u0448\\\\u043e\\\\u0435 \\\\u0438 \\\\u0441\\\\u0440\\\\u0435\\\\u0434\\\\u043d\\\\u0435\\\\u0435 \\\\u043a\\\\u043e\\\\u043b\\\\u044c\\\\u0446\\\\u043e\\", \\"lat\\": 43.6760627, \\"lng\\": 40.3015429}"	2026-03-21 20:58:39.442378+00
13	13	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434 \\\\u041a\\\\u0435\\\\u0439\\\\u0432\\\\u0443\\", \\"lat\\": 43.6936533, \\"lng\\": 40.2240908}"	2026-03-21 20:58:39.442378+00
14	14	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u0437\\\\u0434\\\\u043e\\\\u0440\\\\u043e\\\\u0432\\\\u044c\\\\u044f\\", \\"lat\\": 43.5539171, \\"lng\\": 39.77106}"	2026-03-21 20:58:39.442378+00
15	15	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0440\\\\u043e\\\\u0447\\\\u0438\\\\u0449\\\\u0435 \\\\u041c\\\\u0435\\\\u0434\\\\u0432\\\\u0435\\\\u0436\\\\u044c\\\\u0438 \\\\u0432\\\\u043e\\\\u0440\\\\u043e\\\\u0442\\\\u0430 \\\\u2013 \\\\u0411\\\\u0437\\\\u0435\\\\u0440\\\\u043f\\\\u0438\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u043a\\\\u0430\\\\u0440\\\\u043d\\\\u0438\\\\u0437 - \\\\u041b\\\\u0430\\\\u0433\\\\u0435\\\\u0440\\\\u044c \\\\u0425\\\\u043e\\\\u043b\\\\u043e\\\\u0434\\\\u043d\\\\u044b\\\\u0439\\", \\"lat\\": 43.7287024, \\"lng\\": 40.3941767}"	2026-03-21 20:58:39.442378+00
16	16	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0435\\\\u043b\\\\u0438\\\\u043a\\\\u0442\\\\u043e\\\\u0432\\\\u044b\\\\u0439 \\\\u043b\\\\u0435\\\\u0441\\", \\"lat\\": 43.6589684, \\"lng\\": 40.2527202}"	2026-03-21 20:58:39.442378+00
17	17	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0432\\\\u0435\\\\u0440\\\\u0437\\\\u0438\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u0435 \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u044b\\", \\"lat\\": 44.5210974, \\"lng\\": 38.9599087}"	2026-03-21 20:58:39.442378+00
18	18	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0418\\\\u043d\\\\u0434\\\\u044e\\\\u043a \\\\u0442\\\\u0440\\\\u043e\\\\u043f\\\\u0430.\\", \\"lat\\": 44.2487338, \\"lng\\": 39.260864}"	2026-03-21 20:58:39.442378+00
19	19	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u0430\\\\u043d\\\\u0442\\\\u043e\\\\u0432\\\\u043e \\\\u0443\\\\u0449\\\\u0435\\\\u043b\\\\u044c\\\\u0435 - \\\\u0433\\\\u043e\\\\u0440\\\\u0430 \\\\u0421\\\\u0430\\\\u043f\\\\u0443\\\\u043d\\", \\"lat\\": 44.608689, \\"lng\\": 39.0998604}"	2026-03-21 20:58:39.442378+00
20	20	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u0434\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u044b \\\\u043d\\\\u0430 \\\\u041c\\\\u0430\\\\u043b\\\\u044c\\\\u0446\\\\u0435\\\\u0432\\\\u043e\\\\u043c \\\\u0440\\\\u0443\\\\u0447\\\\u044c\\\\u0435\\", \\"lat\\": 44.6046097, \\"lng\\": 39.1188056}"	2026-03-21 20:58:39.442378+00
21	21	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u0437\\\\u0434\\\\u043e\\\\u0440\\\\u043e\\\\u0432\\\\u044c\\\\u044f\\", \\"lat\\": 44.6029087, \\"lng\\": 39.1075765}"	2026-03-21 20:58:39.442378+00
22	22	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u043e\\\\u0440-\\\\u0434\\\\u043e\\\\u043b\\", \\"lat\\": 44.7490885, \\"lng\\": 37.663859}"	2026-03-21 20:58:39.442378+00
23	23	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0442\\\\u0440\\\\u043e\\\\u043f\\\\u0430\\", \\"lat\\": 44.7813763, \\"lng\\": 37.6644249}"	2026-03-21 20:58:39.442378+00
24	24	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0425\\\\u0430\\\\u0440\\\\u0433\\\\u0438\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u043b\\\\u0435\\\\u0441\\", \\"lat\\": 43.6298987, \\"lng\\": 40.3518045}"	2026-03-21 20:58:39.442378+00
25	25	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434 \\\\u041f\\\\u043e\\\\u043b\\\\u0438\\\\u043a\\\\u0430\\\\u0440\\\\u044f\\", \\"lat\\": 43.6546228, \\"lng\\": 40.270117}"	2026-03-21 20:58:39.442378+00
26	26	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0440\\\\u043e\\\\u043f\\\\u0430 \\\\u0437\\\\u0434\\\\u043e\\\\u0440\\\\u043e\\\\u0432\\\\u044c\\\\u044f\\", \\"lat\\": 43.6670564, \\"lng\\": 40.2622271}"	2026-03-21 20:58:39.442378+00
27	27	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0443\\\\u0442\\\\u044c \\\\u043a \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u0430\\\\u043c\\", \\"lat\\": 43.6118004, \\"lng\\": 40.3031942}"	2026-03-21 20:58:39.442378+00
28	28	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u043c\\\\u0435\\\\u043d\\\\u043d\\\\u044b\\\\u0439 \\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u0431\\", \\"lat\\": 43.6185715, \\"lng\\": 40.3208573}"	2026-03-21 20:58:39.442378+00
29	29	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u042e\\\\u0440\\\\u044c\\\\u0435\\\\u0432 \\\\u0425\\\\u0443\\\\u0442\\\\u043e\\\\u0440\\", \\"lat\\": 43.6236089, \\"lng\\": 40.329239}"	2026-03-21 20:58:39.442378+00
30	30	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041e\\\\u0437\\\\u0451\\\\u0440\\\\u043d\\\\u044b\\\\u0439 \\\\u0442\\\\u0440\\\\u0430\\\\u0432\\\\u0435\\\\u0440\\\\u0441\\", \\"lat\\": 43.6495655, \\"lng\\": 40.3260868}"	2026-03-21 20:58:39.442378+00
31	31	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"10 \\\\u043f\\\\u0430\\\\u043c\\\\u044f\\\\u0442\\\\u043d\\\\u0438\\\\u043a\\\\u043e\\\\u0432 \\\\u0412\\\\u041e\\\\u0412\\", \\"lat\\": 44.6662152, \\"lng\\": 37.7340463}"	2026-03-21 20:58:39.442378+00
32	32	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u043a \\\\u041a\\\\u0443\\\\u043f\\\\u0435\\\\u043b\\\\u0438\\", \\"lat\\": 43.7027116, \\"lng\\": 40.181292}"	2026-03-21 20:58:39.442378+00
33	33	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a \\\\u0410\\\\u0447\\\\u0438\\\\u043f\\\\u0441\\\\u0438\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u043c \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u0430\\\\u043c\\", \\"lat\\": 43.7121535, \\"lng\\": 40.1652577}"	2026-03-21 20:58:39.442378+00
34	34	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0440\\\\u043d\\\\u0438\\\\u0447\\\\u043d\\\\u0430\\\\u044f \\\\u0442\\\\u0440\\\\u043e\\\\u043f\\\\u0430\\", \\"lat\\": 43.6529699, \\"lng\\": 40.2068656}"	2026-03-21 20:58:39.442378+00
35	35	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u043b\\\\u044c\\\\u043f\\\\u0438\\\\u0439\\\\u0441\\\\u043a\\\\u0438\\\\u0435 \\\\u043b\\\\u0443\\\\u0433\\\\u0430\\", \\"lat\\": 43.6434586, \\"lng\\": 40.2455522}"	2026-03-21 20:58:39.442378+00
36	36	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u0432\\\\u0430 \\\\u0432\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u0430\\", \\"lat\\": 43.6504057, \\"lng\\": 40.2633636}"	2026-03-21 20:58:39.442378+00
37	37	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0440\\\\u043d\\\\u0430\\\\u044f \\\\u043f\\\\u0438\\\\u0440\\\\u0430\\\\u043c\\\\u0438\\\\u0434\\\\u0430\\", \\"lat\\": 43.6420423, \\"lng\\": 40.2588955}"	2026-03-21 20:58:39.442378+00
38	38	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0435\\\\u0440\\\\u0435\\\\u0432\\\\u0430\\\\u043b \\\\u0421\\\\u0435\\\\u0434\\\\u043e\\\\u0439\\", \\"lat\\": 43.6371189, \\"lng\\": 40.2672039}"	2026-03-21 20:58:39.442378+00
39	39	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0435\\\\u0440\\\\u0435\\\\u0432\\\\u0430\\\\u043b \\\\u0410\\\\u0438\\\\u0431\\\\u0433\\\\u0430\\", \\"lat\\": 43.6380923, \\"lng\\": 40.2677223}"	2026-03-21 20:58:39.442378+00
40	40	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u0432\\\\u0430 \\\\u041e\\\\u0437\\\\u0435\\\\u0440\\\\u0430\\", \\"lat\\": 43.6418049, \\"lng\\": 40.267943}"	2026-03-21 20:58:39.442378+00
41	41	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0435\\\\u0441\\\\u0435\\\\u0434\\\\u043a\\\\u0430 \\\\u043b\\\\u044e\\\\u0431\\\\u0432\\\\u0438\\", \\"lat\\": 43.6903638, \\"lng\\": 40.2115411}"	2026-03-21 20:58:39.442378+00
42	42	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041e\\\\u0442 \\\\u0441\\\\u043d\\\\u0435\\\\u0436\\\\u043d\\\\u0438\\\\u043a\\\\u043e\\\\u0432 \\\\u043a \\\\u0412\\\\u043e\\\\u0434\\\\u043e\\\\u043f\\\\u0430\\\\u0434\\\\u0430\\\\u043c \\\\\\"\\\\u041c\\\\u0435\\\\u043d\\\\u0434\\\\u0435\\\\u043b\\\\u0438\\\\u0445\\\\u0430\\\\\\"\\", \\"lat\\": 43.6194552, \\"lng\\": 40.2836659}"	2026-03-21 20:58:39.442378+00
43	43	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0440\\\\u043e\\\\u0447\\\\u0438\\\\u0449\\\\u0435 \\\\u042d\\\\u043d\\\\u0433\\\\u0435\\\\u043b\\\\u044c\\\\u043c\\\\u0430\\\\u043d\\\\u043e\\\\u0432\\\\u044b \\\\u043f\\\\u043e\\\\u043b\\\\u044f\\\\u043d\\\\u044b \\\\u2013 \\\\u043e\\\\u0437\\\\u0435\\\\u0440\\\\u043e \\\\u041a\\\\u0430\\\\u0440\\\\u0434\\\\u044b\\\\u0432\\\\u0430\\\\u0447\\", \\"lat\\": 43.5944474, \\"lng\\": 40.5522003}"	2026-03-21 20:58:39.442378+00
44	44	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u043e\\\\u043f\\\\u0430\\\\u0434 \\\\u0425\\\\u0440\\\\u0443\\\\u0441\\\\u0442\\\\u0430\\\\u043b\\\\u044c\\\\u043d\\\\u044b\\\\u0439\\", \\"lat\\": 43.6334101, \\"lng\\": 40.099858}"	2026-03-21 20:58:39.442378+00
45	45	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0425\\\\u043c\\\\u0435\\\\u043b\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u0438\\\\u0435 \\\\u043e\\\\u0437\\\\u0435\\\\u0440\\\\u0430 + 2 \\\\u0441\\\\u043c\\\\u043e\\\\u0442\\\\u0440\\\\u043e\\\\u0432\\\\u044b\\\\u0445 \\\\u043f\\\\u043b\\\\u043e\\\\u0449\\\\u0430\\\\u0434\\\\u043a\\\\u0438\\", \\"lat\\": 43.7044185, \\"lng\\": 40.2214366}"	2026-03-21 20:58:39.442378+00
46	46	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"lat\\": 45.0259714, \\"lng\\": 38.9868878, \\"post_id\\": 2}"	2026-03-21 20:58:39.672952+00
47	46	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"lat\\": 45.0252434, \\"lng\\": 38.9912995, \\"post_id\\": 105}"	2026-03-21 20:58:39.672952+00
48	46	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0443\\\\u0431\\\\u0430\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0442\\\\u043e\\\\u043f\\\\u043b\\\\u0438\\\\u0432\\\\u043d\\\\u044b\\\\u0439 \\\\u0441\\\\u043e\\\\u044e\\\\u0437\\", \\"lat\\": 45.0217882, \\"lng\\": 38.9843633, \\"post_id\\": 238}"	2026-03-21 20:58:39.672952+00
49	46	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0425\\\\u0432\\\\u0430\\\\u043d\\\\u0447\\\\u043a\\\\u0430\\\\u0440\\\\u0430\\", \\"lat\\": 45.0272866, \\"lng\\": 38.9984618, \\"post_id\\": 4}"	2026-03-21 20:58:39.672952+00
50	46	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u043d\\\\u0438 \\\\u043f\\\\u0438\\\\u0446\\\\u0446\\\\u0430\\", \\"lat\\": 45.0282437, \\"lng\\": 38.9740123, \\"post_id\\": 108}"	2026-03-21 20:58:39.672952+00
51	47	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u0430\\\\u0440\\\\u0438\\\\u043d\\\\u0430 \\\\u0413\\\\u0435\\\\u0440\\\\u043c\\\\u0430\\\\u043d\\", \\"lat\\": 45.0149741, \\"lng\\": 38.9866572, \\"post_id\\": 3}"	2026-03-21 20:58:39.672952+00
52	47	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0413\\\\u0417\\\\u0421\\", \\"lat\\": 45.0147092, \\"lng\\": 38.9963686, \\"post_id\\": 248}"	2026-03-21 20:58:39.672952+00
53	47	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Genoff\\", \\"lat\\": 45.0178194, \\"lng\\": 38.9960357, \\"post_id\\": 316}"	2026-03-21 20:58:39.672952+00
54	47	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0440\\\\u0430\\\\u043c\\\\u0431\\\\u043e\\\\u043b\\\\u044c\\", \\"lat\\": 45.0181258, \\"lng\\": 38.9960879, \\"post_id\\": 306}"	2026-03-21 20:58:39.672952+00
55	47	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u0438\\\\u0440 \\\\u041b\\\\u044e\\\\u0431\\\\u0432\\\\u0438\\", \\"lat\\": 45.012877, \\"lng\\": 38.9707164, \\"post_id\\": 129}"	2026-03-21 20:58:39.672952+00
56	48	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0435\\\\u043d\\\\u0430\\\\u043b\\\\u044c\\\\u0442\\\\u0438\\", \\"lat\\": 45.2268225, \\"lng\\": 38.999498, \\"post_id\\": 5}"	2026-03-21 20:58:39.672952+00
57	48	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0435\\\\u0440\\\\u0451\\\\u0437\\\\u043a\\\\u0430\\", \\"lat\\": 45.2371449, \\"lng\\": 38.9744153, \\"post_id\\": 137}"	2026-03-21 20:58:39.672952+00
58	48	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0438\\\\u0446\\\\u0435\\\\u0440\\\\u0438\\\\u044f \\\\\\"\\\\u0421\\\\u0435\\\\u043d\\\\u044c\\\\u043e\\\\u0440\\\\u0430\\\\\\"\\", \\"lat\\": 45.2367197, \\"lng\\": 38.9724153, \\"post_id\\": 136}"	2026-03-21 20:58:39.672952+00
59	48	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"lat\\": 45.2432674, \\"lng\\": 38.9434439, \\"post_id\\": 243}"	2026-03-21 20:58:39.672952+00
60	49	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0435\\\\u0440\\\\u0431\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"lat\\": 45.0288449, \\"lng\\": 38.9694763, \\"post_id\\": 6}"	2026-03-21 20:58:39.672952+00
61	49	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Zohan bar\\", \\"lat\\": 45.0286105, \\"lng\\": 38.9707933, \\"post_id\\": 139}"	2026-03-21 20:58:39.672952+00
62	49	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u0430\\\\u0440\\\\u044b\\\\u0439 \\\\u0433\\\\u043e\\\\u0440\\\\u043e\\\\u0434\\", \\"lat\\": 45.0286528, \\"lng\\": 38.9680284, \\"post_id\\": 41}"	2026-03-21 20:58:39.672952+00
63	49	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0443\\\\u0431\\\\u0430\\", \\"lat\\": 45.0292558, \\"lng\\": 38.9712972, \\"post_id\\": 106}"	2026-03-21 20:58:39.672952+00
64	49	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0425\\\\u043e\\\\u043b\\\\u043e\\\\u0441\\\\u0442\\\\u044f\\\\u043a\\", \\"lat\\": 45.0284227, \\"lng\\": 38.9719668, \\"post_id\\": 99}"	2026-03-21 20:58:39.672952+00
65	50	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0438\\\\u0432\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"lat\\": 45.0416725, \\"lng\\": 38.9807424, \\"post_id\\": 7}"	2026-03-21 20:58:39.672952+00
66	50	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041b\\\\u0435\\\\u0434\\\\u0438 \\\\u041c\\\\u0430\\\\u0440\\\\u043c\\\\u0435\\\\u043b\\\\u0430\\\\u0434\\", \\"lat\\": 45.0428303, \\"lng\\": 38.9775329, \\"post_id\\": 97}"	2026-03-21 20:58:39.672952+00
67	50	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u0432\\\\u043e\\\\u0440\\\\u0438\\\\u043a\\", \\"lat\\": 45.043329, \\"lng\\": 38.9777008, \\"post_id\\": 96}"	2026-03-21 20:58:39.672952+00
68	50	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0432\\\\u043a\\\\u0430\\\\u0437\\", \\"lat\\": 45.044171, \\"lng\\": 38.9784224, \\"post_id\\": 303}"	2026-03-21 20:58:39.672952+00
69	50	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0432\\\\u0430\\\\u0440\\\\u0442\\\\u0438\\\\u0440\\\\u0430\\", \\"lat\\": 45.0405014, \\"lng\\": 38.9766818, \\"post_id\\": 114}"	2026-03-21 20:58:39.672952+00
70	51	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u0435\\\\u0440\\\\u0441\\\\u0430\\\\u043b\\\\u044c\\", \\"lat\\": 45.0005246, \\"lng\\": 41.1328514, \\"post_id\\": 8}"	2026-03-21 20:58:39.672952+00
71	51	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435 \\\\\\"\\\\u041c\\\\u043e\\\\u043b\\\\u043e\\\\u0434\\\\u0435\\\\u0436\\\\u043d\\\\u043e\\\\u0435\\\\\\"\\", \\"lat\\": 44.9999208, \\"lng\\": 41.1367706, \\"post_id\\": 87}"	2026-03-21 20:58:39.672952+00
72	51	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0438\\\\u044f\\", \\"lat\\": 44.9967327, \\"lng\\": 41.1310779, \\"post_id\\": 83}"	2026-03-21 20:58:39.672952+00
73	51	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0435\\\\u0432\\\\u0435\\\\u0440\\\\u043d\\\\u0430\\\\u044f\\", \\"lat\\": 44.9990618, \\"lng\\": 41.125411, \\"post_id\\": 313}"	2026-03-21 20:58:39.672952+00
74	51	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0413\\\\u0440\\\\u0430\\\\u0430\\\\u043b\\\\u044c\\", \\"lat\\": 44.9879957, \\"lng\\": 41.1200933, \\"post_id\\": 9}"	2026-03-21 20:58:39.672952+00
75	52	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u0430\\\\u0434\\\\u044c\\\\u044f\\\\u0440\\", \\"lat\\": 45.0498342, \\"lng\\": 38.9661759, \\"post_id\\": 10}"	2026-03-21 20:58:39.672952+00
76	52	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"McKEY\\", \\"lat\\": 45.0493313, \\"lng\\": 38.9677184, \\"post_id\\": 55}"	2026-03-21 20:58:39.672952+00
77	52	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423 \\\\u0411\\\\u043b\\\\u0438\\\\u0437\\\\u043d\\\\u0435\\\\u0446\\\\u043e\\\\u0432\\", \\"lat\\": 45.0495751, \\"lng\\": 38.969108, \\"post_id\\": 11}"	2026-03-21 20:58:39.672952+00
78	52	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0416\\\\u0430\\\\u0440-\\\\u041f\\\\u0438\\\\u0446\\\\u0446\\\\u0430\\", \\"lat\\": 45.0511482, \\"lng\\": 38.9583754, \\"post_id\\": 131}"	2026-03-21 20:58:39.672952+00
79	52	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0448\\\\u043b\\\\u044b\\\\u043a\\", \\"lat\\": 45.0554619, \\"lng\\": 38.9602437, \\"post_id\\": 126}"	2026-03-21 20:58:39.672952+00
80	53	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0437\\\\u0430\\\\u0447\\\\u043e\\\\u043a\\", \\"lat\\": 45.1265958, \\"lng\\": 39.0119969, \\"post_id\\": 12}"	2026-03-21 20:58:39.672952+00
81	53	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0442\\\\u044e\\\\u0448\\\\u0430\\", \\"lat\\": 45.1262513, \\"lng\\": 39.0107533, \\"post_id\\": 193}"	2026-03-21 20:58:39.672952+00
82	53	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0417\\\\u043e\\\\u043b\\\\u043e\\\\u0442\\\\u0430\\\\u044f \\\\u043a\\\\u043e\\\\u043b\\\\u0435\\\\u0441\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"lat\\": 45.1256248, \\"lng\\": 39.0066871, \\"post_id\\": 312}"	2026-03-21 20:58:39.672952+00
83	53	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0444\\\\u0438\\\\u043c\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"lat\\": 45.1338199, \\"lng\\": 39.0244543, \\"post_id\\": 271}"	2026-03-21 20:58:39.672952+00
84	53	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423 \\\\u0414\\\\u0436\\\\u0430\\\\u0444\\\\u0430\\\\u0440\\\\u0430\\", \\"lat\\": 45.1077891, \\"lng\\": 38.9843819, \\"post_id\\": 134}"	2026-03-21 20:58:39.672952+00
85	54	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435 \\\\u043c\\\\u043e\\\\u043b\\\\u043e\\\\u0434\\\\u0435\\\\u0436\\\\u043d\\\\u043e\\\\u0435\\", \\"lat\\": 45.3690397, \\"lng\\": 38.2126917, \\"post_id\\": 13}"	2026-03-21 20:58:39.672952+00
86	54	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041e\\\\u0430\\\\u0437\\\\u0438\\\\u0441\\", \\"lat\\": 45.3671007, \\"lng\\": 38.2127138, \\"post_id\\": 145}"	2026-03-21 20:58:39.672952+00
87	54	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0440\\\\u0431\\\\u0430\\\\u0442\\", \\"lat\\": 45.3445825, \\"lng\\": 38.2098485, \\"post_id\\": 149}"	2026-03-21 20:58:39.672952+00
88	55	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Big Bull\\", \\"lat\\": 44.8829045, \\"lng\\": 40.5912203, \\"post_id\\": 14}"	2026-03-21 20:58:39.672952+00
89	55	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041d\\\\u0430\\\\u0434\\\\u0435\\\\u0436\\\\u0434\\\\u0430\\", \\"lat\\": 44.8838345, \\"lng\\": 40.5893202, \\"post_id\\": 142}"	2026-03-21 20:58:39.672952+00
90	55	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u043b\\\\u043e\\\\u0451\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8852907, \\"lng\\": 40.5884314, \\"post_id\\": 141}"	2026-03-21 20:58:39.672952+00
91	55	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0439 \\\\u0440\\\\u043e\\\\u044f\\\\u043b\\\\u044c\\", \\"lat\\": 44.8923789, \\"lng\\": 40.591698, \\"post_id\\": 44}"	2026-03-21 20:58:39.672952+00
92	55	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u0441\\\\u0442\\\\u0440\\\\u0435\\\\u0447\\\\u0430\\", \\"lat\\": 44.8730721, \\"lng\\": 40.5829907, \\"post_id\\": 143}"	2026-03-21 20:58:39.672952+00
93	56	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0440\\\\u043e\\\\u043c\\\\u0435\\\\u043d\\\\u0430\\\\u0434\\", \\"lat\\": 43.5859403, \\"lng\\": 39.7192139, \\"post_id\\": 15}"	2026-03-21 20:58:39.672952+00
94	56	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0430\\\\u043d\\\\u043a\\\\u0438\\\\u0440\\", \\"lat\\": 43.5872433, \\"lng\\": 39.7195095, \\"post_id\\": 150}"	2026-03-21 20:58:39.672952+00
95	56	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u0430\\\\u0440\\\\u044b\\\\u0439 \\\\u0411\\\\u0430\\\\u0437\\\\u0430\\\\u0440\\", \\"lat\\": 43.5833881, \\"lng\\": 39.7180436, \\"post_id\\": 16}"	2026-03-21 20:58:39.672952+00
96	56	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u042d\\\\u0434\\\\u0435\\\\u043c\\", \\"lat\\": 43.5881293, \\"lng\\": 39.7220127, \\"post_id\\": 164}"	2026-03-21 20:58:39.672952+00
97	56	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041d\\\\u0435\\\\u0440\\\\u043e\\", \\"lat\\": 43.587661, \\"lng\\": 39.722845, \\"post_id\\": 172}"	2026-03-21 20:58:39.672952+00
98	57	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041e\\\\u043b\\\\u0438\\\\u0432\\\\u044c\\\\u0435\\", \\"lat\\": 43.5922468, \\"lng\\": 39.7228599, \\"post_id\\": 17}"	2026-03-21 20:58:39.672952+00
99	57	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u0443\\\\u0437\\\\u0435\\\\u0439 \\\\u0438\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0438\\\\u0438 \\\\u0421\\\\u043e\\\\u0447\\\\u0438\\", \\"lat\\": 43.5902931, \\"lng\\": 39.7234503, \\"post_id\\": 275}"	2026-03-21 20:58:39.672952+00
100	57	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Nippon House\\", \\"lat\\": 43.589573, \\"lng\\": 39.722576, \\"post_id\\": 24}"	2026-03-21 20:58:39.672952+00
101	57	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f \\\\u043d\\\\u0430 \\\\u0420\\\\u043e\\\\u0437\\", \\"lat\\": 43.5931916, \\"lng\\": 39.7274294, \\"post_id\\": 151}"	2026-03-21 20:58:39.672952+00
102	57	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0417\\\\u043e\\\\u043b\\\\u043e\\\\u0442\\\\u043e\\\\u0439 \\\\u042f\\\\u043a\\\\u043e\\\\u0440\\\\u044c\\", \\"lat\\": 43.5879452, \\"lng\\": 39.7230655, \\"post_id\\": 64}"	2026-03-21 20:58:39.672952+00
103	58	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0424\\\\u0435\\\\u0434\\\\u0438\\\\u043d\\\\u0430 \\\\u0434\\\\u0430\\\\u0447\\\\u0430\\", \\"lat\\": 43.5678854, \\"lng\\": 39.7353245, \\"post_id\\": 18}"	2026-03-21 20:58:39.672952+00
104	58	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0418\\\\u043d\\\\u0434\\\\u0443\\\\u0441\\", \\"lat\\": 43.5727625, \\"lng\\": 39.7352536, \\"post_id\\": 29}"	2026-03-21 20:58:39.672952+00
105	58	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"MIRROR\\", \\"lat\\": 43.5729017, \\"lng\\": 39.7350363, \\"post_id\\": 320}"	2026-03-21 20:58:39.672952+00
106	58	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u0447\\\\u043d\\\\u044b\\\\u0439 \\\\u043a\\\\u0432\\\\u0430\\\\u0440\\\\u0442\\\\u0430\\\\u043b\\", \\"lat\\": 43.5713275, \\"lng\\": 39.7288786, \\"post_id\\": 19}"	2026-03-21 20:58:39.672952+00
107	58	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0430\\\\u0439\\\\u0445\\\\u043e\\\\u043d\\\\u0430 \\\\u21161\\", \\"lat\\": 43.5738775, \\"lng\\": 39.7279572, \\"post_id\\": 40}"	2026-03-21 20:58:39.672952+00
108	59	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0442\\\\u044e\\\\u0448\\\\u0430\\", \\"lat\\": 43.5578359, \\"lng\\": 39.7654887, \\"post_id\\": 20}"	2026-03-21 20:58:39.672952+00
109	59	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0430\\\\u043b\\\\u044c\\\\u043c\\\\u0430\\", \\"lat\\": 43.5614913, \\"lng\\": 39.760543, \\"post_id\\": 23}"	2026-03-21 20:58:39.672952+00
110	59	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u043d\\\\u0442\\\\u0430\\\\u043b\\\\u044c\\", \\"lat\\": 43.5652652, \\"lng\\": 39.7601496, \\"post_id\\": 171}"	2026-03-21 20:58:39.672952+00
111	59	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0430\\\\u043b\\\\u0443\\\\u0431\\\\u0430 \\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"lat\\": 43.548037, \\"lng\\": 39.7771632, \\"post_id\\": 183}"	2026-03-21 20:58:39.672952+00
112	59	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Coffee\\", \\"lat\\": 43.5492829, \\"lng\\": 39.78249, \\"post_id\\": 144}"	2026-03-21 20:58:39.672952+00
113	60	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u00ab\\\\u0401-\\\\u041c\\\\u043e\\\\u0451\\\\u00bb\\", \\"lat\\": 44.7182967, \\"lng\\": 39.2113212, \\"post_id\\": 21}"	2026-03-21 20:58:39.672952+00
114	60	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u00ab\\\\u0401-\\\\u041c\\\\u043e\\\\u0451\\\\u00bb\\", \\"lat\\": 44.718224, \\"lng\\": 39.211267, \\"post_id\\": 322}"	2026-03-21 20:58:39.672952+00
115	60	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043a\\\\u0443\\\\u0441\\\\u043d\\\\u043e\\\\u0435\\\\u0436\\\\u043a\\\\u0430\\", \\"lat\\": 44.7174428, \\"lng\\": 39.2116227, \\"post_id\\": 167}"	2026-03-21 20:58:39.672952+00
116	60	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u043e\\\\u043b\\\\u043e\\\\u0434\\\\u0435\\\\u0436\\\\u043d\\\\u043e\\\\u0435\\", \\"lat\\": 44.7173926, \\"lng\\": 39.211588, \\"post_id\\": 166}"	2026-03-21 20:58:39.672952+00
117	60	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u00ab\\\\u041f\\\\u0440\\\\u0438\\\\u0432\\\\u0430\\\\u043b\\\\u00bb\\", \\"lat\\": 44.7171978, \\"lng\\": 39.2108337, \\"post_id\\": 168}"	2026-03-21 20:58:39.672952+00
118	61	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Amsterdam Bar\\", \\"lat\\": 45.0288339, \\"lng\\": 38.9741391, \\"post_id\\": 22}"	2026-03-21 20:58:39.672952+00
119	61	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0433\\\\u0443\\\\u0449\\\\u0451\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 45.0283518, \\"lng\\": 38.9723536, \\"post_id\\": 121}"	2026-03-21 20:58:39.672952+00
120	61	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0425\\\\u043e\\\\u043b\\\\u043e\\\\u0441\\\\u0442\\\\u044f\\\\u0434\\\\u0437\\\\u0435\\", \\"lat\\": 45.0312423, \\"lng\\": 38.9746396, \\"post_id\\": 102}"	2026-03-21 20:58:39.672952+00
121	61	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u043b\\\\u0435\\\\u0437\\\\u0438\\\\u0440\\", \\"lat\\": 45.0311877, \\"lng\\": 38.9725344, \\"post_id\\": 101}"	2026-03-21 20:58:39.672952+00
122	61	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u043e\\\\u0441\\\\u043a\\\\u0432\\\\u0430\\", \\"lat\\": 45.0262016, \\"lng\\": 38.9713665, \\"post_id\\": 56}"	2026-03-21 20:58:39.672952+00
123	62	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0440\\\\u043e\\\\u0445\\\\u043b\\\\u0430\\\\u0434\\\\u0430\\", \\"lat\\": 43.8961472, \\"lng\\": 39.3473324, \\"post_id\\": 26}"	2026-03-21 20:58:39.672952+00
124	62	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041d\\\\u0435\\\\u0431\\\\u0435\\\\u0441\\\\u0430\\", \\"lat\\": 43.8966944, \\"lng\\": 39.3487903, \\"post_id\\": 178}"	2026-03-21 20:58:39.672952+00
125	62	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041d\\\\u0430\\\\u0442\\\\u0430\\\\u043b\\\\u0438\\", \\"lat\\": 43.9043479, \\"lng\\": 39.3352839, \\"post_id\\": 179}"	2026-03-21 20:58:39.672952+00
126	62	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0438\\\\u043d\\\\u0433\\\\u0432\\\\u0438\\\\u043d\\", \\"lat\\": 43.9082238, \\"lng\\": 39.3322306, \\"post_id\\": 95}"	2026-03-21 20:58:39.672952+00
127	62	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0440\\\\u0438\\\\u0431\\\\u043e\\\\u0439\\", \\"lat\\": 43.9056091, \\"lng\\": 39.3264909, \\"post_id\\": 58}"	2026-03-21 20:58:39.672952+00
128	63	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0443\\\\u0440\\\\u0443\\\\u043c\\", \\"lat\\": 43.5763, \\"lng\\": 39.723794, \\"post_id\\": 27}"	2026-03-21 20:58:39.672952+00
129	63	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0451\\\\u0440\\\\u043d\\\\u044b\\\\u0439 \\\\u0436\\\\u0435\\\\u043c\\\\u0447\\\\u0443\\\\u0433\\", \\"lat\\": 43.5757829, \\"lng\\": 39.7237263, \\"post_id\\": 161}"	2026-03-21 20:58:39.672952+00
130	63	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u043b\\\\u0438\\\\u0444\\\\u043e\\\\u0440\\\\u043d\\\\u0438\\\\u044f\\", \\"lat\\": 43.5757024, \\"lng\\": 39.723905, \\"post_id\\": 162}"	2026-03-21 20:58:39.672952+00
131	63	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0430\\\\u0431\\\\u0430\\\\u0435\\\\u0432\\\\u0430\\", \\"lat\\": 43.5755216, \\"lng\\": 39.7239976, \\"post_id\\": 163}"	2026-03-21 20:58:39.672952+00
132	63	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u043e\\\\u043c 1934 \\\\u0433\\", \\"lat\\": 43.5763724, \\"lng\\": 39.7254205, \\"post_id\\": 38}"	2026-03-21 20:58:39.672952+00
133	64	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Cinema\\", \\"lat\\": 43.5757584, \\"lng\\": 39.725387, \\"post_id\\": 28}"	2026-03-21 20:58:39.672952+00
134	64	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"City Park Hotel\\", \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"post_id\\": 321}"	2026-03-21 20:58:39.672952+00
135	64	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0435 \\\\u043d\\\\u043e\\\\u0447\\\\u0438\\", \\"lat\\": 43.576863, \\"lng\\": 39.7260936, \\"post_id\\": 160}"	2026-03-21 20:58:39.672952+00
136	64	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u042f\\\\u043f\\\\u043e\\\\u043d\\\\u0430 \\\\u041c\\\\u0430\\\\u043c\\\\u0430\\", \\"lat\\": 43.574821, \\"lng\\": 39.728738, \\"post_id\\": 34}"	2026-03-21 20:58:39.672952+00
137	64	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184}"	2026-03-21 20:58:39.672952+00
138	65	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0434\\\\u0430\\\\u043d\\", \\"lat\\": 43.5774093, \\"lng\\": 39.730954, \\"post_id\\": 30}"	2026-03-21 20:58:39.672952+00
139	65	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Seafood market\\", \\"lat\\": 43.5804601, \\"lng\\": 39.719329, \\"post_id\\": 165}"	2026-03-21 20:58:39.672952+00
140	65	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u043e\\\\u0444\\\\u0435\\\\u043c\\\\u0430\\\\u043d\\\\u0438\\\\u044f\\", \\"lat\\": 43.5804043, \\"lng\\": 39.7188144, \\"post_id\\": 85}"	2026-03-21 20:58:39.672952+00
141	65	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0435\\\\u043d\\\\u0430\\\\u0442\\\\u043e\\\\u0440\\", \\"lat\\": 43.5859212, \\"lng\\": 39.7254409, \\"post_id\\": 132}"	2026-03-21 20:58:39.672952+00
142	65	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0440\\\\u0438\\\\u0447\\\\u0430\\\\u043b \\\\u21161\\", \\"lat\\": 43.5790949, \\"lng\\": 39.717561, \\"post_id\\": 84}"	2026-03-21 20:58:39.672952+00
143	66	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u043b\\\\u0435\\\\u043a\\\\u0441\\", \\"lat\\": 45.6161633, \\"lng\\": 38.9350306, \\"post_id\\": 31}"	2026-03-21 20:58:39.672952+00
144	66	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0424\\\\u043b\\\\u0430\\\\u0433\\\\u043c\\\\u0430\\\\u043d\\", \\"lat\\": 45.618911, \\"lng\\": 38.9373718, \\"post_id\\": 32}"	2026-03-21 20:58:39.672952+00
145	66	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u0443\\\\u0437\\\\u0435\\\\u0439 \\\\u0441\\\\u0435\\\\u043c\\\\u044c\\\\u0438 \\\\u0421\\\\u0442\\\\u0435\\\\u043f\\\\u0430\\\\u043d\\\\u043e\\\\u0432\\\\u044b\\\\u0445\\", \\"lat\\": 45.6126297, \\"lng\\": 38.9367781, \\"post_id\\": 280}"	2026-03-21 20:58:39.672952+00
146	66	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435 \\\\u041f\\\\u0438\\\\u0446\\\\u0446\\\\u0430\\", \\"lat\\": 45.6152966, \\"lng\\": 38.9587817, \\"post_id\\": 130}"	2026-03-21 20:58:39.672952+00
147	66	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0418\\\\u0437\\\\u0443\\\\u043c\\\\u0440\\\\u0443\\\\u0434\\", \\"lat\\": 45.6126031, \\"lng\\": 38.9585804, \\"post_id\\": 314}"	2026-03-21 20:58:39.672952+00
148	67	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0440\\\\u0430\\\\u0439\\\\u0434\\", \\"lat\\": 43.6140274, \\"lng\\": 39.739208, \\"post_id\\": 33}"	2026-03-21 20:58:39.672952+00
149	67	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0448\\\\u0441\\\\u043a\\\\u043e\\\\u0435 \\\\u043f\\\\u0438\\\\u0432\\\\u043e\\", \\"lat\\": 43.6088672, \\"lng\\": 39.7280538, \\"post_id\\": 63}"	2026-03-21 20:58:39.672952+00
150	67	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 43.6214187, \\"lng\\": 39.7186565, \\"post_id\\": 45}"	2026-03-21 20:58:39.672952+00
151	67	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"La Vash\\", \\"lat\\": 43.614046, \\"lng\\": 39.7139361, \\"post_id\\": 82}"	2026-03-21 20:58:39.672952+00
152	67	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 43.6272298, \\"lng\\": 39.7182977, \\"post_id\\": 159}"	2026-03-21 20:58:39.672952+00
153	68	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u0430\\\\u043b\\\\u044b\\\\u0439 \\\\u0410\\\\u0445\\\\u0443\\\\u043d\\", \\"lat\\": 43.5443822, \\"lng\\": 39.8284932, \\"post_id\\": 39}"	2026-03-21 20:58:39.672952+00
154	68	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"A.A.C. Art Gallery of Wood Plastic\\", \\"lat\\": 43.5267615, \\"lng\\": 39.8379475, \\"post_id\\": 297}"	2026-03-21 20:58:39.672952+00
155	68	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0430\\\\u043b\\\\u0438\\", \\"lat\\": 43.5485109, \\"lng\\": 39.7921781, \\"post_id\\": 182}"	2026-03-21 20:58:39.672952+00
156	69	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0427\\\\u0430\\\\u0439\\\\u043a\\\\u0430\\", \\"lat\\": 45.2535879, \\"lng\\": 38.1171604, \\"post_id\\": 42}"	2026-03-21 20:58:39.672952+00
157	69	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u043c\\\\u0430\\\\u0440\\\\u0430\\", \\"lat\\": 45.2649128, \\"lng\\": 38.1480452, \\"post_id\\": 52}"	2026-03-21 20:58:39.672952+00
158	69	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u043e\\\\u043c\\\\u043e\\\\u043d\\\\u0434\\", \\"lat\\": 45.2430236, \\"lng\\": 38.15843, \\"post_id\\": 50}"	2026-03-21 20:58:39.672952+00
159	70	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u0443\\\\u0445\\\\u0430\\\\u043d\\\\u044a\\", \\"lat\\": 45.0186018, \\"lng\\": 38.9680247, \\"post_id\\": 43}"	2026-03-21 20:58:39.672952+00
160	70	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422-\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"lat\\": 45.0180693, \\"lng\\": 38.9684338, \\"post_id\\": 112}"	2026-03-21 20:58:39.672952+00
161	70	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0416\\\\u0430\\\\u0440\\\\u043e\\\\u0432\\\\u043d\\\\u044f\\", \\"lat\\": 45.0208084, \\"lng\\": 38.9686524, \\"post_id\\": 111}"	2026-03-21 20:58:39.672952+00
162	70	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u043e\\\\u0441\\\\u044c\\\\u043c\\\\u043e\\\\u0435 \\\\u043d\\\\u0435\\\\u0431\\\\u043e\\", \\"lat\\": 45.0159646, \\"lng\\": 38.9634568, \\"post_id\\": 74}"	2026-03-21 20:58:39.672952+00
163	70	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041c\\\\u044d\\\\u043d\\\\u0438 \\\\u041f\\\\u0435\\\\u043b\\\\u044c\\\\u043c\\\\u0435\\\\u043d\\\\u0438\\", \\"lat\\": 45.0233424, \\"lng\\": 38.969614, \\"post_id\\": 104}"	2026-03-21 20:58:39.672952+00
164	71	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u043b\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.907713, \\"lng\\": 40.5826323, \\"post_id\\": 46}"	2026-03-21 20:58:39.672952+00
165	71	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Bon Hotel\\", \\"lat\\": 44.9082582, \\"lng\\": 40.5976152, \\"post_id\\": 318}"	2026-03-21 20:58:39.672952+00
166	71	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u044e\\\\u0442\\", \\"lat\\": 44.8970689, \\"lng\\": 40.5972337, \\"post_id\\": 140}"	2026-03-21 20:58:39.672952+00
167	72	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u043f\\\\u043e\\\\u0440\\\\u0442\\\\u0431\\\\u0430\\\\u0440\\", \\"lat\\": 45.2139606, \\"lng\\": 36.7188345, \\"post_id\\": 47}"	2026-03-21 20:58:39.672952+00
168	72	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0440\\\\u0445\\\\u0435\\\\u043e\\\\u043b\\\\u043e\\\\u0433\\\\u0438\\\\u0447\\\\u0435\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u043c\\\\u0443\\\\u0437\\\\u0435\\\\u0439\\", \\"lat\\": 45.2171508, \\"lng\\": 36.7225406, \\"post_id\\": 277}"	2026-03-21 20:58:39.672952+00
169	72	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0440\\\\u0430\\\\u0435\\\\u0432\\\\u0435\\\\u0434\\\\u0447\\\\u0435\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u043c\\\\u0443\\\\u0437\\\\u0435\\\\u0439\\", \\"lat\\": 45.2186872, \\"lng\\": 36.722671, \\"post_id\\": 285}"	2026-03-21 20:58:39.672952+00
170	72	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u043e\\\\u043c-\\\\u043c\\\\u0443\\\\u0437\\\\u0435\\\\u0439 \\\\u041c.\\\\u042e. \\\\u041b\\\\u0435\\\\u0440\\\\u043c\\\\u043e\\\\u043d\\\\u0442\\\\u043e\\\\u0432\\\\u0430\\", \\"lat\\": 45.2180072, \\"lng\\": 36.7253798, \\"post_id\\": 278}"	2026-03-21 20:58:39.672952+00
171	72	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0443\\\\u0440\\\\u0435\\\\u0446\\\\u043a\\\\u0438\\\\u0439 \\\\u0444\\\\u043e\\\\u043d\\\\u0442\\\\u0430\\\\u043d\\", \\"lat\\": 45.2109988, \\"lng\\": 36.7291095, \\"post_id\\": 186}"	2026-03-21 20:58:39.672952+00
172	73	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0413\\\\u0440\\\\u0430\\\\u0446\\", \\"lat\\": 45.0594596, \\"lng\\": 38.9640856, \\"post_id\\": 48}"	2026-03-21 20:58:39.672952+00
173	73	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0422\\\\u0430\\\\u0432\\\\u0435\\\\u0440\\\\u043d\\\\u0430 \\\\u0443 \\\\u0417\\\\u0430\\\\u043c\\\\u043a\\\\u0430\\", \\"lat\\": 45.0591697, \\"lng\\": 38.9626714, \\"post_id\\": 49}"	2026-03-21 20:58:39.672952+00
174	73	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0430\\\\u0440\\\\u043c\\\\u0430\\\\u0442\\", \\"lat\\": 45.0600076, \\"lng\\": 38.977284, \\"post_id\\": 138}"	2026-03-21 20:58:39.672952+00
175	73	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0426\\\\u0432\\\\u0435\\\\u0442\\\\u043e\\\\u0447\\\\u043d\\\\u044b\\\\u0435 \\\\u0447\\\\u0430\\\\u0441\\\\u044b\\", \\"lat\\": 45.0540225, \\"lng\\": 38.9799687, \\"post_id\\": 185}"	2026-03-21 20:58:39.672952+00
176	73	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435 \\\\\\"\\\\u041b\\\\u044e\\\\u0431\\\\u043e\\\\\\"\\", \\"lat\\": 45.0520165, \\"lng\\": 38.9794327, \\"post_id\\": 98}"	2026-03-21 20:58:39.672952+00
177	74	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0411\\\\u0430\\\\u0434\\\\u0435\\\\u043d-\\\\u0411\\\\u0430\\\\u0434\\\\u0435\\\\u043d\\", \\"lat\\": 45.0686422, \\"lng\\": 38.9788729, \\"post_id\\": 51}"	2026-03-21 20:58:39.672952+00
178	74	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0430\\\\u0442\\\\u0440\\\\u0438\\\\u043a & \\\\u041c\\\\u0430\\\\u0440\\\\u0438\\", \\"lat\\": 45.0695461, \\"lng\\": 38.9815937, \\"post_id\\": 118}"	2026-03-21 20:58:39.672952+00
179	74	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0438\\\\u043d\\\\u043e\\\\u043a\\\\u043a\\\\u0438\\\\u043e Djan\\", \\"lat\\": 45.0620426, \\"lng\\": 38.9935308, \\"post_id\\": 66}"	2026-03-21 20:58:39.672952+00
180	74	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041b\\\\u044e\\\\u0431\\\\u043e \\\\u041a\\\\u043e\\\\u043d\\\\u0434\\\\u0438\\\\u0442\\\\u0435\\\\u0440\\\\u0441\\\\u043a\\\\u0430\\\\u044f\\", \\"lat\\": 45.0546741, \\"lng\\": 38.98235, \\"post_id\\": 103}"	2026-03-21 20:58:39.672952+00
181	74	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0414\\\\u0438\\\\u043d\\\\u0430\\\\u043c\\\\u043e\\", \\"lat\\": 45.050376, \\"lng\\": 38.9808309, \\"post_id\\": 304}"	2026-03-21 20:58:39.672952+00
182	75	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0443\\\\u0448\\\\u0438-\\\\u0431\\\\u0430\\\\u0440 \\\\\\"\\\\u041c\\\\u0438\\\\u043d\\\\u0430\\\\u043c\\\\u0438\\\\\\"\\", \\"lat\\": 45.0304078, \\"lng\\": 38.9105279, \\"post_id\\": 53}"	2026-03-21 20:58:39.672952+00
183	75	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0443\\\\u0448\\\\u0438Wok\\", \\"lat\\": 45.0297754, \\"lng\\": 38.9130368, \\"post_id\\": 71}"	2026-03-21 20:58:39.672952+00
184	75	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Prosushi\\", \\"lat\\": 45.0316396, \\"lng\\": 38.917235, \\"post_id\\": 73}"	2026-03-21 20:58:39.672952+00
185	75	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041f\\\\u0435\\\\u043d\\\\u0430\\", \\"lat\\": 45.0239593, \\"lng\\": 38.9658524, \\"post_id\\": 90}"	2026-03-21 20:58:39.672952+00
186	75	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"lat\\": 45.0306025, \\"lng\\": 38.9668823, \\"post_id\\": 110}"	2026-03-21 20:58:39.672952+00
191	76	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 22:23:35.487601+00
187	76	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"distance_to_next_km\\": 230.4, \\"duration_to_next_min\\": 346}"	2026-03-21 22:23:35.487601+00
188	76	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 3}"	2026-03-21 22:23:35.487601+00
189	76	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 29.1, \\"duration_to_next_min\\": 44}"	2026-03-21 22:23:35.487601+00
190	76	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 27}"	2026-03-21 22:23:35.487601+00
192	76	187	experience	5	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"recommendation_type\\": \\"food\\"}"	2026-03-21 22:23:35.53812+00
193	76	190	experience	6	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Kuvee Karsov\\", \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"post_id\\": 80, \\"description\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"recommendation_type\\": \\"food\\"}"	2026-03-21 22:23:35.53812+00
194	76	\N	stay	7	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"City Park Hotel\\", \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"post_id\\": 321, \\"recommendation_type\\": \\"stay\\"}"	2026-03-21 22:23:35.53812+00
199	77	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 22:32:41.652374+00
195	77	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"distance_to_next_km\\": 230.4, \\"duration_to_next_min\\": 230, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:32:41.652374+00
196	77	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:32:41.652374+00
197	77	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 29.1, \\"duration_to_next_min\\": 29, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:32:41.652374+00
198	77	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:32:41.652374+00
200	77	195	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Mocco\\", \\"post_id\\": 184, \\"distance_km\\": 0.0, \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}, {\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0434\\\\u0430\\\\u043d\\", \\"post_id\\": 30, \\"distance_km\\": 0.2, \\"lat\\": 43.5774093, \\"lng\\": 39.730954, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}, {\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0435 \\\\u043d\\\\u043e\\\\u0447\\\\u0438\\", \\"post_id\\": 160, \\"distance_km\\": 0.3, \\"lat\\": 43.576863, \\"lng\\": 39.7260936, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}]}"	2026-03-21 22:32:42.536011+00
201	77	198	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Kuvee Karsov\\", \\"post_id\\": 80, \\"distance_km\\": 1.8, \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 22:32:42.536011+00
202	77	\N	stay	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"City Park Hotel\\", \\"post_id\\": 321, \\"distance_km\\": 0.3, \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"MIRROR\\", \\"post_id\\": 320, \\"distance_km\\": 0.8, \\"lat\\": 43.5729017, \\"lng\\": 39.7350363, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}]}"	2026-03-21 22:32:42.536011+00
203	77	197	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"fuel\\", \\"options\\": [{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 253, \\"distance_km\\": 5.3, \\"lat\\": 44.898448, \\"lng\\": 37.449008}, {\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 252, \\"distance_km\\": 6.7, \\"lat\\": 44.8994488, \\"lng\\": 37.3914293}]}"	2026-03-21 22:32:42.536011+00
208	78	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 22:38:23.293983+00
204	78	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"distance_to_next_km\\": 230.4, \\"duration_to_next_min\\": 230, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:38:23.293983+00
205	78	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:38:23.293983+00
206	78	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 29.1, \\"duration_to_next_min\\": 29, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:38:23.293983+00
207	78	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 22:38:23.293983+00
209	78	204	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Mocco\\", \\"post_id\\": 184, \\"distance_km\\": 0.0, \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}, {\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0434\\\\u0430\\\\u043d\\", \\"post_id\\": 30, \\"distance_km\\": 0.2, \\"lat\\": 43.5774093, \\"lng\\": 39.730954, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}, {\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0435 \\\\u043d\\\\u043e\\\\u0447\\\\u0438\\", \\"post_id\\": 160, \\"distance_km\\": 0.3, \\"lat\\": 43.576863, \\"lng\\": 39.7260936, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}]}"	2026-03-21 22:38:24.170618+00
210	78	207	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Kuvee Karsov\\", \\"post_id\\": 80, \\"distance_km\\": 1.8, \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 22:38:24.170618+00
211	78	\N	stay	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"City Park Hotel\\", \\"post_id\\": 321, \\"distance_km\\": 0.3, \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"MIRROR\\", \\"post_id\\": 320, \\"distance_km\\": 0.8, \\"lat\\": 43.5729017, \\"lng\\": 39.7350363, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}]}"	2026-03-21 22:38:24.170618+00
212	78	206	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"fuel\\", \\"options\\": [{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 253, \\"distance_km\\": 5.3, \\"lat\\": 44.898448, \\"lng\\": 37.449008}, {\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 252, \\"distance_km\\": 6.7, \\"lat\\": 44.8994488, \\"lng\\": 37.3914293}]}"	2026-03-21 22:38:24.170618+00
217	79	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 23:05:49.459884+00
213	79	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"distance_to_next_km\\": 230.4, \\"duration_to_next_min\\": 230, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:05:49.459884+00
214	79	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:05:49.459884+00
215	79	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 29.1, \\"duration_to_next_min\\": 29, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:05:49.459884+00
216	79	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:05:49.459884+00
218	79	213	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Mocco\\", \\"post_id\\": 184, \\"distance_km\\": 0.0, \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}, {\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0434\\\\u0430\\\\u043d\\", \\"post_id\\": 30, \\"distance_km\\": 0.2, \\"lat\\": 43.5774093, \\"lng\\": 39.730954, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}, {\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0435 \\\\u043d\\\\u043e\\\\u0447\\\\u0438\\", \\"post_id\\": 160, \\"distance_km\\": 0.3, \\"lat\\": 43.576863, \\"lng\\": 39.7260936, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}]}"	2026-03-21 23:05:50.607594+00
219	79	216	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Kuvee Karsov\\", \\"post_id\\": 80, \\"distance_km\\": 1.8, \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 23:05:50.607594+00
220	79	\N	stay	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"City Park Hotel\\", \\"post_id\\": 321, \\"distance_km\\": 0.3, \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"MIRROR\\", \\"post_id\\": 320, \\"distance_km\\": 0.8, \\"lat\\": 43.5729017, \\"lng\\": 39.7350363, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}]}"	2026-03-21 23:05:50.607594+00
221	79	215	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"fuel\\", \\"options\\": [{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 253, \\"distance_km\\": 5.3, \\"lat\\": 44.898448, \\"lng\\": 37.449008}, {\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 252, \\"distance_km\\": 6.7, \\"lat\\": 44.8994488, \\"lng\\": 37.3914293}]}"	2026-03-21 23:05:50.607594+00
226	80	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 23:09:28.310372+00
222	80	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"distance_to_next_km\\": 230.4, \\"duration_to_next_min\\": 230, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:09:28.310372+00
223	80	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:09:28.310372+00
224	80	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 29.1, \\"duration_to_next_min\\": 29, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:09:28.310372+00
225	80	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:09:28.310372+00
227	80	222	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Mocco\\", \\"post_id\\": 184, \\"distance_km\\": 0.0, \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}, {\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0434\\\\u0430\\\\u043d\\", \\"post_id\\": 30, \\"distance_km\\": 0.2, \\"lat\\": 43.5774093, \\"lng\\": 39.730954, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}, {\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0435 \\\\u043d\\\\u043e\\\\u0447\\\\u0438\\", \\"post_id\\": 160, \\"distance_km\\": 0.3, \\"lat\\": 43.576863, \\"lng\\": 39.7260936, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}]}"	2026-03-21 23:09:29.348381+00
228	80	225	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Kuvee Karsov\\", \\"post_id\\": 80, \\"distance_km\\": 1.8, \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 23:09:29.348381+00
251	84	248	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 23:14:52.031907+00
243	82	240	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0431\\\\u0440\\\\u0430\\\\u0443-\\\\u0414\\\\u044e\\\\u0440\\\\u0441\\\\u043e\\", \\"lat\\": 44.8770928, \\"lng\\": 37.3111542, \\"post_id\\": 491, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 0.0, \\"duration_to_next_min\\": 0, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
245	83	244	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.877187, \\"lng\\": 37.3110563, \\"post_id\\": 490, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 0.0, \\"duration_to_next_min\\": 0, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
229	80	\N	stay	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"City Park Hotel\\", \\"post_id\\": 321, \\"distance_km\\": 0.3, \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"MIRROR\\", \\"post_id\\": 320, \\"distance_km\\": 0.8, \\"lat\\": 43.5729017, \\"lng\\": 39.7350363, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}]}"	2026-03-21 23:09:29.348381+00
230	80	224	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"fuel\\", \\"options\\": [{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 253, \\"distance_km\\": 5.3, \\"lat\\": 44.898448, \\"lng\\": 37.449008}, {\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 252, \\"distance_km\\": 6.7, \\"lat\\": 44.8994488, \\"lng\\": 37.3914293}]}"	2026-03-21 23:09:29.348381+00
235	81	\N	experience	4	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\"}"	2026-03-21 23:10:16.939097+00
231	81	\N	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Mocco\\", \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"post_id\\": 184, \\"description\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\", \\"distance_to_next_km\\": 230.4, \\"duration_to_next_min\\": 230, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:10:16.939097+00
232	81	\N	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:10:16.939097+00
233	81	\N	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 29.1, \\"duration_to_next_min\\": 29, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:10:16.939097+00
234	81	\N	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0430\\\\u0442\\\\u043e \\\\u041b\\\\u0435 \\\\u0413\\\\u0440\\\\u0430\\\\u043d \\\\u0412\\\\u043e\\\\u0441\\\\u0442\\\\u043e\\\\u043a\\", \\"lat\\": 45.0010209, \\"lng\\": 37.7452316, \\"post_id\\": 480, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:10:16.939097+00
236	81	231	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Mocco\\", \\"post_id\\": 184, \\"distance_km\\": 0.0, \\"lat\\": 43.5784046, \\"lng\\": 39.7287965, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}, {\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0434\\\\u0430\\\\u043d\\", \\"post_id\\": 30, \\"distance_km\\": 0.2, \\"lat\\": 43.5774093, \\"lng\\": 39.730954, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}, {\\"name\\": \\"\\\\u0411\\\\u0435\\\\u043b\\\\u044b\\\\u0435 \\\\u043d\\\\u043e\\\\u0447\\\\u0438\\", \\"post_id\\": 160, \\"distance_km\\": 0.3, \\"lat\\": 43.576863, \\"lng\\": 39.7260936, \\"type\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435\\"}]}"	2026-03-21 23:10:17.928254+00
237	81	234	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Kuvee Karsov\\", \\"post_id\\": 80, \\"distance_km\\": 1.8, \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 23:10:17.928254+00
238	81	\N	stay	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"City Park Hotel\\", \\"post_id\\": 321, \\"distance_km\\": 0.3, \\"lat\\": 43.5761102, \\"lng\\": 39.7258462, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"MIRROR\\", \\"post_id\\": 320, \\"distance_km\\": 0.8, \\"lat\\": 43.5729017, \\"lng\\": 39.7350363, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}]}"	2026-03-21 23:10:17.928254+00
239	81	233	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"fuel\\", \\"options\\": [{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 253, \\"distance_km\\": 5.3, \\"lat\\": 44.898448, \\"lng\\": 37.449008}, {\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 252, \\"distance_km\\": 6.7, \\"lat\\": 44.8994488, \\"lng\\": 37.3914293}]}"	2026-03-21 23:10:17.928254+00
240	82	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"day_number\\": 1, \\"date\\": \\"2026-04-15\\", \\"title\\": \\"\\\\u0414\\\\u0435\\\\u043d\\\\u044c 1\\", \\"experience_count\\": 3}"	2026-03-21 23:14:52.031907+00
244	83	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"day_number\\": 2, \\"date\\": \\"2026-04-16\\", \\"title\\": \\"\\\\u0414\\\\u0435\\\\u043d\\\\u044c 2\\", \\"experience_count\\": 3}"	2026-03-21 23:14:52.031907+00
248	84	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"day_number\\": 3, \\"date\\": \\"2026-04-17\\", \\"title\\": \\"\\\\u0414\\\\u0435\\\\u043d\\\\u044c 3\\", \\"experience_count\\": 3}"	2026-03-21 23:14:52.031907+00
241	82	240	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430-\\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041a\\\\u0430\\\\u043d\\\\u0442\\\\u0438\\\\u043d\\\\u0430\\", \\"lat\\": 44.8661441, \\"lng\\": 37.4627079, \\"post_id\\": 478, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 2.3, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
242	82	240	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0428\\\\u0443\\\\u043c\\\\u0440\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\", \\"lat\\": 44.8509508, \\"lng\\": 37.4425334, \\"post_id\\": 479, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 10.8, \\"duration_to_next_min\\": 11, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
246	83	244	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Fanagoria\\", \\"lat\\": 44.8773243, \\"lng\\": 37.3109261, \\"post_id\\": 489, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 11.6, \\"duration_to_next_min\\": 12, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
247	83	244	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u0411\\\\u0435\\\\u0440\\\\u0434\\\\u044f\\\\u0435\\\\u0432\\\\u0430\\", \\"lat\\": 44.981751, \\"lng\\": 37.3125481, \\"post_id\\": 482, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 14.6, \\"duration_to_next_min\\": 15, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
249	84	248	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f LETO\\", \\"lat\\": 45.0732822, \\"lng\\": 37.4463748, \\"post_id\\": 493, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 20.8, \\"duration_to_next_min\\": 21, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
250	84	248	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0420\\\\u0430\\\\u0435\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0435\\", \\"lat\\": 44.9057375, \\"lng\\": 37.5637933, \\"post_id\\": 481, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f\\", \\"distance_to_next_km\\": 17.8, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\"}"	2026-03-21 23:14:52.031907+00
252	82	247	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"post_id\\": 79, \\"distance_km\\": 3.3, \\"lat\\": 44.978699, \\"lng\\": 37.271429, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 23:14:53.08983+00
253	82	251	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"Kuvee Karsov\\", \\"post_id\\": 80, \\"distance_km\\": 1.8, \\"lat\\": 45.015743, \\"lng\\": 37.7545527, \\"type\\": \\"\\\\u0420\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\"}]}"	2026-03-21 23:14:53.08983+00
254	82	\N	stay	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"\\\\u041e\\\\u0442\\\\u0435\\\\u043b\\\\u044c \\\\\\"\\\\u041f\\\\u043b\\\\u0430\\\\u0437\\\\u0430\\\\\\"\\", \\"post_id\\": 324, \\"distance_km\\": 11.8, \\"lat\\": 44.9007732, \\"lng\\": 37.3209396, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"\\\\u0416\\\\u0435\\\\u043c\\\\u0447\\\\u0443\\\\u0436\\\\u0438\\\\u043d\\\\u0430\\", \\"post_id\\": 315, \\"distance_km\\": 18.9, \\"lat\\": 44.7865842, \\"lng\\": 37.6740711, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}, {\\"name\\": \\"\\\\u041a\\\\u043e\\\\u0440\\\\u0441\\\\u0430\\\\u0440\\", \\"post_id\\": 305, \\"distance_km\\": 34.6, \\"lat\\": 44.7133051, \\"lng\\": 37.8449395, \\"type\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\"}]}"	2026-03-21 23:14:53.08983+00
255	82	246	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"fuel\\", \\"options\\": [{\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 251, \\"distance_km\\": 4.0, \\"lat\\": 44.9105977, \\"lng\\": 37.3285363}, {\\"name\\": \\"\\\\u0420\\\\u043e\\\\u0441\\\\u043d\\\\u0435\\\\u0444\\\\u0442\\\\u044c\\", \\"post_id\\": 252, \\"distance_km\\": 6.8, \\"lat\\": 44.8994488, \\"lng\\": 37.3914293}]}"	2026-03-21 23:14:53.08983+00
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.services (id, name, type, duration_min, description) FROM stdin;
1	Пешая экскурсия	activity	120	\N
2	Дегустация вин	activity	90	\N
3	Трансфер	transport	60	\N
4	Обед	food	45	\N
5	Ужин	food	60	\N
6	Фотосессия	activity	90	\N
7	Конная прогулка	activity	120	\N
8	Джип-тур	transport	180	\N
9	Рафтинг	activity	150	\N
10	Мастер-класс по кухне	activity	120	\N
11	Сопровождение гида	guide	240	\N
12	Катание на лодке	activity	60	\N
\.


--
-- Data for Name: similar_places; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.similar_places (place_id, similar_place_id, score) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.tags (id, name, emoji, category, created_at) FROM stdin;
\.


--
-- Data for Name: tour_services; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.tour_services (tour_id, service_id, "position") FROM stdin;
\.


--
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.tours (id, post_id, title, description, price, duration_min, max_group_size, guide_id, publisher_id, created_at) FROM stdin;
\.


--
-- Data for Name: transport_links; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.transport_links (id, from_id, to_id, kind, duration_min, price_from, aviasales_url, tutu_url, updated_at) FROM stdin;
\.


--
-- Data for Name: user_achievements; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_achievements (user_id, achievement_id, earned_at) FROM stdin;
\.


--
-- Data for Name: user_interests; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_interests (user_id, interest_id, weight) FROM stdin;
\.


--
-- Data for Name: user_place_statuses; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_place_statuses (user_id, post_id, status, planned_date, created_at) FROM stdin;
\.


--
-- Data for Name: user_saved_route_items; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_saved_route_items (id, route_id, post_id, "position") FROM stdin;
\.


--
-- Data for Name: user_saved_routes; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_saved_routes (id, user_id, title, start_lat, start_lng, start_label, ai_generated, ai_route_meta, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_subscriptions; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_subscriptions (follower_id, following_id, created_at) FROM stdin;
\.


--
-- Data for Name: user_swiped_posts; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_swiped_posts (user_id, post_id, direction, created_at) FROM stdin;
\.


--
-- Data for Name: user_tags; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_tags (user_id, tag_id, weight) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.users (id, phone, name, avatar_url, bio, role, taste_profile, created_at, updated_at) FROM stdin;
1	+70000000000	Система	\N	\N	tourist	\N	2026-03-21 20:50:38.688929+00	2026-03-21 20:50:38.688929+00
3	+79001234567	\N	\N	\N	tourist	\N	2026-03-21 21:40:57.878791+00	2026-03-21 21:40:57.878791+00
4	+79999999999	\N	\N	\N	tourist	\N	2026-03-21 21:41:04.695557+00	2026-03-21 21:41:04.695557+00
5	+79002222222	\N	\N	\N	tourist	\N	2026-03-21 23:09:28.245451+00	2026-03-21 23:09:28.245451+00
6	+79003333333	\N	\N	\N	tourist	\N	2026-03-21 23:10:16.889076+00	2026-03-21 23:10:16.889076+00
7	+79004444444	\N	\N	\N	tourist	\N	2026-03-21 23:11:06.066845+00	2026-03-21 23:11:06.066845+00
8	+79005555555	\N	\N	\N	tourist	\N	2026-03-21 23:11:49.249021+00	2026-03-21 23:11:49.249021+00
9	+79006666666	\N	\N	\N	tourist	\N	2026-03-21 23:13:43.537559+00	2026-03-21 23:13:43.537559+00
10	+79007777777	\N	\N	\N	tourist	\N	2026-03-21 23:14:51.925214+00	2026-03-21 23:14:51.925214+00
2	+79001111111	Тест	\N	Люблю вино и горы	tourist	\N	2026-03-21 21:33:21.173067+00	2026-03-22 00:27:24.556422+00
\.


--
-- Data for Name: weather_monthly; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.weather_monthly (region_id, month, temp_min, temp_max, rain_mm, sunny_days, description, fetched_at) FROM stdin;
\.


--
-- Name: achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.achievements_id_seq', 1, false);


--
-- Name: booking_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.booking_items_id_seq', 1, false);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.events_id_seq', 6, true);


--
-- Name: experts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.experts_id_seq', 5, true);


--
-- Name: filter_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.filter_presets_id_seq', 1, true);


--
-- Name: geo_regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.geo_regions_id_seq', 145, true);


--
-- Name: interests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.interests_id_seq', 12, true);


--
-- Name: invites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.invites_id_seq', 1, false);


--
-- Name: offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.offers_id_seq', 4, true);


--
-- Name: place_schedule_overrides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.place_schedule_overrides_id_seq', 1, false);


--
-- Name: place_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.place_schedules_id_seq', 1, false);


--
-- Name: post_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.post_media_id_seq', 1468, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.posts_id_seq', 523, true);


--
-- Name: prompt_compositions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.prompt_compositions_id_seq', 1, false);


--
-- Name: prompt_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.prompt_logs_id_seq', 1, false);


--
-- Name: prompt_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.prompt_templates_id_seq', 1, false);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.reports_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: route_pins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.route_pins_id_seq', 1, false);


--
-- Name: route_segments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.route_segments_id_seq', 84, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.routes_id_seq', 86, true);


--
-- Name: segment_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.segment_items_id_seq', 255, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.services_id_seq', 12, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.tours_id_seq', 1, false);


--
-- Name: transport_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.transport_links_id_seq', 1, false);


--
-- Name: user_saved_route_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.user_saved_route_items_id_seq', 1, false);


--
-- Name: user_saved_routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.user_saved_routes_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: achievements achievements_name_key; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_name_key UNIQUE (name);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: booking_items booking_items_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: experts experts_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.experts
    ADD CONSTRAINT experts_pkey PRIMARY KEY (id);


--
-- Name: filter_presets filter_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.filter_presets
    ADD CONSTRAINT filter_presets_pkey PRIMARY KEY (id);


--
-- Name: geo_regions geo_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.geo_regions
    ADD CONSTRAINT geo_regions_pkey PRIMARY KEY (id);


--
-- Name: geo_regions geo_regions_slug_key; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.geo_regions
    ADD CONSTRAINT geo_regions_slug_key UNIQUE (slug);


--
-- Name: interests interests_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.interests
    ADD CONSTRAINT interests_pkey PRIMARY KEY (id);


--
-- Name: invites invites_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: place_schedule_overrides place_schedule_overrides_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_schedule_overrides
    ADD CONSTRAINT place_schedule_overrides_pkey PRIMARY KEY (id);


--
-- Name: place_schedules place_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_schedules
    ADD CONSTRAINT place_schedules_pkey PRIMARY KEY (id);


--
-- Name: place_tags place_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_tags
    ADD CONSTRAINT place_tags_pkey PRIMARY KEY (post_id, tag_id);


--
-- Name: post_interests post_interests_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.post_interests
    ADD CONSTRAINT post_interests_pkey PRIMARY KEY (post_id, interest_id);


--
-- Name: post_media post_media_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.post_media
    ADD CONSTRAINT post_media_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: prompt_composition_items prompt_composition_items_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_composition_items
    ADD CONSTRAINT prompt_composition_items_pkey PRIMARY KEY (composition_id, template_id);


--
-- Name: prompt_compositions prompt_compositions_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_compositions
    ADD CONSTRAINT prompt_compositions_pkey PRIMARY KEY (id);


--
-- Name: prompt_logs prompt_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_logs
    ADD CONSTRAINT prompt_logs_pkey PRIMARY KEY (id);


--
-- Name: prompt_templates prompt_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_templates
    ADD CONSTRAINT prompt_templates_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: route_pins route_pins_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_pins
    ADD CONSTRAINT route_pins_pkey PRIMARY KEY (id);


--
-- Name: route_segments route_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_segments
    ADD CONSTRAINT route_segments_pkey PRIMARY KEY (id);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: segment_items segment_items_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.segment_items
    ADD CONSTRAINT segment_items_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: similar_places similar_places_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.similar_places
    ADD CONSTRAINT similar_places_pkey PRIMARY KEY (place_id, similar_place_id);


--
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tour_services tour_services_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tour_services
    ADD CONSTRAINT tour_services_pkey PRIMARY KEY (tour_id, service_id);


--
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- Name: transport_links transport_links_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.transport_links
    ADD CONSTRAINT transport_links_pkey PRIMARY KEY (id);


--
-- Name: reviews uq_review_per_user_post; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT uq_review_per_user_post UNIQUE (author_id, post_id);


--
-- Name: transport_links uq_transport_links_from_to_kind; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.transport_links
    ADD CONSTRAINT uq_transport_links_from_to_kind UNIQUE (from_id, to_id, kind);


--
-- Name: user_saved_route_items uq_user_saved_route_position; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_route_items
    ADD CONSTRAINT uq_user_saved_route_position UNIQUE (route_id, "position");


--
-- Name: user_saved_route_items uq_user_saved_route_post; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_route_items
    ADD CONSTRAINT uq_user_saved_route_post UNIQUE (route_id, post_id);


--
-- Name: user_achievements user_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (user_id, achievement_id);


--
-- Name: user_interests user_interests_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_pkey PRIMARY KEY (user_id, interest_id);


--
-- Name: user_place_statuses user_place_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_place_statuses
    ADD CONSTRAINT user_place_statuses_pkey PRIMARY KEY (user_id, post_id);


--
-- Name: user_saved_route_items user_saved_route_items_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_route_items
    ADD CONSTRAINT user_saved_route_items_pkey PRIMARY KEY (id);


--
-- Name: user_saved_routes user_saved_routes_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_routes
    ADD CONSTRAINT user_saved_routes_pkey PRIMARY KEY (id);


--
-- Name: user_subscriptions user_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT user_subscriptions_pkey PRIMARY KEY (follower_id, following_id);


--
-- Name: user_swiped_posts user_swiped_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_swiped_posts
    ADD CONSTRAINT user_swiped_posts_pkey PRIMARY KEY (user_id, post_id);


--
-- Name: user_tags user_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_tags
    ADD CONSTRAINT user_tags_pkey PRIMARY KEY (user_id, tag_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weather_monthly weather_monthly_pkey; Type: CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.weather_monthly
    ADD CONSTRAINT weather_monthly_pkey PRIMARY KEY (region_id, month);


--
-- Name: ix_achievements_interest_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_achievements_interest_id ON public.achievements USING btree (interest_id);


--
-- Name: ix_booking_items_booking_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_booking_items_booking_id ON public.booking_items USING btree (booking_id);


--
-- Name: ix_booking_items_segment_item_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_booking_items_segment_item_id ON public.booking_items USING btree (segment_item_id);


--
-- Name: ix_bookings_route_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_bookings_route_id ON public.bookings USING btree (route_id);


--
-- Name: ix_bookings_user_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_bookings_user_id ON public.bookings USING btree (user_id);


--
-- Name: ix_events_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_events_post_id ON public.events USING btree (post_id);


--
-- Name: ix_experts_region_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_experts_region_id ON public.experts USING btree (region_id);


--
-- Name: ix_experts_user_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_experts_user_id ON public.experts USING btree (user_id);


--
-- Name: ix_filter_presets_user_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_filter_presets_user_id ON public.filter_presets USING btree (user_id);


--
-- Name: ix_geo_regions_parent_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_geo_regions_parent_id ON public.geo_regions USING btree (parent_id);


--
-- Name: ix_interests_emoji; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_interests_emoji ON public.interests USING btree (emoji);


--
-- Name: ix_interests_name; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE UNIQUE INDEX ix_interests_name ON public.interests USING btree (name);


--
-- Name: ix_invites_code; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE UNIQUE INDEX ix_invites_code ON public.invites USING btree (code);


--
-- Name: ix_invites_invitee_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_invites_invitee_id ON public.invites USING btree (invitee_id);


--
-- Name: ix_invites_inviter_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_invites_inviter_id ON public.invites USING btree (inviter_id);


--
-- Name: ix_offers_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_offers_post_id ON public.offers USING btree (post_id);


--
-- Name: ix_place_schedule_overrides_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_place_schedule_overrides_post_id ON public.place_schedule_overrides USING btree (post_id);


--
-- Name: ix_place_schedules_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_place_schedules_post_id ON public.place_schedules USING btree (post_id);


--
-- Name: ix_post_media_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_post_media_post_id ON public.post_media USING btree (post_id);


--
-- Name: ix_posts_author_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_posts_author_id ON public.posts USING btree (author_id);


--
-- Name: ix_posts_partner_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_posts_partner_id ON public.posts USING btree (partner_id);


--
-- Name: ix_posts_region_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_posts_region_id ON public.posts USING btree (region_id);


--
-- Name: ix_prompt_composition_items_composition_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_prompt_composition_items_composition_id ON public.prompt_composition_items USING btree (composition_id);


--
-- Name: ix_prompt_composition_items_template_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_prompt_composition_items_template_id ON public.prompt_composition_items USING btree (template_id);


--
-- Name: ix_prompt_logs_composition_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_prompt_logs_composition_id ON public.prompt_logs USING btree (composition_id);


--
-- Name: ix_prompt_logs_route_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_prompt_logs_route_id ON public.prompt_logs USING btree (route_id);


--
-- Name: ix_prompt_templates_category; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_prompt_templates_category ON public.prompt_templates USING btree (category);


--
-- Name: ix_prompt_templates_slug; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE UNIQUE INDEX ix_prompt_templates_slug ON public.prompt_templates USING btree (slug);


--
-- Name: ix_reports_reporter_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_reports_reporter_id ON public.reports USING btree (reporter_id);


--
-- Name: ix_reports_target_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_reports_target_id ON public.reports USING btree (target_id);


--
-- Name: ix_reviews_author_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_reviews_author_id ON public.reviews USING btree (author_id);


--
-- Name: ix_reviews_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_reviews_post_id ON public.reviews USING btree (post_id);


--
-- Name: ix_route_pins_created_by; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_route_pins_created_by ON public.route_pins USING btree (created_by);


--
-- Name: ix_route_pins_route_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_route_pins_route_id ON public.route_pins USING btree (route_id);


--
-- Name: ix_route_pins_segment_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_route_pins_segment_id ON public.route_pins USING btree (segment_id);


--
-- Name: ix_route_pins_segment_item_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_route_pins_segment_item_id ON public.route_pins USING btree (segment_item_id);


--
-- Name: ix_route_segments_city_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_route_segments_city_id ON public.route_segments USING btree (city_id);


--
-- Name: ix_route_segments_route_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_route_segments_route_id ON public.route_segments USING btree (route_id);


--
-- Name: ix_routes_author_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_routes_author_id ON public.routes USING btree (author_id);


--
-- Name: ix_routes_share_token; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE UNIQUE INDEX ix_routes_share_token ON public.routes USING btree (share_token);


--
-- Name: ix_segment_items_parent_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_segment_items_parent_id ON public.segment_items USING btree (parent_id);


--
-- Name: ix_segment_items_segment_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_segment_items_segment_id ON public.segment_items USING btree (segment_id);


--
-- Name: ix_tours_guide_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_tours_guide_id ON public.tours USING btree (guide_id);


--
-- Name: ix_tours_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_tours_post_id ON public.tours USING btree (post_id);


--
-- Name: ix_tours_publisher_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_tours_publisher_id ON public.tours USING btree (publisher_id);


--
-- Name: ix_transport_links_from_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_transport_links_from_id ON public.transport_links USING btree (from_id);


--
-- Name: ix_transport_links_to_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_transport_links_to_id ON public.transport_links USING btree (to_id);


--
-- Name: ix_user_saved_route_items_post_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_user_saved_route_items_post_id ON public.user_saved_route_items USING btree (post_id);


--
-- Name: ix_user_saved_route_items_route_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_user_saved_route_items_route_id ON public.user_saved_route_items USING btree (route_id);


--
-- Name: ix_user_saved_routes_user_id; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE INDEX ix_user_saved_routes_user_id ON public.user_saved_routes USING btree (user_id);


--
-- Name: ix_users_phone; Type: INDEX; Schema: public; Owner: kraeved_user
--

CREATE UNIQUE INDEX ix_users_phone ON public.users USING btree (phone);


--
-- Name: achievements achievements_interest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_interest_id_fkey FOREIGN KEY (interest_id) REFERENCES public.interests(id) ON DELETE RESTRICT;


--
-- Name: booking_items booking_items_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: booking_items booking_items_segment_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_segment_item_id_fkey FOREIGN KEY (segment_item_id) REFERENCES public.segment_items(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: events events_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: experts experts_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.experts
    ADD CONSTRAINT experts_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.geo_regions(id) ON DELETE SET NULL;


--
-- Name: experts experts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.experts
    ADD CONSTRAINT experts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: filter_presets filter_presets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.filter_presets
    ADD CONSTRAINT filter_presets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: geo_regions geo_regions_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.geo_regions
    ADD CONSTRAINT geo_regions_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.geo_regions(id) ON DELETE SET NULL;


--
-- Name: invites invites_invitee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_invitee_id_fkey FOREIGN KEY (invitee_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: invites invites_inviter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_inviter_id_fkey FOREIGN KEY (inviter_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: offers offers_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: place_schedule_overrides place_schedule_overrides_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_schedule_overrides
    ADD CONSTRAINT place_schedule_overrides_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: place_schedules place_schedules_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_schedules
    ADD CONSTRAINT place_schedules_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: place_tags place_tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_tags
    ADD CONSTRAINT place_tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: place_tags place_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.place_tags
    ADD CONSTRAINT place_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: post_interests post_interests_interest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.post_interests
    ADD CONSTRAINT post_interests_interest_id_fkey FOREIGN KEY (interest_id) REFERENCES public.interests(id) ON DELETE CASCADE;


--
-- Name: post_interests post_interests_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.post_interests
    ADD CONSTRAINT post_interests_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: post_media post_media_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.post_media
    ADD CONSTRAINT post_media_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: posts posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: posts posts_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: posts posts_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.geo_regions(id) ON DELETE SET NULL;


--
-- Name: prompt_composition_items prompt_composition_items_composition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_composition_items
    ADD CONSTRAINT prompt_composition_items_composition_id_fkey FOREIGN KEY (composition_id) REFERENCES public.prompt_compositions(id) ON DELETE CASCADE;


--
-- Name: prompt_composition_items prompt_composition_items_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_composition_items
    ADD CONSTRAINT prompt_composition_items_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.prompt_templates(id) ON DELETE CASCADE;


--
-- Name: prompt_logs prompt_logs_composition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_logs
    ADD CONSTRAINT prompt_logs_composition_id_fkey FOREIGN KEY (composition_id) REFERENCES public.prompt_compositions(id) ON DELETE SET NULL;


--
-- Name: prompt_logs prompt_logs_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.prompt_logs
    ADD CONSTRAINT prompt_logs_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id) ON DELETE CASCADE;


--
-- Name: reports reports_reporter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: route_pins route_pins_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_pins
    ADD CONSTRAINT route_pins_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: route_pins route_pins_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_pins
    ADD CONSTRAINT route_pins_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id) ON DELETE CASCADE;


--
-- Name: route_pins route_pins_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_pins
    ADD CONSTRAINT route_pins_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES public.route_segments(id) ON DELETE SET NULL;


--
-- Name: route_pins route_pins_segment_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_pins
    ADD CONSTRAINT route_pins_segment_item_id_fkey FOREIGN KEY (segment_item_id) REFERENCES public.segment_items(id) ON DELETE SET NULL;


--
-- Name: route_segments route_segments_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_segments
    ADD CONSTRAINT route_segments_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.geo_regions(id) ON DELETE SET NULL;


--
-- Name: route_segments route_segments_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.route_segments
    ADD CONSTRAINT route_segments_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id) ON DELETE CASCADE;


--
-- Name: routes routes_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: segment_items segment_items_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.segment_items
    ADD CONSTRAINT segment_items_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.segment_items(id) ON DELETE SET NULL;


--
-- Name: segment_items segment_items_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.segment_items
    ADD CONSTRAINT segment_items_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES public.route_segments(id) ON DELETE CASCADE;


--
-- Name: similar_places similar_places_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.similar_places
    ADD CONSTRAINT similar_places_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: similar_places similar_places_similar_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.similar_places
    ADD CONSTRAINT similar_places_similar_place_id_fkey FOREIGN KEY (similar_place_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: tour_services tour_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tour_services
    ADD CONSTRAINT tour_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: tour_services tour_services_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tour_services
    ADD CONSTRAINT tour_services_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id) ON DELETE CASCADE;


--
-- Name: tours tours_guide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_guide_id_fkey FOREIGN KEY (guide_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tours tours_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: tours tours_publisher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: transport_links transport_links_from_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.transport_links
    ADD CONSTRAINT transport_links_from_id_fkey FOREIGN KEY (from_id) REFERENCES public.geo_regions(id) ON DELETE CASCADE;


--
-- Name: transport_links transport_links_to_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.transport_links
    ADD CONSTRAINT transport_links_to_id_fkey FOREIGN KEY (to_id) REFERENCES public.geo_regions(id) ON DELETE CASCADE;


--
-- Name: user_achievements user_achievements_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id) ON DELETE CASCADE;


--
-- Name: user_achievements user_achievements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_interests user_interests_interest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_interest_id_fkey FOREIGN KEY (interest_id) REFERENCES public.interests(id) ON DELETE CASCADE;


--
-- Name: user_interests user_interests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_interests
    ADD CONSTRAINT user_interests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_place_statuses user_place_statuses_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_place_statuses
    ADD CONSTRAINT user_place_statuses_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: user_place_statuses user_place_statuses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_place_statuses
    ADD CONSTRAINT user_place_statuses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_saved_route_items user_saved_route_items_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_route_items
    ADD CONSTRAINT user_saved_route_items_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: user_saved_route_items user_saved_route_items_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_route_items
    ADD CONSTRAINT user_saved_route_items_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.user_saved_routes(id) ON DELETE CASCADE;


--
-- Name: user_saved_routes user_saved_routes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_saved_routes
    ADD CONSTRAINT user_saved_routes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_subscriptions user_subscriptions_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT user_subscriptions_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_subscriptions user_subscriptions_following_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT user_subscriptions_following_id_fkey FOREIGN KEY (following_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_swiped_posts user_swiped_posts_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_swiped_posts
    ADD CONSTRAINT user_swiped_posts_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: user_swiped_posts user_swiped_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_swiped_posts
    ADD CONSTRAINT user_swiped_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_tags user_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_tags
    ADD CONSTRAINT user_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: user_tags user_tags_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.user_tags
    ADD CONSTRAINT user_tags_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: weather_monthly weather_monthly_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kraeved_user
--

ALTER TABLE ONLY public.weather_monthly
    ADD CONSTRAINT weather_monthly_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.geo_regions(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict jeFRjB6cMDWyrRHn6ATBmVRKsx7cY2XcAPCCuO8aHpX9Utb7Vr6aFUW4MoXPthF

