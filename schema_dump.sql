--
-- PostgreSQL database dump
--

\restrict ZxWiRCbnoJ6dpAxNN3XXoQdgTxWlcFg6t8ZMGoujz7gCtEm9eBKwedaOzA5FAzm

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
    'narrating'
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
    updated_at timestamp with time zone DEFAULT now() NOT NULL
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

\unrestrict ZxWiRCbnoJ6dpAxNN3XXoQdgTxWlcFg6t8ZMGoujz7gCtEm9eBKwedaOzA5FAzm

