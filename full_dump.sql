--
-- PostgreSQL database dump
--

\restrict 9ShAh0g1jTJjdOJK1S5ozCDBwTZ6efVmM5wh86pZJQUpV1G4BfeLgsrzyKjF6Ao

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
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    photo_url text
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

COPY public.geo_regions (id, name, slug, type, parent_id, polygon, centroid, population, timezone, created_at, photo_url) FROM stdin;
3	городской округ Краснодар	gorodskoy-okrug-krasnodar	district	2	{"type": "Polygon", "coordinates": [[[38.8105254, 45.2131433], [38.7561737, 45.1756316], [38.8883714, 45.173017], [38.8816815, 45.1737815], [38.8701801, 45.180631], [38.8566656, 45.1760605], [38.958573, 45.1695043], [39.0033602, 45.1851445], [38.999516, 45.1917331], [38.9858944, 45.1920144], [38.9765604, 45.1836445], [38.9733803, 45.1759832], [38.9655431, 45.1758972], [38.9589869, 45.1736857], [39.0027148, 45.1453933], [39.0294756, 45.1440827], [39.0063812, 45.140839], [39.0291178, 45.1500113], [39.0582917, 45.1678739], [39.0805411, 45.2029458], [39.0553307, 45.2039963], [39.1774727, 45.1555966], [39.1261109, 45.1659614], [39.1308855, 45.1924707], [39.1862649, 45.1027076], [39.185895, 45.133349], [39.2623244, 45.1118016], [39.3127347, 45.1249721], [39.3850758, 45.077695], [39.3765743, 45.1165098], [39.3777076, 45.0647934], [39.3529464, 45.0449485], [39.326915, 45.0449049], [39.3262075, 45.0328771], [39.3053747, 45.0302179], [39.2866149, 45.0168165], [39.2730809, 45.0242346], [39.2741011, 45.0307093], [39.2645819, 45.0199981], [39.2647991, 45.009831], [39.2325186, 45.010386], [39.2371487, 45.0172909], [39.2237032, 45.0092839], [39.2225887, 44.9893471], [39.2039061, 45.0000759], [39.1887661, 44.9939952], [39.1623202, 44.9940037], [39.1363194, 44.9986606], [39.1228481, 44.9966805], [39.1151452, 44.9978858], [39.1008774, 44.9888769], [39.0798585, 44.9888599], [39.076418, 44.9799876], [39.0599388, 44.9742876], [39.0446063, 44.9847029], [39.0331137, 44.9794544], [39.0224589, 44.9679589], [39.019048, 44.9758544], [39.0179863, 44.9891874], [39.0179427, 44.9981427], [39.0142255, 45.0039787], [38.9989665, 45.0031934], [38.9861566, 45.0092018], [38.9742182, 45.0082843], [38.9709203, 44.9928208], [38.9569113, 44.995741], [38.9521237, 45.0043406], [38.9471379, 45.0165492], [38.9572428, 45.0271379], [38.9547322, 45.0346573], [38.9461866, 45.0362695], [38.9282681, 45.0315257], [38.9071594, 45.0222659], [38.8995357, 45.029409], [38.9075326, 45.0402217], [38.9092683, 45.0481367], [38.899565, 45.054009], [38.8848832, 45.0446982], [38.8656523, 45.0350151], [38.8535482, 45.0249046], [38.864786, 45.013267], [38.8590595, 45.0010404], [38.8483776, 45.0077274], [38.8324024, 45.005415], [38.8213008, 45.0120489], [38.8129209, 45.0014474], [38.798707, 44.9982608], [38.7779748, 45.0124529], [38.7686202, 45.0285783], [38.7585874, 45.0423215], [38.7679097, 45.0566392], [38.746158, 45.057853], [38.7328062, 45.043156], [38.7186078, 45.0467572], [38.7055537, 45.0655051], [38.6603523, 45.0654971], [38.6821228, 45.0762597], [38.695899, 45.067156], [38.7724398, 45.1594373], [38.7849377, 45.1451996], [38.7220812, 45.0987757], [38.707591, 45.0786762], [38.6866359, 45.0853399], [38.6806619, 45.0897593], [38.6732346, 45.0979917], [38.672774, 45.0887239], [38.6602923, 45.0773135], [38.6496276, 45.0661283], [38.8105254, 45.2131433]]]}	45.0937763,39.0164697	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
4	Динской район	dinskoy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.0081507, 45.1840834], [39.0388575, 45.1678054], [39.1113368, 45.1923922], [39.0637119, 45.2038962], [39.0386781, 45.2041107], [39.1790201, 45.1552797], [39.1416456, 45.1626884], [39.1348606, 45.1925818], [39.1306895, 45.1925889], [39.1862926, 45.0991312], [39.1861499, 45.1293364], [39.1862926, 45.0991312], [39.2624627, 45.0996237], [39.3128555, 45.13428], [39.2832654, 45.1248157], [39.368995, 45.1094418], [39.3763766, 45.1342665], [39.4818733, 45.1373803], [39.4727296, 45.133426], [39.4678024, 45.1282835], [39.4720393, 45.1220926], [39.461005, 45.1212012], [39.4541436, 45.1204918], [39.4607021, 45.1161903], [39.4675763, 45.1079127], [39.4591022, 45.1030699], [39.4458301, 45.1083508], [39.4385491, 45.1104624], [39.4292356, 45.0976739], [39.4153878, 45.0905748], [39.4033932, 45.0936769], [39.4004655, 45.0844709], [39.4007953, 45.0774824], [39.5030427, 45.2455506], [39.4906846, 45.1750153], [39.4013257, 45.2460738], [39.3753887, 45.2548112], [39.4207082, 45.3200196], [39.3804111, 45.3031398], [39.2652527, 45.3298073], [39.2864627, 45.3343013], [39.2945674, 45.3391117], [39.3031858, 45.3411432], [39.3120819, 45.3397047], [39.3318943, 45.3388337], [39.1984468, 45.3634429], [39.208742, 45.3668613], [39.2132193, 45.3635888], [39.2263, 45.3656609], [39.2380825, 45.3669001], [39.2594733, 45.3676188], [39.195213, 45.3852471], [39.0315373, 45.3746804], [39.0745654, 45.3812469], [39.0787223, 45.3861149], [39.0869796, 45.3846146], [39.0933951, 45.3901243], [39.1010975, 45.3899445], [39.1066766, 45.3897212], [39.1138086, 45.3908844], [39.1205897, 45.3906319], [39.135599, 45.3896163], [39.1397106, 45.3872449], [38.917111, 45.3787368], [38.8145911, 45.3363148], [38.8327716, 45.390265], [38.811535, 45.3334131], [38.6753573, 45.2958807], [38.7495209, 45.3337264], [38.7622681, 45.3188651], [38.7608425, 45.3005266], [38.785249, 45.3152568], [38.7931104, 45.3143131], [38.8092397, 45.3308701], [38.7631058, 45.1701393], [38.728862, 45.1798566], [38.7132466, 45.1875053], [38.697521, 45.1943373], [38.6892257, 45.2023502], [38.787202, 45.2098217], [38.7598473, 45.1728006], [38.8884279, 45.1725873], [38.8843262, 45.1745143], [38.875935, 45.1757115], [38.8683965, 45.1801217], [38.8695758, 45.1837232], [38.837522, 45.1936221], [39.0079575, 45.1826825], [39.0032206, 45.1858447], [38.9998483, 45.1912698], [38.9882694, 45.2003833], [38.9856924, 45.1823173], [38.9756044, 45.1842337], [38.973448, 45.1779039], [38.9694987, 45.1750709], [38.961973, 45.1771013], [38.9589235, 45.1733332], [39.0028451, 45.144414], [39.0050461, 45.1621557], [39.0189956, 45.1394682], [39.0053894, 45.1412926], [39.0394217, 45.1501441], [39.0081507, 45.1840834]]]}	45.2512976,39.0729717	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
5	Красноармейский район	krasnoarmeyskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[38.6402496, 45.271538], [38.6365986, 45.3393965], [38.6287497, 45.3416498], [38.6214953, 45.3435044], [38.6173172, 45.3441538], [38.6021962, 45.3476751], [38.5942306, 45.3530101], [38.5898625, 45.3676623], [38.5399142, 45.3661025], [38.5383555, 45.388125], [38.5269416, 45.4302537], [38.5300152, 45.4348543], [38.5198277, 45.4447747], [38.4974278, 45.4672339], [38.4675474, 45.4826251], [38.4838933, 45.5152567], [38.4798692, 45.5289826], [38.4524586, 45.5435194], [38.4215306, 45.5198102], [38.403756, 45.5129526], [38.3593636, 45.5158462], [38.2672075, 45.5318642], [38.2667973, 45.5819824], [38.2459884, 45.5928717], [38.1601591, 45.5889749], [38.1240118, 45.5904366], [38.1104971, 45.5836653], [38.10311, 45.5712332], [38.0774671, 45.5536686], [38.0697861, 45.5372908], [38.0688898, 45.5260808], [38.0744761, 45.5195282], [38.072255, 45.5089139], [38.0682411, 45.4967034], [38.0684734, 45.4902302], [38.061821, 45.4814179], [38.0520331, 45.4779416], [38.0480096, 45.4643089], [38.0549788, 45.4583779], [38.0558151, 45.4506645], [38.0553656, 45.4344629], [38.0667785, 45.4258672], [38.052521, 45.417402], [38.0585025, 45.4008977], [38.0531416, 45.3883564], [38.0524693, 45.3774852], [38.0340649, 45.3580429], [38.0345529, 45.3524306], [38.0296444, 45.3409653], [38.0313354, 45.3306079], [38.0557238, 45.3178157], [38.0760484, 45.3149867], [38.116379, 45.3103478], [38.1220922, 45.2885972], [38.127303, 45.2736043], [38.1506305, 45.2570392], [38.1647746, 45.2372561], [38.1767893, 45.2300714], [38.1843294, 45.2165111], [38.2035393, 45.213299], [38.2015459, 45.1923177], [38.214183, 45.1895385], [38.2387796, 45.1786152], [38.25623, 45.179204], [38.25585, 45.1655099], [38.2736999, 45.1685758], [38.2859591, 45.1589591], [38.3010997, 45.1689337], [38.3172348, 45.1689324], [38.3407997, 45.1549441], [38.343315, 45.143026], [38.3779284, 45.1249865], [38.3948062, 45.1308112], [38.4071017, 45.1212041], [38.4286954, 45.1211363], [38.4492024, 45.1127377], [38.4495955, 45.0959171], [38.4765156, 45.0830096], [38.4814687, 45.0988825], [38.4988063, 45.1148348], [38.50447, 45.1014394], [38.5212695, 45.1085204], [38.5468224, 45.1087733], [38.570938, 45.096357], [38.5862308, 45.1012548], [38.5871414, 45.075595], [38.5996365, 45.0665462], [38.6123546, 45.0735622], [38.6122985, 45.0852569], [38.6287871, 45.0651448], [38.644774, 45.0603556], [38.7619209, 45.1652378], [38.7771641, 45.1521856], [38.7622888, 45.1028901], [38.711594, 45.1064082], [38.7029454, 45.0808616], [38.6866359, 45.0853399], [38.68115, 45.089052], [38.67719, 45.0990888], [38.6666965, 45.0944886], [38.6616322, 45.0787395], [38.6571802, 45.0703197], [38.6490248, 45.0633829], [38.728862, 45.1798566], [38.7120675, 45.1876949], [38.6938117, 45.1981089], [38.688066, 45.2037951], [38.6402496, 45.271538]]]}	45.3258944,38.4107362	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
6	Северский район	severskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[38.5583794, 45.0407536], [38.548369, 45.036732], [38.5358902, 45.0375041], [38.529969, 45.044616], [38.5207315, 45.0463206], [38.5111619, 45.0467933], [38.50254, 45.045939], [38.498133, 45.050568], [38.4693335, 45.0322181], [38.4461189, 44.9787973], [38.4858648, 44.9532123], [38.5037466, 44.9464719], [38.5001556, 44.9383542], [38.4929831, 44.9188123], [38.4552406, 44.8686566], [38.4537518, 44.8637921], [38.4528428, 44.8592126], [38.4519371, 44.8575563], [38.4524564, 44.8546572], [38.453065, 44.850265], [38.4457289, 44.8467428], [38.4472908, 44.8401728], [38.4446126, 44.8350474], [38.4427355, 44.8314697], [38.4372982, 44.8227169], [38.4346748, 44.8182065], [38.4338061, 44.8147832], [38.4342005, 44.8096406], [38.4300246, 44.8028955], [38.4320541, 44.796709], [38.4275774, 44.7914298], [38.4261444, 44.787167], [38.4188127, 44.7751538], [38.4192807, 44.7705395], [38.4204899, 44.7661475], [38.4197559, 44.763336], [38.415066, 44.7563266], [38.4207541, 44.7112806], [38.4120901, 44.7111607], [38.404329, 44.7110957], [38.3902675, 44.6934295], [38.4245659, 44.6718504], [38.4146901, 44.6584717], [38.4077601, 44.6493253], [38.4224442, 44.6392798], [38.4385059, 44.6342735], [38.4567793, 44.6321146], [38.4818547, 44.6274438], [38.5002818, 44.6142976], [38.5097008, 44.5979852], [38.5207991, 44.5891085], [38.5266114, 44.54986], [38.5483374, 44.5506104], [38.5692828, 44.54409], [38.5841076, 44.5335111], [38.6016432, 44.5300316], [38.6227843, 44.517604], [38.6489661, 44.4942462], [38.6601387, 44.4904328], [38.6775061, 44.4890949], [38.7140956, 44.4945222], [38.7353103, 44.5031846], [38.773218, 44.5090346], [38.7994351, 44.5112681], [38.8374066, 44.5092553], [38.8737881, 44.5055308], [38.884097, 44.527593], [38.8945923, 44.5236115], [38.9081614, 44.5325387], [38.9333842, 44.5445754], [38.9307251, 44.5653099], [38.9340133, 44.5860046], [38.942757, 44.603514], [38.961245, 44.6251623], [38.9837875, 44.6391314], [39.0301688, 44.639466], [39.0004405, 44.681717], [39.0225588, 44.7077601], [38.9897008, 44.8143323], [38.9862986, 44.8552628], [38.8334564, 44.9326752], [38.8462548, 44.9221512], [38.8517266, 44.9164518], [38.8550757, 44.9075867], [38.861918, 44.8988213], [38.8545493, 44.8952319], [38.87586, 44.8903227], [38.7470977, 44.9496278], [38.7549873, 44.9504963], [38.7584648, 44.9550276], [38.7723581, 44.9593429], [38.7807756, 44.9667693], [38.7873268, 44.9565323], [38.7852038, 44.9447937], [38.8095784, 44.9398264], [38.8204656, 44.9406435], [38.6931124, 45.0641566], [38.6603523, 45.0654971], [38.6888189, 45.0712899], [38.6061583, 45.066895], [38.6132212, 45.0846827], [38.644774, 45.0603556], [38.5843595, 45.0719529], [38.5583794, 45.0407536]]]}	44.7870953,38.7177143	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
7	Абинский район	abinskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[38.2168536, 45.188832], [38.2297748, 45.1814224], [38.2648262, 45.1660874], [38.3053187, 45.1719668], [38.3421824, 45.1443015], [38.4046703, 45.126409], [38.4493295, 45.1058794], [38.4814687, 45.0988825], [38.5163895, 45.1079743], [38.5754184, 45.1009357], [38.5848539, 45.0731072], [38.5496544, 45.0381752], [38.534017, 45.038254], [38.5243577, 45.0458036], [38.508034, 45.045396], [38.500084, 45.047429], [38.4693335, 45.0322181], [38.4510619, 44.9624172], [38.5035879, 44.9468339], [38.4987417, 44.9343388], [38.4714339, 44.8693305], [38.4531455, 44.8622259], [38.4522741, 44.8580755], [38.4521826, 44.8540242], [38.447746, 44.849369], [38.4457811, 44.8396301], [38.4444985, 44.832242], [38.4382155, 44.8226283], [38.4335861, 44.8177344], [38.4342005, 44.8096406], [38.4301005, 44.8000788], [38.4281385, 44.7915335], [38.4240911, 44.7838239], [38.419119, 44.7712404], [38.420223, 44.7650035], [38.4166227, 44.757734], [38.4166382, 44.7114599], [38.4075258, 44.7108222], [38.3925958, 44.6908339], [38.4162599, 44.6624363], [38.4055277, 44.648443], [38.2936749, 44.5988437], [38.3310992, 44.6059484], [38.3515647, 44.6101248], [38.3634162, 44.6038842], [38.3736005, 44.601941], [38.3812333, 44.602649], [38.3902493, 44.5953943], [38.3992972, 44.5904662], [38.4078128, 44.5838248], [38.4262195, 44.5925133], [38.4237757, 44.6237234], [38.1231343, 44.6714462], [38.1237702, 44.6625463], [38.1233507, 44.6551402], [38.1332577, 44.6604769], [38.1312283, 44.6565269], [38.1261818, 44.6530559], [38.1359978, 44.6454662], [38.1313032, 44.6384623], [38.1361647, 44.6356746], [38.1435753, 44.6410055], [38.1570119, 44.644874], [38.1565813, 44.6416846], [38.151484, 44.641133], [38.145804, 44.6393932], [38.1398267, 44.6356947], [38.1362982, 44.6323331], [38.1401402, 44.6306331], [38.1423668, 44.6275525], [38.1510371, 44.62734], [38.1563018, 44.6244708], [38.1674845, 44.6289625], [38.1605514, 44.6218692], [38.1769901, 44.6200481], [38.1834069, 44.6202856], [38.1903353, 44.6182578], [38.1958267, 44.6157079], [38.2033828, 44.6148377], [38.2183225, 44.6152056], [38.2365322, 44.6108324], [38.2602888, 44.6092884], [38.2818783, 44.6022516], [37.9959556, 44.7273994], [37.9933363, 44.7110412], [38.0554523, 44.6511768], [38.1081694, 44.6656264], [38.1155763, 44.6660896], [38.0084747, 44.768148], [38.0050723, 44.7600933], [37.9999459, 44.7530084], [37.9940328, 44.7480827], [38.0983256, 44.9192061], [38.0963175, 44.9092243], [38.0946111, 44.9032756], [38.0938315, 44.8963255], [38.0849662, 44.8840102], [38.081764, 44.8774637], [38.0786157, 44.8695694], [38.0854432, 44.8562958], [38.0815529, 44.8162285], [38.1609997, 44.9600104], [38.2131873, 45.0332567], [38.1872001, 45.0120233], [38.2145776, 45.043887], [38.2168536, 45.188832]]]}	44.8849241,38.2878967	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
8	Славянский район	slavyanskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[37.5752075, 45.413424], [37.6087081, 45.4016491], [37.641899, 45.3754954], [37.6527429, 45.3693579], [37.7130228, 45.311102], [37.7126993, 45.2814571], [37.6945265, 45.2402712], [37.6827834, 45.2097301], [37.6753464, 45.1914071], [37.6561868, 45.1819569], [37.6755413, 45.1596668], [37.7422183, 45.1639104], [37.7732559, 45.1463656], [37.8079371, 45.1229798], [37.8423712, 45.1439283], [37.8870655, 45.1422478], [37.9415733, 45.1465216], [37.9604236, 45.1423896], [38.0176794, 45.1420611], [38.0463346, 45.1484594], [38.102671, 45.1647498], [38.1420965, 45.1408017], [38.1933636, 45.1641225], [38.186166, 45.2262392], [38.117752, 45.283047], [38.1767893, 45.2300714], [38.0795457, 45.3128254], [38.0557283, 45.3832224], [38.0350292, 45.3459128], [38.0586513, 45.4486077], [38.06694, 45.489168], [38.0750799, 45.5515759], [38.0766637, 45.5118503], [38.116379, 45.585195], [38.1351825, 45.5974177], [38.1469922, 45.614526], [38.1511033, 45.6428979], [38.1201497, 45.65299], [38.0753982, 45.6630743], [38.0679981, 45.6885457], [38.0434608, 45.6900553], [38.0320256, 45.7028485], [38.01769, 45.6828367], [37.9680276, 45.6724991], [37.9176482, 45.6945969], [37.8931278, 45.675865], [37.8563565, 45.675909], [37.8310243, 45.6789338], [37.7953211, 45.6786814], [37.7858238, 45.7044933], [37.7844155, 45.744329], [37.7758752, 45.737987], [37.765472, 45.730527], [37.7634683, 45.7218339], [37.752078, 45.715119], [37.7416876, 45.7118769], [37.7344188, 45.7085805], [37.7275202, 45.7057166], [37.7201709, 45.7031841], [37.7143988, 45.7021417], [37.707248, 45.7006515], [37.6998371, 45.6994339], [37.6918924, 45.6979483], [37.6855376, 45.6967957], [37.6781997, 45.694904], [37.652585, 45.687695], [37.6458013, 45.6836078], [37.6299441, 45.6740316], [37.6258457, 45.6709644], [37.6208675, 45.6670574], [37.6156211, 45.6619194], [37.612043, 45.6571016], [37.6091623, 45.6508659], [37.6073116, 45.6454283], [37.6053214, 45.6395063], [37.6047662, 45.6342777], [37.6037228, 45.6306766], [37.6026446, 45.6259574], [37.6020867, 45.6195081], [37.6013222, 45.6129042], [37.6006758, 45.6068568], [37.6007295, 45.602068], [37.6001662, 45.5953776], [37.5996351, 45.5890337], [37.5989002, 45.5773012], [37.598699, 45.5644001], [37.5987366, 45.5529873], [37.5989538, 45.5431108], [37.599442, 45.5241643], [37.5994602, 45.4999766], [37.6017425, 45.4928793], [37.5993615, 45.4833718], [37.602746, 45.476613], [37.604674, 45.487155], [37.604261, 45.474323], [37.5986031, 45.4581108], [37.5928485, 45.448829], [37.5908209, 45.4388231], [37.5875831, 45.4337118], [37.5846021, 45.4263999], [37.5781713, 45.4177586], [37.5997977, 45.4627591], [37.594823, 45.4631882], [37.5752075, 45.413424]]]}	45.4322275,37.8912155	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
9	Крымский район	krymskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[37.9885215, 44.7355152], [37.9790593, 44.7411813], [37.9613733, 44.7434084], [37.9422634, 44.7514353], [37.9178444, 44.7606283], [37.8786735, 44.7897264], [37.8670312, 44.7812932], [37.8575041, 44.787451], [37.8635406, 44.7929609], [37.86215, 44.8307826], [37.7989631, 44.8442908], [37.7831659, 44.868018], [37.7795204, 44.8795775], [37.7666125, 44.8896081], [37.7563844, 44.8918629], [37.7361588, 44.8865403], [37.7164397, 44.8819842], [37.7408505, 44.904283], [37.6999137, 44.9187035], [37.6962791, 44.9289791], [37.6518195, 44.947129], [37.6328175, 44.9617776], [37.6449739, 44.9989725], [37.6516632, 45.01172], [37.6463279, 45.0131746], [37.6396511, 45.0158023], [37.639167, 45.0184593], [37.6350929, 45.0207773], [37.6230491, 45.0203186], [37.6125545, 45.0270446], [37.5811855, 45.0404193], [37.5460184, 45.0591701], [37.5450171, 45.0620541], [37.5427961, 45.0669365], [37.5377695, 45.0742751], [37.5325374, 45.081488], [37.5247112, 45.0899432], [37.5214592, 45.097193], [37.5191841, 45.1072288], [37.4995536, 45.1512828], [37.4724858, 45.1546891], [37.4532155, 45.1662206], [37.4700318, 45.1785003], [37.4786454, 45.1836397], [37.4878767, 45.1840134], [37.5000658, 45.1789852], [37.518997, 45.163351], [37.526894, 45.1520197], [37.560749, 45.1535382], [37.5880064, 45.1520716], [37.6523699, 45.149967], [37.6724559, 45.159066], [37.7045068, 45.1659919], [37.7422183, 45.1639104], [37.7729817, 45.1571819], [37.7765584, 45.1437064], [37.7741988, 45.126466], [37.8127212, 45.1277576], [37.834347, 45.1340235], [37.8444547, 45.1402412], [37.8770989, 45.1300418], [37.8994887, 45.142918], [37.9236992, 45.1423343], [37.949028, 45.144226], [37.9604923, 45.1367463], [37.9699614, 45.1394005], [38.0090505, 45.1371167], [38.0260771, 45.1456136], [38.040628, 45.1491088], [38.0623438, 45.1554736], [38.094406, 45.160517], [38.1166859, 45.1534674], [38.1361198, 45.1387974], [38.1545315, 45.1493831], [38.1831947, 45.1603121], [38.2081226, 45.1798905], [38.2168536, 45.188832], [38.2170093, 45.0959911], [38.2144745, 45.0456497], [38.2135463, 45.0299226], [38.1972499, 45.0206917], [38.1461623, 45.0054144], [38.169345, 44.9810078], [38.1307237, 44.9231307], [38.102726, 44.9119429], [38.0965648, 44.9094375], [38.0955392, 44.9060972], [38.0931072, 44.9014289], [38.0926218, 44.8971348], [38.0885217, 44.892457], [38.0850736, 44.8830476], [38.0829873, 44.8784254], [38.0793038, 44.8754887], [38.0786157, 44.8695694], [38.0764762, 44.8644871], [38.0864009, 44.856089], [38.0843997, 44.8362857], [38.0433555, 44.7694723], [38.0081843, 44.7666885], [38.0055586, 44.761671], [38.00346, 44.7568079], [37.9990255, 44.7528477], [37.9949623, 44.7501577], [37.9907486, 44.7468653], [37.9885215, 44.7355152]]]}	44.9625269,37.8329466	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
10	Темрюкский район	temryukskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[36.5922745, 45.2452927], [36.6057449, 45.2267993], [36.602759, 45.2063261], [36.6060972, 45.1901221], [36.616555, 45.1706608], [36.6222187, 45.1574626], [36.6324019, 45.1429853], [36.6462421, 45.1356731], [36.6786004, 45.130047], [36.7131695, 45.1207766], [36.7433129, 45.1090828], [36.774427, 45.115215], [36.8391426, 45.116419], [37.040464, 45.1080907], [37.3261509, 45.149788], [37.2171251, 45.0840592], [37.4791342, 45.1816286], [37.5800005, 45.1527126], [37.6835966, 45.2201831], [37.6597701, 45.1695636], [37.7171669, 45.3051784], [37.5681961, 45.4083873], [37.5476915, 45.3910855], [37.5006562, 45.3666271], [37.4674344, 45.3524318], [37.4164658, 45.35084], [37.388894, 45.3496609], [37.3836315, 45.3384553], [37.3769628, 45.3374114], [37.3691858, 45.3341518], [37.3603955, 45.3367377], [37.3070372, 45.3295776], [37.2480438, 45.3320261], [37.2069892, 45.3345826], [37.1511522, 45.3462856], [37.126392, 45.3522221], [37.0962838, 45.3594978], [37.0805056, 45.3635252], [37.046227, 45.3735585], [37.0260903, 45.3805664], [37.0061937, 45.3883485], [36.9911291, 45.3948912], [36.984956, 45.3978906], [36.9773615, 45.4014806], [36.9579245, 45.4115686], [36.9408233, 45.4210992], [36.9220805, 45.4332423], [36.8681914, 45.4450461], [36.8455213, 45.4512012], [36.7993916, 45.4445236], [36.7701048, 45.4272394], [36.7556305, 45.409403], [36.7125489, 45.3630888], [36.6677643, 45.3425626], [36.6670966, 45.3376002], [36.6615842, 45.3338092], [36.6459459, 45.3232649], [36.621977, 45.3052324], [36.6319383, 45.3078181], [36.6461919, 45.3165712], [36.6480898, 45.3190653], [36.6496708, 45.3160193], [36.6545588, 45.3253553], [36.6669828, 45.3310567], [36.6681208, 45.3271723], [36.671377, 45.332122], [36.6796777, 45.3374165], [36.6815203, 45.3386514], [36.6813768, 45.3365493], [36.6835252, 45.3382614], [36.6871101, 45.3445184], [36.6869184, 45.3419638], [36.7193448, 45.3658733], [36.7707057, 45.4111708], [36.8158984, 45.3885811], [36.858553, 45.379142], [36.84344, 45.36975], [36.813748, 45.356358], [36.786312, 45.369426], [36.766748, 45.371739], [36.7872216, 45.3250729], [36.8027269, 45.3037539], [36.8502145, 45.316776], [36.907289, 45.326043], [36.974553, 45.326487], [36.9985754, 45.3195793], [36.9915807, 45.3006763], [36.984476, 45.282537], [36.931734, 45.273897], [36.900402, 45.261397], [36.8606468, 45.2488405], [36.790571, 45.241237], [36.77394, 45.239375], [36.7408727, 45.2207812], [36.7197862, 45.2194887], [36.6971683, 45.2219041], [36.6778837, 45.2252436], [36.6524348, 45.216406], [36.6298236, 45.2143319], [36.6117455, 45.2103468], [36.6013614, 45.2371726], [36.5922745, 45.2452927]]]}	45.2643139,37.1537616	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
11	муниципальный округ Анапа	munitsipalnyy-okrug-anapa	district	2	{"type": "Polygon", "coordinates": [[[37.4786138, 45.1845081], [37.4852999, 45.1531926], [37.4537084, 45.1672183], [37.4786138, 45.1845081], [37.618814, 45.0227251], [37.5782288, 45.0418892], [37.5449659, 45.0613455], [37.5414048, 45.0719951], [37.5295207, 45.083925], [37.5215794, 45.0977638], [37.6538508, 45.0107721], [37.6437514, 45.0144345], [37.6394731, 45.0185819], [37.6372823, 45.0034011], [37.6052134, 44.9994266], [37.5583979, 45.0054392], [37.6037042, 44.9681099], [37.5845072, 44.9658528], [37.5757054, 44.969279], [37.563685, 44.9730541], [37.5570693, 44.9785386], [37.5234632, 44.9717554], [37.4993262, 44.9179258], [37.508023, 44.8893445], [37.467513, 44.8426151], [37.4491629, 44.7994809], [37.4699611, 44.7938504], [37.4994322, 44.7751117], [37.492988, 44.7534813], [37.4836394, 44.7254222], [37.4790222, 44.7128398], [37.4749062, 44.7078495], [37.4433862, 44.7176042], [37.4556533, 44.7080879], [37.4631891, 44.7071248], [37.43139, 44.728467], [37.4207626, 44.7337096], [37.416234, 44.7355865], [37.4129215, 44.7380825], [37.3991676, 44.7535128], [37.4062669, 44.7468232], [37.3897622, 44.7561862], [37.3855342, 44.7583664], [37.3805516, 44.7570923], [37.3861612, 44.7626525], [37.385081, 44.7669179], [37.3882044, 44.765061], [37.3847078, 44.7648855], [37.3730415, 44.7937141], [37.3790661, 44.7861746], [37.383196, 44.776183], [37.3707286, 44.796507], [37.3583716, 44.8109639], [37.3661399, 44.8015713], [37.3385019, 44.8506442], [37.3416373, 44.8408807], [37.3406238, 44.8339644], [37.3446815, 44.8237937], [37.3169602, 44.8714296], [37.3084524, 44.878237], [37.2986164, 44.8946285], [37.296878, 44.8934841], [37.296457, 44.8910705], [37.297742, 44.8886314], [37.3050057, 44.8983125], [37.3025467, 44.8977015], [37.2984249, 44.8965358], [37.3119467, 44.8973342], [37.3178235, 44.9164641], [37.3170054, 44.9029361], [37.1813822, 45.0152527], [37.2103178, 45.0016124], [37.22875, 44.9927169], [37.2458196, 44.9834481], [37.2583938, 44.9759595], [37.2733873, 44.9656975], [37.2863906, 44.9553576], [37.2987556, 44.9433377], [37.309581, 44.9312279], [37.0375514, 45.0654925], [37.0567238, 45.0600856], [37.0729914, 45.0552427], [37.0907477, 45.0497931], [37.1079004, 45.0442216], [37.1247929, 45.0382914], [36.9521767, 45.0898763], [36.9703674, 45.0837672], [36.9884026, 45.0779225], [37.006014, 45.0731721], [37.024076, 45.0686789], [36.8993121, 45.1054082], [36.9193675, 45.1000458], [36.9349482, 45.0952821], [36.9746497, 45.1210241], [37.403564, 45.1707481], [37.3625502, 45.1700284], [37.3305329, 45.1533643], [37.2783416, 45.141415], [37.238227, 45.116541], [37.2245248, 45.0875821], [37.1964662, 45.078384], [37.4458845, 45.1979346], [37.3793169, 44.7577907], [37.3798186, 44.7592433], [37.3797381, 44.7571395], [37.4786138, 45.1845081]]]}	44.9513051,37.2719538	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
12	городской округ Новороссийск	gorodskoy-okrug-novorossiysk	district	2	{"type": "Polygon", "coordinates": [[[37.4723897, 44.7040789], [37.4806427, 44.695922], [37.493256, 44.6949844], [37.5093707, 44.6901927], [37.5176312, 44.6857239], [37.5260364, 44.6841351], [37.5317189, 44.6809375], [37.5454556, 44.6775924], [37.5586384, 44.6780932], [37.5652473, 44.6762187], [37.582163, 44.670659], [37.6053522, 44.6679053], [37.6273397, 44.6691984], [37.641861, 44.670101], [37.6561605, 44.6678346], [37.6698072, 44.665608], [37.6820586, 44.6596324], [37.6928499, 44.6567886], [37.6992148, 44.6525586], [37.709823, 44.6530547], [37.7209461, 44.6504024], [37.7377214, 44.6502676], [37.7532935, 44.6533695], [37.7604899, 44.654066], [37.7670076, 44.6567047], [37.777972, 44.660479], [37.796198, 44.665675], [37.8022522, 44.6707141], [37.8008116, 44.6718513], [37.8095715, 44.6777357], [37.8128171, 44.6692231], [37.8111668, 44.6726257], [37.8027553, 44.6850614], [37.7961525, 44.6907056], [37.7939585, 44.6925368], [37.7924251, 44.6939749], [37.7912058, 44.6958747], [37.790708, 44.6972512], [37.7896207, 44.7063587], [37.7851197, 44.7113923], [37.7856504, 44.7180589], [37.7785259, 44.7211599], [37.7739602, 44.7277336], [37.7791165, 44.7286941], [37.7830942, 44.7284264], [37.7829024, 44.732064], [37.7858407, 44.7317591], [37.7882132, 44.7330939], [37.7964637, 44.7291315], [37.7961579, 44.73402], [37.8009054, 44.7287818], [37.8062752, 44.731661], [37.8054544, 44.7275432], [37.8119534, 44.7240329], [37.8081259, 44.7191102], [37.8184605, 44.7236289], [37.8161477, 44.7194605], [37.8217448, 44.7248857], [37.8227563, 44.7195259], [37.8200188, 44.7163943], [37.8269429, 44.7207588], [37.8283203, 44.7203329], [37.8307638, 44.7202385], [37.8328317, 44.7200232], [37.8330484, 44.7194641], [37.8295434, 44.7164648], [37.8235272, 44.7146246], [37.8374022, 44.7135524], [37.8424894, 44.7147336], [37.8438164, 44.70936], [37.8466921, 44.7058892], [37.8507087, 44.7046047], [37.8583302, 44.6984945], [37.8645871, 44.6937756], [37.907149, 44.7529111], [37.8889597, 44.7208719], [37.8801449, 44.79088], [37.8616977, 44.781833], [37.8610389, 44.8042269], [37.7811847, 44.8642764], [37.7693436, 44.8877012], [37.7477959, 44.8875181], [37.7183649, 44.9031675], [37.7012367, 44.9233578], [37.6328175, 44.9589526], [37.6452244, 45.008782], [37.6070909, 45.006384], [37.5619386, 45.0096624], [37.6051847, 44.9692583], [37.5836316, 44.9661145], [37.5729066, 44.9696912], [37.5606175, 44.9748316], [37.5350052, 44.969288], [37.4896253, 44.9210951], [37.5065778, 44.8971935], [37.4684613, 44.8600148], [37.4515214, 44.7995575], [37.4704469, 44.7930113], [37.4975791, 44.7660994], [37.4911541, 44.7340429], [37.4829308, 44.7201886], [37.4764832, 44.7087456], [37.4723897, 44.7040789]]]}	44.8305287,37.6731303	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
13	городской округ Геленджик	gorodskoy-okrug-gelendzhik	district	2	{"type": "Polygon", "coordinates": [[[37.9051733, 44.6328232], [37.9133946, 44.6212236], [37.9278539, 44.6075833], [37.9403017, 44.5988908], [37.9531264, 44.5902258], [37.9668569, 44.5797899], [37.9778568, 44.5766083], [37.9843646, 44.5681965], [37.9939236, 44.5681633], [38.0030209, 44.5650567], [38.016537, 44.5630155], [38.0216118, 44.5608646], [38.0258608, 44.559987], [38.0293443, 44.5609033], [38.0295998, 44.5630469], [38.0313715, 44.5669258], [38.0276254, 44.570676], [38.0307787, 44.5753372], [38.0233913, 44.5770622], [38.02631, 44.5831512], [38.0411597, 44.5853927], [38.055915, 44.5824178], [38.0624649, 44.5782103], [38.0693149, 44.5724701], [38.0722189, 44.5694331], [38.0758842, 44.564802], [38.0746839, 44.5574363], [38.0666534, 44.5553436], [38.0538274, 44.5545267], [38.0490263, 44.5522535], [38.0559366, 44.5478507], [38.0762514, 44.5369254], [38.0993076, 44.5215761], [38.1171839, 44.5059713], [38.1296962, 44.4990347], [38.1318038, 44.4916855], [38.1373303, 44.4809244], [38.1452728, 44.4657643], [38.1543213, 44.4568867], [38.1774757, 44.4444722], [38.1948817, 44.4290183], [38.2015659, 44.420261], [38.2039529, 44.4175285], [38.2075849, 44.4158472], [38.2208782, 44.4120088], [38.263895, 44.4125583], [38.3012456, 44.4047159], [38.325258, 44.3913056], [38.349707, 44.3781901], [38.3722647, 44.3707543], [38.39836, 44.3710233], [38.4293737, 44.3715247], [38.4610431, 44.367899], [38.5081154, 44.3580283], [38.5190656, 44.3551706], [38.5287426, 44.3577922], [38.555737, 44.351974], [38.5908121, 44.3412561], [38.6687905, 44.4866613], [38.6825959, 44.4516887], [38.6680609, 44.4223079], [38.6387102, 44.3883284], [38.6130322, 44.3365365], [38.5247653, 44.5510425], [38.581049, 44.5347443], [38.6489661, 44.4942462], [38.4518091, 44.6315152], [38.3072661, 44.5930726], [38.3561698, 44.6058337], [38.3788708, 44.6026953], [38.3950716, 44.5895556], [38.4214658, 44.5860845], [38.1231343, 44.6714462], [38.1243667, 44.6545882], [38.1299986, 44.6551406], [38.1332389, 44.6439427], [38.1399424, 44.6376661], [38.1609586, 44.6427919], [38.1499525, 44.6404173], [38.1378696, 44.6338831], [38.1430712, 44.6284137], [38.1558864, 44.6245094], [38.1612626, 44.6210738], [38.1857758, 44.6205772], [38.1976011, 44.6157819], [38.224654, 44.6136868], [38.2659186, 44.6043508], [37.9997662, 44.7180687], [38.1073409, 44.66673], [37.9870516, 44.7359532], [37.9328766, 44.7521947], [37.8872921, 44.7247767], [37.8767576, 44.6848933], [37.892299, 44.6760441], [37.897792, 44.6740282], [37.9116833, 44.6671955], [37.9184854, 44.6599532], [37.9234468, 44.6559563], [37.9290862, 44.651169], [37.9298197, 44.6440864], [37.918646, 44.6395244], [37.9051733, 44.6328232]]]}	44.5483408,38.2775379	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
14	муниципальный округ Горячий Ключ	munitsipalnyy-okrug-goryachiy-klyuch	district	2	{"type": "Polygon", "coordinates": [[[38.8792154, 44.5053152], [38.8845109, 44.5169349], [38.8866608, 44.5272546], [38.8930606, 44.525398], [38.8973019, 44.5237398], [38.9030014, 44.5258217], [38.9108343, 44.5348932], [38.9272101, 44.5370493], [38.9333842, 44.5445754], [38.9384228, 44.5549444], [38.932114, 44.564502], [38.9244406, 44.5766986], [38.9273098, 44.5855649], [38.9424385, 44.5889907], [38.9384067, 44.5966899], [38.9450597, 44.6085872], [38.9578051, 44.6169695], [38.9654347, 44.6287718], [38.978363, 44.6342672], [38.984299, 44.640294], [38.9980283, 44.65367], [39.0301688, 44.639466], [39.0326917, 44.6631437], [39.0024577, 44.6812051], [39.0061556, 44.6868874], [39.016087, 44.6988182], [38.9969071, 44.7525101], [38.9898734, 44.7647789], [38.9880453, 44.8442168], [39.0419289, 44.8355264], [39.0861395, 44.8241774], [39.1113915, 44.824779], [39.1684859, 44.833219], [39.2161068, 44.8252938], [39.230792, 44.8241243], [39.2481308, 44.8202783], [39.2674303, 44.8252483], [39.3049311, 44.8254649], [39.3533083, 44.8093819], [39.3697761, 44.814924], [39.4053671, 44.8151795], [39.4697971, 44.8117621], [39.4836965, 44.8068289], [39.4821836, 44.8105776], [39.4815514, 44.8141337], [39.4806933, 44.8169528], [39.4837191, 44.8193394], [39.5288615, 44.8118194], [39.6037318, 44.7619215], [39.6069313, 44.7646859], [39.604123, 44.7680835], [39.6067481, 44.7742895], [39.5770789, 44.7654178], [39.5376953, 44.7969837], [39.5288615, 44.8118194], [39.5436142, 44.6881712], [39.3482043, 44.5298609], [39.3591277, 44.5425785], [39.3683087, 44.5491168], [39.3756138, 44.5499832], [39.3867795, 44.5608229], [39.3997174, 44.560603], [39.4582724, 44.5918601], [39.4710617, 44.6400179], [39.5145135, 44.6471879], [39.3921638, 44.4633157], [39.3986908, 44.4639346], [39.402303, 44.4673967], [39.4071344, 44.4700613], [39.4082702, 44.4734794], [39.4138746, 44.4797301], [39.4176338, 44.4808689], [39.4279346, 44.4818158], [39.4291159, 44.4913672], [39.4229557, 44.4964617], [39.4295282, 44.506268], [39.2703712, 44.4268915], [39.3189376, 44.4595049], [39.3524733, 44.4655038], [38.8792154, 44.5053152], [38.8883131, 44.4955446], [38.8980733, 44.4957962], [38.9113892, 44.4949515], [38.9403837, 44.483667], [38.9466687, 44.4687896], [38.9565779, 44.4579566], [38.9721653, 44.4480961], [38.9695242, 44.4338732], [38.9673448, 44.4305739], [38.9564419, 44.424678], [38.9362439, 44.4252705], [38.918724, 44.422709], [38.9281506, 44.4158356], [38.9379471, 44.4123973], [38.9446598, 44.4093496], [38.9565234, 44.4055219], [38.9729788, 44.4020904], [38.9880649, 44.3974809], [38.9924782, 44.4042358], [39.0031212, 44.4106145], [39.0168518, 44.4094118], [39.0276698, 44.3959543], [39.02573, 44.3848479], [39.023849, 44.3814204], [39.0536982, 44.4006898], [39.0528702, 44.4208979], [39.0734423, 44.4375131], [39.0819656, 44.4419175], [39.0938328, 44.4480582], [39.1112635, 44.4476233], [39.1356584, 44.457981], [39.1627573, 44.4465099], [39.1832232, 44.4422299], [39.2164918, 44.4385317], [39.2494419, 44.4331352], [38.8792154, 44.5053152]]]}	44.6128185,39.2430691	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
15	Белореченский район	belorechenskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.5277586, 44.6514926], [39.5574943, 44.6275068], [39.5703552, 44.6195263], [39.5757076, 44.6191428], [39.580514, 44.6199388], [39.5843122, 44.6214337], [39.5878722, 44.6245217], [39.5913804, 44.6257381], [39.5943374, 44.6273834], [39.613343, 44.6264315], [39.621269, 44.6219229], [39.6213793, 44.6290106], [39.6218712, 44.6306622], [39.6263012, 44.6369462], [39.629322, 44.6396041], [39.6482895, 44.6676707], [39.7297612, 44.6504742], [39.757421, 44.63942], [39.7446619, 44.6348823], [39.7455428, 44.6285719], [39.7509506, 44.6228174], [39.742854, 44.611129], [39.8620201, 44.5324942], [39.8660562, 44.5316053], [39.8573775, 44.54058], [39.879643, 44.6218178], [39.8941122, 44.5900883], [39.9203841, 44.6261085], [39.912879, 44.6164098], [39.9153087, 44.6082665], [39.9080782, 44.7005185], [39.9142978, 44.7015201], [39.9163769, 44.68943], [39.9275007, 44.6896657], [40.0191191, 44.7527455], [39.9328508, 44.729249], [39.9507665, 44.8305083], [39.9634786, 44.8924253], [39.9418936, 44.9297581], [39.7067594, 44.9545606], [39.673337, 44.9923563], [39.6744548, 44.9783401], [39.6903885, 44.9777775], [39.6797435, 44.9713602], [39.69147, 44.9659313], [39.6854077, 44.9578942], [39.6913501, 44.9551603], [39.6981295, 44.9530177], [39.5424987, 45.0523713], [39.5409977, 45.0433806], [39.5529365, 45.0401777], [39.5582616, 45.031803], [39.5715745, 45.0358613], [39.5771607, 45.046338], [39.5869057, 45.0485891], [39.6061042, 45.0448062], [39.6331285, 45.0422711], [39.645917, 45.0222578], [39.6490494, 45.0180878], [39.6440375, 45.008418], [39.5988118, 44.9825453], [39.4757125, 44.9958883], [39.4799817, 45.036171], [39.495963, 45.043821], [39.5119021, 45.04067], [39.517587, 45.0459328], [39.5408143, 45.055025], [39.4894844, 44.9784288], [39.4858736, 44.9904185], [39.4736082, 44.9910638], [39.5066822, 44.9838734], [39.504759, 44.9793598], [39.5162687, 44.9833443], [39.5044561, 44.9680277], [39.5091168, 44.9738526], [39.5198172, 44.9784701], [39.635843, 44.8944199], [39.6287058, 44.8998701], [39.621616, 44.903526], [39.6059621, 44.9090197], [39.5986091, 44.9155486], [39.5940983, 44.9227648], [39.5807729, 44.9277988], [39.5736254, 44.9312239], [39.5724894, 44.9382489], [39.559504, 44.9391216], [39.5572276, 44.9448798], [39.5414559, 44.9548898], [39.5215086, 44.9645834], [39.5628083, 44.8090322], [39.5670714, 44.8240383], [39.5589573, 44.8340687], [39.5948617, 44.8453323], [39.608274, 44.8467167], [39.6146145, 44.8546026], [39.6262152, 44.8623595], [39.6418518, 44.8692707], [39.6526681, 44.8707167], [39.6386016, 44.8777657], [39.6455661, 44.8862769], [39.604648, 44.7626971], [39.6041958, 44.7686522], [39.5711178, 44.7739105], [39.5277586, 44.6514926]]]}	44.7819868,39.7497583	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
16	Апшеронский район	apsheronskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.2703712, 44.4268915], [39.3524733, 44.4655038], [39.2950786, 44.4185848], [39.3451593, 44.3965269], [39.3934618, 44.3881795], [39.428787, 44.3759927], [39.4556833, 44.3609578], [39.4752397, 44.3525857], [39.4883329, 44.3422705], [39.4836084, 44.322901], [39.5137974, 44.2979175], [39.5402532, 44.2892017], [39.5688494, 44.2895071], [39.5639444, 44.2566317], [39.5545861, 44.2149905], [39.5483051, 44.1937669], [39.5634311, 44.1753844], [39.5742653, 44.1575607], [39.5777482, 44.1234762], [39.5643995, 44.1073831], [39.5293615, 44.093966], [39.524209, 44.0695737], [39.5783146, 44.0455208], [39.5879518, 44.0233919], [39.61004, 44.0179915], [39.6556555, 44.0038798], [39.6792048, 43.9906633], [39.6882507, 43.9609554], [39.7206652, 43.945088], [39.7709496, 43.9363995], [39.7736481, 44.1680003], [39.7739937, 44.1368656], [39.8072986, 44.114207], [39.8221995, 44.0591953], [39.7983398, 44.0121325], [39.8161108, 43.986673], [39.7937224, 43.9484816], [39.8078398, 44.1808144], [39.865187, 44.1835996], [39.8769247, 44.16083], [40.018744, 44.0933909], [39.998968, 44.0790168], [39.977597, 44.0836431], [39.9706474, 44.0953618], [39.9462925, 44.1009659], [39.9031839, 44.122281], [40.079547, 44.2341005], [40.0778193, 44.1973573], [40.0819, 44.1762803], [40.0730025, 44.1633285], [40.0741523, 44.1506377], [40.077388, 44.1422198], [40.0875807, 44.1373685], [40.0928479, 44.132256], [40.0870654, 44.1238745], [40.0801875, 44.1255214], [40.0709812, 44.1241159], [40.0619808, 44.129921], [40.0546729, 44.1365102], [40.0422491, 44.1270823], [40.0307192, 44.1153651], [40.01646, 44.1028803], [40.0057425, 44.2656246], [40.0542685, 44.2693832], [40.0795562, 44.2509292], [39.9675973, 44.2983101], [39.9739195, 44.2827523], [39.9666499, 44.3448498], [39.9525953, 44.348594], [39.8697712, 44.3381863], [39.8954986, 44.3516376], [39.8706265, 44.431669], [39.8490101, 44.3572273], [39.8818762, 44.4897255], [39.8690095, 44.5237684], [39.863103, 44.5356052], [39.8179011, 44.5862817], [39.7297612, 44.6504742], [39.757421, 44.63942], [39.7446619, 44.6348823], [39.7455428, 44.6285719], [39.7509506, 44.6228174], [39.742854, 44.611129], [39.5659564, 44.6212786], [39.5713205, 44.6193035], [39.576585, 44.6204903], [39.5824198, 44.6198257], [39.5846219, 44.622335], [39.5885496, 44.6248661], [39.5924019, 44.625409], [39.595585, 44.6274618], [39.6145828, 44.6248064], [39.6209895, 44.623155], [39.6231507, 44.6289863], [39.6195514, 44.6319756], [39.6309811, 44.6339404], [39.629469, 44.6406651], [39.6526032, 44.6631433], [39.3554197, 44.5409647], [39.3737536, 44.5497888], [39.3999233, 44.5600202], [39.4618702, 44.6264902], [39.390255, 44.4623219], [39.4005179, 44.4653884], [39.4084773, 44.4717729], [39.4158277, 44.4805842], [39.4308748, 44.4876405], [39.4309059, 44.5058127], [39.2703712, 44.4268915]]]}	44.3012439,39.6819443	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
19	Мостовский район	mostovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.775739, 44.4650237], [40.6506937, 44.4647304], [40.643364, 44.584312], [40.565605, 44.7407837], [40.5198344, 44.7480843], [40.3675236, 44.7117066], [40.4043613, 44.6700645], [40.3948851, 44.6719122], [40.3819788, 44.6808417], [40.3654865, 44.6923881], [40.3691685, 44.7027194], [40.4043613, 44.6700645], [40.3980072, 44.6595145], [40.4011493, 44.6596086], [40.4000033, 44.656415], [40.3992225, 44.6544352], [40.3959556, 44.6529416], [40.3461907, 44.6196522], [40.3428158, 44.6405365], [40.3823705, 44.6387279], [40.3869846, 44.6459411], [40.393326, 44.6486721], [40.387266, 44.5488575], [40.40869, 44.4481299], [40.3979928, 44.4598601], [40.388629, 44.4716323], [40.3840137, 44.4825174], [40.4025942, 44.4947528], [40.4128796, 44.5061254], [40.4228577, 44.5143802], [40.4111142, 44.5290813], [40.45054, 44.3817536], [40.411419, 44.4319064], [40.4064265, 44.4423303], [40.4666568, 44.3096119], [40.3598234, 44.2467465], [40.4056664, 44.1639607], [40.3619171, 44.2443698], [40.4184413, 44.1277368], [40.426868, 44.0543152], [40.4198781, 44.0727233], [40.4692433, 43.982712], [40.4500536, 44.0077193], [40.43157, 44.0370087], [40.3730139, 43.7872328], [40.3937902, 43.8326056], [40.4168295, 43.8851872], [40.4078119, 43.9286815], [40.459488, 43.9578766], [40.3778472, 43.7706078], [40.3864409, 43.7459492], [40.3764677, 43.7259544], [40.4093345, 43.7287337], [40.4485654, 43.7252565], [40.4558551, 43.6949243], [40.4537297, 43.6687292], [40.4758463, 43.6479429], [40.5073608, 43.6395836], [40.5405437, 43.6263477], [40.5704696, 43.6147965], [40.5909809, 43.6032407], [40.5994819, 43.5990989], [40.6112328, 43.5879105], [40.6271668, 43.584212], [40.6563996, 43.5747698], [40.6698193, 43.559286], [40.6864534, 43.5496608], [40.6933191, 43.5353832], [40.728986, 43.5664496], [40.7238799, 43.5462497], [40.74125, 43.5927713], [40.7256975, 43.5802099], [40.7124925, 43.6432267], [40.7283226, 43.615279], [40.7085828, 43.6605801], [40.7134652, 43.6760199], [40.6867634, 43.7244065], [40.6877232, 43.7128134], [40.7080972, 43.6870569], [40.7198975, 43.7368219], [40.7419542, 43.7826865], [40.8267822, 43.9203419], [40.7905681, 43.8980405], [40.7859814, 43.8800034], [40.7676643, 43.8638603], [40.7563358, 43.8418817], [40.7391668, 43.8136003], [40.9207738, 44.033456], [40.9300588, 44.0127508], [40.9115397, 43.9842037], [40.8836073, 43.9441094], [40.9141294, 44.1452968], [40.9132694, 44.0809615], [40.9268869, 44.0680843], [40.9200249, 44.044404], [40.9149141, 44.206872], [40.8879136, 44.2627625], [40.8871981, 44.2329984], [40.8869273, 44.2096671], [40.8914417, 44.2690913], [40.8656151, 44.3262775], [40.7873651, 44.4402754], [40.8042199, 44.426922], [40.8253602, 44.3960739], [40.8507697, 44.3428197], [40.775739, 44.4650237]]]}	44.147479,40.6360521	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
20	Ейский район	eyskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[38.0878562, 46.6628852], [38.0691898, 46.6532152], [38.1338142, 46.6906266], [38.1091808, 46.676695], [38.0887586, 46.6634417], [38.224312, 46.7008102], [38.2698936, 46.7275882], [38.2839065, 46.7346624], [38.2903142, 46.7377926], [38.2872027, 46.7264434], [38.2871351, 46.714976], [38.2901526, 46.7044975], [38.3037364, 46.6839331], [38.3239822, 46.6678998], [38.3510716, 46.6610436], [38.3308121, 46.6647455], [38.4594891, 46.6450109], [38.4407561, 46.6500181], [38.4230227, 46.6545711], [38.4015706, 46.6554118], [38.379675, 46.6576193], [38.3586954, 46.6599295], [38.5227808, 46.3934223], [38.581863, 46.2621007], [38.569196, 46.241086], [38.4608557, 46.1584622], [38.4732419, 46.1503075], [38.4919988, 46.1438363], [38.4042953, 46.1847182], [38.4172375, 46.1796629], [38.4326448, 46.1720094], [38.4473867, 46.164901], [38.3476099, 46.2083582], [38.3596712, 46.2020203], [38.3729375, 46.1962032], [38.3862305, 46.1911291], [38.3243359, 46.2243629], [38.3356595, 46.2160843], [38.3013544, 46.2383513], [38.3126279, 46.2322306], [38.288472, 46.2615772], [38.2914329, 46.2516089], [38.2441244, 46.3038836], [38.2361743, 46.311055], [38.1718821, 46.3580663], [38.1592885, 46.3662662], [38.0952767, 46.3979409], [38.1079566, 46.3935045], [38.1199622, 46.387738], [38.1318899, 46.3816302], [37.9849438, 46.4071182], [37.9996638, 46.4091511], [38.017644, 46.4059882], [38.0277533, 46.4022812], [38.0459785, 46.4032481], [38.061997, 46.4029005], [38.0774942, 46.401498], [37.9658773, 46.3883252], [37.9614106, 46.3872837], [37.9640576, 46.3899869], [37.9761204, 46.401512], [37.9799573, 46.4001339], [37.9729709, 46.396279], [37.967623, 46.3918], [37.9972646, 46.3784324], [37.9878716, 46.3828125], [37.9877262, 46.3888003], [38.0084309, 46.3763668], [38.0007484, 46.382137], [37.9738469, 46.3719135], [37.9844131, 46.3664927], [37.9988623, 46.3634743], [38.0117241, 46.3672125], [38.015299, 46.3743666], [38.0117147, 46.3821735], [38.0127953, 46.3752612], [37.957354, 46.382135], [37.9705771, 46.3737645], [37.9293251, 46.3994689], [37.9413838, 46.3929849], [37.8544926, 46.475405], [37.8416199, 46.495243], [37.8001218, 46.5674897], [37.7353392, 46.6817979], [37.7596082, 46.6714622], [37.7927882, 46.6552748], [37.8007568, 46.6518009], [37.9513136, 46.6329652], [37.9363798, 46.6331651], [37.9194838, 46.6335334], [37.8998071, 46.6345672], [37.877215, 46.6370736], [37.8570613, 46.6397371], [37.8378345, 46.6431176], [37.8181478, 46.6473054], [37.9775202, 46.6339989], [37.9626748, 46.6333129], [37.9517798, 46.6329719], [38.0490901, 46.6428741], [38.0268556, 46.6390575], [38.0071524, 46.6360351], [38.0878562, 46.6628852]]]}	46.440845,38.1621064	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
21	Щербиновский район	scherbinovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[38.6856065, 46.8704344], [38.8959219, 46.8264641], [38.8773293, 46.5803145], [38.7654167, 46.5208039], [38.7588361, 46.4578277], [38.7130069, 46.394442], [38.5475932, 46.383006], [38.4890029, 46.4107496], [38.4648773, 46.6278094], [38.4767891, 46.6428938], [38.5314562, 46.6555649], [38.5221415, 46.6506356], [38.5116078, 46.644915], [38.5010777, 46.6418298], [38.4896313, 46.6415468], [38.532837, 46.6559355], [38.5485791, 46.6618612], [38.5442945, 46.6582509], [38.5926627, 46.6621895], [38.5835283, 46.6642752], [38.5756981, 46.6613853], [38.5641612, 46.6628214], [38.5989622, 46.6938397], [38.6014436, 46.6858547], [38.5994622, 46.677774], [38.5955573, 46.6703875], [38.5917365, 46.6649373], [38.5900651, 46.71137], [38.5926762, 46.7069214], [38.5957583, 46.7010536], [38.5862897, 46.7173558], [38.5688158, 46.727821], [38.5749215, 46.726497], [38.5789452, 46.723695], [38.584805, 46.7200432], [38.5381503, 46.7361657], [38.5429942, 46.734623], [38.5474074, 46.7337309], [38.5527781, 46.732734], [38.5573709, 46.7313008], [38.5635748, 46.7297283], [38.5308028, 46.7401262], [38.5345294, 46.7376619], [38.4817248, 46.7482806], [38.4897039, 46.750236], [38.4979464, 46.7514448], [38.5074441, 46.7509754], [38.5139151, 46.7482509], [38.5210158, 46.7440671], [38.5273937, 46.7412868], [38.4186998, 46.7546684], [38.4310382, 46.7534664], [38.4425852, 46.7552039], [38.4517471, 46.7555975], [38.4597198, 46.753108], [38.4688499, 46.7501768], [38.4014662, 46.7208717], [38.399095, 46.7261712], [38.3985257, 46.7321674], [38.3986877, 46.7388364], [38.4004658, 46.7457142], [38.4059658, 46.7519667], [38.394831, 46.7452791], [38.3942629, 46.732827], [38.3989415, 46.7223736], [38.3957144, 46.7495158], [38.410255, 46.7975274], [38.4083346, 46.7906027], [38.4060752, 46.7842881], [38.4043618, 46.7780464], [38.402022, 46.7696772], [38.425021, 46.8272304], [38.4154823, 46.8127101], [38.447818, 46.8508018], [38.4413801, 46.8448158], [38.4358373, 46.8389367], [38.4297003, 46.8324165], [38.4915755, 46.8733097], [38.4837075, 46.8676379], [38.4729193, 46.8632621], [38.4639686, 46.8601854], [38.4551311, 46.8558772], [38.5199675, 46.8700512], [38.5125738, 46.8738789], [38.5053339, 46.8777269], [38.498742, 46.879577], [38.556781, 46.8558232], [38.5465783, 46.857317], [38.5390794, 46.8605165], [38.5311709, 46.8641964], [38.6034683, 46.8643775], [38.5934223, 46.8615866], [38.5833746, 46.8588702], [38.5725992, 46.8566868], [38.5623563, 46.8559255], [38.6785768, 46.8711365], [38.6676302, 46.871661], [38.6581635, 46.8721403], [38.6481718, 46.8721385], [38.6378768, 46.8719167], [38.6186728, 46.8683565], [38.6856065, 46.8704344]]]}	46.6270554,38.6635572	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
22	Староминский район	starominskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.2272858, 46.6819599], [39.2672154, 46.6818476], [39.2875037, 46.6339584], [39.2937423, 46.615663], [39.2992169, 46.6245038], [39.3084627, 46.6194888], [39.3267841, 46.516269], [39.3249777, 46.4209781], [39.2991512, 46.4257009], [39.2818161, 46.4233812], [39.2674332, 46.4228164], [39.2525501, 46.4230556], [39.2595424, 46.4129558], [39.25515, 46.4005558], [39.2429542, 46.3959886], [39.2299306, 46.3911091], [39.2026321, 46.3870253], [39.1710171, 46.3490007], [39.1619719, 46.32088], [39.1146213, 46.3373965], [39.0903298, 46.3458157], [39.0603959, 46.3562039], [39.0303844, 46.3666236], [38.9993185, 46.3922815], [38.956791, 46.3945821], [38.9378142, 46.3945736], [38.8876888, 46.3946039], [38.8562969, 46.3945168], [38.8281288, 46.3944766], [38.7914041, 46.394489], [38.7913537, 46.4348217], [38.7965821, 46.441886], [38.8013617, 46.4492904], [38.7967956, 46.4513002], [38.7817094, 46.4519515], [38.769855, 46.4556635], [38.757106, 46.4582883], [38.7477544, 46.4626756], [38.7410384, 46.4657828], [38.7654951, 46.4682346], [38.7654156, 46.5204929], [38.8093893, 46.5384922], [38.8428602, 46.5385204], [38.85938, 46.5385366], [38.8694467, 46.5612234], [38.8980253, 46.5611449], [38.9023717, 46.5757206], [38.9020941, 46.6086994], [38.9022669, 46.6344856], [38.9046512, 46.6325921], [38.9099298, 46.6323932], [38.9201866, 46.6297635], [38.9246215, 46.6304274], [38.9281765, 46.6278036], [38.9300169, 46.6262092], [38.9326642, 46.6254509], [38.9377748, 46.6274439], [38.9423616, 46.6286494], [38.9471829, 46.6321326], [38.9566457, 46.6349174], [38.9609802, 46.636597], [38.9672072, 46.6345444], [38.9766449, 46.6284295], [38.9776683, 46.6264269], [38.9795805, 46.6275143], [38.9804452, 46.6263842], [38.9821725, 46.6268926], [38.9840608, 46.6272241], [38.9853267, 46.6267194], [38.985906, 46.6233337], [38.9878801, 46.6230684], [38.9895485, 46.6232453], [38.9902566, 46.622711], [38.9909697, 46.6222206], [38.992123, 46.6223606], [38.9936311, 46.6230053], [38.9949066, 46.6240083], [38.9954791, 46.625152], [38.9981235, 46.6244157], [39.0000505, 46.6243934], [39.0011563, 46.6253985], [39.0035387, 46.6252477], [39.0076666, 46.6263455], [39.007275, 46.6281396], [39.0082782, 46.6307919], [39.0183077, 46.6325744], [39.0428202, 46.6247099], [39.0587639, 46.6169093], [39.0717628, 46.5990708], [39.101848, 46.6024944], [39.1219127, 46.6040946], [39.1342009, 46.6084645], [39.1445275, 46.6218717], [39.1509497, 46.6186752], [39.1537861, 46.6098105], [39.1622297, 46.6171694], [39.1700457, 46.6224988], [39.1912124, 46.6144617], [39.1975059, 46.6083885], [39.2025447, 46.6106349], [39.2024504, 46.6196296], [39.2090356, 46.6376068], [39.2272858, 46.6819599]]]}	46.500066,39.0339113	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
23	Приморско-Ахтарский муниципальный округ	primorsko-ahtarskiy-munitsipalnyy-okrug	district	2	{"type": "Polygon", "coordinates": [[[37.9501408, 46.0112906], [37.9895425, 46.044158], [38.037597, 46.051223], [38.004565, 46.044271], [38.092741, 46.058344], [38.117777, 46.047895], [38.109416, 46.029489], [38.103661, 46.032395], [38.090267, 46.029467], [38.078506, 46.03912], [38.102627, 46.03944], [38.083018, 46.022484], [38.082158, 46.029915], [38.072764, 46.008036], [38.079796, 46.016942], [38.073364, 45.994189], [38.077875, 45.977424], [38.084687, 45.965936], [38.06662, 45.968483], [38.093397, 45.950614], [38.086584, 45.940043], [38.095313, 45.945885], [38.106231, 45.952896], [38.128649, 45.988981], [38.120324, 45.968653], [38.1543832, 46.0133654], [38.1552214, 46.0438572], [38.1517098, 46.0323682], [38.1521675, 46.0245703], [38.1787643, 46.0788628], [38.1705728, 46.0627536], [38.1806767, 46.1041328], [38.1954154, 46.1241396], [38.2314778, 46.1469105], [38.2498079, 46.2161221], [38.2476407, 46.1809484], [38.2794169, 46.2627102], [38.2811969, 46.2632228], [38.2703242, 46.2595095], [38.2568005, 46.2397114], [38.2508647, 46.2221572], [38.2843199, 46.2622216], [38.2789687, 46.2352714], [38.253763, 46.207897], [38.2548917, 46.2141613], [38.2565564, 46.1685303], [38.266299, 46.182071], [38.261926, 46.163959], [38.277833, 46.14726], [38.268868, 46.155412], [38.304735, 46.135628], [38.287607, 46.147706], [38.3219791, 46.1262752], [38.336126, 46.1156999], [38.354316, 46.0982989], [38.375901, 46.0904716], [38.3946232, 46.0739016], [38.435441, 46.054394], [38.4102701, 46.064994], [38.489343, 46.042335], [38.455611, 46.04513], [38.547175, 46.0472971], [38.517997, 46.051181], [38.5751605, 46.0418449], [38.5817472, 46.04083], [38.5787392, 46.0390916], [38.5703311, 46.038955], [38.5636853, 46.0411193], [38.5570635, 46.0443548], [38.5799819, 46.0455805], [38.582714, 46.0434618], [38.6492085, 45.9960115], [38.6371271, 46.0167832], [38.6236708, 46.042987], [38.6194249, 46.0513508], [38.5895814, 46.0463433], [38.7168886, 45.9397655], [38.7096099, 45.9631877], [38.6808846, 45.9797021], [38.605576, 45.8656093], [38.6243562, 45.8809868], [38.6475632, 45.8951124], [38.6032941, 45.7480942], [38.3060735, 45.7512391], [38.0516372, 45.7475711], [38.0969516, 45.7437135], [37.9606043, 45.7055559], [37.8806053, 45.6743697], [37.8148733, 45.6758155], [37.7846377, 45.7438127], [37.8245847, 45.7496857], [37.8491789, 45.7784471], [37.8350828, 45.7576628], [37.8832948, 45.8519548], [37.8772116, 45.8364541], [37.8660428, 45.8100765], [37.9092103, 45.9275299], [37.900123, 45.9003201], [37.8939003, 45.8831188], [37.8860414, 45.8598548], [37.9237935, 45.9662195], [37.9501408, 46.0112906]]]}	45.9658004,38.2458817	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
24	Калининский район	kalininskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[38.870713, 45.4695834], [38.8145911, 45.3363148], [38.8092397, 45.3308701], [38.8133901, 45.3352022], [38.7253424, 45.3306432], [38.7668404, 45.3217079], [38.7600888, 45.3010693], [38.785249, 45.3152568], [38.8031819, 45.322319], [38.5948099, 45.3035608], [38.6355931, 45.3404248], [38.6276805, 45.3419504], [38.6206132, 45.3433917], [38.6152405, 45.3436547], [38.6014031, 45.3478405], [38.5939275, 45.3560128], [38.5884893, 45.368632], [38.5426842, 45.3679776], [38.5388419, 45.389874], [38.5253668, 45.4321176], [38.5297813, 45.4355811], [38.5179306, 45.4475827], [38.4925495, 45.4695303], [38.462495, 45.4857204], [38.4867076, 45.5183424], [38.4705189, 45.5299699], [38.4369049, 45.5292889], [38.4203854, 45.5196477], [38.393939, 45.5130243], [38.3546227, 45.5171282], [38.267541, 45.5428924], [38.267903, 45.5833338], [38.2331681, 45.593253], [38.1314354, 45.5944688], [38.1351825, 45.5974177], [38.1442966, 45.6006281], [38.1571284, 45.6057736], [38.1468994, 45.6117899], [38.143501, 45.619416], [38.1521617, 45.6349493], [38.1534751, 45.63949], [38.1523453, 45.6478752], [38.1453005, 45.6517183], [38.129768, 45.656746], [38.1163325, 45.6515648], [38.103676, 45.658431], [38.0869353, 45.6554511], [38.0776429, 45.6627965], [38.0782528, 45.6687095], [38.0741005, 45.6744895], [38.0714223, 45.6821146], [38.0623759, 45.6941778], [38.0544002, 45.6828786], [38.0447825, 45.6858788], [38.039928, 45.689434], [38.0388764, 45.6956546], [38.0373148, 45.7018937], [38.0320256, 45.7028485], [38.0224888, 45.7049445], [38.0137802, 45.6931272], [38.0191908, 45.6859], [38.0096349, 45.6782961], [37.9994727, 45.6739881], [37.9751466, 45.670525], [37.9589042, 45.6723242], [37.9463802, 45.678969], [37.9325222, 45.6885021], [37.9320476, 45.7013209], [37.9364599, 45.7018714], [37.9433357, 45.7037295], [37.9500347, 45.7042002], [37.9597627, 45.7051698], [37.9658563, 45.7062847], [37.9698131, 45.7069462], [37.9741103, 45.7097873], [38.0118713, 45.7895211], [38.0160818, 45.785911], [38.0270258, 45.7733193], [38.0263884, 45.7603249], [38.0395841, 45.7628233], [38.048069, 45.7604914], [38.0468087, 45.7511662], [38.0606344, 45.7448412], [38.0707807, 45.7591053], [38.0749488, 45.7620063], [38.0795528, 45.7656992], [38.0924604, 45.7611202], [38.0993859, 45.7598728], [38.0948424, 45.751054], [38.0974452, 45.7461239], [38.1420344, 45.72495], [38.1678456, 45.7009454], [38.256918, 45.7203849], [38.345191, 45.7300985], [38.3841701, 45.7190036], [38.4340563, 45.7248142], [38.4650138, 45.7315725], [38.498033, 45.7382311], [38.5173269, 45.7374979], [38.5444952, 45.748477], [38.5621333, 45.7413654], [38.5704927, 45.7371058], [38.5748765, 45.7327326], [38.5870279, 45.7269598], [38.5917714, 45.7180016], [38.5953677, 45.709611], [38.6101384, 45.7050167], [38.6315096, 45.6970599], [38.6650277, 45.6650571], [38.683566, 45.6517556], [38.6645123, 45.6097142], [38.6539575, 45.5889132], [38.7379662, 45.5094574], [38.8249515, 45.4941887], [38.870713, 45.4695834]]]}	45.5305453,38.3965172	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
25	Тимашёвский район	timashyovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.2929539, 45.7369095], [39.1511441, 45.7536757], [39.2929539, 45.7369095], [39.1302042, 45.7444283], [39.1227865, 45.7484154], [39.0864201, 45.705611], [38.9771191, 45.7168435], [39.033553, 45.7196762], [39.0690438, 45.7096713], [38.9124354, 45.7239493], [38.9310373, 45.717249], [38.9513326, 45.7170136], [38.9638296, 45.716937], [38.9762854, 45.7168734], [38.8537498, 45.7714612], [38.91262, 45.7349981], [38.6354439, 45.7610783], [38.6624625, 45.7673876], [38.678841, 45.7476442], [38.6841334, 45.7512539], [38.6856677, 45.7568721], [38.6944549, 45.748397], [38.7014475, 45.7469048], [38.7043733, 45.7624264], [38.7218441, 45.762992], [38.7234175, 45.754459], [38.7323178, 45.7553798], [38.7491855, 45.7620653], [38.7456809, 45.7654773], [38.7732536, 45.7720026], [38.8394721, 45.7715878], [38.5645235, 45.7514457], [38.5857478, 45.7481836], [38.598182, 45.7435008], [38.6084061, 45.7528511], [38.5596584, 45.7421845], [38.56747, 45.7392592], [38.5725028, 45.7355834], [38.5748765, 45.7327326], [38.5823927, 45.7323439], [38.587648, 45.7232576], [38.590877, 45.7164646], [38.5937425, 45.7110595], [38.5990361, 45.7060467], [38.6172219, 45.7035233], [38.6315096, 45.6970599], [38.6572867, 45.6688229], [38.6750857, 45.6586557], [38.6857044, 45.6513968], [38.6652361, 45.6098299], [38.6671137, 45.6056439], [38.6500694, 45.5854089], [38.7379662, 45.5094574], [38.7799278, 45.5214397], [38.8258652, 45.4282221], [38.8762939, 45.4007261], [38.960867, 45.3749941], [39.0709337, 45.3769228], [39.0758394, 45.3832723], [39.0804144, 45.3856338], [39.0869796, 45.3846146], [39.0922652, 45.3899114], [39.0991825, 45.3909906], [39.1041454, 45.3893003], [39.108409, 45.3906549], [39.1146312, 45.3915293], [39.1205897, 45.3906319], [39.1342771, 45.3896508], [39.1385747, 45.3875837], [39.1426086, 45.4759707], [39.1436627, 45.4321134], [39.1438022, 45.3868204], [39.1425577, 45.4794352], [39.1162514, 45.5288961], [39.1452484, 45.5912932], [39.1452484, 45.5912932], [39.1503635, 45.5887432], [39.1529494, 45.5857183], [39.1577025, 45.5841917], [39.1664279, 45.5893145], [39.1648668, 45.5936691], [39.1664996, 45.600606], [39.1613568, 45.6037557], [39.1646049, 45.6116147], [39.1678945, 45.6164242], [39.1843617, 45.617114], [39.1904444, 45.6184272], [39.1944657, 45.6227787], [39.1980013, 45.6245501], [39.2553938, 45.6646797], [39.2395446, 45.6392613], [39.2328728, 45.64151], [39.2274498, 45.6395723], [39.2198149, 45.6364213], [39.2165132, 45.6323901], [39.2107138, 45.6307991], [39.2100706, 45.6277651], [39.2066959, 45.6258024], [39.2032359, 45.6213921], [39.3195459, 45.6580387], [39.2553938, 45.6646797], [39.3957371, 45.7193919], [39.389681, 45.6797552], [39.3963884, 45.6554916], [39.2929539, 45.7369095]]]}	45.5674671,38.9780234	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
26	Брюховецкий район	bryuhovetskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.2929539, 45.7369095], [39.1328336, 45.7406927], [39.1511441, 45.7536757], [39.0387482, 45.721808], [38.9250152, 45.7172072], [38.9638296, 45.716937], [38.913285, 45.7709555], [38.6596643, 45.7675096], [38.6841174, 45.7529555], [38.698689, 45.7453379], [38.7218441, 45.762992], [38.7378358, 45.7573272], [38.77303, 45.7721528], [38.6175585, 45.7825066], [38.5944574, 45.8688408], [38.6029337, 45.8669343], [38.613848, 45.8633711], [38.6211834, 45.8664606], [38.6248511, 45.8714721], [38.6243188, 45.8775588], [38.6241807, 45.8841786], [38.6277369, 45.8867053], [38.6306176, 45.8969051], [38.6398512, 45.8983022], [38.6463006, 45.8961496], [38.6581075, 45.9082818], [38.7132295, 45.9082705], [38.7258656, 45.9102978], [38.7336188, 45.9100494], [38.7391087, 45.9097105], [38.7403408, 45.906686], [38.7441006, 45.9056686], [38.7464342, 45.9064166], [38.7503551, 45.9069363], [38.7546361, 45.9102885], [38.7559831, 45.9086343], [38.7571054, 45.9059775], [38.7589498, 45.9040767], [38.7638562, 45.9047432], [38.7702855, 45.9044172], [38.7730389, 45.9064736], [38.7739022, 45.9080695], [38.7767648, 45.9092039], [38.7807425, 45.9100313], [38.7872352, 45.9111049], [38.7992973, 45.9222973], [38.7905285, 45.9337387], [38.7859015, 45.9394059], [38.7812014, 45.9437178], [38.7766854, 45.9418523], [38.7681488, 45.9478128], [38.7590105, 45.9565331], [38.7519142, 45.9659243], [38.7489409, 45.9758136], [38.7435773, 45.9880647], [38.7376294, 45.9970372], [38.7455044, 46.0030764], [38.8044907, 46.0036036], [38.878234, 46.002508], [38.8884474, 45.9602308], [38.9931547, 45.9482179], [38.9985535, 45.9277202], [39.0165512, 45.924566], [39.0669098, 45.9252], [39.0809008, 45.9241529], [39.0870351, 45.9143935], [39.1232625, 45.9145659], [39.2008273, 45.9151485], [39.2870496, 45.8896873], [39.291965, 45.8845696], [39.2957952, 45.8814552], [39.3002747, 45.8815787], [39.3040231, 45.8800165], [39.3066643, 45.8803957], [39.3103913, 45.8826818], [39.3139164, 45.8811444], [39.3160116, 45.8801096], [39.3193658, 45.880315], [39.3210218, 45.8838955], [39.3264291, 45.884844], [39.3332849, 45.8823793], [39.3424687, 45.8833428], [39.3465073, 45.8852678], [39.3521781, 45.8826759], [39.3577824, 45.8874639], [39.3644986, 45.8877178], [39.3698201, 45.8877925], [39.3778345, 45.8891143], [39.3910415, 45.8888998], [39.398155, 45.8865602], [39.4063433, 45.8892693], [39.4310918, 45.8902441], [39.4512239, 45.9265419], [39.5097311, 45.93575], [39.5056024, 45.8865057], [39.5134362, 45.8865288], [39.5182166, 45.8851693], [39.5195419, 45.8851835], [39.5211884, 45.8856674], [39.5224302, 45.8871724], [39.5268074, 45.891595], [39.5270258, 45.8844411], [39.5232288, 45.857518], [39.5238649, 45.8022148], [39.4941187, 45.7870248], [39.46701, 45.795729], [39.448593, 45.786452], [39.2929539, 45.7369095]]]}	45.8546073,39.0608558	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
27	Кущёвский район	kuschyovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.0678142, 46.6357231], [40.1030598, 46.6311456], [40.098989, 46.6319785], [40.0950778, 46.6321655], [40.0930284, 46.6306848], [40.0889063, 46.6345212], [40.0840186, 46.6359517], [40.0800095, 46.6330224], [40.0745613, 46.6342223], [40.0678142, 46.6357231], [40.127428, 46.7212405], [40.1218722, 46.7360045], [40.1278216, 46.7263922], [40.1250323, 46.7217652], [40.0632219, 46.7719415], [40.082354, 46.7298082], [40.0927788, 46.7277241], [40.1018837, 46.7296766], [39.7534009, 46.7874707], [39.7578579, 46.788837], [39.7534009, 46.7874707], [39.7483372, 46.7874898], [39.7462607, 46.7906859], [39.7426796, 46.7912737], [39.7396973, 46.7927506], [39.7335016, 46.7934169], [39.7320022, 46.7922625], [39.7148329, 46.7894925], [39.7226431, 46.7874335], [39.6113359, 46.7856633], [39.4089758, 46.7961426], [39.4012964, 46.7985245], [39.3923002, 46.7998649], [39.3813534, 46.8010751], [39.3744002, 46.8002012], [39.3689026, 46.7995135], [39.4112524, 46.796593], [39.4189936, 46.7968352], [39.4227329, 46.7985112], [39.4398426, 46.8040385], [39.486953, 46.8052503], [39.5638694, 46.7892957], [39.305318, 46.79412], [39.3409452, 46.7994944], [39.2623287, 46.7733089], [39.2620727, 46.7418679], [39.2621223, 46.7526305], [39.2269213, 46.6977658], [39.2494833, 46.681911], [39.2672154, 46.6818476], [39.2876083, 46.6501727], [39.2873646, 46.6134228], [39.2957111, 46.6199679], [39.3000669, 46.6245914], [39.3064219, 46.6206253], [39.3129659, 46.5718648], [39.3258997, 46.4754107], [39.3902765, 46.4341705], [39.4104161, 46.4322074], [39.4267198, 46.4285628], [39.4413749, 46.4586639], [39.4639649, 46.4592136], [39.4803717, 46.3570117], [39.5967035, 46.3470149], [39.5970465, 46.3124653], [39.6738439, 46.3414367], [39.8145284, 46.3751155], [39.8157591, 46.3784802], [39.8232851, 46.3814704], [39.8315389, 46.3804063], [39.8399849, 46.3758778], [39.844262, 46.3732626], [39.851519, 46.3730646], [39.8547052, 46.3795118], [39.8592766, 46.3878327], [39.8740151, 46.3857075], [39.89332, 46.4211398], [39.8862718, 46.4206563], [39.8770623, 46.4253428], [39.8693174, 46.4296616], [39.8633583, 46.4334724], [39.8564759, 46.4318967], [39.8444443, 46.4317292], [39.8377133, 46.4311438], [39.8311734, 46.4331625], [39.8299808, 46.4372039], [39.8212362, 46.4427272], [39.8130214, 46.4441993], [39.798121, 46.4473819], [39.7908068, 46.4487903], [39.7825427, 46.4528157], [39.771746, 46.4530325], [39.7615244, 46.4566271], [39.7543336, 46.4606766], [39.7406247, 46.468202], [39.7311589, 46.4735069], [39.7259787, 46.4735114], [39.7846385, 46.5460837], [39.920605, 46.4960534], [39.9735451, 46.5108831], [40.0580631, 46.5918874], [40.0678142, 46.6357231]]]}	46.5645301,39.6863422	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
28	Крыловский район	krylovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.4225593, 46.2734423], [40.4327774, 46.2601173], [40.3367811, 46.2513982], [40.197503, 46.2743336], [40.2003955, 46.2778011], [40.2000539, 46.2798351], [40.2065732, 46.2779172], [40.2084899, 46.2756311], [40.2200804, 46.2693279], [40.3367811, 46.2513982], [40.1884822, 46.2700989], [40.1961291, 46.2713643], [40.1938087, 46.2740159], [40.1939707, 46.2336991], [39.9849353, 46.2346969], [39.993038, 46.2393279], [40.0014254, 46.2343249], [40.0200985, 46.2315316], [40.0311539, 46.2261245], [40.0357393, 46.2218401], [40.0465024, 46.2151265], [40.0655325, 46.2093181], [40.0906062, 46.2069101], [39.8701986, 46.2337122], [39.9326733, 46.230064], [39.9530963, 46.2306147], [39.9681831, 46.2298925], [39.7153267, 46.2410425], [39.7279861, 46.2396523], [39.749086, 46.2393906], [39.7718885, 46.2412873], [39.7944003, 46.23764], [39.8139776, 46.2332703], [39.6753422, 46.2849703], [39.6747351, 46.3088932], [39.6675142, 46.2936051], [39.8152675, 46.3758898], [39.8181815, 46.3792072], [39.826831, 46.3802552], [39.8350698, 46.3809633], [39.8437008, 46.3742163], [39.8498724, 46.3732859], [39.8547052, 46.3795118], [39.8610135, 46.3883478], [39.8765224, 46.3845517], [39.8907368, 46.4216941], [39.8807161, 46.4249909], [39.8700525, 46.4278767], [39.8652759, 46.4332644], [39.8564759, 46.4318967], [39.8445951, 46.4307112], [39.8360026, 46.4325704], [39.8309731, 46.4354001], [39.8218659, 46.4382696], [39.8157244, 46.4446119], [39.8007213, 46.4470637], [39.7908068, 46.4487903], [39.7813033, 46.4532003], [39.7692868, 46.4551245], [39.7600489, 46.4595881], [39.7462347, 46.462873], [39.7322709, 46.4731977], [39.7259573, 46.4723774], [39.7846385, 46.5460837], [39.9407746, 46.4960803], [39.9731381, 46.5780268], [40.0644322, 46.5696446], [40.0702831, 46.5360288], [40.1390377, 46.5402595], [40.1286141, 46.5402595], [40.1219195, 46.5403894], [40.1116898, 46.5378925], [40.096619, 46.5392374], [40.0853032, 46.5367408], [40.0738721, 46.5359346], [40.2131308, 46.5370727], [40.208355, 46.5341367], [40.1978049, 46.5345952], [40.1871656, 46.5398007], [40.1818235, 46.5365158], [40.1776393, 46.5334473], [40.1707971, 46.5384708], [40.1649681, 46.5370679], [40.1588681, 46.5352378], [40.1520313, 46.5364552], [40.2212605, 46.5228519], [40.2383365, 46.4482403], [40.28613, 46.3763464], [40.2472941, 46.348587], [40.2474773, 46.3452568], [40.2643286, 46.3454742], [40.254251, 46.3456119], [40.3241992, 46.2925204], [40.396111, 46.2743452], [40.3896389, 46.2746688], [40.3828343, 46.2761195], [40.3733517, 46.2791624], [40.3697682, 46.2777477], [40.3621419, 46.2792045], [40.3540963, 46.2805762], [40.3467614, 46.2799016], [40.3377982, 46.2798832], [40.3285416, 46.280381], [40.4225593, 46.2734423]]]}	46.398871,40.0499186	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
29	Каневской район	kanevskoy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.114075, 46.3376077], [39.0906314, 46.3121497], [39.0993154, 46.2362334], [39.1184797, 46.2309878], [39.141506, 46.2008732], [39.2212141, 46.1514339], [39.2097494, 46.1066786], [39.2088225, 46.1008549], [39.1993159, 46.1059619], [39.1904423, 46.0558073], [39.1847203, 46.0389403], [39.3271308, 45.9987647], [39.3093409, 46.0088832], [39.2970029, 46.0221153], [39.3191354, 46.01901], [39.469805, 46.0435258], [39.4124318, 45.890169], [39.3322013, 45.8821926], [39.3521781, 45.8826759], [39.3704209, 45.8876506], [39.4006119, 45.8873518], [39.2962587, 45.8813303], [39.306615, 45.8815925], [39.3172848, 45.8796941], [39.3303452, 45.882805], [39.1240494, 45.9145697], [39.0087953, 45.9239421], [38.8779183, 45.9844264], [38.7921146, 45.9298014], [38.7774428, 45.942689], [38.7524021, 45.9649691], [38.7376294, 45.9970372], [38.7364893, 45.9090011], [38.745666, 45.9053441], [38.7558546, 45.9093891], [38.7630268, 45.9047378], [38.7738271, 45.9078903], [38.7871018, 45.9111091], [38.7187213, 45.9238404], [38.7179366, 45.9459073], [38.7115904, 45.9612784], [38.6951495, 45.9731829], [38.6663003, 45.9831624], [38.6494755, 45.9981683], [38.6409304, 46.0107338], [38.6315626, 46.0320917], [38.624884, 46.0442997], [38.6305772, 46.0546245], [38.6072797, 46.0453867], [38.5819928, 46.0559432], [38.5825887, 46.0522074], [38.5807042, 46.0814428], [38.5773791, 46.0829934], [38.576966, 46.0797432], [38.57844, 46.0766463], [38.579124, 46.0732472], [38.5797053, 46.0698687], [38.579933, 46.0660555], [38.5806793, 46.0625466], [38.5818274, 46.0586266], [38.5231047, 46.1373353], [38.5260698, 46.1348269], [38.5286545, 46.1329838], [38.5309243, 46.1304983], [38.5334065, 46.1285379], [38.5362099, 46.127059], [38.5387085, 46.1257832], [38.5414995, 46.1237206], [38.5450093, 46.1218491], [38.5493661, 46.1199154], [38.5534464, 46.1182961], [38.5573545, 46.1170413], [38.5614193, 46.1158589], [38.5652129, 46.1146723], [38.5687962, 46.1139536], [38.5709804, 46.1114835], [38.5726118, 46.1092], [38.5749698, 46.1065261], [38.5761094, 46.1034763], [38.5770492, 46.1002661], [38.5790593, 46.0969104], [38.5813339, 46.0941262], [38.5807389, 46.0910786], [38.5820463, 46.0879493], [38.5806781, 46.0843931], [38.5133118, 46.1390062], [38.5163831, 46.1398886], [38.5195603, 46.1400704], [38.510928, 46.1385751], [38.5077173, 46.1497834], [38.5296644, 46.1833156], [38.5684705, 46.2474931], [38.5661668, 46.2439135], [38.5687753, 46.2409267], [38.583901, 46.3161216], [38.5832016, 46.2643086], [38.5781086, 46.2528566], [38.651862, 46.3942602], [38.7611181, 46.3944331], [38.9479747, 46.3945815], [39.0521184, 46.3590739], [39.114075, 46.3376077]]]}	46.137344,39.0081287	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
30	Ленинградский муниципальный округ	leningradskiy-munitsipalnyy-okrug	district	2	{"type": "Polygon", "coordinates": [[[39.5850548, 46.1952346], [39.6753805, 46.2515601], [39.6672469, 46.2954151], [39.6738439, 46.3414367], [39.5971103, 46.3446579], [39.4191689, 46.4314893], [39.443468, 46.4588457], [39.4803717, 46.3570117], [39.3134444, 46.424429], [39.2896617, 46.4259577], [39.2674332, 46.4228164], [39.25518, 46.420412], [39.2610671, 46.4083885], [39.2429542, 46.3959886], [39.2277535, 46.3878226], [39.1712079, 46.3599096], [39.1619719, 46.32088], [39.1141946, 46.3367265], [39.1058087, 46.329399], [39.1072475, 46.3253403], [39.0906314, 46.3121497], [39.0981872, 46.2460232], [39.0977786, 46.2386291], [39.0989983, 46.2362334], [39.1019036, 46.2358859], [39.1101434, 46.2332662], [39.1161301, 46.2313514], [39.1310964, 46.2263697], [39.1316897, 46.2003625], [39.1405066, 46.2007956], [39.1570802, 46.1908495], [39.2090586, 46.1947684], [39.2229136, 46.1654785], [39.2154088, 46.1413061], [39.2134845, 46.1105781], [39.2097738, 46.1076884], [39.2098877, 46.1049648], [39.2097762, 46.1034213], [39.2091396, 46.1017006], [39.208948, 46.0996714], [39.2069025, 46.0989266], [39.2042755, 46.1018432], [39.1979325, 46.1044572], [39.1983119, 46.0648973], [39.1911294, 46.0572969], [39.1906358, 46.0540443], [39.1920325, 46.0517863], [39.1919384, 46.0485607], [39.1769441, 46.0222723], [39.2771409, 46.0028978], [39.3273759, 45.9953092], [39.3273912, 45.9991793], [39.3289148, 46.0044316], [39.3205585, 46.0044041], [39.308632, 46.008875], [39.293025, 46.0117704], [39.2930025, 46.0151273], [39.2970029, 46.0221153], [39.3058005, 46.0210152], [39.3117488, 46.0194521], [39.3182681, 46.0191861], [39.3260378, 46.0179861], [39.3314945, 46.0198142], [39.4569422, 46.0434907], [39.521675, 46.043796], [39.5232889, 46.0893595], [39.5240037, 46.0920732], [39.5243938, 46.095098], [39.5270611, 46.0985589], [39.5302899, 46.096627], [39.5317493, 46.0958773], [39.5329845, 46.0947455], [39.5337877, 46.094182], [39.5349412, 46.0939488], [39.5368396, 46.0939618], [39.5409165, 46.0940201], [39.5423292, 46.0937999], [39.5448188, 46.0937329], [39.5522535, 46.0938948], [39.5527905, 46.0976935], [39.551212, 46.1020909], [39.5549621, 46.1033117], [39.5566169, 46.1042018], [39.5573036, 46.1048638], [39.5579714, 46.1057881], [39.5577059, 46.1066956], [39.5578963, 46.1073427], [39.5583791, 46.1079917], [39.5593421, 46.1085496], [39.5616568, 46.1085068], [39.5634163, 46.1084101], [39.5649103, 46.1081423], [39.5659569, 46.1084044], [39.5674876, 46.1087369], [39.5682733, 46.1104999], [39.5676911, 46.1116592], [39.567439, 46.1125485], [39.5665621, 46.1134552], [39.5672167, 46.114311], [39.5850912, 46.1108467], [39.5854576, 46.1610747], [39.5850548, 46.1952346]]]}	46.2259654,39.417124	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
31	Лабинский район	labinskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[41.1199681, 44.2147078], [41.150038, 44.1580447], [41.1659322, 44.1518706], [41.1728299, 44.1611417], [41.1757432, 44.1615444], [41.1900926, 44.1621379], [41.2090664, 44.1601268], [41.1957273, 44.1424342], [41.1883713, 44.1356818], [41.1665098, 44.138082], [41.1650007, 44.1095978], [41.1786778, 44.1118394], [41.1893913, 44.1182454], [41.2003741, 44.1115777], [41.2074742, 44.0995376], [41.2293766, 44.091206], [41.2302958, 44.0945752], [41.080627, 44.288708], [41.0953756, 44.267989], [41.0510986, 44.3158304], [41.1241817, 44.3508353], [41.1696081, 44.3652603], [41.1916498, 44.419705], [41.1698437, 44.4961842], [41.2107056, 44.5314081], [41.1557781, 44.6063159], [41.13806, 44.6400198], [41.0600172, 44.6904977], [41.0475732, 44.7046138], [41.0339196, 44.7315533], [40.968643, 44.736567], [40.8022087, 44.7666683], [40.8059568, 44.7659679], [40.806026, 44.7645738], [40.8090641, 44.7614629], [40.8129009, 44.7602465], [40.8150349, 44.7603974], [40.8166915, 44.7573586], [40.8160462, 44.7584819], [40.8177708, 44.7586441], [40.8201523, 44.7561595], [40.8187157, 44.7544107], [40.8218881, 44.7548399], [40.807149, 44.7484204], [40.7029444, 44.7384877], [40.6759334, 44.6999433], [40.6801862, 44.6621358], [40.6800118, 44.6641694], [40.6788013, 44.6651967], [40.6781799, 44.6661608], [40.6703819, 44.6728349], [40.6643778, 44.6820173], [40.6590929, 44.685841], [40.6545356, 44.6867134], [40.6523814, 44.6905363], [40.6494677, 44.6948859], [40.7277853, 44.5720631], [40.7304752, 44.5849649], [40.7313198, 44.5936145], [40.7348726, 44.6018687], [40.7318949, 44.6087203], [40.7267149, 44.6146103], [40.7213667, 44.6199346], [40.7172627, 44.6246177], [40.7100742, 44.62878], [40.7010328, 44.6330398], [40.6956396, 44.635067], [40.6909362, 44.6406525], [40.6852674, 44.6470625], [40.6823812, 44.6518275], [40.6827009, 44.6587959], [40.7272021, 44.5558132], [40.7286345, 44.5677647], [40.7752945, 44.4785593], [40.7628606, 44.4882315], [40.7482107, 44.5074713], [40.7460665, 44.5248232], [40.7342532, 44.5362375], [40.7761819, 44.4573291], [40.7817509, 44.4443425], [40.793068, 44.4339635], [40.8042199, 44.426922], [40.8190639, 44.4037547], [40.8361496, 44.3938581], [40.8463858, 44.359124], [40.8656151, 44.3262775], [40.891843, 44.2823064], [40.8909851, 44.2696581], [40.8864188, 44.2577984], [40.8899303, 44.2388648], [40.88524, 44.2246903], [40.8869273, 44.2096671], [40.9146183, 44.2076493], [40.9220989, 44.1793033], [41.0920446, 44.0976353], [41.0329729, 44.1161672], [40.9468676, 44.1423477], [41.1703049, 44.0886842], [41.1668432, 44.1048955], [41.1536605, 44.1089915], [41.1251433, 44.1259803], [41.1225563, 44.1065239], [41.2322815, 44.0897056], [41.1199681, 44.2147078]]]}	44.4408676,40.9405803	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
32	Отрадненский район	otradnenskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[41.2107056, 44.5314081], [41.1701128, 44.50069], [41.176414, 44.48345], [41.1916498, 44.419705], [41.1821812, 44.3888847], [41.1618265, 44.3523163], [41.0577831, 44.3238586], [41.055222, 44.302763], [41.073761, 44.291667], [41.0957138, 44.2777636], [41.1170493, 44.2192988], [41.1323457, 44.1840066], [41.1524431, 44.1555807], [41.1659322, 44.1518706], [41.1701205, 44.1594663], [41.1728321, 44.1643762], [41.1825063, 44.1598457], [41.1950885, 44.1622278], [41.2090664, 44.1601268], [41.1937267, 44.1464708], [41.1971635, 44.134266], [41.1784615, 44.1389352], [41.1610606, 44.1346377], [41.1650007, 44.1095978], [41.1731943, 44.1101553], [41.1851598, 44.1140469], [41.1931949, 44.118746], [41.2009922, 44.1109519], [41.2074742, 44.0995376], [41.220977, 44.0912516], [41.2259533, 44.0965898], [41.2426103, 44.0948291], [41.2766042, 44.015189], [41.2501357, 44.0138039], [41.2563354, 44.0237308], [41.2673401, 44.0368117], [41.2767654, 44.0429985], [41.2786891, 44.0541463], [41.2756306, 44.0667219], [41.2768736, 44.0725801], [41.2823801, 44.0668674], [41.2914202, 44.0847475], [41.2481324, 44.0944276], [41.390922, 43.9919805], [41.3762527, 44.0030581], [41.3654106, 44.0092252], [41.3585971, 44.0036474], [41.3517558, 43.9912273], [41.3155451, 43.9836076], [41.3043823, 43.998926], [41.3058414, 44.0025512], [41.3060453, 44.0055105], [41.2990854, 44.0055586], [41.3169144, 44.0206458], [41.3158214, 44.0248056], [41.3063164, 44.0123128], [41.3039744, 44.0186933], [41.3012948, 44.0215105], [41.2962054, 44.0084391], [41.2862428, 44.0138366], [41.2872382, 44.002958], [41.5510287, 44.0608178], [41.5385829, 44.0446646], [41.5227052, 44.0469174], [41.5055822, 44.0457079], [41.4945181, 44.0463271], [41.4858802, 44.0467616], [41.4843233, 44.0514167], [41.4800945, 44.0508933], [41.477831, 44.0424506], [41.480347, 44.035158], [41.4797244, 44.0257217], [41.4772036, 44.0179191], [41.4819515, 44.0090618], [41.4797499, 44.0009256], [41.4238442, 43.9927867], [41.6996564, 44.1829683], [41.6906887, 44.1698573], [41.6806144, 44.164453], [41.6746216, 44.1535953], [41.6625055, 44.1428573], [41.6508204, 44.1329004], [41.6310233, 44.1268621], [41.6253609, 44.1144155], [41.5869512, 44.1090345], [41.5545482, 44.0985085], [41.7118379, 44.2078451], [41.7095837, 44.1936309], [41.7424394, 44.2670938], [41.739817, 44.257868], [41.7278569, 44.2492987], [41.7281293, 44.2388748], [41.7252858, 44.229303], [41.7149864, 44.2169931], [41.7161895, 44.3026251], [41.6807895, 44.3364304], [41.6939037, 44.4100415], [41.7062226, 44.4551787], [41.7228511, 44.4857141], [41.6383359, 44.5251383], [41.5316495, 44.6025825], [41.4039775, 44.6239436], [41.39455, 44.6025839], [41.3913072, 44.6054025], [41.3864746, 44.6081592], [41.3836573, 44.6130191], [41.380358, 44.6164614], [41.3627845, 44.5872808], [41.3956058, 44.6016958], [41.2107056, 44.5314081]]]}	44.308353,41.3975382	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
34	городской округ Армавир	gorodskoy-okrug-armavir	district	2	{"type": "Polygon", "coordinates": [[[41.1896501, 44.9932297], [41.1862812, 44.9940066], [41.1797875, 44.99733], [41.1768624, 45.0004806], [41.1741094, 45.0002884], [41.1685434, 45.0004522], [41.1654798, 45.0021977], [41.1896501, 44.9932297], [41.1718928, 44.9861694], [41.178749, 44.9889334], [41.1844204, 44.9896212], [41.1861949, 44.9616347], [41.1938669, 44.9643562], [41.1888754, 44.967148], [41.182786, 44.9666083], [41.1828094, 44.9682682], [41.1817498, 44.9688409], [41.180335, 44.970434], [41.182176, 44.9718728], [41.1817121, 44.9720359], [41.176617, 44.9758631], [41.1738233, 44.9813197], [41.1719789, 44.9822836], [41.1701639, 44.9823533], [41.1669067, 44.9845548], [41.1676077, 44.9877697], [41.1719148, 44.9581818], [41.1800068, 44.961247], [41.2270873, 44.8814956], [41.2289964, 44.8827906], [41.2344817, 44.8839244], [41.2384272, 44.8875149], [41.2454076, 44.8905234], [41.2087679, 44.9175832], [41.1992259, 44.9246118], [41.1857235, 44.9172467], [41.1593781, 44.9161225], [41.1608655, 44.9269347], [41.1626426, 44.9281153], [41.164398, 44.93271], [41.1659619, 44.9368815], [41.1569489, 44.9484634], [41.1630099, 44.9487209], [41.1648146, 44.9471557], [41.1694822, 44.9540193], [41.1646391, 44.9552763], [41.166855, 44.9571238], [41.1701204, 44.955278], [41.1709706, 44.9571217], [41.2494149, 44.7845887], [41.2628621, 44.7999451], [41.2564899, 44.8523637], [41.2552313, 44.8580131], [41.2379518, 44.8609265], [41.2321368, 44.7976038], [41.2381485, 44.7932337], [41.2494149, 44.7845887], [41.1500407, 44.9106205], [41.1518145, 44.9049397], [41.1543294, 44.8999729], [41.1485381, 44.8881469], [41.1598652, 44.8891644], [41.1648565, 44.880265], [41.1594813, 44.8784966], [41.162498, 44.8758925], [41.1562342, 44.8746235], [41.1482481, 44.8709434], [41.1438744, 44.8694381], [41.142961, 44.8651871], [41.1479845, 44.8596655], [41.1500244, 44.85547], [41.151799, 44.8477193], [41.1480513, 44.8377975], [41.149584, 44.8346504], [41.1526378, 44.8203897], [41.1515199, 44.8182273], [41.1553706, 44.8169572], [41.1559916, 44.8093766], [41.1601601, 44.8047069], [41.1681738, 44.7957827], [41.1860848, 44.7878045], [41.1930947, 44.786173], [41.199749, 44.7809911], [41.1964849, 44.7773929], [41.2005229, 44.7799498], [41.201374, 44.7762707], [41.0844685, 44.9511229], [41.0817907, 44.9074955], [41.0901425, 44.9006661], [40.9995577, 44.9794546], [41.0344304, 44.954416], [41.0694263, 44.959938], [41.0470772, 45.0489673], [41.0167354, 45.0300769], [41.0012497, 45.0203657], [40.9462022, 45.0325018], [40.9427315, 45.0352692], [40.9199263, 45.053056], [41.1083702, 45.0583632], [41.1029478, 45.0600711], [41.0977902, 45.0613111], [41.0923959, 45.0612228], [41.0903731, 45.0612783], [41.0891428, 45.0585381], [41.0772647, 45.0620111], [41.0719534, 45.0652531], [41.1376448, 45.0221683], [41.136474, 45.023895], [41.1340913, 45.0252799], [41.13026, 45.028347], [41.1188564, 45.0350422], [41.1140084, 45.0513396], [41.1543696, 45.0196114], [41.1480689, 45.0224764], [41.1542685, 45.0195162], [41.1622256, 45.007042], [41.1552998, 45.010885], [41.1589231, 45.0143401], [41.1543991, 45.0156628], [41.1654592, 45.0037085], [41.1896501, 44.9932297]]]}	44.9207619,41.0792476	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
35	Новокубанский район	novokubanskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[41.3533377, 45.2143651], [41.2819749, 45.2591721], [41.2862098, 45.2529481], [41.2904645, 45.2420008], [41.2906136, 45.236049], [41.29349, 45.2312853], [41.2789967, 45.2638468], [41.1370146, 45.2246213], [40.9017061, 45.2360523], [40.8530607, 45.2037384], [40.7984451, 45.1435387], [40.8092454, 45.116406], [40.9097111, 44.9629649], [40.8028861, 44.9439154], [40.9182543, 44.870403], [40.8951996, 44.926857], [40.9681048, 44.8381958], [40.9571136, 44.855035], [40.9430929, 44.8586071], [40.9914227, 44.7442433], [41.1823201, 44.6244151], [41.1305118, 44.6411931], [41.0600172, 44.6904977], [41.050439, 44.6998762], [41.0434995, 44.7172713], [41.0207306, 44.7416174], [41.1823201, 44.6244151], [41.2815963, 44.5179742], [41.3866663, 44.6010597], [41.39455, 44.6025839], [41.3913072, 44.6054025], [41.3864746, 44.6081592], [41.3836573, 44.6130191], [41.380358, 44.6164614], [41.3685127, 44.6194195], [41.3575637, 44.6198678], [41.3411483, 44.627829], [41.3273506, 44.6376478], [41.3200862, 44.6473782], [41.3109394, 44.6596418], [41.306719, 44.6660528], [41.2920381, 44.6756132], [41.2973712, 44.6833517], [41.296658, 44.6865041], [41.286457, 44.687452], [41.2904568, 44.6929627], [41.2810957, 44.6935949], [41.2723775, 44.7001137], [41.2699182, 44.7040535], [41.264372, 44.7117675], [41.2624165, 44.7215486], [41.2432128, 44.7315799], [41.2311532, 44.7512113], [41.2209578, 44.7535839], [41.2154143, 44.7532717], [41.210747, 44.758565], [41.212201, 44.7691034], [41.1262209, 44.9261018], [41.1529812, 44.8980172], [41.1648565, 44.880265], [41.1570459, 44.8753094], [41.1462603, 44.8678248], [41.1500244, 44.85547], [41.1475664, 44.8368337], [41.1511092, 44.8159755], [41.1601601, 44.8047069], [41.1910575, 44.7861467], [41.198131, 44.7775066], [41.0844685, 44.9511229], [40.9991278, 44.9812694], [41.0836955, 44.9514954], [41.0012497, 45.0203657], [40.9360988, 45.0401514], [41.0990333, 45.0614259], [41.0903731, 45.0612783], [41.0757649, 45.0626468], [41.1363645, 45.0240254], [41.1188564, 45.0350422], [41.1509132, 45.0223518], [41.1603963, 45.0074819], [41.1543991, 45.0156628], [41.1862812, 44.9940066], [41.1759755, 45.000491], [41.1654592, 45.0037085], [41.195346, 44.9941381], [41.3494111, 45.0349399], [41.4275879, 45.0210805], [41.4238936, 45.0264553], [41.4206884, 45.0327947], [41.4168802, 45.0400175], [41.4162375, 45.0438727], [41.4137808, 45.0474754], [41.4104386, 45.0519355], [41.4098928, 45.0557495], [41.4088327, 45.0583507], [41.4044976, 45.0650384], [41.4000456, 45.0675214], [41.3983361, 45.0692808], [41.3953329, 45.0710858], [41.3939316, 45.0729155], [41.3886494, 45.077137], [41.383003, 45.0793224], [41.3795583, 45.0812307], [41.3757916, 45.0827495], [41.3738554, 45.0835029], [41.3689323, 45.0860437], [41.364131, 45.0866557], [41.3587811, 45.0879766], [41.3556159, 45.0885974], [41.3531163, 45.0888921], [41.3521626, 45.0900559], [41.3514443, 45.0913906], [41.3533377, 45.2143651]]]}	44.8909105,41.086172	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
36	Курганинский район	kurganinskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.1254264, 45.1842956], [40.1823204, 45.1842628], [40.2513029, 45.1992894], [40.2624805, 45.1971739], [40.3301391, 45.1926147], [40.4041758, 45.1562318], [40.4325545, 45.1563417], [40.5629284, 45.1604153], [40.7747588, 45.0650948], [40.6847404, 45.1269038], [40.9097111, 44.9629649], [40.8028861, 44.9439154], [40.9182543, 44.870403], [40.8951996, 44.926857], [40.9681048, 44.8381958], [40.9571136, 44.855035], [40.9430929, 44.8586071], [40.9914227, 44.7442433], [40.9968602, 44.7363144], [40.838555, 44.7811898], [40.8017452, 44.7658539], [40.8059189, 44.7654607], [40.8057493, 44.7644218], [40.8085108, 44.7618074], [40.8118748, 44.7608737], [40.8142929, 44.7609244], [40.8142843, 44.7599034], [40.8160576, 44.7571275], [40.8151493, 44.758249], [40.8167143, 44.7588387], [40.8179274, 44.7576979], [40.8196615, 44.7565841], [40.8183954, 44.7541853], [40.820981, 44.754819], [40.8249851, 44.7538131], [40.7976814, 44.7456647], [40.6983942, 44.7275493], [40.687723, 44.7032322], [40.649515, 44.6968336], [40.6531712, 44.7007612], [40.6491215, 44.7083291], [40.6477388, 44.7199627], [40.6408805, 44.7283312], [40.6389108, 44.7446813], [40.6333243, 44.7531842], [40.6269983, 44.7639522], [40.6312334, 44.7711982], [40.6266358, 44.7824244], [40.6222551, 44.7951249], [40.6122488, 44.8045058], [40.6051368, 44.8067709], [40.5987681, 44.8146155], [40.5945714, 44.8216821], [40.5912602, 44.8265182], [40.5860795, 44.8315996], [40.5837336, 44.8416614], [40.5884612, 44.8626366], [40.579635, 44.8674064], [40.5548619, 44.8816625], [40.5420492, 44.8938342], [40.5339283, 44.9019677], [40.5283459, 44.9291911], [40.4928617, 44.9559544], [40.4482008, 44.983266], [40.4331694, 45.0011508], [40.4005664, 45.0240442], [40.3507372, 45.04517], [40.3376571, 45.0452327], [40.3470917, 45.0558429], [40.3319907, 45.0567403], [40.3201392, 45.0547838], [40.3107014, 45.0597655], [40.2931873, 45.062363], [40.2846266, 45.0630098], [40.285155, 45.0649527], [40.2914243, 45.0696121], [40.284552, 45.0732202], [40.2912314, 45.0777057], [40.2844079, 45.0845806], [40.2878456, 45.0904917], [40.2808766, 45.1032152], [40.2612573, 45.1000564], [40.2478019, 45.0980303], [40.2484308, 45.1040155], [40.241882, 45.1105736], [40.2388612, 45.1133733], [40.225714, 45.1176068], [40.2133948, 45.1163655], [40.2033111, 45.1126598], [40.1918078, 45.1156862], [40.1858536, 45.1162509], [40.179563, 45.1110776], [40.1729493, 45.1162511], [40.1662828, 45.1218718], [40.1641585, 45.1153146], [40.1614094, 45.1169321], [40.1552576, 45.1209434], [40.1360345, 45.120171], [40.1275006, 45.1126525], [40.1128203, 45.1159813], [40.0966883, 45.1096945], [40.0880903, 45.1107554], [40.1254264, 45.1842956]]]}	44.9583917,40.5554569	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
37	Гулькевичский район	gulkevichskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.4671396, 45.1845597], [40.4097112, 45.1638182], [40.4112536, 45.2544869], [40.3986368, 45.1989013], [40.3796332, 45.1980772], [40.357706, 45.2008927], [40.3859469, 45.3065833], [40.3375978, 45.3485473], [40.289564, 45.3338964], [40.2727731, 45.3496654], [40.2915518, 45.3453885], [40.2927344, 45.3502975], [40.2805398, 45.3525516], [40.314189, 45.3693506], [40.3310231, 45.3791246], [40.3284893, 45.3579686], [40.3467133, 45.3620772], [40.3359933, 45.3712519], [40.3631831, 45.3733058], [40.3651321, 45.3830263], [40.377119, 45.3801514], [40.3819917, 45.3800145], [40.3931015, 45.3902129], [40.414444, 45.4000674], [40.4190244, 45.3889126], [40.4353967, 45.3994515], [40.4394291, 45.3862696], [40.4336411, 45.3790151], [40.4590884, 45.3765267], [40.4758059, 45.3844067], [40.4827183, 45.3800551], [40.5020996, 45.3853069], [40.5205364, 45.3846222], [40.5356418, 45.3880444], [40.551332, 45.3922877], [40.5671025, 45.392732], [40.5893248, 45.3964276], [40.5936271, 45.4120626], [40.6036649, 45.4056314], [40.6175034, 45.4054261], [40.6319485, 45.4013763], [40.6398749, 45.4000778], [40.6423336, 45.4026241], [40.6293929, 45.4115153], [40.6360135, 45.4174966], [40.6542666, 45.4168313], [40.679751, 45.4351701], [40.6741376, 45.431614], [40.6789872, 45.4193361], [40.6909777, 45.4264708], [40.7064145, 45.4339665], [40.726607, 45.4313404], [40.735261, 45.4186458], [40.7552976, 45.4258142], [40.7689412, 45.4306291], [40.7703446, 45.4212178], [40.7724496, 45.4313951], [40.788787, 45.4315053], [40.7933674, 45.4246659], [40.8052568, 45.4212459], [40.8251103, 45.419682], [40.8330313, 45.4301375], [40.8568102, 45.4293852], [40.8793221, 45.4369079], [40.9000799, 45.4277438], [40.9067068, 45.4431304], [40.9244435, 45.4241872], [40.9369176, 45.4254867], [40.9508536, 45.4185782], [40.9568958, 45.4194675], [41.0197003, 45.3018305], [41.014891, 45.3114451], [41.0028753, 45.3174333], [40.9963486, 45.3209309], [40.9985413, 45.3360896], [41.0071959, 45.3495026], [40.9919687, 45.3672282], [41.0071564, 45.3780887], [40.994256, 45.3895018], [40.9740332, 45.3925391], [40.9735503, 45.414358], [41.035159, 45.2486788], [41.0349632, 45.2584182], [41.021898, 45.2559821], [41.0168837, 45.2634004], [41.0276139, 45.2666182], [41.0195668, 45.2728353], [41.0135956, 45.274369], [41.0156909, 45.2773967], [41.0345739, 45.2790686], [41.0230973, 45.2797363], [41.0291306, 45.2812915], [41.0275937, 45.2892977], [41.0202869, 45.2914926], [40.9017061, 45.2360523], [41.0254738, 45.2322305], [40.8825027, 45.2433877], [40.8530607, 45.2037384], [40.8092454, 45.116406], [40.748842, 45.0831144], [40.6373542, 45.1441168], [40.5629284, 45.1604153], [40.4671396, 45.1845597]]]}	45.2512851,40.6553703	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
38	Кавказский район	kavkazskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.2195745, 45.5557867], [40.3666206, 45.5149975], [40.2195745, 45.5557867], [40.2188141, 45.6140412], [40.4739845, 45.6208831], [40.4451067, 45.5903758], [40.4366282, 45.5870682], [40.4739845, 45.6208831], [40.5119434, 45.6206701], [40.8479682, 45.694229], [40.7439177, 45.6912506], [40.846552, 45.5705421], [40.846552, 45.5705421], [40.9769408, 45.4123703], [40.9794049, 45.4175303], [40.9762777, 45.4255623], [40.9675003, 45.4280422], [40.9542919, 45.4323655], [40.9476783, 45.4354613], [40.936437, 45.4403883], [40.9323126, 45.4437217], [40.927614, 45.4472013], [40.9230516, 45.4867402], [40.9071546, 45.5165794], [40.8822909, 45.5147641], [40.8604624, 45.5167638], [40.8473812, 45.5169392], [40.8268308, 45.4201842], [40.8291331, 45.4261023], [40.844336, 45.4265811], [40.8658734, 45.4287697], [40.8756189, 45.4345144], [40.8875083, 45.4297272], [40.9008595, 45.4301375], [40.9050501, 45.4450449], [40.9082661, 45.4321892], [40.9261977, 45.4234348], [40.9386718, 45.4273334], [40.9452987, 45.4252815], [40.9535823, 45.4193991], [40.9594296, 45.4221352], [40.9735503, 45.414358], [40.7680836, 45.4283859], [40.7678497, 45.4229141], [40.7766596, 45.4246104], [40.7741648, 45.4315593], [40.7878084, 45.4330365], [40.7936598, 45.4195359], [40.7939521, 45.4273334], [40.8010663, 45.4222036], [40.8196642, 45.4161983], [40.6360135, 45.4174966], [40.6473182, 45.4141035], [40.6610398, 45.4226953], [40.679751, 45.4351701], [40.6787375, 45.4316687], [40.6714869, 45.4282217], [40.6789872, 45.4193361], [40.6862999, 45.4250482], [40.6984622, 45.4266897], [40.7064145, 45.4339665], [40.7210716, 45.4313404], [40.7238783, 45.4260878], [40.735261, 45.4186458], [40.7482809, 45.423133], [40.7594297, 45.4321611], [40.6415981, 45.400916], [40.6420383, 45.4031973], [40.6320241, 45.4081629], [40.6311527, 45.4167817], [40.5717974, 45.3912611], [40.584052, 45.3948609], [40.5950102, 45.401012], [40.5968431, 45.4115153], [40.6014235, 45.4048787], [40.6079529, 45.4047419], [40.6207194, 45.4057682], [40.62934, 45.4039368], [40.6367803, 45.3997164], [40.5020996, 45.3853069], [40.5147866, 45.386744], [40.5252142, 45.3835271], [40.5356418, 45.3880444], [40.5431458, 45.3909874], [40.5578614, 45.3929036], [40.4812259, 45.3802975], [40.4936234, 45.3840101], [40.3310231, 45.3791246], [40.3240064, 45.3658431], [40.3347264, 45.3528325], [40.3467133, 45.3620772], [40.3316078, 45.3674179], [40.3468107, 45.3723473], [40.3631831, 45.3733058], [40.3600645, 45.3817258], [40.3694201, 45.3759757], [40.377119, 45.3801514], [40.3795554, 45.3866539], [40.3868645, 45.3788508], [40.3931015, 45.3902129], [40.4067451, 45.3953457], [40.4174651, 45.39952], [40.4190244, 45.3889126], [40.4279902, 45.3958247], [40.4397285, 45.3971671], [40.4394291, 45.3862696], [40.4322939, 45.3824498], [40.4393293, 45.3788399], [40.4590884, 45.3765267], [40.4668224, 45.3851482], [40.47847, 45.3825233], [40.3027606, 45.4609989], [40.3091863, 45.3737321], [40.3092471, 45.4950234], [40.3008894, 45.4727655], [40.347418, 45.4841798], [40.3421165, 45.4901703], [40.3388109, 45.4941053], [40.3302661, 45.4916569], [40.3169187, 45.4937118], [40.2195745, 45.5557867]]]}	45.523757,40.5997104	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
97	Тихорецк	tihoretsk	city	2	\N	45.854679,40.128124	54582	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
39	Белоглинский район	beloglinskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.9116305, 45.6939517], [40.8612148, 45.7501888], [40.8494267, 45.7508851], [40.8489277, 45.7526694], [40.9122705, 45.7802434], [40.97808, 45.8517923], [40.9400783, 45.879377], [40.9205311, 45.931354], [40.8726827, 45.9655791], [40.7579618, 46.0475507], [40.7467919, 46.0490389], [40.7453517, 46.1671294], [40.5823864, 46.160243], [40.5298766, 46.1423089], [40.664687, 46.20502], [40.6616416, 46.2004672], [40.6603016, 46.1959983], [40.6742881, 46.2859245], [40.7438024, 46.2853995], [40.7444897, 46.2290633], [40.8998123, 46.2299122], [40.9255568, 46.2701419], [40.9255346, 46.2952768], [40.9301887, 46.2968239], [40.934423, 46.2971172], [40.9392223, 46.2972948], [40.9427789, 46.2954888], [40.9461213, 46.2938011], [40.9502836, 46.2929022], [40.9529774, 46.2918766], [40.9588051, 46.2927352], [40.9645239, 46.2932878], [40.9667754, 46.2951631], [40.9710757, 46.2954727], [40.9741139, 46.2961725], [40.9777101, 46.2964866], [40.9904218, 46.2983631], [40.9907203, 46.2666942], [40.9912509, 46.2074023], [40.9657756, 46.1942077], [40.96708, 46.1932941], [40.9665148, 46.191107], [40.9677762, 46.1890879], [40.9745341, 46.1879975], [40.977259, 46.1877737], [40.9785542, 46.1817726], [40.9790767, 46.1331793], [40.9787882, 46.1134055], [40.9860264, 46.1132666], [40.9882441, 46.1152601], [40.9933679, 46.1162039], [40.9984618, 46.1148429], [41.0013181, 46.1183103], [41.0042042, 46.1187034], [41.009381, 46.1169797], [41.0147648, 46.1177569], [41.0208981, 46.1196086], [41.0258429, 46.1199685], [41.0302041, 46.1195596], [41.038459, 46.1219984], [41.0448783, 46.1225003], [41.0489318, 46.1203459], [41.053207, 46.1191689], [41.0573734, 46.1202271], [41.0649764, 46.1201291], [41.066683, 46.1166533], [41.0695134, 46.1133303], [41.0695956, 46.0912523], [41.1082242, 46.0776194], [41.1218425, 46.0596109], [41.1216166, 46.0326137], [41.1347908, 45.99883], [41.1608482, 45.9571932], [41.1609907, 45.9279011], [41.2475133, 45.7589362], [41.2727983, 45.7948098], [41.2577083, 45.8044367], [41.2597973, 45.8079838], [41.2566287, 45.8145175], [41.2569371, 45.818059], [41.2430534, 45.822867], [41.2380082, 45.8255111], [41.2337231, 45.8324681], [41.2403385, 45.8352278], [41.2390366, 45.8385586], [41.2429789, 45.8409468], [41.2404783, 45.8445527], [41.239407, 45.8472989], [41.2470773, 45.8486719], [41.2541049, 45.8528803], [41.2617752, 45.8589088], [41.259247, 45.8630269], [41.2547494, 45.8651325], [41.2552156, 45.869181], [41.2508277, 45.8695247], [41.250718, 45.8659919], [41.2490098, 45.8800514], [41.1300082, 45.6747943], [41.2423106, 45.7590712], [40.938195, 45.6938388], [40.9646745, 45.7072658], [40.9733304, 45.7097794], [40.9790724, 45.7136093], [40.9836574, 45.7132802], [40.9901493, 45.7128773], [40.9991479, 45.7098851], [41.003433, 45.712608], [41.0093036, 45.7120395], [41.009815, 45.7075187], [41.0187736, 45.7053068], [41.0233158, 45.7018953], [41.0326145, 45.6984835], [41.0302302, 45.694441], [41.0532558, 45.6931321], [41.1226429, 45.6746915], [40.9116305, 45.6939517]]]}	45.9864011,40.9013374	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
40	Новопокровский район	novopokrovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.5372676, 46.2726677], [40.5333762, 46.2729345], [40.5308525, 46.2733059], [40.528687, 46.2731483], [40.5267332, 46.2733734], [40.5248282, 46.2739023], [40.5213764, 46.2740374], [40.5186411, 46.2735084], [40.5162313, 46.273666], [40.5130798, 46.2739586], [40.5434339, 46.2745166], [40.5491937, 46.2767351], [40.5597666, 46.282517], [40.5652618, 46.2853476], [40.5693068, 46.2868595], [40.5724105, 46.2874186], [40.5770509, 46.2871092], [40.5801241, 46.2873061], [40.5848564, 46.2863988], [40.6349285, 46.2861568], [40.6481321, 46.2860689], [40.5298766, 46.1423089], [40.6613979, 46.2032495], [40.6632252, 46.1993711], [40.6734579, 46.1959983], [40.5298766, 46.1423089], [40.6731908, 46.1592363], [40.7467919, 46.0490389], [40.8306426, 45.9956321], [40.7467919, 46.0490389], [40.9551545, 45.8812691], [40.9171747, 45.9337555], [40.8306426, 45.9956321], [40.8492321, 45.7807397], [40.97808, 45.8517923], [40.8610657, 45.7301891], [40.8531066, 45.7522778], [40.8484288, 45.7518861], [40.8479682, 45.694229], [40.7718286, 45.6946815], [40.7439177, 45.6912506], [40.6406941, 45.6503912], [40.5392865, 45.7375556], [40.5495192, 45.7145098], [40.5645054, 45.6508802], [40.4897398, 45.9619041], [40.4883691, 45.7729699], [40.3471824, 45.9726236], [40.3492107, 45.9678653], [40.3626594, 45.9645461], [40.3740615, 45.9608202], [40.3879001, 45.9579748], [40.4208396, 45.9627848], [40.4327291, 45.9711843], [40.4453007, 45.9631235], [40.4603086, 45.9681362], [40.4689821, 45.9642074], [40.4874984, 45.9610234], [40.3219935, 45.9723689], [40.2367582, 45.9725216], [40.3619133, 46.0981775], [40.3487136, 46.0865601], [40.3442307, 46.0825045], [40.3363369, 46.083248], [40.2670469, 46.0894665], [40.3363369, 46.1584306], [40.3433536, 46.1529625], [40.3442307, 46.1491143], [40.3394554, 46.1471563], [40.3344853, 46.1445231], [40.3400402, 46.1403367], [40.3357522, 46.1341915], [40.3290278, 46.1309498], [40.3375063, 46.1276404], [40.3381885, 46.1208183], [40.3308795, 46.120413], [40.3619674, 46.1162923], [40.33699, 46.260385], [40.431404, 46.262766], [40.4224778, 46.2671397], [40.4225593, 46.2734423], [40.5097349, 46.273621], [40.5076182, 46.2746114], [40.5053225, 46.2748364], [40.5034826, 46.2736435], [40.5013334, 46.2732383], [40.5000634, 46.2731821], [40.4990539, 46.2741499], [40.4974133, 46.2739075], [40.4942345, 46.2733059], [40.4915643, 46.2739924], [40.4886987, 46.2736097], [40.4852306, 46.2739474], [40.4803949, 46.2738461], [40.4744194, 46.2738911], [40.4679718, 46.2738911], [40.464524, 46.2736072], [40.4623383, 46.2735328], [40.4591705, 46.2733095], [40.4571176, 46.2735544], [40.4548356, 46.2734967], [40.45321, 46.2730286], [40.4515427, 46.273115], [40.4501151, 46.2724955], [40.4475204, 46.2726324], [40.4436441, 46.2735976], [40.4423415, 46.2740297], [40.4395437, 46.2732631], [40.4362337, 46.2734733], [40.4326663, 46.2730014], [40.4299802, 46.2730587], [40.4259378, 46.2731251], [40.4225593, 46.2734423], [40.5372676, 46.2726677]]]}	45.968912,40.6050434	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
41	Павловский район	pavlovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.1945688, 46.2749027], [40.20057, 46.2763703], [40.1995937, 46.2794718], [40.206836, 46.2778189], [40.206528, 46.272766], [40.2767611, 46.2522858], [40.1870571, 46.2699396], [40.1965568, 46.2716008], [40.1951444, 46.2736905], [40.1939404, 46.2649674], [39.9913108, 46.2395165], [40.003098, 46.2339055], [40.022917, 46.2300028], [40.0362745, 46.2238707], [40.0443799, 46.2154566], [40.0703475, 46.2088976], [40.103933, 46.2102764], [39.9257443, 46.2295017], [39.9511888, 46.2307701], [39.9698196, 46.2301745], [39.7202664, 46.2397706], [39.7431894, 46.2403438], [39.7693898, 46.2412931], [39.7957792, 46.2373875], [39.8361921, 46.2337149], [39.6238814, 46.2151339], [39.5850726, 46.1923254], [39.5279915, 46.0975334], [39.5310114, 46.0961575], [39.5319197, 46.0956523], [39.5330289, 46.0946759], [39.5336943, 46.0941998], [39.5346354, 46.0939958], [39.5361858, 46.0940379], [39.5385278, 46.0938484], [39.5414629, 46.0939942], [39.5424296, 46.0937707], [39.5444499, 46.0937134], [39.5516672, 46.0935337], [39.5532015, 46.0963819], [39.5509645, 46.1000023], [39.55209, 46.1027936], [39.5551255, 46.1032922], [39.5565779, 46.1041503], [39.5571105, 46.1047039], [39.5574082, 46.1054459], [39.5580412, 46.1063739], [39.5575289, 46.1068648], [39.5578829, 46.1073836], [39.558304, 46.1079508], [39.5591489, 46.1084882], [39.5606027, 46.1089587], [39.5618741, 46.1083636], [39.5639072, 46.1081888], [39.5649506, 46.1082], [39.5658525, 46.1084842], [39.5673319, 46.1086216], [39.5677318, 46.1096386], [39.5679017, 46.1109562], [39.567208, 46.1121401], [39.5674345, 46.112578], [39.566578, 46.113373], [39.5668142, 46.1141673], [39.5721847, 46.115055], [39.5857047, 46.1193905], [39.5234075, 46.0886896], [39.5237079, 46.0910989], [39.524737, 46.0928809], [39.5243822, 46.0954823], [39.5270611, 46.0985589], [39.4830422, 46.0435931], [39.5087313, 45.9897411], [39.5095002, 45.9742293], [39.5101246, 45.8908753], [39.5064512, 45.8861807], [39.5129478, 45.8864303], [39.5178995, 45.8852033], [39.5189849, 45.8852118], [39.5202899, 45.8852118], [39.521647, 45.8859252], [39.5226555, 45.8874786], [39.5268074, 45.891595], [39.638473, 45.909087], [39.6000887, 45.9089475], [39.5985581, 45.8825678], [39.5879405, 45.8832774], [39.5770739, 45.8863773], [39.5727655, 45.8880896], [39.5684808, 45.8866657], [39.560642, 45.8835022], [39.5532481, 45.8847139], [39.5426951, 45.8853306], [39.5361681, 45.8904991], [39.5268074, 45.891595], [39.7121489, 45.8832558], [39.6980178, 45.8998389], [39.7931174, 45.8896407], [39.7567037, 45.8806191], [39.8647732, 45.9359596], [39.8152704, 45.8821513], [40.0410378, 45.9493688], [40.038236, 45.9828995], [40.1151323, 46.0629389], [40.0689341, 46.0602137], [40.3618699, 46.0836536], [40.3340961, 46.0893323], [40.3442307, 46.1491143], [40.3377987, 46.1380408], [40.3388707, 46.1227097], [40.1945688, 46.2749027]]]}	46.0803824,39.9225048	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
42	Кореновский район	korenovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.1425577, 45.4794352], [39.1432024, 45.446775], [39.1440982, 45.3948009], [39.1423594, 45.4929231], [39.1159932, 45.5458628], [39.1157941, 45.5647013], [39.1153025, 45.5916904], [39.1487176, 45.5899322], [39.1521582, 45.5865563], [39.1568071, 45.5840822], [39.1648504, 45.5874388], [39.1654442, 45.5930855], [39.1674543, 45.5998336], [39.1614307, 45.6027221], [39.1630345, 45.6105059], [39.1681252, 45.6155964], [39.1837298, 45.6179826], [39.1895206, 45.6179554], [39.1945079, 45.6219538], [39.19687, 45.6251807], [39.2020195, 45.621089], [39.2412724, 45.6397398], [39.2346144, 45.6404858], [39.2288354, 45.6410315], [39.2205505, 45.6367921], [39.2168211, 45.6332514], [39.2109704, 45.6314211], [39.210363, 45.6286376], [39.2066959, 45.6265267], [39.2064119, 45.6227155], [39.3580074, 45.6576908], [39.2960627, 45.6648479], [39.3450226, 45.7190546], [39.3909914, 45.6799722], [39.3960334, 45.6731344], [39.5238571, 45.8027297], [39.5093887, 45.7877337], [39.5002319, 45.7873976], [39.4941631, 45.7885341], [39.4755895, 45.7899813], [39.4680365, 45.7945676], [39.4588155, 45.7948063], [39.4558185, 45.788083], [39.4468375, 45.7842082], [39.4062158, 45.764367], [39.5363024, 45.8164088], [39.5380986, 45.7850868], [39.5434172, 45.7648315], [39.5329103, 45.7626533], [39.5223934, 45.7638913], [39.518919, 45.7668762], [39.5139229, 45.7719151], [39.5111862, 45.7754507], [39.5099861, 45.7706378], [39.5114046, 45.7634722], [39.516994, 45.7652141], [39.5179058, 45.7604421], [39.5179873, 45.7582722], [39.5179696, 45.756229], [39.518703, 45.7535851], [39.5180919, 45.7532155], [39.5222376, 45.7522275], [39.5233346, 45.7492018], [39.5234297, 45.747875], [39.5267436, 45.7463301], [39.5238301, 45.7348203], [39.527773, 45.7384399], [39.532217, 45.7423114], [39.5243767, 45.7313708], [39.5249445, 45.629773], [39.5895134, 45.6212546], [39.590202, 45.5202069], [39.6093816, 45.5224501], [39.6609372, 45.4865246], [39.6572249, 45.4819068], [39.6603783, 45.4732021], [39.6640108, 45.4684993], [39.6644643, 45.4524314], [39.6300861, 45.4414535], [39.6144619, 45.3754576], [39.6021125, 45.3820291], [39.5905116, 45.3780425], [39.5799085, 45.3714704], [39.5814678, 45.3646347], [39.5904492, 45.3602525], [39.5237694, 45.3608504], [39.5149541, 45.3326692], [39.5081412, 45.3149203], [39.4384288, 45.3325337], [39.265258, 45.3296322], [39.2864627, 45.3343013], [39.292429, 45.3386185], [39.2996357, 45.3400864], [39.3067776, 45.3411432], [39.323484, 45.3397047], [39.3372143, 45.329968], [39.1984468, 45.3634429], [39.2074988, 45.3669077], [39.2111027, 45.3644315], [39.2179323, 45.3638862], [39.2298277, 45.3656807], [39.2392396, 45.3669893], [39.2594733, 45.3676188], [39.1583204, 45.3848903], [39.1425577, 45.4794352]]]}	45.5610498,39.3911936	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
17	Туапсинский муниципальный округ	tuapsinskiy-munitsipalnyy-okrug	district	2	{"type": "Polygon", "coordinates": [[[38.6698558, 44.4901263], [38.6826624, 44.4673803], [38.6795933, 44.4454842], [38.6686592, 44.4240574], [38.650797, 44.3986482], [38.6302102, 44.3674876], [38.6132855, 44.3385346], [38.6171211, 44.3329811], [38.6287209, 44.3267877], [38.6392104, 44.3207933], [38.6582016, 44.3199921], [38.6681139, 44.3133165], [38.6934409, 44.3076776], [38.6986827, 44.3098236], [38.7051381, 44.3062838], [38.7087351, 44.3027004], [38.7264269, 44.2995983], [38.7410323, 44.3003205], [38.7512546, 44.2997117], [38.7543288, 44.2978687], [38.7560814, 44.296089], [38.7656253, 44.2915477], [38.7874972, 44.2823629], [38.7934546, 44.2797791], [38.7987502, 44.2756631], [38.8036734, 44.2718067], [38.8092497, 44.2664961], [38.8197668, 44.2527713], [38.8260307, 44.2394522], [38.8307691, 44.2395674], [38.8385982, 44.2353524], [38.8438719, 44.2256805], [38.8505907, 44.219595], [38.857557, 44.2096268], [38.8613278, 44.2048265], [38.8673197, 44.1967489], [38.8808164, 44.1941033], [38.8843974, 44.1877745], [38.8960701, 44.1860919], [38.9052415, 44.1859746], [38.9085881, 44.1870763], [38.9241443, 44.1837046], [38.9333002, 44.1804397], [38.9388061, 44.1762315], [38.9464778, 44.1724434], [38.9625592, 44.1673615], [38.9665619, 44.1688785], [38.9738382, 44.1692729], [38.9907534, 44.1631921], [38.9937482, 44.1617163], [38.9997542, 44.1603418], [39.0053073, 44.1548972], [39.0123264, 44.1503232], [39.0209396, 44.1396586], [39.029436, 44.127311], [39.0316862, 44.1163357], [39.032144, 44.108886], [39.033172, 44.100064], [39.0487076, 44.0968253], [39.0588356, 44.0969349], [39.0738579, 44.093778], [39.0783709, 44.0888496], [39.0793586, 44.0868306], [39.0863643, 44.0839837], [39.0916943, 44.0797342], [39.0968287, 44.0752132], [39.1024163, 44.0688396], [39.1142724, 44.0593309], [39.1216199, 44.0527845], [39.1285967, 44.0473138], [39.1370831, 44.0384478], [39.1438781, 44.0303986], [39.1505174, 44.0247878], [39.2419839, 44.0731263], [39.21911, 44.0565052], [39.1816664, 44.0491182], [39.2734623, 44.0643538], [39.3846148, 44.0967115], [39.3777466, 44.0595584], [39.3369984, 44.0561042], [39.2916584, 44.0632899], [39.478683, 44.095541], [39.440163, 44.1200404], [39.5696658, 44.1723483], [39.5820884, 44.1142396], [39.5700807, 44.2651389], [39.515635, 44.2982933], [39.5702078, 44.2826422], [39.468973, 44.3560309], [39.4869989, 44.3309624], [39.3451593, 44.3965269], [39.0636958, 44.4092979], [39.1094889, 44.449349], [39.2255326, 44.4369966], [38.9633276, 44.4040766], [39.015264, 44.4097835], [38.8904493, 44.49407], [38.9551446, 44.4614978], [38.9542791, 44.4239592], [38.7681463, 44.5047257], [38.8310119, 44.5066763], [38.6879102, 44.4943649], [38.6698558, 44.4901263]]]}	44.2686691,39.0958981	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
18	городской округ Сочи	gorodskoy-okrug-sochi	district	2	{"type": "Polygon", "coordinates": [[[39.8841882, 43.4938231], [39.8900169, 43.4796327], [39.8917222, 43.4746566], [39.8929211, 43.4711368], [39.8949319, 43.4660493], [39.898003, 43.4573437], [39.9009902, 43.4492033], [39.909343, 43.4326654], [39.9136069, 43.4260268], [39.9191459, 43.4200597], [39.9307644, 43.4253122], [39.9589638, 43.4199781], [40.0092354, 43.396184], [40.020719, 43.4320277], [40.0533208, 43.4886251], [40.1513927, 43.572399], [40.097797, 43.5654901], [40.088901, 43.5228853], [40.4174886, 43.5534468], [40.4061684, 43.554342], [40.3954355, 43.5559272], [40.3831295, 43.5561993], [40.3714136, 43.5580575], [40.3616289, 43.5618827], [40.3533248, 43.5641334], [40.3464423, 43.5631927], [40.3384761, 43.563939], [40.3280477, 43.5667415], [40.3190019, 43.5759343], [40.3102915, 43.5783817], [40.3029047, 43.5740679], [40.2942022, 43.5714649], [40.2775873, 43.5785103], [40.261641, 43.5854461], [40.2410638, 43.585633], [40.2266979, 43.5800762], [40.2146407, 43.5758597], [40.1906045, 43.57416], [40.4523292, 43.5493779], [40.5278215, 43.5211006], [40.6137766, 43.5481168], [40.4570695, 43.6654889], [40.561943, 43.6155907], [40.6192371, 43.5888645], [40.3764677, 43.7259544], [40.4526696, 43.6788268], [40.1494734, 43.857874], [40.1904789, 43.8519015], [40.2073798, 43.798714], [40.2616982, 43.7601459], [40.3468383, 43.7724085], [39.9457487, 43.9457321], [39.9998751, 43.9005048], [40.0491761, 43.8771061], [39.8592668, 43.9269232], [39.6098684, 44.0197459], [39.5593537, 44.052857], [39.442412, 44.1206159], [39.376781, 44.0607457], [39.2916584, 44.0632899], [39.2208695, 44.0590495], [39.1600152, 44.0337832], [39.1632937, 44.0159679], [39.189201, 44.000366], [39.2162834, 43.9887563], [39.2270959, 43.980385], [39.237478, 43.9776103], [39.2656993, 43.9559302], [39.2974493, 43.9398801], [39.316816, 43.9173662], [39.3575832, 43.8886606], [39.3777985, 43.8721152], [39.407932, 43.8465218], [39.4368314, 43.8183934], [39.4550111, 43.7979768], [39.4721738, 43.7812926], [39.5241348, 43.7459563], [39.5407217, 43.7324188], [39.5475455, 43.7283927], [39.5536195, 43.7231865], [39.5600496, 43.7187741], [39.5679145, 43.7144468], [39.5792073, 43.7055247], [39.5915857, 43.6911212], [39.6164912, 43.6644166], [39.6439909, 43.6540635], [39.66412, 43.6460187], [39.6862797, 43.6334498], [39.6992874, 43.620823], [39.709234, 43.5945491], [39.7145554, 43.5719248], [39.71806, 43.5825197], [39.7267495, 43.5724727], [39.7462858, 43.5634179], [39.7621006, 43.5561122], [39.7781905, 43.5476476], [39.7988951, 43.5395929], [39.8115027, 43.5348965], [39.8413881, 43.5209966], [39.8634297, 43.5112858], [39.8802699, 43.4975247], [39.8841882, 43.4938231]]]}	43.7611586,39.9055726	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
33	Успенский район	uspenskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[41.6539743, 44.986253], [41.616942, 44.8488984], [41.6245039, 44.8496241], [41.6267251, 44.851616], [41.6305218, 44.8506406], [41.6387808, 44.8755994], [41.5551773, 44.7513475], [41.5785486, 44.7578321], [41.5862941, 44.7723606], [41.5899034, 44.771046], [41.5934228, 44.768874], [41.6152512, 44.7999782], [41.611821, 44.8274741], [41.6118404, 44.8347012], [41.6148572, 44.8343245], [41.6162138, 44.8472172], [41.5171383, 44.7302074], [41.5598862, 44.7383883], [41.476111, 44.6475041], [41.4663017, 44.6506924], [41.4603001, 44.6509792], [41.4477758, 44.6571982], [41.4394793, 44.7108614], [41.4791764, 44.6387115], [41.3800686, 44.618815], [41.3685127, 44.6194195], [41.3637165, 44.6209368], [41.3575637, 44.6198678], [41.3466463, 44.622909], [41.3411483, 44.627829], [41.3327767, 44.6348678], [41.3273506, 44.6376478], [41.3194351, 44.641841], [41.3200862, 44.6473782], [41.314381, 44.6501576], [41.3109394, 44.6596418], [41.3101332, 44.6616928], [41.306719, 44.6660528], [41.296234, 44.674355], [41.2920381, 44.6756132], [41.296751, 44.6765172], [41.2973712, 44.6833517], [41.2939192, 44.6833995], [41.296658, 44.6865041], [41.291511, 44.6874079], [41.286457, 44.687452], [41.2897126, 44.6901192], [41.2904568, 44.6929627], [41.2848097, 44.6944486], [41.2810957, 44.6935949], [41.2769998, 44.698204], [41.2723775, 44.7001137], [41.2760673, 44.7018988], [41.2699182, 44.7040535], [41.2654706, 44.7092909], [41.264372, 44.7117675], [41.2680762, 44.7152944], [41.2624165, 44.7215486], [41.2522832, 44.725024], [41.2432128, 44.7315799], [41.2393829, 44.744052], [41.2311532, 44.7512113], [41.2267374, 44.7490114], [41.2209578, 44.7535839], [41.2187998, 44.7497822], [41.2154143, 44.7532717], [41.2134103, 44.7544319], [41.210747, 44.758565], [41.2173692, 44.764211], [41.212201, 44.7691034], [41.202697, 44.7733123], [41.2321368, 44.7976038], [41.2381873, 44.7932055], [41.2671734, 44.7965877], [41.2236138, 44.8296164], [41.2552313, 44.8580131], [41.2513299, 44.8702859], [41.2287825, 44.882761], [41.2344817, 44.8839244], [41.2395375, 44.8895658], [41.2092061, 44.9172605], [41.1992259, 44.9246118], [41.1785994, 44.924198], [41.1620791, 44.9269758], [41.1626426, 44.9281153], [41.1641125, 44.9335827], [41.1650989, 44.9426969], [41.1630099, 44.9487209], [41.1697974, 44.9516247], [41.1662626, 44.9544689], [41.166855, 44.9571238], [41.17119, 44.9553944], [41.1719148, 44.9581818], [41.1800068, 44.961247], [41.1807402, 44.9615254], [41.1935285, 44.9626258], [41.1888754, 44.967148], [41.1825266, 44.9667219], [41.1820235, 44.9688021], [41.180335, 44.970434], [41.1820469, 44.9720222], [41.1765429, 44.9737963], [41.1738233, 44.9813197], [41.1712626, 44.9823118], [41.167146, 44.9839672], [41.1676077, 44.9877697], [41.1756579, 44.9860708], [41.18228, 44.989782], [41.1896501, 44.9932297], [41.195334, 44.993609], [41.1973601, 44.9945575], [41.278387, 45.0488087], [41.3518141, 45.0337229], [41.4564792, 44.9882632], [41.4531478, 44.9914899], [41.44922, 44.9939204], [41.4447739, 44.9972893], [41.4444953, 45.0021546], [41.4420628, 45.0053105], [41.4410746, 45.0081494], [41.4387229, 45.0106207], [41.4367981, 45.0146439], [41.4331081, 45.0171944], [41.6539743, 44.986253]]]}	44.8334244,41.4054616	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
1	Россия	russia	country	\N	\N	60.0,90.0	\N	\N	2026-03-21 20:50:38.711698+00	https://images.unsplash.com/photo-1513326738677-b964603b136d?w=800&h=400&fit=crop
48	Краснодар	krasnodar	city	2	\N	45.0351532,38.9772396	1154885	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1578590strokes-8d1c3b6e8f3a?w=800&h=400&fit=crop
49	Славянск-на-Кубани	slavyansk-na-kubani	city	2	\N	45.2590875,38.1244609	61449	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
50	Темрюк	temryuk	city	2	\N	45.2823609,37.3658235	39164	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&h=400&fit=crop
51	Анапа	anapa	city	2	\N	44.894272,37.316887	82695	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&h=400&fit=crop
52	Приморско-Ахтарск	primorsko-ahtarsk	city	2	\N	46.0433467,38.1560033	30465	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
53	Ейск	eysk	city	2	\N	46.7112094,38.2747987	82534	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=800&h=400&fit=crop
54	Сочи	sochi	city	2	\N	43.5854823,39.723109	446599	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1596484552834-6a58f850e0a1?w=800&h=400&fit=crop
55	Геленджик	gelendzhik	city	2	\N	44.5609447,38.0766832	80296	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1506953823976-52e1fdc0149a?w=800&h=400&fit=crop
56	Кабардинка	kabardinka	city	2	\N	44.6515718,37.9395292	7550	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&h=400&fit=crop
57	Горячий Ключ	goryachiy-klyuch	city	2	\N	44.6342653,39.1363613	34585	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&h=400&fit=crop
58	Туапсе	tuapse	city	2	\N	44.0984747,39.0718875	60707	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1468413253725-0d5181091126?w=800&h=400&fit=crop
59	Новороссийск	novorossiysk	city	2	\N	44.7239578,37.7690711	261973	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&h=400&fit=crop
60	Армавир	armavir	city	2	\N	44.9993585,41.1294061	187215	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800&h=400&fit=crop
61	Тимашёвск	timashyovsk	city	2	\N	45.6129685,38.9357743	52641	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
62	Павловская	pavlovskaya	city	2	\N	46.1352,39.783	\N	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
63	Витязево	vityazevo	city	2	\N	44.9897066,37.2607195	7936	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
64	Джубга	dzhubga	city	2	\N	44.3170538,38.7043664	7024	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800&h=400&fit=crop
65	Дагомыс	dagomys	city	2	\N	43.6590048,39.6544373	17841	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&h=400&fit=crop
66	Усть-Лабинск	ust-labinsk	city	2	\N	45.2094926,39.6901178	42062	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
67	Васюринская	vasyurinskaya	city	2	\N	45.1183262,39.4200463	13339	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
68	Воронежская	voronezhskaya	city	2	\N	45.2120476,39.5670828	8562	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
69	Пластуновская	plastunovskaya	city	2	\N	45.2962422,39.2662799	10264	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
70	Платнировская	platnirovskaya	city	2	\N	45.391981,39.3903857	12004	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
71	Елизаветинская	elizavetinskaya	city	2	\N	45.0480573,38.7928963	24755	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
72	Новомышастовская	novomyshastovskaya	city	2	\N	45.1987319,38.5795212	10032	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
73	Динская	dinskaya	city	2	\N	45.2168713,39.2249757	34848	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
74	Белореченск	belorechensk	city	2	\N	44.7614149,39.8712943	52322	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
75	Выселки	vyselki	city	2	\N	45.5806221,39.6574237	19426	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
76	Афипский	afipskiy	city	2	\N	44.9040435,38.8426821	19956	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
77	Северская	severskaya	city	2	\N	44.853421,38.6781253	24867	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
78	Ильский	ilskiy	city	2	\N	44.8458544,38.5608255	24831	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
79	Крымск	krymsk	city	2	\N	44.9295889,37.9880177	54420	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&h=400&fit=crop
80	Курганинск	kurganinsk	city	2	\N	44.8851635,40.5894674	48194	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
81	Калининская	kalininskaya	city	2	\N	45.4856626,38.6598137	13391	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
82	Брюховецкая	bryuhovetskaya	city	2	\N	45.8006933,39.0006977	22024	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
83	Переясловская	pereyaslovskaya	city	2	\N	45.844673,39.021858	8424	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
84	Каневская	kanevskaya	city	2	\N	46.0845999,38.9721929	41721	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
85	Стародеревянковская	staroderevyankovskaya	city	2	\N	46.1277738,38.9713729	13482	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
86	Варениковская	varenikovskaya	city	2	\N	45.121292,37.638737	14881	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
87	Старотитаровская	starotitarovskaya	city	2	\N	45.2188185,37.1480059	12164	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
88	Тбилисская	tbilisskaya	city	2	\N	45.3635681,40.1898342	25317	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
89	Ладожская	ladozhskaya	city	2	\N	45.3076593,39.9268511	14828	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
90	Медвёдовская	medvyodovskaya	city	2	\N	45.4525812,39.0167858	16793	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
2	Краснодарский край	krasnodarskiy-kray	region	1	\N	44.77788090018502,40.06460274817761	5842238	Europe/Moscow	2026-03-21 20:50:38.711698+00	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=400&fit=crop
93	Абинск	abinsk	city	2	\N	44.8649528,38.1578189	36986	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
91	Холмская	holmskaya	city	2	\N	44.8432658,38.3950178	17585	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
92	Ахтырский	ahtyrskiy	city	2	\N	44.8559341,38.2941737	20863	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
94	Старощербиновская	staroscherbinovskaya	city	2	\N	46.6284506,38.6624971	18010	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
95	Новотитаровская	novotitarovskaya	city	2	\N	45.2360889,38.9712606	24754	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
96	Апшеронск	apsheronsk	city	2	\N	44.4674401,39.733173	40244	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&h=400&fit=crop
98	Роговская	rogovskaya	city	2	\N	45.734535,38.739555	7864	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
99	Новопокровская	novopokrovskaya	city	2	\N	45.953815,40.707203	19684	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
100	Белая Глина	belaya-glina	city	2	\N	46.0778137,40.8739482	17320	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
101	Архангельская	arhangelskaya	city	2	\N	45.6725524,40.2796117	8714	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
102	Нижнебаканская	nizhnebakanskaya	city	2	\N	44.8646355,37.8608578	8277	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
103	Анапская	anapskaya	city	2	\N	44.9002856,37.3832216	16107	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
104	Псебай	psebay	city	2	\N	44.1092655,40.7902989	10613	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1454496522488-7a8e488e8606?w=800&h=400&fit=crop
105	Лабинск	labinsk	city	2	\N	44.6347953,40.7242185	60971	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&h=400&fit=crop
106	Мостовской	mostovskoy	city	2	\N	44.4138041,40.7899446	25006	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&h=400&fit=crop
107	Архипо-Осиповка	arhipo-osipovka	city	2	\N	44.3703184,38.533611	7853	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800&h=400&fit=crop
108	Новомихайловский	novomihaylovskiy	city	2	\N	44.2533593,38.8447977	10792	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
109	Нефтегорск	neftegorsk	city	2	\N	44.3555651,39.7034985	5188	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
110	Крыловская	krylovskaya	city	2	\N	46.321865,39.962914	13621	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
111	Ленинградская	leningradskaya	city	2	\N	46.3212449,39.389554	36940	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
112	Новоминская	novominskaya	city	2	\N	46.317478,38.955532	11595	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
113	Кущёвская	kuschyovskaya	city	2	\N	46.5650084,39.6273712	30200	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
114	Староминская	starominskaya	city	2	\N	46.5359488,39.0625056	29809	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
115	Михайловская	mihaylovskaya	city	2	\N	44.990738,40.5999124	8245	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
116	Фастовецкая	fastovetskaya	city	2	\N	45.917324,40.154659	8573	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
117	Казанская	kazanskaya	city	2	\N	45.4074844,40.4406018	10991	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
118	Кавказская	kavkazskaya	city	2	\N	45.4393405,40.6697566	11164	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
119	Петровская	petrovskaya	city	2	\N	45.430317,37.956711	13554	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
120	Новокубанск	novokubansk	city	2	\N	45.1083184,41.0366896	35251	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
121	Гулькевичи	gulkevichi	city	2	\N	45.3565119,40.6962256	34347	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
122	Советская	sovetskaya	city	2	\N	44.7836633,41.1711179	9021	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
123	Тамань	taman	city	2	\N	45.2158646,36.7191326	10827	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
124	Марьянская	maryanskaya	city	2	\N	45.0991226,38.6367903	10643	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
125	Октябрьская	oktyabrskaya	city	2	\N	46.2837923,39.8102996	11252	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
126	Красносельский	krasnoselskiy	city	2	\N	45.3934779,40.598473	7676	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
127	Успенское	uspenskoe	city	2	\N	44.8346548,41.3850485	12409	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
128	Коноково	konokovo	city	2	\N	44.8617355,41.325343	7880	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
129	Черноморский	chernomorskiy	city	2	\N	44.849996,38.4944065	8512	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
130	Родниковская	rodnikovskaya	city	2	\N	44.7685255,40.6579706	8346	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
131	Отрадная	otradnaya	city	2	\N	44.3975687,41.5263169	23204	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
132	Кропоткин	kropotkin	city	2	\N	45.4344413,40.5750274	79795	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
133	Кореновск	korenovsk	city	2	\N	45.4635863,39.4487565	41828	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
134	Старокорсунская	starokorsunskaya	city	2	\N	45.0506551,39.3130266	12238	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
135	Хадыженск	hadyzhensk	city	2	\N	44.4231032,39.5369484	22430	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
136	Гирей	girey	city	2	\N	45.4024641,40.6581862	6441	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
137	Владимирская	vladimirskaya	city	2	\N	44.5446631,40.8043345	7217	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
138	Старомышастовская	staromyshastovskaya	city	2	\N	45.3419471,39.0729692	10610	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
139	Гостагаевская	gostagaevskaya	city	2	\N	45.024044,37.502266	9772	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
140	Нововеличковская	novovelichkovskaya	city	2	\N	45.2787805,38.8377083	9169	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
141	Ивановская	ivanovskaya	city	2	\N	45.2672191,38.4653294	9473	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
142	Старая Станица	staraya-stanitsa	city	2	\N	45.0143064,41.1490284	7612	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
143	Красная Поляна	krasnaya-polyana	city	2	\N	43.6779574,40.2069574	9165	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&h=400&fit=crop
144	Полтавская	poltavskaya	city	2	\N	45.366794,38.2115057	26490	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=800&h=400&fit=crop
145	Сириус	sirius	city	2	\N	43.4062071,39.9545377	\N	\N	2026-03-21 20:52:49.875179+00	https://images.unsplash.com/photo-1596484552834-6a58f850e0a1?w=800&h=400&fit=crop
43	Тбилисский район	tbilisskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.0664409, 45.3418864], [40.0535501, 45.3586965], [40.1178605, 45.2772291], [40.115619, 45.2716742], [40.1088947, 45.2698224], [40.1047369, 45.2697604], [40.1029905, 45.2695848], [40.0987493, 45.2669511], [40.0976516, 45.2644928], [40.0943584, 45.2619642], [40.0885704, 45.2577495], [40.0846285, 45.2560285], [40.0788904, 45.2555367], [40.0739008, 45.2557826], [40.0697095, 45.2572227], [40.0692266, 45.2607321], [40.066433, 45.2624937], [40.0610382, 45.2609741], [40.066915, 45.3077257], [40.0606156, 45.3212785], [40.0620501, 45.3286895], [40.0664409, 45.3418864], [40.1181528, 45.2614544], [40.0919833, 45.2036954], [40.1064431, 45.190914], [40.2460165, 45.1739311], [40.2170921, 45.1820506], [40.1823204, 45.1842628], [40.1310565, 45.1920531], [40.2561518, 45.208491], [40.2528773, 45.198768], [40.2569368, 45.1982051], [40.2610062, 45.1971388], [40.2789951, 45.2205188], [40.3602044, 45.1917914], [40.3301391, 45.1926147], [40.3074766, 45.1973406], [40.2789951, 45.2205188], [40.4021301, 45.2543752], [40.4019742, 45.2442758], [40.3956157, 45.1982146], [40.384311, 45.1984206], [40.3732987, 45.2025407], [40.3636507, 45.2016481], [40.3602044, 45.1917914], [40.3896187, 45.3065334], [40.3331926, 45.3072873], [40.3374385, 45.3360416], [40.334557, 45.3474376], [40.3090297, 45.3373294], [40.2817578, 45.3319982], [40.2733342, 45.3361217], [40.2727731, 45.3496654], [40.2869602, 45.3453688], [40.2928152, 45.3457968], [40.2943643, 45.3487092], [40.2906633, 45.3503418], [40.2822207, 45.3494109], [40.2829062, 45.3547657], [40.2935287, 45.3658588], [40.3171127, 45.3710622], [40.3027606, 45.4609989], [40.3088208, 45.3982822], [40.3134015, 45.3733284], [40.3088105, 45.4716283], [40.3008894, 45.4727655], [40.2962116, 45.4610426], [40.3446114, 45.4870221], [40.3419918, 45.4913071], [40.3388109, 45.4941053], [40.3331351, 45.4910447], [40.3205362, 45.4921815], [40.3120538, 45.4951546], [40.2197359, 45.5330328], [40.3666206, 45.5149975], [40.2192944, 45.5951958], [40.1219753, 45.5954385], [40.1101456, 45.5775997], [40.0913366, 45.5744251], [40.0849124, 45.5743378], [40.0748707, 45.5736829], [40.0683218, 45.5730281], [40.0576564, 45.573159], [40.053041, 45.5735956], [40.0473652, 45.5726788], [40.0439348, 45.5730281], [40.0342674, 45.5737266], [40.0156185, 45.576608], [40.0110654, 45.5790527], [40.0105665, 45.5636405], [40.0017722, 45.568138], [39.9992774, 45.5703648], [40.0021464, 45.5739449], [40.0044541, 45.5783543], [40.0067832, 45.5606305], [40.0004933, 45.5575963], [39.9995727, 45.5267609], [39.9100707, 45.5266516], [39.9745078, 45.460087], [40.0532119, 45.3986182], [40.0462683, 45.4142906], [40.0445531, 45.4239219], [40.037039, 45.4514445], [40.0289931, 45.4583572], [40.0221947, 45.4572635], [40.0181406, 45.455601], [40.0149597, 45.4548134], [40.0664409, 45.3418864]]]}	45.3846998,40.1606622	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
44	Тихорецкий район	tihoretskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.5645054, 45.6508802], [40.5139991, 45.6206584], [40.4998831, 45.6207386], [40.4739845, 45.6208831], [40.4733685, 45.5938708], [40.4466903, 45.5924217], [40.4434012, 45.5902053], [40.4374078, 45.590069], [40.4060776, 45.587065], [40.3770556, 45.5670707], [40.3288157, 45.6141264], [40.2188141, 45.6140412], [40.2192944, 45.5951958], [40.1219753, 45.5954385], [40.1099507, 45.5954685], [40.0910871, 45.5775248], [40.0508934, 45.6219407], [40.0376084, 45.5899134], [40.0419744, 45.5910482], [40.0506439, 45.5901753], [40.0565692, 45.5930122], [40.0597501, 45.5955435], [40.0654258, 45.5864216], [40.078114, 45.5775685], [40.1661943, 45.6577223], [40.0936664, 45.6598261], [40.0848721, 45.6580824], [40.1662556, 45.7177426], [40.1666873, 45.7389114], [40.1017505, 45.7387458], [40.0083711, 45.8212937], [40.0094938, 45.8104075], [40.0096692, 45.7953225], [40.0509732, 45.7947584], [40.1017505, 45.7387458], [39.9899081, 45.8048429], [39.9980928, 45.81811], [39.8152704, 45.8821513], [39.8215213, 45.8799891], [39.8287883, 45.8774753], [39.835879, 45.8750224], [39.8431374, 45.8725113], [39.847806, 45.8708961], [39.8499977, 45.8701379], [39.8577261, 45.867464], [39.8615265, 45.8661491], [39.8647884, 45.8650205], [39.8706319, 45.859518], [39.858172, 45.842037], [39.8562694, 45.839381], [39.8438462, 45.822039], [39.8880516, 45.8065437], [39.9652822, 45.7797098], [39.8986327, 45.9552974], [39.8704015, 45.9318786], [39.8709205, 45.9348491], [39.8647732, 45.9359596], [39.8568421, 45.9378907], [39.8438487, 45.9224959], [39.8254885, 45.8965119], [39.8251935, 45.8960973], [39.8152704, 45.8821513], [39.9819561, 45.9489453], [39.9390762, 45.9331072], [40.0512705, 45.9823917], [40.0472505, 45.9486912], [40.0410378, 45.9493688], [40.0316578, 45.9542811], [40.0225215, 45.9552127], [40.0159433, 45.9571606], [40.0351906, 46.0493929], [40.038236, 45.9828995], [40.0432305, 45.9826456], [40.047616, 45.9822224], [40.1934613, 46.089727], [40.1221978, 46.0720669], [40.1151323, 46.0629389], [40.1157584, 46.0584033], [40.1139044, 46.0575696], [40.1041395, 46.0576778], [40.0837959, 46.0591994], [40.0689341, 46.0602137], [40.0630869, 46.0441508], [40.0538287, 46.0464337], [40.0351906, 46.0493929], [40.1934613, 46.089727], [40.232441, 45.990784], [40.2325213, 45.9725177], [40.2367582, 45.9725216], [40.3219935, 45.9723689], [40.3476392, 45.9714594], [40.3492107, 45.9678653], [40.3592485, 45.9652912], [40.3668499, 45.9644106], [40.3740615, 45.9608202], [40.3799088, 45.9573651], [40.4112891, 45.9570263], [40.4208396, 45.9627848], [40.4296105, 45.9687458], [40.4360425, 45.9708456], [40.4453007, 45.9631235], [40.4579697, 45.9688136], [40.462745, 45.9684072], [40.4689821, 45.9642074], [40.4833079, 45.9607525], [40.4897398, 45.9619041], [40.4891305, 45.9061048], [40.4883691, 45.7729699], [40.4881229, 45.7378957], [40.5392865, 45.7375556], [40.5434283, 45.7132339], [40.5579246, 45.7150201], [40.5645054, 45.6508802]]]}	45.8283988,40.1901302	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
45	Выселковский район	vyselkovskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[39.8949261, 45.4329475], [39.8591667, 45.4330156], [40.0090564, 45.4538358], [39.9947111, 45.4511668], [39.9770602, 45.4518669], [39.9774967, 45.4475789], [39.9720196, 45.4380391], [39.9221971, 45.4329517], [39.9739086, 45.4869798], [39.9268057, 45.526672], [40.0004933, 45.5575963], [40.0034562, 45.5675704], [40.0007743, 45.5714126], [40.0044541, 45.5783543], [40.0873449, 45.5738576], [40.0726254, 45.5735956], [40.0576564, 45.573159], [40.0493611, 45.5726788], [40.0416895, 45.5728971], [40.0156185, 45.576608], [40.0046413, 45.5795766], [40.0399162, 45.5900444], [40.0565692, 45.5930122], [40.0780247, 45.586378], [40.0936664, 45.6598261], [40.1661943, 45.6577223], [40.0083711, 45.8212937], [40.0116183, 45.7945751], [39.9899081, 45.8048429], [39.8209611, 45.8801829], [39.835879, 45.8750224], [39.8494293, 45.8703345], [39.8615265, 45.8661491], [39.8584065, 45.8423661], [39.8438462, 45.822039], [39.9673849, 45.7789791], [39.7921174, 45.8899787], [39.7682149, 45.8883728], [39.7500523, 45.8827421], [39.734924, 45.8828354], [39.7157971, 45.8833339], [39.7000916, 45.8833907], [39.6887609, 45.8867659], [39.7046282, 45.9091848], [39.6799764, 45.9092043], [39.6520816, 45.9092034], [39.6326315, 45.9090575], [39.612765, 45.9089903], [39.6001159, 45.9064052], [39.6003666, 45.8829455], [39.5965903, 45.8836617], [39.5915929, 45.88446], [39.5867655, 45.8832675], [39.5837784, 45.8841446], [39.5769465, 45.886555], [39.5744442, 45.8874379], [39.5718285, 45.8882304], [39.5694728, 45.887331], [39.567524, 45.8853045], [39.5637156, 45.8837782], [39.5579278, 45.8821489], [39.5562355, 45.8828216], [39.5510978, 45.8858758], [39.5461744, 45.8862951], [39.5415147, 45.8854736], [39.5367168, 45.8874015], [39.5341263, 45.8914345], [39.5291081, 45.8921354], [39.5269354, 45.8901897], [39.5270446, 45.8885336], [39.5269573, 45.8858978], [39.5272341, 45.8834041], [39.5231027, 45.8818202], [39.5233806, 45.8423905], [39.5235957, 45.8162504], [39.5365019, 45.7850868], [39.5425893, 45.7791364], [39.5351527, 45.7625595], [39.5229888, 45.7634759], [39.5193128, 45.7665635], [39.5145205, 45.7709299], [39.5117624, 45.7757722], [39.5098993, 45.7712306], [39.5106748, 45.7633248], [39.5160336, 45.7658305], [39.518024, 45.7614027], [39.517512, 45.7585186], [39.5183092, 45.7567218], [39.5194237, 45.7538975], [39.5173313, 45.7531397], [39.5209507, 45.7525492], [39.5235248, 45.7504244], [39.5234976, 45.7474674], [39.5243611, 45.7482981], [39.5244532, 45.7331057], [39.5264856, 45.7380554], [39.5323009, 45.7412622], [39.5301255, 45.7449653], [39.5247775, 45.6697326], [39.5817117, 45.6212537], [39.5901162, 45.5233004], [39.6057237, 45.522465], [39.6670445, 45.4865805], [39.6571051, 45.4825505], [39.6579434, 45.4762251], [39.6613763, 45.4687512], [39.6645042, 45.4534955], [39.7520376, 45.4416685], [39.7131276, 45.4404735], [39.6985962, 45.4415109], [39.7561829, 45.4416888], [39.8949261, 45.4329475]]]}	45.6643217,39.8382777	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
46	Усть-Лабинский район	ust-labinskiy-rayon	district	2	{"type": "Polygon", "coordinates": [[[40.009744, 45.0910832], [39.9944946, 45.0953068], [39.9878292, 45.087383], [39.9764942, 45.0913723], [39.9714494, 45.0822217], [39.9647341, 45.0852953], [39.9567134, 45.0833264], [39.9484271, 45.0874378], [39.9532082, 45.0913675], [39.9442087, 45.0948246], [40.0505751, 45.1005549], [40.0485855, 45.094993], [40.0429772, 45.1004687], [40.0385998, 45.1017405], [40.0227853, 45.0924891], [40.0133048, 45.0943512], [40.0868795, 45.1074876], [40.0907895, 45.1033134], [40.0859596, 45.0993142], [40.0790076, 45.1098863], [40.0755427, 45.1061182], [40.0691645, 45.0965121], [40.0590185, 45.0991936], [40.1030982, 45.1318394], [40.1254264, 45.1842956], [40.1213688, 45.2456752], [40.1178605, 45.2772291], [40.1088947, 45.2698224], [40.1029905, 45.2695848], [40.0976516, 45.2644928], [40.0885704, 45.2577495], [40.0788904, 45.2555367], [40.0697095, 45.2572227], [40.066433, 45.2624937], [40.066915, 45.3077257], [40.0620501, 45.3286895], [40.0662738, 45.359836], [40.0462683, 45.4142906], [40.037039, 45.4514445], [40.0221947, 45.4572635], [40.0149597, 45.4548134], [39.9999502, 45.4516481], [39.9791808, 45.4517794], [39.9774967, 45.4475789], [39.9720196, 45.436945], [39.8949261, 45.4329475], [39.8318121, 45.4328923], [39.7823024, 45.4418166], [39.7520376, 45.4416685], [39.7089488, 45.4415238], [39.6670848, 45.4414224], [39.6152727, 45.3766843], [39.6021125, 45.3820291], [39.5866446, 45.3755014], [39.5795299, 45.3689495], [39.5887028, 45.3625313], [39.5250685, 45.3608504], [39.5149541, 45.3326692], [39.5076314, 45.3149062], [39.4261292, 45.3306743], [39.4171981, 45.307025], [39.3660616, 45.278231], [39.38516, 45.2442411], [39.5030521, 45.2451318], [39.5056939, 45.161217], [39.5456117, 45.1885878], [39.5402576, 45.1625493], [39.5226348, 45.1621617], [39.6054128, 45.212785], [39.5778976, 45.2003696], [39.5544088, 45.1914304], [39.6860997, 45.1945456], [39.6395697, 45.2122955], [39.6066691, 45.2130478], [39.6805895, 45.1688805], [39.686322, 45.1803466], [39.6774001, 45.1870539], [39.6903414, 45.1863385], [39.8290199, 45.1212707], [39.8250345, 45.1165407], [39.8202545, 45.1194215], [39.8135192, 45.1189031], [39.8090478, 45.1202362], [39.8028952, 45.129017], [39.7938386, 45.130024], [39.7864532, 45.1281493], [39.7793269, 45.1242839], [39.780904, 45.1332455], [39.7643596, 45.1371756], [39.7478185, 45.1322449], [39.7388536, 45.1390179], [39.7345714, 45.143889], [39.7259142, 45.152039], [39.7167246, 45.1474721], [39.7114831, 45.1449929], [39.7130223, 45.1524743], [39.7037329, 45.1477156], [39.7004309, 45.1522263], [39.6915561, 45.1539529], [39.6883113, 45.1607585], [39.8419127, 45.117768], [39.8312926, 45.1131728], [39.8930599, 45.0861811], [39.9004422, 45.0952639], [39.8812627, 45.1045889], [39.8722658, 45.1084831], [39.8613251, 45.1123125], [39.8518059, 45.1180278], [39.8483937, 45.1079547], [39.8434226, 45.1142873], [39.9345098, 45.0925986], [39.9270871, 45.0944928], [39.9074272, 45.0937598], [39.9008423, 45.0870896], [40.009744, 45.0910832]]]}	45.2697602,39.7456249	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
47	городской округ Сириус	gorodskoy-okrug-sirius	district	2	{"type": "Polygon", "coordinates": [[[39.9395964, 43.4068191], [39.9363777, 43.4056127], [39.9360699, 43.4055288], [39.9327096, 43.4091089], [39.9306518, 43.4105397], [39.9250414, 43.4164623], [39.9246103, 43.4161818], [39.9243309, 43.4157698], [39.9243044, 43.4155411], [39.9241596, 43.4152101], [39.9246534, 43.4142582], [39.9253665, 43.4138189], [39.9260285, 43.4134129], [39.9271279, 43.4127665], [39.9275306, 43.4126426], [39.9281403, 43.4121709], [39.9253839, 43.4170033], [39.9266553, 43.4187723], [39.9278891, 43.4208257], [39.9283236, 43.4215777], [39.9298149, 43.424118], [39.9304211, 43.4250745], [39.9320036, 43.4260251], [39.9336076, 43.4269212], [39.9346429, 43.4278464], [39.9361022, 43.4287523], [39.9569505, 43.4200522], [39.9561078, 43.4198132], [39.9553381, 43.4199007], [39.9531086, 43.4195418], [39.9505283, 43.4181819], [39.9481518, 43.4178877], [39.9454335, 43.4184357], [39.9441714, 43.4189963], [39.9435786, 43.4196851], [39.9442324, 43.4199835], [39.9436397, 43.4208102], [39.9410225, 43.4240965], [39.9361022, 43.4287523], [39.9656372, 43.4188132], [39.9589638, 43.4199781], [40.0068278, 43.3954437], [40.0058515, 43.3959601], [40.0033544, 43.3994428], [40.0010852, 43.403888], [39.9998729, 43.4056125], [39.9986578, 43.4062692], [39.9973436, 43.4064076], [39.994782, 43.4062868], [39.9905656, 43.406731], [39.988841, 43.407528], [39.9861427, 43.407719], [39.9840961, 43.4085997], [39.9818618, 43.410143], [39.9792521, 43.4115576], [39.9761962, 43.4130394], [39.9708889, 43.4165454], [39.9683811, 43.41818], [40.0085526, 43.3855385], [40.0072398, 43.3881328], [40.0068045, 43.3897509], [40.0069308, 43.3908928], [40.0083648, 43.3934116], [40.008637, 43.3943486], [40.0081741, 43.3856368], [39.9437309, 43.4045182], [39.9445197, 43.4035787], [39.9450212, 43.4028869], [39.9458888, 43.4017916], [39.9465742, 43.400598], [39.9476354, 43.3997962], [39.9485263, 43.3992242], [39.9498083, 43.3988856], [39.9505385, 43.3986876], [39.9516855, 43.398425], [39.9532591, 43.3983831], [39.9542762, 43.3984952], [39.955973, 43.3988933], [39.956482, 43.3989369], [39.957182, 43.3990232], [39.9575865, 43.3991917], [39.9579703, 43.3992173], [39.9593602, 43.3990394], [39.9608149, 43.3984925], [39.9624309, 43.3977222], [39.9645396, 43.3974021], [39.9670261, 43.397021], [39.9686519, 43.3966571], [39.9697794, 43.3961368], [39.9713155, 43.3954366], [39.9727123, 43.3945614], [39.974141, 43.3935486], [39.9764406, 43.3920926], [39.9779279, 43.391267], [39.9791979, 43.390484], [39.9809199, 43.3895075], [39.9820625, 43.3890553], [39.9842968, 43.388299], [39.9861603, 43.3875428], [39.9882276, 43.3866691], [39.9901199, 43.3858605], [39.9917319, 43.3851139], [39.994103, 43.3847084], [39.9961618, 43.3849837], [39.997376, 43.3853347], [39.9991648, 43.3859499], [40.0013646, 43.3863478], [40.0035068, 43.3863536], [40.0053468, 43.3861139], [40.0072431, 43.385839], [40.007506, 43.3858702], [40.0080084, 43.3856914], [39.9415501, 43.4060879], [39.9426197, 43.4054562], [39.9437309, 43.4045182], [39.9395964, 43.4068191]]]}	43.4067304,39.9664535	\N	\N	2026-03-21 20:52:33.744698+00	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&h=400&fit=crop
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
524	2
524	1
525	7
526	5
526	11
527	4
527	3
528	2
528	1
529	7
529	4
530	4
530	11
531	7
531	4
532	1
533	5
533	12
\.


--
-- Data for Name: post_media; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.post_media (id, post_id, url, alt, "position", created_at) FROM stdin;
1489	524	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800&h=600&fit=crop	Абрау-Дюрсо виноградники	0	2026-03-22 00:49:46.953776+00
1490	524	https://images.unsplash.com/photo-1516594915697-87eb3b1c14ea?w=800&h=600&fit=crop	Дегустация вин	1	2026-03-22 00:49:46.953776+00
1491	524	https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800&h=600&fit=crop	Озеро Абрау	2	2026-03-22 00:49:46.953776+00
1492	525	https://images.unsplash.com/photo-1540979388789-6cee28a1cdc9?w=800&h=600&fit=crop	Подвесной мост	0	2026-03-22 00:49:46.953776+00
1493	525	https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800&h=600&fit=crop	Ущелье	1	2026-03-22 00:49:46.953776+00
1494	525	https://images.unsplash.com/photo-1551632811-561732d1e306?w=800&h=600&fit=crop	Горы Сочи	2	2026-03-22 00:49:46.953776+00
1495	526	https://images.unsplash.com/photo-1588714477688-cf28a50e94f7?w=800&h=600&fit=crop	Парк Галицкого	0	2026-03-22 00:49:46.953776+00
1496	526	https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=800&h=600&fit=crop	Террасы парка	1	2026-03-22 00:49:46.953776+00
1497	526	https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800&h=600&fit=crop	Вечерняя подсветка	2	2026-03-22 00:49:46.953776+00
1498	527	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800&h=600&fit=crop	Водопад	0	2026-03-22 00:49:46.953776+00
1499	527	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800&h=600&fit=crop	Каскад	1	2026-03-22 00:49:46.953776+00
1500	527	https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=800&h=600&fit=crop	Тропа к водопаду	2	2026-03-22 00:49:46.953776+00
1501	528	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800&h=600&fit=crop	Виноградники	0	2026-03-22 00:49:46.953776+00
1502	528	https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800&h=600&fit=crop	Бокал вина	1	2026-03-22 00:49:46.953776+00
1503	528	https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?w=800&h=600&fit=crop	Сыроварня	2	2026-03-22 00:49:46.953776+00
1504	529	https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&h=600&fit=crop	Горы зимой	0	2026-03-22 00:49:46.953776+00
1505	529	https://images.unsplash.com/photo-1486911278844-a81c5267e227?w=800&h=600&fit=crop	Горнолыжный склон	1	2026-03-22 00:49:46.953776+00
1506	529	https://images.unsplash.com/photo-1548587143-53e00bffb425?w=800&h=600&fit=crop	Набережная	2	2026-03-22 00:49:46.953776+00
1507	530	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800&h=600&fit=crop	Кипарисы в воде	0	2026-03-22 00:49:46.953776+00
1508	530	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&h=600&fit=crop	Рассвет на озере	1	2026-03-22 00:49:46.953776+00
1509	530	https://images.unsplash.com/photo-1518173946687-a9e7e1e3eb3c?w=800&h=600&fit=crop	Отражение	2	2026-03-22 00:49:46.953776+00
1510	531	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&h=600&fit=crop	Ущелье	0	2026-03-22 00:49:46.953776+00
1511	531	https://images.unsplash.com/photo-1454496522488-7a8e488e8606?w=800&h=600&fit=crop	Скалы	1	2026-03-22 00:49:46.953776+00
1512	531	https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&h=600&fit=crop	Горная река	2	2026-03-22 00:49:46.953776+00
1513	532	https://images.unsplash.com/photo-1500595046743-cd271d694d30?w=800&h=600&fit=crop	Ферма	0	2026-03-22 00:49:46.953776+00
1514	532	https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=800&h=600&fit=crop	Козий сыр	1	2026-03-22 00:49:46.953776+00
1515	532	https://images.unsplash.com/photo-1550583724-b2692b85b150?w=800&h=600&fit=crop	Мастер-класс	2	2026-03-22 00:49:46.953776+00
1516	533	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800&h=600&fit=crop	Архитектура парка	0	2026-03-22 00:49:46.953776+00
1517	533	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800&h=600&fit=crop	Японский сад	1	2026-03-22 00:49:46.953776+00
1518	533	https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&h=600&fit=crop	Замок	2	2026-03-22 00:49:46.953776+00
1519	534	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Агурские водопады	0	2026-03-22 04:45:47.859648+00
1520	534	https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800	Агурские водопады	1	2026-03-22 04:45:47.859648+00
1521	535	https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=800	Озеро Рица	0	2026-03-22 04:45:47.859648+00
1522	535	https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800	Озеро Рица	1	2026-03-22 04:45:47.859648+00
1523	536	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Набережная Геленджика	0	2026-03-22 04:45:47.859648+00
1524	536	https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800	Набережная Геленджика	1	2026-03-22 04:45:47.859648+00
1525	537	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Скала Парус	0	2026-03-22 04:45:47.859648+00
1526	537	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Скала Парус	1	2026-03-22 04:45:47.859648+00
1527	538	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Дендрарий Сочи	0	2026-03-22 04:45:47.859648+00
1528	538	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Дендрарий Сочи	1	2026-03-22 04:45:47.859648+00
1529	539	https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800	Олимпийский парк	0	2026-03-22 04:45:47.859648+00
1530	539	https://images.unsplash.com/photo-1596484552834-6a58f850e0a1?w=800	Олимпийский парк	1	2026-03-22 04:45:47.859648+00
1531	540	https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800	Мыс Тарханкут	0	2026-03-22 04:45:47.859648+00
1532	540	https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=800	Мыс Тарханкут	1	2026-03-22 04:45:47.859648+00
1533	541	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Свято-Троицкий собор Краснодара	0	2026-03-22 04:45:47.859648+00
1534	541	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Свято-Троицкий собор Краснодара	1	2026-03-22 04:45:47.859648+00
1535	542	https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800	Грязевой вулкан Шуго	0	2026-03-22 04:45:47.859648+00
1536	542	https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800	Грязевой вулкан Шуго	1	2026-03-22 04:45:47.859648+00
1537	543	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Большой Утриш	0	2026-03-22 04:45:47.859648+00
1538	543	https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800	Большой Утриш	1	2026-03-22 04:45:47.859648+00
1539	544	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня Мысхако	0	2026-03-22 04:45:47.859648+00
1540	544	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня Мысхако	1	2026-03-22 04:45:47.859648+00
1541	545	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Тюльпановое дерево	0	2026-03-22 04:45:47.859648+00
1542	545	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Тюльпановое дерево	1	2026-03-22 04:45:47.859648+00
1543	546	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Каньон Белые скалы	0	2026-03-22 04:45:47.859648+00
1544	546	https://images.unsplash.com/photo-1454496522488-7a8e488e8606?w=800	Каньон Белые скалы	1	2026-03-22 04:45:47.859648+00
1545	547	https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=800	Рынок Краснодара	0	2026-03-22 04:45:47.859648+00
1546	547	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Рынок Краснодара	1	2026-03-22 04:45:47.859648+00
1547	548	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Маяк Анапы	0	2026-03-22 04:45:47.859648+00
1548	548	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Маяк Анапы	1	2026-03-22 04:45:47.859648+00
1549	549	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка городской округ Краснодар	0	2026-03-22 04:50:49.535545+00
1550	549	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка городской округ Краснодар	1	2026-03-22 04:50:49.535545+00
1551	550	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Динской район	0	2026-03-22 04:50:49.535545+00
1552	550	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Динской район	1	2026-03-22 04:50:49.535545+00
1553	551	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе Красноармейский район	0	2026-03-22 04:50:49.535545+00
1554	551	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе Красноармейский район	1	2026-03-22 04:50:49.535545+00
1555	552	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Северский район	0	2026-03-22 04:50:49.535545+00
1556	552	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Северский район	1	2026-03-22 04:50:49.535545+00
1557	553	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Абинский район	0	2026-03-22 04:50:49.535545+00
1558	553	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Абинский район	1	2026-03-22 04:50:49.535545+00
1559	554	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Славянский район	0	2026-03-22 04:50:49.535545+00
1560	554	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Славянский район	1	2026-03-22 04:50:49.535545+00
1561	555	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка Крымский район	0	2026-03-22 04:50:49.535545+00
1562	555	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка Крымский район	1	2026-03-22 04:50:49.535545+00
1563	556	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Темрюкский район	0	2026-03-22 04:50:49.535545+00
1564	556	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Темрюкский район	1	2026-03-22 04:50:49.535545+00
1565	557	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка муниципальный округ Анапа	0	2026-03-22 04:50:49.535545+00
1566	557	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка муниципальный округ Анапа	1	2026-03-22 04:50:49.535545+00
1567	558	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей городской округ Новороссийск	0	2026-03-22 04:50:49.535545+00
1568	558	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей городской округ Новороссийск	1	2026-03-22 04:50:49.535545+00
1569	559	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж городской округ Геленджик	0	2026-03-22 04:50:49.535545+00
1570	559	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж городской округ Геленджик	1	2026-03-22 04:50:49.535545+00
1571	560	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка муниципальный округ Горячий Ключ	0	2026-03-22 04:50:49.535545+00
1572	560	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка муниципальный округ Горячий Ключ	1	2026-03-22 04:50:49.535545+00
1573	561	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Белореченский район	0	2026-03-22 04:50:49.535545+00
1574	561	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Белореченский район	1	2026-03-22 04:50:49.535545+00
1575	562	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Апшеронский район	0	2026-03-22 04:50:49.535545+00
1576	562	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Апшеронский район	1	2026-03-22 04:50:49.535545+00
1577	563	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж Мостовский район	0	2026-03-22 04:50:49.535545+00
1578	563	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж Мостовский район	1	2026-03-22 04:50:49.535545+00
1579	564	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Ейский район	0	2026-03-22 04:50:49.535545+00
1580	564	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Ейский район	1	2026-03-22 04:50:49.535545+00
1581	565	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе Щербиновский район	0	2026-03-22 04:50:49.535545+00
1582	565	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе Щербиновский район	1	2026-03-22 04:50:49.535545+00
1583	566	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж Староминский район	0	2026-03-22 04:50:49.535545+00
1584	566	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж Староминский район	1	2026-03-22 04:50:49.535545+00
1585	567	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Приморско-Ахтарский муниципальный округ	0	2026-03-22 04:50:49.535545+00
1586	567	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Приморско-Ахтарский муниципальный округ	1	2026-03-22 04:50:49.535545+00
1587	568	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Калининский район	0	2026-03-22 04:50:49.535545+00
1588	568	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Калининский район	1	2026-03-22 04:50:49.535545+00
1589	569	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Тимашёвский район	0	2026-03-22 04:50:49.535545+00
1590	569	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Тимашёвский район	1	2026-03-22 04:50:49.535545+00
1591	570	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Брюховецкий район	0	2026-03-22 04:50:49.535545+00
1592	570	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Брюховецкий район	1	2026-03-22 04:50:49.535545+00
1593	571	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Кущёвский район	0	2026-03-22 04:50:49.535545+00
1594	571	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Кущёвский район	1	2026-03-22 04:50:49.535545+00
1595	572	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка Крыловский район	0	2026-03-22 04:50:49.535545+00
1596	572	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка Крыловский район	1	2026-03-22 04:50:49.535545+00
1597	573	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж Каневской район	0	2026-03-22 04:50:49.535545+00
1598	573	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж Каневской район	1	2026-03-22 04:50:49.535545+00
1599	574	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Ленинградский муниципальный округ	0	2026-03-22 04:50:49.535545+00
1600	574	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Ленинградский муниципальный округ	1	2026-03-22 04:50:49.535545+00
1601	575	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Лабинский район	0	2026-03-22 04:50:49.535545+00
1602	575	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Лабинский район	1	2026-03-22 04:50:49.535545+00
1603	576	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка Отрадненский район	0	2026-03-22 04:50:49.535545+00
1604	576	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка Отрадненский район	1	2026-03-22 04:50:49.535545+00
1605	577	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей городской округ Армавир	0	2026-03-22 04:50:49.535545+00
1606	577	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей городской округ Армавир	1	2026-03-22 04:50:49.535545+00
1607	578	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Новокубанский район	0	2026-03-22 04:50:49.535545+00
1608	578	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Новокубанский район	1	2026-03-22 04:50:49.535545+00
1609	579	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка Курганинский район	0	2026-03-22 04:50:49.535545+00
1610	579	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка Курганинский район	1	2026-03-22 04:50:49.535545+00
1611	580	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Гулькевичский район	0	2026-03-22 04:50:49.535545+00
1612	580	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Гулькевичский район	1	2026-03-22 04:50:49.535545+00
1613	581	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Кавказский район	0	2026-03-22 04:50:49.535545+00
1614	581	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Кавказский район	1	2026-03-22 04:50:49.535545+00
1615	582	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Белоглинский район	0	2026-03-22 04:50:49.535545+00
1616	582	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Белоглинский район	1	2026-03-22 04:50:49.535545+00
1617	583	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка Новопокровский район	0	2026-03-22 04:50:49.535545+00
1618	583	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка Новопокровский район	1	2026-03-22 04:50:49.535545+00
1619	584	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Павловский район	0	2026-03-22 04:50:49.535545+00
1620	584	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Павловский район	1	2026-03-22 04:50:49.535545+00
1621	585	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Кореновский район	0	2026-03-22 04:50:49.535545+00
1622	585	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Кореновский район	1	2026-03-22 04:50:49.535545+00
1623	586	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж Туапсинский муниципальный округ	0	2026-03-22 04:50:49.535545+00
1624	586	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж Туапсинский муниципальный округ	1	2026-03-22 04:50:49.535545+00
1625	587	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей городской округ Сочи	0	2026-03-22 04:50:49.535545+00
1626	587	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей городской округ Сочи	1	2026-03-22 04:50:49.535545+00
1627	588	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Успенский район	0	2026-03-22 04:50:49.535545+00
1628	588	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Успенский район	1	2026-03-22 04:50:49.535545+00
1629	589	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк Тбилисский район	0	2026-03-22 04:50:49.535545+00
1630	589	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк Тбилисский район	1	2026-03-22 04:50:49.535545+00
1631	590	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж Тихорецкий район	0	2026-03-22 04:50:49.535545+00
1632	590	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж Тихорецкий район	1	2026-03-22 04:50:49.535545+00
1633	591	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж Выселковский район	0	2026-03-22 04:50:49.535545+00
1634	591	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж Выселковский район	1	2026-03-22 04:50:49.535545+00
1635	592	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей Усть-Лабинский район	0	2026-03-22 04:50:49.535545+00
1636	592	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей Усть-Лабинский район	1	2026-03-22 04:50:49.535545+00
1637	593	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж городской округ Сириус	0	2026-03-22 04:50:49.535545+00
1638	593	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж городской округ Сириус	1	2026-03-22 04:50:49.535545+00
1639	594	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка «Краснодар»	0	2026-03-22 04:50:49.535545+00
1640	594	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка «Краснодар»	1	2026-03-22 04:50:49.535545+00
1641	595	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей «Краснодар»	0	2026-03-22 04:50:49.535545+00
1642	595	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей «Краснодар»	1	2026-03-22 04:50:49.535545+00
1643	596	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей «Анапа»	0	2026-03-22 04:50:49.535545+00
1644	596	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей «Анапа»	1	2026-03-22 04:50:49.535545+00
1645	597	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка «Анапа»	0	2026-03-22 04:50:49.535545+00
1646	597	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка «Анапа»	1	2026-03-22 04:50:49.535545+00
1647	598	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей «Ейск»	0	2026-03-22 04:50:49.535545+00
1648	598	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей «Ейск»	1	2026-03-22 04:50:49.535545+00
1649	599	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей «Ейск»	0	2026-03-22 04:50:49.535545+00
1650	599	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей «Ейск»	1	2026-03-22 04:50:49.535545+00
1651	600	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Сочи»	0	2026-03-22 04:50:49.535545+00
1652	600	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Сочи»	1	2026-03-22 04:50:49.535545+00
1653	601	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка «Сочи»	0	2026-03-22 04:50:49.535545+00
1654	601	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка «Сочи»	1	2026-03-22 04:50:49.535545+00
1655	602	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Геленджик»	0	2026-03-22 04:50:49.535545+00
1656	602	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Геленджик»	1	2026-03-22 04:50:49.535545+00
1657	603	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Геленджик»	0	2026-03-22 04:50:49.535545+00
1658	603	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Геленджик»	1	2026-03-22 04:50:49.535545+00
1659	604	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Горячий Ключ»	0	2026-03-22 04:50:49.535545+00
1660	604	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Горячий Ключ»	1	2026-03-22 04:50:49.535545+00
1661	605	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Горячий Ключ»	0	2026-03-22 04:50:49.535545+00
1662	605	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Горячий Ключ»	1	2026-03-22 04:50:49.535545+00
1663	606	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Туапсе»	0	2026-03-22 04:50:49.535545+00
1664	606	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Туапсе»	1	2026-03-22 04:50:49.535545+00
1665	607	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая площадка «Туапсе»	0	2026-03-22 04:50:49.535545+00
1666	607	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая площадка «Туапсе»	1	2026-03-22 04:50:49.535545+00
1667	608	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Новороссийск»	0	2026-03-22 04:50:49.535545+00
1668	608	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Новороссийск»	1	2026-03-22 04:50:49.535545+00
1669	609	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Новороссийск»	0	2026-03-22 04:50:49.535545+00
1670	609	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Новороссийск»	1	2026-03-22 04:50:49.535545+00
1671	610	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Армавир»	0	2026-03-22 04:50:49.535545+00
1672	610	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Армавир»	1	2026-03-22 04:50:49.535545+00
1673	611	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей «Армавир»	0	2026-03-22 04:50:49.535545+00
1674	611	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей «Армавир»	1	2026-03-22 04:50:49.535545+00
1675	612	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Музей «Красная Поляна»	0	2026-03-22 04:50:49.535545+00
1676	612	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Музей «Красная Поляна»	1	2026-03-22 04:50:49.535545+00
1677	613	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Красная Поляна»	0	2026-03-22 04:50:49.535545+00
1678	613	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Красная Поляна»	1	2026-03-22 04:50:49.535545+00
1679	614	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Центральная»	0	2026-03-22 04:58:11.986551+00
1680	614	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Центральная»	1	2026-03-22 04:58:11.986551+00
1681	615	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Тихий»	0	2026-03-22 04:58:11.986551+00
1682	615	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Тихий»	1	2026-03-22 04:58:11.986551+00
1683	616	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1684	616	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1685	617	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Причал»	0	2026-03-22 04:58:11.986551+00
1686	617	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Причал»	1	2026-03-22 04:58:11.986551+00
1687	618	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1688	618	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1689	619	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Золотой»	0	2026-03-22 04:58:11.986551+00
1690	619	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Золотой»	1	2026-03-22 04:58:11.986551+00
1691	620	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
1692	620	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
1693	621	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Кубанский»	0	2026-03-22 04:58:11.986551+00
1694	621	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Кубанский»	1	2026-03-22 04:58:11.986551+00
1695	622	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1696	623	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
1697	623	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
1698	624	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «У моря»	0	2026-03-22 04:58:11.986551+00
1699	624	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «У моря»	1	2026-03-22 04:58:11.986551+00
1700	625	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1701	625	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1702	626	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1703	626	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1704	627	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
1705	627	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
1706	628	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1707	628	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1708	629	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
1709	629	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
1710	630	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Приморский»	0	2026-03-22 04:58:11.986551+00
1711	630	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Приморский»	1	2026-03-22 04:58:11.986551+00
1712	631	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Центральная»	0	2026-03-22 04:58:11.986551+00
1713	631	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Центральная»	1	2026-03-22 04:58:11.986551+00
1714	632	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Покровский»	0	2026-03-22 04:58:11.986551+00
1715	632	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Покровский»	1	2026-03-22 04:58:11.986551+00
1716	633	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1717	633	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1718	634	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Центральная»	0	2026-03-22 04:58:11.986551+00
1719	634	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Центральная»	1	2026-03-22 04:58:11.986551+00
1720	635	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1721	635	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1722	636	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Покровский»	0	2026-03-22 04:58:11.986551+00
1723	636	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Покровский»	1	2026-03-22 04:58:11.986551+00
1724	637	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
1725	637	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
1726	638	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1727	638	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1728	639	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
1729	639	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
1730	640	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1731	641	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1732	641	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1733	642	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
1734	643	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1735	643	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1736	644	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1737	645	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Утро»	0	2026-03-22 04:58:11.986551+00
1738	645	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Утро»	1	2026-03-22 04:58:11.986551+00
1739	646	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Причал»	0	2026-03-22 04:58:11.986551+00
1740	646	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Причал»	1	2026-03-22 04:58:11.986551+00
1741	647	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Городской»	0	2026-03-22 04:58:11.986551+00
1742	647	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Городской»	1	2026-03-22 04:58:11.986551+00
1743	648	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Причал»	0	2026-03-22 04:58:11.986551+00
1744	648	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Причал»	1	2026-03-22 04:58:11.986551+00
1745	649	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
1746	649	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
1747	650	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1748	650	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1749	651	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1750	652	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
1751	652	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
1752	653	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Золотой»	0	2026-03-22 04:58:11.986551+00
1753	653	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Золотой»	1	2026-03-22 04:58:11.986551+00
1754	654	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
1755	654	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
1756	655	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1757	655	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1758	656	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
1759	656	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
1760	657	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
1761	657	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
1762	658	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
1763	658	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
1764	659	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
1765	659	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
1766	660	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
1767	660	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
1768	661	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1769	662	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1770	662	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1771	663	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Дикий»	0	2026-03-22 04:58:11.986551+00
1772	663	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Дикий»	1	2026-03-22 04:58:11.986551+00
1773	664	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1774	664	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1775	665	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1776	665	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1777	666	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
1778	666	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
1779	667	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
1780	667	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
1781	668	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Домашний»	0	2026-03-22 04:58:11.986551+00
1782	668	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Домашний»	1	2026-03-22 04:58:11.986551+00
1783	669	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
1784	669	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
1785	670	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
1786	670	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
1787	671	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Тихий»	0	2026-03-22 04:58:11.986551+00
1788	671	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Тихий»	1	2026-03-22 04:58:11.986551+00
1789	672	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1790	672	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1791	673	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Дикий»	0	2026-03-22 04:58:11.986551+00
1792	673	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Дикий»	1	2026-03-22 04:58:11.986551+00
1793	674	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
1794	674	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
1795	675	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Приморская»	0	2026-03-22 04:58:11.986551+00
1796	675	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Приморская»	1	2026-03-22 04:58:11.986551+00
1797	676	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
1798	676	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
1799	677	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Домашний»	0	2026-03-22 04:58:11.986551+00
1800	677	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Домашний»	1	2026-03-22 04:58:11.986551+00
1801	678	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
1802	678	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
1803	679	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Южная»	0	2026-03-22 04:58:11.986551+00
1804	679	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Южная»	1	2026-03-22 04:58:11.986551+00
1805	680	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
1806	680	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
1807	681	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1808	681	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1809	682	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
1810	682	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
1811	683	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1812	683	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1813	684	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
1814	685	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Утро»	0	2026-03-22 04:58:11.986551+00
1815	685	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Утро»	1	2026-03-22 04:58:11.986551+00
1816	686	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1817	687	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Горная»	0	2026-03-22 04:58:11.986551+00
1818	687	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Горная»	1	2026-03-22 04:58:11.986551+00
1819	688	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1820	689	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
1821	689	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
1822	690	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
1823	690	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
1824	691	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1825	692	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
1826	692	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
1827	693	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1828	694	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1829	695	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1830	695	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1831	696	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Южная»	0	2026-03-22 04:58:11.986551+00
1832	696	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Южная»	1	2026-03-22 04:58:11.986551+00
1833	697	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1834	697	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1835	698	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
1836	698	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
1837	699	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Безымянный»	0	2026-03-22 04:58:11.986551+00
1838	699	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Безымянный»	1	2026-03-22 04:58:11.986551+00
1839	700	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
1840	700	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
1841	701	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Безымянный»	0	2026-03-22 04:58:11.986551+00
1842	701	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Безымянный»	1	2026-03-22 04:58:11.986551+00
1843	702	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Городской»	0	2026-03-22 04:58:11.986551+00
1844	702	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Городской»	1	2026-03-22 04:58:11.986551+00
1845	703	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
1846	703	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
1847	704	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
1848	704	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
1849	705	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1850	705	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1851	706	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1852	707	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1853	707	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1854	708	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Приморский»	0	2026-03-22 04:58:11.986551+00
1855	708	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Приморский»	1	2026-03-22 04:58:11.986551+00
1856	709	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
1857	709	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
1858	710	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
1859	710	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
1860	711	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Приморский»	0	2026-03-22 04:58:11.986551+00
1861	711	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Приморский»	1	2026-03-22 04:58:11.986551+00
1862	712	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
1863	712	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
1864	713	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1865	713	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1866	714	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
1867	714	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
1868	715	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
1869	716	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1870	717	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Южная»	0	2026-03-22 04:58:11.986551+00
1871	717	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Южная»	1	2026-03-22 04:58:11.986551+00
1872	718	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Лаванда»	0	2026-03-22 04:58:11.986551+00
1873	718	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Лаванда»	1	2026-03-22 04:58:11.986551+00
1874	719	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
1875	719	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
1876	720	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1877	720	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1878	721	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
1879	721	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
1880	722	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Покровский»	0	2026-03-22 04:58:11.986551+00
1881	722	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Покровский»	1	2026-03-22 04:58:11.986551+00
1882	723	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1883	724	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
1884	724	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
1885	725	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1886	725	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1887	726	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Панорама»	0	2026-03-22 04:58:11.986551+00
1888	726	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Панорама»	1	2026-03-22 04:58:11.986551+00
1889	727	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
1890	727	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
1891	728	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1892	728	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1893	729	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
1894	729	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
1895	730	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1896	731	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Дикий»	0	2026-03-22 04:58:11.986551+00
1897	731	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Дикий»	1	2026-03-22 04:58:11.986551+00
1898	732	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
1899	732	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
1900	733	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
1901	733	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
1902	734	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
1903	734	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
1904	735	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Городской»	0	2026-03-22 04:58:11.986551+00
1905	735	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Городской»	1	2026-03-22 04:58:11.986551+00
1906	736	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Южная»	0	2026-03-22 04:58:11.986551+00
1907	736	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Южная»	1	2026-03-22 04:58:11.986551+00
1908	737	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Приморская»	0	2026-03-22 04:58:11.986551+00
1909	737	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Приморская»	1	2026-03-22 04:58:11.986551+00
1910	738	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
1911	738	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
1912	739	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1913	739	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1914	740	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Причал»	0	2026-03-22 04:58:11.986551+00
1915	740	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Причал»	1	2026-03-22 04:58:11.986551+00
1916	741	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
1917	741	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
1918	742	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Дикий»	0	2026-03-22 04:58:11.986551+00
1919	742	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Дикий»	1	2026-03-22 04:58:11.986551+00
1920	743	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
1921	743	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
1922	744	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
1923	744	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
1924	745	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Мельница»	0	2026-03-22 04:58:11.986551+00
1925	745	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Мельница»	1	2026-03-22 04:58:11.986551+00
1926	746	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Старый двор»	0	2026-03-22 04:58:11.986551+00
1927	746	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Старый двор»	1	2026-03-22 04:58:11.986551+00
1928	747	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Лаванда»	0	2026-03-22 04:58:11.986551+00
1929	747	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Лаванда»	1	2026-03-22 04:58:11.986551+00
1930	748	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Покровский»	0	2026-03-22 04:58:11.986551+00
1931	748	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Покровский»	1	2026-03-22 04:58:11.986551+00
1932	749	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Безымянный»	0	2026-03-22 04:58:11.986551+00
1933	749	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Безымянный»	1	2026-03-22 04:58:11.986551+00
1934	750	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Безымянный»	0	2026-03-22 04:58:11.986551+00
1935	750	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Безымянный»	1	2026-03-22 04:58:11.986551+00
1936	751	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Кубанский»	0	2026-03-22 04:58:11.986551+00
1937	751	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Кубанский»	1	2026-03-22 04:58:11.986551+00
1938	752	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Домашний»	0	2026-03-22 04:58:11.986551+00
1939	752	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Домашний»	1	2026-03-22 04:58:11.986551+00
1940	753	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Тихий»	0	2026-03-22 04:58:11.986551+00
1941	753	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Тихий»	1	2026-03-22 04:58:11.986551+00
1942	754	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
1943	754	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
1944	755	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1945	756	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Покровский»	0	2026-03-22 04:58:11.986551+00
1946	756	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Покровский»	1	2026-03-22 04:58:11.986551+00
1947	757	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
1948	757	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
1949	758	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
1950	758	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
1951	759	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Кубанский»	0	2026-03-22 04:58:11.986551+00
1952	759	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Кубанский»	1	2026-03-22 04:58:11.986551+00
1953	760	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Панорама»	0	2026-03-22 04:58:11.986551+00
1954	760	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Панорама»	1	2026-03-22 04:58:11.986551+00
1955	761	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
1956	761	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
1957	762	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1958	763	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Утро»	0	2026-03-22 04:58:11.986551+00
1959	763	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Утро»	1	2026-03-22 04:58:11.986551+00
1960	764	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Кубанский»	0	2026-03-22 04:58:11.986551+00
1961	764	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Кубанский»	1	2026-03-22 04:58:11.986551+00
1962	765	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1963	765	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1964	766	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
1965	766	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
1966	767	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
1967	767	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
1968	768	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
1969	768	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
1970	769	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1971	769	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1972	770	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
1973	770	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
1974	771	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
1975	771	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
1976	772	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
1977	772	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
1978	773	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
1979	774	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
1980	775	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
1981	775	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
1982	776	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
1983	776	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
1984	777	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
1985	777	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
1986	778	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Утро»	0	2026-03-22 04:58:11.986551+00
1987	778	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Утро»	1	2026-03-22 04:58:11.986551+00
1988	779	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
1989	779	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
1990	780	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
1991	780	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
1992	781	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
1993	781	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
1994	782	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Утро»	0	2026-03-22 04:58:11.986551+00
1995	782	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Утро»	1	2026-03-22 04:58:11.986551+00
1996	783	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
1997	783	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
1998	784	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
1999	784	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
2000	785	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
2001	786	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Горный»	0	2026-03-22 04:58:11.986551+00
2002	786	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Горный»	1	2026-03-22 04:58:11.986551+00
2003	787	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Причал»	0	2026-03-22 04:58:11.986551+00
2004	787	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Причал»	1	2026-03-22 04:58:11.986551+00
2005	788	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Приморская»	0	2026-03-22 04:58:11.986551+00
2006	788	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Приморская»	1	2026-03-22 04:58:11.986551+00
2007	789	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Безымянный»	0	2026-03-22 04:58:11.986551+00
2008	789	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Безымянный»	1	2026-03-22 04:58:11.986551+00
2009	790	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
2010	790	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
2011	791	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Горный»	0	2026-03-22 04:58:11.986551+00
2012	791	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Горный»	1	2026-03-22 04:58:11.986551+00
2013	792	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
2014	793	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
2015	793	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
2016	794	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Мельница»	0	2026-03-22 04:58:11.986551+00
2017	794	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Мельница»	1	2026-03-22 04:58:11.986551+00
2018	795	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
2019	795	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
2020	796	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
2021	796	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
2022	797	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
2023	797	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
2024	798	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
2025	798	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
2026	799	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
2027	800	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
2028	800	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
2029	801	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Терраса»	0	2026-03-22 04:58:11.986551+00
2030	801	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Терраса»	1	2026-03-22 04:58:11.986551+00
2031	802	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Старый двор»	0	2026-03-22 04:58:11.986551+00
2032	802	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Старый двор»	1	2026-03-22 04:58:11.986551+00
2033	803	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
2034	803	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
2035	804	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Старый двор»	0	2026-03-22 04:58:11.986551+00
2036	804	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Старый двор»	1	2026-03-22 04:58:11.986551+00
2037	805	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Дикий»	0	2026-03-22 04:58:11.986551+00
2038	805	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Дикий»	1	2026-03-22 04:58:11.986551+00
2039	806	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
2040	806	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
2041	807	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
2042	808	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Роснефть»	0	2026-03-22 04:58:11.986551+00
2043	809	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
2044	809	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
2045	810	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
2046	810	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
2047	811	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Горный»	0	2026-03-22 04:58:11.986551+00
2048	811	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Горный»	1	2026-03-22 04:58:11.986551+00
2049	812	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
2050	812	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
2051	813	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
2052	813	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
2053	814	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
2054	814	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
2055	815	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
2056	815	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
2057	816	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
2058	816	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
2059	817	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Лаванда»	0	2026-03-22 04:58:11.986551+00
2060	817	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Лаванда»	1	2026-03-22 04:58:11.986551+00
2061	818	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
2062	818	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
2063	819	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
2064	819	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
2065	820	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Центральная»	0	2026-03-22 04:58:11.986551+00
2066	820	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Центральная»	1	2026-03-22 04:58:11.986551+00
2067	821	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Городской»	0	2026-03-22 04:58:11.986551+00
2068	821	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Городской»	1	2026-03-22 04:58:11.986551+00
2069	822	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Старый двор»	0	2026-03-22 04:58:11.986551+00
2070	822	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Старый двор»	1	2026-03-22 04:58:11.986551+00
2071	823	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
2072	824	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
2073	824	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
2074	825	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
2075	825	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
2076	826	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Горная»	0	2026-03-22 04:58:11.986551+00
2077	826	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Горная»	1	2026-03-22 04:58:11.986551+00
2078	827	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Панорама»	0	2026-03-22 04:58:11.986551+00
2079	827	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Панорама»	1	2026-03-22 04:58:11.986551+00
2080	828	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
2081	828	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
2082	829	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Дикий»	0	2026-03-22 04:58:11.986551+00
2083	829	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Дикий»	1	2026-03-22 04:58:11.986551+00
2084	830	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
2085	831	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
2086	831	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
2087	832	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
2088	832	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
2089	833	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Причал»	0	2026-03-22 04:58:11.986551+00
2090	833	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Причал»	1	2026-03-22 04:58:11.986551+00
2091	834	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
2092	834	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
2093	835	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
2094	835	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
2095	836	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Тихая гавань»	0	2026-03-22 04:58:11.986551+00
2096	836	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Тихая гавань»	1	2026-03-22 04:58:11.986551+00
2097	837	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Центральный»	0	2026-03-22 04:58:11.986551+00
2098	837	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Центральный»	1	2026-03-22 04:58:11.986551+00
2099	838	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
2100	838	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
2101	839	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Горный»	0	2026-03-22 04:58:11.986551+00
2102	839	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Горный»	1	2026-03-22 04:58:11.986551+00
2103	840	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
2104	840	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
2105	841	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Домашний»	0	2026-03-22 04:58:11.986551+00
2106	841	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Домашний»	1	2026-03-22 04:58:11.986551+00
2107	842	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
2108	842	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
2109	843	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
2110	843	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
2111	844	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
2112	844	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
2113	845	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Кубанский»	0	2026-03-22 04:58:11.986551+00
2114	845	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Кубанский»	1	2026-03-22 04:58:11.986551+00
2115	846	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Утро»	0	2026-03-22 04:58:11.986551+00
2116	846	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Утро»	1	2026-03-22 04:58:11.986551+00
2117	847	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
2118	847	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
2119	848	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Лаванда»	0	2026-03-22 04:58:11.986551+00
2120	848	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Лаванда»	1	2026-03-22 04:58:11.986551+00
2121	849	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Уют»	0	2026-03-22 04:58:11.986551+00
2122	849	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Уют»	1	2026-03-22 04:58:11.986551+00
2123	850	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
2124	850	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
2125	851	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Тихий»	0	2026-03-22 04:58:11.986551+00
2126	851	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Тихий»	1	2026-03-22 04:58:11.986551+00
2127	852	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
2128	852	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
2129	853	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
2130	853	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
2131	854	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Лукойл»	0	2026-03-22 04:58:11.986551+00
2132	855	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
2133	855	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
2134	856	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
2135	856	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
2136	857	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
2137	858	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
2138	858	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
2139	859	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Мельница»	0	2026-03-22 04:58:11.986551+00
2140	859	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Мельница»	1	2026-03-22 04:58:11.986551+00
2141	860	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
2142	860	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
2143	861	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
2144	861	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
2145	862	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Центральная»	0	2026-03-22 04:58:11.986551+00
2146	862	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Центральная»	1	2026-03-22 04:58:11.986551+00
2147	863	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
2148	863	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
2149	864	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
2150	864	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
2151	865	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Долина»	0	2026-03-22 04:58:11.986551+00
2152	865	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Долина»	1	2026-03-22 04:58:11.986551+00
2153	866	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Горный»	0	2026-03-22 04:58:11.986551+00
2154	866	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Горный»	1	2026-03-22 04:58:11.986551+00
2155	867	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Панорама»	0	2026-03-22 04:58:11.986551+00
2156	867	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Панорама»	1	2026-03-22 04:58:11.986551+00
2157	868	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
2158	868	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
2159	869	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
2160	869	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
2161	870	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
2162	870	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
2163	871	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Горный»	0	2026-03-22 04:58:11.986551+00
2164	871	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Горный»	1	2026-03-22 04:58:11.986551+00
2165	872	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Горная»	0	2026-03-22 04:58:11.986551+00
2166	872	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Горная»	1	2026-03-22 04:58:11.986551+00
2167	873	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
2168	873	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
2169	874	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Свято-Николаевский»	0	2026-03-22 04:58:11.986551+00
2170	874	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Свято-Николаевский»	1	2026-03-22 04:58:11.986551+00
2171	875	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Панорама»	0	2026-03-22 04:58:11.986551+00
2172	875	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Панорама»	1	2026-03-22 04:58:11.986551+00
2173	876	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
2174	876	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
2175	877	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Горная»	0	2026-03-22 04:58:11.986551+00
2176	877	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Горная»	1	2026-03-22 04:58:11.986551+00
2177	878	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Мельница»	0	2026-03-22 04:58:11.986551+00
2178	878	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Мельница»	1	2026-03-22 04:58:11.986551+00
2179	879	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Орлиная»	0	2026-03-22 04:58:11.986551+00
2180	879	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Орлиная»	1	2026-03-22 04:58:11.986551+00
2181	880	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
2182	880	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
2183	881	https://images.unsplash.com/photo-1585007600263-dbc7e6a65920?w=800	Храм «Троицкий»	0	2026-03-22 04:58:11.986551+00
2184	881	https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=800	Храм «Троицкий»	1	2026-03-22 04:58:11.986551+00
2185	882	https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800	Гостиница «Центральная»	0	2026-03-22 04:58:11.986551+00
2186	882	https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800	Гостиница «Центральная»	1	2026-03-22 04:58:11.986551+00
2187	883	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «На обрыве»	0	2026-03-22 04:58:11.986551+00
2188	883	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «На обрыве»	1	2026-03-22 04:58:11.986551+00
2189	884	https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800	Ресторан «Домашний»	0	2026-03-22 04:58:11.986551+00
2190	884	https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800	Ресторан «Домашний»	1	2026-03-22 04:58:11.986551+00
2191	885	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Старый»	0	2026-03-22 04:58:11.986551+00
2192	885	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Старый»	1	2026-03-22 04:58:11.986551+00
2193	886	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Мельница»	0	2026-03-22 04:58:11.986551+00
2194	886	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Мельница»	1	2026-03-22 04:58:11.986551+00
2195	887	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
2196	887	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
2197	888	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Уют»	0	2026-03-22 04:58:11.986551+00
2198	888	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Уют»	1	2026-03-22 04:58:11.986551+00
2199	889	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
2200	889	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
2201	890	https://images.unsplash.com/photo-1432405972618-c6b0cfba575b?w=800	Водопад «Серебряный»	0	2026-03-22 04:58:11.986551+00
2202	890	https://images.unsplash.com/photo-1433086966358-54859d0ed716?w=800	Водопад «Серебряный»	1	2026-03-22 04:58:11.986551+00
2203	891	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Детский»	0	2026-03-22 04:58:11.986551+00
2204	891	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Детский»	1	2026-03-22 04:58:11.986551+00
2205	892	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Лазурный»	0	2026-03-22 04:58:11.986551+00
2206	892	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Лазурный»	1	2026-03-22 04:58:11.986551+00
2207	893	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
2208	894	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Кубанская»	0	2026-03-22 04:58:11.986551+00
2209	894	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Кубанская»	1	2026-03-22 04:58:11.986551+00
2210	895	https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800	Парк «Городской»	0	2026-03-22 04:58:11.986551+00
2211	895	https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=800	Парк «Городской»	1	2026-03-22 04:58:11.986551+00
2212	896	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
2213	897	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
2214	897	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
2215	898	https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800	Смотровая «Панорама»	0	2026-03-22 04:58:11.986551+00
2216	898	https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800	Смотровая «Панорама»	1	2026-03-22 04:58:11.986551+00
2217	899	https://images.unsplash.com/photo-1560493676-04071c5f467b?w=800	Винодельня «Южная»	0	2026-03-22 04:58:11.986551+00
2218	899	https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=800	Винодельня «Южная»	1	2026-03-22 04:58:11.986551+00
2219	900	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Бриз»	0	2026-03-22 04:58:11.986551+00
2220	900	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Бриз»	1	2026-03-22 04:58:11.986551+00
2221	901	https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=800	Заправка «Газпром»	0	2026-03-22 04:58:11.986551+00
2222	902	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Уют»	0	2026-03-22 04:58:11.986551+00
2223	902	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Уют»	1	2026-03-22 04:58:11.986551+00
2224	903	https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800	Пляж «Золотой»	0	2026-03-22 04:58:11.986551+00
2225	903	https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800	Пляж «Золотой»	1	2026-03-22 04:58:11.986551+00
2226	904	https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800	Кафе «Веранда»	0	2026-03-22 04:58:11.986551+00
2227	904	https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800	Кафе «Веранда»	1	2026-03-22 04:58:11.986551+00
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.posts (id, author_id, title, description, geo_lat, geo_lng, season, region_id, address, phone, email, website, need_car, price_level, duration_hours, best_angle, partner_id, verified, rating_avg, reviews_count, created_at, updated_at, city) FROM stdin;
534	1	Агурские водопады	Три каскада в ущелье. Нижний — 30 метров. Тропа от Мацесты, 2 часа туда-обратно.	43.5575	39.8208	spring	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Сочи
535	1	Озеро Рица	Горное озеро на высоте 950м. Бирюзовая вода, скалы, шашлыки на берегу.	43.4722	40.5419	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Сочи
536	1	Набережная Геленджика	7 км вдоль бухты. Велодорожка, кафе, фонтаны. Вечером подсветка.	44.5611	38.0764	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Геленджик
537	1	Скала Парус	Каменная стена 25м торчит из моря. Фото на закате — обязательно.	44.4342	38.1842	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Геленджик
538	1	Дендрарий Сочи	1800 видов растений на склоне горы. Канатка наверх, пешком вниз. 2-3 часа.	43.5717	39.7428	spring	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Сочи
539	1	Олимпийский парк	Стадион Фишт, поющие фонтаны, трасса Формулы-1. Велосипед напрокат 300₽/час.	43.4019	39.9556	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Сочи
540	1	Мыс Тарханкут	Обрывы, гроты, чистейшая вода. Дайвинг и снорклинг. Дикий, без инфраструктуры.	45.3472	32.4947	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Анапа
541	1	Свято-Троицкий собор Краснодара	Главный храм города. Красный кирпич, золотые купола. Внутри тихо.	45.025	38.9711	autumn	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Краснодар
542	1	Грязевой вулкан Шуго	Залезть в тёплую грязь, измазаться, смыть в речке. Дети в восторге, взрослые тоже.	44.8167	37.7833	summer	79	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Крымск
543	1	Большой Утриш	Заповедник. Можжевеловый лес, дикие пляжи, дельфины иногда. Пешком от Анапы 12км.	44.7558	37.3886	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Анапа
544	1	Винодельня Мысхако	Одна из старейших в крае. Дегустация от 500₽, магазин при заводе.	44.6611	37.7483	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Новороссийск
545	1	Тюльпановое дерево	Дереву 200 лет, обхват 6 метров. Цветёт в мае. Головинка, 30 мин от Лазаревского.	43.9778	39.3667	spring	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Туапсе
546	1	Каньон Белые скалы	Белый известняк, голубая вода, прыжки со скал. Лучше в будни — меньше народу.	43.4786	39.6158	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Сочи
547	1	Рынок Краснодара	Центральный рынок. Сыры, мёд, чурчхела, специи. Торговаться можно.	45.0233	38.9783	autumn	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Краснодар
548	1	Маяк Анапы	Белый маяк на обрыве. Лучший закат в городе. Фото обязательно.	44.8839	37.3108	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:45:47.859648+00	2026-03-22 04:45:47.859648+00	Анапа
674	1	Смотровая «Орлиная»	Панорама на горы и море.	45.099806	39.416176	summer	67	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Васюринская
675	1	Гостиница «Приморская»	Чисто, тихо, завтрак включён.	45.192958	39.57661	summer	68	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Воронежская
676	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	45.213813	39.562725	autumn	68	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Воронежская
677	1	Ресторан «Домашний»	Местная кухня, свежие продукты.	45.292856	39.263122	summer	69	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Пластуновская
678	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	45.30094	39.274589	spring	69	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Пластуновская
679	1	Гостиница «Южная»	Чисто, тихо, завтрак включён.	45.289802	39.280873	summer	69	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Пластуновская
680	1	Смотровая «Горная»	Панорама на горы и море.	45.409645	39.387264	summer	70	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Платнировская
681	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.378712	39.399961	autumn	70	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Платнировская
682	1	Кафе «Бриз»	Кофе, выпечка, вид.	45.373671	39.39738	summer	70	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Платнировская
683	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	45.391798	39.408824	autumn	70	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Платнировская
684	1	Заправка «Лукойл»	Лукойл, круглосуточно.	45.056491	38.800693	summer	71	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Елизаветинская
685	1	Кафе «Утро»	Кофе, выпечка, вид.	45.062358	38.802485	summer	71	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Елизаветинская
686	1	Заправка «Роснефть»	Лукойл, круглосуточно.	45.067264	38.790708	summer	71	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Елизаветинская
687	1	Гостиница «Горная»	Чисто, тихо, завтрак включён.	45.192735	38.574961	summer	72	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомышастовская
688	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.180554	38.595477	summer	72	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомышастовская
689	1	Кафе «Веранда»	Кофе, выпечка, вид.	45.199161	38.563785	summer	72	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомышастовская
690	1	Пляж «Центральный»	Чистая вода, галька.	45.209009	38.568386	summer	72	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомышастовская
549	1	Смотровая площадка городской округ Краснодар	Панорама на закате.	45.09289	38.986548	summer	3	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	городской округ Краснодар
550	1	Музей Динской район	Экспозиция про казаков.	45.231393	39.035934	autumn	4	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Динской район
551	1	Кафе Красноармейский район	Местная кухня, порции большие.	45.341176	38.457941	summer	5	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Красноармейский район
552	1	Музей Северский район	Экспозиция про казаков.	44.816655	38.691911	autumn	6	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Северский район
553	1	Музей Абинский район	Маленький но душевный.	44.848138	38.270114	autumn	7	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Абинский район
554	1	Музей Славянский район	Краеведческий, история района.	45.445318	37.865564	autumn	8	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Славянский район
555	1	Смотровая площадка Крымский район	Вид на долину и горы.	44.957515	37.882073	summer	9	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Крымский район
556	1	Музей Темрюкский район	Маленький но душевный.	45.235313	37.171501	autumn	10	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Темрюкский район
557	1	Смотровая площадка муниципальный округ Анапа	Обзор на 360 градусов.	44.921821	37.237405	summer	11	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	муниципальный округ Анапа
558	1	Музей городской округ Новороссийск	Экспозиция про казаков.	44.780596	37.69299	autumn	12	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	городской округ Новороссийск
559	1	Пляж городской округ Геленджик	Галька, чистая вода, мало народу.	44.579454	38.323785	summer	13	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	городской округ Геленджик
560	1	Смотровая площадка муниципальный округ Горячий Ключ	Вид на долину и горы.	44.567445	39.289004	summer	14	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	муниципальный округ Горячий Ключ
561	1	Парк Белореченский район	Старые деревья, белки.	44.761974	39.756253	spring	15	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Белореченский район
562	1	Музей Апшеронский район	Экспозиция про казаков.	44.321715	39.657816	autumn	16	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Апшеронский район
563	1	Пляж Мостовский район	Песок, пологий вход, для детей.	44.173787	40.590164	summer	19	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Мостовский район
564	1	Парк Ейский район	Детская площадка, фонтан.	46.458653	38.115457	spring	20	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Ейский район
565	1	Кафе Щербиновский район	Домашняя кухня, борщ и пироги.	46.580029	38.711417	summer	21	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Щербиновский район
566	1	Пляж Староминский район	Песок, пологий вход, для детей.	46.453475	39.009175	summer	22	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Староминский район
567	1	Музей Приморско-Ахтарский муниципальный округ	Краеведческий, история района.	45.996521	38.21999	autumn	23	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Приморско-Ахтарский муниципальный округ
568	1	Парк Калининский район	Старые деревья, белки.	45.549352	38.396624	spring	24	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Калининский район
569	1	Музей Тимашёвский район	Краеведческий, история района.	45.560015	39.019953	autumn	25	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Тимашёвский район
570	1	Музей Брюховецкий район	Экспозиция про казаков.	45.811881	39.103627	autumn	26	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Брюховецкий район
571	1	Парк Кущёвский район	Детская площадка, фонтан.	46.566037	39.728444	spring	27	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Кущёвский район
572	1	Смотровая площадка Крыловский район	Панорама на закате.	46.411042	40.03019	summer	28	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Крыловский район
573	1	Пляж Каневской район	Галька, чистая вода, мало народу.	46.132546	39.011813	summer	29	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Каневской район
574	1	Музей Ленинградский муниципальный округ	Экспозиция про казаков.	46.178573	39.455817	autumn	30	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Ленинградский муниципальный округ
575	1	Музей Лабинский район	Маленький но душевный.	44.414395	40.927121	autumn	31	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Лабинский район
576	1	Смотровая площадка Отрадненский район	Вид на долину и горы.	44.319257	41.363941	summer	32	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Отрадненский район
577	1	Музей городской округ Армавир	Краеведческий, история района.	44.914462	41.071347	autumn	34	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	городской округ Армавир
578	1	Парк Новокубанский район	Тенистые аллеи, скамейки, тишина.	44.845018	41.060318	spring	35	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Новокубанский район
579	1	Смотровая площадка Курганинский район	Вид на долину и горы.	44.919002	40.511816	summer	36	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Курганинский район
580	1	Парк Гулькевичский район	Старые деревья, белки.	45.273563	40.641422	spring	37	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Гулькевичский район
581	1	Парк Кавказский район	Старые деревья, белки.	45.478832	40.561383	spring	38	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Кавказский район
582	1	Парк Белоглинский район	Старые деревья, белки.	45.989452	40.88143	spring	39	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Белоглинский район
583	1	Смотровая площадка Новопокровский район	Вид на долину и горы.	46.018647	40.648168	summer	40	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Новопокровский район
584	1	Музей Павловский район	Маленький но душевный.	46.075227	39.933025	autumn	41	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Павловский район
585	1	Музей Кореновский район	Экспозиция про казаков.	45.541557	39.428419	autumn	42	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Кореновский район
586	1	Пляж Туапсинский муниципальный округ	Галька, чистая вода, мало народу.	44.312743	39.097065	summer	17	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Туапсинский муниципальный округ
587	1	Музей городской округ Сочи	Краеведческий, история района.	43.739256	39.914725	autumn	18	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	городской округ Сочи
588	1	Музей Успенский район	Маленький но душевный.	44.810077	41.400398	autumn	33	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Успенский район
589	1	Парк Тбилисский район	Детская площадка, фонтан.	45.345667	40.171821	spring	43	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Тбилисский район
590	1	Пляж Тихорецкий район	Песок, пологий вход, для детей.	45.872878	40.226807	summer	44	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Тихорецкий район
591	1	Пляж Выселковский район	Песок, пологий вход, для детей.	45.71401	39.847055	summer	45	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Выселковский район
592	1	Музей Усть-Лабинский район	Маленький но душевный.	45.234284	39.742191	autumn	46	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Усть-Лабинский район
593	1	Пляж городской округ Сириус	Песок, пологий вход, для детей.	43.394777	40.015822	summer	47	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	городской округ Сириус
594	1	Смотровая площадка «Краснодар»	Панорама на закате.	45.051754	38.960483	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Краснодар
595	1	Музей «Краснодар»	Маленький но душевный.	45.062354	38.959089	autumn	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Краснодар
596	1	Музей «Анапа»	Экспозиция про казаков.	44.893004	37.28699	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Анапа
597	1	Смотровая площадка «Анапа»	Обзор на 360 градусов.	44.88282	37.316536	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Анапа
598	1	Музей «Ейск»	Краеведческий, история района.	46.702923	38.256904	autumn	53	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Ейск
599	1	Музей «Ейск»	Краеведческий, история района.	46.686913	38.289636	autumn	53	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Ейск
600	1	Парк «Сочи»	Старые деревья, белки.	43.603316	39.697137	spring	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Сочи
601	1	Смотровая площадка «Сочи»	Обзор на 360 градусов.	43.594808	39.748012	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Сочи
602	1	Кафе «Геленджик»	Кофе и выпечка с видом.	44.574085	38.070246	summer	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Геленджик
603	1	Парк «Геленджик»	Старые деревья, белки.	44.569318	38.074099	spring	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Геленджик
604	1	Кафе «Горячий Ключ»	Местная кухня, порции большие.	44.631969	39.118807	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Горячий Ключ
605	1	Парк «Горячий Ключ»	Детская площадка, фонтан.	44.638755	39.163258	spring	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Горячий Ключ
606	1	Пляж «Туапсе»	Дикий, без зонтиков, красиво.	44.112495	39.052094	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Туапсе
607	1	Смотровая площадка «Туапсе»	Панорама на закате.	44.123071	39.04781	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Туапсе
608	1	Пляж «Новороссийск»	Галька, чистая вода, мало народу.	44.69747	37.747748	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Новороссийск
609	1	Пляж «Новороссийск»	Дикий, без зонтиков, красиво.	44.700538	37.793849	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Новороссийск
610	1	Пляж «Армавир»	Песок, пологий вход, для детей.	45.000823	41.139394	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Армавир
611	1	Музей «Армавир»	Маленький но душевный.	45.01003	41.119497	autumn	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Армавир
612	1	Музей «Красная Поляна»	Экспозиция про казаков.	43.704644	40.227083	autumn	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Красная Поляна
613	1	Парк «Красная Поляна»	Тенистые аллеи, скамейки, тишина.	43.700815	40.190004	spring	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:50:49.535545+00	2026-03-22 04:50:49.535545+00	Красная Поляна
691	1	Заправка «Роснефть»	Лукойл, круглосуточно.	45.222521	39.219628	summer	73	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Динская
692	1	Кафе «Бриз»	Кофе, выпечка, вид.	45.224544	39.225811	summer	73	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Динская
693	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.746764	39.866633	summer	74	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Белореченск
694	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.749519	39.855638	summer	74	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Белореченск
695	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.773747	39.886129	autumn	74	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Белореченск
614	1	Гостиница «Центральная»	Чисто, тихо, завтрак включён.	45.874543	40.133644	summer	97	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тихорецк
615	1	Пляж «Тихий»	Чистая вода, галька.	45.854358	40.130996	summer	97	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тихорецк
616	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	45.856822	40.1096	spring	97	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тихорецк
617	1	Ресторан «Причал»	Местная кухня, свежие продукты.	45.873949	40.143102	summer	97	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тихорецк
618	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.041936	38.961004	autumn	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Краснодар
619	1	Пляж «Золотой»	Чистая вода, галька.	45.026385	38.965318	summer	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Краснодар
620	1	Пляж «Центральный»	Чистая вода, галька.	45.263144	38.132551	summer	49	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Славянск-на-Кубани
621	1	Ресторан «Кубанский»	Местная кухня, свежие продукты.	45.254159	38.129067	summer	49	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Славянск-на-Кубани
622	1	Заправка «Роснефть»	Лукойл, круглосуточно.	45.27502	37.371122	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Темрюк
623	1	Пляж «Лазурный»	Чистая вода, галька.	45.274856	37.380995	summer	50	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Темрюк
624	1	Ресторан «У моря»	Местная кухня, свежие продукты.	44.893965	37.313294	summer	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Анапа
625	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.879084	37.334828	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Анапа
626	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	46.05379	38.175307	spring	52	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Приморско-Ахтарск
627	1	Смотровая «Орлиная»	Панорама на горы и море.	46.059821	38.16556	summer	52	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Приморско-Ахтарск
628	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	46.718032	38.26518	spring	53	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ейск
629	1	Кафе «Веранда»	Кофе, выпечка, вид.	46.70633	38.261813	summer	53	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ейск
630	1	Парк «Приморский»	Зелень, скамейки, фонтан.	46.730269	38.280039	spring	53	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ейск
631	1	Гостиница «Центральная»	Чисто, тихо, завтрак включён.	46.704453	38.264982	summer	53	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ейск
632	1	Храм «Покровский»	Старинный, тихий, красивый.	43.600009	39.726996	autumn	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сочи
633	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	43.598896	39.727534	autumn	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сочи
634	1	Гостиница «Центральная»	Чисто, тихо, завтрак включён.	43.57595	39.71871	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сочи
635	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	43.597148	39.704815	autumn	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сочи
636	1	Храм «Покровский»	Старинный, тихий, красивый.	44.562746	38.085109	autumn	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Геленджик
637	1	Парк «Детский»	Зелень, скамейки, фонтан.	44.572229	38.08581	spring	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Геленджик
638	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	44.580115	38.064679	autumn	55	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Геленджик
639	1	Пляж «Лазурный»	Чистая вода, галька.	44.645982	37.947289	summer	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кабардинка
640	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.640677	37.92431	summer	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кабардинка
641	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.61909	39.155093	autumn	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Горячий Ключ
642	1	Заправка «Лукойл»	Лукойл, круглосуточно.	44.650607	39.130036	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Горячий Ключ
643	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	44.616023	39.13596	autumn	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Горячий Ключ
644	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.632624	39.141641	summer	57	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Горячий Ключ
645	1	Кафе «Утро»	Кофе, выпечка, вид.	44.094272	39.070615	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Туапсе
646	1	Ресторан «Причал»	Местная кухня, свежие продукты.	44.082441	39.06342	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Туапсе
647	1	Парк «Городской»	Зелень, скамейки, фонтан.	44.085649	39.07947	spring	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Туапсе
648	1	Ресторан «Причал»	Местная кухня, свежие продукты.	44.115272	39.076239	summer	58	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Туапсе
649	1	Смотровая «На обрыве»	Панорама на горы и море.	44.719792	37.766512	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новороссийск
650	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	44.743107	37.774312	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новороссийск
651	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.735018	37.749131	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новороссийск
525	1	Skypark AJ Hackett Сочи	Банджи-джампинг 207 метров, самый длинный подвесной мост в мире. Ахштырское ущелье под ногами.	43.5281	40.0206	summer	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.50	2	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Сочи
532	1	Ферма Экзархо	Козий сыр, экскурсия по ферме, мастер-класс по варке моцареллы. Берите сумку-холодильник.	44.8956	37.8469	summer	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.67	3	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Новороссийск
531	1	Гуамское ущелье	Узкоколейка по краю обрыва 400 метров. Поезд идёт медленно, можно снимать. Скалы, река Курджипс.	44.2458	39.9217	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.50	2	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Апшеронск
526	1	Парк Галицкого	Лучший городской парк России по версии всех рейтингов. Террасы, амфитеатр, зеркальный лабиринт. Вечером подсветка.	45.0428	38.9581	spring	48	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.67	3	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Краснодар
524	1	Абрау-Дюрсо	Винодельня с дегустацией игристых вин. Озеро, парк, лавка сыров. Экскурсия по подвалам — обязательно.	44.6977	37.5977	autumn	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.67	3	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Новороссийск
533	1	Старый парк в Кабардинке	Архитектурный парк: египетский храм, средневековый замок, японский сад. Всё в одном месте, без толп.	44.6528	37.9336	spring	56	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.50	2	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Кабардинка
530	1	Кипарисовое озеро	Болотные кипарисы растут прямо из воды. Рассвет — лучшее время, народу никого. Сукко, 15 минут от Анапы.	44.8103	37.4392	autumn	51	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.50	2	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Анапа
528	1	Винодельня Лефкадия	Биодинамическое виноделие, сыроварня, оливковое масло. Обед на веранде с видом на виноградники.	44.7486	37.7231	autumn	79	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.50	2	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Крымск
655	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.98719	41.125524	autumn	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Армавир
656	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	45.603279	38.940311	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тимашёвск
657	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	45.601043	38.939413	spring	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тимашёвск
658	1	Смотровая «На обрыве»	Панорама на горы и море.	45.622522	38.939128	summer	61	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тимашёвск
659	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	46.131556	39.779434	spring	62	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Павловская
660	1	Парк «Старый»	Зелень, скамейки, фонтан.	46.13039	39.801825	spring	62	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Павловская
661	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.970145	37.258015	summer	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Витязево
662	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	44.999214	37.264545	spring	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Витязево
529	1	Роза Хутор	Горный курорт. Зимой лыжи, летом трекинг. Набережная как в Австрии, подъёмник на Роза Пик 2320м.	43.6615	40.304	winter	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.67	3	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Красная Поляна
527	1	33 водопада	Каскад водопадов в ущелье Джегош. Лёгкая тропа вдоль ручья, купель внизу. Мокро, скользко, красиво.	43.8383	39.5583	spring	54	\N	\N	\N	\N	f	\N	\N	\N	\N	f	4.50	2	2026-03-22 00:47:20.253676+00	2026-03-22 04:54:03.266556+00	Сочи
652	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	44.714298	37.784674	spring	59	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новороссийск
653	1	Пляж «Золотой»	Чистая вода, галька.	44.984264	41.119332	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Армавир
663	1	Пляж «Дикий»	Чистая вода, галька.	44.976877	37.2695	summer	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Витязево
664	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.000676	37.278102	autumn	63	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Витязево
654	1	Пляж «Лазурный»	Чистая вода, галька.	45.016194	41.140965	summer	60	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Армавир
665	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	44.326064	38.684789	autumn	64	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Джубга
666	1	Кафе «Веранда»	Кофе, выпечка, вид.	44.303082	38.694645	summer	64	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Джубга
667	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	43.677718	39.662218	autumn	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Дагомыс
668	1	Ресторан «Домашний»	Местная кухня, свежие продукты.	43.644611	39.640801	summer	65	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Дагомыс
669	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	45.226574	39.681742	spring	66	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Усть-Лабинск
670	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	45.222201	39.68956	summer	66	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Усть-Лабинск
671	1	Пляж «Тихий»	Чистая вода, галька.	45.208335	39.680051	summer	66	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Усть-Лабинск
672	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	45.125209	39.416512	spring	67	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Васюринская
673	1	Пляж «Дикий»	Чистая вода, галька.	45.126975	39.422986	summer	67	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Васюринская
696	1	Гостиница «Южная»	Чисто, тихо, завтрак включён.	45.597556	39.677269	summer	75	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Выселки
697	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.590726	39.64872	autumn	75	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Выселки
698	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	45.592506	39.645112	autumn	75	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Выселки
699	1	Водопад «Безымянный»	Каскад в ущелье, тропа лёгкая.	44.918328	38.840484	spring	76	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Афипский
700	1	Кафе «Веранда»	Кофе, выпечка, вид.	44.915982	38.844875	summer	76	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Афипский
701	1	Водопад «Безымянный»	Каскад в ущелье, тропа лёгкая.	44.92372	38.849891	spring	76	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Афипский
702	1	Парк «Городской»	Зелень, скамейки, фонтан.	44.872053	38.695372	spring	77	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Северская
703	1	Пляж «Центральный»	Чистая вода, галька.	44.841726	38.679737	summer	77	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Северская
704	1	Кафе «Веранда»	Кофе, выпечка, вид.	44.853071	38.672262	summer	77	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Северская
705	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	44.856299	38.545094	autumn	78	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ильский
706	1	Заправка «Газпром»	Лукойл, круглосуточно.	44.858645	38.564574	summer	78	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ильский
707	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.928548	37.988892	autumn	79	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Крымск
708	1	Парк «Приморский»	Зелень, скамейки, фонтан.	44.938877	37.970801	spring	79	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Крымск
709	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	44.892754	40.578899	autumn	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Курганинск
710	1	Кафе «Бриз»	Кофе, выпечка, вид.	44.884898	40.607528	summer	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Курганинск
711	1	Парк «Приморский»	Зелень, скамейки, фонтан.	44.893205	40.598646	spring	80	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Курганинск
712	1	Пляж «Лазурный»	Чистая вода, галька.	45.484176	38.664617	summer	81	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Калининская
713	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.487978	38.659353	autumn	81	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Калининская
714	1	Храм «Троицкий»	Старинный, тихий, красивый.	45.500706	38.675394	autumn	81	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Калининская
715	1	Заправка «Лукойл»	Лукойл, круглосуточно.	45.499591	38.67337	summer	81	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Калининская
716	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.79231	38.983018	summer	82	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Брюховецкая
717	1	Гостиница «Южная»	Чисто, тихо, завтрак включён.	45.785594	39.019286	summer	82	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Брюховецкая
718	1	Кафе «Лаванда»	Кофе, выпечка, вид.	45.853673	39.027786	summer	83	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Переясловская
719	1	Парк «Старый»	Зелень, скамейки, фонтан.	45.839517	39.036529	spring	83	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Переясловская
720	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.838419	39.023525	autumn	83	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Переясловская
721	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	46.091471	38.955909	spring	84	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Каневская
722	1	Храм «Покровский»	Старинный, тихий, красивый.	46.074207	38.985477	autumn	84	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Каневская
723	1	Заправка «Роснефть»	Лукойл, круглосуточно.	46.06739	38.967304	summer	84	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Каневская
724	1	Пляж «Центральный»	Чистая вода, галька.	46.113901	38.990398	summer	85	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Стародеревянковская
725	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	46.124589	38.96672	spring	85	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Стародеревянковская
726	1	Смотровая «Панорама»	Панорама на горы и море.	45.129088	37.647497	summer	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Варениковская
727	1	Пляж «Лазурный»	Чистая вода, галька.	45.133229	37.631904	summer	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Варениковская
728	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	45.129867	37.63342	autumn	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Варениковская
729	1	Смотровая «На обрыве»	Панорама на горы и море.	45.106365	37.658367	summer	86	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Варениковская
730	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.216537	37.152446	summer	87	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старотитаровская
731	1	Пляж «Дикий»	Чистая вода, галька.	45.223914	37.149703	summer	87	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старотитаровская
732	1	Смотровая «Орлиная»	Панорама на горы и море.	45.204806	37.13497	summer	87	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старотитаровская
733	1	Парк «Детский»	Зелень, скамейки, фонтан.	45.365072	40.202969	spring	88	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тбилисская
734	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.367087	40.191269	autumn	88	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тбилисская
735	1	Парк «Городской»	Зелень, скамейки, фонтан.	45.293152	39.915811	spring	89	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ладожская
736	1	Гостиница «Южная»	Чисто, тихо, завтрак включён.	45.289554	39.936185	summer	89	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ладожская
737	1	Гостиница «Приморская»	Чисто, тихо, завтрак включён.	45.288547	39.914931	summer	89	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ладожская
738	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	45.452435	39.022064	summer	90	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Медвёдовская
739	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.451281	38.999551	autumn	90	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Медвёдовская
740	1	Ресторан «Причал»	Местная кухня, свежие продукты.	45.443828	38.999791	summer	90	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Медвёдовская
741	1	Пляж «Лазурный»	Чистая вода, галька.	45.469981	39.023426	summer	90	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Медвёдовская
742	1	Пляж «Дикий»	Чистая вода, галька.	44.86266	38.15137	summer	93	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Абинск
743	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	44.861947	38.170181	summer	93	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Абинск
744	1	Храм «Троицкий»	Старинный, тихий, красивый.	44.867776	38.163075	autumn	93	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Абинск
745	1	Кафе «Мельница»	Кофе, выпечка, вид.	44.840295	38.386229	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Холмская
746	1	Ресторан «Старый двор»	Местная кухня, свежие продукты.	44.837446	38.409974	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Холмская
747	1	Кафе «Лаванда»	Кофе, выпечка, вид.	44.824782	38.408924	summer	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Холмская
748	1	Храм «Покровский»	Старинный, тихий, красивый.	44.862362	38.410714	autumn	91	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Холмская
749	1	Водопад «Безымянный»	Каскад в ущелье, тропа лёгкая.	44.861208	38.312357	spring	92	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ахтырский
750	1	Водопад «Безымянный»	Каскад в ущелье, тропа лёгкая.	44.861287	38.280191	spring	92	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ахтырский
751	1	Ресторан «Кубанский»	Местная кухня, свежие продукты.	44.849883	38.309148	summer	92	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ахтырский
752	1	Ресторан «Домашний»	Местная кухня, свежие продукты.	44.859454	38.294997	summer	92	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ахтырский
753	1	Пляж «Тихий»	Чистая вода, галька.	46.642368	38.671749	summer	94	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старощербиновская
754	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	46.63733	38.648886	autumn	94	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старощербиновская
755	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.238695	38.955854	summer	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новотитаровская
756	1	Храм «Покровский»	Старинный, тихий, красивый.	45.233672	38.98637	autumn	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новотитаровская
757	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	45.217167	38.967553	spring	95	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новотитаровская
758	1	Пляж «Центральный»	Чистая вода, галька.	44.479796	39.740558	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Апшеронск
759	1	Ресторан «Кубанский»	Местная кухня, свежие продукты.	44.449848	39.748128	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Апшеронск
760	1	Смотровая «Панорама»	Панорама на горы и море.	44.485441	39.722618	summer	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Апшеронск
761	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	44.487378	39.716167	autumn	96	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Апшеронск
762	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.742625	38.747213	summer	98	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Роговская
763	1	Кафе «Утро»	Кофе, выпечка, вид.	45.71516	38.721518	summer	98	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Роговская
764	1	Ресторан «Кубанский»	Местная кухня, свежие продукты.	45.959738	40.688883	summer	99	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новопокровская
765	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.942547	40.724792	autumn	99	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новопокровская
766	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	45.934159	40.708042	spring	99	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новопокровская
767	1	Смотровая «На обрыве»	Панорама на горы и море.	46.068713	40.892481	summer	100	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Белая Глина
768	1	Пляж «Центральный»	Чистая вода, галька.	46.082512	40.887673	summer	100	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Белая Глина
769	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.681869	40.264628	autumn	101	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Архангельская
770	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	45.663191	40.270798	spring	101	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Архангельская
771	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.679069	40.279145	autumn	101	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Архангельская
772	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	44.86699	37.869066	spring	102	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нижнебаканская
773	1	Заправка «Роснефть»	Лукойл, круглосуточно.	44.865688	37.872692	summer	102	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нижнебаканская
774	1	Заправка «Газпром»	Лукойл, круглосуточно.	44.849377	37.846512	summer	102	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нижнебаканская
775	1	Храм «Троицкий»	Старинный, тихий, красивый.	44.892086	37.366612	autumn	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Анапская
776	1	Смотровая «На обрыве»	Панорама на горы и море.	44.893592	37.377923	summer	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Анапская
777	1	Смотровая «Горная»	Панорама на горы и море.	44.905109	37.375232	summer	103	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Анапская
778	1	Кафе «Утро»	Кофе, выпечка, вид.	44.109417	40.780302	summer	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Псебай
779	1	Парк «Старый»	Зелень, скамейки, фонтан.	44.121472	40.782991	spring	104	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Псебай
780	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	44.651372	40.724805	spring	105	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Лабинск
781	1	Парк «Детский»	Зелень, скамейки, фонтан.	44.626926	40.728851	spring	105	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Лабинск
782	1	Кафе «Утро»	Кофе, выпечка, вид.	44.643899	40.709352	summer	105	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Лабинск
783	1	Смотровая «Горная»	Панорама на горы и море.	44.406896	40.790751	summer	106	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Мостовской
784	1	Смотровая «Горная»	Панорама на горы и море.	44.426691	40.793595	summer	106	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Мостовской
785	1	Заправка «Лукойл»	Лукойл, круглосуточно.	44.41885	40.779953	summer	106	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Мостовской
786	1	Ресторан «Горный»	Местная кухня, свежие продукты.	44.405135	40.771283	summer	106	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Мостовской
787	1	Ресторан «Причал»	Местная кухня, свежие продукты.	44.356667	38.528918	summer	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Архипо-Осиповка
788	1	Гостиница «Приморская»	Чисто, тихо, завтрак включён.	44.357022	38.538777	summer	107	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Архипо-Осиповка
789	1	Водопад «Безымянный»	Каскад в ущелье, тропа лёгкая.	44.244935	38.85981	spring	108	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомихайловский
790	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	44.235968	38.844175	autumn	108	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомихайловский
791	1	Ресторан «Горный»	Местная кухня, свежие продукты.	44.235178	38.829374	summer	108	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомихайловский
792	1	Заправка «Лукойл»	Лукойл, круглосуточно.	44.263035	38.854263	summer	108	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новомихайловский
793	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	44.351932	39.713081	spring	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нефтегорск
794	1	Кафе «Мельница»	Кофе, выпечка, вид.	44.343182	39.685526	summer	109	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нефтегорск
795	1	Смотровая «Орлиная»	Панорама на горы и море.	46.320588	39.944359	summer	110	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Крыловская
796	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	46.325266	39.97055	autumn	110	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Крыловская
797	1	Парк «Детский»	Зелень, скамейки, фонтан.	46.318215	39.406227	spring	111	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ленинградская
798	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	46.309227	39.385065	autumn	111	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ленинградская
799	1	Заправка «Лукойл»	Лукойл, круглосуточно.	46.328594	38.969829	summer	112	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новоминская
800	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	46.323335	38.936736	autumn	112	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новоминская
801	1	Ресторан «Терраса»	Местная кухня, свежие продукты.	46.311732	38.959451	summer	112	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новоминская
802	1	Ресторан «Старый двор»	Местная кухня, свежие продукты.	46.333286	38.953268	summer	112	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новоминская
803	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	46.559245	39.64198	spring	113	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кущёвская
804	1	Ресторан «Старый двор»	Местная кухня, свежие продукты.	46.571873	39.62265	summer	113	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кущёвская
805	1	Пляж «Дикий»	Чистая вода, галька.	46.5845	39.608247	summer	113	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кущёвская
806	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	46.546488	39.07285	spring	114	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Староминская
807	1	Заправка «Роснефть»	Лукойл, круглосуточно.	46.550512	39.042869	summer	114	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Староминская
808	1	Заправка «Роснефть»	Лукойл, круглосуточно.	46.553977	39.052998	summer	114	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Староминская
809	1	Пляж «Лазурный»	Чистая вода, галька.	46.535362	39.048805	summer	114	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Староминская
810	1	Парк «Старый»	Зелень, скамейки, фонтан.	44.977824	40.616014	spring	115	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Михайловская
811	1	Ресторан «Горный»	Местная кухня, свежие продукты.	44.981911	40.598308	summer	115	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Михайловская
812	1	Смотровая «Орлиная»	Панорама на горы и море.	44.996886	40.593587	summer	115	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Михайловская
813	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	45.912392	40.138899	autumn	116	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Фастовецкая
814	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	45.905429	40.15697	autumn	116	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Фастовецкая
815	1	Храм «Троицкий»	Старинный, тихий, красивый.	45.930727	40.153655	autumn	116	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Фастовецкая
816	1	Смотровая «Горная»	Панорама на горы и море.	45.918522	40.154268	summer	116	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Фастовецкая
817	1	Кафе «Лаванда»	Кофе, выпечка, вид.	45.398585	40.457399	summer	117	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Казанская
818	1	Парк «Старый»	Зелень, скамейки, фонтан.	45.398452	40.437737	spring	117	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Казанская
819	1	Парк «Детский»	Зелень, скамейки, фонтан.	45.439294	40.658502	spring	118	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кавказская
820	1	Гостиница «Центральная»	Чисто, тихо, завтрак включён.	45.455933	40.687175	summer	118	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кавказская
821	1	Парк «Городской»	Зелень, скамейки, фонтан.	45.42887	40.663403	spring	118	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кавказская
822	1	Ресторан «Старый двор»	Местная кухня, свежие продукты.	45.42955	40.683517	summer	118	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кавказская
823	1	Заправка «Лукойл»	Лукойл, круглосуточно.	45.434912	37.961859	summer	119	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Петровская
824	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	45.433135	37.947274	summer	119	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Петровская
825	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	45.10781	41.043735	spring	120	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новокубанск
826	1	Гостиница «Горная»	Чисто, тихо, завтрак включён.	45.095799	41.049887	summer	120	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новокубанск
827	1	Смотровая «Панорама»	Панорама на горы и море.	45.094496	41.048688	summer	120	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новокубанск
828	1	Пляж «Центральный»	Чистая вода, галька.	45.108708	41.048025	summer	120	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Новокубанск
829	1	Пляж «Дикий»	Чистая вода, галька.	45.366822	40.702131	summer	121	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гулькевичи
830	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.375469	40.691521	summer	121	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гулькевичи
831	1	Смотровая «Горная»	Панорама на горы и море.	45.343172	40.691564	summer	121	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гулькевичи
832	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	45.372898	40.685365	summer	121	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гулькевичи
833	1	Ресторан «Причал»	Местная кухня, свежие продукты.	44.775696	41.185875	summer	122	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Советская
834	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.787466	41.184526	autumn	122	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Советская
835	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	44.780617	41.156136	autumn	122	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Советская
836	1	Гостиница «Тихая гавань»	Чисто, тихо, завтрак включён.	44.791543	41.179372	summer	122	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Советская
837	1	Пляж «Центральный»	Чистая вода, галька.	45.208111	36.734865	summer	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тамань
838	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	45.228109	36.732041	autumn	123	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Тамань
839	1	Ресторан «Горный»	Местная кухня, свежие продукты.	45.116775	38.651223	summer	124	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Марьянская
840	1	Смотровая «Орлиная»	Панорама на горы и море.	45.118049	38.655216	summer	124	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Марьянская
841	1	Ресторан «Домашний»	Местная кухня, свежие продукты.	45.111335	38.64272	summer	124	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Марьянская
842	1	Храм «Троицкий»	Старинный, тихий, красивый.	45.0971	38.63692	autumn	124	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Марьянская
843	1	Пляж «Лазурный»	Чистая вода, галька.	46.286518	39.81806	summer	125	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Октябрьская
844	1	Парк «Детский»	Зелень, скамейки, фонтан.	46.301591	39.819713	spring	125	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Октябрьская
845	1	Ресторан «Кубанский»	Местная кухня, свежие продукты.	45.377494	40.581445	summer	126	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Красносельский
846	1	Кафе «Утро»	Кофе, выпечка, вид.	45.402428	40.581469	summer	126	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Красносельский
847	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.384948	40.605789	autumn	126	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Красносельский
848	1	Кафе «Лаванда»	Кофе, выпечка, вид.	44.816992	41.386362	summer	127	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Успенское
849	1	Кафе «Уют»	Кофе, выпечка, вид.	44.81989	41.386934	summer	127	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Успенское
850	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	44.850171	41.313625	autumn	128	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Коноково
851	1	Водопад «Тихий»	Каскад в ущелье, тропа лёгкая.	44.856913	41.307173	spring	128	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Коноково
852	1	Парк «Старый»	Зелень, скамейки, фонтан.	44.854453	38.506335	spring	129	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Черноморский
853	1	Храм «Троицкий»	Старинный, тихий, красивый.	44.836552	38.505408	autumn	129	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Черноморский
854	1	Заправка «Лукойл»	Лукойл, круглосуточно.	44.847136	38.509342	summer	129	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Черноморский
855	1	Кафе «Бриз»	Кофе, выпечка, вид.	44.767484	40.639856	summer	130	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Родниковская
856	1	Смотровая «На обрыве»	Панорама на горы и море.	44.781171	40.652988	summer	130	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Родниковская
857	1	Заправка «Газпром»	Лукойл, круглосуточно.	44.752438	40.66263	summer	130	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Родниковская
858	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	44.754613	40.65609	spring	130	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Родниковская
859	1	Кафе «Мельница»	Кофе, выпечка, вид.	44.395547	41.537185	summer	131	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Отрадная
860	1	Смотровая «На обрыве»	Панорама на горы и море.	44.387589	41.510761	summer	131	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Отрадная
861	1	Кафе «Бриз»	Кофе, выпечка, вид.	45.451929	40.575652	summer	132	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кропоткин
862	1	Гостиница «Центральная»	Чисто, тихо, завтрак включён.	45.446264	40.588635	summer	132	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кропоткин
863	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	45.416126	40.572997	autumn	132	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кропоткин
864	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	45.421408	40.575575	spring	132	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кропоткин
865	1	Винодельня «Долина»	Дегустация, экскурсия по подвалам.	45.479846	39.468658	autumn	133	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кореновск
866	1	Водопад «Горный»	Каскад в ущелье, тропа лёгкая.	45.483562	39.438539	spring	133	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Кореновск
867	1	Смотровая «Панорама»	Панорама на горы и море.	45.05408	39.332744	summer	134	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старокорсунская
868	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.033671	39.319362	autumn	134	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старокорсунская
869	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	44.429872	39.54481	autumn	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Хадыженск
870	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	44.408709	39.522136	autumn	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Хадыженск
871	1	Ресторан «Горный»	Местная кухня, свежие продукты.	44.427259	39.541085	summer	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Хадыженск
872	1	Гостиница «Горная»	Чисто, тихо, завтрак включён.	44.429384	39.540643	summer	135	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Хадыженск
873	1	Кафе «Бриз»	Кофе, выпечка, вид.	45.413093	40.675736	summer	136	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гирей
874	1	Храм «Свято-Николаевский»	Старинный, тихий, красивый.	45.383966	40.670306	autumn	136	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гирей
875	1	Смотровая «Панорама»	Панорама на горы и море.	45.40917	40.642645	summer	136	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гирей
876	1	Кафе «Веранда»	Кофе, выпечка, вид.	45.393383	40.651747	summer	136	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гирей
877	1	Смотровая «Горная»	Панорама на горы и море.	44.538934	40.802648	summer	137	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Владимирская
878	1	Кафе «Мельница»	Кофе, выпечка, вид.	44.533402	40.804756	summer	137	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Владимирская
879	1	Смотровая «Орлиная»	Панорама на горы и море.	44.548806	40.823624	summer	137	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Владимирская
880	1	Кафе «Бриз»	Кофе, выпечка, вид.	45.349062	39.091404	summer	138	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старомышастовская
881	1	Храм «Троицкий»	Старинный, тихий, красивый.	45.328271	39.087271	autumn	138	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старомышастовская
882	1	Гостиница «Центральная»	Чисто, тихо, завтрак включён.	45.044004	37.506186	summer	139	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гостагаевская
883	1	Смотровая «На обрыве»	Панорама на горы и море.	45.039892	37.500542	summer	139	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Гостагаевская
884	1	Ресторан «Домашний»	Местная кухня, свежие продукты.	45.268378	38.822349	summer	140	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нововеличковская
885	1	Парк «Старый»	Зелень, скамейки, фонтан.	45.290249	38.855494	spring	140	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нововеличковская
886	1	Кафе «Мельница»	Кофе, выпечка, вид.	45.272867	38.840516	summer	140	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нововеличковская
887	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	45.292912	38.855727	spring	140	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Нововеличковская
888	1	Кафе «Уют»	Кофе, выпечка, вид.	45.255969	38.475528	summer	141	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ивановская
889	1	Кафе «Веранда»	Кофе, выпечка, вид.	45.254488	38.45568	summer	141	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ивановская
890	1	Водопад «Серебряный»	Каскад в ущелье, тропа лёгкая.	45.280813	38.467292	spring	141	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ивановская
891	1	Парк «Детский»	Зелень, скамейки, фонтан.	45.262198	38.480861	spring	141	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Ивановская
892	1	Пляж «Лазурный»	Чистая вода, галька.	45.001132	41.162553	summer	142	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старая Станица
893	1	Заправка «Газпром»	Лукойл, круглосуточно.	45.025716	41.132014	summer	142	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старая Станица
894	1	Винодельня «Кубанская»	Дегустация, экскурсия по подвалам.	45.009418	41.143739	autumn	142	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старая Станица
895	1	Парк «Городской»	Зелень, скамейки, фонтан.	45.004381	41.1494	spring	142	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Старая Станица
896	1	Заправка «Газпром»	Лукойл, круглосуточно.	43.680895	40.18745	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Красная Поляна
897	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	43.665281	40.218534	autumn	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Красная Поляна
898	1	Смотровая «Панорама»	Панорама на горы и море.	43.691576	40.202525	summer	143	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Красная Поляна
899	1	Винодельня «Южная»	Дегустация, экскурсия по подвалам.	45.366297	38.229929	autumn	144	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Полтавская
900	1	Кафе «Бриз»	Кофе, выпечка, вид.	45.353775	38.214984	summer	144	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Полтавская
901	1	Заправка «Газпром»	Лукойл, круглосуточно.	43.410369	39.936362	summer	145	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сириус
902	1	Кафе «Уют»	Кофе, выпечка, вид.	43.419287	39.939206	summer	145	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сириус
903	1	Пляж «Золотой»	Чистая вода, галька.	43.394793	39.937432	summer	145	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сириус
904	1	Кафе «Веранда»	Кофе, выпечка, вид.	43.402556	39.957683	summer	145	\N	\N	\N	\N	f	\N	\N	\N	\N	f	0.00	0	2026-03-22 04:58:11.986551+00	2026-03-22 04:58:11.986551+00	Сириус
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
1	1	524	5	Потрясающая дегустация. Розовое игристое — лучшее что я пробовал в России.	[]	2026-03-22 03:20:36.763024+00
2	3	524	4	Красиво, но много народу в выходные. Приезжайте в будни.	[]	2026-03-22 03:20:36.763024+00
3	4	524	5	Озеро, парк, вино — идеально для пары на день.	[]	2026-03-22 03:20:36.763024+00
4	1	525	5	Прыгнул с банджи. Руки тряслись, но оно того стоило.	[]	2026-03-22 03:20:36.763024+00
5	3	525	4	Мост длинный, виды огонь. Банджи не решился, но не жалею.	[]	2026-03-22 03:20:36.763024+00
6	1	526	5	Лучший парк в стране. Не преувеличение.	[]	2026-03-22 03:20:36.763024+00
7	3	526	5	Были вечером — подсветка космос. Дети в восторге от лабиринта.	[]	2026-03-22 03:20:36.763024+00
8	4	526	4	Очень красиво, но летом жарко. Берите воду.	[]	2026-03-22 03:20:36.763024+00
9	1	527	4	Мокро, скользко, но красиво. Обувь берите трекинговую.	[]	2026-03-22 03:20:36.763024+00
10	3	527	5	Купель внизу холодная, но после подъёма — самое то.	[]	2026-03-22 03:20:36.763024+00
11	1	528	5	Сыроварня и вино в одном месте. Обед на веранде — мечта.	[]	2026-03-22 03:20:36.763024+00
12	3	528	4	Вина хорошие, но дорого. Зато виды бесплатные.	[]	2026-03-22 03:20:36.763024+00
13	1	529	5	Зимой лыжи, летом треки. Набережная как в Европе.	[]	2026-03-22 03:20:36.763024+00
14	3	529	4	Дорого, но качество соответствует. Подъёмник на Пик — must.	[]	2026-03-22 03:20:36.763024+00
15	4	529	5	Лучший горный курорт России. Не Альпы, но близко.	[]	2026-03-22 03:20:36.763024+00
16	1	530	5	Рассвет на озере — одно из лучших воспоминаний за год.	[]	2026-03-22 03:20:36.763024+00
17	3	530	4	Осенью кипарисы рыжие — фото получаются нереальные.	[]	2026-03-22 03:20:36.763024+00
18	1	531	5	Узкоколейка — атмосфера. Ущелье давит масштабом.	[]	2026-03-22 03:20:36.763024+00
19	3	531	4	Дорога до Гуамки убитая, но само ущелье компенсирует.	[]	2026-03-22 03:20:36.763024+00
20	1	532	5	Мастер-класс по моцарелле — дети были в восторге.	[]	2026-03-22 03:20:36.763024+00
21	3	532	4	Козий сыр отличный. Берите сумку-холодильник, не пожалеете.	[]	2026-03-22 03:20:36.763024+00
22	4	532	5	Хозяйка душевная, козы милые, сыр вкусный. Полный набор.	[]	2026-03-22 03:20:36.763024+00
23	1	533	4	Необычный парк. Египет, Япония, средневековье — всё рядом.	[]	2026-03-22 03:20:36.763024+00
24	3	533	5	Тихо, красиво, нет толп. Идеально после пляжного безумия.	[]	2026-03-22 03:20:36.763024+00
\.


--
-- Data for Name: route_pins; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.route_pins (id, route_id, segment_id, segment_item_id, label, pin_type, lat, lng, icon, color, "position", zoom_level, is_visible, source, is_persistent, created_by, notes, created_at) FROM stdin;
1	98	\N	\N	1	experience	44.8956	37.8469	\N	\N	0	\N	t	auto	t	\N	Ферма Экзархо	2026-03-22 04:55:33.131327+00
2	98	\N	\N	2	experience	44.7486	37.7231	\N	\N	1	\N	t	auto	t	\N	Винодельня Лефкадия	2026-03-22 04:55:33.131327+00
3	98	\N	\N	3	experience	44.6977	37.5977	\N	\N	2	\N	t	auto	t	\N	Абрау-Дюрсо	2026-03-22 04:55:33.131327+00
4	98	\N	\N	4	experience	44.8103	37.4392	\N	\N	3	\N	t	auto	t	\N	Кипарисовое озеро	2026-03-22 04:55:33.131327+00
5	98	\N	\N	5	experience	44.6528	37.9336	\N	\N	4	\N	t	auto	t	\N	Старый парк в Кабардинке	2026-03-22 04:55:33.131327+00
6	98	\N	\N	6	experience	44.574085	38.070246	\N	\N	5	\N	t	auto	t	\N	Кафе «Геленджик»	2026-03-22 04:55:33.131327+00
7	98	\N	\N	7	experience	44.5611	38.0764	\N	\N	6	\N	t	auto	t	\N	Набережная Геленджика	2026-03-22 04:55:33.131327+00
\.


--
-- Data for Name: route_segments; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.route_segments (id, route_id, "position", city_id, title, description, narrative, date_from, date_to, photos, created_at) FROM stdin;
102	98	0	\N	День 1	\N	\N	2026-03-22	2026-03-22	\N	2026-03-22 04:55:33.131327+00
103	98	1	\N	День 2	\N	\N	2026-03-23	2026-03-23	\N	2026-03-22 04:55:33.131327+00
104	98	2	\N	День 3	\N	\N	2026-03-24	2026-03-24	\N	2026-03-22 04:55:33.131327+00
97	95	0	\N	День 1	\N	\N	2025-05-10	2025-05-10	\N	2026-03-22 03:58:48.998436+00
98	95	1	\N	День 2	\N	\N	2025-05-11	2025-05-11	\N	2026-03-22 03:58:48.998436+00
99	96	0	\N	День 1	\N	\N	2025-06-15	2025-06-15	\N	2026-03-22 03:58:49.031613+00
100	97	0	\N	День 1	\N	\N	2025-07-20	2025-07-20	\N	2026-03-22 03:58:49.04471+00
101	97	1	\N	День 2	\N	\N	2025-07-21	2025-07-21	\N	2026-03-22 03:58:49.04471+00
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.routes (id, author_id, title, description, cover_url, narrative, total_days, total_price, total_price_status, total_experiences, total_hotels, total_transports, share_token, params, status, created_at, updated_at) FROM stdin;
98	4	Маршрут elderly	\N	\N	Вы отправляетесь в путешествие по живописным уголкам Краснодарского края с 22 по 31 марта 2026 года. Этот маршрут идеально подходит для людей старшего возраста, которые ценят гастрономические удовольствия и предпочитают размеренный темп. Погода в это время будет пасмурной, с температурой около 5 градусов, так что не забудьте утеплиться.\n\nПервой остановкой станет Ферма Экзархо. Здесь вам предложат экскурсию по ферме, где вы сможете узнать о процессе производства козьего сыра и даже поучаствовать в мастер-классе по варке моцареллы. Не забудьте взять с собой сумку-холодильник, чтобы привезти домой свежие продукты. После этого вы отправитесь в винодельню Лефкадия, где вам предложат попробовать биодинамические вина и местные сыры на веранде с видом на виноградники. Приятный обед сделает ваш день еще более насыщенным.\n\nСледующей станет Абрау-Дюрсо — известная винодельня с дегустацией игристых вин. Обязательно посетите экскурсию по подвалам и насладитесь атмосферой этого места, а также прогуляйтесь у озера. Далее, вы направитесь к Кипарисовому озеру, где растут болотные кипарисы. Это место привлекает своей атмосферой — лучшее время для посещения — рассвет, когда здесь тихо и спокойно, а природа словно пробуждается к жизни. \n\nВ завершение дня вы сможете насладиться прогулкой по Набережной Геленджика. Здесь протянулась велодорожка вдоль бухты, а вечером набережная подсвечивается, создавая романтичную атмосферу. В рамках этого маршрута вы также сможете попробовать местную кухню в ряде кафе и ресторанов, таких как "Венеция", "Душенька" и "Старик Хинкалыч".\n\nВ общей сложности вы проедете около 106.4 км, что позволит вам насладиться красотой природы и культурными достопримечательностями края. Путешествие будет не только вкусным, но и насыщенным впечатлениями, которые останутся с вами надолго.	10	\N	fresh	7	12	1	VAxGjE6lFFU	{"pace": "balanced", "budget": "mid", "dateTo": "2026-03-31", "events": [], "offers": [], "weather": {"time": "2026-03-22T07:45", "weather": "Пасмурно", "windspeed": 13.2, "temperature": 5.3, "weathercode": 3, "winddirection": 64}, "dateFrom": "2026-03-22", "total_km": 106.4, "groupType": "elderly", "interests": ["gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 44.8956, "lng": 37.8469, "name": "Ферма Экзархо", "description": "Козий сыр, экскурсия по ферме, мастер-класс по варке моцареллы. Берите сумку-холодильник.", "distance_to_next_km": 19.0, "duration_to_next_min": 19}, {"lat": 44.7486, "lng": 37.7231, "name": "Винодельня Лефкадия", "description": "Биодинамическое виноделие, сыроварня, оливковое масло. Обед на веранде с видом на виноградники.", "distance_to_next_km": 11.4, "duration_to_next_min": 11}, {"lat": 44.6977, "lng": 37.5977, "name": "Абрау-Дюрсо", "description": "Винодельня с дегустацией игристых вин. Озеро, парк, лавка сыров. Экскурсия по подвалам — обязательно.", "distance_to_next_km": 17.7, "duration_to_next_min": 18}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": 44.8103, "lng": 37.4392, "name": "Кипарисовое озеро", "description": "Болотные кипарисы растут прямо из воды. Рассвет — лучшее время, народу никого. Сукко, 15 минут от Анапы.", "distance_to_next_km": 42.8, "duration_to_next_min": 43}, {"lat": 44.6528, "lng": 37.9336, "name": "Старый парк в Кабардинке", "description": "Архитектурный парк: египетский храм, средневековый замок, японский сад. Всё в одном месте, без толп.", "distance_to_next_km": 13.9, "duration_to_next_min": 14}, {"lat": 44.574085, "lng": 38.070246, "name": "Кафе «Геленджик»", "description": "Кофе и выпечка с видом.", "distance_to_next_km": 1.5, "duration_to_next_min": 2}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": 44.5611, "lng": 38.0764, "name": "Набережная Геленджика", "description": "7 км вдоль бухты. Велодорожка, кафе, фонтаны. Вечером подсветка.", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [], "offers": [], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-03-31", "dateFrom": "2026-03-22", "groupType": "elderly", "interests": ["gastro"], "transport": "car"}, "totalKm": 106.4, "weather": {"time": "2026-03-22T07:45", "weather": "Пасмурно", "windspeed": 13.2, "temperature": 5.3, "weathercode": 3, "winddirection": 64}, "weatherPerDay": [{"date": "2026-03-22", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-23", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-24", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-25", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-26", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-27", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-28", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-29", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-30", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-31", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}], "recommendations": [{"type": "food", "options": [{"lat": 44.8956, "lng": 37.8469, "name": "Венеция, кафе", "type": "кафе", "source": "2gis", "address": "улица Ленина, 4"}, {"lat": 44.8956, "lng": 37.8469, "name": "Душенька, кафе", "type": "кафе", "source": "2gis", "address": "улица Ленина, 1г"}, {"lat": 44.8956, "lng": 37.8469, "name": "Долина Лефкадия, ресторанный комплекс", "type": "ресторан", "source": "2gis", "address": "Степная улица, 1д"}, {"lat": 44.8956, "lng": 37.8469, "name": "Сольфасоль, караоке-рестобар", "type": "ресторан", "source": "2gis", "address": "Карла Либкнехта, 36а"}, {"lat": 44.8956, "lng": 37.8469, "name": "Тыква, кафе самообслуживания", "type": "столовая", "source": "2gis", "address": "улица Синёва, 37"}]}, {"type": "food", "options": [{"lat": 44.7486, "lng": 37.7231, "name": "Тадж Махал, чайхона", "type": "кафе", "source": "2gis", "address": "Анапское шоссе, 109"}, {"lat": 44.7486, "lng": 37.7231, "name": "Фич-хан, кафе", "type": "кафе", "source": "2gis", "address": "улица Горького, 18Б"}, {"lat": 44.7486, "lng": 37.7231, "name": "Черчилль, рестобар", "type": "ресторан", "source": "2gis", "address": "Тобольская улица, 7"}, {"lat": 44.7486, "lng": 37.7231, "name": "Локка, ресторан", "type": "ресторан", "source": "2gis", "address": "Свободы, 16а"}, {"lat": 44.7486, "lng": 37.7231, "name": "Вареничная", "type": "столовая", "source": "2gis", "address": "Анапское шоссе, 105"}]}, {"type": "food", "options": [{"lat": 44.6977, "lng": 37.5977, "name": "Вино-град, ресторан", "type": "кафе", "source": "2gis", "address": "Промышленная улица, 14"}, {"lat": 44.6977, "lng": 37.5977, "name": "Abrau Club, кафе-магазин", "type": "кафе", "source": "2gis", "address": null}, {"lat": 44.6977, "lng": 37.5977, "name": "Абрау Light, караоке-бар", "type": "ресторан", "source": "2gis", "address": "Промышленная улица, 13"}, {"lat": 44.6977, "lng": 37.5977, "name": "Seven", "type": "ресторан", "source": "2gis", "address": "Промышленная улица, 7а"}, {"lat": 44.6977, "lng": 37.5977, "name": "Столовая №1", "type": "столовая", "source": "2gis", "address": "Промышленная улица, 19"}]}, {"type": "food", "options": [{"lat": 44.8103, "lng": 37.4392, "name": "Ласточка", "type": "кафе", "source": "2gis", "address": "Речной переулок, 12Б"}, {"lat": 44.8103, "lng": 37.4392, "name": "у Давида, кафе", "type": "кафе", "source": "2gis", "address": "Советская улица, 187"}, {"lat": 44.8103, "lng": 37.4392, "name": "Кипарис, ресторан", "type": "ресторан", "source": "2gis", "address": "Речной переулок, 6Б"}, {"lat": 44.8103, "lng": 37.4392, "name": "Дельмонт, кафе", "type": "ресторан", "source": "2gis", "address": "Центральная улица, 14"}, {"lat": 44.8103, "lng": 37.4392, "name": "Рубль, столовая", "type": "столовая", "source": "2gis", "address": "Мирная улица, 9 к1"}]}, {"type": "food", "options": [{"lat": 44.6528, "lng": 37.9336, "name": "Одиссея, кафе", "type": "кафе", "source": "2gis", "address": "Приморский бульвар, 12"}, {"lat": 44.6528, "lng": 37.9336, "name": "Пита&гиро", "type": "кафе", "source": "2gis", "address": "улица Мира, 36Б"}, {"lat": 44.6528, "lng": 37.9336, "name": "Мадера, рестопаб", "type": "ресторан", "source": "2gis", "address": null}, {"lat": 44.6528, "lng": 37.9336, "name": "Дача, ресторан", "type": "ресторан", "source": "2gis", "address": "улица Мира, 13е"}, {"lat": 44.6528, "lng": 37.9336, "name": "Под шатром, столовая", "type": "столовая", "source": "2gis", "address": "Приморский бульвар, 8"}]}, {"type": "food", "options": [{"lat": 44.574085, "lng": 38.070246, "name": "Хлеба и зрелищ, кафе", "type": "кафе", "source": "2gis", "address": "Лермонтовский бульвар, 6/2"}, {"lat": 44.574085, "lng": 38.070246, "name": "Парасоль, кафе", "type": "кафе", "source": "2gis", "address": "Приморский бульвар, 7"}, {"lat": 44.574085, "lng": 38.070246, "name": "Цех, ресторан", "type": "ресторан", "source": "2gis", "address": "Мира, 44 лит6"}, {"lat": 44.574085, "lng": 38.070246, "name": "Rony Oyster, ресторан", "type": "ресторан", "source": "2gis", "address": "Лермонтовский бульвар, 18"}, {"lat": 44.574085, "lng": 38.070246, "name": "Столовая №7", "type": "столовая", "source": "2gis", "address": "Горная улица, 5"}]}, {"type": "food", "options": [{"lat": 44.5611, "lng": 38.0764, "name": "Старик Хинкалыч, хинкальная", "type": "кафе", "source": "2gis", "address": "улица Ленина, 16"}, {"lat": 44.5611, "lng": 38.0764, "name": "Любокофе, кофейня", "type": "кафе", "source": "2gis", "address": "улица Ленина, 1"}, {"lat": 44.5611, "lng": 38.0764, "name": "Ваха Лавка, грузинский ресторан", "type": "ресторан", "source": "2gis", "address": "улица Островского, 2а"}, {"lat": 44.5611, "lng": 38.0764, "name": "La сosta, ресторан", "type": "ресторан", "source": "2gis", "address": "Революционная улица, 11"}, {"lat": 44.5611, "lng": 38.0764, "name": "Щи-Борщи, столовая", "type": "столовая", "source": "2gis", "address": "улица Ленина, 3"}]}]}, "weatherPerDay": [{"date": "2026-03-22", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-23", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-24", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-25", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-26", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-27", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-28", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-29", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-30", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}, {"date": "2026-03-31", "icon": 3, "tempC": 5.3, "weather": "Пасмурно"}]}	ready	2026-03-22 04:55:33.091903+00	2026-03-22 04:55:54.601533+00
97	1	Горный трекинг	\N	\N	Маршрут для тех, кто приехал не загорать, а ходить. В первый день — Гуамское ущелье: узкий каньон с отвесными скалами и узкоколейкой, один из самых впечатляющих пеших маршрутов края. Здесь можно провести несколько часов, двигаясь вдоль реки Курджипс. Потом — 33 водопада, чтобы закрыть первый день купанием и отдыхом у воды. Ночёвка в Хосте или Лазаревском.\n\nНа второй день — Роза Хутор, но не как курорт, а как база для выхода в горы. Летом тропы открыты до высоты 2200 м, виды на Главный Кавказский хребет компенсируют усталость в ногах. Суммарный набор высоты за два дня — около 1500 м. Берите треккинговые палки и запас воды.	2	\N	fresh	3	0	0	demo-mountain-trek	{"pace": "active", "budget": "low", "groupType": "friends", "interests": ["hiking", "nature", "mountains"], "transport": "none"}	ready	2026-03-22 03:58:49.04471+00	2026-03-22 03:58:49.04471+00
96	1	Семейный день в Сочи	\N	\N	Один насыщенный день, который понравится и взрослым, и детям. Начните с SkyPark — самого длинного пешеходного подвесного моста в мире, откуда открывается вид на реку Мзымта и горные склоны. Дети будут в восторге, а взрослые успеют сделать фотографии, которые не стыдно показать. Потом — 33 водопада в Хосте: короткий маршрут по ущелью с каскадами и прохладой, где можно перекусить и отдохнуть.\n\nЗавершить день стоит на Роза Хутор: летом здесь работают подъёмники в горы, пешеходные тропы и набережная с ресторанами. Суммарный путь на машине — около 60 км, большая часть по живописной дороге вдоль гор. Выезжайте пораньше: у водопадов и SkyPark в выходные бывают очереди.	1	\N	fresh	3	0	0	demo-family-sochi	{"pace": "balanced", "budget": "mid", "groupType": "family", "interests": ["nature", "family", "adventure"], "transport": "car"}	ready	2026-03-22 03:58:49.031613+00	2026-03-22 03:58:49.031613+00
95	1	Винный weekend для двоих	\N	\N	Этот маршрут создан для тех, кто хочет провести выходные в окружении виноградников, тихих горных дорог и вкусной еды. Вы начнёте с Абрау-Дюрсо — одного из старейших винодельческих хозяйств России, где можно продегустировать игристые вина прямо у берега озера. Затем вас ждёт Лефкадия с её бутиковыми сортами и живописными терруарами, а вечер завершится на ферме Экзархо, где готовят блюда из собственного хозяйства.\n\nНа второй день маршрут становится спокойнее: прогулка у Кипарисового озера с его особенной атмосферой южной природы, а финалом станет Старый парк в Кабардинке — место с вековыми деревьями и скульптурами, где хорошо просто сидеть и разговаривать. Примерный путь на машине — около 120 км за два дня, без спешки.	2	\N	fresh	5	0	0	demo-wine-weekend	{"pace": "relaxed", "budget": "mid", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	ready	2026-03-22 03:58:48.998436+00	2026-03-22 03:58:48.998436+00
\.


--
-- Data for Name: segment_items; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.segment_items (id, segment_id, parent_id, type, "position", price, price_currency, price_original, price_fetched_at, price_status, provider_name, provider_url, ai_comment, details, created_at) FROM stdin;
339	98	337	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Старый парк в Кабардинке\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336, \\"post_id\\": 533, \\"description\\": \\"Архитектурный парк: египетский храм, средневековый замок, японский сад. Всё в одном месте, без толп.\\"}"	2026-03-22 03:58:48.998436+00
341	99	340	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Skypark AJ Hackett Сочи\\", \\"lat\\": 43.5281, \\"lng\\": 40.0206, \\"post_id\\": 525, \\"description\\": \\"Банджи-джампинг 207 метров, самый длинный подвесной мост в мире. Ахштырское ущелье под ногами.\\"}"	2026-03-22 03:58:49.031613+00
342	99	340	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"33 водопада\\", \\"lat\\": 43.8383, \\"lng\\": 39.5583, \\"post_id\\": 527, \\"description\\": \\"Каскад водопадов в ущелье Джегош. Лёгкая тропа вдоль ручья, купель внизу. Мокро, скользко, красиво.\\"}"	2026-03-22 03:58:49.031613+00
343	99	340	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Роза Хутор\\", \\"lat\\": 43.6615, \\"lng\\": 40.304, \\"post_id\\": 529, \\"description\\": \\"Горный курорт. Зимой лыжи, летом трекинг. Набережная как в Австрии, подъёмник на Роза Пик 2320м.\\"}"	2026-03-22 03:58:49.031613+00
344	100	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"label\\": \\"День 1\\"}"	2026-03-22 03:58:49.04471+00
345	100	344	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Гуамское ущелье\\", \\"lat\\": 44.2458, \\"lng\\": 39.9217, \\"post_id\\": 531, \\"description\\": \\"Узкоколейка по краю обрыва 400 метров. Поезд идёт медленно, можно снимать. Скалы, река Курджипс.\\"}"	2026-03-22 03:58:49.04471+00
346	100	344	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"33 водопада\\", \\"lat\\": 43.8383, \\"lng\\": 39.5583, \\"post_id\\": 527, \\"description\\": \\"Каскад водопадов в ущелье Джегош. Лёгкая тропа вдоль ручья, купель внизу. Мокро, скользко, красиво.\\"}"	2026-03-22 03:58:49.04471+00
347	101	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"label\\": \\"День 2\\"}"	2026-03-22 03:58:49.04471+00
349	102	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"day_number\\": 1, \\"date\\": \\"2026-03-22\\", \\"title\\": \\"\\\\u0414\\\\u0435\\\\u043d\\\\u044c 1\\", \\"experience_count\\": 3}"	2026-03-22 04:55:33.131327+00
353	103	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"day_number\\": 2, \\"date\\": \\"2026-03-23\\", \\"title\\": \\"\\\\u0414\\\\u0435\\\\u043d\\\\u044c 2\\", \\"experience_count\\": 3}"	2026-03-22 04:55:33.131327+00
357	104	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"day_number\\": 3, \\"date\\": \\"2026-03-24\\", \\"title\\": \\"\\\\u0414\\\\u0435\\\\u043d\\\\u044c 3\\", \\"experience_count\\": 1}"	2026-03-22 04:55:33.131327+00
358	104	357	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041d\\\\u0430\\\\u0431\\\\u0435\\\\u0440\\\\u0435\\\\u0436\\\\u043d\\\\u0430\\\\u044f \\\\u0413\\\\u0435\\\\u043b\\\\u0435\\\\u043d\\\\u0434\\\\u0436\\\\u0438\\\\u043a\\\\u0430\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764, \\"post_id\\": 536, \\"description\\": \\"7 \\\\u043a\\\\u043c \\\\u0432\\\\u0434\\\\u043e\\\\u043b\\\\u044c \\\\u0431\\\\u0443\\\\u0445\\\\u0442\\\\u044b. \\\\u0412\\\\u0435\\\\u043b\\\\u043e\\\\u0434\\\\u043e\\\\u0440\\\\u043e\\\\u0436\\\\u043a\\\\u0430, \\\\u043a\\\\u0430\\\\u0444\\\\u0435, \\\\u0444\\\\u043e\\\\u043d\\\\u0442\\\\u0430\\\\u043d\\\\u044b. \\\\u0412\\\\u0435\\\\u0447\\\\u0435\\\\u0440\\\\u043e\\\\u043c \\\\u043f\\\\u043e\\\\u0434\\\\u0441\\\\u0432\\\\u0435\\\\u0442\\\\u043a\\\\u0430.\\", \\"time\\": \\"09:00\\", \\"duration_min\\": 90}"	2026-03-22 04:55:33.131327+00
350	102	349	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0424\\\\u0435\\\\u0440\\\\u043c\\\\u0430 \\\\u042d\\\\u043a\\\\u0437\\\\u0430\\\\u0440\\\\u0445\\\\u043e\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469, \\"post_id\\": 532, \\"description\\": \\"\\\\u041a\\\\u043e\\\\u0437\\\\u0438\\\\u0439 \\\\u0441\\\\u044b\\\\u0440, \\\\u044d\\\\u043a\\\\u0441\\\\u043a\\\\u0443\\\\u0440\\\\u0441\\\\u0438\\\\u044f \\\\u043f\\\\u043e \\\\u0444\\\\u0435\\\\u0440\\\\u043c\\\\u0435, \\\\u043c\\\\u0430\\\\u0441\\\\u0442\\\\u0435\\\\u0440-\\\\u043a\\\\u043b\\\\u0430\\\\u0441\\\\u0441 \\\\u043f\\\\u043e \\\\u0432\\\\u0430\\\\u0440\\\\u043a\\\\u0435 \\\\u043c\\\\u043e\\\\u0446\\\\u0430\\\\u0440\\\\u0435\\\\u043b\\\\u043b\\\\u044b. \\\\u0411\\\\u0435\\\\u0440\\\\u0438\\\\u0442\\\\u0435 \\\\u0441\\\\u0443\\\\u043c\\\\u043a\\\\u0443-\\\\u0445\\\\u043e\\\\u043b\\\\u043e\\\\u0434\\\\u0438\\\\u043b\\\\u044c\\\\u043d\\\\u0438\\\\u043a.\\", \\"time\\": \\"09:00\\", \\"duration_min\\": 90, \\"distance_to_next_km\\": 19.0, \\"duration_to_next_min\\": 19, \\"transport_to_next\\": \\"car\\", \\"distance_source\\": \\"haversine\\"}"	2026-03-22 04:55:33.131327+00
351	102	349	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u041b\\\\u0435\\\\u0444\\\\u043a\\\\u0430\\\\u0434\\\\u0438\\\\u044f\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231, \\"post_id\\": 528, \\"description\\": \\"\\\\u0411\\\\u0438\\\\u043e\\\\u0434\\\\u0438\\\\u043d\\\\u0430\\\\u043c\\\\u0438\\\\u0447\\\\u0435\\\\u0441\\\\u043a\\\\u043e\\\\u0435 \\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u0438\\\\u0435, \\\\u0441\\\\u044b\\\\u0440\\\\u043e\\\\u0432\\\\u0430\\\\u0440\\\\u043d\\\\u044f, \\\\u043e\\\\u043b\\\\u0438\\\\u0432\\\\u043a\\\\u043e\\\\u0432\\\\u043e\\\\u0435 \\\\u043c\\\\u0430\\\\u0441\\\\u043b\\\\u043e. \\\\u041e\\\\u0431\\\\u0435\\\\u0434 \\\\u043d\\\\u0430 \\\\u0432\\\\u0435\\\\u0440\\\\u0430\\\\u043d\\\\u0434\\\\u0435 \\\\u0441 \\\\u0432\\\\u0438\\\\u0434\\\\u043e\\\\u043c \\\\u043d\\\\u0430 \\\\u0432\\\\u0438\\\\u043d\\\\u043e\\\\u0433\\\\u0440\\\\u0430\\\\u0434\\\\u043d\\\\u0438\\\\u043a\\\\u0438.\\", \\"time\\": \\"11:00\\", \\"duration_min\\": 90, \\"distance_to_next_km\\": 11.4, \\"duration_to_next_min\\": 11, \\"transport_to_next\\": \\"car\\", \\"distance_source\\": \\"haversine\\"}"	2026-03-22 04:55:33.131327+00
356	103	353	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0430\\\\u0444\\\\u0435 \\\\u00ab\\\\u0413\\\\u0435\\\\u043b\\\\u0435\\\\u043d\\\\u0434\\\\u0436\\\\u0438\\\\u043a\\\\u00bb\\", \\"lat\\": 44.574085, \\"lng\\": 38.070246, \\"post_id\\": 602, \\"description\\": \\"\\\\u041a\\\\u043e\\\\u0444\\\\u0435 \\\\u0438 \\\\u0432\\\\u044b\\\\u043f\\\\u0435\\\\u0447\\\\u043a\\\\u0430 \\\\u0441 \\\\u0432\\\\u0438\\\\u0434\\\\u043e\\\\u043c.\\", \\"time\\": \\"13:00\\", \\"duration_min\\": 90, \\"distance_to_next_km\\": 1.5, \\"duration_to_next_min\\": 2, \\"transport_to_next\\": \\"car\\", \\"distance_source\\": \\"haversine\\"}"	2026-03-22 04:55:33.131327+00
359	102	\N	leg	-3	6157	RUB	\N	\N	fresh	DP	https://www.aviasales.ru/search/MOW2403KRR1?t=DP17743464001774360800000240VKOKRR_b7bcb628bf10c7ff389edec775ab76e1_6157&search_date=22032026&expected_price_uuid=019d13b6-7301-8030-23d8-948c42640549&static_fare_key=TY%7CP0%7CH1%7CL0%7CCH1%7CR0%7CTBC0&expected_price_source=share&expected_price_currency=rub&expected_price=6157	\N	"{\\"from\\": \\"MOW\\", \\"to\\": \\"KRR\\", \\"transport\\": \\"plane\\", \\"duration_min\\": 240, \\"stops\\": 0, \\"departure_at\\": \\"2026-03-24T10:00:00+03:00\\", \\"carrier\\": \\"DP\\", \\"flight_number\\": \\"157\\"}"	2026-03-22 04:55:33.204802+00
360	102	\N	leg	-2	6157	RUB	\N	\N	fresh	DP	https://www.aviasales.ru/search/MOW2603KRR1?t=DP17745183001774532700000240VKOKRR_fdabdf5789d2fddc015f3beffbb1ce8e_6157&search_date=22032026&expected_price_uuid=019d13d5-6588-8030-2370-0104c58009e0&static_fare_key=TY%7CP0%7CH1%7CL0%7CCH1%7CR0%7CTBC0&expected_price_source=share&expected_price_currency=rub&expected_price=6157	\N	"{\\"from\\": \\"MOW\\", \\"to\\": \\"KRR\\", \\"transport\\": \\"plane\\", \\"duration_min\\": 240, \\"stops\\": 0, \\"departure_at\\": \\"2026-03-26T09:45:00+03:00\\", \\"carrier\\": \\"DP\\", \\"flight_number\\": \\"155\\"}"	2026-03-22 04:55:33.204802+00
361	102	\N	leg	-1	6162	RUB	\N	\N	fresh	U6	https://www.aviasales.ru/search/MOW2503KRR1?t=U617744364001774450800000240DMEKRR_80e58fb0ad0b8ba5acb4b6d2f3da4041_6162&search_date=22032026&expected_price_uuid=019d13cf-0b7c-8030-e72a-cec63c073eb5&static_fare_key=TY%7CP0%7CH1%7CL0%7CCH1_0%7CR0%7CTBC0&expected_price_source=share&expected_price_currency=rub&expected_price=6162	\N	"{\\"from\\": \\"MOW\\", \\"to\\": \\"KRR\\", \\"transport\\": \\"plane\\", \\"duration_min\\": 240, \\"stops\\": 0, \\"departure_at\\": \\"2026-03-25T11:00:00+03:00\\", \\"carrier\\": \\"U6\\", \\"flight_number\\": \\"109\\"}"	2026-03-22 04:55:33.204802+00
352	102	349	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0410\\\\u0431\\\\u0440\\\\u0430\\\\u0443-\\\\u0414\\\\u044e\\\\u0440\\\\u0441\\\\u043e\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977, \\"post_id\\": 524, \\"description\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e\\\\u0434\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u044f \\\\u0441 \\\\u0434\\\\u0435\\\\u0433\\\\u0443\\\\u0441\\\\u0442\\\\u0430\\\\u0446\\\\u0438\\\\u0435\\\\u0439 \\\\u0438\\\\u0433\\\\u0440\\\\u0438\\\\u0441\\\\u0442\\\\u044b\\\\u0445 \\\\u0432\\\\u0438\\\\u043d. \\\\u041e\\\\u0437\\\\u0435\\\\u0440\\\\u043e, \\\\u043f\\\\u0430\\\\u0440\\\\u043a, \\\\u043b\\\\u0430\\\\u0432\\\\u043a\\\\u0430 \\\\u0441\\\\u044b\\\\u0440\\\\u043e\\\\u0432. \\\\u042d\\\\u043a\\\\u0441\\\\u043a\\\\u0443\\\\u0440\\\\u0441\\\\u0438\\\\u044f \\\\u043f\\\\u043e \\\\u043f\\\\u043e\\\\u0434\\\\u0432\\\\u0430\\\\u043b\\\\u0430\\\\u043c \\\\u2014 \\\\u043e\\\\u0431\\\\u044f\\\\u0437\\\\u0430\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\\\u043d\\\\u043e.\\", \\"time\\": \\"13:00\\", \\"duration_min\\": 90, \\"distance_to_next_km\\": 17.7, \\"duration_to_next_min\\": 18, \\"transport_to_next\\": \\"car\\", \\"distance_source\\": \\"haversine\\"}"	2026-03-22 04:55:33.131327+00
354	103	353	experience	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u041a\\\\u0438\\\\u043f\\\\u0430\\\\u0440\\\\u0438\\\\u0441\\\\u043e\\\\u0432\\\\u043e\\\\u0435 \\\\u043e\\\\u0437\\\\u0435\\\\u0440\\\\u043e\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392, \\"post_id\\": 530, \\"description\\": \\"\\\\u0411\\\\u043e\\\\u043b\\\\u043e\\\\u0442\\\\u043d\\\\u044b\\\\u0435 \\\\u043a\\\\u0438\\\\u043f\\\\u0430\\\\u0440\\\\u0438\\\\u0441\\\\u044b \\\\u0440\\\\u0430\\\\u0441\\\\u0442\\\\u0443\\\\u0442 \\\\u043f\\\\u0440\\\\u044f\\\\u043c\\\\u043e \\\\u0438\\\\u0437 \\\\u0432\\\\u043e\\\\u0434\\\\u044b. \\\\u0420\\\\u0430\\\\u0441\\\\u0441\\\\u0432\\\\u0435\\\\u0442 \\\\u2014 \\\\u043b\\\\u0443\\\\u0447\\\\u0448\\\\u0435\\\\u0435 \\\\u0432\\\\u0440\\\\u0435\\\\u043c\\\\u044f, \\\\u043d\\\\u0430\\\\u0440\\\\u043e\\\\u0434\\\\u0443 \\\\u043d\\\\u0438\\\\u043a\\\\u043e\\\\u0433\\\\u043e. \\\\u0421\\\\u0443\\\\u043a\\\\u043a\\\\u043e, 15 \\\\u043c\\\\u0438\\\\u043d\\\\u0443\\\\u0442 \\\\u043e\\\\u0442 \\\\u0410\\\\u043d\\\\u0430\\\\u043f\\\\u044b.\\", \\"time\\": \\"09:00\\", \\"duration_min\\": 90, \\"distance_to_next_km\\": 42.8, \\"duration_to_next_min\\": 43, \\"transport_to_next\\": \\"car\\", \\"distance_source\\": \\"haversine\\"}"	2026-03-22 04:55:33.131327+00
355	103	353	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u0430\\\\u0440\\\\u044b\\\\u0439 \\\\u043f\\\\u0430\\\\u0440\\\\u043a \\\\u0432 \\\\u041a\\\\u0430\\\\u0431\\\\u0430\\\\u0440\\\\u0434\\\\u0438\\\\u043d\\\\u043a\\\\u0435\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336, \\"post_id\\": 533, \\"description\\": \\"\\\\u0410\\\\u0440\\\\u0445\\\\u0438\\\\u0442\\\\u0435\\\\u043a\\\\u0442\\\\u0443\\\\u0440\\\\u043d\\\\u044b\\\\u0439 \\\\u043f\\\\u0430\\\\u0440\\\\u043a: \\\\u0435\\\\u0433\\\\u0438\\\\u043f\\\\u0435\\\\u0442\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0445\\\\u0440\\\\u0430\\\\u043c, \\\\u0441\\\\u0440\\\\u0435\\\\u0434\\\\u043d\\\\u0435\\\\u0432\\\\u0435\\\\u043a\\\\u043e\\\\u0432\\\\u044b\\\\u0439 \\\\u0437\\\\u0430\\\\u043c\\\\u043e\\\\u043a, \\\\u044f\\\\u043f\\\\u043e\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0441\\\\u0430\\\\u0434. \\\\u0412\\\\u0441\\\\u0451 \\\\u0432 \\\\u043e\\\\u0434\\\\u043d\\\\u043e\\\\u043c \\\\u043c\\\\u0435\\\\u0441\\\\u0442\\\\u0435, \\\\u0431\\\\u0435\\\\u0437 \\\\u0442\\\\u043e\\\\u043b\\\\u043f.\\", \\"time\\": \\"11:00\\", \\"duration_min\\": 90, \\"distance_to_next_km\\": 13.9, \\"duration_to_next_min\\": 14, \\"transport_to_next\\": \\"car\\", \\"distance_source\\": \\"haversine\\"}"	2026-03-22 04:55:33.131327+00
362	102	350	experience	1000	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u0412\\\\u0435\\\\u043d\\\\u0435\\\\u0446\\\\u0438\\\\u044f, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041b\\\\u0435\\\\u043d\\\\u0438\\\\u043d\\\\u0430, 4\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0414\\\\u0443\\\\u0448\\\\u0435\\\\u043d\\\\u044c\\\\u043a\\\\u0430, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041b\\\\u0435\\\\u043d\\\\u0438\\\\u043d\\\\u0430, 1\\\\u0433\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0414\\\\u043e\\\\u043b\\\\u0438\\\\u043d\\\\u0430 \\\\u041b\\\\u0435\\\\u0444\\\\u043a\\\\u0430\\\\u0434\\\\u0438\\\\u044f, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\\\u043d\\\\u044b\\\\u0439 \\\\u043a\\\\u043e\\\\u043c\\\\u043f\\\\u043b\\\\u0435\\\\u043a\\\\u0441\\", \\"address\\": \\"\\\\u0421\\\\u0442\\\\u0435\\\\u043f\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 1\\\\u0434\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0421\\\\u043e\\\\u043b\\\\u044c\\\\u0444\\\\u0430\\\\u0441\\\\u043e\\\\u043b\\\\u044c, \\\\u043a\\\\u0430\\\\u0440\\\\u0430\\\\u043e\\\\u043a\\\\u0435-\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0431\\\\u0430\\\\u0440\\", \\"address\\": \\"\\\\u041a\\\\u0430\\\\u0440\\\\u043b\\\\u0430 \\\\u041b\\\\u0438\\\\u0431\\\\u043a\\\\u043d\\\\u0435\\\\u0445\\\\u0442\\\\u0430, 36\\\\u0430\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0422\\\\u044b\\\\u043a\\\\u0432\\\\u0430, \\\\u043a\\\\u0430\\\\u0444\\\\u0435 \\\\u0441\\\\u0430\\\\u043c\\\\u043e\\\\u043e\\\\u0431\\\\u0441\\\\u043b\\\\u0443\\\\u0436\\\\u0438\\\\u0432\\\\u0430\\\\u043d\\\\u0438\\\\u044f\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u0421\\\\u0438\\\\u043d\\\\u0451\\\\u0432\\\\u0430, 37\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}]}"	2026-03-22 04:55:35.045705+00
363	102	351	experience	1001	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u0422\\\\u0430\\\\u0434\\\\u0436 \\\\u041c\\\\u0430\\\\u0445\\\\u0430\\\\u043b, \\\\u0447\\\\u0430\\\\u0439\\\\u0445\\\\u043e\\\\u043d\\\\u0430\\", \\"address\\": \\"\\\\u0410\\\\u043d\\\\u0430\\\\u043f\\\\u0441\\\\u043a\\\\u043e\\\\u0435 \\\\u0448\\\\u043e\\\\u0441\\\\u0441\\\\u0435, 109\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231}, {\\"name\\": \\"\\\\u0424\\\\u0438\\\\u0447-\\\\u0445\\\\u0430\\\\u043d, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u0413\\\\u043e\\\\u0440\\\\u044c\\\\u043a\\\\u043e\\\\u0433\\\\u043e, 18\\\\u0411\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231}, {\\"name\\": \\"\\\\u0427\\\\u0435\\\\u0440\\\\u0447\\\\u0438\\\\u043b\\\\u043b\\\\u044c, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0431\\\\u0430\\\\u0440\\", \\"address\\": \\"\\\\u0422\\\\u043e\\\\u0431\\\\u043e\\\\u043b\\\\u044c\\\\u0441\\\\u043a\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 7\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231}, {\\"name\\": \\"\\\\u041b\\\\u043e\\\\u043a\\\\u043a\\\\u0430, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u0421\\\\u0432\\\\u043e\\\\u0431\\\\u043e\\\\u0434\\\\u044b, 16\\\\u0430\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231}, {\\"name\\": \\"\\\\u0412\\\\u0430\\\\u0440\\\\u0435\\\\u043d\\\\u0438\\\\u0447\\\\u043d\\\\u0430\\\\u044f\\", \\"address\\": \\"\\\\u0410\\\\u043d\\\\u0430\\\\u043f\\\\u0441\\\\u043a\\\\u043e\\\\u0435 \\\\u0448\\\\u043e\\\\u0441\\\\u0441\\\\u0435, 105\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231}]}"	2026-03-22 04:55:35.045705+00
364	102	352	experience	1002	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043d\\\\u043e-\\\\u0433\\\\u0440\\\\u0430\\\\u0434, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u043e\\\\u043c\\\\u044b\\\\u0448\\\\u043b\\\\u0435\\\\u043d\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 14\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977}, {\\"name\\": \\"Abrau Club, \\\\u043a\\\\u0430\\\\u0444\\\\u0435-\\\\u043c\\\\u0430\\\\u0433\\\\u0430\\\\u0437\\\\u0438\\\\u043d\\", \\"address\\": null, \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977}, {\\"name\\": \\"\\\\u0410\\\\u0431\\\\u0440\\\\u0430\\\\u0443 Light, \\\\u043a\\\\u0430\\\\u0440\\\\u0430\\\\u043e\\\\u043a\\\\u0435-\\\\u0431\\\\u0430\\\\u0440\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u043e\\\\u043c\\\\u044b\\\\u0448\\\\u043b\\\\u0435\\\\u043d\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 13\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977}, {\\"name\\": \\"Seven\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u043e\\\\u043c\\\\u044b\\\\u0448\\\\u043b\\\\u0435\\\\u043d\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 7\\\\u0430\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977}, {\\"name\\": \\"\\\\u0421\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f \\\\u21161\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u043e\\\\u043c\\\\u044b\\\\u0448\\\\u043b\\\\u0435\\\\u043d\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 19\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977}]}"	2026-03-22 04:55:35.045705+00
365	103	354	experience	1003	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u041b\\\\u0430\\\\u0441\\\\u0442\\\\u043e\\\\u0447\\\\u043a\\\\u0430\\", \\"address\\": \\"\\\\u0420\\\\u0435\\\\u0447\\\\u043d\\\\u043e\\\\u0439 \\\\u043f\\\\u0435\\\\u0440\\\\u0435\\\\u0443\\\\u043b\\\\u043e\\\\u043a, 12\\\\u0411\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"\\\\u0443 \\\\u0414\\\\u0430\\\\u0432\\\\u0438\\\\u0434\\\\u0430, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u0421\\\\u043e\\\\u0432\\\\u0435\\\\u0442\\\\u0441\\\\u043a\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 187\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"\\\\u041a\\\\u0438\\\\u043f\\\\u0430\\\\u0440\\\\u0438\\\\u0441, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u0420\\\\u0435\\\\u0447\\\\u043d\\\\u043e\\\\u0439 \\\\u043f\\\\u0435\\\\u0440\\\\u0435\\\\u0443\\\\u043b\\\\u043e\\\\u043a, 6\\\\u0411\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"\\\\u0414\\\\u0435\\\\u043b\\\\u044c\\\\u043c\\\\u043e\\\\u043d\\\\u0442, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u0426\\\\u0435\\\\u043d\\\\u0442\\\\u0440\\\\u0430\\\\u043b\\\\u044c\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 14\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"\\\\u0420\\\\u0443\\\\u0431\\\\u043b\\\\u044c, \\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"address\\": \\"\\\\u041c\\\\u0438\\\\u0440\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 9 \\\\u043a1\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}]}"	2026-03-22 04:55:35.045705+00
366	103	355	experience	1004	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u041e\\\\u0434\\\\u0438\\\\u0441\\\\u0441\\\\u0435\\\\u044f, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u0438\\\\u043c\\\\u043e\\\\u0440\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0431\\\\u0443\\\\u043b\\\\u044c\\\\u0432\\\\u0430\\\\u0440, 12\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336}, {\\"name\\": \\"\\\\u041f\\\\u0438\\\\u0442\\\\u0430&\\\\u0433\\\\u0438\\\\u0440\\\\u043e\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041c\\\\u0438\\\\u0440\\\\u0430, 36\\\\u0411\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336}, {\\"name\\": \\"\\\\u041c\\\\u0430\\\\u0434\\\\u0435\\\\u0440\\\\u0430, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u043f\\\\u0430\\\\u0431\\", \\"address\\": null, \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336}, {\\"name\\": \\"\\\\u0414\\\\u0430\\\\u0447\\\\u0430, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041c\\\\u0438\\\\u0440\\\\u0430, 13\\\\u0435\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336}, {\\"name\\": \\"\\\\u041f\\\\u043e\\\\u0434 \\\\u0448\\\\u0430\\\\u0442\\\\u0440\\\\u043e\\\\u043c, \\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u0438\\\\u043c\\\\u043e\\\\u0440\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0431\\\\u0443\\\\u043b\\\\u044c\\\\u0432\\\\u0430\\\\u0440, 8\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.6528, \\"lng\\": 37.9336}]}"	2026-03-22 04:55:35.045705+00
367	103	356	experience	1005	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u0425\\\\u043b\\\\u0435\\\\u0431\\\\u0430 \\\\u0438 \\\\u0437\\\\u0440\\\\u0435\\\\u043b\\\\u0438\\\\u0449, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u041b\\\\u0435\\\\u0440\\\\u043c\\\\u043e\\\\u043d\\\\u0442\\\\u043e\\\\u0432\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0431\\\\u0443\\\\u043b\\\\u044c\\\\u0432\\\\u0430\\\\u0440, 6/2\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.574085, \\"lng\\": 38.070246}, {\\"name\\": \\"\\\\u041f\\\\u0430\\\\u0440\\\\u0430\\\\u0441\\\\u043e\\\\u043b\\\\u044c, \\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"address\\": \\"\\\\u041f\\\\u0440\\\\u0438\\\\u043c\\\\u043e\\\\u0440\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0431\\\\u0443\\\\u043b\\\\u044c\\\\u0432\\\\u0430\\\\u0440, 7\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.574085, \\"lng\\": 38.070246}, {\\"name\\": \\"\\\\u0426\\\\u0435\\\\u0445, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u041c\\\\u0438\\\\u0440\\\\u0430, 44 \\\\u043b\\\\u0438\\\\u04426\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.574085, \\"lng\\": 38.070246}, {\\"name\\": \\"Rony Oyster, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u041b\\\\u0435\\\\u0440\\\\u043c\\\\u043e\\\\u043d\\\\u0442\\\\u043e\\\\u0432\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0431\\\\u0443\\\\u043b\\\\u044c\\\\u0432\\\\u0430\\\\u0440, 18\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.574085, \\"lng\\": 38.070246}, {\\"name\\": \\"\\\\u0421\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f \\\\u21167\\", \\"address\\": \\"\\\\u0413\\\\u043e\\\\u0440\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 5\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.574085, \\"lng\\": 38.070246}]}"	2026-03-22 04:55:35.045705+00
368	104	358	experience	1006	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"food\\", \\"options\\": [{\\"name\\": \\"\\\\u0421\\\\u0442\\\\u0430\\\\u0440\\\\u0438\\\\u043a \\\\u0425\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\\\u043b\\\\u044b\\\\u0447, \\\\u0445\\\\u0438\\\\u043d\\\\u043a\\\\u0430\\\\u043b\\\\u044c\\\\u043d\\\\u0430\\\\u044f\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041b\\\\u0435\\\\u043d\\\\u0438\\\\u043d\\\\u0430, 16\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"\\\\u041b\\\\u044e\\\\u0431\\\\u043e\\\\u043a\\\\u043e\\\\u0444\\\\u0435, \\\\u043a\\\\u043e\\\\u0444\\\\u0435\\\\u0439\\\\u043d\\\\u044f\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041b\\\\u0435\\\\u043d\\\\u0438\\\\u043d\\\\u0430, 1\\", \\"type\\": \\"\\\\u043a\\\\u0430\\\\u0444\\\\u0435\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"\\\\u0412\\\\u0430\\\\u0445\\\\u0430 \\\\u041b\\\\u0430\\\\u0432\\\\u043a\\\\u0430, \\\\u0433\\\\u0440\\\\u0443\\\\u0437\\\\u0438\\\\u043d\\\\u0441\\\\u043a\\\\u0438\\\\u0439 \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041e\\\\u0441\\\\u0442\\\\u0440\\\\u043e\\\\u0432\\\\u0441\\\\u043a\\\\u043e\\\\u0433\\\\u043e, 2\\\\u0430\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"La \\\\u0441osta, \\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"address\\": \\"\\\\u0420\\\\u0435\\\\u0432\\\\u043e\\\\u043b\\\\u044e\\\\u0446\\\\u0438\\\\u043e\\\\u043d\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 11\\", \\"type\\": \\"\\\\u0440\\\\u0435\\\\u0441\\\\u0442\\\\u043e\\\\u0440\\\\u0430\\\\u043d\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"\\\\u0429\\\\u0438-\\\\u0411\\\\u043e\\\\u0440\\\\u0449\\\\u0438, \\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"address\\": \\"\\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430 \\\\u041b\\\\u0435\\\\u043d\\\\u0438\\\\u043d\\\\u0430, 3\\", \\"type\\": \\"\\\\u0441\\\\u0442\\\\u043e\\\\u043b\\\\u043e\\\\u0432\\\\u0430\\\\u044f\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}]}"	2026-03-22 04:55:35.045705+00
369	102	\N	stay	1007	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043b\\\\u043b\\\\u0430 \\\\u041c\\\\u0430\\\\u043b\\\\u0438\\\\u043d\\\\u0430\\", \\"address\\": \\"\\\\u043f\\\\u0435\\\\u0440\\\\u0435\\\\u0443\\\\u043b\\\\u043e\\\\u043a \\\\u041a\\\\u043e\\\\u0440\\\\u043e\\\\u043b\\\\u0435\\\\u0432\\\\u0430, 20\\", \\"type\\": \\"\\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0413\\\\u0435\\\\u0440\\\\u043c\\\\u0435\\\\u0441, \\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"address\\": \\"\\\\u0424\\\\u0440\\\\u0443\\\\u043d\\\\u0437\\\\u0435, 12/1\\\\u0411\\", \\"type\\": \\"\\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0413\\\\u0435\\\\u0440\\\\u043c\\\\u0435\\\\u0441, \\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"address\\": \\"\\\\u0424\\\\u0440\\\\u0443\\\\u043d\\\\u0437\\\\u0435, 12/1\\\\u0411\\", \\"type\\": \\"\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}, {\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043b\\\\u043b\\\\u0430 \\\\u041c\\\\u0430\\\\u043b\\\\u0438\\\\u043d\\\\u0430\\", \\"address\\": \\"\\\\u043f\\\\u0435\\\\u0440\\\\u0435\\\\u0443\\\\u043b\\\\u043e\\\\u043a \\\\u041a\\\\u043e\\\\u0440\\\\u043e\\\\u043b\\\\u0435\\\\u0432\\\\u0430, 20\\", \\"type\\": \\"\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469}]}"	2026-03-22 04:55:35.045705+00
370	103	\N	stay	1008	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"\\\\u0413\\\\u043e\\\\u0441\\\\u0442\\\\u0435\\\\u0432\\\\u043e\\\\u0439 \\\\u0434\\\\u043e\\\\u043c\\", \\"address\\": \\"\\\\u0421\\\\u043e\\\\u0432\\\\u0435\\\\u0442\\\\u0441\\\\u043a\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 34\\\\u0411\\", \\"type\\": \\"\\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"\\\\u0412\\\\u0438\\\\u043b\\\\u043b\\\\u0430 \\\\u0420\\\\u043e\\\\u0437\\\\u0430, \\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0435\\\\u0432\\\\u043e\\\\u0439 \\\\u0434\\\\u043e\\\\u043c\\", \\"address\\": \\"\\\\u0422\\\\u0438\\\\u0441\\\\u043e\\\\u0432\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 71\\", \\"type\\": \\"\\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"Holiday House, \\\\u0430\\\\u043f\\\\u0430\\\\u0440\\\\u0442-\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"address\\": \\"\\\\u041c\\\\u0438\\\\u0440\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 11/3\\", \\"type\\": \\"\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}, {\\"name\\": \\"\\\\u0423\\\\u0441\\\\u0430\\\\u0434\\\\u044c\\\\u0431\\\\u0430 \\\\u0421\\\\u0443\\\\u043a\\\\u043a\\\\u043e, \\\\u044d\\\\u043a\\\\u043e\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"address\\": \\"\\\\u0421\\\\u043e\\\\u0432\\\\u0435\\\\u0442\\\\u0441\\\\u043a\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 135\\\\u0430\\", \\"type\\": \\"\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392}]}"	2026-03-22 04:55:35.045705+00
371	104	\N	stay	1009	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"recommendation_type\\": \\"stay\\", \\"options\\": [{\\"name\\": \\"\\\\u0410\\\\u0441\\\\u0442\\\\u0435\\\\u043b\\\\u044c \\\\u0412\\\\u0438\\\\u043b\\\\u043b\\\\u0430, \\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"address\\": \\"\\\\u0428\\\\u043a\\\\u043e\\\\u043b\\\\u044c\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 1\\", \\"type\\": \\"\\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"\\\\u0414\\\\u0430\\\\u0447\\\\u0430, \\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0447\\\\u043d\\\\u044b\\\\u0439 \\\\u043a\\\\u043e\\\\u043c\\\\u043f\\\\u043b\\\\u0435\\\\u043a\\\\u0441\\", \\"address\\": \\"\\\\u0425\\\\u0435\\\\u0440\\\\u0441\\\\u043e\\\\u043d\\\\u0441\\\\u043a\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 9\\", \\"type\\": \\"\\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0446\\\\u0430\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"\\\\u0410\\\\u0441\\\\u0442\\\\u0435\\\\u043b\\\\u044c \\\\u0412\\\\u0438\\\\u043b\\\\u043b\\\\u0430, \\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"address\\": \\"\\\\u0428\\\\u043a\\\\u043e\\\\u043b\\\\u044c\\\\u043d\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 1\\", \\"type\\": \\"\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}, {\\"name\\": \\"\\\\u0414\\\\u0430\\\\u0447\\\\u0430, \\\\u0433\\\\u043e\\\\u0441\\\\u0442\\\\u0438\\\\u043d\\\\u0438\\\\u0447\\\\u043d\\\\u044b\\\\u0439 \\\\u043a\\\\u043e\\\\u043c\\\\u043f\\\\u043b\\\\u0435\\\\u043a\\\\u0441\\", \\"address\\": \\"\\\\u0425\\\\u0435\\\\u0440\\\\u0441\\\\u043e\\\\u043d\\\\u0441\\\\u043a\\\\u0430\\\\u044f \\\\u0443\\\\u043b\\\\u0438\\\\u0446\\\\u0430, 9\\", \\"type\\": \\"\\\\u043e\\\\u0442\\\\u0435\\\\u043b\\\\u044c\\", \\"source\\": \\"2gis\\", \\"lat\\": 44.5611, \\"lng\\": 38.0764}]}"	2026-03-22 04:55:35.045705+00
334	97	333	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Абрау-Дюрсо\\", \\"lat\\": 44.6977, \\"lng\\": 37.5977, \\"post_id\\": 524, \\"description\\": \\"Винодельня с дегустацией игристых вин. Озеро, парк, лавка сыров. Экскурсия по подвалам — обязательно.\\"}"	2026-03-22 03:58:48.998436+00
348	101	347	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Роза Хутор\\", \\"lat\\": 43.6615, \\"lng\\": 40.304, \\"post_id\\": 529, \\"description\\": \\"Горный курорт. Зимой лыжи, летом трекинг. Набережная как в Австрии, подъёмник на Роза Пик 2320м.\\"}"	2026-03-22 03:58:49.04471+00
333	97	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"label\\": \\"День 1\\"}"	2026-03-22 03:58:48.998436+00
337	98	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"label\\": \\"День 2\\"}"	2026-03-22 03:58:48.998436+00
335	97	333	experience	2	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Винодельня Лефкадия\\", \\"lat\\": 44.7486, \\"lng\\": 37.7231, \\"post_id\\": 528, \\"description\\": \\"Биодинамическое виноделие, сыроварня, оливковое масло. Обед на веранде с видом на виноградники.\\"}"	2026-03-22 03:58:48.998436+00
336	97	333	experience	3	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Ферма Экзархо\\", \\"lat\\": 44.8956, \\"lng\\": 37.8469, \\"post_id\\": 532, \\"description\\": \\"Козий сыр, экскурсия по ферме, мастер-класс по варке моцареллы. Берите сумку-холодильник.\\"}"	2026-03-22 03:58:48.998436+00
338	98	337	experience	1	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"name\\": \\"Кипарисовое озеро\\", \\"lat\\": 44.8103, \\"lng\\": 37.4392, \\"post_id\\": 530, \\"description\\": \\"Болотные кипарисы растут прямо из воды. Рассвет — лучшее время, народу никого. Сукко, 15 минут от Анапы.\\"}"	2026-03-22 03:58:48.998436+00
340	99	\N	day	0	\N	\N	\N	\N	fresh	\N	\N	\N	"{\\"label\\": \\"День 1\\"}"	2026-03-22 03:58:49.031613+00
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
2	1	20
2	2	20
2	4	21
2	7	21
14	9	1
14	10	1
14	3	2
14	2	24
14	11	23
14	7	5
14	4	27
14	1	26
14	5	23
14	12	21
\.


--
-- Data for Name: user_place_statuses; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.user_place_statuses (user_id, post_id, status, planned_date, created_at) FROM stdin;
2	524	want	\N	2026-03-22 03:35:41.68694+00
2	529	want	\N	2026-03-22 03:35:41.739418+00
14	533	want	\N	2026-03-22 03:39:47.05628+00
14	524	want	\N	2026-03-22 03:43:07.191325+00
14	530	want	\N	2026-03-22 04:01:07.47427+00
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
14	533	right	2026-03-22 03:46:49.406438+00
14	532	right	2026-03-22 03:46:50.01283+00
14	531	right	2026-03-22 03:46:50.516873+00
14	530	left	2026-03-22 03:46:50.963178+00
14	529	right	2026-03-22 03:46:51.751125+00
14	528	right	2026-03-22 03:46:52.114969+00
14	527	right	2026-03-22 03:46:52.299683+00
14	526	right	2026-03-22 03:46:52.446733+00
14	525	right	2026-03-22 03:46:52.86509+00
14	524	right	2026-03-22 03:46:53.276904+00
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
11	+77999999999	\N	\N	\N	tourist	\N	2026-03-22 01:28:52.499023+00	2026-03-22 01:28:52.499023+00
12	+779999999999	\N	\N	\N	tourist	\N	2026-03-22 02:21:31.075356+00	2026-03-22 02:21:31.075356+00
13	+779001111111	\N	\N	\N	tourist	\N	2026-03-22 02:23:08.81526+00	2026-03-22 02:23:08.81526+00
14	+77777777777	\N	\N	\N	tourist	\N	2026-03-22 03:39:42.961541+00	2026-03-22 03:39:42.961541+00
15	+79008888888	\N	\N	\N	tourist	\N	2026-03-22 03:52:10.537157+00	2026-03-22 03:52:10.537157+00
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

SELECT pg_catalog.setval('public.post_media_id_seq', 2227, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.posts_id_seq', 904, true);


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

SELECT pg_catalog.setval('public.reviews_id_seq', 24, true);


--
-- Name: route_pins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.route_pins_id_seq', 7, true);


--
-- Name: route_segments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.route_segments_id_seq', 104, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.routes_id_seq', 98, true);


--
-- Name: segment_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kraeved_user
--

SELECT pg_catalog.setval('public.segment_items_id_seq', 371, true);


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

SELECT pg_catalog.setval('public.users_id_seq', 15, true);


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

\unrestrict 9ShAh0g1jTJjdOJK1S5ozCDBwTZ6efVmM5wh86pZJQUpV1G4BfeLgsrzyKjF6Ao

