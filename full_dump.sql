--
-- PostgreSQL database dump
--

\restrict 7adqeDySmF3vgpj6QiSJNWDap2u0moiFaXyJcseAwOZWXGpuoPRrneGwUoCai7B

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
1469	524	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Абрау-Дюрсо	0	2026-03-22 00:47:20.253676+00
1470	524	https://images.unsplash.com/photo-1474722883778-792e7990302f?w=800	Абрау-Дюрсо	1	2026-03-22 00:47:20.253676+00
1471	525	https://images.unsplash.com/photo-1551524559-8af4e6624178?w=800	Skypark AJ Hackett Сочи	0	2026-03-22 00:47:20.253676+00
1472	525	https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800	Skypark AJ Hackett Сочи	1	2026-03-22 00:47:20.253676+00
1473	526	https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=800	Парк Галицкого	0	2026-03-22 00:47:20.253676+00
1474	526	https://images.unsplash.com/photo-1588714477688-cf28a50e94f7?w=800	Парк Галицкого	1	2026-03-22 00:47:20.253676+00
1475	527	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	33 водопада	0	2026-03-22 00:47:20.253676+00
1476	527	https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=800	33 водопада	1	2026-03-22 00:47:20.253676+00
1477	528	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня Лефкадия	0	2026-03-22 00:47:20.253676+00
1478	528	https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800	Винодельня Лефкадия	1	2026-03-22 00:47:20.253676+00
1479	529	https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800	Роза Хутор	0	2026-03-22 00:47:20.253676+00
1480	529	https://images.unsplash.com/photo-1486911278844-a81c5267e227?w=800	Роза Хутор	1	2026-03-22 00:47:20.253676+00
1481	530	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Кипарисовое озеро	0	2026-03-22 00:47:20.253676+00
1482	530	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Кипарисовое озеро	1	2026-03-22 00:47:20.253676+00
1483	531	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Гуамское ущелье	0	2026-03-22 00:47:20.253676+00
1484	531	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Гуамское ущелье	1	2026-03-22 00:47:20.253676+00
1485	532	https://images.unsplash.com/photo-1500595046743-cd271d694d30?w=800	Ферма Экзархо	0	2026-03-22 00:47:20.253676+00
1486	532	https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=800	Ферма Экзархо	1	2026-03-22 00:47:20.253676+00
1487	533	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Старый парк в Кабардинке	0	2026-03-22 00:47:20.253676+00
1488	533	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Старый парк в Кабардинке	1	2026-03-22 00:47:20.253676+00
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.posts (id, author_id, title, description, geo_lat, geo_lng, season, region_id, address, phone, email, website, need_car, price_level, duration_hours, best_angle, partner_id, verified, rating_avg, reviews_count, created_at, updated_at, city) FROM stdin;
528	1	Винодельня Лефкадия	Биодинамическое виноделие, сыроварня, оливковое масло. Обед на веранде с видом на виноградники.	44.7486	37.7231	autumn	79	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Крымск
529	1	Роза Хутор	Горный курорт. Зимой лыжи, летом трекинг. Набережная как в Австрии, подъёмник на Роза Пик 2320м.	43.6615	40.304	winter	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Красная Поляна
530	1	Кипарисовое озеро	Болотные кипарисы растут прямо из воды. Рассвет — лучшее время, народу никого. Сукко, 15 минут от Анапы.	44.8103	37.4392	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Анапа
531	1	Гуамское ущелье	Узкоколейка по краю обрыва 400 метров. Поезд идёт медленно, можно снимать. Скалы, река Курджипс.	44.2458	39.9217	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Апшеронск
524	1	Абрау-Дюрсо	Винодельня с дегустацией игристых вин. Озеро, парк, лавка сыров. Экскурсия по подвалам — обязательно.	44.6977	37.5977	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Новороссийск
525	1	Skypark AJ Hackett Сочи	Банджи-джампинг 207 метров, самый длинный подвесной мост в мире. Ахштырское ущелье под ногами.	43.5281	40.0206	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Сочи
526	1	Парк Галицкого	Лучший городской парк России по версии всех рейтингов. Террасы, амфитеатр, зеркальный лабиринт. Вечером подсветка.	45.0428	38.9581	spring	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Краснодар
527	1	33 водопада	Каскад водопадов в ущелье Джегош. Лёгкая тропа вдоль ручья, купель внизу. Мокро, скользко, красиво.	43.8383	39.5583	spring	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Сочи
532	1	Ферма Экзархо	Козий сыр, экскурсия по ферме, мастер-класс по варке моцареллы. Берите сумку-холодильник.	44.8956	37.8469	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Новороссийск
533	1	Старый парк в Кабардинке	Архитектурный парк: египетский храм, средневековый замок, японский сад. Всё в одном месте, без толп.	44.6528	37.9336	spring	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 00:47:20.253676+00	2026-03-22 00:47:20.253676+00	Кабардинка
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

SELECT pg_catalog.setval('public.post_media_id_seq', 1488, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.posts_id_seq', 533, true);


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

\unrestrict 7adqeDySmF3vgpj6QiSJNWDap2u0moiFaXyJcseAwOZWXGpuoPRrneGwUoCai7B

