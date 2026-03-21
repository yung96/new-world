--
-- PostgreSQL database dump
--

\restrict qbhmFdbuMWGgvcsszbpUdMs0Xjnruga4L2wD41QbsuOsstiCcBLCKr7kXkxY1MT

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
1	1	Фестиваль молодого вина	Дегустация 20 виноделен края	2026-04-15	2026-04-17	\N	2026-03-21 21:02:46.297305+00
2	1	Краснодар Jazz	Джазовый фестиваль под открытым небом	2026-05-01	2026-05-03	\N	2026-03-21 21:02:46.297305+00
3	1	Горный марафон Фишт	Трейл 42км по горам	2026-06-07	2026-06-07	\N	2026-03-21 21:02:46.297305+00
4	1	Ночь музеев	Бесплатный вход во все музеи	2026-05-16	2026-05-16	\N	2026-03-21 21:02:46.297305+00
5	1	Сочи Surf Fest	Фестиваль серфинга	2026-07-10	2026-07-12	\N	2026-03-21 21:02:46.297305+00
6	1	Фермерский рынок Абрау	Еженедельный рынок фермеров	2026-04-05	2026-10-25	\N	2026-03-21 21:02:46.297305+00
\.


--
-- Data for Name: experts; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.experts (id, user_id, name, photo_url, specialization, price_from, bio, contacts, region_id, created_at) FROM stdin;
1	\N	Алексей Горный	\N	hiking	3000	Горный гид, 10 лет опыта	\N	2	2026-03-21 21:02:46.262551+00
2	\N	Мария Виноградова	\N	wine	5000	Сомелье, винные туры	\N	2	2026-03-21 21:02:46.262551+00
3	\N	Игорь Фотограф	\N	photo	7000	Travel-фотограф, Instagram 50K	\N	2	2026-03-21 21:02:46.262551+00
4	\N	Елена Историк	\N	culture	2500	Экскурсовод по Краснодару	\N	2	2026-03-21 21:02:46.262551+00
5	\N	Дмитрий Рафтинг	\N	sport	4000	Инструктор по рафтингу	\N	2	2026-03-21 21:02:46.262551+00
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
1	Россия	russia	country	\N	\N	60.0,90.0	\N	\N	2026-03-21 20:50:38.711698+00
2	Краснодарский край	krasnodarskiy-kray	region	1	{"type": "MultiPolygon", "coordinates": [[[[36.6684499, 45.6266206], [36.7845329, 45.6282269], [36.8013454, 45.6309915], [36.8183804, 45.6329813], [36.8355651, 45.6341877], [36.8528258, 45.6346056], [36.8700885, 45.6342332], [36.8872797, 45.6330722], [36.9043253, 45.6311273], [36.9211525, 45.628407], [36.9376893, 45.6249227], [36.9538647, 45.6206892], [36.9696097, 45.6157244], [36.9848567, 45.6100495], [36.9995406, 45.6036886], [37.0135982, 45.5966685], [37.0269695, 45.5890192], [37.0395973, 45.5807731], [37.0418357, 45.5791067], [37.0520382, 45.5793539], [37.0693011, 45.5789812], [37.0864921, 45.577819], [37.1035377, 45.5758722], [37.120365, 45.5731493], [37.1369017, 45.5696615], [37.1530773, 45.5654239], [37.1688223, 45.5604542], [37.1840693, 45.5547737], [37.198753, 45.5484064], [37.2128107, 45.5413794], [37.2134915, 45.5409897], [37.2260142, 45.538347], [37.2421898, 45.534107], [37.2579348, 45.5291346], [37.2731818, 45.5234509], [37.2878656, 45.51708], [37.2919885, 45.5150181], [37.2959128, 45.5176033], [37.3092428, 45.5252976], [37.3232625, 45.5323636], [37.3379119, 45.5387714], [37.3405082, 45.5397479], [37.3400995, 45.5414618], [37.3383742, 45.5534965], [37.3377765, 45.5655819], [37.3383091, 45.5776662], [37.3399696, 45.5896976], [37.3427508, 45.6016247], [37.3466409, 45.6133966], [37.3516233, 45.6249628], [37.3525065, 45.6266133], [37.3507238, 45.6319146], [37.3478782, 45.6438254], [37.346153, 45.6558382], [37.3455554, 45.6679016], [37.3460879, 45.6799638], [37.3477484, 45.6919733], [37.3505296, 45.7038786], [37.3544197, 45.715629], [37.3594021, 45.7271741], [37.3654553, 45.7384647], [37.3725535, 45.7494526], [37.3806663, 45.7600909], [37.3897589, 45.7703343], [37.3997924, 45.7801392], [37.4107239, 45.7894637], [37.4225064, 45.7982683], [37.4350897, 45.8065156], [37.4484197, 45.8141702], [37.4624394, 45.8211999], [37.4770888, 45.8275747], [37.4923051, 45.8332676], [37.5080232, 45.8382544], [37.5241757, 45.8425139], [37.5406936, 45.846028], [37.5462594, 45.8469397], [37.5564067, 45.8535846], [37.5697366, 45.8612329], [37.5837564, 45.8682566], [37.5984058, 45.8746261], [37.6136221, 45.8803141], [37.6293402, 45.8852966], [37.6318948, 45.8859698], [37.6331191, 45.894792], [37.6359003, 45.9066541], [37.6397904, 45.9183617], [37.6447728, 45.9298649], [37.650826, 45.9411145], [37.6579242, 45.9520624], [37.6629417, 45.9586182], [37.662634, 45.9647974], [37.6631665, 45.9767955], [37.6648269, 45.9887411], [37.6676082, 46.0005832], [37.6714983, 46.012271], [37.6764806, 46.0237547], [37.6825338, 46.0349852], [37.6896321, 46.0459145], [37.6977449, 46.0564962], [37.7068375, 46.066685], [37.716871, 46.0764376], [37.718688, 46.0779795], [37.7197494, 46.0811641], [37.7247317, 46.0926335], [37.7307849, 46.10385], [37.7378832, 46.1147657], [37.7459959, 46.1253341], [37.7550886, 46.1355103], [37.7651221, 46.1452507], [37.7760535, 46.1545141], [37.7878361, 46.1632608], [37.8004193, 46.1714538], [37.8137494, 46.1790582], [37.827769, 46.1860417], [37.8424184, 46.1923746], [37.8576347, 46.1980301], [37.8733528, 46.202984], [37.8832657, 46.205581], [37.8750705, 46.2081378], [37.8598235, 46.2137519], [37.8451397, 46.2200434], [37.8310821, 46.226985], [37.8177108, 46.2345468], [37.8050831, 46.2426964], [37.7932529, 46.2513983], [37.7822711, 46.2606151], [37.776839, 46.2658352], [37.7661609, 46.269163], [37.7509139, 46.2747708], [37.7362302, 46.2810553], [37.7221725, 46.2879893], [37.7088012, 46.2955427], [37.6961735, 46.3036831], [37.6843433, 46.3123754], [37.6733615, 46.321582], [37.6632751, 46.3312633], [37.6541272, 46.3413776], [37.645957, 46.3518813], [37.6387994, 46.3627293], [37.6326852, 46.3738749], [37.6277828, 46.3849491], [37.6173519, 46.3926019], [37.6063701, 46.401795], [37.5962836, 46.4114621], [37.5871357, 46.4215616], [37.5789655, 46.4320499], [37.571808, 46.442882], [37.5656938, 46.4540112], [37.5606492, 46.4653898], [37.5566956, 46.4769689], [37.5538709, 46.4886129], [37.5457776, 46.4975354], [37.5376075, 46.5080091], [37.5304499, 46.5188261], [37.5243357, 46.5299398], [37.5192911, 46.5413025], [37.5153375, 46.5528654], [37.512492, 46.5645789], [37.5122252, 46.5664061], [37.5023679, 46.5736142], [37.4913861, 46.5827767], [37.4812996, 46.5924117], [37.4721517, 46.6024776], [37.4639814, 46.612931], [37.4568239, 46.6237271], [37.4507098, 46.6348193], [37.445665, 46.64616], [37.4417115, 46.6577006], [37.4388661, 46.6693914], [37.4371408, 46.6811824], [37.4365431, 46.6930229], [37.4370757, 46.7048623], [37.4375896, 46.7158298], [36.6684499, 45.6266206]]], [[[37.620074, 46.8298909], [37.4375896, 46.7158298], [37.620074, 46.8298909]]], [[[37.870342, 46.8447314], [37.620074, 46.8298909], [37.870342, 46.8447314]]], [[[38.3381215, 46.9807515], [38.2384557, 46.9202795], [38.1408636, 46.8609996], [38.0057729, 46.8528763], [37.870342, 46.8447314], [38.3381215, 46.9807515]]], [[[38.6856065, 46.8704344], [38.6596625, 47.0030215], [38.4991569, 46.991906], [38.3381215, 46.9807515], [38.6856065, 46.8704344]]], [[[38.6856065, 46.8704344], [38.6856014, 46.8703452], [38.6855937, 46.8695117], [38.6856143, 46.8601911], [38.6856151, 46.859839], [38.6856487, 46.8446155], [38.685649, 46.8444595], [38.6856645, 46.8374778], [38.685665, 46.8372521], [38.6856888, 46.8264351], [38.6856894, 46.826179], [38.6856065, 46.8704344]]], [[[38.6856894, 46.826179], [38.6863361, 46.8261784], [38.6922641, 46.8261733], [38.6924243, 46.8261731], [38.6992997, 46.8261862], [38.6856894, 46.826179]]], [[[38.6992997, 46.8261862], [38.7009587, 46.8261696], [38.7012082, 46.8261702], [38.7060884, 46.8261817], [38.7066679, 46.8261831], [38.713409, 46.826199], [38.7139267, 46.8262003], [38.7175235, 46.8262088], [38.7186071, 46.8262113], [38.719904, 46.8262144], [38.7205572, 46.826216], [38.7268752, 46.8262086], [38.7273191, 46.8262042], [38.7367736, 46.8261704], [38.7371211, 46.8262162], [38.7374221, 46.8262558], [38.7512997, 46.8263025], [38.7644561, 46.8263204], [38.764765, 46.8263208], [38.7650575, 46.8263212], [38.7674848, 46.8263211], [38.8035621, 46.826319], [38.8049439, 46.8263189], [38.8301999, 46.8263552], [38.8306372, 46.8263558], [38.8434438, 46.8263742], [38.85657, 46.826393], [38.8570265, 46.8263937], [38.8695636, 46.8264117], [38.8695647, 46.8265609], [38.8696766, 46.8413117], [38.8698135, 46.8413116], [38.8703019, 46.8413116], [38.9047949, 46.8413093], [38.9097073, 46.841309], [38.9105567, 46.8413089], [38.9172033, 46.8413085], [38.9180598, 46.8413084], [38.9247913, 46.841308], [38.9253067, 46.8413079], [38.9330859, 46.8413214], [38.6992997, 46.8261862]]], [[[38.9330859, 46.8413214], [38.9330866, 46.8412092], [38.9331433, 46.8265383], [38.9331496, 46.8264137], [38.9224166, 46.826431], [38.9219016, 46.8264316], [38.9204072, 46.8264335], [38.9190483, 46.8264352], [38.9166152, 46.8264382], [38.9161669, 46.8264388], [38.9091432, 46.8264476], [38.907971, 46.826449], [38.902325, 46.8264561], [38.9019, 46.8264566], [38.8970292, 46.8264627], [38.8959219, 46.8264641], [38.8959217, 46.8263561], [38.8958339, 46.808234], [38.8957543, 46.7711947], [38.8959432, 46.7518715], [38.8959444, 46.7515317], [38.8959767, 46.7438503], [38.8959728, 46.7431363], [38.8960852, 46.7319072], [38.9330859, 46.8413214]]], [[[38.8960852, 46.7319072], [38.8955754, 46.7318392], [38.8931957, 46.7318236], [38.8927473, 46.7318207], [38.8853306, 46.7317723], [38.8848801, 46.7317694], [38.8697294, 46.7316705], [38.8697207, 46.7162114], [38.8697118, 46.700483], [38.8697018, 46.6825732], [38.8693692, 46.6825724], [38.8662764, 46.6825656], [38.8663242, 46.6744643], [38.8663428, 46.6713133], [38.8663433, 46.6712373], [38.8663437, 46.6711568], [38.8663467, 46.6706537], [38.8663553, 46.6691914], [38.8663557, 46.6691149], [38.8663588, 46.6685966], [38.8960852, 46.7319072]]], [[[38.8663588, 46.6685966], [38.866407, 46.6646943], [38.869299, 46.6646881], [38.8692047, 46.6362789], [38.8693264, 46.6301469], [38.8694177, 46.6289131], [38.8694341, 46.6286918], [38.8693612, 46.6045793], [38.8693589, 46.6036967], [38.8693751, 46.6016744], [38.8694076, 46.5994606], [38.8694692, 46.5890018], [38.8694528, 46.5853505], [38.8693352, 46.5851741], [38.8693352, 46.5850574], [38.8695279, 46.5850629], [38.8699724, 46.5848427], [38.8699838, 46.5846994], [38.8699545, 46.5845673], [38.8706456, 46.5844276], [38.87111, 46.5842572], [38.8719059, 46.5839638], [38.8723775, 46.583757], [38.8724751, 46.5836788], [38.8727597, 46.5835782], [38.873028, 46.583472], [38.8736053, 46.5833323], [38.8739364, 46.5832335], [38.8744509, 46.5829523], [38.8748656, 46.5827735], [38.8756787, 46.5825108], [38.8761421, 46.5822873], [38.8763373, 46.5821755], [38.8768414, 46.5819576], [38.8769634, 46.5818681], [38.8769878, 46.5817787], [38.8769227, 46.5816614], [38.876817, 46.5815217], [38.876752, 46.5813205], [38.876752, 46.581164], [38.8768333, 46.5809796], [38.8770203, 46.5807728], [38.8772154, 46.5805492], [38.8773293, 46.5803145], [38.8774106, 46.5799736], [38.8774187, 46.57975], [38.8773699, 46.5795656], [38.877248, 46.5793421], [38.8769878, 46.5790011], [38.8765893, 46.5784143], [38.8761828, 46.578051], [38.8760771, 46.5779281], [38.8743509, 46.5771976], [38.8741967, 46.5771559], [38.8727957, 46.5766166], [38.8725109, 46.5764817], [38.8723661, 46.5763726], [38.8721695, 46.5761851], [38.8719536, 46.5760269], [38.8717695, 46.5757691], [38.8717271, 46.5756571], [38.8716386, 46.5754577], [38.8715713, 46.5752363], [38.8713944, 46.5748129], [38.8713353, 46.5746817], [38.8712613, 46.5741607], [38.8712367, 46.5739065], [38.8711872, 46.5737191], [38.8710888, 46.5734956], [38.8708208, 46.5731639], [38.8705342, 46.5728772], [38.8702569, 46.5726993], [38.8694805, 46.5722545], [38.8688458, 46.5718732], [38.86855, 46.5716106], [38.8684206, 46.571475], [38.8683343, 46.5712505], [38.868285, 46.5709879], [38.8682912, 46.5708566], [38.8683775, 46.5707379], [38.8684329, 46.5706575], [38.8684329, 46.570577], [38.868359, 46.5705219], [38.8683347, 46.5704835], [38.8675651, 46.5692668], [38.8663588, 46.6685966]]], [[[38.8675651, 46.5692668], [38.8702613, 46.5685411], [38.883688, 46.5649727], [38.8980253, 46.5611449], [38.8981156, 46.5611207], [38.902318, 46.5599924], [38.9023221, 46.5612626], [38.9023226, 46.5613938], [38.9023233, 46.5616016], [38.902336, 46.5654463], [38.9023369, 46.5657564], [38.9023541, 46.5706833], [38.9023717, 46.5757206], [38.9023887, 46.5805946], [38.9023881, 46.5807054], [38.9023874, 46.5808342], [38.9023859, 46.5811192], [38.9024921, 46.6028025], [38.9024961, 46.6036027], [38.9021689, 46.6065242], [38.9020941, 46.6065884], [38.9020941, 46.6086994], [38.902309, 46.6087507], [38.9022909, 46.6092652], [38.9022909, 46.6202244], [38.9023147, 46.6217116], [38.9022439, 46.6243367], [38.9021491, 46.6282291], [38.9021322, 46.6289212], [38.902039, 46.6345352], [38.9022669, 46.6344856], [38.9027385, 46.6343292], [38.9029499, 46.6341394], [38.9030385, 46.6340123], [38.9033077, 46.6336258], [38.9036427, 46.6331594], [38.9039093, 46.6329195], [38.9039538, 46.6328795], [38.9043079, 46.6326658], [38.9046512, 46.6325921], [38.9050482, 46.6325627], [38.9055846, 46.6326216], [38.9063464, 46.6327616], [38.9068184, 46.6327911], [38.9074943, 46.632769], [38.9082346, 46.63271], [38.9087603, 46.6326142], [38.9092646, 46.6325258], [38.9099298, 46.6323932], [38.9149295, 46.6320253], [38.9158736, 46.6319074], [38.9163564, 46.6317601], [38.9173542, 46.6314065], [38.9185022, 46.6310013], [38.9190279, 46.6307139], [38.9196502, 46.6302129], [38.9198862, 46.6299919], [38.9201866, 46.6297635], [38.9203235, 46.6297383], [38.920491, 46.6297685], [38.9208162, 46.6299584], [38.9211415, 46.6300365], [38.9229465, 46.6302375], [38.9235807, 46.6303492], [38.9240523, 46.6304609], [38.9243613, 46.6304609], [38.9246215, 46.6304274], [38.9252395, 46.6301817], [38.9264428, 46.6293442], [38.9267184, 46.6290869], [38.9273554, 46.6286203], [38.9274687, 46.6284939], [38.9274687, 46.6283189], [38.9274687, 46.6281828], [38.9276527, 46.6280467], [38.9281765, 46.6278036], [38.928304, 46.6275995], [38.9282898, 46.627405], [38.9281765, 46.627055], [38.9282332, 46.6268898], [38.9284172, 46.6267828], [38.9291109, 46.6266759], [38.9295214, 46.6265592], [38.9298187, 46.6263939], [38.9300169, 46.6262092], [38.9301302, 46.6260342], [38.9303284, 46.6255675], [38.9304983, 46.62548], [38.931291, 46.6251786], [38.9316874, 46.6250814], [38.9319139, 46.6250522], [38.9321688, 46.6251203], [38.9324519, 46.6252953], [38.9326642, 46.6254509], [38.9329474, 46.6255286], [38.9341507, 46.6256648], [38.9346603, 46.6258106], [38.9364724, 46.6262286], [38.9367556, 46.6263745], [38.9369962, 46.6265884], [38.937251, 46.6269481], [38.9374634, 46.6272398], [38.9377748, 46.6274439], [38.9381712, 46.62758], [38.9386101, 46.6276286], [38.939148, 46.6275509], [38.9395728, 46.6275217], [38.9400399, 46.6275314], [38.9404646, 46.6276092], [38.9414839, 46.6281731], [38.9420077, 46.6285425], [38.9423616, 46.6286494], [38.9434092, 46.6286786], [38.9451289, 46.6292928], [38.9469206, 46.6299116], [38.947103, 46.6300222], [38.9473176, 46.6302579], [38.9475107, 46.6305526], [38.9475429, 46.6308031], [38.9472854, 46.6315472], [38.9471829, 46.6321326], [38.9472687, 46.6324568], [38.9476764, 46.6327367], [38.948642, 46.6331198], [38.9527404, 46.6337681], [38.9535129, 46.6339597], [38.9540708, 46.6341954], [38.9548647, 46.634608], [38.955723, 46.6348732], [38.9566457, 46.6349174], [38.9578903, 46.6347848], [38.9586627, 46.6347111], [38.9593494, 46.6347406], [38.9597785, 46.6349026], [38.9600575, 46.6351678], [38.9602721, 46.6357719], [38.9604652, 46.6361697], [38.9607012, 46.6364791], [38.9609802, 46.636597], [38.9614308, 46.636597], [38.9625037, 46.6364202], [38.9633233, 46.6361504], [38.9639885, 46.6359294], [38.9648039, 46.6358115], [38.9653189, 46.6357379], [38.9658124, 46.6355905], [38.9664132, 46.6353253], [38.9672072, 46.6345444], [38.96789, 46.6337749], [38.9685874, 46.6332297], [38.9704005, 46.6322646], [38.9717309, 46.631329], [38.9748639, 46.6297299], [38.9758724, 46.6291847], [38.9762908, 46.6289121], [38.9765161, 46.6286764], [38.9766449, 46.6284295], [38.9767951, 46.6282785], [38.9770311, 46.6280538], [38.9771706, 46.6278512], [38.9773247, 46.6274622], [38.9774238, 46.6271705], [38.9776644, 46.6269761], [38.9777211, 46.6268205], [38.9776361, 46.6265775], [38.9776683, 46.6264269], [38.977806, 46.6263441], [38.9780042, 46.6263371], [38.9781458, 46.6264025], [38.97865, 46.6269557], [38.9790382, 46.6271884], [38.9791676, 46.6273281], [38.9793155, 46.6274635], [38.9794388, 46.6275143], [38.9795805, 46.6275143], [38.9797222, 46.6274762], [38.9798085, 46.6274297], [38.9799071, 46.6273366], [38.9799892, 46.6271063], [38.980075, 46.6267415], [38.9801501, 46.6265794], [38.980236, 46.6264542], [38.9803164, 46.6264063], [38.9804452, 46.6263842], [38.9806651, 46.6263768], [38.9808851, 46.6264063], [38.9811318, 46.6264689], [38.9813625, 46.6265758], [38.981561, 46.6266679], [38.9817273, 46.6267747], [38.9818989, 46.6268668], [38.9820277, 46.6268926], [38.9821725, 46.6268926], [38.9823174, 46.6268557], [38.9826768, 46.6266494], [38.9828431, 46.6265094], [38.9829772, 46.6264284], [38.9830737, 46.6263952], [38.9831971, 46.6264026], [38.9833205, 46.6264763], [38.9837979, 46.6269442], [38.9840608, 46.6272241], [38.9842325, 46.6273347], [38.9843611, 46.6273678], [38.9845434, 46.6273751], [38.9847366, 46.6273346], [38.9850102, 46.6272278], [38.985214, 46.6271173], [38.9853213, 46.6270104], [38.9853696, 46.6268704], [38.9853267, 46.6267194], [38.9852516, 46.6265647], [38.9852033, 46.6264394], [38.9852033, 46.6263142], [38.985391, 46.6243616], [38.9854178, 46.6240668], [38.985493, 46.6237868], [38.9855788, 46.623669], [38.9856968, 46.6235326], [38.985906, 46.6233337], [38.9861581, 46.6231716], [38.9863942, 46.6230905], [38.9868019, 46.6229505], [38.9870701, 46.6228768], [38.9872364, 46.6228658], [38.9874241, 46.6228584], [38.9875583, 46.6228879], [38.9877192, 46.6229726], [38.9878801, 46.6230684], [38.9880679, 46.6231679], [38.9882234, 46.6232084], [38.9883736, 46.6231937], [38.988556, 46.6231421], [38.9888296, 46.6230684], [38.9890013, 46.6230574], [38.9891783, 46.6231016], [38.9893929, 46.6231863], [38.9895485, 46.6232453], [38.989645, 46.6232489], [38.9897845, 46.62319], [38.9898167, 46.6231016], [38.9898381, 46.6230132], [38.9898971, 46.6229874], [38.9900581, 46.62298], [38.9901815, 46.6229579], [38.9902619, 46.6228768], [38.9902566, 46.622711], [38.9901868, 46.6225821], [38.9901278, 46.6224531], [38.9901543, 46.6223606], [38.9902562, 46.6222317], [38.9904708, 46.622099], [38.9906692, 46.6220733], [38.9908194, 46.6221064], [38.9908945, 46.6221691], [38.9909697, 46.6222206], [38.9911038, 46.6222391], [38.9914095, 46.6222059], [38.9915866, 46.6221248], [38.991726, 46.6220843], [38.9918494, 46.6220769], [38.9919352, 46.6221212], [38.992005, 46.622228], [38.9920318, 46.6223164], [38.992123, 46.6223606], [38.992461, 46.6224564], [38.9926575, 46.6225863], [38.9928177, 46.6227091], [38.9928978, 46.6228403], [38.9929717, 46.6229249], [38.9930826, 46.6229757], [38.9932305, 46.6229714], [38.9934339, 46.6229672], [38.9936311, 46.6230053], [38.9938591, 46.6230561], [38.9939823, 46.623128], [38.9941425, 46.6232931], [38.9942534, 46.6233862], [38.9944383, 46.6234497], [38.9945615, 46.6235005], [38.9947279, 46.6237163], [38.9948265, 46.623894], [38.9949066, 46.6240083], [38.9948573, 46.6240972], [38.9947594, 46.6241967], [38.9947402, 46.6243765], [38.9947834, 46.6245204], [38.9948512, 46.6247193], [38.9949436, 46.6248801], [38.9950668, 46.6250155], [38.9951716, 46.6250832], [38.9954791, 46.625152], [38.9958976, 46.6252036], [38.9962516, 46.6252036], [38.9965413, 46.6251815], [38.9968953, 46.6251226], [38.9973352, 46.6250268], [38.9976681, 46.6249015], [38.997847, 46.6247898], [38.9979365, 46.6247061], [38.9981235, 46.6244157], [38.998278, 46.6242593], [38.9983999, 46.6241923], [38.9985382, 46.6241253], [38.9986764, 46.6241197], [38.9991805, 46.6242538], [38.999457, 46.6243319], [38.999583, 46.6243515], [38.9997415, 46.6243487], [39.0000505, 46.6243934], [39.0002944, 46.624505], [39.0004571, 46.6246893], [39.0005872, 46.6247452], [39.0007986, 46.6247619], [39.0009002, 46.6247954], [39.0009449, 46.6248457], [39.0009937, 46.6250355], [39.0010506, 46.6253036], [39.0011563, 46.6253985], [39.0015303, 46.6255604], [39.0018068, 46.6256498], [39.0019992, 46.6256692], [39.0021808, 46.6256665], [39.0023558, 46.6256533], [39.002563, 46.6256107], [39.0029045, 46.6254655], [39.0032541, 46.6253315], [39.0035387, 46.6252477], [39.0039276, 46.6251869], [39.0045928, 46.6251206], [39.0054296, 46.6251611], [39.0057193, 46.62522], [39.0058863, 46.6252959], [39.006431, 46.6255527], [39.0068051, 46.6258264], [39.0071953, 46.6260162], [39.0076666, 46.6263455], [39.0077524, 46.6264339], [39.00779, 46.6265407], [39.0078758, 46.6270123], [39.0078222, 46.6271854], [39.0076881, 46.6273917], [39.0075003, 46.6275943], [39.0073555, 46.6277749], [39.0072911, 46.6279627], [39.007275, 46.6281396], [39.007216, 46.6288432], [39.0071999, 46.6293552], [39.0072375, 46.6296389], [39.0073233, 46.6298415], [39.0074467, 46.6300367], [39.0076934, 46.6302762], [39.0079831, 46.6305156], [39.008187, 46.6306814], [39.0082782, 46.6307919], [39.0085839, 46.6311898], [39.008817, 46.631398], [38.8675651, 46.5692668]]], [[[39.008817, 46.631398], [39.0102053, 46.6306766], [39.0128397, 46.6324299], [39.013991, 46.6331961], [39.0151011, 46.6332977], [39.0164142, 46.6331035], [39.0183077, 46.6325744], [39.0231605, 46.6312184], [39.0258809, 46.630367], [39.0277949, 46.6282907], [39.0307303, 46.6266254], [39.0341311, 46.6257546], [39.0363317, 46.6251166], [39.0373096, 46.6248331], [39.0404263, 46.6246039], [39.0428202, 46.6247099], [39.0439907, 46.6243418], [39.0453229, 46.6242919], [39.047992, 46.6241918], [39.0512773, 46.6238802], [39.0539855, 46.6225046], [39.0556982, 46.6211], [39.0567539, 46.6202342], [39.0577522, 46.6185829], [39.0587639, 46.6169093], [39.0592776, 46.6150466], [39.0610049, 46.6126825], [39.0617532, 46.6100137], [39.0620015, 46.6091281], [39.0632594, 46.6074215], [39.0649977, 46.6050633], [39.0658288, 46.6039357], [39.0688002, 46.6004134], [39.0717628, 46.5990708], [39.0791454, 46.5989185], [39.0817395, 46.5997507], [39.0830858, 46.6005883], [39.0852156, 46.6017746], [39.0876215, 46.602439], [39.092022, 46.6024795], [39.0958227, 46.6016473], [39.0994098, 46.6018927], [39.101848, 46.6024944], [39.1056009, 46.6033727], [39.10663, 46.6036135], [39.1085186, 46.6033671], [39.1114014, 46.6026229], [39.1124711, 46.6025809], [39.115034, 46.602655], [39.1177915, 46.6028812], [39.119667, 46.603413], [39.1219127, 46.6040946], [39.1227199, 46.6046029], [39.1244016, 46.6049703], [39.1273141, 46.6042299], [39.1282744, 46.6044824], [39.1296233, 46.6041096], [39.008817, 46.631398]]], [[[39.1296233, 46.6041096], [39.131449, 46.6049472], [39.1320388, 46.6058818], [39.1342009, 46.6084645], [39.1345056, 46.6097634], [39.1360814, 46.6120954], [39.1363417, 46.6139444], [39.1365026, 46.615477], [39.136353, 46.6176563], [39.1377138, 46.6195506], [39.1402997, 46.6211523], [39.1430615, 46.6218041], [39.1445275, 46.6218717], [39.1458766, 46.621934], [39.148134, 46.6217215], [39.1489361, 46.6214424], [39.1499964, 46.6211227], [39.1510785, 46.6204953], [39.151234, 46.6201306], [39.1513145, 46.6198211], [39.1513132, 46.6192924], [39.1509497, 46.6186752], [39.1502317, 46.6175487], [39.1499214, 46.6161848], [39.1503328, 46.6146957], [39.1508706, 46.6133528], [39.1519116, 46.611535], [39.1523331, 46.6105897], [39.1526073, 46.6102148], [39.1530418, 46.6099495], [39.1537861, 46.6098105], [39.1545385, 46.6098352], [39.1551761, 46.6100162], [39.1562444, 46.6105244], [39.1569203, 46.6110255], [39.1577295, 46.6118564], [39.1592699, 46.6135239], [39.1605619, 46.6152888], [39.161823, 46.6167116], [39.1622297, 46.6171694], [39.1624432, 46.6173916], [39.1628385, 46.6178001], [39.1637476, 46.6187418], [39.1667104, 46.6217922], [39.1673541, 46.622308], [39.1679764, 46.6226323], [39.1685762, 46.6227203], [39.1691673, 46.6226802], [39.1700457, 46.6224988], [39.1715772, 46.6220013], [39.1738719, 46.6210664], [39.1761973, 46.6203651], [39.1781705, 46.6196184], [39.1840247, 46.6168907], [39.1872454, 46.6158528], [39.1891384, 46.6152606], [39.1900939, 46.6149831], [39.1912124, 46.6144617], [39.1917878, 46.6139157], [39.1922021, 46.6126432], [39.1924401, 46.6116503], [39.1927519, 46.6109131], [39.1939126, 46.6098376], [39.1948307, 46.6092106], [39.1956434, 46.6087533], [39.1966009, 46.6084975], [39.1975059, 46.6083885], [39.1984865, 46.6083814], [39.1990095, 46.6084349], [39.1995245, 46.6085233], [39.2004572, 46.6088215], [39.2014289, 46.6092345], [39.2019117, 46.609533], [39.2022802, 46.6098758], [39.2025018, 46.6102406], [39.2025447, 46.6106349], [39.2024725, 46.6110439], [39.2020082, 46.6116409], [39.2009974, 46.6132019], [39.2009139, 46.6136455], [39.201035, 46.6147366], [39.2013806, 46.6156648], [39.2019225, 46.6173793], [39.2022121, 46.6190179], [39.2024504, 46.6196296], [39.2027861, 46.6202061], [39.2032877, 46.6206243], [39.2041201, 46.6208526], [39.2054629, 46.6209797], [39.2072117, 46.6208159], [39.209095, 46.6205662], [39.2090946, 46.6255575], [39.2090842, 46.6305813], [39.2090356, 46.6376068], [39.2091697, 46.6446451], [39.2092754, 46.6586887], [39.2093614, 46.668157], [39.2093551, 46.6820408], [39.2231762, 46.681972], [39.2272858, 46.6819599], [39.1296233, 46.6041096]]], [[[39.2272858, 46.6819599], [39.2272191, 46.6842124], [39.227256, 46.685313], [39.2269213, 46.6977658], [39.2268951, 46.7043613], [39.2278905, 46.708289], [39.2618455, 46.7081987], [39.2617223, 46.729775], [39.2272858, 46.6819599]]], [[[39.2617223, 46.729775], [39.2617845, 46.7310701], [39.2620483, 46.7365589], [39.2620698, 46.7412355], [39.2620727, 46.7418679], [39.2620736, 46.7420608], [39.2620749, 46.7423494], [39.2620894, 46.7454924], [39.2620899, 46.745599], [39.2620906, 46.7457626], [39.2621212, 46.7524045], [39.2621223, 46.7526305], [39.2621266, 46.7535641], [39.2621346, 46.7553098], [39.262148, 46.7582245], [39.2617223, 46.729775]]], [[[39.262148, 46.7582245], [39.2623287, 46.7733089], [39.2625622, 46.7942943], [39.2971576, 46.7941578], [39.262148, 46.7582245]]], [[[39.2971576, 46.7941578], [39.2979148, 46.7941543], [39.2979644, 46.7941541], [39.3042889, 46.7941248], [39.3050212, 46.7941214], [39.305318, 46.79412], [39.3132555, 46.7942123], [39.3323715, 46.7944371], [39.3364298, 46.7944832], [39.3409762, 46.7945348], [39.3409468, 46.7992424], [39.3409454, 46.7994646], [39.3409452, 46.7994944], [39.3627399, 46.7993841], [39.3612595, 46.802455], [39.3671577, 46.8024386], [39.3660753, 46.801108], [39.3662993, 46.7998384], [39.2971576, 46.7941578]]], [[[39.4089758, 46.7961426], [39.408254, 46.7965487], [39.4076245, 46.7970279], [39.4068217, 46.7975109], [39.4058668, 46.7979369], [39.4044882, 46.7981609], [39.4029808, 46.7982527], [39.4012964, 46.7985245], [39.3994671, 46.7989284], [39.3983084, 46.7991745], [39.3971658, 46.7991047], [39.3960553, 46.7989247], [39.3954974, 46.7990092], [39.3937486, 46.7997179], [39.3923002, 46.7998649], [39.3907231, 46.7997987], [39.3890762, 46.799986], [39.3879926, 46.8001843], [39.3856376, 46.8006544], [39.3839964, 46.8010399], [39.3828652, 46.8011462], [39.3813534, 46.8010751], [39.3794364, 46.8007682], [39.3783743, 46.8004733], [39.3772584, 46.8000117], [39.3767488, 46.7997473], [39.3762097, 46.7997207], [39.3755537, 46.7998718], [39.3744002, 46.8002012], [39.3735258, 46.8007929], [39.3731278, 46.8009224], [39.3725499, 46.8008627], [39.3714434, 46.8005332], [39.3703675, 46.8000341], [39.3696946, 46.7996775], [39.3689026, 46.7995135], [39.3678612, 46.799524], [39.3662993, 46.7998384], [39.4089758, 46.7961426]]], [[[39.4089758, 46.7961426], [39.4094878, 46.7959905], [39.4101316, 46.7960272], [39.4107592, 46.7962953], [39.4112524, 46.796593], [39.4117999, 46.796703], [39.4126276, 46.7965609], [39.4148791, 46.7966883], [39.4165335, 46.7965818], [39.4177221, 46.796474], [39.4185736, 46.7965361], [39.4189936, 46.7968352], [39.4192779, 46.797129], [39.4195837, 46.7974889], [39.4199055, 46.79761], [39.4202703, 46.7976468], [39.4208175, 46.7976578], [39.421429, 46.797812], [39.4227329, 46.7985112], [39.4237647, 46.79896], [39.4260812, 46.7999008], [39.4287776, 46.8004963], [39.4317919, 46.8017147], [39.43638, 46.8027576], [39.4380898, 46.8034335], [39.4398426, 46.8040385], [39.4433927, 46.8046742], [39.4459928, 46.8056793], [39.4459978, 46.8075237], [39.4459622, 46.8115759], [39.4461005, 46.8180853], [39.4867759, 46.8177977], [39.486953, 46.8052503], [39.5017078, 46.8053786], [39.5065115, 46.8053951], [39.5129245, 46.8054403], [39.5652998, 46.8058096], [39.5646869, 46.7989755], [39.5642832, 46.7940888], [39.5638694, 46.7892957], [39.5637785, 46.7879535], [39.4089758, 46.7961426]]], [[[39.5637785, 46.7879535], [39.6112701, 46.7880205], [39.6113359, 46.7856633], [39.5637785, 46.7879535]]], [[[39.6113359, 46.7856633], [39.622764, 46.7858509], [39.6229268, 46.7882244], [39.6329093, 46.788293], [39.6113359, 46.7856633]]], [[[39.6329093, 46.788293], [39.6616959, 46.7884027], [39.690484, 46.788808], [39.7112851, 46.7884677], [39.7129116, 46.7892923], [39.7148329, 46.7894925], [39.7164252, 46.7898071], [39.7183412, 46.7912082], [39.7202789, 46.7915529], [39.7214293, 46.79086], [39.7219076, 46.7900463], [39.7220583, 46.7882056], [39.7226431, 46.7874335], [39.7238746, 46.787554], [39.7251263, 46.7886268], [39.7265835, 46.7898172], [39.7287015, 46.790981], [39.7309127, 46.7916085], [39.7318668, 46.7922769], [39.6329093, 46.788293]]], [[[39.7534009, 46.7874707], [39.7529146, 46.787544], [39.7518905, 46.787606], [39.751104, 46.7875711], [39.7502836, 46.787482], [39.7495989, 46.7872999], [39.7489596, 46.7873038], [39.7483372, 46.7874898], [39.7479694, 46.7877842], [39.7477091, 46.7882026], [39.7475054, 46.7887682], [39.7472791, 46.7894423], [39.7470245, 46.7898762], [39.7466567, 46.7902055], [39.7462607, 46.7906859], [39.7457684, 46.7910694], [39.7452648, 46.791387], [39.7446934, 46.7915149], [39.7443143, 46.7915885], [39.7437994, 46.7915807], [39.7433184, 46.7914761], [39.7426796, 46.7912737], [39.742498, 46.7912243], [39.7421359, 46.7912476], [39.7417851, 46.7913212], [39.7413278, 46.7915675], [39.7405912, 46.7922083], [39.7402065, 46.7924949], [39.7396973, 46.7927506], [39.737401, 46.7938152], [39.736557, 46.7939786], [39.7359176, 46.7940134], [39.7351312, 46.7939437], [39.7344465, 46.7938275], [39.7339033, 46.7936571], [39.7335016, 46.7934169], [39.7332979, 46.7931109], [39.7331904, 46.7927971], [39.732998, 46.7925143], [39.7327491, 46.7922703], [39.7325341, 46.7922083], [39.7322297, 46.7922139], [39.7320022, 46.7922625], [39.7318668, 46.7922769], [39.7534009, 46.7874707]]], [[[39.7534009, 46.7874707], [39.7540952, 46.7880854], [39.7572128, 46.7880583], [39.7574165, 46.7881242], [39.7575014, 46.7882404], [39.757575, 46.7885348], [39.7576938, 46.7887053], [39.7578579, 46.788837], [39.7581858, 46.7889262], [39.7745739, 46.7888966], [39.7904812, 46.7890721], [39.8145295, 46.7891354], [39.8408377, 46.7891075], [39.8411159, 46.7714627], [39.7534009, 46.7874707]]], [[[39.8411159, 46.7714627], [39.8673488, 46.7713599], [39.8411159, 46.7714627]]], [[[39.8673488, 46.7713599], [39.9442412, 46.7715336], [39.9831702, 46.7718127], [40.0002032, 46.7717801], [40.0632219, 46.7719415], [40.063257, 46.7419887], [40.0796783, 46.7418528], [40.0800059, 46.7329617], [40.0794285, 46.7322349], [40.0793283, 46.7311128], [40.0789479, 46.7296288], [40.082354, 46.7298082], [40.0844924, 46.7290296], [40.0859292, 46.7280905], [40.0882289, 46.728935], [40.0889363, 46.7288005], [40.0907406, 46.7273118], [40.0916826, 46.7272255], [40.0927788, 46.7277241], [40.0934136, 46.7285715], [40.0941821, 46.7291212], [40.0962537, 46.7301976], [40.0977667, 46.7304069], [40.0992608, 46.7303121], [40.1005263, 46.7296408], [40.1018837, 46.7296766], [40.1034499, 46.7301418], [40.1047551, 46.7302133], [40.1055374, 46.7359724], [40.1218722, 46.7360045], [39.8673488, 46.7713599]]], [[[40.1218722, 46.7360045], [40.1419781, 46.736044], [40.1457892, 46.7340044], [40.1434399, 46.7321437], [40.1379059, 46.7295672], [40.1359221, 46.729102], [40.1327374, 46.727778], [40.1278216, 46.7263922], [40.125577, 46.7270384], [40.1238292, 46.7267943], [40.1232372, 46.7260348], [40.1240185, 46.7249074], [40.1243063, 46.7237235], [40.1240596, 46.7222718], [40.1250323, 46.7217652], [40.1262594, 46.7220604], [40.127428, 46.7212405], [40.1218722, 46.7360045]]], [[[40.127428, 46.7212405], [40.1257825, 46.7181955], [40.1162904, 46.7181868], [40.1164976, 46.7003026], [40.1167619, 46.6999395], [40.1167803, 46.6822404], [40.11676, 46.6821528], [40.127428, 46.7212405]]], [[[40.11676, 46.6821528], [40.1163731, 46.6819041], [40.116848, 46.6634157], [40.1166579, 46.646098], [40.1034394, 46.6459223], [40.1036003, 46.6314519], [40.11676, 46.6821528]]], [[[40.1036003, 46.6314519], [40.1030598, 46.6311456], [40.1023608, 46.6308915], [40.1016206, 46.6308915], [40.1008394, 46.630962], [40.1003665, 46.6312303], [40.1000581, 46.631555], [40.0994619, 46.6318374], [40.098989, 46.6319785], [40.0981666, 46.6323032], [40.0974059, 46.6325856], [40.0968673, 46.6326985], [40.0962094, 46.6327166], [40.095762, 46.6326624], [40.095341, 46.6324455], [40.0950778, 46.6321655], [40.0950844, 46.6317436], [40.0952283, 46.6313342], [40.0952283, 46.6310377], [40.0948582, 46.6308401], [40.0943031, 46.6305859], [40.0937069, 46.6305295], [40.0930284, 46.6306848], [40.0920005, 46.6310518], [40.0911575, 46.6314613], [40.0906024, 46.6318742], [40.0903454, 46.6325977], [40.0900627, 46.6332507], [40.0893432, 46.6341154], [40.0889063, 46.6345212], [40.0882895, 46.6346095], [40.0877755, 46.6344859], [40.0870816, 46.6344506], [40.0861051, 46.6346977], [40.0856955, 46.6350208], [40.0850401, 46.6356782], [40.0840186, 46.6359517], [40.0829135, 46.6358458], [40.0821425, 46.6356164], [40.0816029, 46.6352635], [40.0812431, 46.6346282], [40.0807805, 46.6338518], [40.0804721, 46.6333224], [40.0800095, 46.6330224], [40.0795469, 46.6328812], [40.0784676, 46.6329341], [40.0777737, 46.6332341], [40.0770284, 46.6337459], [40.0763602, 46.6341341], [40.0755892, 46.63424], [40.0745613, 46.6342223], [40.0739188, 46.6342753], [40.0734305, 46.634487], [40.0724025, 46.6352988], [40.0716572, 46.6360046], [40.070655, 46.6360752], [40.069296, 46.63583], [40.0678142, 46.6357231], [40.1036003, 46.6314519]]], [[[40.0678142, 46.6357231], [40.0668823, 46.6280593], [40.0644057, 46.6280494], [40.0645914, 46.614909], [40.0646012, 46.5919249], [40.0580631, 46.5918874], [40.0678142, 46.6357231]]], [[[40.0580631, 46.5918874], [40.0643413, 46.5876852], [40.0644322, 46.5696446], [40.0645209, 46.5627866], [40.0644904, 46.5554049], [40.0644722, 46.5502342], [40.0645551, 46.5428474], [40.0643543, 46.5402512], [40.064291, 46.5343087], [40.0580631, 46.5918874]]], [[[40.0717346, 46.5361429], [40.0702831, 46.5360288], [40.0671119, 46.5347279], [40.0656252, 46.534416], [40.064291, 46.5343087], [40.0717346, 46.5361429]]], [[[40.0719554, 46.5361603], [40.0717346, 46.5361429], [40.0719554, 46.5361603]]], [[[40.1431263, 46.538802], [40.141292, 46.5392006], [40.1390377, 46.5402595], [40.1380303, 46.5408252], [40.1369096, 46.5412068], [40.1357071, 46.5413625], [40.134644, 46.5411739], [40.1326584, 46.5403353], [40.1310196, 46.5399908], [40.1295804, 46.5399908], [40.1286141, 46.5402595], [40.1278342, 46.5401407], [40.1269694, 46.5397928], [40.1260169, 46.5391295], [40.1252501, 46.538848], [40.1244894, 46.5391167], [40.1238109, 46.5395692], [40.1229269, 46.5398945], [40.1219195, 46.5403894], [40.1208687, 46.5406667], [40.1198018, 46.5408137], [40.1187533, 46.5408561], [40.1174968, 46.5406323], [40.1160395, 46.5401914], [40.1146003, 46.5394843], [40.1133873, 46.5387348], [40.1116898, 46.5378925], [40.1097894, 46.5373206], [40.1076941, 46.536886], [40.1045673, 46.5365286], [40.1025916, 46.5366427], [40.1010722, 46.5369953], [40.0995542, 46.5376463], [40.0980911, 46.5385793], [40.096619, 46.5392374], [40.0953362, 46.5396399], [40.0936295, 46.5397718], [40.0916583, 46.5397341], [40.0896412, 46.5393005], [40.0883749, 46.5389372], [40.0872769, 46.5385793], [40.0862078, 46.5377732], [40.0853032, 46.5367408], [40.084192, 46.5359029], [40.083165, 46.5353548], [40.0817875, 46.534789], [40.0804457, 46.534435], [40.0792176, 46.5343082], [40.0781058, 46.5344744], [40.0759982, 46.5352311], [40.0738721, 46.5359346], [40.0721104, 46.5361725], [40.0719554, 46.5361603], [40.1431263, 46.538802]]], [[[40.1432524, 46.5387746], [40.1431263, 46.538802], [40.1432524, 46.5387746]]], [[[40.2214541, 46.5378245], [40.2188458, 46.5380778], [40.2155038, 46.5376273], [40.2131308, 46.5370727], [40.2121751, 46.5368284], [40.2112211, 46.5367831], [40.2098858, 46.5367071], [40.2089514, 46.5365229], [40.2085238, 46.5361711], [40.2084086, 46.5358101], [40.2085129, 46.5348174], [40.208355, 46.5341367], [40.2078392, 46.5337167], [40.2071616, 46.5336133], [40.2058707, 46.5337479], [40.2044069, 46.5337818], [40.2028608, 46.5334763], [40.2014957, 46.5334763], [40.2005706, 46.5337314], [40.1978049, 46.5345952], [40.1957184, 46.535502], [40.1939058, 46.5364584], [40.1926131, 46.5372399], [40.1908631, 46.5385613], [40.1898499, 46.5391496], [40.189061, 46.5395037], [40.1882841, 46.539756], [40.1871656, 46.5398007], [40.1866027, 46.5397253], [40.1864946, 46.5397108], [40.1843017, 46.5391327], [40.1823707, 46.5386547], [40.1817972, 46.5384256], [40.1814419, 46.5378373], [40.1813601, 46.53718], [40.1818235, 46.5365158], [40.1824144, 46.5357309], [40.1827577, 46.5349499], [40.1826119, 46.5344954], [40.1825341, 46.5342529], [40.1812675, 46.5336348], [40.180034, 46.533212], [40.1785069, 46.5332295], [40.1776393, 46.5334473], [40.176784, 46.5338546], [40.1753745, 46.534702], [40.1740998, 46.5354568], [40.1725553, 46.5359231], [40.1719813, 46.5365429], [40.171455, 46.5372942], [40.1710955, 46.538017], [40.1707971, 46.5384708], [40.1701129, 46.5387786], [40.1694418, 46.53886], [40.1686787, 46.538851], [40.1677993, 46.5382209], [40.1672444, 46.5375386], [40.1666786, 46.5370226], [40.1658449, 46.53684], [40.1649681, 46.5370679], [40.1647106, 46.53776], [40.1641918, 46.5382174], [40.1634812, 46.5382627], [40.1628233, 46.5379459], [40.1619589, 46.5368663], [40.1613233, 46.5360542], [40.1598365, 46.5352757], [40.1588681, 46.5352378], [40.1576851, 46.535635], [40.1566334, 46.5360373], [40.1561432, 46.5365967], [40.15578, 46.5373245], [40.1550124, 46.5375584], [40.1542533, 46.5373562], [40.1529107, 46.5366747], [40.1520313, 46.5364552], [40.1512706, 46.5366674], [40.1502837, 46.5374735], [40.1491951, 46.5380069], [40.1477549, 46.5383362], [40.1459046, 46.538421], [40.1432524, 46.5387746], [40.2214541, 46.5378245]]], [[[40.2214541, 46.5378245], [40.2212605, 46.5228519], [40.2210435, 46.5024023], [40.2338698, 46.5023167], [40.2339882, 46.4969147], [40.238018, 46.4967907], [40.2379982, 46.4898966], [40.2379894, 46.4810773], [40.2378851, 46.4698821], [40.2383365, 46.4482403], [40.2214541, 46.5378245]]], [[[40.2383365, 46.4482403], [40.2599649, 46.4485974], [40.2383365, 46.4482403]]], [[[40.2599649, 46.4485974], [40.2859941, 46.4484447], [40.2859906, 46.4401673], [40.285831, 46.4336655], [40.2857071, 46.409576], [40.28613, 46.3763464], [40.2814572, 46.3762511], [40.276554, 46.3762533], [40.2665522, 46.3761553], [40.2605818, 46.3762211], [40.2606409, 46.3676991], [40.2475454, 46.3677101], [40.2474266, 46.3634321], [40.2472941, 46.348587], [40.2472644, 46.3457148], [40.2474773, 46.3452568], [40.2599649, 46.4485974]]], [[[40.2525288, 46.344949], [40.2518243, 46.3447688], [40.2509583, 46.3447027], [40.2498807, 46.3447716], [40.2488426, 46.3449793], [40.2474773, 46.3452568], [40.2525288, 46.344949]]], [[[40.2722389, 46.344489], [40.2715526, 46.3445512], [40.2707942, 46.3447716], [40.2698763, 46.3451298], [40.2685193, 46.3452537], [40.2669428, 46.3453088], [40.2658652, 46.345364], [40.2643286, 46.3454742], [40.2627122, 46.345543], [40.2612355, 46.3457221], [40.2601379, 46.3456946], [40.2588408, 46.3455981], [40.2580425, 46.3457083], [40.2567255, 46.3459287], [40.2557676, 46.3459563], [40.254251, 46.3456119], [40.2529339, 46.3451849], [40.2525288, 46.344949], [40.2722389, 46.344489]]], [[[40.2722389, 46.344489], [40.2722748, 46.3144931], [40.3064061, 46.3144262], [40.3242771, 46.3143399], [40.3242719, 46.2990553], [40.3241992, 46.2925204], [40.3240567, 46.2829579], [40.2722389, 46.344489]]], [[[40.4032225, 46.2723238], [40.4016128, 46.2725022], [40.400485, 46.2726207], [40.3992907, 46.2730288], [40.3987975, 46.273473], [40.397556, 46.2740639], [40.396111, 46.2743452], [40.3955559, 46.2744], [40.3946002, 46.2744407], [40.3933355, 46.274447], [40.3928139, 46.2743874], [40.3918539, 46.2742753], [40.3908673, 46.2741834], [40.3902893, 46.2742953], [40.3896389, 46.2746688], [40.3882983, 46.2752326], [40.3875898, 46.2754177], [40.3869942, 46.2754444], [40.3861287, 46.2753155], [40.3855151, 46.2752676], [40.3845654, 46.2754041], [40.3837326, 46.2756914], [40.3828343, 46.2761195], [40.3817922, 46.2765786], [40.3808153, 46.2769748], [40.3803091, 46.2771868], [40.3790308, 46.277722], [40.3774547, 46.2782712], [40.3754748, 46.2788473], [40.3744198, 46.2790184], [40.3733517, 46.2791624], [40.3730288, 46.2792007], [40.3725181, 46.2792614], [40.3717396, 46.2792487], [40.3712958, 46.2791874], [40.3708787, 46.2789741], [40.3705527, 46.2786604], [40.370211, 46.2781723], [40.3697682, 46.2777477], [40.3694344, 46.2775189], [40.3690523, 46.2773844], [40.3679808, 46.2772959], [40.3667644, 46.2773873], [40.3654028, 46.2776912], [40.3642717, 46.2783077], [40.3632687, 46.2787384], [40.3621419, 46.2792045], [40.3611858, 46.2795851], [40.3603535, 46.2797414], [40.35947, 46.2797031], [40.35877, 46.279647], [40.3576301, 46.279581], [40.356478, 46.2798063], [40.3552103, 46.2802606], [40.3540963, 46.2805762], [40.353072, 46.2808299], [40.35215, 46.2809096], [40.3512025, 46.2808624], [40.3500501, 46.2805379], [40.3493117, 46.2803108], [40.3479672, 46.2800335], [40.3475416, 46.2799869], [40.3467614, 46.2799016], [40.3452142, 46.2799339], [40.3434602, 46.279957], [40.3425621, 46.2800203], [40.3422998, 46.2800537], [40.3413328, 46.2802105], [40.3401991, 46.280192], [40.3389653, 46.2800169], [40.3377982, 46.2798832], [40.336331, 46.2797772], [40.3351106, 46.2797219], [40.3337968, 46.2797772], [40.3327564, 46.2797449], [40.3314159, 46.2796574], [40.3305689, 46.2796435], [40.329662, 46.2798602], [40.3285416, 46.280381], [40.3273878, 46.2810078], [40.3264141, 46.2816623], [40.324815, 46.2826029], [40.3240567, 46.2829579], [40.4032225, 46.2723238]]], [[[40.4225593, 46.2734423], [40.4199624, 46.2737862], [40.4180248, 46.2737749], [40.4159733, 46.2734261], [40.4139706, 46.2730209], [40.4108445, 46.2723344], [40.4080929, 46.2721318], [40.4032225, 46.2723238], [40.4225593, 46.2734423]]], [[[40.4640967, 46.2735535], [40.4623383, 46.2735328], [40.4611503, 46.2733815], [40.4599416, 46.2733239], [40.4591705, 46.2733095], [40.4582222, 46.2733671], [40.4577429, 46.2734823], [40.4571176, 46.2735544], [40.4562944, 46.2735328], [40.4555233, 46.2734967], [40.4548356, 46.2734967], [40.4543354, 46.2734031], [40.4537623, 46.2731582], [40.45321, 46.2730286], [40.4527619, 46.2730142], [40.4522409, 46.2730934], [40.4515427, 46.273115], [40.4511989, 46.2730718], [40.4506466, 46.2727837], [40.4501151, 46.2724955], [40.449667, 46.2724595], [40.4480929, 46.2725863], [40.4475204, 46.2726324], [40.4456656, 46.2728989], [40.4444985, 46.2732158], [40.4436441, 46.2735976], [40.4431439, 46.2737921], [40.4428104, 46.2739433], [40.4423415, 46.2740297], [40.4412474, 46.2738569], [40.4401419, 46.27346], [40.4395437, 46.2732631], [40.4384003, 46.2732509], [40.43738, 46.2733748], [40.4362337, 46.2734733], [40.434864, 46.2733449], [40.4337394, 46.2731484], [40.4326663, 46.2730014], [40.431697, 46.2729975], [40.4307227, 46.273043], [40.4299802, 46.2730587], [40.4282984, 46.2731679], [40.4267645, 46.2731266], [40.4259378, 46.2731251], [40.425402, 46.2731539], [40.4243142, 46.2732302], [40.4225593, 46.2734423], [40.4640967, 46.2735535]]], [[[40.464524, 46.2736072], [40.4640967, 46.2735535], [40.464524, 46.2736072]]], [[[40.5130798, 46.2739586], [40.511184, 46.2737898], [40.5097349, 46.273621], [40.5084974, 46.2737786], [40.5079276, 46.2740036], [40.5076182, 46.2746114], [40.5072437, 46.2748477], [40.5063645, 46.2750053], [40.5053225, 46.2748364], [40.5045898, 46.2743975], [40.5040525, 46.2739361], [40.5034826, 46.2736435], [40.5025871, 46.2734634], [40.5018056, 46.2733847], [40.5013334, 46.2732383], [40.5010403, 46.2730583], [40.5004542, 46.273002], [40.5000634, 46.2731821], [40.5000288, 46.2732122], [40.4994936, 46.2736773], [40.4990539, 46.2741499], [40.4985988, 46.2742264], [40.4980087, 46.2742264], [40.4974133, 46.2739075], [40.4968178, 46.2735664], [40.4953319, 46.273266], [40.4942345, 46.2733059], [40.4931273, 46.2734859], [40.4923947, 46.2738348], [40.4915643, 46.2739924], [40.4901644, 46.2739957], [40.4893633, 46.2738], [40.4886987, 46.2736097], [40.4876566, 46.2734409], [40.48681, 46.273756], [40.4852306, 46.2739474], [40.4838467, 46.2738686], [40.4820394, 46.2737898], [40.4803949, 46.2738461], [40.4782294, 46.2740374], [40.4759988, 46.2740374], [40.4744194, 46.2738911], [40.4723354, 46.2739136], [40.4704467, 46.2738798], [40.4679718, 46.2738911], [40.465269, 46.2736885], [40.464524, 46.2736072], [40.5130798, 46.2739586]]], [[[40.5372676, 46.2726677], [40.5359003, 46.2730856], [40.5346787, 46.2731596], [40.5333762, 46.2729345], [40.5325295, 46.2728557], [40.5313409, 46.273002], [40.5308525, 46.2733059], [40.5301035, 46.2733621], [40.5292894, 46.2733396], [40.528687, 46.2731483], [40.5275147, 46.2731145], [40.5272379, 46.2731596], [40.5267332, 46.2733734], [40.5259764, 46.2736606], [40.5258061, 46.2736964], [40.5248282, 46.2739023], [40.5230697, 46.2738686], [40.5224999, 46.2738911], [40.5213764, 46.2740374], [40.5204321, 46.2740712], [40.519732, 46.2739361], [40.5186411, 46.2735084], [40.5177944, 46.2730133], [40.517192, 46.273002], [40.5162313, 46.273666], [40.5152382, 46.2740712], [40.5145543, 46.2741724], [40.5130798, 46.2739586], [40.5372676, 46.2726677]]], [[[40.5372676, 46.2726677], [40.5413181, 46.274038], [40.5434339, 46.2745166], [40.545291, 46.2752024], [40.5475168, 46.2759569], [40.5491937, 46.2767351], [40.5547071, 46.2796117], [40.558852, 46.281653], [40.5597666, 46.282517], [40.5605155, 46.2830396], [40.5632885, 46.2842632], [40.5652618, 46.2853476], [40.566432, 46.2862794], [40.5676277, 46.2865783], [40.5693068, 46.2868595], [40.5704262, 46.2868595], [40.5714271, 46.2873936], [40.5724105, 46.2874186], [40.5741201, 46.2872498], [40.5758908, 46.2871514], [40.5770509, 46.2871092], [40.5781906, 46.2873764], [40.5789844, 46.2874327], [40.5801241, 46.2873061], [40.5813859, 46.2872217], [40.5839967, 46.2864029], [40.5848564, 46.2863988], [40.5372676, 46.2726677]]], [[[40.5848564, 46.2863988], [40.6083123, 46.2862873], [40.6349285, 46.2861568], [40.6359305, 46.2861445], [40.5848564, 46.2863988]]], [[[40.6359305, 46.2861445], [40.6481321, 46.2860689], [40.670784, 46.285994], [40.6742881, 46.2859245], [40.6359305, 46.2861445]]], [[[40.6742881, 46.2859245], [40.7435255, 46.2855493], [40.6742881, 46.2859245]]], [[[40.7435255, 46.2855493], [40.7438024, 46.2853995], [40.7439367, 46.2739576], [40.7441104, 46.2604371], [40.7444897, 46.2290633], [40.8095337, 46.2294041], [40.8744425, 46.2298376], [40.8998123, 46.2299122], [40.925714, 46.2299941], [40.9257054, 46.2482215], [40.9255568, 46.2701419], [40.9254185, 46.2864077], [40.9255711, 46.2887568], [40.9255346, 46.2952768], [40.9271282, 46.298231], [40.7435255, 46.2855493]]], [[[40.9271282, 46.298231], [40.9301887, 46.2968239], [40.9313724, 46.2967294], [40.9335012, 46.2971578], [40.934423, 46.2971172], [40.9376146, 46.2967731], [40.9384822, 46.2968865], [40.9392223, 46.2972948], [40.940115, 46.2975862], [40.9411127, 46.2973916], [40.9427789, 46.2954888], [40.9446215, 46.2946006], [40.94475, 46.2939788], [40.9461213, 46.2938011], [40.9476649, 46.2931965], [40.9487749, 46.293245], [40.9502836, 46.2929022], [40.9507492, 46.2925576], [40.9518912, 46.2918795], [40.9529774, 46.2918766], [40.9537972, 46.2922881], [40.9544343, 46.2927648], [40.9588051, 46.2927352], [40.9609477, 46.2932386], [40.9637956, 46.2930309], [40.9645239, 46.2932878], [40.9649127, 46.2936581], [40.965392, 46.2942446], [40.9667754, 46.2951631], [40.9677068, 46.2952871], [40.9698178, 46.2951927], [40.9710757, 46.2954727], [40.9720471, 46.2960154], [40.9730553, 46.2961762], [40.9741139, 46.2961725], [40.975602, 46.2960725], [40.9767168, 46.2961994], [40.9777101, 46.2964866], [40.9823446, 46.2973078], [40.9864011, 46.2981238], [40.9904218, 46.2983631], [40.9271282, 46.298231]]], [[[40.9904218, 46.2983631], [40.990664, 46.271308], [40.9907203, 46.2666942], [40.991062, 46.238702], [40.9908934, 46.2259457], [40.9912509, 46.2074023], [40.9718931, 46.2073008], [40.9720328, 46.194156], [40.9657756, 46.1942077], [40.9657555, 46.1939559], [40.966174, 46.1936732], [40.96708, 46.1932941], [40.9673117, 46.1927376], [40.9672696, 46.1919997], [40.9665148, 46.191107], [40.9665848, 46.1901401], [40.9669461, 46.1893458], [40.9677762, 46.1890879], [40.9702038, 46.1888518], [40.9732006, 46.1884597], [40.9745341, 46.1879975], [40.9755345, 46.187666], [40.9764221, 46.1876751], [40.977259, 46.1877737], [40.9781481, 46.1878898], [40.9785865, 46.1877212], [40.9785542, 46.1817726], [40.9904218, 46.2983631]]], [[[40.9785542, 46.1817726], [40.9788381, 46.1418063], [40.9790767, 46.1331793], [40.9791113, 46.1178945], [40.9789239, 46.1155212], [40.9787882, 46.1134055], [40.9812859, 46.1135176], [40.9842842, 46.1130633], [40.9860264, 46.1132666], [40.987094, 46.1138759], [40.987804, 46.1144989], [40.9882441, 46.1152601], [40.9896392, 46.115952], [40.9914205, 46.1163559], [40.9933679, 46.1162039], [40.9949126, 46.1156399], [40.9968124, 46.1149053], [40.9984618, 46.1148429], [40.9997271, 46.1156684], [41.0001525, 46.116647], [41.0013181, 46.1183103], [41.0022094, 46.1189757], [41.0032035, 46.1191183], [41.0042042, 46.1187034], [41.0056526, 46.1178135], [41.0075572, 46.1169321], [41.009381, 46.1169797], [41.0106767, 46.1174549], [41.0124933, 46.1177569], [41.0147648, 46.1177569], [41.0159077, 46.1178892], [41.0170464, 46.1181832], [41.0208981, 46.1196086], [41.0223666, 46.1199977], [41.0238856, 46.1201429], [41.0258429, 46.1199685], [41.0277536, 46.119532], [41.0291757, 46.1194656], [41.0302041, 46.1195596], [41.0311152, 46.119809], [41.0341757, 46.1207743], [41.038459, 46.1219984], [41.0406646, 46.1223634], [41.0431351, 46.1224645], [41.0448783, 46.1225003], [41.0466178, 46.1219795], [41.047874, 46.1212682], [41.0489318, 46.1203459], [41.0501125, 46.1196709], [41.0518028, 46.1192172], [41.053207, 46.1191689], [41.0547688, 46.1193546], [41.0560052, 46.119785], [41.0573734, 46.1202271], [41.0609168, 46.1204924], [41.0638423, 46.1204169], [41.0649764, 46.1201291], [41.0657592, 46.1192636], [41.0663037, 46.1176026], [41.066683, 46.1166533], [41.0671489, 46.1156215], [41.0683263, 46.1141121], [41.0695134, 46.1133303], [40.9785542, 46.1817726]]], [[[41.0695134, 46.1133303], [41.0695705, 46.1047353], [41.0695956, 46.0912523], [41.0696389, 46.0865406], [41.069777, 46.0775708], [41.1082242, 46.0776194], [41.1084405, 46.0597415], [41.1218425, 46.0596109], [41.0695134, 46.1133303]]], [[[41.1218425, 46.0596109], [41.1216892, 46.0418799], [41.1218425, 46.0596109]]], [[[41.1216892, 46.0418799], [41.1216166, 46.0326137], [41.1217922, 46.0056789], [41.134752, 46.0056932], [41.1347908, 45.99883], [41.1350529, 45.9791845], [41.16065, 45.9789676], [41.1608482, 45.9571932], [41.1608983, 45.9516883], [41.1216892, 46.0418799]]], [[[41.1612399, 45.8906325], [41.1609907, 45.9279011], [41.1609666, 45.9341101], [41.1608983, 45.9516883], [41.1612399, 45.8906325]]], [[[41.2475133, 45.7589362], [41.2581603, 45.7588921], [41.2721359, 45.7588342], [41.2727983, 45.7948098], [41.260045, 45.7949469], [41.2601785, 45.8043545], [41.2577083, 45.8044367], [41.2575476, 45.8058556], [41.258726, 45.8065277], [41.2597973, 45.8079838], [41.2597973, 45.8097013], [41.2592081, 45.8117175], [41.2566287, 45.8145175], [41.2567228, 45.8154607], [41.257537, 45.8172228], [41.2569371, 45.818059], [41.2537233, 45.8196418], [41.2472099, 45.8222996], [41.2430534, 45.822867], [41.2406109, 45.8223892], [41.239209, 45.8227512], [41.2380082, 45.8255111], [41.234923, 45.8281089], [41.233466, 45.8313933], [41.2337231, 45.8324681], [41.2351801, 45.8334832], [41.2394651, 45.8345282], [41.2403385, 45.8352278], [41.2403222, 45.8363195], [41.2391652, 45.8378421], [41.2390366, 45.8385586], [41.2397222, 45.8392153], [41.2419933, 45.8401109], [41.2429789, 45.8409468], [41.2435234, 45.8417419], [41.2428779, 45.8429408], [41.2404783, 45.8445527], [41.2391071, 45.8454781], [41.2386357, 45.8466422], [41.239407, 45.8472989], [41.2409068, 45.8478361], [41.2444634, 45.848254], [41.2470773, 45.8486719], [41.2496055, 45.8491495], [41.2507321, 45.8494898], [41.2541049, 45.8528803], [41.2609182, 45.8556857], [41.2628036, 45.8572675], [41.2617752, 45.8589088], [41.2603611, 45.8599235], [41.2593327, 45.8610873], [41.259247, 45.8630269], [41.2580114, 45.8639331], [41.2553977, 45.8643704], [41.2547494, 45.8651325], [41.2557092, 45.8671568], [41.2557915, 45.868188], [41.2552156, 45.869181], [41.2539266, 45.8696965], [41.2522537, 45.8698111], [41.2508277, 45.8695247], [41.2502517, 45.8687799], [41.250334, 45.8674241], [41.250718, 45.8659919], [41.2500949, 45.8652656], [41.2489062, 45.8651115], [41.2490098, 45.8800514], [41.1611772, 45.8798408], [41.1612399, 45.8906325], [41.2475133, 45.7589362]]], [[[41.1300082, 45.6747943], [41.1672375, 45.6744391], [41.1693736, 45.7596507], [41.2423106, 45.7590712], [41.2475133, 45.7589362], [41.1300082, 45.6747943]]], [[[40.9116305, 45.6939517], [40.938195, 45.6938388], [40.9630339, 45.6937333], [40.9634575, 45.7059515], [40.9646745, 45.7072658], [40.9674598, 45.7075052], [40.9704165, 45.7089715], [40.9733304, 45.7097794], [40.974873, 45.7106172], [40.9753443, 45.7119936], [40.9790724, 45.7136093], [40.9810913, 45.7135338], [40.981472, 45.7135196], [40.9836574, 45.7132802], [40.9866998, 45.7120834], [40.9880907, 45.7118247], [40.9901493, 45.7128773], [40.9921204, 45.7128473], [40.9943055, 45.7118841], [40.9991479, 45.7098851], [41.0006477, 45.7098253], [41.0020618, 45.7104536], [41.003433, 45.712608], [41.0053284, 45.7131804], [41.0077442, 45.7130575], [41.0093036, 45.7120395], [41.0095607, 45.7110221], [41.0091751, 45.7089276], [41.009815, 45.7075187], [41.0150885, 45.7071322], [41.017231, 45.706414], [41.0187736, 45.7053068], [41.0205734, 45.7033916], [41.0213777, 45.7029527], [41.0233158, 45.7018953], [41.0257155, 45.7012967], [41.0290512, 45.7008122], [41.0326145, 45.6984835], [41.0331715, 45.6973163], [41.032887, 45.6962667], [41.0302302, 45.694441], [41.0291101, 45.6931989], [41.0308302, 45.6930941], [41.0532558, 45.6931321], [41.0531344, 45.6750018], [41.063324, 45.6750273], [41.1226429, 45.6746915], [41.1300082, 45.6747943], [40.9116305, 45.6939517]]], [[[40.8479682, 45.694229], [40.9116305, 45.6939517], [40.8479682, 45.694229]]], [[[40.846552, 45.5705421], [40.8479682, 45.694229], [40.846552, 45.5705421]]], [[[40.8460433, 45.5169199], [40.8463558, 45.5533855], [40.846552, 45.5705421], [40.8460433, 45.5169199]]], [[[40.9735503, 45.414358], [40.9748107, 45.4145399], [40.9750195, 45.4119305], [40.9769408, 45.4123703], [40.978319, 45.4124876], [40.9792796, 45.4137483], [40.9788473, 45.4156596], [40.9794049, 45.4175303], [40.9806067, 45.4205905], [40.9804073, 45.4224553], [40.9784026, 45.4244194], [40.9762777, 45.4255623], [40.972973, 45.4258264], [40.9725971, 45.4266764], [40.9714694, 45.427292], [40.9675003, 45.4280422], [40.9616929, 45.4282132], [40.9584685, 45.4309], [40.9573199, 45.4312664], [40.9542919, 45.4323655], [40.9511594, 45.4322922], [40.9511072, 45.4336844], [40.9499587, 45.4347835], [40.9476783, 45.4354613], [40.9442681, 45.4356627], [40.9406382, 45.4358546], [40.9396216, 45.4386666], [40.936437, 45.4403883], [40.9356539, 45.4414872], [40.9344009, 45.4421832], [40.9341921, 45.4429891], [40.9323126, 45.4437217], [40.9316861, 45.4444909], [40.9313548, 45.4461426], [40.9289191, 45.4467252], [40.927614, 45.4472013], [40.9258389, 45.4469816], [40.9224905, 45.4471008], [40.922882, 45.4691444], [40.9230516, 45.4867402], [40.9230843, 45.4904973], [40.9231754, 45.516862], [40.9112333, 45.5167508], [40.9071546, 45.5165794], [40.9040548, 45.5169795], [40.8985078, 45.5159506], [40.8909214, 45.5156648], [40.8822909, 45.5147641], [40.8749238, 45.5166325], [40.8713345, 45.5166325], [40.8635034, 45.5175471], [40.8604624, 45.5167638], [40.8577117, 45.5173184], [40.8543228, 45.5168223], [40.8506056, 45.5171442], [40.8473812, 45.5169392], [40.8460433, 45.5169199], [40.9735503, 45.414358]]], [[[41.0212406, 45.2974448], [41.0206224, 45.2992611], [41.0197003, 45.3018305], [41.0225332, 45.3038231], [41.0246085, 45.3057229], [41.0220346, 45.3077142], [41.0161208, 45.3092294], [41.0150635, 45.3111343], [41.014891, 45.3114451], [41.0149344, 45.3128176], [41.016011, 45.3164487], [41.014859, 45.3179739], [41.0099225, 45.3193659], [41.0063836, 45.3176163], [41.0028753, 45.3174333], [41.0026135, 45.3195359], [41.00642, 45.3217105], [41.0065954, 45.3237185], [41.0048062, 45.3245649], [40.9999414, 45.3221783], [40.9963486, 45.3209309], [40.9941109, 45.3217846], [40.9934772, 45.322803], [40.9976538, 45.3270976], [41.0025707, 45.3297594], [41.0031057, 45.3335452], [40.9985413, 45.3360896], [40.9944559, 45.3389618], [40.9945213, 45.34053], [40.9997421, 45.3417409], [41.0020755, 45.3432786], [41.0009092, 45.3465926], [41.0071959, 45.3495026], [41.0050206, 45.3527841], [41.0004912, 45.3563453], [40.9981683, 45.3634226], [40.9926866, 45.3621388], [40.9894889, 45.3638353], [40.9919687, 45.3672282], [40.9984114, 45.3672207], [41.0012033, 45.367913], [41.0013758, 45.3715621], [40.9995486, 45.3754496], [41.0071945, 45.3732388], [41.0071564, 45.3780887], [41.004798, 45.3796426], [40.9956537, 45.3773156], [40.9910388, 45.3772832], [40.9914564, 45.3795569], [40.9944235, 45.3828926], [40.994256, 45.3895018], [40.9953198, 45.3930134], [40.9942629, 45.3935115], [40.9895587, 45.3957283], [40.9848608, 45.3949263], [40.9791445, 45.3904808], [40.9740332, 45.3925391], [40.9777539, 45.397594], [40.9757517, 45.4017474], [40.9816168, 45.4020085], [40.9791741, 45.4070386], [40.973484, 45.4115337], [40.9735503, 45.414358], [41.0212406, 45.2974448]]], [[[41.0308518, 45.2348726], [41.0274564, 45.2392728], [41.0278424, 45.2417304], [41.0296119, 45.2436706], [41.0320265, 45.2464734], [41.035159, 45.2486788], [41.035159, 45.2506084], [41.0370515, 45.2523542], [41.037443, 45.2543756], [41.0383567, 45.2557079], [41.0388466, 45.2556243], [41.0349632, 45.2584182], [41.0330639, 45.2584538], [41.0313087, 45.2590154], [41.029873, 45.2588775], [41.0275889, 45.2577751], [41.0249133, 45.257821], [41.021898, 45.2559821], [41.0201494, 45.257821], [41.0181916, 45.2583263], [41.0174737, 45.259245], [41.0174737, 45.2607609], [41.0176756, 45.2630238], [41.0168837, 45.2634004], [41.0185644, 45.2637583], [41.0205358, 45.2649342], [41.0221061, 45.2651928], [41.0239185, 45.2640349], [41.0249462, 45.2643462], [41.0276139, 45.2666182], [41.0272851, 45.2690024], [41.0277072, 45.2715013], [41.0235556, 45.2722583], [41.0229749, 45.2713774], [41.0217052, 45.271495], [41.0195668, 45.2728353], [41.0179058, 45.2727231], [41.017438, 45.2715474], [41.0154667, 45.2712652], [41.0131612, 45.2720647], [41.0129607, 45.273452], [41.0135956, 45.274369], [41.0138963, 45.2758033], [41.0113569, 45.2756857], [41.0112567, 45.2764852], [41.0141302, 45.277167], [41.0145311, 45.2778253], [41.0156909, 45.2773967], [41.0218723, 45.2748104], [41.0269892, 45.2741075], [41.0298627, 45.2753537], [41.0336717, 45.2766234], [41.034908, 45.2780341], [41.0345739, 45.2790686], [41.0330703, 45.2801736], [41.0315667, 45.2797269], [41.0291944, 45.2792332], [41.0273898, 45.2790036], [41.0262541, 45.2796564], [41.0230973, 45.2797363], [41.021301, 45.2806391], [41.0203174, 45.2817074], [41.0239527, 45.2803833], [41.0260202, 45.2805968], [41.0275426, 45.281126], [41.0291306, 45.2812915], [41.0311344, 45.2804632], [41.0320325, 45.2807943], [41.0317117, 45.282013], [41.0304254, 45.2825845], [41.0266514, 45.2873767], [41.0275937, 45.2892977], [41.0274601, 45.290332], [41.0257894, 45.2906611], [41.0233578, 45.2886371], [41.0240854, 45.2913663], [41.0221669, 45.292092], [41.0202869, 45.2914926], [41.0202027, 45.2922227], [41.0197375, 45.29387], [41.019372, 45.2949718], [41.0200507, 45.2954492], [41.0212406, 45.2974448], [41.0308518, 45.2348726]]], [[[41.1370146, 45.2246213], [41.0602475, 45.2251396], [41.0361393, 45.2252918], [41.0354076, 45.2256431], [41.0370535, 45.2276472], [41.0373882, 45.2282955], [41.0369452, 45.2295352], [41.0308518, 45.2348726], [41.1370146, 45.2246213]]], [[[41.2789967, 45.2638468], [41.2651122, 45.2579604], [41.2648312, 45.2506795], [41.258531, 45.2507513], [41.2582609, 45.2328494], [41.2328846, 45.2330008], [41.232713, 45.2239852], [41.1370146, 45.2246213], [41.2789967, 45.2638468]]], [[[41.2789967, 45.2638468], [41.2794776, 45.2621502], [41.2799783, 45.2610048], [41.2808754, 45.2599035], [41.2819749, 45.2591721], [41.2828156, 45.2583175], [41.283212, 45.2575245], [41.2833677, 45.2573437], [41.2834119, 45.257182], [41.2833261, 45.2564107], [41.2839005, 45.2553362], [41.2857573, 45.2532508], [41.2862098, 45.2529481], [41.2862574, 45.2528248], [41.2875306, 45.2511799], [41.2886438, 45.249261], [41.2888032, 45.2477283], [41.2881565, 45.24576], [41.2883651, 45.2445555], [41.290309, 45.2431402], [41.2904645, 45.2420008], [41.2902701, 45.2417706], [41.2896377, 45.2405747], [41.2898255, 45.2394435], [41.2903434, 45.2385458], [41.2903865, 45.238471], [41.2906391, 45.2380332], [41.2905765, 45.236667], [41.2906136, 45.236049], [41.2906274, 45.2358182], [41.2906391, 45.2356239], [41.2917448, 45.2342723], [41.2934973, 45.2333761], [41.2941649, 45.23295], [41.2942066, 45.2322742], [41.2935182, 45.2314367], [41.29349, 45.2312853], [41.2934383, 45.2310083], [41.2932469, 45.2299821], [41.2933545, 45.2292866], [41.2933793, 45.2291263], [41.2934764, 45.2284981], [41.2950829, 45.2255154], [41.2974904, 45.2235689], [41.2789967, 45.2638468]]], [[[41.3533377, 45.2143651], [41.3534804, 45.2230539], [41.344022, 45.2231925], [41.2974904, 45.2235689], [41.3533377, 45.2143651]]], [[[41.352481, 45.1508925], [41.3526172, 45.161197], [41.3529515, 45.1778773], [41.365587, 45.177906], [41.3659108, 45.186898], [41.3531712, 45.186895], [41.3533377, 45.2143651], [41.352481, 45.1508925]]], [[[41.3514443, 45.0913906], [41.352481, 45.1508925], [41.3514443, 45.0913906]]], [[[41.402584, 45.0666468], [41.4012796, 45.0668112], [41.4007042, 45.0673532], [41.400324, 45.0674575], [41.4000456, 45.0675214], [41.4001638, 45.0678955], [41.3999884, 45.0680349], [41.3996021, 45.0680551], [41.3991068, 45.0677957], [41.3986976, 45.0679498], [41.3985857, 45.0681139], [41.3985409, 45.0690981], [41.3983361, 45.0692808], [41.3979299, 45.0693588], [41.3969301, 45.0691066], [41.3966495, 45.0692322], [41.3966644, 45.0694887], [41.396856, 45.0701803], [41.396742, 45.0707234], [41.3961934, 45.0709764], [41.3953329, 45.0710858], [41.3951761, 45.0712012], [41.3950747, 45.0718151], [41.3951005, 45.0722405], [41.3952459, 45.0724557], [41.3951866, 45.0726051], [41.3950454, 45.072677], [41.3942419, 45.0728167], [41.3939316, 45.0729155], [41.3937925, 45.0730452], [41.3934801, 45.0742115], [41.3921654, 45.0749365], [41.39095, 45.0759665], [41.3899316, 45.0772689], [41.3896959, 45.0772523], [41.3894282, 45.0771148], [41.3886494, 45.077137], [41.3881463, 45.077395], [41.3877669, 45.0782617], [41.3870003, 45.0785113], [41.3861051, 45.0784528], [41.384496, 45.0780986], [41.3836312, 45.0782956], [41.3832625, 45.0787898], [41.383003, 45.0793224], [41.3827792, 45.0796627], [41.3824874, 45.0797533], [41.3818958, 45.0795584], [41.3815658, 45.0796384], [41.3808716, 45.0798302], [41.3803762, 45.0800385], [41.3801287, 45.0803675], [41.3795583, 45.0812307], [41.3793973, 45.0814309], [41.3790841, 45.0815064], [41.3779688, 45.081358], [41.3774069, 45.0814785], [41.3771168, 45.0818259], [41.3767499, 45.0819526], [41.3760623, 45.0821622], [41.3757916, 45.0827495], [41.3754646, 45.0830533], [41.374936, 45.0831325], [41.3744147, 45.0830229], [41.3740244, 45.0828204], [41.3737349, 45.0829074], [41.3737349, 45.0830654], [41.3738296, 45.0832963], [41.3738554, 45.0835029], [41.373522, 45.0836569], [41.37284, 45.0837399], [41.3725164, 45.0840382], [41.3721515, 45.084633], [41.3714905, 45.0850097], [41.370852, 45.0851372], [41.3703214, 45.0852432], [41.3689323, 45.0860437], [41.3680609, 45.0862563], [41.3678516, 45.0863963], [41.3674199, 45.0864681], [41.366776, 45.0863687], [41.3667073, 45.0869576], [41.366246, 45.0871762], [41.3655593, 45.0871915], [41.364131, 45.0866557], [41.3633053, 45.0868448], [41.361941, 45.0871393], [41.3612744, 45.0875854], [41.3606942, 45.0875066], [41.3607165, 45.0884519], [41.360051, 45.0884488], [41.3593348, 45.0882563], [41.3587811, 45.0879766], [41.3581536, 45.0876596], [41.3577405, 45.0873721], [41.3573932, 45.0873428], [41.3572728, 45.0875391], [41.3571351, 45.0879383], [41.3569061, 45.0884153], [41.3563922, 45.0886478], [41.3556159, 45.0885974], [41.3550393, 45.0888169], [41.3547858, 45.0892323], [41.3547514, 45.0895559], [41.3545104, 45.0895604], [41.3542097, 45.08939], [41.353821, 45.088721], [41.35345, 45.0886649], [41.3531163, 45.0888921], [41.3531128, 45.089148], [41.3537073, 45.0898014], [41.3541042, 45.0901977], [41.3540715, 45.0903806], [41.353822, 45.0905021], [41.3535982, 45.0905477], [41.3533678, 45.0904971], [41.3521626, 45.0900559], [41.351946, 45.0901072], [41.3518725, 45.0902765], [41.3520174, 45.0908983], [41.3520064, 45.0910643], [41.3519055, 45.0911899], [41.3515268, 45.091281], [41.3514443, 45.0913906], [41.402584, 45.0666468]]], [[[41.4084031, 45.0604671], [41.4069079, 45.0625952], [41.4076506, 45.0629259], [41.4063499, 45.0641242], [41.4052466, 45.0643201], [41.4044976, 45.0650384], [41.4038412, 45.0650626], [41.4032925, 45.0652906], [41.402584, 45.0666468], [41.4084031, 45.0604671]]], [[[41.4331081, 45.0171944], [41.431075, 45.0178072], [41.4292617, 45.0193453], [41.4290385, 45.0199368], [41.4275879, 45.0210805], [41.4280064, 45.0220664], [41.4274763, 45.0225397], [41.4270858, 45.0243931], [41.4254558, 45.0243258], [41.42487, 45.0251737], [41.4243678, 45.0252525], [41.4244794, 45.0259426], [41.4238936, 45.0264553], [41.4230009, 45.026337], [41.4225546, 45.026613], [41.4224709, 45.0281903], [41.4214666, 45.0290775], [41.4207134, 45.0301027], [41.4219129, 45.0305167], [41.4204623, 45.0319165], [41.4206884, 45.0327947], [41.4198445, 45.033216], [41.4186617, 45.03432], [41.4182154, 45.0355659], [41.4173004, 45.0367014], [41.4173673, 45.0370956], [41.4166532, 45.0383415], [41.4176372, 45.0392909], [41.4168802, 45.0400175], [41.4169659, 45.0407442], [41.4172087, 45.0410167], [41.4169802, 45.0412993], [41.4163089, 45.0415617], [41.4159947, 45.0418442], [41.4160518, 45.0427424], [41.416923, 45.0432571], [41.4162375, 45.0438727], [41.4165374, 45.0443369], [41.4165176, 45.0449209], [41.4150234, 45.0452956], [41.4142379, 45.0456388], [41.4141236, 45.0459415], [41.4152662, 45.0464461], [41.4152519, 45.0469406], [41.4137808, 45.0474754], [41.4132523, 45.0480001], [41.4123097, 45.0480809], [41.412124, 45.0498871], [41.4105401, 45.0505449], [41.4105529, 45.0508962], [41.4111527, 45.0514512], [41.411126, 45.0518851], [41.4104386, 45.0519355], [41.4100938, 45.0522595], [41.4101496, 45.052831], [41.4092011, 45.0528704], [41.4092569, 45.0533434], [41.4101217, 45.0540332], [41.4099084, 45.0545592], [41.4104786, 45.0552372], [41.4098928, 45.0557495], [41.4100044, 45.0562028], [41.4110365, 45.0569319], [41.4120129, 45.0571684], [41.4121803, 45.0579172], [41.4110365, 45.0589616], [41.4100323, 45.0591587], [41.409307, 45.0582522], [41.4088327, 45.0583507], [41.4084701, 45.0590207], [41.4084031, 45.0604671], [41.4331081, 45.0171944]]], [[[41.5285421, 44.987665], [41.4564792, 44.9882632], [41.455558, 44.9894538], [41.453795, 44.9903219], [41.4531031, 44.9908585], [41.4531478, 44.9914899], [41.4527237, 44.9922474], [41.451474, 44.9929419], [41.4502019, 44.9928472], [41.44922, 44.9939204], [41.4475239, 44.9949462], [41.4462518, 44.9951514], [41.4455376, 44.9964297], [41.4447739, 44.9972893], [41.4447631, 44.9987776], [41.4443838, 44.9998822], [41.4443614, 45.0010658], [41.4444953, 45.0021546], [41.4431117, 45.0031645], [41.4432456, 45.0040639], [41.442643, 45.0051685], [41.4420628, 45.0053105], [41.4411255, 45.0063519], [41.4413486, 45.0071566], [41.4403444, 45.0076142], [41.4410746, 45.0081494], [41.4403688, 45.0086287], [41.4391693, 45.0088654], [41.4391414, 45.0096346], [41.4387229, 45.0106207], [41.4390474, 45.0124075], [41.4379418, 45.0135592], [41.4377745, 45.0139536], [41.4367981, 45.0146439], [41.4361565, 45.0154721], [41.434929, 45.0157088], [41.4338411, 45.0161032], [41.4331081, 45.0171944], [41.5285421, 44.987665]]], [[[41.6539743, 44.986253], [41.5766787, 44.9870832], [41.5435921, 44.9874831], [41.5285421, 44.987665], [41.6539743, 44.986253]]], [[[41.616942, 44.8488984], [41.6223295, 44.8475584], [41.6235389, 44.8479415], [41.6241238, 44.8486738], [41.6245039, 44.8496241], [41.6247051, 44.8505162], [41.6250609, 44.8512248], [41.6258128, 44.8516429], [41.6267251, 44.851616], [41.6276232, 44.8513845], [41.6286845, 44.8510523], [41.6300605, 44.8507823], [41.6305218, 44.8506406], [41.6321566, 44.8537564], [41.6364604, 44.8635521], [41.6386764, 44.8641035], [41.6387808, 44.8755994], [41.6395632, 44.9053969], [41.652161, 44.9053179], [41.6539743, 44.986253], [41.616942, 44.8488984]]], [[[41.5551773, 44.7513475], [41.5668312, 44.7536338], [41.5638498, 44.7616127], [41.5785088, 44.7572273], [41.5785486, 44.7578321], [41.57945, 44.7577316], [41.5839178, 44.7672606], [41.5839611, 44.7673505], [41.5862941, 44.7723606], [41.5868351, 44.7724726], [41.5879965, 44.7722748], [41.5884125, 44.7715215], [41.5899034, 44.771046], [41.5903355, 44.7705398], [41.591243, 44.7704171], [41.5931013, 44.7696194], [41.5934228, 44.768874], [41.5942248, 44.7682388], [41.5922815, 44.7733079], [41.5844511, 44.7942122], [41.6152512, 44.7999782], [41.6085986, 44.8183796], [41.6057904, 44.8259697], [41.6116129, 44.8271496], [41.611821, 44.8274741], [41.609271, 44.8347457], [41.6110852, 44.835396], [41.6114322, 44.835396], [41.6118404, 44.8347012], [41.6130038, 44.8350631], [41.6135753, 44.8349183], [41.6141876, 44.8342815], [41.6148572, 44.8343245], [41.6139835, 44.8387104], [41.6136937, 44.8404259], [41.6157854, 44.846031], [41.6162138, 44.8472172], [41.616942, 44.8488984], [41.5551773, 44.7513475]]], [[[41.4394793, 44.7108614], [41.5207235, 44.7265609], [41.5171383, 44.7302074], [41.5196807, 44.7307529], [41.5247798, 44.7316038], [41.5350491, 44.7335761], [41.5598862, 44.7383883], [41.5551773, 44.7513475], [41.4394793, 44.7108614]]], [[[41.4791764, 44.6387115], [41.4764609, 44.6457123], [41.476111, 44.6475041], [41.474634, 44.6484349], [41.4723973, 44.6484349], [41.4670376, 44.6506266], [41.4663017, 44.6506924], [41.4650963, 44.6500561], [41.4634504, 44.6500561], [41.461678, 44.6509268], [41.4603001, 44.6509792], [41.4586795, 44.6504988], [41.4568893, 44.6506123], [41.4555874, 44.6535694], [41.4477758, 44.6571982], [41.4483896, 44.6584876], [41.4441695, 44.6628702], [41.4270929, 44.7084762], [41.4394793, 44.7108614], [41.4791764, 44.6387115]]], [[[41.5800296, 44.5421586], [41.5647257, 44.5837244], [41.5519664, 44.6181523], [41.5274524, 44.6139404], [41.5316495, 44.6025825], [41.4949328, 44.5956913], [41.4929501, 44.6017566], [41.4883796, 44.6138978], [41.4858477, 44.6210651], [41.4791764, 44.6387115], [41.5800296, 44.5421586]]], [[[41.736078, 44.4736649], [41.7366406, 44.4834389], [41.7295311, 44.4838097], [41.7292661, 44.4840816], [41.725827, 44.4852597], [41.7228511, 44.4857141], [41.716959, 44.4872643], [41.7141479, 44.4877837], [41.7089993, 44.4887864], [41.7038551, 44.4895424], [41.6999572, 44.4996747], [41.6937186, 44.4984299], [41.6511304, 44.4903407], [41.6383359, 44.5251383], [41.5897072, 44.5159289], [41.5847966, 44.5292399], [41.5800296, 44.5421586], [41.736078, 44.4736649]]], [[[41.736078, 44.4736649], [41.7352512, 44.4609574], [41.7251055, 44.4596322], [41.7215385, 44.4551908], [41.7159774, 44.4548297], [41.7062226, 44.4551787], [41.6973006, 44.4319921], [41.6939037, 44.4100415], [41.736078, 44.4736649]]], [[[41.6939037, 44.4100415], [41.6668385, 44.4101041], [41.6299392, 44.4073469], [41.6939037, 44.4100415]]], [[[41.6299392, 44.4073469], [41.6280945, 44.407196], [41.6336952, 44.3778918], [41.5977803, 44.3741208], [41.592001, 44.3635563], [41.5980028, 44.3617565], [41.6072204, 44.3589914], [41.6299392, 44.4073469]]], [[[41.6072204, 44.3589914], [41.6246307, 44.3537682], [41.6615157, 44.3424827], [41.678999, 44.3369883], [41.6807895, 44.3364304], [41.6072204, 44.3589914]]], [[[41.6807895, 44.3364304], [41.6904961, 44.3334061], [41.6807895, 44.3364304]]], [[[41.6904961, 44.3334061], [41.7036264, 44.3177974], [41.7161895, 44.3026251], [41.7194217, 44.2986292], [41.6904961, 44.3334061]]], [[[41.7194217, 44.2986292], [41.7328639, 44.2820083], [41.7422848, 44.2703607], [41.7194217, 44.2986292]]], [[[41.7422848, 44.2703607], [41.7439797, 44.2683772], [41.7424394, 44.2670938], [41.7424394, 44.2662306], [41.742715, 44.265022], [41.7420301, 44.2639737], [41.7404418, 44.2633448], [41.7389263, 44.2634681], [41.737652, 44.2623828], [41.7375487, 44.2607056], [41.739817, 44.257868], [41.7399596, 44.2569068], [41.7388575, 44.2555501], [41.7368943, 44.2541193], [41.7345867, 44.2534039], [41.7312802, 44.2526144], [41.7307323, 44.2521883], [41.7289298, 44.2508665], [41.7278569, 44.2492987], [41.7276423, 44.2478231], [41.7283198, 44.2461221], [41.7287934, 44.2442099], [41.7288795, 44.2430996], [41.7282062, 44.2414575], [41.7282888, 44.2405693], [41.7286746, 44.2398784], [41.7281293, 44.2388748], [41.7280861, 44.2368573], [41.728527, 44.235041], [41.7283286, 44.2339039], [41.7284592, 44.2327149], [41.7273146, 44.2318981], [41.7261774, 44.2315427], [41.7252733, 44.2307715], [41.7252858, 44.229303], [41.7245969, 44.2276371], [41.7192206, 44.22295], [41.7186987, 44.2220838], [41.7196028, 44.2198314], [41.7191671, 44.219181], [41.7180874, 44.2183788], [41.7161087, 44.2181147], [41.7149864, 44.2169931], [41.713436, 44.2159227], [41.7123614, 44.2147773], [41.7422848, 44.2703607]]], [[[41.7123614, 44.2147773], [41.7121961, 44.2140268], [41.7127837, 44.2131747], [41.7123339, 44.2114594], [41.7125267, 44.2101757], [41.7123339, 44.2090697], [41.7118379, 44.2078451], [41.7105704, 44.2066996], [41.7102398, 44.205554], [41.7090825, 44.2042306], [41.7092823, 44.2019647], [41.7105308, 44.2005758], [41.7114032, 44.1980714], [41.709842, 44.1964089], [41.7095837, 44.1936309], [41.7102892, 44.1926733], [41.7111626, 44.1912876], [41.711073, 44.189694], [41.709807, 44.1883128], [41.7087676, 44.1870298], [41.7123614, 44.2147773]]], [[[41.7087676, 44.1870298], [41.6996564, 44.1829683], [41.6995351, 44.1792976], [41.6978048, 44.1759494], [41.6992131, 44.1751376], [41.6998158, 44.1737481], [41.6996006, 44.1723586], [41.6989117, 44.1711852], [41.6929594, 44.1704415], [41.6906887, 44.1698573], [41.6883208, 44.1698882], [41.6859529, 44.1689618], [41.6847044, 44.1682824], [41.6841795, 44.1680767], [41.6831311, 44.1676658], [41.682724, 44.1667383], [41.6814755, 44.1648544], [41.6806144, 44.164453], [41.679452, 44.1627543], [41.6782035, 44.1621367], [41.6773424, 44.161241], [41.678238, 44.1590625], [41.6779157, 44.1566398], [41.6766451, 44.1565606], [41.6750521, 44.1552633], [41.6746216, 44.1535953], [41.670876, 44.1522362], [41.6696275, 44.1515257], [41.668379, 44.1511551], [41.6646334, 44.1483131], [41.664973, 44.1466807], [41.6648475, 44.1458725], [41.6627466, 44.1444391], [41.6625055, 44.1428573], [41.6617478, 44.141745], [41.6592335, 44.1405587], [41.6561337, 44.138779], [41.6543077, 44.136701], [41.6549803, 44.1360515], [41.654998, 44.1352922], [41.6543077, 44.1346926], [41.6508204, 44.1329004], [41.6503469, 44.127091], [41.6491844, 44.125793], [41.6482803, 44.1254531], [41.6479359, 44.124526], [41.6441547, 44.124515], [41.6358766, 44.1300472], [41.6349264, 44.1299294], [41.6310233, 44.1268621], [41.6311925, 44.1266851], [41.635202, 44.1257705], [41.6330937, 44.1231447], [41.637066, 44.118117], [41.6376676, 44.1174282], [41.6346918, 44.1162809], [41.6327079, 44.1167359], [41.6253609, 44.1144155], [41.618972, 44.113932], [41.6149732, 44.1139011], [41.6115015, 44.1134264], [41.6094901, 44.1139011], [41.6080848, 44.1133077], [41.5999994, 44.112284], [41.5992285, 44.112092], [41.5869512, 44.1090345], [41.5783906, 44.1053749], [41.5755991, 44.1051765], [41.5752504, 44.1050747], [41.5697027, 44.1034552], [41.5655696, 44.1013974], [41.5647706, 44.1015557], [41.5626064, 44.1000679], [41.5545482, 44.0985085], [41.5507843, 44.0961583], [41.7087676, 44.1870298]]], [[[41.5507843, 44.0961583], [41.5526404, 44.0936096], [41.5551203, 44.0906906], [41.5566849, 44.0872216], [41.5521216, 44.0769763], [41.5536037, 44.0642852], [41.5510287, 44.0608178], [41.5457018, 44.0582535], [41.5458187, 44.0530271], [41.5458509, 44.0515898], [41.5457813, 44.0459767], [41.5453686, 44.0419827], [41.5442314, 44.0423374], [41.5426815, 44.0424364], [41.5385829, 44.0446646], [41.5366886, 44.0447141], [41.5343991, 44.0450875], [41.531729, 44.0447389], [41.5296969, 44.0450607], [41.5279059, 44.045036], [41.5259772, 44.0456054], [41.5244617, 44.0457786], [41.5227052, 44.0469174], [41.5220852, 44.0469174], [41.5215495, 44.047261], [41.5162645, 44.046051], [41.5143358, 44.0457044], [41.5109604, 44.0455063], [41.5085839, 44.0457786], [41.5066628, 44.0455569], [41.5055822, 44.0457079], [41.5047583, 44.045823], [41.503665, 44.0456329], [41.5023071, 44.0461653], [41.5007614, 44.0458964], [41.4990369, 44.0464459], [41.4964723, 44.0461923], [41.4960336, 44.0461489], [41.4945181, 44.0463271], [41.4939946, 44.0460102], [41.493664, 44.0459904], [41.4934435, 44.0453765], [41.49033, 44.0461489], [41.4885941, 44.0463271], [41.4882084, 44.0459706], [41.486748, 44.0462677], [41.4858802, 44.0467616], [41.4844611, 44.0469411], [41.4841855, 44.0475946], [41.4834876, 44.0483471], [41.4824772, 44.0494364], [41.4834416, 44.0494562], [41.4835518, 44.0504266], [41.4837447, 44.0510207], [41.4843233, 44.0514167], [41.4849295, 44.0524861], [41.4849395, 44.0538453], [41.4854661, 44.0545832], [41.4842163, 44.0545721], [41.4836723, 44.0539212], [41.4831433, 44.0538578], [41.4817822, 44.0520568], [41.4800945, 44.0508933], [41.4799471, 44.0498022], [41.4796164, 44.0492318], [41.4797487, 44.0482971], [41.4789331, 44.0473781], [41.4788009, 44.0457462], [41.4780294, 44.0445262], [41.4786686, 44.0427358], [41.477831, 44.0424506], [41.4777208, 44.0414523], [41.4782939, 44.04066], [41.478382, 44.0390913], [41.4789552, 44.0383783], [41.4799004, 44.0377826], [41.4795755, 44.0372814], [41.4804792, 44.0358077], [41.480347, 44.035158], [41.4803938, 44.0337585], [41.4800411, 44.0306365], [41.4787183, 44.0304377], [41.4784099, 44.0297331], [41.4785642, 44.0291309], [41.4796884, 44.0284177], [41.4801513, 44.0271498], [41.4797244, 44.0257217], [41.4796223, 44.024598], [41.4802395, 44.023647], [41.4800632, 44.0229655], [41.4789169, 44.0211268], [41.4792255, 44.0202867], [41.4780572, 44.0198588], [41.4773298, 44.0190662], [41.4772036, 44.0179191], [41.47735, 44.0169178], [41.4777082, 44.0158874], [41.4780389, 44.0145994], [41.4783713, 44.0139394], [41.4799676, 44.012816], [41.4809513, 44.0120825], [41.4810973, 44.010438], [41.4819515, 44.0090618], [41.481979, 44.0081194], [41.4815933, 44.0072078], [41.4815382, 44.005979], [41.4807695, 44.0046517], [41.4813177, 44.0026494], [41.4811249, 44.0021738], [41.4800503, 44.0018765], [41.4797499, 44.0009256], [41.463112, 44.0014212], [41.4612138, 44.0014777], [41.4525994, 44.0041047], [41.444301, 44.003717], [41.434916, 44.0011583], [41.4322909, 44.0004426], [41.4258507, 43.9943193], [41.4238442, 43.9927867], [41.4202939, 43.989191], [41.4174109, 43.9862712], [41.4167473, 43.9851052], [41.4151721, 43.9823371], [41.4141691, 43.98285], [41.4052629, 43.9811448], [41.5507843, 44.0961583]]], [[[41.4052629, 43.9811448], [41.3932809, 43.9856875], [41.390922, 43.9919805], [41.3891846, 43.9966159], [41.3862839, 43.9989083], [41.3843035, 43.9967094], [41.380789, 43.9991725], [41.3801743, 43.9996034], [41.3804288, 44.0036775], [41.3785345, 44.0052568], [41.3762527, 44.0030581], [41.3686968, 44.004882], [41.3724641, 44.0083844], [41.3728515, 44.0098397], [41.3708281, 44.009592], [41.3695795, 44.0102422], [41.3672418, 44.0088712], [41.3667811, 44.0086011], [41.3654106, 44.0092252], [41.3651882, 44.0103042], [41.3640688, 44.0111092], [41.3624759, 44.009592], [41.3579554, 44.0113879], [41.356083, 44.0099784], [41.3544427, 44.00942], [41.3560176, 44.0072317], [41.3585971, 44.0036474], [41.3626955, 43.9997576], [41.3604411, 44.0002623], [41.3579123, 44.0008284], [41.3574818, 43.9987844], [41.3574818, 43.9969881], [41.352746, 43.9961519], [41.3501629, 43.9932715], [41.3517558, 43.9912273], [41.3520245, 43.9883445], [41.3552704, 43.9835143], [41.3564075, 43.9828764], [41.3601188, 43.9779945], [41.3299648, 43.9792809], [41.322009, 43.9794649], [41.3150387, 43.9797845], [41.3155451, 43.9836076], [41.3135363, 43.987884], [41.3088072, 43.9979523], [41.3104971, 43.9995577], [41.309813, 44.0000229], [41.3091194, 44.0004944], [41.3068286, 43.9997359], [41.3052898, 43.9992264], [41.3043823, 43.998926], [41.3034736, 43.9986285], [41.3027634, 43.999251], [41.3019249, 43.999986], [41.3014362, 44.0004143], [41.3029807, 44.0008977], [41.3040369, 44.0015082], [41.3051341, 44.0021424], [41.3058414, 44.0025512], [41.3078402, 44.0037065], [41.3128598, 44.0066077], [41.3132186, 44.0076553], [41.312171, 44.0069151], [41.3117135, 44.0065918], [41.3084833, 44.0061714], [41.306987, 44.0059766], [41.3060453, 44.0055105], [41.3050977, 44.0050414], [41.3027866, 44.0038974], [41.3004634, 44.0027474], [41.2990226, 44.0015637], [41.2971931, 44.0000606], [41.2958609, 44.0002876], [41.2927634, 44.0008153], [41.2990854, 44.0055586], [41.3030749, 44.0074699], [41.3039382, 44.0078835], [41.3090716, 44.0115859], [41.3131591, 44.0153488], [41.3131395, 44.0164452], [41.3140488, 44.0189022], [41.3152404, 44.0196004], [41.3169144, 44.0206458], [41.3172549, 44.0217721], [41.3189408, 44.023263], [41.3218891, 44.0274631], [41.3215901, 44.0276421], [41.3203576, 44.0283803], [41.3176317, 44.0254909], [41.316265, 44.0266479], [41.3158214, 44.0248056], [41.3138473, 44.0230549], [41.3106551, 44.0202239], [41.3092344, 44.0222671], [41.3074356, 44.0219858], [41.3071679, 44.0200381], [41.3092371, 44.0150275], [41.307205, 44.0131388], [41.3063164, 44.0123128], [41.3049116, 44.0123128], [41.3030651, 44.0123128], [41.3054622, 44.0144331], [41.3055074, 44.0152209], [41.3054071, 44.0175044], [41.3049631, 44.0184102], [41.3047301, 44.0188854], [41.3039744, 44.0186933], [41.3022048, 44.0154953], [41.3003924, 44.0119957], [41.2996496, 44.012212], [41.2986848, 44.0124928], [41.2978085, 44.0127479], [41.299428, 44.015305], [41.3019629, 44.0211106], [41.3012948, 44.0215105], [41.2992627, 44.0201199], [41.2973477, 44.017101], [41.2951471, 44.0168182], [41.2953461, 44.0153503], [41.2955181, 44.0140814], [41.2956296, 44.013259], [41.2960275, 44.0103238], [41.2962054, 44.0084391], [41.2943305, 44.0082191], [41.294037, 44.0096234], [41.2932385, 44.0101508], [41.2899552, 44.0111769], [41.2885371, 44.01162], [41.2885027, 44.0134864], [41.2884891, 44.0142275], [41.2862428, 44.0138366], [41.2861254, 44.0131261], [41.2856022, 44.0112259], [41.2845736, 44.0109906], [41.2842011, 44.0054649], [41.2855099, 44.0044177], [41.2858496, 44.0041444], [41.2867045, 44.0034566], [41.2872382, 44.002958], [41.2844767, 44.0018898], [41.4052629, 43.9811448]]], [[[41.2844767, 44.0018898], [41.280661, 44.0032307], [41.2776561, 44.004234], [41.2777861, 44.0094269], [41.2844767, 44.0018898]]], [[[41.2777861, 44.0094269], [41.2778152, 44.0142881], [41.2766042, 44.015189], [41.2736208, 44.0182329], [41.2581347, 44.0116903], [41.2570154, 44.0107924], [41.2552669, 44.0129621], [41.2507816, 44.0102785], [41.2483238, 44.0100898], [41.2465925, 44.0099492], [41.2501357, 44.0138039], [41.2523961, 44.0163549], [41.2517706, 44.0181173], [41.2501896, 44.0220049], [41.2514791, 44.0227897], [41.2531323, 44.0219972], [41.2544066, 44.0225173], [41.2567172, 44.0226962], [41.2563354, 44.0237308], [41.256846, 44.0252735], [41.2579542, 44.0292285], [41.2604932, 44.0291634], [41.2614328, 44.0298724], [41.2625694, 44.0322], [41.264581, 44.0342778], [41.2654885, 44.0360353], [41.2673401, 44.0368117], [41.2713874, 44.0366187], [41.2738938, 44.0382137], [41.2752724, 44.0406], [41.2757776, 44.0413896], [41.2759661, 44.0416974], [41.2761031, 44.0419231], [41.2763352, 44.0423158], [41.2767654, 44.0429985], [41.2773042, 44.0438365], [41.2782214, 44.0453379], [41.279439, 44.0472393], [41.2811918, 44.0499762], [41.2818577, 44.0513541], [41.2807578, 44.05227], [41.2803419, 44.0526472], [41.2786891, 44.0541463], [41.2786615, 44.0565423], [41.2788544, 44.0573542], [41.2775053, 44.057973], [41.2759613, 44.0617697], [41.276843, 44.0632547], [41.2761042, 44.0641543], [41.2765347, 44.0660723], [41.2756306, 44.0667219], [41.2737794, 44.0666291], [41.2729745, 44.0671944], [41.2755015, 44.0685779], [41.2780496, 44.0693597], [41.2780308, 44.0706598], [41.2789676, 44.0715903], [41.2771216, 44.0722238], [41.2768736, 44.0725801], [41.2784986, 44.0737845], [41.2819927, 44.073023], [41.2822269, 44.0706808], [41.2833001, 44.0705465], [41.2833989, 44.0700803], [41.2822079, 44.0696514], [41.2807441, 44.0676407], [41.2823801, 44.0668674], [41.2829398, 44.0654444], [41.2851441, 44.0606373], [41.2878909, 44.0584217], [41.2944868, 44.0555372], [41.2955542, 44.0570603], [41.3014705, 44.0617186], [41.2961397, 44.0738275], [41.2914202, 44.0847475], [41.2911159, 44.0854616], [41.2873557, 44.084075], [41.2833036, 44.0846556], [41.2714555, 44.0920216], [41.2640289, 44.094959], [41.2582918, 44.0943001], [41.2566024, 44.0928719], [41.2481324, 44.0944276], [41.2438183, 44.0943079], [41.2777861, 44.0094269]]], [[[41.2438183, 44.0943079], [41.2426103, 44.0948291], [41.2420722, 44.0951909], [41.2380949, 44.0969621], [41.2338543, 44.0987342], [41.2319498, 44.0978152], [41.2319995, 44.0942123], [41.2438183, 44.0943079]]], [[[41.2319995, 44.0942123], [41.2322815, 44.0897056], [41.2318005, 44.0891304], [41.2296844, 44.0892398], [41.2194696, 44.0888907], [41.2153324, 44.0890407], [41.2084613, 44.088587], [41.2001633, 44.0886072], [41.1923754, 44.088975], [41.2319995, 44.0942123]]], [[[41.1923754, 44.088975], [41.1906063, 44.0890585], [41.1829735, 44.0889267], [41.1761801, 44.0886146], [41.1703049, 44.0886842], [41.1689556, 44.092419], [41.1696425, 44.098862], [41.169947, 44.1021113], [41.1699457, 44.1042649], [41.1694663, 44.1043257], [41.1674604, 44.1029486], [41.1672179, 44.1035343], [41.1678131, 44.1042307], [41.1665125, 44.1044682], [41.1668432, 44.1048955], [41.1660757, 44.1051516], [41.1658292, 44.1052438], [41.1660055, 44.106415], [41.1647932, 44.1079978], [41.1636249, 44.1082669], [41.1631028, 44.1090137], [41.161498, 44.1089911], [41.1560422, 44.1089148], [41.1556977, 44.1092115], [41.1536605, 44.1089915], [41.1527492, 44.1100794], [41.1555907, 44.1120577], [41.1535241, 44.112645], [41.1522127, 44.1132464], [41.1512754, 44.1136727], [41.1523238, 44.1177582], [41.1312535, 44.1247486], [41.1279813, 44.1252287], [41.1260525, 44.1259407], [41.1251433, 44.1259803], [41.1245095, 44.1262572], [41.1236589, 44.1260759], [41.1227737, 44.1262374], [41.121947, 44.125921], [41.1214544, 44.126023], [41.1206347, 44.1231883], [41.1197405, 44.1200959], [41.118184, 44.1147132], [41.117649, 44.1128627], [41.1225563, 44.1065239], [41.1204023, 44.1056935], [41.1200878, 44.105481], [41.1196462, 44.1051826], [41.1180327, 44.1040921], [41.1153378, 44.1026574], [41.1120855, 44.1018567], [41.1059988, 44.101523], [41.102386, 44.1006521], [41.1923754, 44.088975]]], [[[41.102386, 44.1006521], [41.099494, 44.0999548], [41.0971705, 44.0992313], [41.0920446, 44.0976353], [41.0881217, 44.0959567], [41.0847882, 44.0947128], [41.0745465, 44.1016069], [41.0615036, 44.1126287], [41.0381181, 44.1205352], [41.0356262, 44.1211091], [41.0340136, 44.1191826], [41.0339393, 44.1171813], [41.0335823, 44.1168066], [41.0329729, 44.1161672], [41.0319693, 44.1155001], [41.0312589, 44.1125627], [41.0181993, 44.1164313], [41.015567, 44.1177404], [41.0009312, 44.1235441], [40.987387, 44.1290067], [40.9743545, 44.1337159], [40.9635727, 44.137721], [40.9548535, 44.14107], [40.9468676, 44.1423477], [40.9441755, 44.1428314], [40.940123, 44.1434999], [40.9242238, 44.1445987], [40.919829, 44.1449261], [40.9141294, 44.1452968], [41.102386, 44.1006521]]], [[[40.9141294, 44.1452968], [40.90536, 44.1439051], [40.8975982, 44.1410119], [40.8942617, 44.139592], [40.8942946, 44.1430302], [40.8912762, 44.1429954], [40.8912672, 44.1406393], [40.8913132, 44.134778], [40.8912887, 44.128315], [40.8912866, 44.1142157], [40.8912444, 44.1038882], [40.8951266, 44.1024214], [40.9079765, 44.097406], [40.9147647, 44.0946665], [40.9262027, 44.0901806], [40.9106675, 44.0836731], [40.9132694, 44.0809615], [40.9113683, 44.0792614], [40.9117951, 44.0785089], [40.9114847, 44.0756103], [40.9115235, 44.0748577], [40.9122994, 44.0737149], [40.9131918, 44.0732411], [40.9143169, 44.0751643], [40.9160239, 44.0749971], [40.9168386, 44.0744117], [40.9174206, 44.0746068], [40.9181965, 44.0740494], [40.919438, 44.0740773], [40.9200587, 44.0742724], [40.9213778, 44.0733526], [40.9205243, 44.071039], [40.9268869, 44.0680843], [40.9249539, 44.0647148], [40.9234448, 44.0649615], [40.9224505, 44.0649854], [40.9240023, 44.0618073], [40.9216745, 44.0578763], [40.9201275, 44.0574564], [40.9212478, 44.056789], [40.9210127, 44.0543546], [40.9207046, 44.0526067], [40.919308, 44.0516308], [40.9200839, 44.0507385], [40.9196276, 44.0483125], [40.9193794, 44.0478664], [40.9196028, 44.0474916], [40.9195283, 44.0456712], [40.9200249, 44.044404], [40.9196143, 44.0435121], [40.9195743, 44.0404388], [40.9189424, 44.0396105], [40.919054, 44.0381409], [40.9141294, 44.1452968]]], [[[40.919054, 44.0381409], [40.9205408, 44.0354153], [40.9205919, 44.0349568], [40.9207738, 44.033456], [40.9218046, 44.0327697], [40.9226595, 44.0313267], [40.9228453, 44.0293491], [40.9241091, 44.0278792], [40.9234029, 44.0273714], [40.9248153, 44.0256075], [40.9253014, 44.0237912], [40.9281008, 44.0233889], [40.9287698, 44.0218387], [40.9326993, 44.0202268], [40.9354588, 44.0173529], [40.9331989, 44.0159329], [40.9323901, 44.0146327], [40.9312244, 44.0138287], [40.9307248, 44.0131614], [40.9300588, 44.0127508], [40.9291964, 44.0118882], [40.9278954, 44.0119216], [40.9256652, 44.0115206], [40.9239461, 44.0104513], [40.9221102, 44.0079639], [40.9208315, 44.0058037], [40.9199692, 44.0033226], [40.9177389, 44.0010553], [40.9151197, 43.9977258], [40.9149014, 43.9968621], [40.9151631, 43.9955444], [40.9155199, 43.9936105], [40.9151372, 43.9918433], [40.9131886, 43.9891607], [40.9114867, 43.9861515], [40.9115397, 43.9842037], [40.9123943, 43.9826778], [40.9119297, 43.979602], [40.911465, 43.9770609], [40.9097924, 43.9749545], [40.9029623, 43.968668], [40.9005322, 43.9652817], [40.9006098, 43.964053], [40.9009201, 43.9631873], [40.9007558, 43.9621058], [40.9003704, 43.9611163], [40.8931172, 43.9576396], [40.8902075, 43.9544837], [40.8885393, 43.9490093], [40.8857488, 43.9446234], [40.8848798, 43.9439307], [40.8836073, 43.9441094], [40.8817451, 43.9460983], [40.8771826, 43.9480871], [40.8679025, 43.946724], [40.8654506, 43.9474167], [40.863247, 43.9470145], [40.8608261, 43.9468804], [40.8587847, 43.9454689], [40.8525454, 43.9434144], [40.8482561, 43.9385], [40.8464408, 43.9370634], [40.8452802, 43.9360648], [40.8429177, 43.9346397], [40.841023, 43.9333571], [40.8402485, 43.9308561], [40.8401811, 43.9264281], [40.919054, 44.0381409]]], [[[40.8401811, 43.9264281], [40.8385444, 43.9243324], [40.8342609, 43.9210439], [40.8317093, 43.9212921], [40.8267822, 43.9203419], [40.8242331, 43.9195568], [40.820453, 43.9190513], [40.8188687, 43.9188108], [40.8166563, 43.9176871], [40.8147768, 43.9175658], [40.8132318, 43.9179431], [40.8102531, 43.9179992], [40.8071345, 43.9187861], [40.8047906, 43.9184427], [40.8029719, 43.9177416], [40.8019546, 43.9166919], [40.8010235, 43.9133102], [40.800442, 43.9040803], [40.7995105, 43.9025491], [40.7952429, 43.8994741], [40.7905681, 43.8980405], [40.7899053, 43.8963963], [40.7890906, 43.8957556], [40.7903523, 43.8949828], [40.7903523, 43.8941598], [40.7896819, 43.8938914], [40.7897564, 43.8932651], [40.7891853, 43.8926746], [40.7880719, 43.8894138], [40.7883872, 43.8880535], [40.7870961, 43.8865146], [40.7873941, 43.8854945], [40.7864448, 43.8839749], [40.786212, 43.8829123], [40.7863424, 43.8823244], [40.7859016, 43.8813743], [40.7859814, 43.8800034], [40.7850869, 43.8794169], [40.7829919, 43.8793609], [40.7813237, 43.8797245], [40.7789571, 43.8793609], [40.7746143, 43.8778335], [40.7705102, 43.8780194], [40.7657711, 43.8722289], [40.7660815, 43.8717814], [40.7672298, 43.871401], [40.7688556, 43.870358], [40.7693403, 43.868179], [40.7688543, 43.8675207], [40.7683161, 43.8667917], [40.768192, 43.8654491], [40.7677885, 43.8647554], [40.7676643, 43.8638603], [40.7662677, 43.8626743], [40.765286, 43.86236], [40.7641572, 43.8621373], [40.7629807, 43.8614278], [40.7622018, 43.8596533], [40.7603009, 43.8566853], [40.7593944, 43.8543961], [40.7591101, 43.8509466], [40.7590831, 43.8506193], [40.7577001, 43.847415], [40.7569255, 43.8460677], [40.7557151, 43.8448813], [40.7556764, 43.8445706], [40.7555154, 43.8432794], [40.7554668, 43.8428891], [40.7563358, 43.8418817], [40.7557151, 43.8405162], [40.7557365, 43.839267], [40.753977, 43.8383447], [40.7529217, 43.8367552], [40.7532379, 43.8358037], [40.7555834, 43.8314047], [40.7556627, 43.831256], [40.7556627, 43.8297167], [40.7542563, 43.8283873], [40.7526553, 43.8258949], [40.7515203, 43.8251971], [40.7480292, 43.8230505], [40.747273, 43.8208649], [40.7443958, 43.8181854], [40.7419988, 43.8158294], [40.7391668, 43.8136003], [40.7369311, 43.8103687], [40.7363892, 43.8086617], [40.7354511, 43.8064552], [40.735326, 43.8050723], [40.7321057, 43.8024352], [40.7311779, 43.8016754], [40.7285893, 43.7999158], [40.7266078, 43.79866], [40.7247171, 43.7971936], [40.7228059, 43.7948998], [40.7237949, 43.7936617], [40.7242601, 43.7931723], [40.8401811, 43.9264281]]], [[[40.7242601, 43.7931723], [40.7283803, 43.7904635], [40.7289743, 43.7889976], [40.7301974, 43.7876313], [40.73164, 43.7872451], [40.7325686, 43.7858594], [40.7337108, 43.7850348], [40.737483, 43.7850583], [40.7380044, 43.7850615], [40.7406134, 43.7833319], [40.7419542, 43.7826865], [40.7436171, 43.7796522], [40.7433866, 43.7792285], [40.7438793, 43.7755907], [40.7448475, 43.7716162], [40.7471419, 43.7698237], [40.7483213, 43.7678514], [40.7487559, 43.7640634], [40.751107, 43.759437], [40.7548565, 43.7566321], [40.7570016, 43.7532394], [40.7577084, 43.7497766], [40.7242601, 43.7931723]]], [[[40.7577084, 43.7497766], [40.7568612, 43.7491154], [40.7527095, 43.7486289], [40.750149, 43.7484887], [40.7483265, 43.7479108], [40.7460754, 43.7478161], [40.7397055, 43.7426226], [40.736803, 43.7421826], [40.733001, 43.7395198], [40.7323027, 43.7386509], [40.7280351, 43.7380903], [40.7265996, 43.7392115], [40.7252194, 43.7393646], [40.7198975, 43.7368219], [40.7188376, 43.7371896], [40.7176955, 43.7369923], [40.7162057, 43.7370102], [40.7151644, 43.7364575], [40.712575, 43.7363657], [40.7577084, 43.7497766]]], [[[40.712575, 43.7363657], [40.7109157, 43.7361689], [40.7041009, 43.7374399], [40.7007176, 43.7412417], [40.6969254, 43.7361449], [40.6950811, 43.7338212], [40.6935428, 43.7319318], [40.6917205, 43.730641], [40.6912635, 43.7299694], [40.6907785, 43.7268856], [40.6902451, 43.7260795], [40.6867634, 43.7244065], [40.6853336, 43.7231968], [40.6846765, 43.7215702], [40.6841369, 43.7201996], [40.6824881, 43.7187625], [40.6800148, 43.7174657], [40.6783385, 43.7174778], [40.6771536, 43.71701], [40.6756918, 43.7162105], [40.6752432, 43.7158067], [40.6751802, 43.7153294], [40.6763776, 43.7142059], [40.6788509, 43.7132245], [40.6797427, 43.71294], [40.6814981, 43.7131546], [40.6826544, 43.7127646], [40.6877232, 43.7128134], [40.690089, 43.7099349], [40.6948025, 43.7063078], [40.6960008, 43.7038006], [40.6957758, 43.7032686], [40.6942724, 43.6996925], [40.69306, 43.6973083], [40.6929682, 43.6961688], [40.6929235, 43.6956136], [40.6946689, 43.6948077], [40.6958243, 43.6939423], [40.6973505, 43.6937664], [40.6982491, 43.6934163], [40.7004313, 43.6906111], [40.7047609, 43.6883811], [40.7055674, 43.6877951], [40.7080972, 43.6870569], [40.7101254, 43.6866246], [40.7105889, 43.6864335], [40.712575, 43.7363657]]], [[[40.7105889, 43.6864335], [40.7127451, 43.6855398], [40.7128954, 43.6851036], [40.7126626, 43.6833361], [40.7128566, 43.682326], [40.7160379, 43.6797167], [40.7168138, 43.6787627], [40.7157275, 43.677921], [40.7141089, 43.6766018], [40.7134652, 43.6760199], [40.7137763, 43.6740721], [40.7135428, 43.6730803], [40.7073686, 43.670449], [40.7067986, 43.6702304], [40.7105889, 43.6864335]]], [[[40.7067986, 43.6702304], [40.7068562, 43.6681588], [40.7069313, 43.6665212], [40.7074034, 43.6642084], [40.7074571, 43.6630132], [40.7078862, 43.6619654], [40.7081115, 43.6612513], [40.7085828, 43.6605801], [40.7059323, 43.6577445], [40.7048392, 43.6562449], [40.704056, 43.655523], [40.7021356, 43.6550961], [40.7005048, 43.6541025], [40.6988103, 43.6535223], [40.7067986, 43.6702304]]], [[[40.6988103, 43.6535223], [40.7013502, 43.6511545], [40.7023124, 43.6503236], [40.7067507, 43.6486842], [40.7079596, 43.6480771], [40.7124179, 43.6459233], [40.7119338, 43.644417], [40.7122594, 43.6438562], [40.7124925, 43.6432267], [40.7135788, 43.6428448], [40.7156893, 43.6411379], [40.7152056, 43.6368174], [40.7164032, 43.634242], [40.7163721, 43.6325348], [40.7173343, 43.6310072], [40.7211829, 43.6297716], [40.7228899, 43.6277722], [40.7227968, 43.625593], [40.7222704, 43.6220759], [40.7230075, 43.6211211], [40.7247037, 43.6195467], [40.7256845, 43.6174137], [40.7275467, 43.6161497], [40.7275467, 43.6154195], [40.7283226, 43.615279], [40.7310583, 43.6131282], [40.7335601, 43.6116555], [40.7351584, 43.6112527], [40.7357534, 43.6102761], [40.7392388, 43.6089303], [40.7423973, 43.6054304], [40.7426485, 43.6032755], [40.7416203, 43.6019565], [40.6988103, 43.6535223]]], [[[40.7416203, 43.6019565], [40.7381896, 43.6004086], [40.7382271, 43.5970452], [40.7384592, 43.5966332], [40.741014, 43.5942694], [40.74125, 43.5927713], [40.7394164, 43.5896801], [40.7368484, 43.5887115], [40.7340848, 43.5887193], [40.7323896, 43.5889407], [40.731679, 43.5887714], [40.7317654, 43.5882278], [40.7318292, 43.5867205], [40.731282, 43.5857708], [40.730167, 43.5851991], [40.7283238, 43.5850645], [40.7265746, 43.5843246], [40.7258288, 43.5836212], [40.7258914, 43.5824748], [40.7264277, 43.5815396], [40.7259311, 43.5808057], [40.7256975, 43.5802099], [40.7251267, 43.5797031], [40.7248735, 43.5791404], [40.7253694, 43.5765235], [40.7265209, 43.5754338], [40.7281697, 43.5743447], [40.7298186, 43.5737825], [40.730643, 43.5727285], [40.7416203, 43.6019565]]], [[[40.730643, 43.5727285], [40.730352, 43.5716041], [40.7280242, 43.5694608], [40.7279107, 43.5687408], [40.7278303, 43.568231], [40.728986, 43.5664496], [40.7291998, 43.5661201], [40.727824, 43.5643532], [40.7279016, 43.5631443], [40.7268475, 43.5621281], [40.7279404, 43.5599113], [40.7288969, 43.5590389], [40.7262532, 43.5570984], [40.726566, 43.5551745], [40.7266175, 43.5544594], [40.7264017, 43.5541509], [40.7249795, 43.5534987], [40.7255482, 43.5519578], [40.725587, 43.5506925], [40.7263241, 43.5492585], [40.7258585, 43.5480212], [40.7238799, 43.5462497], [40.7217248, 43.5444656], [40.7208592, 43.5441476], [40.7200003, 43.5443656], [40.7168521, 43.5421175], [40.7157826, 43.5395582], [40.7156242, 43.5373425], [40.714581, 43.5365483], [40.7142162, 43.5357628], [40.71453, 43.5334817], [40.713345, 43.532475], [40.730643, 43.5727285]]], [[[40.6617756, 43.5630484], [40.663691, 43.5617754], [40.6656007, 43.5607958], [40.6666143, 43.5601907], [40.6679074, 43.5596965], [40.6698193, 43.559286], [40.6715831, 43.5585474], [40.67271, 43.5576334], [40.6745825, 43.5574204], [40.6752758, 43.5569913], [40.6759081, 43.5557929], [40.675526, 43.553703], [40.6759295, 43.5521842], [40.6758531, 43.5515807], [40.6755179, 43.5510011], [40.6766601, 43.5509916], [40.6794889, 43.5497258], [40.6809668, 43.5496576], [40.6827608, 43.5504568], [40.6839348, 43.5498509], [40.6852061, 43.5493876], [40.6864534, 43.5496608], [40.6879931, 43.5488592], [40.6890886, 43.5489281], [40.6897672, 43.5484154], [40.6906819, 43.5483149], [40.6922026, 43.5478979], [40.6917119, 43.5469883], [40.6908515, 43.5461378], [40.689713, 43.5453301], [40.6892234, 43.5437941], [40.6887521, 43.5423153], [40.688744, 43.540519], [40.688739, 43.5382861], [40.6895381, 43.5379607], [40.6910544, 43.5375654], [40.692208, 43.5359709], [40.6933191, 43.5353832], [40.6943667, 43.534829], [40.6965377, 43.5342246], [40.6979764, 43.5338209], [40.6999366, 43.5334063], [40.7019055, 43.5335524], [40.7059347, 43.5332763], [40.7073126, 43.5332994], [40.7093688, 43.532343], [40.7118129, 43.5324556], [40.713345, 43.532475], [40.6617756, 43.5630484]]], [[[40.5952939, 43.5316556], [40.5959517, 43.5328753], [40.5975239, 43.5347608], [40.5994823, 43.5366265], [40.5997382, 43.5367371], [40.600464, 43.5376202], [40.6023813, 43.5410654], [40.6046698, 43.5429456], [40.6061471, 43.5438628], [40.6072645, 43.5465639], [40.6088781, 43.5473149], [40.6108971, 43.547889], [40.6137766, 43.5481168], [40.6155867, 43.5485542], [40.6172677, 43.5498129], [40.6188573, 43.5502635], [40.6204299, 43.5502106], [40.6240219, 43.5495199], [40.6256721, 43.5488904], [40.6267481, 43.5488816], [40.6318553, 43.549472], [40.634257, 43.5500295], [40.6357673, 43.5504934], [40.6385724, 43.5517899], [40.6393464, 43.5528756], [40.6393648, 43.5532173], [40.6402803, 43.5534616], [40.6432542, 43.5547019], [40.644891, 43.5552348], [40.6456513, 43.5554823], [40.6470786, 43.5556192], [40.6482809, 43.5554433], [40.650054, 43.5564266], [40.651608, 43.5580769], [40.6531332, 43.558447], [40.6550452, 43.5594805], [40.6556475, 43.5597603], [40.656406, 43.5597762], [40.6574345, 43.5601464], [40.6593306, 43.5609413], [40.6617756, 43.5630484], [40.5952939, 43.5316556]]], [[[40.5874532, 43.5309087], [40.589113, 43.5307983], [40.5910986, 43.530457], [40.5930845, 43.5305563], [40.5952939, 43.5316556], [40.5874532, 43.5309087]]], [[[40.4998717, 43.528315], [40.5012348, 43.5281187], [40.5020878, 43.5268904], [40.5032799, 43.5260261], [40.5042707, 43.5255613], [40.5054097, 43.5248753], [40.5070206, 43.5248632], [40.5118412, 43.5257366], [40.5151017, 43.5251343], [40.5176776, 43.5242613], [40.5187579, 43.5231288], [40.5199292, 43.5220821], [40.5211239, 43.521212], [40.5233013, 43.5205008], [40.5259466, 43.5206222], [40.5274308, 43.5208849], [40.5278215, 43.5211006], [40.5296863, 43.5217069], [40.5312828, 43.5219477], [40.5316996, 43.5218335], [40.5337638, 43.5211882], [40.5368292, 43.5203006], [40.5402066, 43.5193242], [40.5420861, 43.5194104], [40.543068, 43.51955], [40.5443182, 43.5196307], [40.5482684, 43.51969], [40.5512136, 43.5194528], [40.5532003, 43.5197663], [40.5550643, 43.5199323], [40.5570569, 43.5197154], [40.5591465, 43.5196737], [40.5610872, 43.5198325], [40.5626526, 43.5197246], [40.5645591, 43.5190582], [40.5662982, 43.5191571], [40.5668468, 43.5196105], [40.5676307, 43.5201175], [40.5682026, 43.5211295], [40.5689585, 43.5221317], [40.5701731, 43.5225098], [40.5714781, 43.5227727], [40.573977, 43.5230041], [40.575368, 43.5238515], [40.5758378, 43.5239953], [40.576595, 43.5241735], [40.577191, 43.5244956], [40.5784632, 43.5255907], [40.5795634, 43.5266818], [40.5813738, 43.5276973], [40.5849671, 43.528851], [40.5857224, 43.5296051], [40.5864083, 43.5301827], [40.5864114, 43.5301849], [40.5874532, 43.5309087], [40.4998717, 43.528315]]], [[[40.4778211, 43.5491264], [40.4795997, 43.5487093], [40.4822766, 43.5473985], [40.4834906, 43.5459559], [40.4842758, 43.5455323], [40.4851887, 43.5447249], [40.4863026, 43.5440631], [40.487312, 43.543779], [40.4877269, 43.5433749], [40.4880096, 43.5422938], [40.4889653, 43.5408871], [40.4896261, 43.539748], [40.4903788, 43.5391473], [40.4914157, 43.5388876], [40.4922191, 43.5385302], [40.4932603, 43.5379737], [40.4937362, 43.5370255], [40.4934953, 43.5355609], [40.4934285, 43.5339683], [40.4939185, 43.5335572], [40.4946343, 43.533017], [40.4950514, 43.5317889], [40.4965188, 43.5312589], [40.4978044, 43.5306764], [40.4987101, 43.5291724], [40.4998717, 43.528315], [40.4778211, 43.5491264]]], [[[40.4401674, 43.5562006], [40.4404177, 43.5560924], [40.4421525, 43.5534854], [40.4440803, 43.5533029], [40.4448916, 43.552731], [40.4468345, 43.5506113], [40.447948, 43.55022], [40.4496518, 43.5498787], [40.4523292, 43.5493779], [40.4555014, 43.5493883], [40.4569241, 43.5483511], [40.4570005, 43.5482161], [40.4598527, 43.5475249], [40.4629811, 43.5465449], [40.4651076, 43.5463355], [40.4666272, 43.5460823], [40.4697723, 43.5467994], [40.473319, 43.5480802], [40.474589, 43.5485705], [40.4757942, 43.5485705], [40.4767995, 43.5488223], [40.4778211, 43.5491264], [40.4401674, 43.5562006]]], [[[40.4323937, 43.5576929], [40.4331131, 43.5576831], [40.4336501, 43.5570894], [40.4352138, 43.5571362], [40.4358852, 43.5573117], [40.4360897, 43.557227], [40.436192, 43.5568248], [40.4366156, 43.5567083], [40.437231, 43.556747], [40.4383099, 43.5568999], [40.4391462, 43.5568439], [40.4401674, 43.5562006], [40.4323937, 43.5576929]]], [[[40.4192407, 43.5539101], [40.419937, 43.553863], [40.4211507, 43.5539478], [40.4223515, 43.5543138], [40.4232476, 43.5543844], [40.4241974, 43.553926], [40.4248355, 43.5541375], [40.4249862, 43.5534499], [40.4252955, 43.5534278], [40.425943, 43.5534624], [40.4267149, 43.5533106], [40.4276842, 43.5536768], [40.428354, 43.5543039], [40.4289169, 43.5549191], [40.4299103, 43.5557767], [40.430983, 43.556269], [40.4317364, 43.5568459], [40.4318824, 43.5574494], [40.4323937, 43.5576929], [40.4192407, 43.5539101]]], [[[40.4192407, 43.5539101], [40.419098, 43.5538395], [40.4189464, 43.5537744], [40.41876, 43.5536179], [40.4184958, 43.5535178], [40.4183255, 43.5534663], [40.4181364, 43.5534595], [40.4178588, 43.5534896], [40.4176442, 43.5534896], [40.4174886, 43.5534468], [40.4172995, 43.5533506], [40.4171453, 43.5532097], [40.4169884, 43.5531523], [40.4167805, 43.5531008], [40.4164841, 43.5530513], [40.4163299, 43.5529842], [40.4159598, 43.5527665], [40.4156325, 43.552576], [40.4155186, 43.552507], [40.4153751, 43.5524516], [40.415186, 43.5524214], [40.4147152, 43.5524982], [40.4142861, 43.5525177], [40.4141251, 43.5524982], [40.413991, 43.5524399], [40.4137765, 43.5523271], [40.4135512, 43.5522922], [40.4133191, 43.5522892], [40.4131153, 43.5522854], [40.4128481, 43.5523171], [40.412666, 43.5523388], [40.4121779, 43.552366], [40.41186, 43.5523748], [40.4115341, 43.5523738], [40.4111479, 43.5523894], [40.4108099, 43.5523544], [40.4103969, 43.5522611], [40.4102939, 43.5522189], [40.4100576, 43.5521221], [40.4098698, 43.5520754], [40.4097049, 43.5521172], [40.4095868, 43.5522066], [40.4093602, 43.5523981], [40.4092113, 43.5524671], [40.4089968, 43.5525721], [40.4088036, 43.5526304], [40.4086159, 43.5526537], [40.4084751, 43.5526819], [40.4082779, 43.5527626], [40.4081116, 43.5529025], [40.4079507, 43.5531086], [40.4077898, 43.5533147], [40.4076181, 43.5534818], [40.4074773, 43.5535878], [40.4073271, 43.5536344], [40.4071608, 43.553685], [40.406855, 43.553891], [40.4067531, 43.5539493], [40.4066404, 43.5539493], [40.4065238, 43.55396], [40.4063789, 43.5540144], [40.4062931, 43.5540533], [40.4062596, 43.5541593], [40.4062609, 43.5542283], [40.4062006, 43.5542681], [40.4061684, 43.554342], [40.4060892, 43.5544576], [40.4059122, 43.5545665], [40.4057178, 43.5546258], [40.4055032, 43.554653], [40.4052739, 43.5547142], [40.4050539, 43.5548231], [40.4049144, 43.5549358], [40.4048018, 43.5550486], [40.4046663, 43.5551273], [40.4045769, 43.5551388], [40.4045161, 43.5551467], [40.4043565, 43.5551341], [40.404099, 43.5551302], [40.4038456, 43.5551584], [40.4036417, 43.5552206], [40.403509, 43.5552779], [40.4033451, 43.5553479], [40.4031335, 43.5553635], [40.4029873, 43.5552984], [40.4028933, 43.5553109], [40.4027901, 43.5553246], [40.4026989, 43.5552857], [40.4026185, 43.5552196], [40.4023985, 43.5551574], [40.4022054, 43.555068], [40.4021303, 43.554963], [40.4020659, 43.5547687], [40.4020177, 43.5546909], [40.4018943, 43.554652], [40.4016636, 43.5546481], [40.4014758, 43.5546481], [40.4013793, 43.5546326], [40.4011312, 43.5547541], [40.4007181, 43.554929], [40.4005317, 43.5550136], [40.4004727, 43.5550291], [40.400407, 43.5550223], [40.4003426, 43.5549757], [40.4002514, 43.5549329], [40.4000958, 43.5549368], [40.3998866, 43.5549951], [40.399668, 43.5550408], [40.399318, 43.5550923], [40.398567, 43.5551662], [40.3977087, 43.5552245], [40.3974136, 43.5552711], [40.3972272, 43.5553207], [40.3971347, 43.5554266], [40.397022, 43.5555938], [40.3967873, 43.5557833], [40.396621, 43.5558455], [40.396267, 43.5559077], [40.3959917, 43.5559542], [40.3958754, 43.5559738], [40.3955535, 43.5559661], [40.3954355, 43.5559272], [40.3952907, 43.55576], [40.3950855, 43.5556288], [40.3947328, 43.5554957], [40.3946027, 43.5554305], [40.3944699, 43.555414], [40.3942339, 43.5555462], [40.3939965, 43.5556171], [40.393794, 43.5556239], [40.3936438, 43.5556084], [40.3935419, 43.555554], [40.3933809, 43.5553518], [40.3931771, 43.5552352], [40.3930269, 43.5551574], [40.3928378, 43.5551273], [40.3926567, 43.5551419], [40.3924904, 43.5551263], [40.3924408, 43.5550806], [40.3923228, 43.5550768], [40.3922316, 43.5551234], [40.3920331, 43.5551506], [40.3918574, 43.5551302], [40.3915356, 43.5550369], [40.3911572, 43.554981], [40.3911212, 43.5549757], [40.390629, 43.5548036], [40.3899799, 43.5545548], [40.3895333, 43.5544081], [40.3892903, 43.5543594], [40.3892326, 43.5543478], [40.3889446, 43.5543527], [40.388553, 43.554411], [40.388219, 43.5544625], [40.3879723, 43.5545169], [40.3876947, 43.5546054], [40.3875284, 43.5547531], [40.3873138, 43.5549708], [40.3871314, 43.5550525], [40.3867599, 43.5551195], [40.3865413, 43.5551574], [40.3863965, 43.5551613], [40.3862731, 43.5551263], [40.3861108, 43.5551506], [40.3860156, 43.5552896], [40.3858962, 43.5554888], [40.3857903, 43.5557483], [40.3857635, 43.5558533], [40.3855905, 43.5559787], [40.3853772, 43.5560671], [40.38505, 43.556141], [40.3847965, 43.5561808], [40.3844653, 43.5561682], [40.3840241, 43.5560914], [40.3835948, 43.5560379], [40.3833441, 43.5560788], [40.3832462, 43.5561186], [40.3831295, 43.5561993], [40.3829954, 43.5563587], [40.3827272, 43.5565336], [40.3824576, 43.556694], [40.3821572, 43.556799], [40.3818836, 43.5569], [40.381708, 43.5569963], [40.3816369, 43.5570866], [40.3815578, 43.5574083], [40.3815202, 43.5574978], [40.3814491, 43.557592], [40.3812788, 43.557661], [40.3805801, 43.5578019], [40.3801831, 43.5578914], [40.3799216, 43.5579098], [40.3796212, 43.557902], [40.3793423, 43.5578243], [40.3791223, 43.5577504], [40.3789118, 43.5576814], [40.378779, 43.5576805], [40.3785845, 43.5577359], [40.3784357, 43.557836], [40.3782855, 43.5579487], [40.3781138, 43.5580848], [40.3779193, 43.5582257], [40.3776136, 43.558319], [40.3773132, 43.558354], [40.3770516, 43.5583374], [40.3769779, 43.5582933], [40.3769283, 43.5582636], [40.3768304, 43.5581868], [40.3766761, 43.5581742], [40.376365, 43.5582208], [40.3761115, 43.5583073], [40.3758125, 43.5583996], [40.3756448, 43.5583928], [40.375555, 43.5583647], [40.375378, 43.5581547], [40.3752438, 43.5580731], [40.3750239, 43.5579642], [40.3748415, 43.5578748], [40.3746739, 43.5578525], [40.3743735, 43.5579069], [40.3740798, 43.5580459], [40.3738866, 43.5582014], [40.3735634, 43.5583656], [40.3732268, 43.5584307], [40.3727923, 43.5584929], [40.3725026, 43.5585551], [40.3723135, 43.5585522], [40.3721432, 43.5585085], [40.3720198, 43.5584385], [40.3719715, 43.5583102], [40.3719541, 43.558179], [40.3718683, 43.5580974], [40.3716966, 43.5580585], [40.3714136, 43.5580575], [40.371183, 43.5580886], [40.3710207, 43.5581868], [40.3709724, 43.5583268], [40.370963, 43.5584735], [40.3707216, 43.5586329], [40.3704896, 43.5586999], [40.3701248, 43.5587233], [40.3699277, 43.5587379], [40.3697815, 43.5587583], [40.369638, 43.5588856], [40.3695307, 43.5590566], [40.3694932, 43.5591927], [40.3695039, 43.5593132], [40.3696474, 43.5596174], [40.3696689, 43.5597301], [40.369638, 43.5598535], [40.3695629, 43.5599468], [40.3692893, 43.5600401], [40.3691056, 43.5600683], [40.3688387, 43.5600479], [40.3686349, 43.5600168], [40.3684525, 43.5599507], [40.3682594, 43.5598885], [40.3680756, 43.5598467], [40.3678289, 43.5598467], [40.3675875, 43.5598817], [40.3674225, 43.5599624], [40.3672763, 43.5601111], [40.3670886, 43.5604648], [40.3669987, 43.5606738], [40.3667989, 43.5608341], [40.3666755, 43.5608808], [40.3664998, 43.5608837], [40.3663335, 43.5608526], [40.3662102, 43.5607865], [40.3661297, 43.5607126], [40.3659527, 43.5606465], [40.3657153, 43.5606514], [40.3651789, 43.5606164], [40.3649227, 43.5606427], [40.3644064, 43.5607447], [40.3641435, 43.5607641], [40.3639732, 43.5607398], [40.3638337, 43.5606854], [40.3637305, 43.5606242], [40.3636138, 43.5606116], [40.3635011, 43.5606504], [40.3633134, 43.5607826], [40.3631726, 43.5608963], [40.3630653, 43.5609585], [40.3625785, 43.5610897], [40.3623894, 43.5611879], [40.3620085, 43.5614016], [40.361806, 43.5615523], [40.3616772, 43.5617661], [40.3616289, 43.5618827], [40.3616397, 43.5620032], [40.3615793, 43.5620897], [40.3614774, 43.5621286], [40.3613165, 43.5621247], [40.3611676, 43.5620771], [40.3610281, 43.562011], [40.3606513, 43.5619847], [40.3603093, 43.5619488], [40.3599874, 43.5619604], [40.3597568, 43.5619954], [40.3595797, 43.5620421], [40.3594671, 43.5621354], [40.3593638, 43.562253], [40.3592257, 43.5623414], [40.3589615, 43.5624434], [40.3586088, 43.5626329], [40.3584411, 43.5627388], [40.3582534, 43.5628982], [40.3580562, 43.5631305], [40.3578578, 43.5632937], [40.3577129, 43.5633793], [40.3575734, 43.5634065], [40.3573911, 43.5633676], [40.3571872, 43.5632704], [40.3570424, 43.5632277], [40.3568546, 43.5632626], [40.3567192, 43.5633686], [40.3565703, 43.5635581], [40.3564576, 43.5636708], [40.3563007, 43.5637495], [40.3560446, 43.5637874], [40.3558354, 43.5637796], [40.3555926, 43.5637262], [40.3554478, 43.5636718], [40.3553459, 43.5635474], [40.35526, 43.5634541], [40.3551434, 43.5633559], [40.3550146, 43.563286], [40.3548215, 43.5632743], [40.3546659, 43.5633248], [40.3546016, 43.563422], [40.3546016, 43.5635425], [40.3546552, 43.5636436], [40.3547933, 43.5638078], [40.3549489, 43.5639944], [40.3550104, 43.5641634], [40.3549865, 43.564317], [40.3549044, 43.5643559], [40.3548161, 43.5643977], [40.3546485, 43.5644531], [40.3544983, 43.5644375], [40.3542261, 43.5643277], [40.3539632, 43.5641645], [40.3537915, 43.5641061], [40.3535126, 43.5641023], [40.3533248, 43.5641334], [40.3531089, 43.5642276], [40.3529694, 43.5643948], [40.3528407, 43.5645114], [40.3527441, 43.564558], [40.3526489, 43.5645493], [40.3525577, 43.564491], [40.3524773, 43.5643821], [40.3524182, 43.5641567], [40.3523592, 43.5640634], [40.3522573, 43.5639895], [40.352091, 43.5639818], [40.3518161, 43.5640682], [40.3516243, 43.5641178], [40.3514352, 43.5641227], [40.3513239, 43.5640906], [40.3512595, 43.564009], [40.3513011, 43.5638933], [40.3513668, 43.563803], [40.3513615, 43.5637252], [40.3513065, 43.5636407], [40.351222, 43.5636241], [40.3511455, 43.5636407], [40.3510543, 43.5637184], [40.3509953, 43.5638428], [40.350931, 43.5639633], [40.3507928, 43.5640206], [40.3505997, 43.5640051], [40.350347, 43.5639736], [40.3501706, 43.5639429], [40.3499117, 43.5639128], [40.3496328, 43.5638817], [40.349441, 43.5638263], [40.3492962, 43.5637291], [40.3491996, 43.5635542], [40.3491245, 43.5633909], [40.3490387, 43.5632199], [40.3489582, 43.5631072], [40.3488174, 43.5630304], [40.3486792, 43.5630294], [40.3484969, 43.5630644], [40.3482823, 43.5632277], [40.3480342, 43.5634269], [40.3478035, 43.5635785], [40.3476801, 43.5636135], [40.3475474, 43.5636086], [40.3474401, 43.5635658], [40.3473475, 43.5634774], [40.347306, 43.5633365], [40.3472724, 43.5631781], [40.3473167, 43.5630527], [40.347322, 43.5629594], [40.3472939, 43.5629099], [40.3472255, 43.5628973], [40.3471021, 43.5629167], [40.3469076, 43.5630148], [40.3464423, 43.5631927], [40.3460882, 43.5632899], [40.3459206, 43.5632947], [40.3457181, 43.5632665], [40.3455826, 43.5631431], [40.3455035, 43.5630411], [40.3454861, 43.5629293], [40.3455075, 43.5628166], [40.3455625, 43.5626912], [40.345584, 43.5625513], [40.345525, 43.5624541], [40.345482, 43.5624191], [40.3453479, 43.5623841], [40.3452179, 43.5623773], [40.3449563, 43.5623919], [40.3446398, 43.5624891], [40.3444145, 43.5625435], [40.3442308, 43.5626572], [40.3440055, 43.5628321], [40.3438231, 43.5630304], [40.3436367, 43.5631694], [40.34341, 43.563252], [40.3432183, 43.5632976], [40.343052, 43.5632937], [40.3429393, 43.5632549], [40.3427408, 43.5631305], [40.3426496, 43.563045], [40.342541, 43.5629993], [40.3423868, 43.5629944], [40.3422473, 43.5630178], [40.3420864, 43.5630566], [40.3418342, 43.5632004], [40.3415821, 43.5633443], [40.3414681, 43.5633802], [40.3412656, 43.5633676], [40.341098, 43.5633608], [40.3409263, 43.5634308], [40.3408566, 43.5634968], [40.3407077, 43.5635192], [40.3405361, 43.5635309], [40.3404328, 43.5635279], [40.3403201, 43.5635746], [40.3402129, 43.5636329], [40.3400372, 43.563663], [40.3398011, 43.5636708], [40.3395959, 43.5636834], [40.3394082, 43.5637262], [40.3393378, 43.5637935], [40.3392486, 43.5639118], [40.3391628, 43.5640012], [40.3390327, 43.5640566], [40.3389093, 43.5640955], [40.338798, 43.5640945], [40.3386894, 43.5640371], [40.3386089, 43.5639788], [40.338562, 43.5639351], [40.3384761, 43.563939], [40.3383766, 43.5639621], [40.3382347, 43.5640673], [40.3379115, 43.564216], [40.3375964, 43.5643355], [40.3373751, 43.5643948], [40.3371176, 43.5644181], [40.3369204, 43.5644482], [40.3367743, 43.5645114], [40.3366777, 43.5646241], [40.3366455, 43.564799], [40.3366576, 43.5649613], [40.3366844, 43.5650468], [40.336722, 43.5651284], [40.336738, 43.5652178], [40.3366898, 43.5652567], [40.336608, 43.5652499], [40.3360729, 43.565109], [40.3358087, 43.5650478], [40.3356491, 43.565039], [40.3354653, 43.5650867], [40.3352521, 43.5651673], [40.3350362, 43.5652305], [40.3346714, 43.5653315], [40.334489, 43.565452], [40.3343509, 43.5656337], [40.3342865, 43.5659097], [40.3342114, 43.5659875], [40.3341041, 43.5660302], [40.3339807, 43.5660458], [40.3338131, 43.5660079], [40.3335985, 43.5659573], [40.3333571, 43.5659457], [40.3328421, 43.5659962], [40.3324076, 43.5660545], [40.3321394, 43.5660545], [40.3318551, 43.5660234], [40.3315708, 43.565934], [40.3313629, 43.5658786], [40.3311269, 43.5658786], [40.3308694, 43.5659408], [40.3307017, 43.566039], [40.3303745, 43.5661245], [40.3299507, 43.5662605], [40.3297522, 43.5663266], [40.3296074, 43.566451], [40.3294518, 43.5665054], [40.3293392, 43.5664743], [40.3292225, 43.5663995], [40.3291689, 43.5662906], [40.3289905, 43.5662022], [40.3288564, 43.5661867], [40.3287022, 43.5661935], [40.3284554, 43.5663179], [40.3282462, 43.5664539], [40.3281322, 43.5665987], [40.3280477, 43.5667415], [40.3278331, 43.5672624], [40.3277473, 43.5674373], [40.3275649, 43.5676083], [40.3273222, 43.5677064], [40.3271894, 43.5677715], [40.3270915, 43.5678813], [40.3270003, 43.5680446], [40.3269641, 43.5681563], [40.3268769, 43.5682584], [40.3266355, 43.568375], [40.326319, 43.5684838], [40.3259757, 43.5685304], [40.3257772, 43.5686004], [40.3254406, 43.5687471], [40.3252354, 43.5688569], [40.3250262, 43.5688997], [40.3247204, 43.5689386], [40.3242108, 43.5690007], [40.3238728, 43.5690552], [40.3236703, 43.5691203], [40.3234182, 43.5692913], [40.3229086, 43.5697966], [40.3225331, 43.5701891], [40.3223528, 43.5704048], [40.3222648, 43.5705506], [40.322285, 43.5707498], [40.3223011, 43.5709052], [40.3221401, 43.5711462], [40.321947, 43.5714455], [40.3217445, 43.5716505], [40.3215407, 43.5717749], [40.3212818, 43.5718847], [40.320854, 43.5720081], [40.3206072, 43.5721013], [40.3203538, 43.5722539], [40.3202679, 43.5723666], [40.3202787, 43.5725221], [40.3205804, 43.572867], [40.3208916, 43.5732556], [40.3210096, 43.5735044], [40.3209921, 43.573653], [40.3209492, 43.5737269], [40.3207843, 43.5739163], [40.3205965, 43.5741029], [40.3205375, 43.5741962], [40.3205321, 43.574305], [40.3205804, 43.5747636], [40.3206113, 43.5748889], [40.3205791, 43.5750482], [40.3204517, 43.5752144], [40.3201285, 43.5754485], [40.3197007, 43.5756341], [40.3195545, 43.5756973], [40.3193359, 43.5757779], [40.3191736, 43.5758916], [40.3190019, 43.5759343], [40.3188249, 43.5759149], [40.3184293, 43.5758245], [40.317854, 43.5757012], [40.317748, 43.5756691], [40.317693, 43.5755729], [40.3177306, 43.5754602], [40.3177587, 43.5753776], [40.3177534, 43.5753038], [40.3177212, 43.5752299], [40.3176193, 43.575195], [40.3174516, 43.575192], [40.3171459, 43.5752309], [40.3168146, 43.5752999], [40.3164163, 43.5754136], [40.3160314, 43.5755642], [40.3157565, 43.5757361], [40.3156224, 43.5758449], [40.3154842, 43.5759878], [40.3153984, 43.5761432], [40.3153005, 43.576424], [40.3152737, 43.5765484], [40.3153233, 43.5766407], [40.3155218, 43.5768272], [40.3156331, 43.5769953], [40.3156385, 43.5771546], [40.3155486, 43.5773363], [40.3154078, 43.5774383], [40.3151106, 43.5775737], [40.3149478, 43.5777016], [40.3148554, 43.5778387], [40.3147815, 43.5780047], [40.3146291, 43.5781703], [40.3143671, 43.5782894], [40.3141042, 43.5783749], [40.3138052, 43.5784128], [40.313655, 43.5784244], [40.3134229, 43.5783827], [40.3132204, 43.5783661], [40.3128865, 43.5783943], [40.3126196, 43.5783972], [40.3123782, 43.5783467], [40.3122817, 43.5782301], [40.3122441, 43.5780164], [40.3122066, 43.5778299], [40.3120993, 43.5776977], [40.3119263, 43.5776287], [40.3117278, 43.5776132], [40.3115521, 43.5776744], [40.3113737, 43.5777842], [40.3111712, 43.5780397], [40.3110251, 43.5782661], [40.3109513, 43.5783661], [40.3108225, 43.5784478], [40.3107193, 43.5784565], [40.3105852, 43.5784332], [40.3102915, 43.5783817], [40.3096209, 43.5782651], [40.3091542, 43.5781524], [40.3088686, 43.578029], [40.3087519, 43.577892], [40.3087251, 43.5778026], [40.3086714, 43.5776938], [40.3085145, 43.577621], [40.3082087, 43.577586], [40.3078614, 43.5775462], [40.3075717, 43.5774956], [40.3074912, 43.5774296], [40.3074859, 43.577313], [40.3076146, 43.5771031], [40.3077165, 43.5769555], [40.3077434, 43.5768039], [40.3076723, 43.5766727], [40.3075704, 43.5766339], [40.3072646, 43.5766766], [40.3068569, 43.5768554], [40.3065082, 43.5770963], [40.3062574, 43.5773363], [40.3061233, 43.5775656], [40.3059624, 43.5776899], [40.3058377, 43.5777453], [40.3056995, 43.5777482], [40.3056405, 43.5776627], [40.3056727, 43.5775267], [40.3056982, 43.5773528], [40.3056459, 43.5772625], [40.3054045, 43.5770643], [40.30521, 43.5768787], [40.3051363, 43.5767417], [40.3051242, 43.576595], [40.3051738, 43.576423], [40.3051684, 43.5762598], [40.3051363, 43.5761277], [40.3049914, 43.5759256], [40.3048841, 43.575638], [40.3048345, 43.5754447], [40.3047339, 43.5752494], [40.3045515, 43.575125], [40.3044067, 43.57509], [40.3042122, 43.5750832], [40.3038367, 43.5751726], [40.3036664, 43.5752105], [40.3035484, 43.5751639], [40.3035108, 43.5750784], [40.3035162, 43.5750006], [40.3035806, 43.5748918], [40.3036986, 43.5747752], [40.3037737, 43.5746509], [40.3037576, 43.5745537], [40.3036557, 43.5744876], [40.3033606, 43.5743982], [40.3030911, 43.5742476], [40.3029047, 43.5740679], [40.3028939, 43.5738969], [40.3029583, 43.5738153], [40.3031192, 43.5737376], [40.3034465, 43.5736326], [40.3036382, 43.5734665], [40.3036825, 43.5733878], [40.3036342, 43.5732517], [40.3035216, 43.5731779], [40.3032748, 43.5731313], [40.303071, 43.5730963], [40.3027531, 43.5731866], [40.3025742, 43.5731786], [40.3023575, 43.5731079], [40.3019216, 43.5727941], [40.3016387, 43.5725755], [40.3014885, 43.5724239], [40.3014134, 43.5722762], [40.3014187, 43.5720741], [40.3014724, 43.5718448], [40.301467, 43.5716388], [40.3014294, 43.5715106], [40.3013315, 43.5714144], [40.3011451, 43.5713512], [40.3009346, 43.5713405], [40.3005269, 43.5713755], [40.3001997, 43.5713949], [40.2999328, 43.5713201], [40.2997866, 43.5712278], [40.2996806, 43.571052], [40.2996753, 43.5708926], [40.2996967, 43.5706594], [40.2996967, 43.5705039], [40.2996538, 43.5703679], [40.2995626, 43.5702863], [40.2994433, 43.5702445], [40.2992837, 43.5702396], [40.299159, 43.5703067], [40.2990248, 43.5704388], [40.2989176, 43.5705438], [40.2986709, 43.5706121], [40.2982865, 43.5707466], [40.2978567, 43.5709626], [40.2975027, 43.5712424], [40.2971044, 43.5714532], [40.2967664, 43.571566], [40.2966672, 43.5715878], [40.2965197, 43.5716204], [40.2962944, 43.5717253], [40.2958223, 43.5717525], [40.2954481, 43.5717554], [40.2952604, 43.5717127], [40.2951155, 43.5716194], [40.2949587, 43.5715103], [40.2946528, 43.571426], [40.2944718, 43.5714095], [40.2942022, 43.5714649], [40.2939394, 43.5715504], [40.2936014, 43.5717797], [40.2933989, 43.5719692], [40.2932916, 43.5722918], [40.293242, 43.5725337], [40.2931253, 43.5727076], [40.2929631, 43.5728058], [40.2927713, 43.5728553], [40.2925017, 43.5729029], [40.2921061, 43.5730263], [40.2918057, 43.573139], [40.2916448, 43.5732984], [40.2915308, 43.5734082], [40.2914527, 43.573491], [40.2912564, 43.5735369], [40.2910158, 43.5735753], [40.2905652, 43.5737308], [40.2902285, 43.5739086], [40.2899442, 43.5740834], [40.2897337, 43.5742166], [40.2893786, 43.5743436], [40.2891098, 43.5744571], [40.2889703, 43.5746312], [40.2888475, 43.5748726], [40.2888244, 43.5751796], [40.2888459, 43.5757239], [40.288793, 43.575856], [40.2885527, 43.5759538], [40.2883223, 43.5759747], [40.287641, 43.5759808], [40.2873082, 43.5760043], [40.2870877, 43.57607], [40.2865823, 43.5763183], [40.28625, 43.5764819], [40.2861248, 43.5765842], [40.286069, 43.5766298], [40.2858936, 43.5769271], [40.2857184, 43.5771418], [40.2855792, 43.5772034], [40.2853405, 43.5772502], [40.2850682, 43.5772926], [40.2849443, 43.5773884], [40.2848352, 43.5775238], [40.284722, 43.5776503], [40.2842775, 43.577817], [40.2834353, 43.5780677], [40.282588, 43.5782931], [40.2820263, 43.5784392], [40.281422, 43.578677], [40.2809519, 43.5787829], [40.2805911, 43.5788331], [40.2800343, 43.578868], [40.2794568, 43.5788286], [40.2787256, 43.5787423], [40.2780435, 43.5786114], [40.2775873, 43.5785103], [40.277218, 43.5783903], [40.2769602, 43.5783065], [40.2764989, 43.5782191], [40.2758034, 43.5781979], [40.2746165, 43.5782136], [40.2742946, 43.5782309], [40.2740028, 43.5781736], [40.2737319, 43.5780356], [40.2729565, 43.5775458], [40.2727499, 43.5774253], [40.2725458, 43.5773723], [40.272331, 43.5773876], [40.2719606, 43.5774791], [40.2717299, 43.5775118], [40.2714606, 43.5774842], [40.2710915, 43.5775236], [40.2707361, 43.5776177], [40.270362, 43.5779084], [40.2699148, 43.5784126], [40.2695796, 43.5787557], [40.2691013, 43.5790742], [40.2687964, 43.5792246], [40.2684415, 43.5793328], [40.2677396, 43.5794892], [40.266767, 43.5796569], [40.266568, 43.5797735], [40.2664733, 43.5798815], [40.2665146, 43.5802336], [40.2665637, 43.5804538], [40.2665103, 43.5805855], [40.2663604, 43.5806832], [40.265568, 43.5808635], [40.2652808, 43.5809655], [40.2650608, 43.5811629], [40.2650284, 43.5813776], [40.265104, 43.5816357], [40.2652963, 43.5819883], [40.2654098, 43.5822207], [40.2653991, 43.582396], [40.265023, 43.5827927], [40.2647457, 43.5830029], [40.2644986, 43.5830799], [40.2640588, 43.5831352], [40.263863, 43.5832122], [40.2637455, 43.5833394], [40.2636339, 43.5835232], [40.2635711, 43.5839124], [40.2634577, 43.5841176], [40.2632211, 43.5842544], [40.2629837, 43.5843659], [40.2626702, 43.5844082], [40.2622598, 43.5845081], [40.2618905, 43.5847309], [40.2617789, 43.5850043], [40.2617625, 43.5852367], [40.261641, 43.5854461], [40.2614195, 43.5855907], [40.2610394, 43.5857659], [40.2605939, 43.5859582], [40.2596042, 43.5861871], [40.259204, 43.5862271], [40.2589499, 43.5861678], [40.2589028, 43.5861533], [40.2586249, 43.5860377], [40.2581735, 43.5858197], [40.2576799, 43.5857072], [40.2571851, 43.5856522], [40.2568804, 43.5856521], [40.2564257, 43.5857696], [40.2560856, 43.5859507], [40.2558179, 43.5862392], [40.2556844, 43.5862843], [40.2555149, 43.5862664], [40.2544396, 43.585975], [40.2541663, 43.585912], [40.2534643, 43.5857888], [40.2531795, 43.585795], [40.2525803, 43.5861428], [40.2523262, 43.5861737], [40.2517692, 43.5860173], [40.2513615, 43.5859987], [40.2506239, 43.5858028], [40.2503465, 43.5856894], [40.2499458, 43.5854185], [40.2495671, 43.5845602], [40.2492915, 43.5843595], [40.2490371, 43.5843189], [40.2487868, 43.5843554], [40.2485805, 43.5843814], [40.2480722, 43.5846611], [40.2467422, 43.5851026], [40.2457112, 43.5854501], [40.2453379, 43.5855483], [40.2450847, 43.5856923], [40.2447165, 43.5859713], [40.2444909, 43.5860336], [40.2442165, 43.5860999], [40.2440177, 43.5861655], [40.2437503, 43.5862048], [40.2434859, 43.5862166], [40.243061, 43.5863029], [40.2427375, 43.5863866], [40.2424425, 43.5864177], [40.2421635, 43.5864294], [40.241965, 43.5863983], [40.2417714, 43.5862938], [40.2416003, 43.5861265], [40.2414983, 43.5859206], [40.241471, 43.5857614], [40.2414018, 43.5856486], [40.2412799, 43.5855869], [40.2410638, 43.585633], [40.2408922, 43.5857185], [40.2407366, 43.5857418], [40.2405649, 43.5857418], [40.2403176, 43.5856721], [40.2400499, 43.5855786], [40.2397603, 43.5853921], [40.239513, 43.5852369], [40.2393091, 43.5851708], [40.238961, 43.585159], [40.2387303, 43.5851395], [40.2385479, 43.5851084], [40.2383596, 43.5850193], [40.2380758, 43.584852], [40.2379256, 43.5846966], [40.237577, 43.5844362], [40.2372604, 43.5842342], [40.236981, 43.5841333], [40.2367186, 43.5840982], [40.2364665, 43.5841176], [40.2362573, 43.5841564], [40.2360978, 43.5841963], [40.2354741, 43.5844556], [40.2352858, 43.5845025], [40.2351844, 43.5844945], [40.2349645, 43.5843974], [40.2347982, 43.5843313], [40.2345085, 43.5842886], [40.2342671, 43.5842419], [40.2341115, 43.5841603], [40.2340364, 43.5840671], [40.2339882, 43.5839233], [40.2338862, 43.5838028], [40.2337199, 43.583729], [40.2334893, 43.5836629], [40.2332338, 43.5836591], [40.2330226, 43.5836474], [40.2328348, 43.5835852], [40.232566, 43.5834455], [40.2318478, 43.5832005], [40.2313167, 43.5829635], [40.2307802, 43.5827342], [40.2303672, 43.5825827], [40.2300346, 43.5824117], [40.229739, 43.5822992], [40.2293635, 43.5821321], [40.2290904, 43.5819881], [40.228849, 43.5818366], [40.2287847, 43.5817278], [40.22879, 43.5815918], [40.2287627, 43.5814326], [40.2286935, 43.5812848], [40.2284574, 43.5810827], [40.227642, 43.5805231], [40.2273095, 43.5803094], [40.2270251, 43.5801812], [40.2266979, 43.5800762], [40.2264726, 43.580049], [40.2262688, 43.580084], [40.2259308, 43.5802472], [40.2256626, 43.5804415], [40.2254797, 43.5805389], [40.2252978, 43.5805814], [40.22511, 43.5805892], [40.2248418, 43.5805231], [40.2245409, 43.5803951], [40.2243054, 43.5802433], [40.2242035, 43.5801034], [40.2241337, 43.5798664], [40.2241176, 43.579571], [40.2241284, 43.5792951], [40.2240372, 43.5791708], [40.2238548, 43.5790425], [40.2235651, 43.5789609], [40.223152, 43.5789143], [40.2228087, 43.578891], [40.2226365, 43.5789223], [40.2222503, 43.5790039], [40.2219123, 43.579066], [40.221628, 43.5790855], [40.2213169, 43.5790699], [40.2207219, 43.5789609], [40.2204591, 43.5789298], [40.2201694, 43.5788677], [40.2199602, 43.5787977], [40.2196485, 43.5786463], [40.2193218, 43.578448], [40.2191663, 43.5783236], [40.2190799, 43.5781917], [40.2188331, 43.577838], [40.2186942, 43.5777212], [40.2184743, 43.5776319], [40.2182382, 43.5775969], [40.217852, 43.5775541], [40.2176251, 43.5775512], [40.2174711, 43.5775502], [40.217374, 43.5775232], [40.2173048, 43.5774764], [40.2172673, 43.5774103], [40.2172665, 43.5772884], [40.2172184, 43.5771774], [40.2170688, 43.5770839], [40.2168429, 43.5769947], [40.2165809, 43.5769557], [40.216285, 43.5769209], [40.2160552, 43.5768702], [40.2159318, 43.5767963], [40.2158559, 43.5767032], [40.2158237, 43.5765478], [40.215813, 43.576404], [40.2157816, 43.5762639], [40.2156709, 43.5761518], [40.2146407, 43.5758597], [40.2144049, 43.5757606], [40.2142754, 43.5756454], [40.2141517, 43.5754672], [40.2140385, 43.5749956], [40.213873, 43.5747956], [40.2136217, 43.5746703], [40.2133108, 43.5746629], [40.212909, 43.5747008], [40.2125456, 43.5747669], [40.2122758, 43.5749004], [40.211889, 43.5751297], [40.2114998, 43.5754474], [40.2112243, 43.5756024], [40.2109601, 43.5756499], [40.2107128, 43.5756291], [40.2100546, 43.5754425], [40.2093766, 43.5752762], [40.2090236, 43.5751468], [40.2087881, 43.5749043], [40.208483, 43.5747348], [40.2082691, 43.5746596], [40.2080027, 43.5746237], [40.2076761, 43.5746075], [40.2072772, 43.5746557], [40.2068395, 43.5747949], [40.206446, 43.575014], [40.205567, 43.5754862], [40.2052645, 43.5756071], [40.2048463, 43.5756695], [40.2041602, 43.5756602], [40.203403, 43.5755399], [40.2030227, 43.5754328], [40.2026342, 43.5752925], [40.2019624, 43.5749058], [40.2015431, 43.5746787], [40.2011793, 43.5745502], [40.2009609, 43.5744977], [40.2004832, 43.5744565], [40.1985209, 43.5745794], [40.1979941, 43.5745368], [40.1975081, 43.5744089], [40.1971213, 43.5743637], [40.1969257, 43.5743557], [40.1967076, 43.5744076], [40.1960683, 43.5745737], [40.1950183, 43.5747883], [40.1945565, 43.5748263], [40.1938787, 43.5747993], [40.1932467, 43.5747614], [40.1928181, 43.5748071], [40.1923157, 43.5748835], [40.1919864, 43.5749068], [40.1916642, 43.5748615], [40.1913628, 43.574741], [40.1911535, 43.5746017], [40.1906045, 43.57416], [40.1901128, 43.5737028], [40.1898714, 43.5735279], [40.189673, 43.5734385], [40.1894691, 43.5734229], [40.1893243, 43.5734696], [40.1890668, 43.573625], [40.1886046, 43.5739517], [40.1883426, 43.5741147], [40.1881119, 43.5741964], [40.1879242, 43.5742546], [40.1878728, 43.5742615], [40.1876023, 43.5742974], [40.1872804, 43.5742935], [40.1867708, 43.5743013], [40.1863838, 43.5742898], [40.1851554, 43.5742737], [40.4192407, 43.5539101]]], [[[40.1851554, 43.5742737], [40.1843843, 43.574134], [40.183699, 43.5740331], [40.1830612, 43.5740646], [40.182577, 43.5742852], [40.1821387, 43.5745506], [40.1817088, 43.5746141], [40.1808722, 43.5745502], [40.1798964, 43.5745564], [40.1788326, 43.5744451], [40.1778646, 43.5742101], [40.1770506, 43.5739898], [40.1759047, 43.5739968], [40.1755134, 43.5741058], [40.1749992, 43.5745378], [40.1729607, 43.5756769], [40.171962, 43.576666], [40.1711418, 43.5765604], [40.168782, 43.574521], [40.167328, 43.573851], [40.1653005, 43.573581], [40.164435, 43.573362], [40.1630297, 43.5725206], [40.1613299, 43.5726809], [40.1597635, 43.573423], [40.1588065, 43.574014], [40.1572621, 43.5745557], [40.155816, 43.574276], [40.154529, 43.573612], [40.1539208, 43.5732715], [40.153757, 43.572787], [40.1535393, 43.5725779], [40.1530606, 43.5723503], [40.1522304, 43.572204], [40.1513927, 43.572399], [40.1506687, 43.5723947], [40.1499409, 43.572346], [40.1491637, 43.572036], [40.1485217, 43.5715819], [40.1474967, 43.5715139], [40.1463939, 43.5715251], [40.1458674, 43.5714398], [40.1449928, 43.5705658], [40.1443949, 43.5702544], [40.1436352, 43.570229], [40.142647, 43.570305], [40.1420108, 43.5701189], [40.1414418, 43.5696579], [40.1411233, 43.5694399], [40.1400591, 43.5692044], [40.138845, 43.56862], [40.1380022, 43.568273], [40.1374319, 43.5678056], [40.1368502, 43.5671628], [40.1355863, 43.5672322], [40.1346824, 43.5673151], [40.1332074, 43.5661832], [40.1316689, 43.5655375], [40.130665, 43.5650393], [40.130064, 43.5650755], [40.1286564, 43.5656876], [40.127736, 43.5658581], [40.1252103, 43.5661171], [40.1241095, 43.5662169], [40.1226814, 43.5672104], [40.1217818, 43.5675174], [40.1200077, 43.5676079], [40.1193799, 43.5680825], [40.1185034, 43.5683868], [40.1178912, 43.5687542], [40.1164393, 43.5688645], [40.11518, 43.568916], [40.1147305, 43.5686616], [40.1142679, 43.5686723], [40.1137049, 43.5686766], [40.113052, 43.5688634], [40.1117198, 43.5686248], [40.1103624, 43.5686647], [40.1097733, 43.5696009], [40.109009, 43.569605], [40.1074454, 43.5691652], [40.1063612, 43.5686127], [40.1059148, 43.5681711], [40.1038511, 43.5681921], [40.1022343, 43.5675939], [40.1018508, 43.5673425], [40.1011935, 43.5665883], [40.099733, 43.5662485], [40.0984909, 43.5661649], [40.0978832, 43.5659785], [40.097797, 43.5654901], [40.0979065, 43.5646036], [40.0976209, 43.5635778], [40.0980344, 43.5630687], [40.0982905, 43.5624739], [40.0979884, 43.5618583], [40.0971578, 43.5613882], [40.09628, 43.560463], [40.0948753, 43.5597606], [40.0940284, 43.5583211], [40.091515, 43.556237], [40.0906936, 43.555579], [40.0904828, 43.5546436], [40.0908579, 43.5540174], [40.0908397, 43.5532233], [40.0912414, 43.5522969], [40.091311, 43.5515704], [40.0918075, 43.5508279], [40.092684, 43.5504441], [40.0931659, 43.5500145], [40.0930967, 43.5494042], [40.0921727, 43.5484324], [40.0916832, 43.5475483], [40.0927135, 43.5470743], [40.0937038, 43.545702], [40.0935605, 43.5447661], [40.0931953, 43.5440249], [40.0935696, 43.542868], [40.0928819, 43.5417761], [40.0931405, 43.5409937], [40.0929628, 43.539847], [40.0932866, 43.5392994], [40.0940353, 43.5390347], [40.094484, 43.538776], [40.0949129, 43.5384033], [40.0948022, 43.5378962], [40.0952222, 43.5365063], [40.0952525, 43.5353409], [40.0953705, 43.5349108], [40.095621, 43.5334204], [40.0957332, 43.5325054], [40.0957854, 43.532063], [40.095321, 43.5308667], [40.0953866, 43.5300326], [40.0952675, 43.5296922], [40.0950577, 43.5293754], [40.0947065, 43.529076], [40.0927006, 43.5280839], [40.0923189, 43.5276668], [40.0921287, 43.5273369], [40.0919201, 43.5265326], [40.0917304, 43.526076], [40.0916256, 43.5256096], [40.0914239, 43.5252242], [40.0907889, 43.5242785], [40.0899135, 43.5235107], [40.088901, 43.5228853], [40.0876199, 43.5221379], [40.0870328, 43.5217201], [40.0862791, 43.5209725], [40.0854897, 43.5204719], [40.0845338, 43.5196715], [40.0840974, 43.5194675], [40.0835931, 43.5193621], [40.0830889, 43.5192897], [40.0820806, 43.5194123], [40.0816585, 43.5193477], [40.0812722, 43.5192434], [40.0810334, 43.5190246], [40.0807551, 43.5184728], [40.0802093, 43.5179016], [40.0799723, 43.5177392], [40.079544, 43.5176149], [40.0784652, 43.5174649], [40.0776656, 43.5172877], [40.0771521, 43.5170955], [40.0768345, 43.5167301], [40.0766376, 43.5161662], [40.0766965, 43.5152618], [40.0766821, 43.5147984], [40.0763466, 43.5139803], [40.0759243, 43.5135006], [40.0754118, 43.5130894], [40.0743507, 43.5123553], [40.0735718, 43.5118279], [40.073325, 43.5114838], [40.0730951, 43.5109234], [40.0728945, 43.5105845], [40.0725005, 43.5098732], [40.0722414, 43.5096465], [40.0714434, 43.5096352], [40.0702139, 43.5097284], [40.0698993, 43.5096267], [40.0696303, 43.5092738], [40.0691648, 43.5084641], [40.0687033, 43.5076712], [40.0679547, 43.5072689], [40.0668662, 43.5067521], [40.0650172, 43.5060808], [40.0636988, 43.5054547], [40.0636969, 43.505442], [40.0634995, 43.5052932], [40.0629593, 43.5046004], [40.1851554, 43.5742737]]], [[[40.0266201, 43.4363954], [40.0290843, 43.4382021], [40.0302702, 43.439245], [40.0313082, 43.4401496], [40.0323701, 43.4411752], [40.0328411, 43.4417729], [40.0332579, 43.4424701], [40.0337179, 43.4433543], [40.0359617, 43.4449763], [40.0364401, 43.4459902], [40.0357457, 43.4474152], [40.0366225, 43.4499326], [40.0374808, 43.4504818], [40.0389375, 43.4513253], [40.0405691, 43.4521552], [40.0415623, 43.453045], [40.0420695, 43.4535193], [40.0422527, 43.4538548], [40.0423785, 43.4547226], [40.0423495, 43.4554773], [40.0424128, 43.4568439], [40.0421076, 43.458669], [40.0419075, 43.4599016], [40.0420175, 43.4606895], [40.0422631, 43.4622193], [40.0426053, 43.4630609], [40.0429264, 43.464106], [40.0431659, 43.4647874], [40.0434432, 43.4655856], [40.0438793, 43.4670485], [40.0443021, 43.4680829], [40.0443511, 43.468656], [40.0441454, 43.469599], [40.0439054, 43.4709534], [40.0443554, 43.472643], [40.0443299, 43.4732446], [40.0440649, 43.474176], [40.0443855, 43.4750713], [40.0449246, 43.4756541], [40.0457845, 43.4763153], [40.0461522, 43.4767904], [40.0463409, 43.4774305], [40.04698, 43.4786286], [40.0483565, 43.4799815], [40.0485749, 43.4811961], [40.0487969, 43.4822178], [40.049581, 43.4834334], [40.050054, 43.4844823], [40.0510127, 43.4855439], [40.0519388, 43.4865765], [40.0526573, 43.4877269], [40.0533208, 43.4886251], [40.0548507, 43.489838], [40.05527, 43.4904577], [40.0554579, 43.4913592], [40.0557018, 43.4921803], [40.0561809, 43.4930437], [40.0570081, 43.4938243], [40.0577457, 43.4947472], [40.057975, 43.4960556], [40.0590267, 43.4965163], [40.0594284, 43.4980771], [40.0597976, 43.4987527], [40.0601996, 43.4991496], [40.0610142, 43.4998342], [40.061261, 43.5000444], [40.0614114, 43.5002598], [40.0616131, 43.5006354], [40.0617789, 43.501659], [40.0617175, 43.5022703], [40.0619229, 43.5030516], [40.062322, 43.5037137], [40.0629593, 43.5046004], [40.0266201, 43.4363954]]], [[[40.0129583, 43.4283451], [40.0139263, 43.4293417], [40.0148833, 43.4300764], [40.0160405, 43.4307985], [40.0167475, 43.4310879], [40.0180926, 43.4313037], [40.0194367, 43.4315934], [40.020719, 43.4320277], [40.0216033, 43.432577], [40.0225561, 43.4334087], [40.024822, 43.435283], [40.0266201, 43.4363954], [40.0129583, 43.4283451]]], [[[40.0087701, 43.4065076], [40.0089442, 43.4070085], [40.0090426, 43.4071531], [40.0110033, 43.4096612], [40.0122508, 43.4112646], [40.0130209, 43.4113953], [40.013887, 43.411984], [40.0139952, 43.4126984], [40.0136379, 43.413419], [40.0135482, 43.4140786], [40.0138334, 43.4145037], [40.014157, 43.414798], [40.0152033, 43.4159293], [40.015521, 43.4166448], [40.0155557, 43.4171737], [40.015238, 43.4175609], [40.014631, 43.4182568], [40.0145616, 43.418727], [40.0146762, 43.4193089], [40.0147047, 43.4208583], [40.0137025, 43.4215101], [40.0132181, 43.4218395], [40.0127398, 43.4221399], [40.0113728, 43.4227403], [40.010543, 43.423168], [40.010135, 43.4240409], [40.0101474, 43.4243519], [40.0107961, 43.4247257], [40.0117437, 43.4254822], [40.0120071, 43.4257121], [40.0121929, 43.4266157], [40.0123845, 43.4273193], [40.0127584, 43.4280039], [40.0129583, 43.4283451], [40.0087701, 43.4065076]]], [[[40.0080645, 43.4032071], [40.007925, 43.4038947], [40.0081982, 43.4045548], [40.0085827, 43.4059186], [40.0087701, 43.4065076], [40.0080645, 43.4032071]]], [[[40.0089228, 43.3949798], [40.0091492, 43.395481], [40.0092354, 43.396184], [40.0092144, 43.3968612], [40.0089759, 43.3973329], [40.0088767, 43.3975289], [40.0087168, 43.3977962], [40.0085874, 43.3981095], [40.0084171, 43.3995292], [40.0083628, 43.4002364], [40.0082721, 43.4021527], [40.0080645, 43.4032071], [40.0089228, 43.3949798]]], [[[40.0085526, 43.3855385], [40.0074266, 43.3859143], [40.0072987, 43.3862746], [40.0072398, 43.3881328], [40.0072488, 43.3882801], [40.0067719, 43.3897308], [40.0068045, 43.3897509], [40.0066929, 43.3898955], [40.0067748, 43.3906669], [40.0069308, 43.3908928], [40.0075507, 43.3913665], [40.0079127, 43.3922163], [40.0083648, 43.3934116], [40.0084652, 43.3938247], [40.0085003, 43.3939326], [40.008637, 43.3943486], [40.0089228, 43.3949798], [40.0085526, 43.3855385]]], [[[39.8844803, 43.2244305], [39.9448432, 43.3028651], [40.0085526, 43.3855385], [39.8844803, 43.2244305]]], [[[39.8844803, 43.2244305], [39.8671003, 43.2258232], [39.8498824, 43.2280412], [39.8329005, 43.2310749], [39.8162273, 43.2349111], [39.7999342, 43.2395333], [39.7840909, 43.2449215], [39.7687652, 43.2510523], [39.7540229, 43.2578995], [39.739927, 43.2654332], [39.7265379, 43.2736213], [39.713913, 43.2824281], [39.7021062, 43.2918159], [39.6911682, 43.301744], [39.6811458, 43.3121699], [39.6720818, 43.3230485], [39.6640153, 43.3343331], [39.6569806, 43.345975], [39.6511328, 43.3576238], [39.6489836, 43.3598447], [39.6413846, 43.3689029], [39.6348849, 43.371898], [39.6212402, 43.3791359], [39.6082761, 43.3870059], [39.6045135, 43.3896117], [39.5993581, 43.3913607], [39.5840325, 43.3974769], [39.5692901, 43.4043075], [39.5551943, 43.4118232], [39.5418052, 43.4199915], [39.5291802, 43.4287772], [39.5173734, 43.4381423], [39.5064355, 43.4480466], [39.4964131, 43.4584472], [39.4873491, 43.4692996], [39.4792825, 43.4805569], [39.4722479, 43.4921708], [39.4711876, 43.4942871], [39.4654727, 43.496564], [39.4507304, 43.5033835], [39.4366344, 43.5108868], [39.4232453, 43.5190417], [39.4106204, 43.5278129], [39.3988137, 43.5371628], [39.3878756, 43.5470508], [39.3778532, 43.5574344], [39.3687893, 43.568269], [39.3607227, 43.579508], [39.3568145, 43.5859499], [39.346146, 43.5954718], [39.3364262, 43.6054762], [39.3341367, 43.6081944], [39.3246943, 43.613905], [39.3124661, 43.6223415], [39.3018432, 43.6311957], [39.2877454, 43.6387284], [39.2743562, 43.646866], [39.2617313, 43.6556187], [39.2499246, 43.6649486], [39.2389865, 43.6748157], [39.2289641, 43.6851773], [39.2199003, 43.6959889], [39.2118337, 43.7072039], [39.2047989, 43.7187742], [39.204025, 43.7203132], [39.2025819, 43.7209783], [39.188486, 43.7284545], [39.1750969, 43.7365799], [39.1624719, 43.7453196], [39.1506652, 43.7546355], [39.1397272, 43.7644878], [39.1297048, 43.7748339], [39.1277095, 43.7767467], [39.1155223, 43.7845081], [39.1022064, 43.789686], [39.0869741, 43.7976368], [39.0738608, 43.8071846], [39.0630474, 43.8157148], [39.050052, 43.8275927], [39.0349534, 43.838359], [39.026833, 43.8440286], [39.0212549, 43.8467176], [39.0115145, 43.8513341], [38.9985503, 43.8578569], [38.9851837, 43.8647697], [38.9720165, 43.8727101], [38.9591666, 43.881874], [38.9469311, 43.8915423], [38.9365923, 43.9008355], [38.9260438, 43.9106637], [38.9205862, 43.9168744], [38.9156433, 43.9206938], [38.9100569, 43.9239605], [38.8947312, 43.9300226], [38.8799889, 43.9367929], [38.865893, 43.9442422], [38.8525039, 43.9523383], [38.839879, 43.9610463], [38.8280722, 43.9703287], [38.8171342, 43.9801454], [38.8071118, 43.9904541], [38.7980479, 44.0012106], [38.797372, 44.0021456], [38.7907253, 44.0047545], [38.7764586, 44.0112593], [38.7645691, 44.0171583], [38.7489258, 44.0223997], [38.7336002, 44.0284518], [38.7188579, 44.035211], [38.704762, 44.0426479], [38.6913728, 44.0507305], [38.6787479, 44.0594242], [38.6669412, 44.0686911], [38.6560031, 44.0784916], [38.6459807, 44.0887832], [38.6369169, 44.0995218], [38.6288503, 44.1106611], [38.6238792, 44.1187822], [38.6153203, 44.1226771], [38.6022698, 44.1296005], [38.5848897, 44.1309724], [38.5676719, 44.1331572], [38.55069, 44.1361454], [38.5340168, 44.1399242], [38.5177236, 44.1444771], [38.5018802, 44.1497846], [38.4865546, 44.1558237], [38.4718123, 44.1625682], [38.4603483, 44.1686037], [38.452137, 44.1700309], [38.4360157, 44.1736482], [38.4248518, 44.1767412], [38.4210032, 44.1770372], [38.4043616, 44.179114], [38.387945, 44.1819668], [38.3827157, 44.18314], [38.3649278, 44.1828529], [38.3474599, 44.1834055], [38.3300799, 44.1847762], [38.312862, 44.186959], [38.2958801, 44.1899446], [38.2792069, 44.1937199], [38.2629138, 44.1982686], [38.2470704, 44.2035713], [38.2317448, 44.2096048], [38.2170025, 44.2163432], [38.2029065, 44.2237574], [38.1942774, 44.2289508], [38.1824371, 44.2298839], [38.1652192, 44.2320651], [38.1482373, 44.2350483], [38.131564, 44.2388207], [38.1152709, 44.243366], [38.0994276, 44.2486646], [38.0841019, 44.2546935], [38.0693596, 44.2614267], [38.0552638, 44.2688352], [38.0418747, 44.276887], [38.0292497, 44.2855473], [38.0174429, 44.2947789], [38.006505, 44.3045418], [37.9964826, 44.314794], [37.9874186, 44.3254915], [37.979352, 44.3365881], [37.9770238, 44.3403773], [37.9684228, 44.3448918], [37.9550337, 44.3529331], [37.9424088, 44.3615822], [37.9306021, 44.3708018], [37.919664, 44.3805521], [37.909643, 44.3907896], [37.9050439, 44.3915953], [37.8883707, 44.3953577], [37.8720775, 44.3998909], [37.8562342, 44.4051753], [37.8409086, 44.4111883], [37.8261662, 44.4179035], [37.8120703, 44.4252922], [37.7986812, 44.4333226], [37.7860563, 44.4419598], [37.7742496, 44.4511667], [37.7633115, 44.4609036], [37.7534705, 44.4709434], [37.7473434, 44.4705629], [37.7298625, 44.4702964], [37.7123946, 44.4708463], [37.6950146, 44.4722103], [37.6777967, 44.4743824], [37.6608148, 44.4773533], [37.6441415, 44.4811102], [37.6407599, 44.4820497], [37.6290676, 44.4807695], [37.6116486, 44.4796879], [37.5941677, 44.4794214], [37.5766998, 44.4799712], [37.5593198, 44.481335], [37.5421019, 44.4835068], [37.52512, 44.4864773], [37.5084468, 44.4902335], [37.4921537, 44.4947594], [37.4763103, 44.5000353], [37.4609846, 44.5060384], [37.4462424, 44.5127427], [37.4321464, 44.5201195], [37.4295913, 44.5216496], [37.414719, 44.5235243], [37.3977371, 44.5264927], [37.3810639, 44.5302463], [37.3647708, 44.5347691], [37.3489275, 44.5400413], [37.3336018, 44.5460403], [37.3188595, 44.5527402], [37.3047636, 44.5601118], [37.2913745, 44.5681236], [37.2787496, 44.5767408], [37.2687737, 44.5845022], [39.8844803, 43.2244305]]], [[[37.2687737, 44.5845022], [37.2606969, 44.5871877], [37.2453712, 44.5931818], [37.2306289, 44.5998761], [37.2165331, 44.6072419], [37.203144, 44.6152471], [37.190519, 44.6238574], [37.1787122, 44.6330356], [37.1677743, 44.6427421], [37.1577518, 44.6529352], [37.1486879, 44.6635708], [37.1406213, 44.6746032], [37.1335866, 44.6859851], [37.1276139, 44.6976674], [37.1227287, 44.7095999], [37.118952, 44.7217315], [37.1163, 44.7340101], [37.114784, 44.7463829], [37.1147406, 44.7478252], [37.1044942, 44.7547974], [37.0926874, 44.7639549], [37.0817494, 44.7736395], [37.071727, 44.7838095], [37.0626631, 44.7944211], [37.0545965, 44.8054286], [37.0475618, 44.8167847], [37.0415891, 44.8284407], [37.0367039, 44.8403462], [37.0352321, 44.8450639], [37.0317004, 44.846039], [37.015857, 44.8512829], [37.0005315, 44.8572498], [36.9857891, 44.8639136], [36.9716932, 44.8712458], [36.9583041, 44.8792146], [36.954665, 44.8816854], [36.9415827, 44.8833241], [36.9246008, 44.8862742], [36.9079275, 44.8900046], [36.8916344, 44.8944993], [36.8757911, 44.8997389], [36.8604654, 44.9057007], [36.8457231, 44.9123589], [36.8437596, 44.9133794], [36.8279858, 44.9153543], [36.8110039, 44.9183027], [36.7943307, 44.9220311], [36.7909226, 44.9229708], [36.7748855, 44.9212282], [36.7574665, 44.9201548], [36.7399856, 44.9198903], [36.7225178, 44.920436], [36.7051377, 44.9217894], [36.6879199, 44.9239447], [36.670938, 44.9268927], [36.6542647, 44.9306205], [36.6379715, 44.935112], [36.6266191, 44.9388638], [36.6166411, 44.9391754], [36.6097225, 44.9406672], [37.2687737, 44.5845022]]], [[[36.6684499, 45.6266206], [36.6815681, 45.4566115], [36.6635019, 45.3599397], [36.6536169, 45.3522562], [36.6227602, 45.3280113], [36.6030245, 45.3093876], [36.5937019, 45.2823897], [36.5941742, 45.252542], [36.5859391, 45.2441721], [36.5542469, 45.2216309], [36.530486, 45.1992024], [36.5327005, 45.1837928], [36.5338353, 45.1751824], [36.5356885, 45.1659388], [36.5428648, 45.1340402], [36.5679872, 45.0506562], [36.5983297, 44.9685154], [36.6097225, 44.9406672], [36.6684499, 45.6266206]]], [[[40.5139054, 44.9441994], [40.5088403, 44.9468704], [40.5059486, 44.9483952], [40.5004241, 44.9513083], [40.4982793, 44.953976], [40.4928617, 44.9559544], [40.4889506, 44.9573826], [40.4823196, 44.9610932], [40.5139054, 44.9441994]]], [[[40.5548619, 44.8816625], [40.5522432, 44.8841721], [40.5493826, 44.8856541], [40.547462, 44.8892651], [40.5467813, 44.8898439], [40.5438674, 44.8935769], [40.5432343, 44.8938096], [40.5420492, 44.8938342], [40.541387, 44.894254], [40.5408293, 44.8956244], [40.5402193, 44.8960565], [40.5375023, 44.8965669], [40.5352218, 44.8983029], [40.5331795, 44.9004246], [40.532771, 44.9012926], [40.5339283, 44.9019677], [40.5337241, 44.9026186], [40.5396291, 44.9063808], [40.5388474, 44.9072944], [40.5372681, 44.91146], [40.5366145, 44.9127521], [40.5309386, 44.9169054], [40.5304733, 44.9198712], [40.5283459, 44.9291911], [40.527814, 44.9334741], [40.5139054, 44.9441994], [40.5548619, 44.8816625]]], [[[40.5835024, 44.8430931], [40.5824472, 44.844517], [40.5812219, 44.8450962], [40.5794806, 44.8553063], [40.5859347, 44.8595481], [40.5875677, 44.8610382], [40.5884612, 44.8626366], [40.5879384, 44.8635346], [40.5869796, 44.8642247], [40.5850593, 44.8647816], [40.5837086, 44.8650132], [40.5810074, 44.8656771], [40.5801796, 44.8662947], [40.5800489, 44.8668969], [40.579635, 44.8674064], [40.5788262, 44.86761], [40.5771584, 44.8675617], [40.574768, 44.8667454], [40.5719165, 44.8665726], [40.5679001, 44.8675376], [40.5670975, 44.8685842], [40.5673559, 44.8696877], [40.5548619, 44.8816625], [40.5835024, 44.8430931]]], [[[40.5964884, 44.8242933], [40.5954428, 44.8246641], [40.5941139, 44.8243706], [40.5929158, 44.8244787], [40.5912602, 44.8265182], [40.5905849, 44.8275688], [40.5898401, 44.8282552], [40.5885766, 44.8283633], [40.5872914, 44.8282397], [40.5865289, 44.828765], [40.5865943, 44.8300937], [40.5863329, 44.831067], [40.5860795, 44.8315996], [40.586115, 44.8356552], [40.5854179, 44.8367365], [40.5853308, 44.8378951], [40.5847208, 44.8387138], [40.5846119, 44.8393471], [40.5851783, 44.840776], [40.5840455, 44.8411081], [40.5837336, 44.8416614], [40.5835024, 44.8430931], [40.5964884, 44.8242933]]], [[[40.6099658, 44.806039], [40.6082405, 44.8061009], [40.6068289, 44.8068057], [40.6059749, 44.8065213], [40.6051368, 44.8067709], [40.6042101, 44.80742], [40.6024742, 44.8078547], [40.6009425, 44.8079271], [40.6005, 44.8081686], [40.5990364, 44.8107042], [40.598997, 44.812569], [40.5993399, 44.8139973], [40.5987681, 44.8146155], [40.5972704, 44.8165278], [40.5973249, 44.8179765], [40.5976789, 44.8185173], [40.5975972, 44.8199274], [40.5969981, 44.8203716], [40.5955277, 44.8203523], [40.5951192, 44.8207579], [40.5945714, 44.8216821], [40.59492, 44.8225473], [40.5963142, 44.8234435], [40.5964884, 44.8242933], [40.6099658, 44.806039]]], [[[40.6489631, 44.6962645], [40.6490904, 44.6965003], [40.649515, 44.6968336], [40.6500787, 44.6970812], [40.6503086, 44.6971245], [40.6506252, 44.6974501], [40.6509978, 44.6975655], [40.6512245, 44.6978704], [40.651861, 44.6981879], [40.6524974, 44.6995166], [40.6531712, 44.7007612], [40.6527539, 44.7015038], [40.6521754, 44.7019834], [40.6512211, 44.702541], [40.6504118, 44.703059], [40.6497984, 44.7037275], [40.6496354, 44.7046405], [40.6492459, 44.7062319], [40.6491215, 44.7083291], [40.6487408, 44.7098301], [40.6486361, 44.7106151], [40.6486918, 44.711855], [40.6503257, 44.7138095], [40.6504073, 44.7143319], [40.6495904, 44.7155123], [40.6492092, 44.7173505], [40.6477388, 44.7199627], [40.6454514, 44.7205818], [40.6422927, 44.7231745], [40.6421565, 44.724316], [40.6418842, 44.7251672], [40.6410401, 44.7258444], [40.6405091, 44.7265779], [40.6405742, 44.7276783], [40.6408805, 44.7283312], [40.6405742, 44.734183], [40.6395871, 44.735924], [40.6390424, 44.7379066], [40.63683, 44.73972], [40.6372497, 44.7416061], [40.6379849, 44.7423604], [40.6380938, 44.7430566], [40.6389108, 44.7446813], [40.6391558, 44.7467313], [40.63823, 44.7476403], [40.6367012, 44.7479226], [40.6362107, 44.7488911], [40.636129, 44.749626], [40.6354482, 44.7505542], [40.6340323, 44.7515598], [40.6333243, 44.7531842], [40.6313637, 44.7552146], [40.6310914, 44.7564908], [40.6304923, 44.7576897], [40.6283139, 44.7594492], [40.6276604, 44.760416], [40.6264078, 44.7613827], [40.6265627, 44.7636429], [40.6269983, 44.7639522], [40.6279514, 44.7638749], [40.6285505, 44.7647449], [40.6285777, 44.7662142], [40.6295035, 44.7668329], [40.6303204, 44.7687275], [40.629912, 44.7697714], [40.630008, 44.7702316], [40.6312334, 44.7711982], [40.6311994, 44.7717056], [40.6306548, 44.7731313], [40.6334118, 44.7751851], [40.6330714, 44.7759825], [40.6294975, 44.777698], [40.6288167, 44.7783987], [40.6287486, 44.7795343], [40.6266358, 44.7824244], [40.6262354, 44.7835855], [40.625473, 44.7846678], [40.6251462, 44.7859241], [40.6253368, 44.7870837], [40.6242204, 44.7900405], [40.6220692, 44.7920503], [40.6216335, 44.7929006], [40.6222551, 44.7951249], [40.6197464, 44.7981242], [40.6178062, 44.7985589], [40.6170574, 44.7986556], [40.6157299, 44.7994043], [40.6146067, 44.799839], [40.6132111, 44.8020369], [40.6131812, 44.8038038], [40.6122488, 44.8045058], [40.611848, 44.80458], [40.6105409, 44.8058165], [40.6099658, 44.806039], [40.6489631, 44.6962645]]], [[[40.6821713, 44.659715], [40.6820867, 44.6598618], [40.6817939, 44.6603698], [40.6809056, 44.6610861], [40.6802233, 44.6618193], [40.6801862, 44.6621358], [40.680431, 44.6624048], [40.6799921, 44.6629886], [40.679926, 44.6631264], [40.6798636, 44.6632], [40.6798558, 44.6632721], [40.679835, 44.6635596], [40.67991, 44.6637025], [40.6799109, 44.6638548], [40.679931, 44.6639252], [40.6800118, 44.6641694], [40.6798322, 44.664446], [40.6798062, 44.6645212], [40.6796967, 44.6646474], [40.6794819, 44.6649053], [40.6794233, 44.6649688], [40.6793359, 44.6650253], [40.6792757, 44.6650924], [40.6792145, 44.665149], [40.6790076, 44.6651893], [40.6788013, 44.6651967], [40.6786834, 44.6651894], [40.6785862, 44.6651562], [40.6784831, 44.6651508], [40.6783983, 44.6651806], [40.6783349, 44.6652314], [40.6782977, 44.6653023], [40.6782405, 44.6653691], [40.677944, 44.6654346], [40.6778202, 44.6656086], [40.6781799, 44.6661608], [40.6777489, 44.6669505], [40.6757468, 44.6675691], [40.6745449, 44.6675059], [40.6730254, 44.667185], [40.6728164, 44.6674099], [40.6713414, 44.668419], [40.6702053, 44.6696175], [40.6696425, 44.6705671], [40.6700364, 44.6715183], [40.6703819, 44.6728349], [40.6711214, 44.6742185], [40.6726497, 44.6758444], [40.6725973, 44.6770507], [40.6697372, 44.6785029], [40.6685703, 44.6790312], [40.6657279, 44.679787], [40.6643786, 44.6804113], [40.6642438, 44.6811134], [40.6643032, 44.6816354], [40.6643778, 44.6820173], [40.664318, 44.6827428], [40.6645776, 44.6831436], [40.6650519, 44.6835585], [40.6654641, 44.6838807], [40.6646604, 44.6848497], [40.6645196, 44.685207], [40.6637828, 44.6857543], [40.6628133, 44.6857586], [40.6615784, 44.6855095], [40.6590929, 44.685841], [40.6585399, 44.6862689], [40.658014, 44.6864234], [40.6578415, 44.6864312], [40.6574281, 44.6864498], [40.6565677, 44.686513], [40.6561208, 44.6865728], [40.6555491, 44.686715], [40.6554223, 44.6867032], [40.655077, 44.6866712], [40.6545356, 44.6867134], [40.6538162, 44.6868679], [40.6533712, 44.6871669], [40.6527853, 44.6874674], [40.652451, 44.6878529], [40.6523872, 44.688116], [40.6523552, 44.6885905], [40.6523991, 44.6888341], [40.6527351, 44.6897985], [40.6523774, 44.690399], [40.6523814, 44.6905363], [40.6523997, 44.6911688], [40.6519425, 44.6918512], [40.6518064, 44.6921653], [40.6517693, 44.6924922], [40.6512427, 44.6931196], [40.650553, 44.6936626], [40.6503311, 44.6939536], [40.6499327, 44.6942692], [40.6498734, 44.6943641], [40.6494677, 44.6948859], [40.6492967, 44.695034], [40.6490904, 44.6952127], [40.6491123, 44.6954441], [40.6488791, 44.6958623], [40.6489368, 44.6962323], [40.6489631, 44.6962645], [40.6821713, 44.659715]]], [[[40.7286345, 44.5677647], [40.7288266, 44.5689142], [40.7275877, 44.5706322], [40.7277853, 44.5720631], [40.7283121, 44.5733767], [40.729761, 44.5742681], [40.7307327, 44.5754432], [40.7290036, 44.5772235], [40.7291683, 44.5794752], [40.7294222, 44.5800157], [40.7299781, 44.5808477], [40.7304959, 44.5823804], [40.7310624, 44.583603], [40.7304752, 44.5849649], [40.7306437, 44.5867461], [40.7309386, 44.5872137], [40.7314057, 44.5880786], [40.731647, 44.5887345], [40.7316688, 44.5891791], [40.7314564, 44.5895281], [40.7313403, 44.5899615], [40.7314057, 44.5907133], [40.7315458, 44.592443], [40.7313198, 44.5936145], [40.7305742, 44.5947581], [40.7306947, 44.5956789], [40.7318097, 44.5972797], [40.7318808, 44.5976628], [40.7323207, 44.5980779], [40.7334226, 44.5990807], [40.7335912, 44.6000882], [40.7336352, 44.6008086], [40.7342689, 44.6016267], [40.7348726, 44.6018687], [40.735232, 44.6020104], [40.7352906, 44.6022212], [40.7346585, 44.6030377], [40.7340517, 44.6036849], [40.7337421, 44.604802], [40.7338814, 44.6057624], [40.7338146, 44.6066198], [40.7333649, 44.6073506], [40.7334655, 44.6081982], [40.7318949, 44.6087203], [40.731207, 44.6096759], [40.7300337, 44.6105798], [40.729016, 44.6113812], [40.7284453, 44.6118838], [40.7279913, 44.6125362], [40.7277814, 44.6130057], [40.7278288, 44.6136324], [40.7275351, 44.613822], [40.7271373, 44.6143528], [40.7267149, 44.6146103], [40.7265266, 44.6149578], [40.7257947, 44.6156435], [40.7255334, 44.6162566], [40.7251079, 44.6168171], [40.7246989, 44.6180066], [40.7243951, 44.6188184], [40.723646, 44.6188687], [40.7228584, 44.6190036], [40.7221165, 44.6193157], [40.7213667, 44.6199346], [40.7201511, 44.6205855], [40.7193999, 44.6211561], [40.7190405, 44.6213516], [40.7187522, 44.6215771], [40.7183475, 44.6220187], [40.7184723, 44.6225069], [40.7186908, 44.622781], [40.7186277, 44.6232795], [40.7183143, 44.6241446], [40.7172627, 44.6246177], [40.7156961, 44.6262082], [40.7148935, 44.6270009], [40.7140487, 44.6275198], [40.7137599, 44.6276897], [40.7133866, 44.6277856], [40.7128568, 44.6278122], [40.7125676, 44.6280845], [40.7114067, 44.6283633], [40.7109125, 44.6286111], [40.7100742, 44.62878], [40.7094465, 44.6290874], [40.7082703, 44.6293118], [40.707793, 44.6295381], [40.7072891, 44.6298385], [40.7069889, 44.6303317], [40.7066985, 44.6305883], [40.7058864, 44.6310247], [40.7055338, 44.6313222], [40.7031965, 44.6321244], [40.7010328, 44.6330398], [40.7007322, 44.6332617], [40.7001393, 44.6336993], [40.6988817, 44.6335175], [40.6984859, 44.633756], [40.6978888, 44.6339895], [40.6965584, 44.6342773], [40.6960647, 44.6344846], [40.6960615, 44.6345701], [40.6958139, 44.6348278], [40.6956396, 44.635067], [40.6955713, 44.6354142], [40.6954088, 44.6357951], [40.6948941, 44.6364381], [40.6943953, 44.636764], [40.6939124, 44.6369058], [40.6928563, 44.6376457], [40.6926208, 44.6379812], [40.6919361, 44.6388905], [40.6911173, 44.6403633], [40.6909362, 44.6406525], [40.6904643, 44.6423659], [40.6895665, 44.6429989], [40.6892959, 44.6437612], [40.6890506, 44.6447142], [40.6883391, 44.6455608], [40.6872484, 44.6462186], [40.6863148, 44.6465101], [40.6861193, 44.6466879], [40.6858499, 44.646841], [40.6852674, 44.6470625], [40.6847699, 44.6472965], [40.6841296, 44.6476613], [40.6835996, 44.6485024], [40.6833753, 44.6490759], [40.6830314, 44.6496801], [40.683021, 44.6501944], [40.6828629, 44.6503639], [40.6826426, 44.6507338], [40.6824265, 44.6513427], [40.6823812, 44.6518275], [40.682596, 44.6524279], [40.6826665, 44.6526404], [40.6826937, 44.652832], [40.6827261, 44.653448], [40.6827903, 44.6540661], [40.6829771, 44.6547028], [40.6827456, 44.6562162], [40.6824645, 44.6571144], [40.6822626, 44.6582129], [40.6827009, 44.6587959], [40.6821713, 44.659715], [40.7286345, 44.5677647]]], [[[40.7333477, 44.5430146], [40.732648, 44.5450682], [40.7317424, 44.5468869], [40.7301626, 44.548481], [40.7299257, 44.5495865], [40.7310123, 44.5508537], [40.7308477, 44.5521677], [40.7288061, 44.5539746], [40.7272021, 44.5558132], [40.7243936, 44.5575646], [40.7242619, 44.5597701], [40.7238009, 44.5607086], [40.7246241, 44.5611778], [40.7260071, 44.5615532], [40.726995, 44.5622805], [40.725612, 44.5649316], [40.7237021, 44.56648], [40.7254144, 44.5671603], [40.7286345, 44.5677647], [40.7333477, 44.5430146]]], [[[40.775739, 44.4650237], [40.7764295, 44.4664001], [40.7755654, 44.4686977], [40.7767158, 44.4698518], [40.7765197, 44.4718102], [40.7760297, 44.4731042], [40.7756376, 44.4745729], [40.7761767, 44.4759367], [40.7776469, 44.4772655], [40.7752945, 44.4785593], [40.7750985, 44.4800629], [40.7744614, 44.4805174], [40.7757356, 44.4838042], [40.7756376, 44.4847132], [40.7743144, 44.4856572], [40.771619, 44.4871606], [40.7690216, 44.4865313], [40.7670177, 44.4866762], [40.7651346, 44.4886196], [40.7628606, 44.4882315], [40.7620703, 44.4889597], [40.7613788, 44.4904866], [40.7585469, 44.4915436], [40.7574932, 44.4942919], [40.7562359, 44.4989015], [40.7554963, 44.499868], [40.7540968, 44.5005726], [40.7511327, 44.5049458], [40.7488693, 44.5059742], [40.7482107, 44.5074713], [40.7495691, 44.510348], [40.7482931, 44.5122853], [40.7487112, 44.5134078], [40.746538, 44.5168526], [40.7430656, 44.5195054], [40.7424482, 44.5205913], [40.7431479, 44.5215011], [40.744712, 44.5224695], [40.7453295, 44.5239368], [40.7460665, 44.5248232], [40.7453256, 44.5257622], [40.7435968, 44.5255275], [40.7413741, 44.5272295], [40.7368875, 44.528814], [40.7359449, 44.5296056], [40.7364348, 44.5308387], [40.7361732, 44.531805], [40.7341709, 44.5330981], [40.7339239, 44.5346531], [40.7342532, 44.5362375], [40.7324833, 44.5392301], [40.7348707, 44.5413424], [40.7333477, 44.5430146], [40.775739, 44.4650237]]], [[[40.683297, 44.4647724], [40.7048797, 44.4643123], [40.7491605, 44.4644505], [40.775739, 44.4650237], [40.683297, 44.4647724]]], [[[40.6184389, 44.4780649], [40.618016, 44.476347], [40.61952, 44.467215], [40.619524, 44.465084], [40.6289203, 44.4649287], [40.6360899, 44.4644], [40.6409446, 44.464721], [40.6506937, 44.4647304], [40.683297, 44.4647724], [40.6184389, 44.4780649]]], [[[40.6588131, 44.5304396], [40.660889, 44.519172], [40.661762, 44.498621], [40.6612499, 44.4827091], [40.6565506, 44.4825073], [40.619703, 44.4832], [40.6184389, 44.4780649], [40.6588131, 44.5304396]]], [[[40.6683561, 44.5396802], [40.6681, 44.538816], [40.663427, 44.533028], [40.6588131, 44.5304396], [40.6683561, 44.5396802]]], [[[40.6379976, 44.6358156], [40.6437306, 44.6358057], [40.643711, 44.6263624], [40.643364, 44.584312], [40.648267, 44.578532], [40.656795, 44.566666], [40.66681, 44.552516], [40.670221, 44.545973], [40.6683561, 44.5396802], [40.6379976, 44.6358156]]], [[[40.5683614, 44.6581667], [40.5684248, 44.6544394], [40.6187104, 44.6537713], [40.6184588, 44.635833], [40.6379976, 44.6358156], [40.5683614, 44.6581667]]], [[[40.5641394, 44.7441983], [40.5658404, 44.7419958], [40.565746, 44.7418077], [40.5650546, 44.7416301], [40.5651576, 44.7410867], [40.565605, 44.7407837], [40.5673703, 44.7405538], [40.5677173, 44.7400732], [40.5677909, 44.7391641], [40.56859, 44.7388628], [40.5685808, 44.7350036], [40.5685383, 44.7171713], [40.5684767, 44.707288], [40.5682217, 44.6663856], [40.5683614, 44.6581667], [40.5641394, 44.7441983]]], [[[40.4698176, 44.7622848], [40.498094, 44.761694], [40.527497, 44.762615], [40.5245548, 44.7556475], [40.521191, 44.7524945], [40.5198603, 44.7487142], [40.5198344, 44.7480843], [40.5194656, 44.7473938], [40.5197904, 44.7463079], [40.5193306, 44.7439526], [40.5185672, 44.7415219], [40.5187367, 44.7411859], [40.5191748, 44.740967], [40.5217921, 44.7416162], [40.5249183, 44.7427007], [40.5326373, 44.74419], [40.5641394, 44.7441983], [40.4698176, 44.7622848]]], [[[40.4656097, 44.7624124], [40.4661811, 44.762368], [40.4674485, 44.7622978], [40.4698176, 44.7622848], [40.4656097, 44.7624124]]], [[[40.3674781, 44.7109477], [40.3675236, 44.7117066], [40.3684073, 44.7146976], [40.3684626, 44.7153099], [40.3677887, 44.7161341], [40.3677556, 44.7167071], [40.3694192, 44.7172627], [40.3731912, 44.7174922], [40.386578, 44.7174522], [40.4039547, 44.7175062], [40.4037442, 44.7301185], [40.4059536, 44.7349527], [40.4158283, 44.7354898], [40.4298276, 44.7353723], [40.4299303, 44.7536189], [40.4299974, 44.7624618], [40.4656097, 44.7624124], [40.3674781, 44.7109477]]], [[[40.4043613, 44.6700645], [40.4048884, 44.6713214], [40.4042993, 44.6731735], [40.402904, 44.6741657], [40.4018498, 44.6731294], [40.4010864, 44.6737589], [40.3989547, 44.6747235], [40.3984121, 44.6759086], [40.3971718, 44.6760189], [40.3954625, 44.6754446], [40.3933813, 44.6753629], [40.3936836, 44.6745581], [40.3942262, 44.674062], [40.3954277, 44.6746408], [40.3960091, 44.6743652], [40.3963579, 44.6734006], [40.3948851, 44.6719122], [40.3923659, 44.6713058], [40.3917458, 44.672491], [40.390273, 44.6727115], [40.3903297, 44.6738031], [40.3910869, 44.6750818], [40.3885289, 44.6784992], [40.3875212, 44.6781134], [40.3877149, 44.6769559], [40.3855058, 44.6761015], [40.3832191, 44.6762118], [40.3819788, 44.6766803], [40.3834904, 44.6781961], [40.3834128, 44.6788024], [40.3841105, 44.6797669], [40.3844205, 44.6804835], [40.3819788, 44.6808417], [40.3797077, 44.6808031], [40.3762442, 44.6810106], [40.3771138, 44.682675], [40.3767747, 44.6843628], [40.3754603, 44.68517], [40.3751275, 44.6858784], [40.3739648, 44.6863951], [40.373531, 44.6877546], [40.3726567, 44.6878417], [40.3705735, 44.6876006], [40.3697983, 44.6870151], [40.3675697, 44.6885995], [40.3661648, 44.6890472], [40.3667946, 44.6898738], [40.3673275, 44.6910449], [40.3654865, 44.6923881], [40.3660639, 44.6936172], [40.3681027, 44.6928358], [40.3688294, 44.6935246], [40.3685871, 44.6945578], [40.3690716, 44.6951433], [40.3701859, 44.6954876], [40.3702828, 44.6972096], [40.3706703, 44.6980705], [40.3695076, 44.6981738], [40.3665523, 44.6961764], [40.3648082, 44.6965552], [40.3645072, 44.697115], [40.366407, 44.6976228], [40.3670853, 44.6987937], [40.3673956, 44.7004939], [40.3691685, 44.7027194], [40.3718331, 44.7033047], [40.3731919, 44.7039618], [40.3725598, 44.7051642], [40.3711548, 44.7059905], [40.3678604, 44.7063349], [40.366843, 44.7078499], [40.3674781, 44.7109477], [40.4043613, 44.6700645]]], [[[40.3988949, 44.6640447], [40.3993599, 44.6656435], [40.4010653, 44.6665256], [40.4018017, 44.6673525], [40.4007165, 44.6681795], [40.4009196, 44.6686973], [40.4022839, 44.669006], [40.403121, 44.6697117], [40.4043613, 44.6700645], [40.3988949, 44.6640447]]], [[[40.3988949, 44.6640447], [40.3990336, 44.6637917], [40.3991973, 44.6634289], [40.3990021, 44.6628154], [40.3987376, 44.6624436], [40.3986683, 44.6623496], [40.398555, 44.6621033], [40.3987628, 44.6609836], [40.3988635, 44.660894], [40.3987565, 44.6607507], [40.3985613, 44.6605357], [40.3981646, 44.6603118], [40.397686, 44.6599042], [40.397642, 44.6596981], [40.3977616, 44.6595593], [40.3980072, 44.6595145], [40.3982591, 44.6595593], [40.3987565, 44.6597698], [40.3990084, 44.6597116], [40.3991343, 44.6595369], [40.3990713, 44.6593354], [40.3988824, 44.6589188], [40.3990399, 44.6588113], [40.3992791, 44.6588472], [40.3996695, 44.6591562], [40.40023, 44.6594025], [40.4003055, 44.65951], [40.4004629, 44.6595011], [40.4006329, 44.6595638], [40.4008533, 44.6595727], [40.4009478, 44.659613], [40.4011493, 44.6596086], [40.4011493, 44.659528], [40.4012878, 44.6595414], [40.4014075, 44.6594384], [40.4012752, 44.6590174], [40.4014767, 44.6585919], [40.4013886, 44.6584037], [40.4018042, 44.6581216], [40.4016908, 44.658023], [40.4016719, 44.6576289], [40.4017349, 44.6574676], [40.4015019, 44.6573377], [40.4005196, 44.6571227], [40.400167, 44.6569525], [40.3999907, 44.6567689], [40.399934, 44.6566211], [40.4000033, 44.656415], [40.4001355, 44.6563434], [40.4013067, 44.6563344], [40.4014956, 44.6562314], [40.4016593, 44.6560164], [40.4016404, 44.6553938], [40.4017664, 44.6550444], [40.4016719, 44.6548876], [40.4015019, 44.6548339], [40.4012689, 44.6548652], [40.4011934, 44.6546995], [40.4010989, 44.6546816], [40.4007715, 44.6547398], [40.4005448, 44.6546592], [40.4001292, 44.6544979], [40.3996884, 44.6544173], [40.3992225, 44.6544352], [40.3988761, 44.6545158], [40.398618, 44.6546233], [40.3984354, 44.6548294], [40.3982968, 44.6548204], [40.3981016, 44.6547353], [40.3978561, 44.6547891], [40.3976546, 44.654704], [40.3974657, 44.6545203], [40.3970249, 44.6543994], [40.3968612, 44.654256], [40.3967226, 44.6541127], [40.3964582, 44.6539962], [40.39637, 44.6538305], [40.3963259, 44.6534318], [40.3960426, 44.6531004], [40.3959556, 44.6529416], [40.3988949, 44.6640447]]], [[[40.3434934, 44.5829085], [40.3544944, 44.5972829], [40.3482621, 44.6033422], [40.3520352, 44.6090521], [40.3520565, 44.6107974], [40.3511827, 44.6115521], [40.3518958, 44.6129868], [40.3508726, 44.6138035], [40.3505005, 44.6146422], [40.3486091, 44.6146863], [40.3482681, 44.6166065], [40.3490742, 44.6174673], [40.3486091, 44.6184825], [40.3470278, 44.6184163], [40.3470278, 44.6190122], [40.3461907, 44.6196522], [40.3447954, 44.6189239], [40.3432626, 44.6199442], [40.3435727, 44.6221512], [40.3426425, 44.6226753], [40.3422549, 44.623696], [40.3415573, 44.6244959], [40.3410147, 44.6257924], [40.3402896, 44.6270293], [40.3396582, 44.6293231], [40.3398907, 44.6314745], [40.3417123, 44.6319709], [40.3418674, 44.6357219], [40.3409759, 44.6367423], [40.341441, 44.6375697], [40.341131, 44.6384522], [40.3428158, 44.6405365], [40.3421387, 44.6429197], [40.3430301, 44.6435264], [40.3428751, 44.6452636], [40.3470595, 44.6483321], [40.3485724, 44.6481589], [40.3504603, 44.649307], [40.3580335, 44.6444772], [40.3623814, 44.6417335], [40.375341, 44.6363001], [40.3766516, 44.63546], [40.3776697, 44.6353444], [40.3785795, 44.6361151], [40.379836, 44.6369783], [40.3808324, 44.6372327], [40.3816231, 44.6383271], [40.3823705, 44.6387279], [40.3833019, 44.6396219], [40.3841793, 44.6399841], [40.3844501, 44.640169], [40.3856523, 44.6405158], [40.3861181, 44.6415871], [40.3873528, 44.6424348], [40.3877536, 44.6427739], [40.3875694, 44.6430128], [40.3868654, 44.6431207], [40.3868004, 44.6434135], [40.3876344, 44.6434366], [40.3877103, 44.6438373], [40.3876561, 44.6442304], [40.3870062, 44.6447159], [40.3871145, 44.6454402], [40.3869846, 44.6459411], [40.3866705, 44.6462956], [40.3863672, 44.6468427], [40.3864972, 44.6472974], [40.3868113, 44.647544], [40.3877887, 44.6476641], [40.3883555, 44.6479528], [40.3890447, 44.6478602], [40.3893588, 44.6477785], [40.3907833, 44.6476695], [40.391442, 44.6478003], [40.3917177, 44.6479038], [40.391909, 44.6484353], [40.3922921, 44.648525], [40.3927363, 44.6481708], [40.3930044, 44.6482525], [40.393326, 44.6486721], [40.3937779, 44.6488682], [40.3943447, 44.6489227], [40.394383, 44.6490862], [40.3945591, 44.6493477], [40.3950033, 44.649473], [40.395685, 44.649375], [40.3960143, 44.6495384], [40.3964049, 44.6502576], [40.3965887, 44.6504211], [40.3965657, 44.6506772], [40.3964049, 44.6509823], [40.3965504, 44.6511893], [40.3968644, 44.6516034], [40.3968491, 44.6517505], [40.3959556, 44.6529416], [40.3434934, 44.5829085]]], [[[40.387266, 44.5488575], [40.3495819, 44.5479173], [40.3496522, 44.5579079], [40.3422345, 44.5579603], [40.3427651, 44.5630768], [40.3413855, 44.5674871], [40.3366455, 44.5675627], [40.3368931, 44.5734847], [40.3403597, 44.5727035], [40.3415409, 44.5797793], [40.3425588, 44.5810963], [40.3434934, 44.5829085], [40.387266, 44.5488575]]], [[[40.4036049, 44.4438134], [40.4050622, 44.4449202], [40.4080078, 44.4457614], [40.4093426, 44.446875], [40.40869, 44.4481299], [40.4076978, 44.4488603], [40.4078838, 44.4515607], [40.4057444, 44.4532871], [40.4033569, 44.4529772], [40.4027368, 44.4538625], [40.403729, 44.4548806], [40.4044437, 44.4557813], [40.4034189, 44.4562085], [40.4019926, 44.4556995], [40.4009694, 44.4554339], [40.3998842, 44.4565184], [40.4006284, 44.4580012], [40.3999462, 44.458488], [40.3968146, 44.4585323], [40.3970626, 44.4593954], [40.3979928, 44.4598601], [40.3999772, 44.4601257], [40.4003803, 44.4607454], [40.398728, 44.461564], [40.3976243, 44.46181], [40.3966906, 44.4629583], [40.3970014, 44.4640031], [40.3973107, 44.4646622], [40.3959154, 44.4648835], [40.3952643, 44.4655474], [40.3958844, 44.466698], [40.39359, 44.4674946], [40.394024, 44.4685125], [40.3925357, 44.4693754], [40.3929648, 44.4708642], [40.3915125, 44.4716545], [40.388629, 44.4716323], [40.388815, 44.474044], [40.3911405, 44.4760573], [40.3908304, 44.4771857], [40.3897452, 44.4771635], [40.388877, 44.476522], [40.3872337, 44.477783], [40.3857144, 44.4780264], [40.3842281, 44.4768138], [40.3834432, 44.4772787], [40.383468, 44.4793141], [40.3841378, 44.4802521], [40.3857005, 44.4805883], [40.3860725, 44.4812963], [40.3847579, 44.4815086], [40.3837905, 44.4821811], [40.3840137, 44.4825174], [40.3853284, 44.4826944], [40.3862462, 44.4838624], [40.3892321, 44.4838336], [40.3897576, 44.4840642], [40.3898429, 44.4851012], [40.3904243, 44.4855458], [40.3928389, 44.4848067], [40.392866, 44.4876472], [40.3947651, 44.4878961], [40.397827, 44.4876749], [40.3985634, 44.4889467], [40.397672, 44.4908269], [40.3972069, 44.4920434], [40.3993385, 44.4932322], [40.4008888, 44.4942275], [40.4025942, 44.4947528], [40.4024004, 44.4955822], [40.4009276, 44.4962733], [40.4026717, 44.4984573], [40.4028704, 44.4995309], [40.4040816, 44.5000492], [40.4063222, 44.500222], [40.4073517, 44.5025112], [40.4098565, 44.5025043], [40.4099727, 44.5034165], [40.4084224, 44.5044116], [40.4069496, 44.5040522], [40.4068334, 44.5051303], [40.4091201, 44.5062912], [40.4105541, 44.5060977], [40.4120269, 44.5051303], [40.4128796, 44.5061254], [40.4125695, 44.5075627], [40.4122207, 44.5088618], [40.4145247, 44.5100846], [40.4155458, 44.5084784], [40.4169613, 44.5090195], [40.417703, 44.5099304], [40.4171604, 44.5118099], [40.4182068, 44.5118928], [40.4190982, 44.5113124], [40.4200672, 44.5112018], [40.4201447, 44.5125284], [40.4211524, 44.5130259], [40.4230515, 44.5123073], [40.4243456, 44.5139159], [40.4239815, 44.5145853], [40.4228577, 44.5143802], [40.4213849, 44.5136063], [40.4199509, 44.5147947], [40.418013, 44.5145183], [40.4175479, 44.5162042], [40.4170441, 44.5176413], [40.4180905, 44.5186361], [40.4183231, 44.5197415], [40.4169666, 44.5201284], [40.4169666, 44.5208469], [40.419292, 44.5220075], [40.4196408, 44.5231681], [40.4176254, 44.5239418], [40.4159589, 44.523776], [40.4131683, 44.5265392], [40.4104165, 44.5277274], [40.4111142, 44.5290813], [40.4108975, 44.5320376], [40.4130632, 44.5322989], [40.4140709, 44.5339566], [40.4150382, 44.5349946], [40.413257, 44.5355037], [40.4100014, 44.5343434], [40.4075984, 44.5338185], [40.4052342, 44.5345644], [40.4029862, 44.5347578], [40.4005269, 44.5340078], [40.3990281, 44.533038], [40.3968929, 44.5325258], [40.387266, 44.5488575], [40.4036049, 44.4438134]]], [[[40.4549152, 44.3695198], [40.4513707, 44.3790987], [40.45054, 44.3817536], [40.4423263, 44.4018633], [40.4349182, 44.4215166], [40.4146856, 44.4224461], [40.4119725, 44.4229413], [40.4126205, 44.423686], [40.4147717, 44.4230298], [40.4155661, 44.4248209], [40.4146747, 44.4254852], [40.4147631, 44.4263869], [40.4140267, 44.4279409], [40.4121663, 44.4291617], [40.4115353, 44.4297753], [40.4119616, 44.4304395], [40.4130468, 44.4311315], [40.4124655, 44.4319618], [40.411419, 44.4319064], [40.4109927, 44.4329304], [40.4095586, 44.4334839], [40.4100471, 44.4343356], [40.4083728, 44.4355311], [40.4088999, 44.436461], [40.409768, 44.437258], [40.4089929, 44.4377893], [40.4107674, 44.4385004], [40.4101162, 44.4394966], [40.4072017, 44.4396516], [40.4070156, 44.4400722], [40.4083179, 44.4405371], [40.4086279, 44.4412455], [40.4076047, 44.4414448], [40.4059849, 44.4409882], [40.4064265, 44.4423303], [40.4072637, 44.4428173], [40.4057134, 44.4433264], [40.4036049, 44.4438134], [40.4549152, 44.3695198]]], [[[40.4385932, 44.2834042], [40.4406577, 44.2847088], [40.4423407, 44.2854242], [40.4434913, 44.2878085], [40.4469725, 44.2915269], [40.4485177, 44.2920134], [40.4515456, 44.2950476], [40.4537863, 44.3001621], [40.4546342, 44.3053629], [40.4594405, 44.3080693], [40.4601034, 44.3084095], [40.461179, 44.3086068], [40.4666568, 44.3096119], [40.4699286, 44.3096882], [40.4709281, 44.3100719], [40.4721856, 44.3112575], [40.4829016, 44.3153721], [40.4673657, 44.3414639], [40.462765, 44.348229], [40.4564532, 44.3658323], [40.4554539, 44.3680638], [40.4549152, 44.3695198], [40.4385932, 44.2834042]]], [[[40.4185322, 44.2781343], [40.4195669, 44.2788804], [40.4243101, 44.2811601], [40.4293205, 44.2823461], [40.4360507, 44.2826681], [40.4385932, 44.2834042], [40.4185322, 44.2781343]]], [[[40.3598234, 44.2467465], [40.3774367, 44.2568189], [40.3815395, 44.258236], [40.3844079, 44.2598094], [40.3897306, 44.262729], [40.3952864, 44.265869], [40.398791, 44.2682718], [40.4029093, 44.2704037], [40.4156094, 44.2769783], [40.4185322, 44.2781343], [40.3598234, 44.2467465]]], [[[40.4033845, 44.153619], [40.4013013, 44.1555307], [40.4016404, 44.1570253], [40.3995572, 44.1595626], [40.4005262, 44.1613699], [40.4029121, 44.1615022], [40.4056664, 44.1639607], [40.4063239, 44.1662312], [40.4060976, 44.1673127], [40.4035783, 44.1691545], [40.4025703, 44.1713804], [40.4011523, 44.1740376], [40.398506, 44.1770603], [40.3985883, 44.1787796], [40.3968891, 44.1812397], [40.3951009, 44.1844473], [40.3961939, 44.1914038], [40.3877158, 44.203773], [40.3695021, 44.2328842], [40.3631207, 44.2429998], [40.362404, 44.2438155], [40.3621993, 44.2440485], [40.3619171, 44.2443698], [40.3598234, 44.2467465], [40.4033845, 44.153619]]], [[[40.4235844, 44.0870144], [40.4246663, 44.0919858], [40.4261828, 44.0955176], [40.4261049, 44.0965282], [40.4258622, 44.1063299], [40.4265523, 44.1074956], [40.4272424, 44.1086613], [40.4286226, 44.1109926], [40.4326708, 44.1140168], [40.4294591, 44.1141592], [40.4271531, 44.1180495], [40.4238264, 44.1215178], [40.4220712, 44.1236071], [40.420417, 44.12534], [40.4184413, 44.1277368], [40.4161364, 44.1290837], [40.413447, 44.1300025], [40.4055461, 44.1328484], [40.4055737, 44.1406524], [40.4074674, 44.144352], [40.410176, 44.1496364], [40.4091296, 44.1498867], [40.4064616, 44.1498393], [40.4059104, 44.1508096], [40.4029257, 44.1521337], [40.4033845, 44.153619], [40.4235844, 44.0870144]]], [[[40.4213604, 44.0791859], [40.4235844, 44.0870144], [40.4213604, 44.0791859]]], [[[40.4304637, 44.0517959], [40.4288233, 44.053141], [40.426868, 44.0543152], [40.4249584, 44.0554934], [40.4230938, 44.0568399], [40.4213463, 44.058018], [40.4193827, 44.059345], [40.4174641, 44.0606396], [40.4158607, 44.0619924], [40.4143204, 44.063384], [40.4137683, 44.0638171], [40.4145456, 44.0650345], [40.4159826, 44.0663709], [40.4172659, 44.0679859], [40.4172028, 44.0686719], [40.4181486, 44.0698045], [40.4194637, 44.0711959], [40.4192205, 44.0723091], [40.4198781, 44.0727233], [40.4207789, 44.0732669], [40.4212429, 44.0743925], [40.4214274, 44.0761208], [40.4218237, 44.0774797], [40.4213604, 44.0791859], [40.4304637, 44.0517959]]], [[[40.4313274, 44.0416505], [40.4314439, 44.0425256], [40.4312097, 44.0442738], [40.4310475, 44.0461385], [40.4308314, 44.0478477], [40.4307953, 44.04979], [40.4304637, 44.0517959], [40.4313274, 44.0416505]]], [[[40.4715268, 43.9714878], [40.4709053, 43.9745932], [40.4690777, 43.9789988], [40.4692433, 43.982712], [40.4681793, 43.9855049], [40.4645858, 43.9912177], [40.4627183, 43.9940866], [40.4630462, 43.9943786], [40.4603763, 43.9959269], [40.4588504, 43.9973275], [40.457602, 43.9988688], [40.4568273, 43.9998148], [40.4571182, 44.0008294], [40.4570384, 44.0029007], [40.4552067, 44.0039456], [40.4530622, 44.0048816], [40.4514378, 44.005559], [40.4510264, 44.00597], [40.4502474, 44.0070004], [40.4500536, 44.0077193], [40.4494176, 44.0112574], [40.4490628, 44.013213], [40.4476844, 44.0167134], [40.4461443, 44.0183823], [40.4448652, 44.0198203], [40.4433502, 44.0214499], [40.4419468, 44.0228905], [40.4405956, 44.0246587], [40.4396588, 44.0263556], [40.4390103, 44.0300342], [40.4379493, 44.0313245], [40.436308, 44.0326894], [40.4347407, 44.0341206], [40.4330833, 44.0354999], [40.4318373, 44.0364521], [40.43157, 44.0370087], [40.4314846, 44.0387455], [40.4313268, 44.040473], [40.4313274, 44.0416505], [40.4715268, 43.9714878]]], [[[40.4804755, 43.9645059], [40.4799509, 43.9662868], [40.4796673, 43.9672499], [40.4777264, 43.9681062], [40.4725752, 43.9694803], [40.4715268, 43.9714878], [40.4804755, 43.9645059]]], [[[40.3656669, 43.7732688], [40.3676793, 43.7745843], [40.3688347, 43.7757644], [40.3713286, 43.7772619], [40.3727555, 43.7801248], [40.373178, 43.7808957], [40.3730139, 43.7872328], [40.373219, 43.7895129], [40.3736351, 43.791238], [40.376518, 43.7931959], [40.3780817, 43.7976852], [40.3804907, 43.7997002], [40.382041, 43.801973], [40.3822849, 43.8042537], [40.380379, 43.8100729], [40.3802336, 43.8200994], [40.383094, 43.8216671], [40.3850804, 43.8236245], [40.3871636, 43.8241896], [40.3924443, 43.8266653], [40.393716, 43.8277568], [40.3934223, 43.8315156], [40.3937902, 43.8326056], [40.3942595, 43.8339961], [40.3946617, 43.8351878], [40.3961704, 43.8396576], [40.3963195, 43.8421946], [40.4011756, 43.854573], [40.4039292, 43.8568186], [40.4030536, 43.86134], [40.4038288, 43.8630167], [40.4042164, 43.864868], [40.4078255, 43.8687883], [40.4156102, 43.8725567], [40.4174568, 43.8761768], [40.4169724, 43.8783594], [40.4199159, 43.8804416], [40.4204242, 43.8825935], [40.4168295, 43.8851872], [40.4146016, 43.8868759], [40.4126406, 43.887501], [40.4096206, 43.8885112], [40.4091555, 43.889824], [40.4030101, 43.8952599], [40.4032619, 43.8989766], [40.4027986, 43.9014865], [40.402683, 43.9021127], [40.4038845, 43.9062735], [40.4037005, 43.9066659], [40.4029155, 43.9083399], [40.403605, 43.9112207], [40.4048185, 43.9133993], [40.4066401, 43.9166697], [40.4062213, 43.9218832], [40.4078119, 43.9286815], [40.4083177, 43.9348257], [40.4096867, 43.9387685], [40.4129408, 43.9418998], [40.4193291, 43.9427719], [40.423922, 43.9427125], [40.4274182, 43.943086], [40.4401348, 43.9458124], [40.4454574, 43.9464937], [40.4503447, 43.9483497], [40.4531595, 43.9524703], [40.4525059, 43.9563592], [40.4528595, 43.9565509], [40.4543359, 43.9573512], [40.4552604, 43.9578524], [40.4558708, 43.9578559], [40.459488, 43.9578766], [40.46297, 43.9587143], [40.4660768, 43.9579115], [40.4709995, 43.9575867], [40.4766896, 43.9590513], [40.4769214, 43.9614077], [40.4773492, 43.9631493], [40.4804755, 43.9645059], [40.3656669, 43.7732688]]], [[[40.0933469, 43.8452271], [40.095079, 43.8461134], [40.0963414, 43.8473075], [40.0982868, 43.8486806], [40.0990525, 43.8495015], [40.0992955, 43.8507688], [40.0979143, 43.8526505], [40.0981419, 43.8534415], [40.0981833, 43.8542176], [40.0988249, 43.8548891], [40.1016336, 43.8566503], [40.1020741, 43.8575305], [40.1017636, 43.8585005], [40.1020534, 43.8595003], [40.1038125, 43.8610671], [40.1043605, 43.8619736], [40.1042678, 43.862813], [40.1049922, 43.86338], [40.1052405, 43.8652451], [40.1045782, 43.8668715], [40.1053647, 43.866961], [40.1066669, 43.8667415], [40.107053, 43.867057], [40.1075563, 43.8670666], [40.1084437, 43.8678592], [40.1097887, 43.8678339], [40.1104402, 43.8681111], [40.1126714, 43.8681344], [40.1154524, 43.8669221], [40.1195915, 43.8655466], [40.1243774, 43.8645208], [40.1274817, 43.864241], [40.1314579, 43.8633299], [40.1322999, 43.8635649], [40.133367, 43.8634483], [40.1343048, 43.8625857], [40.1363743, 43.8619562], [40.1373768, 43.8620028], [40.138008, 43.8619329], [40.1388397, 43.8607354], [40.1395188, 43.8605451], [40.140657, 43.8605302], [40.1418367, 43.8602019], [40.1428762, 43.8593419], [40.1441339, 43.8591573], [40.1451066, 43.8586201], [40.1471141, 43.8581128], [40.1482523, 43.8582918], [40.1494734, 43.857874], [40.1509014, 43.8576949], [40.1523087, 43.8579337], [40.1542937, 43.8593102], [40.1558269, 43.8596498], [40.1583055, 43.8607085], [40.1594279, 43.8616046], [40.160173, 43.8624999], [40.1604006, 43.8639622], [40.1612285, 43.8648425], [40.1611457, 43.8658422], [40.1614561, 43.8663794], [40.1615182, 43.8669165], [40.1619163, 43.8673373], [40.163774, 43.8677968], [40.164457, 43.8687219], [40.1654504, 43.8691993], [40.1663817, 43.869065], [40.1675613, 43.8698558], [40.1679621, 43.8709442], [40.1684415, 43.8716607], [40.1692999, 43.8716508], [40.1708628, 43.8711543], [40.1720681, 43.8714503], [40.17312, 43.8714822], [40.1733794, 43.871794], [40.1741344, 43.8720137], [40.1754986, 43.871985], [40.1760946, 43.8723288], [40.1768629, 43.8725197], [40.1789399, 43.8721596], [40.1802404, 43.8722906], [40.1823861, 43.8733981], [40.1836709, 43.8737801], [40.1841874, 43.873675], [40.1850749, 43.8738087], [40.1864583, 43.873674], [40.1872338, 43.8732836], [40.1882007, 43.8732263], [40.1890617, 43.8729207], [40.1899353, 43.8724228], [40.1907968, 43.8713644], [40.1912604, 43.870314], [40.1921478, 43.868538], [40.1932869, 43.8681465], [40.194397, 43.8675939], [40.197142, 43.860907], [40.1968925, 43.8592284], [40.1960949, 43.8581574], [40.1949425, 43.8571833], [40.1945849, 43.8567248], [40.1934723, 43.8559321], [40.1929028, 43.8553304], [40.1921213, 43.8547001], [40.1912115, 43.8540828], [40.1909822, 43.852914], [40.1904789, 43.8519015], [40.1903067, 43.8509081], [40.1905981, 43.8501536], [40.1904789, 43.8493799], [40.1900551, 43.8487208], [40.1898564, 43.8474981], [40.1892477, 43.846772], [40.1888233, 43.8462658], [40.1888365, 43.8458073], [40.1892471, 43.84511], [40.1893728, 43.8443134], [40.192161, 43.8424065], [40.1925849, 43.841862], [40.1928233, 43.8411073], [40.1933001, 43.8406105], [40.1940948, 43.8400373], [40.195618, 43.8385183], [40.19632, 43.8384132], [40.1964657, 43.8381266], [40.1965452, 43.8375916], [40.1972859, 43.8366845], [40.1983068, 43.8359292], [40.1996541, 43.835012], [40.1997505, 43.8344674], [40.1995254, 43.8335502], [40.1997505, 43.832633], [40.1998962, 43.8312953], [40.2002936, 43.8305691], [40.2005717, 43.8296232], [40.2014592, 43.8286294], [40.2014724, 43.8278555], [40.200426, 43.826575], [40.1996691, 43.8253135], [40.2004658, 43.8237178], [40.2010618, 43.8231254], [40.2013664, 43.8225424], [40.2024923, 43.8221793], [40.2030618, 43.8217684], [40.2030618, 43.820612], [40.2035916, 43.8204305], [40.2045188, 43.8204687], [40.2047969, 43.8203636], [40.2063201, 43.8195417], [40.2081179, 43.8187816], [40.2077109, 43.815824], [40.2079625, 43.814658], [40.2075122, 43.8132053], [40.2071678, 43.810443], [40.2064039, 43.8095955], [40.2067572, 43.8078336], [40.2069427, 43.8050615], [40.2068633, 43.8048739], [40.2064129, 43.8038093], [40.2057771, 43.8026908], [40.2054823, 43.801507], [40.205936, 43.8000141], [40.2073798, 43.798714], [40.207941, 43.7982998], [40.2091414, 43.7974138], [40.2104526, 43.796974], [40.2104791, 43.7961518], [40.2105652, 43.7960119], [40.2113798, 43.7946891], [40.2137904, 43.7932454], [40.2143962, 43.7922451], [40.2143997, 43.7908838], [40.2138566, 43.7899946], [40.2147573, 43.7890384], [40.2149163, 43.7882831], [40.2148235, 43.7871069], [40.2158037, 43.7862272], [40.2168272, 43.785506], [40.217009, 43.7846877], [40.2166911, 43.7841044], [40.2166249, 43.7833681], [40.2161878, 43.7825553], [40.2158024, 43.7822461], [40.2162805, 43.7817138], [40.2164792, 43.7811496], [40.2170885, 43.7805471], [40.2171812, 43.7799255], [40.2168648, 43.7791163], [40.2193004, 43.7785962], [40.2213667, 43.7787014], [40.2222541, 43.778338], [40.2237773, 43.7773721], [40.2244925, 43.7771426], [40.22538, 43.7771809], [40.2266912, 43.7770661], [40.2289959, 43.7774391], [40.2306118, 43.7763297], [40.2313138, 43.7761384], [40.2319948, 43.7756955], [40.2331019, 43.7753829], [40.2336052, 43.774417], [40.2368105, 43.7718346], [40.2372951, 43.7697768], [40.2404132, 43.7669279], [40.2418172, 43.7661914], [40.2429431, 43.7669662], [40.243804, 43.7669662], [40.2443471, 43.7667749], [40.2470093, 43.7643548], [40.2483523, 43.7628476], [40.2494067, 43.7621165], [40.2512345, 43.7616286], [40.2521882, 43.7615808], [40.2532611, 43.7617817], [40.2541087, 43.7617147], [40.2557247, 43.761686], [40.2583957, 43.7607162], [40.2596452, 43.7607103], [40.2616982, 43.7601459], [40.2636718, 43.7611503], [40.2659299, 43.7617151], [40.2674141, 43.7614769], [40.2692614, 43.76166], [40.2711818, 43.761753], [40.2737646, 43.7607677], [40.2744754, 43.7603383], [40.2753854, 43.760479], [40.2776062, 43.7621139], [40.2805868, 43.762767], [40.2839198, 43.7642075], [40.2875793, 43.7662584], [40.2895367, 43.7685061], [40.2910071, 43.7689378], [40.2916059, 43.7692235], [40.2922781, 43.7697784], [40.2930932, 43.7699378], [40.2944915, 43.7705586], [40.2953145, 43.7712129], [40.2956324, 43.7729058], [40.2961489, 43.7735562], [40.2964271, 43.77435], [40.297937, 43.7759472], [40.2982682, 43.7774773], [40.2985261, 43.779058], [40.2993675, 43.7798012], [40.3024272, 43.7810635], [40.3032881, 43.7813695], [40.3063388, 43.7824822], [40.3071991, 43.7824344], [40.3084915, 43.782423], [40.3097992, 43.7822967], [40.3120316, 43.7823136], [40.3150896, 43.7820963], [40.3167717, 43.7820676], [40.3179903, 43.7821059], [40.3195726, 43.7818777], [40.3204671, 43.7806141], [40.3211029, 43.7792179], [40.3218314, 43.779017], [40.3235494, 43.7778198], [40.3245201, 43.7777451], [40.3277387, 43.7771235], [40.3314871, 43.776521], [40.3336858, 43.7752394], [40.3357683, 43.7743947], [40.3378978, 43.7746847], [40.339911, 43.7738527], [40.3412091, 43.7739005], [40.3419375, 43.7736423], [40.3424011, 43.7738431], [40.3430634, 43.7737762], [40.3434607, 43.7734032], [40.3441892, 43.7731736], [40.3452621, 43.7731545], [40.3468383, 43.7724085], [40.3477257, 43.7721981], [40.3489364, 43.7723195], [40.3513256, 43.7725735], [40.3516894, 43.7728731], [40.3522555, 43.7730015], [40.3566, 43.7741779], [40.3604411, 43.774044], [40.3610106, 43.7738335], [40.3618715, 43.7737475], [40.3636464, 43.7734319], [40.3656669, 43.7732688], [40.0933469, 43.8452271]]], [[[39.8880053, 43.9338289], [39.9126762, 43.9394982], [39.9031283, 43.9537626], [39.9055917, 43.9630231], [39.9089201, 43.9738829], [39.9229854, 43.9725405], [39.9242719, 43.9710458], [39.9254041, 43.970703], [39.9259869, 43.9702073], [39.926265, 43.9696735], [39.9268081, 43.9692445], [39.9272102, 43.9679988], [39.9267948, 43.9676239], [39.9264714, 43.9671605], [39.9263842, 43.9666706], [39.9261855, 43.9661844], [39.9255785, 43.9658277], [39.9255763, 43.965069], [39.9254835, 43.9644779], [39.9259604, 43.9634674], [39.9265692, 43.9630176], [39.9267683, 43.9625331], [39.9281061, 43.9613032], [39.9285564, 43.9610458], [39.9306848, 43.9599258], [39.9311392, 43.9595013], [39.931881, 43.959158], [39.9326889, 43.9590627], [39.9335499, 43.9590627], [39.9356558, 43.9585669], [39.937987, 43.9585001], [39.940146, 43.9580616], [39.941353, 43.9567348], [39.9421327, 43.9563263], [39.94336, 43.9537847], [39.9435632, 43.951654], [39.9436427, 43.949766], [39.9431261, 43.9490317], [39.9426096, 43.9484309], [39.9426361, 43.9480781], [39.9436584, 43.9476991], [39.9438281, 43.9471054], [39.9442785, 43.9464951], [39.9450202, 43.9460469], [39.9457487, 43.9457321], [39.9458414, 43.9452267], [39.9470762, 43.9440799], [39.9487072, 43.9428248], [39.9492698, 43.9415328], [39.9501726, 43.939638], [39.9504507, 43.9382074], [39.9512587, 43.9370628], [39.9524135, 43.9366972], [39.9525699, 43.9361949], [39.9529915, 43.9348403], [39.9530147, 43.9344214], [39.9530508, 43.9337719], [39.9534839, 43.9332953], [39.9547771, 43.9322166], [39.9556163, 43.9313494], [39.9578198, 43.9301832], [39.9581398, 43.9299046], [39.9589144, 43.9284137], [39.9601064, 43.9277341], [39.9614825, 43.9266252], [39.962474, 43.9258262], [39.9659012, 43.923954], [39.9663317, 43.9235127], [39.9671761, 43.9216047], [39.9679542, 43.9207461], [39.9694277, 43.9201021], [39.9712821, 43.9194819], [39.9749957, 43.9158238], [39.9767623, 43.9150811], [39.9771265, 43.9145921], [39.9774907, 43.9133278], [39.9780702, 43.9126241], [39.9786896, 43.9123178], [39.980057, 43.911992], [39.9808527, 43.9115771], [39.9820107, 43.9104533], [39.9830372, 43.9100717], [39.9837822, 43.9095707], [39.9862772, 43.9085204], [39.9869787, 43.9080059], [39.987971, 43.9076503], [39.9901068, 43.9077934], [39.9908849, 43.9077218], [39.991332, 43.9074833], [39.9913651, 43.906863], [39.9912326, 43.9065171], [39.9912161, 43.9059684], [39.9927889, 43.9055031], [39.9930129, 43.905322], [39.9936168, 43.9046323], [39.9946433, 43.9038689], [39.9954863, 43.9035814], [39.9962161, 43.9031054], [39.9971433, 43.9021392], [39.9991963, 43.9012802], [39.9998751, 43.9005048], [40.0006864, 43.8998964], [40.0014149, 43.8995146], [40.0020109, 43.899109], [40.0028056, 43.8987869], [40.0033023, 43.8981188], [40.0033851, 43.8971406], [40.0034182, 43.8959594], [40.0040308, 43.895518], [40.0045937, 43.8945397], [40.0058685, 43.8937403], [40.0056368, 43.893275], [40.0056864, 43.892571], [40.00615, 43.8923205], [40.0068454, 43.8923324], [40.0076401, 43.8927858], [40.0084514, 43.8929409], [40.0088487, 43.8923921], [40.0092461, 43.8904592], [40.009809, 43.8897313], [40.010554, 43.8891467], [40.0114812, 43.8886813], [40.0115309, 43.8873927], [40.0120067, 43.8866862], [40.0136004, 43.8859369], [40.0136335, 43.8855192], [40.0122759, 43.8850897], [40.0124249, 43.8845766], [40.0133355, 43.8843737], [40.0148256, 43.8847556], [40.0156157, 43.8847567], [40.0168289, 43.8841947], [40.018021, 43.8835026], [40.0197925, 43.883073], [40.0217131, 43.882357], [40.0227561, 43.8809489], [40.0233191, 43.8808176], [40.0241138, 43.8807937], [40.0252562, 43.8805073], [40.0261999, 43.8798748], [40.0269076, 43.8796596], [40.0295277, 43.8801851], [40.0313655, 43.8802806], [40.032839, 43.8805789], [40.0337496, 43.8811159], [40.035306, 43.8812472], [40.0363159, 43.8809369], [40.0377563, 43.8808056], [40.0393292, 43.8812472], [40.040306, 43.8812711], [40.0414484, 43.8810443], [40.0424252, 43.8809966], [40.0434752, 43.880652], [40.0441678, 43.8800896], [40.0452854, 43.8785681], [40.0481414, 43.8774045], [40.0491761, 43.8771061], [40.0525081, 43.8755248], [40.053336, 43.8754353], [40.0544742, 43.8749877], [40.0551572, 43.8740478], [40.0556746, 43.8731378], [40.0570819, 43.8724217], [40.0584478, 43.872362], [40.0593791, 43.8708999], [40.0611382, 43.8698108], [40.0630008, 43.8693781], [40.0640563, 43.8684381], [40.0655257, 43.8677966], [40.0680637, 43.8676766], [40.0693543, 43.8666477], [40.0699131, 43.8657823], [40.0690025, 43.8635143], [40.0712997, 43.8624549], [40.0725001, 43.8606195], [40.0733486, 43.859948], [40.0736176, 43.8589183], [40.0743213, 43.858202], [40.0757907, 43.8560382], [40.0779016, 43.8546056], [40.0793089, 43.8543071], [40.0802014, 43.8539579], [40.0806334, 43.8524864], [40.0810754, 43.8520225], [40.0814406, 43.8519043], [40.0831583, 43.8516059], [40.0841724, 43.8510686], [40.0850166, 43.8502707], [40.0862006, 43.8498], [40.086987, 43.8489493], [40.087885, 43.8461417], [40.0895739, 43.8459642], [40.0913538, 43.8453821], [40.0933469, 43.8452271], [39.8880053, 43.9338289]]], [[[39.8014697, 43.9402642], [39.8048149, 43.9388041], [39.8056506, 43.9349787], [39.8077437, 43.9336363], [39.8113689, 43.9326824], [39.8160379, 43.9319908], [39.8203388, 43.9316372], [39.8243989, 43.9309535], [39.8288007, 43.9288926], [39.830442, 43.9288907], [39.8335712, 43.9273644], [39.8357732, 43.9275194], [39.8372964, 43.9265416], [39.8392004, 43.9260766], [39.8442004, 43.9243117], [39.8466011, 43.9240971], [39.8514575, 43.92423], [39.8516648, 43.9243015], [39.8592668, 43.9269232], [39.8640682, 43.9282826], [39.8669763, 43.9303881], [39.8700451, 43.9311085], [39.8716842, 43.9309297], [39.874118, 43.9299758], [39.8766842, 43.9303454], [39.8796519, 43.9312488], [39.8806743, 43.9320266], [39.8813035, 43.9330282], [39.8837704, 43.9350312], [39.8853267, 43.9346616], [39.8860552, 43.9347451], [39.8861214, 43.9343516], [39.886883, 43.9338032], [39.8874625, 43.9339939], [39.8880053, 43.9338289], [39.8014697, 43.9402642]]], [[[39.7683751, 44.1847552], [39.7686556, 44.1778996], [39.769026, 44.1769002], [39.7754288, 44.1720424], [39.7761167, 44.1713592], [39.7763989, 44.1704103], [39.7763276, 44.1697696], [39.7736481, 44.1680003], [39.7725457, 44.1676998], [39.7697456, 44.1672728], [39.7681615, 44.1661304], [39.7661004, 44.1650697], [39.7646012, 44.1634565], [39.7648522, 44.1613358], [39.7644033, 44.1554404], [39.7618047, 44.1488176], [39.7673829, 44.1435966], [39.7682908, 44.141178], [39.7721664, 44.1386651], [39.7739937, 44.1368656], [39.7745088, 44.1328825], [39.7755389, 44.1304619], [39.7761975, 44.1298764], [39.7766726, 44.129454], [39.7784316, 44.1288414], [39.7843849, 44.1284672], [39.7898754, 44.1281324], [39.794054, 44.1272276], [39.7994282, 44.1240228], [39.8011868, 44.1223768], [39.8054298, 44.1171268], [39.8072986, 44.114207], [39.8106175, 44.108926], [39.8128224, 44.1040182], [39.8154681, 44.1000205], [39.8259267, 44.0884423], [39.8291434, 44.084684], [39.8303919, 44.0821143], [39.8309651, 44.0788199], [39.8308007, 44.0759688], [39.8292777, 44.0703696], [39.8284399, 44.0671538], [39.8284936, 44.0653433], [39.8221995, 44.0591953], [39.8190577, 44.0561452], [39.816293, 44.0530213], [39.81428, 44.050867], [39.8086093, 44.0432088], [39.8053335, 44.0375302], [39.8016329, 44.0307255], [39.8010561, 44.0293351], [39.7996579, 44.0260258], [39.7983883, 44.0222329], [39.7967834, 44.0174595], [39.7970389, 44.0150184], [39.7983398, 44.0121325], [39.7989969, 44.0103748], [39.7983844, 44.0079619], [39.7966458, 44.0013433], [39.7966862, 43.9984148], [39.797083, 43.9971935], [39.7976383, 43.9964354], [39.7995342, 43.9950633], [39.8032785, 43.9923082], [39.8103559, 43.9876604], [39.8122962, 43.9870259], [39.8145451, 43.9866452], [39.8161108, 43.986673], [39.8177164, 43.9862521], [39.8191219, 43.9836543], [39.8164486, 43.9815523], [39.8068006, 43.9767467], [39.7974617, 43.9722539], [39.7866802, 43.9670967], [39.7777748, 43.9617671], [39.7815739, 43.9590526], [39.7882986, 43.9564973], [39.7906054, 43.9545446], [39.7927082, 43.9501483], [39.7937224, 43.9484816], [39.7955744, 43.9466243], [39.7975146, 43.9458941], [39.7983051, 43.9427511], [39.8014697, 43.9402642], [39.7683751, 44.1847552]]], [[[39.865187, 44.1835996], [39.854708, 44.1834092], [39.8448208, 44.182594], [39.8334179, 44.1811611], [39.8258044, 44.1808646], [39.8220494, 44.1804199], [39.8170541, 44.1804199], [39.8078398, 44.1808144], [39.7683751, 44.1847552], [39.865187, 44.1835996]]], [[[39.8756356, 44.1629693], [39.8765135, 44.1644518], [39.8770647, 44.1656064], [39.8773734, 44.1671089], [39.8771006, 44.1682881], [39.8761015, 44.1703638], [39.8746202, 44.1721923], [39.872691, 44.1741196], [39.8713277, 44.1756575], [39.8690048, 44.1787893], [39.865187, 44.1835996], [39.8756356, 44.1629693]]], [[[39.8856495, 44.1424298], [39.8832208, 44.1446416], [39.8780371, 44.1481471], [39.8785025, 44.1504003], [39.879017, 44.1519867], [39.879846, 44.152784], [39.8803491, 44.1536376], [39.8805339, 44.1550998], [39.8801106, 44.1570486], [39.8802869, 44.1585925], [39.8797837, 44.1592388], [39.8769247, 44.16083], [39.8763705, 44.1618435], [39.8756356, 44.1629693], [39.8856495, 44.1424298]]], [[[40.0171938, 44.1003977], [40.016841, 44.0996884], [40.0167705, 44.0986241], [40.0163158, 44.0980004], [40.0169317, 44.0958705], [40.0179312, 44.0958637], [40.0187553, 44.0946719], [40.0191843, 44.0944611], [40.0193649, 44.0941368], [40.018744, 44.0933909], [40.0170959, 44.0927991], [40.0173781, 44.0924625], [40.0169365, 44.0914196], [40.0177309, 44.0903722], [40.0178518, 44.0878412], [40.0139607, 44.0852253], [40.0110283, 44.0846551], [40.0101684, 44.0851461], [40.0087132, 44.084085], [40.0067968, 44.0818133], [40.0030689, 44.0805531], [39.998968, 44.0790168], [39.9933016, 44.0764033], [39.9914716, 44.076039], [39.9897992, 44.0759638], [39.9878187, 44.0761516], [39.9858511, 44.0769288], [39.9833174, 44.0783615], [39.9821462, 44.0793042], [39.980203, 44.0791288], [39.9797474, 44.0795475], [39.9813863, 44.0819036], [39.9789198, 44.0844413], [39.977597, 44.0836431], [39.9765916, 44.0856956], [39.9738685, 44.0856236], [39.9727817, 44.0850621], [39.9708943, 44.0858223], [39.9695715, 44.0866711], [39.9686895, 44.0878114], [39.9672901, 44.0881017], [39.9660261, 44.089509], [39.9651971, 44.091156], [39.9670767, 44.094018], [39.9692363, 44.0955138], [39.9706474, 44.0953618], [39.9706827, 44.0979966], [39.9693411, 44.0979443], [39.9691129, 44.0999093], [39.9666611, 44.1033672], [39.9647738, 44.1046591], [39.9636626, 44.1041271], [39.9640506, 44.1033418], [39.9631511, 44.1023032], [39.9567503, 44.1014517], [39.9543019, 44.1007641], [39.9502655, 44.0994603], [39.9462925, 44.1009659], [39.9433463, 44.1021486], [39.9387617, 44.1039302], [39.9353358, 44.1051145], [39.9327407, 44.1088587], [39.9299847, 44.1114075], [39.9255411, 44.1142867], [39.9208789, 44.1171219], [39.9156369, 44.1190679], [39.9123954, 44.1202993], [39.9097723, 44.120861], [39.907239, 44.1209672], [39.9031839, 44.122281], [39.9014628, 44.1228122], [39.8999332, 44.1233422], [39.8966401, 44.1239254], [39.8953693, 44.1249407], [39.8925912, 44.1285174], [39.8904085, 44.1319832], [39.8873438, 44.1399741], [39.8856495, 44.1424298], [40.0171938, 44.1003977]]], [[[40.0935173, 44.2468289], [40.0891305, 44.2444131], [40.0840069, 44.2363824], [40.079547, 44.2341005], [40.0762855, 44.2299922], [40.076712, 44.2299203], [40.0795618, 44.2294398], [40.080352, 44.2214569], [40.0802393, 44.2212879], [40.0758407, 44.2146912], [40.0757531, 44.2127937], [40.0769174, 44.210024], [40.0774814, 44.2037759], [40.075869, 44.198481], [40.0772276, 44.1973826], [40.0778193, 44.1973573], [40.0786803, 44.1974429], [40.0792267, 44.1974331], [40.0796205, 44.1969626], [40.0801783, 44.1953157], [40.079358, 44.1946099], [40.0790793, 44.1934191], [40.0798615, 44.192269], [40.0822897, 44.1900808], [40.0875585, 44.1786975], [40.0866312, 44.1782478], [40.0845803, 44.1767182], [40.0819, 44.1762803], [40.0793439, 44.175472], [40.0778345, 44.1746248], [40.07685, 44.1737775], [40.0751026, 44.1728525], [40.0740936, 44.1721536], [40.0732733, 44.1711415], [40.0724894, 44.1697296], [40.0724113, 44.1680115], [40.0725157, 44.1664707], [40.0730436, 44.1654219], [40.0733061, 44.1643156], [40.0730025, 44.1633285], [40.0704811, 44.161684], [40.0705485, 44.1609462], [40.0713559, 44.1597711], [40.0715994, 44.1594167], [40.0718599, 44.1592054], [40.0731903, 44.1581268], [40.0760461, 44.1561515], [40.0763966, 44.1550153], [40.0764598, 44.1542079], [40.0757344, 44.1529686], [40.0742953, 44.1513379], [40.0741523, 44.1506377], [40.0725874, 44.1498931], [40.0710412, 44.1482706], [40.0708656, 44.1471855], [40.0703831, 44.1462957], [40.0695291, 44.1456787], [40.0687521, 44.1456636], [40.0690461, 44.1452266], [40.0702012, 44.1448348], [40.0708324, 44.1442635], [40.074081, 44.143115], [40.0756101, 44.1423232], [40.077388, 44.1422198], [40.078209, 44.1411929], [40.0788128, 44.141419], [40.0802376, 44.1409672], [40.0805979, 44.1398553], [40.0800728, 44.1390076], [40.0807291, 44.1386685], [40.082698, 44.1388945], [40.083748, 44.1393467], [40.0860319, 44.1394785], [40.0872088, 44.1392428], [40.0879873, 44.1385162], [40.0875807, 44.1373685], [40.0868719, 44.137425], [40.0868982, 44.1371424], [40.0861894, 44.1366526], [40.0861106, 44.1357483], [40.0867144, 44.1354657], [40.0867407, 44.1349758], [40.0874757, 44.1343918], [40.0889458, 44.1351642], [40.0893723, 44.1348435], [40.0893921, 44.1343918], [40.0918072, 44.1328091], [40.0928479, 44.132256], [40.092645, 44.1313968], [40.0929194, 44.1307899], [40.0930244, 44.129584], [40.0927882, 44.1281142], [40.0922106, 44.127662], [40.0919481, 44.1271533], [40.0912393, 44.1265314], [40.0912044, 44.1261414], [40.090478, 44.1256269], [40.0882815, 44.1249774], [40.0874066, 44.1244398], [40.0870654, 44.1238745], [40.086383, 44.1238698], [40.0856746, 44.123737], [40.0861466, 44.1245528], [40.0860678, 44.1254762], [40.0855428, 44.1263807], [40.0850094, 44.126438], [40.0845726, 44.1261485], [40.0839005, 44.1263415], [40.0829093, 44.1256541], [40.0819852, 44.1255335], [40.0806748, 44.1250752], [40.0801875, 44.1255214], [40.0792635, 44.1249908], [40.0788807, 44.1254162], [40.078516, 44.1250358], [40.0788793, 44.1246871], [40.0775848, 44.1220743], [40.0754682, 44.1222136], [40.0752389, 44.122011], [40.0744628, 44.122049], [40.0735732, 44.1230872], [40.0733771, 44.1235212], [40.0716168, 44.1239732], [40.0709812, 44.1241159], [40.0695939, 44.1248029], [40.0677697, 44.1265856], [40.0674089, 44.1273375], [40.0669829, 44.1276472], [40.0661801, 44.1273119], [40.0663856, 44.1268931], [40.0652296, 44.1271006], [40.0648684, 44.1276243], [40.0642385, 44.1281303], [40.0632112, 44.1285111], [40.0624775, 44.1291512], [40.0619808, 44.129921], [40.0615405, 44.1302613], [40.0614163, 44.1305854], [40.0615609, 44.1310682], [40.0619311, 44.1314215], [40.0609919, 44.1321605], [40.0603868, 44.1320179], [40.0590058, 44.1336464], [40.0578433, 44.1356804], [40.0569377, 44.1375559], [40.0564908, 44.137386], [40.0557696, 44.136874], [40.0546729, 44.1365102], [40.0535029, 44.1353042], [40.0528546, 44.1343417], [40.0509815, 44.1331109], [40.0499772, 44.1323953], [40.0493198, 44.13141], [40.0485031, 44.1311469], [40.047398, 44.1307722], [40.0467354, 44.1301448], [40.0456627, 44.1291826], [40.0448856, 44.1280762], [40.0438475, 44.1276333], [40.0422491, 44.1270823], [40.0404168, 44.1259398], [40.0389979, 44.1250792], [40.0386638, 44.1246514], [40.0382013, 44.1234519], [40.0368215, 44.1227779], [40.0359636, 44.1216758], [40.0340761, 44.1204311], [40.0336571, 44.1198954], [40.0324616, 44.1184726], [40.0313045, 44.116943], [40.0310505, 44.1158286], [40.0307192, 44.1153651], [40.0296113, 44.1149776], [40.0286758, 44.1148795], [40.0266801, 44.113595], [40.0250082, 44.1126781], [40.022683, 44.1108384], [40.0211174, 44.109601], [40.0195221, 44.1078654], [40.0192399, 44.1079161], [40.0183368, 44.1073082], [40.0161267, 44.1064376], [40.0161765, 44.1047111], [40.01646, 44.1028803], [40.0170386, 44.1020697], [40.0171938, 44.1003977], [40.0935173, 44.2468289]]], [[[40.0863289, 44.2490703], [40.0901335, 44.2479649], [40.0935173, 44.2468289], [40.0863289, 44.2490703]]], [[[39.989763, 44.2613097], [39.991882, 44.2612965], [39.9939558, 44.2632893], [39.999876, 44.2649772], [40.0013062, 44.2650753], [40.0030913, 44.2647181], [40.0057425, 44.2656246], [40.0070112, 44.2665416], [40.0102118, 44.2670781], [40.0195946, 44.2676655], [40.0264138, 44.267739], [40.032105, 44.2676655], [40.0397959, 44.2685467], [40.0430773, 44.269795], [40.0456592, 44.2698765], [40.0486147, 44.2690974], [40.0496746, 44.2690448], [40.0505117, 44.2694646], [40.0542685, 44.2693832], [40.0609889, 44.2686689], [40.0620914, 44.2684245], [40.0652402, 44.2667895], [40.0681818, 44.2617884], [40.068838, 44.2613184], [40.0702906, 44.2607913], [40.0713582, 44.2599648], [40.0721834, 44.258289], [40.0762147, 44.2550388], [40.077554, 44.2541969], [40.0771821, 44.2520404], [40.0795562, 44.2509292], [40.0825873, 44.2503362], [40.0863289, 44.2490703], [39.989763, 44.2613097]]], [[[39.9746113, 44.3385739], [39.9747344, 44.3376058], [39.9742421, 44.3368137], [39.9744472, 44.3357869], [39.9742861, 44.334561], [39.9772084, 44.3268149], [39.9719041, 44.3225142], [39.9713299, 44.3200008], [39.9663029, 44.3064517], [39.9675973, 44.2983101], [39.9684586, 44.293466], [39.9702634, 44.2929081], [39.9713709, 44.2925558], [39.9720682, 44.2918218], [39.9742966, 44.2913169], [39.9746021, 44.2910771], [39.9744445, 44.2899497], [39.9740508, 44.2895551], [39.9742083, 44.2884652], [39.9739983, 44.287131], [39.973972, 44.2857403], [39.9739195, 44.2827523], [39.9731153, 44.279173], [39.9745299, 44.276598], [39.9740573, 44.2754138], [39.9743724, 44.2748312], [39.9772638, 44.2745431], [39.9779425, 44.2740042], [39.9790188, 44.272444], [39.9806666, 44.2707365], [39.989763, 44.2613097], [39.9746113, 44.3385739]]], [[[39.9598938, 44.3486283], [39.9618624, 44.3479281], [39.9666499, 44.3448498], [39.9698911, 44.3417656], [39.9746113, 44.3385739], [39.9598938, 44.3486283]]], [[[39.9320664, 44.338106], [39.9328963, 44.3397045], [39.9351386, 44.3400001], [39.9355562, 44.3400597], [39.9405666, 44.3407741], [39.9444727, 44.3479752], [39.9463911, 44.3484303], [39.9490163, 44.3484596], [39.9514773, 44.3481956], [39.9525953, 44.348594], [39.9598938, 44.3486283], [39.9320664, 44.338106]]], [[[39.8474629, 44.3574791], [39.8443135, 44.3533926], [39.845903, 44.3531727], [39.8517234, 44.3489109], [39.8563502, 44.3463062], [39.8612067, 44.3430678], [39.8614692, 44.3433494], [39.8624864, 44.342528], [39.8626505, 44.3416362], [39.864685, 44.3405098], [39.8697712, 44.3381863], [39.8702634, 44.3386088], [39.8700993, 44.3397822], [39.870402, 44.3406344], [39.8716744, 44.3412373], [39.8728229, 44.341425], [39.874037, 44.3419648], [39.8749558, 44.342927], [39.8763312, 44.3440463], [39.8774814, 44.3457317], [39.8784658, 44.346915], [39.8830598, 44.3484303], [39.8954986, 44.3516376], [39.9072812, 44.3510232], [39.9222574, 44.3373143], [39.9320664, 44.338106], [39.8474629, 44.3574791]]], [[[39.8818762, 44.4897255], [39.881065, 44.4705839], [39.8807255, 44.4631088], [39.8802946, 44.4536201], [39.8794056, 44.4327656], [39.8765432, 44.4311957], [39.872544, 44.4320378], [39.8717236, 44.432111], [39.8706265, 44.431669], [39.8688011, 44.4276075], [39.8688011, 44.4269118], [39.8660499, 44.4200048], [39.8647506, 44.4197713], [39.8630073, 44.415743], [39.8625972, 44.4143147], [39.8630586, 44.4070261], [39.8691194, 44.4029318], [39.8790917, 44.3965421], [39.8620332, 44.3776064], [39.8588543, 44.3714861], [39.8490101, 44.3572273], [39.8474629, 44.3574791], [39.8818762, 44.4897255]]], [[[39.8799161, 44.5911947], [39.8741643, 44.5913943], [39.8738583, 44.5851982], [39.8736234, 44.5803069], [39.8723947, 44.5555539], [39.8848229, 44.5550654], [39.8846119, 44.5471339], [39.8843258, 44.5462521], [39.8834927, 44.528253], [39.8820256, 44.4942081], [39.8818762, 44.4897255], [39.8799161, 44.5911947]]], [[[39.924037, 44.6107606], [39.9304879, 44.6064275], [39.9328774, 44.6028921], [39.9320914, 44.5999419], [39.9308026, 44.5961692], [39.9300283, 44.5933364], [39.9291282, 44.5902936], [39.8965883, 44.5899503], [39.8941122, 44.5900883], [39.8914208, 44.5897816], [39.8837234, 44.5898199], [39.8830774, 44.5911233], [39.8799161, 44.5911947], [39.924037, 44.6107606]]], [[[39.8962476, 44.6618048], [39.9042312, 44.6574683], [39.9072196, 44.6558324], [39.9092573, 44.6547232], [39.9101008, 44.6542641], [39.9159623, 44.6510738], [39.9044178, 44.6417709], [39.9203841, 44.6261085], [39.9115542, 44.6211311], [39.9111083, 44.6208797], [39.9117198, 44.6202605], [39.9113334, 44.6199616], [39.9114846, 44.6197104], [39.9110814, 44.6191843], [39.9111318, 44.6189212], [39.9117534, 44.6186581], [39.9116694, 44.6184189], [39.9124422, 44.6173187], [39.9124254, 44.6167685], [39.912879, 44.6164098], [39.9124926, 44.6158477], [39.9131983, 44.615453], [39.9135175, 44.614568], [39.9137527, 44.6134558], [39.9141727, 44.6131687], [39.9135511, 44.6122956], [39.9142567, 44.6117694], [39.9144751, 44.6103939], [39.9143407, 44.6101189], [39.9146599, 44.609784], [39.9148784, 44.6084683], [39.9153087, 44.6082665], [39.924037, 44.6107606], [39.8962476, 44.6618048]]], [[[39.9100781, 44.7130039], [39.9105065, 44.7124592], [39.9110972, 44.7118529], [39.9122691, 44.7102462], [39.9123441, 44.7081916], [39.9122176, 44.7070051], [39.9103752, 44.7051598], [39.909005, 44.7037316], [39.9087023, 44.7030415], [39.9082095, 44.7019179], [39.9080782, 44.7005185], [39.9084775, 44.6993595], [39.9088098, 44.6986949], [39.909469, 44.6982518], [39.9104227, 44.6982841], [39.9108931, 44.6986949], [39.9113501, 44.6994306], [39.9119339, 44.7002086], [39.9119917, 44.7004851], [39.9123406, 44.7013515], [39.9130809, 44.7015688], [39.9140033, 44.7014682], [39.9142978, 44.7015201], [39.9146221, 44.7014625], [39.9158643, 44.7009398], [39.9169876, 44.699934], [39.9178562, 44.6989398], [39.9181454, 44.6979701], [39.91809, 44.6971742], [39.9175321, 44.696147], [39.9165302, 44.6936509], [39.9153729, 44.6911776], [39.9154947, 44.6907525], [39.9161601, 44.6896098], [39.9163769, 44.68943], [39.9169437, 44.6889552], [39.9179057, 44.6887594], [39.9185753, 44.6890872], [39.9191182, 44.6896062], [39.9193366, 44.689815], [39.9206491, 44.6907482], [39.9218185, 44.6914014], [39.9224867, 44.6917746], [39.9235948, 44.6920122], [39.9251381, 44.6917746], [39.9265582, 44.6910634], [39.9275007, 44.6896657], [39.9273565, 44.6873103], [39.9260585, 44.6841344], [39.9229521, 44.6825185], [39.9147712, 44.675124], [39.9124892, 44.6764068], [39.8962476, 44.6618048], [39.9100781, 44.7130039]]], [[[39.994173, 44.7851278], [39.9982076, 44.7779292], [40.0033775, 44.7688175], [40.0083475, 44.7598879], [40.0139668, 44.7574331], [40.0191191, 44.7527455], [40.0233556, 44.7502066], [40.0290165, 44.7469979], [40.0128023, 44.7352446], [40.0056282, 44.7305487], [40.0028251, 44.7283549], [39.9997136, 44.7261407], [39.9875098, 44.7174554], [39.9695296, 44.7300591], [39.9608172, 44.7236194], [39.9428183, 44.7363027], [39.9410852, 44.7350763], [39.9328508, 44.729249], [39.9304594, 44.7275566], [39.9247484, 44.7235146], [39.9196102, 44.7198464], [39.9130216, 44.7152141], [39.9100781, 44.7130039], [39.994173, 44.7851278]]], [[[39.9339444, 44.8838526], [39.9576832, 44.8423188], [39.9757228, 44.8473557], [39.98539, 44.8304558], [39.9718583, 44.8267522], [39.9554547, 44.8221452], [39.9507665, 44.8305083], [39.9390725, 44.8270301], [39.948496, 44.8104625], [39.9454682, 44.809625], [39.9489978, 44.8032642], [39.9519228, 44.8042193], [39.9524599, 44.8029369], [39.9576319, 44.7936027], [39.981417, 44.8004363], [39.9907257, 44.7839852], [39.994173, 44.7851278], [39.9339444, 44.8838526]]], [[[39.9418936, 44.9297581], [39.9634786, 44.8924253], [39.956557, 44.8904081], [39.9483206, 44.8879313], [39.939587, 44.885498], [39.9339444, 44.8838526], [39.9418936, 44.9297581]]], [[[39.8851475, 45.0230499], [39.8912365, 45.0004978], [39.9036911, 45.0021091], [39.9107905, 44.9762827], [39.9226767, 44.9331422], [39.9244132, 44.9270935], [39.9347845, 44.9285876], [39.9418936, 44.9297581], [39.8851475, 45.0230499]]], [[[39.811414, 45.0039611], [39.822338, 45.007203], [39.8494118, 45.0148681], [39.8500611, 45.0132715], [39.8517854, 45.0136618], [39.8563637, 45.0149636], [39.8604742, 45.0163129], [39.8612535, 45.0198793], [39.8851475, 45.0230499], [39.811414, 45.0039611]]], [[[39.7929011, 44.9987103], [39.811414, 45.0039611], [39.7929011, 44.9987103]]], [[[39.7067594, 44.9545606], [39.7117861, 44.9558769], [39.7148639, 44.9567261], [39.7276254, 44.9605113], [39.7737527, 44.9737101], [39.7640998, 44.9903734], [39.7929011, 44.9987103], [39.7067594, 44.9545606]]], [[[39.6617964, 44.9911201], [39.6665442, 44.9932914], [39.6670476, 44.9919092], [39.6688152, 44.9911137], [39.6704446, 44.9911062], [39.673337, 44.9923563], [39.6753189, 44.9933791], [39.6775674, 44.9936896], [39.6786934, 44.9925836], [39.6786398, 44.9900077], [39.6774079, 44.9881893], [39.6772472, 44.9848177], [39.6758545, 44.9833401], [39.6725336, 44.9826582], [39.6714087, 44.9815973], [39.6714623, 44.9801197], [39.6732876, 44.9786129], [39.6744548, 44.9783401], [39.675826, 44.9786893], [39.6765939, 44.9793876], [39.6771424, 44.980183], [39.6812287, 44.9815991], [39.6848213, 44.9818901], [39.6875089, 44.9835389], [39.6884413, 44.9835583], [39.689648, 44.982569], [39.6909095, 44.9814439], [39.6912935, 44.9803382], [39.6911015, 44.9789609], [39.6903885, 44.9777775], [39.6893189, 44.9769045], [39.6864119, 44.9767687], [39.6850133, 44.9764389], [39.6839163, 44.9764389], [39.6828742, 44.9759151], [39.6824354, 44.9750421], [39.6802414, 44.9748093], [39.6790724, 44.9743691], [39.6784725, 44.9733991], [39.6786729, 44.9721724], [39.6787013, 44.9720198], [39.6797435, 44.9713602], [39.6815535, 44.971302], [39.6835555, 44.9722721], [39.6871481, 44.9723691], [39.6893421, 44.971884], [39.6926056, 44.9708557], [39.6943059, 44.9698274], [39.6962324, 44.9684177], [39.695799, 44.9674829], [39.6951032, 44.9670241], [39.6940677, 44.9670489], [39.692646, 44.9662666], [39.69147, 44.9659313], [39.6894464, 44.9660716], [39.6894244, 44.964362], [39.6894121, 44.9634035], [39.6885894, 44.9625788], [39.687907, 44.9624416], [39.6868068, 44.9625303], [39.6852984, 44.9634763], [39.6825902, 44.9640099], [39.6817332, 44.9637189], [39.6817118, 44.9630867], [39.6839615, 44.9595998], [39.6854077, 44.9578942], [39.6863268, 44.95797], [39.6880066, 44.9583096], [39.6884865, 44.9594012], [39.6889322, 44.9598621], [39.6900977, 44.9598378], [39.6919288, 44.9589086], [39.6919631, 44.9582537], [39.6909346, 44.9575017], [39.6906604, 44.9565556], [39.691346, 44.9560947], [39.6917231, 44.9555368], [39.6913501, 44.9551603], [39.6898144, 44.9553931], [39.6885419, 44.9550826], [39.6882786, 44.9539803], [39.6890903, 44.9527692], [39.6910649, 44.9521947], [39.6924252, 44.9514029], [39.6943997, 44.9518842], [39.6952993, 44.9524742], [39.695387, 44.9533282], [39.6958368, 44.9537416], [39.6970764, 44.9537474], [39.6981295, 44.9530177], [39.6977346, 44.9525208], [39.6968652, 44.9523345], [39.6961988, 44.9516498], [39.7067594, 44.9545606], [39.6617964, 44.9911201]]], [[[39.6200133, 44.960311], [39.6516493, 44.9756472], [39.64455, 44.9832324], [39.6617964, 44.9911201], [39.6200133, 44.960311]]], [[[39.5408143, 45.055025], [39.5442505, 45.0550851], [39.5441954, 45.0537083], [39.5424987, 45.0523713], [39.5381916, 45.0516337], [39.5368211, 45.052648], [39.5346023, 45.053109], [39.531992, 45.0516337], [39.5310131, 45.0494207], [39.5298384, 45.0464237], [39.5297732, 45.0432422], [39.5314699, 45.041905], [39.5344066, 45.0415361], [39.537278, 45.0430578], [39.5402146, 45.0448561], [39.5409977, 45.0433806], [39.5436734, 45.0425506], [39.5473279, 45.0429656], [39.5494814, 45.0440261], [39.549814, 45.0447624], [39.5504603, 45.0461932], [39.5518923, 45.0473339], [39.5544505, 45.0468175], [39.555077, 45.0451576], [39.5537877, 45.0439804], [39.5504882, 45.0426819], [39.5507806, 45.0409998], [39.5529365, 45.0401777], [39.5526232, 45.0393292], [39.5487599, 45.0365254], [39.546776, 45.0358982], [39.5459329, 45.0351259], [39.5453664, 45.034607], [39.5454186, 45.0335739], [39.5463583, 45.0331681], [39.5493864, 45.0336108], [39.5520489, 45.0328729], [39.5569042, 45.0298843], [39.5588359, 45.0310281], [39.5582616, 45.031803], [39.5587315, 45.0335739], [39.5582094, 45.03564], [39.5572697, 45.0370419], [39.556852, 45.0396612], [39.5584704, 45.0405097], [39.5602977, 45.0393292], [39.5607154, 45.0374108], [39.561133, 45.0347176], [39.5605587, 45.0333894], [39.5619683, 45.0326147], [39.5687031, 45.0332788], [39.5715745, 45.0358613], [39.5718355, 45.0380749], [39.5701127, 45.0414688], [39.5676589, 45.042391], [39.5661971, 45.0434608], [39.5658317, 45.045674], [39.5660927, 45.0470757], [39.5670851, 45.0477963], [39.5679722, 45.0484405], [39.5700083, 45.0487355], [39.5716789, 45.0482929], [39.5732451, 45.0471864], [39.5771607, 45.046338], [39.579249, 45.0462273], [39.5807447, 45.0469499], [39.5807177, 45.0486203], [39.5796886, 45.050808], [39.5794881, 45.053381], [39.5805907, 45.0542307], [39.5830299, 45.0550568], [39.5855358, 45.0548916], [39.5876074, 45.0539239], [39.588142, 45.0518231], [39.5881086, 45.0500054], [39.5869057, 45.0485891], [39.5830486, 45.0480613], [39.5820471, 45.0473073], [39.5821718, 45.0469886], [39.5858896, 45.0464883], [39.5886043, 45.0447767], [39.5932821, 45.0445406], [39.5963545, 45.0435281], [39.5999647, 45.0448652], [39.6029718, 45.0475211], [39.604726, 45.0476096], [39.6055195, 45.0466653], [39.6061042, 45.0448062], [39.6079811, 45.0423972], [39.6114789, 45.0436145], [39.6154939, 45.0453483], [39.6156171, 45.0473265], [39.6162586, 45.0476664], [39.6183168, 45.0472887], [39.6208241, 45.0491106], [39.6221292, 45.0490368], [39.6274901, 45.0458418], [39.6297037, 45.0454582], [39.6315831, 45.0440712], [39.6331285, 45.0422711], [39.6362192, 45.0410316], [39.6409805, 45.0398511], [39.6455087, 45.0362197], [39.6507537, 45.0346272], [39.6524243, 45.0336827], [39.6529255, 45.0318527], [39.6528837, 45.0300227], [39.6534267, 45.0271594], [39.6529673, 45.0252111], [39.650879, 45.0232037], [39.648578, 45.0222594], [39.645917, 45.0222578], [39.642889, 45.0226637], [39.6406963, 45.0225899], [39.6392867, 45.0211877], [39.6385558, 45.0200437], [39.6364675, 45.0189366], [39.6355278, 45.0174973], [39.637094, 45.016058], [39.6400176, 45.0159104], [39.6423147, 45.0154306], [39.6439331, 45.0154675], [39.6464913, 45.0169437], [39.6490494, 45.0180878], [39.6533304, 45.0184568], [39.6550533, 45.0171282], [39.6570372, 45.0159473], [39.6568283, 45.0143603], [39.655732, 45.0133269], [39.6489972, 45.0134007], [39.6465435, 45.0147294], [39.6446118, 45.0143234], [39.6438287, 45.0129209], [39.6449773, 45.0114446], [39.6451339, 45.0098944], [39.6440375, 45.008418], [39.6412706, 45.0081227], [39.639987, 45.0072083], [39.6414794, 45.0053543], [39.6442047, 45.0048641], [39.6411709, 45.0028514], [39.6330025, 44.9985432], [39.6301235, 44.996744], [39.6273325, 44.9955045], [39.6260253, 44.994924], [39.5988566, 44.9828573], [39.5986161, 44.9827505], [39.5988118, 44.9825453], [39.6072914, 44.9736537], [39.611249, 44.9695033], [39.6200133, 44.960311], [39.5408143, 45.055025]]], [[[39.4768632, 44.9918444], [39.4765452, 44.9926458], [39.4734266, 44.993036], [39.4712861, 44.9937744], [39.4705001, 44.9947778], [39.4713354, 44.9956521], [39.4731397, 44.9952267], [39.4747769, 44.9951795], [39.4757125, 44.9958883], [39.4761469, 44.9972587], [39.4764476, 44.9992434], [39.4755788, 45.0001885], [39.4739082, 44.9998528], [39.4738788, 45.0010257], [39.4738522, 45.0019879], [39.473716, 45.0038266], [39.4732747, 45.009783], [39.4729051, 45.0154065], [39.4720114, 45.0293344], [39.4712487, 45.0356908], [39.4799817, 45.036171], [39.4814576, 45.0339643], [39.4846764, 45.0325465], [39.487434, 45.0322588], [39.4884497, 45.0328854], [39.4886452, 45.0342364], [39.4871834, 45.0361548], [39.486961, 45.037741], [39.4885617, 45.0406998], [39.4907753, 45.0446248], [39.4939826, 45.0451647], [39.4956619, 45.0447133], [39.495963, 45.043821], [39.4945342, 45.0417328], [39.4943672, 45.0409064], [39.495113, 45.040024], [39.4994569, 45.039961], [39.5015025, 45.0393124], [39.5033819, 45.0372465], [39.5059296, 45.0364201], [39.5090621, 45.0365972], [39.5109833, 45.037335], [39.5124033, 45.0380729], [39.5131134, 45.0393419], [39.5119021, 45.04067], [39.5086444, 45.0412602], [39.5065561, 45.042116], [39.5055955, 45.0436211], [39.5061802, 45.0451556], [39.5079287, 45.0457483], [39.5107348, 45.0454717], [39.5137367, 45.0441345], [39.5162819, 45.0428895], [39.5183701, 45.0428895], [39.5200016, 45.043904], [39.5194796, 45.0453795], [39.517587, 45.0459328], [39.5147156, 45.0472699], [39.5137367, 45.0487453], [39.5147005, 45.049936], [39.5158069, 45.0504337], [39.5178952, 45.0500188], [39.5211582, 45.0482207], [39.5239643, 45.0478979], [39.5260526, 45.0493733], [39.5257916, 45.0510792], [39.5232465, 45.0524162], [39.5231798, 45.0546178], [39.5408143, 45.055025], [39.4768632, 44.9918444]]], [[[39.5035035, 44.9801962], [39.5030185, 44.9803461], [39.5019637, 44.980043], [39.5016372, 44.9799331], [39.5009887, 44.9787714], [39.4997093, 44.9779973], [39.4985048, 44.9773111], [39.4971698, 44.977106], [39.4945097, 44.9752108], [39.492951, 44.976213], [39.4910715, 44.9778379], [39.4894844, 44.9784288], [39.4869716, 44.9802809], [39.4875025, 44.981202], [39.4887972, 44.9820587], [39.4905096, 44.9819701], [39.491512, 44.9819405], [39.4911965, 44.9841519], [39.4910526, 44.9851605], [39.4907084, 44.9854275], [39.4899268, 44.9860338], [39.4897578, 44.9861649], [39.486333, 44.9890007], [39.4858736, 44.9904185], [39.4848672, 44.9905521], [39.4840079, 44.9899118], [39.4840047, 44.989366], [39.4839987, 44.9883244], [39.4830966, 44.9871901], [39.4803568, 44.9864575], [39.4779845, 44.9865757], [39.4769032, 44.987199], [39.4759889, 44.987726], [39.4750283, 44.9876669], [39.4739006, 44.9894983], [39.4736082, 44.9910638], [39.4744101, 44.9914714], [39.476308, 44.9912446], [39.4768632, 44.9918444], [39.5035035, 44.9801962]]], [[[39.5171924, 44.9877084], [39.513079, 44.9882415], [39.5108774, 44.9878603], [39.5096625, 44.9870845], [39.5093427, 44.9867151], [39.5084253, 44.9849548], [39.5077854, 44.9841368], [39.5073295, 44.9839547], [39.5066822, 44.9838734], [39.5057362, 44.9840609], [39.5048545, 44.9836837], [39.5041616, 44.9826295], [39.5042342, 44.9821106], [39.5042932, 44.9818716], [39.5049758, 44.9810523], [39.5061064, 44.9802779], [39.506525, 44.9797726], [39.5065453, 44.979513], [39.5061225, 44.979242], [39.5056879, 44.9791699], [39.504759, 44.9793598], [39.5035035, 44.9801962], [39.5171924, 44.9877084]]], [[[39.5193352, 44.9822796], [39.5179295, 44.9826798], [39.5155263, 44.982786], [39.5129232, 44.9825197], [39.5117359, 44.9829186], [39.5114415, 44.9832627], [39.511529, 44.9836777], [39.5121491, 44.9840934], [39.5129534, 44.9841091], [39.5151607, 44.9834033], [39.5162687, 44.9833443], [39.517544, 44.9834923], [39.5189853, 44.984282], [39.5199777, 44.9854905], [39.5200314, 44.9860586], [39.5195625, 44.9870216], [39.5188303, 44.9874266], [39.5171924, 44.9877084], [39.5193352, 44.9822796]]], [[[39.5108499, 44.9665928], [39.5095468, 44.9666874], [39.5082292, 44.9679622], [39.5058714, 44.9677512], [39.5044561, 44.9680277], [39.5045129, 44.9681726], [39.5046111, 44.9684297], [39.5047113, 44.9686897], [39.5050307, 44.9695181], [39.5053284, 44.96955], [39.5067535, 44.9697028], [39.5102288, 44.9709631], [39.5119395, 44.9713262], [39.5118968, 44.9722339], [39.5106137, 44.9725818], [39.5094376, 44.9731416], [39.5091168, 44.9738526], [39.5096514, 44.97473], [39.5119007, 44.9764849], [39.5125597, 44.976394], [39.5132867, 44.9760309], [39.5149333, 44.9768478], [39.5157459, 44.9771201], [39.5162805, 44.9769234], [39.517478, 44.9766814], [39.5180981, 44.9770898], [39.5180554, 44.978542], [39.5183411, 44.9789045], [39.5198172, 44.9784701], [39.5216319, 44.9789248], [39.521822, 44.9789724], [39.5227826, 44.980095], [39.5224967, 44.9810127], [39.5219177, 44.9816833], [39.5207704, 44.9821621], [39.5193352, 44.9822796], [39.5108499, 44.9665928]]], [[[39.6409238, 44.8955618], [39.6401602, 44.8957979], [39.6381485, 44.8960531], [39.6364025, 44.8947781], [39.635843, 44.8944199], [39.6346735, 44.8946092], [39.6347738, 44.8961004], [39.6341724, 44.8965264], [39.6327571, 44.8958205], [39.6302552, 44.8954569], [39.6282023, 44.8955478], [39.6265985, 44.8960932], [39.6267695, 44.8967142], [39.6283306, 44.8973656], [39.6304048, 44.8974262], [39.6306614, 44.8980321], [39.6287058, 44.8998701], [39.6280837, 44.8996443], [39.6282174, 44.8986786], [39.6278699, 44.8980159], [39.6265601, 44.8980727], [39.6239138, 44.8990573], [39.6238604, 44.8998715], [39.6251534, 44.9006845], [39.6260255, 44.9011211], [39.6262811, 44.9017791], [39.6260673, 44.9023542], [39.6247308, 44.903263], [39.621616, 44.903526], [39.618075, 44.9051562], [39.6161771, 44.9056295], [39.6162038, 44.9061407], [39.6179413, 44.9073902], [39.6179948, 44.9082421], [39.617674, 44.9090751], [39.6162038, 44.9095673], [39.6150812, 44.9091508], [39.6141189, 44.9075038], [39.6136292, 44.9071268], [39.6091029, 44.909067], [39.6059621, 44.9090197], [39.6054609, 44.9091342], [39.6049263, 44.9101082], [39.6038999, 44.910997], [39.6020395, 44.9108153], [39.6007176, 44.9104201], [39.59901, 44.9103429], [39.5975398, 44.9111238], [39.5974062, 44.9124016], [39.5984086, 44.9131824], [39.6004802, 44.9135137], [39.6007475, 44.9141289], [39.5986091, 44.9155486], [39.5975941, 44.9153192], [39.5970387, 44.9151937], [39.596033, 44.915257], [39.5956451, 44.9157487], [39.595092, 44.9164498], [39.5943656, 44.9173705], [39.5928955, 44.9181276], [39.5927058, 44.9182166], [39.5916926, 44.9186481], [39.5916592, 44.9195709], [39.5931628, 44.9208485], [39.5940983, 44.9227648], [39.593851, 44.9233207], [39.5920936, 44.9229541], [39.5898215, 44.9239477], [39.5877833, 44.9239004], [39.585411, 44.923096], [39.5846426, 44.9234272], [39.5851016, 44.9256605], [39.5843753, 44.926408], [39.5825834, 44.9274458], [39.582335, 44.9275495], [39.5820817, 44.9276237], [39.5807729, 44.9277988], [39.5797734, 44.9275573], [39.5793142, 44.9264953], [39.578771, 44.9252389], [39.580308, 44.9233937], [39.5803708, 44.9227861], [39.5795395, 44.9224237], [39.5758975, 44.9237012], [39.5729906, 44.9259013], [39.5731577, 44.9268003], [39.5751624, 44.9287637], [39.5751878, 44.9301927], [39.5736254, 44.9312239], [39.5736923, 44.9318626], [39.5772674, 44.9341097], [39.576666, 44.9357417], [39.5775013, 44.9372082], [39.5775007, 44.9382924], [39.5760312, 44.9392896], [39.5748696, 44.9416169], [39.5735252, 44.942104], [39.572357, 44.9408972], [39.5722889, 44.9408269], [39.5719938, 44.939364], [39.5724894, 44.9382489], [39.5726899, 44.9368534], [39.5716976, 44.9357734], [39.5700169, 44.9339441], [39.5690795, 44.933748], [39.5685467, 44.9336366], [39.5663641, 44.9343139], [39.5654728, 44.9361438], [39.5643033, 44.9365223], [39.5631339, 44.9377759], [39.5615969, 44.9379178], [39.5613104, 44.9380826], [39.559504, 44.9391216], [39.5601936, 44.940212], [39.5626327, 44.9420094], [39.5650273, 44.9420624], [39.5654854, 44.9420725], [39.5653126, 44.9432316], [39.5644815, 44.9434529], [39.5632209, 44.9437886], [39.5621129, 44.9440837], [39.5619379, 44.9441303], [39.5597661, 44.9442249], [39.5582837, 44.9446073], [39.5572276, 44.9448798], [39.5558234, 44.9443668], [39.5530501, 44.9442013], [39.5527612, 44.9443199], [39.5513795, 44.9448871], [39.5513519, 44.9455656], [39.5512793, 44.9473465], [39.5483693, 44.9497421], [39.5482721, 44.95087], [39.5478378, 44.952005], [39.5461671, 44.9526435], [39.543467, 44.9531377], [39.5414559, 44.9548898], [39.5400526, 44.9554809], [39.5394248, 44.9555403], [39.538727, 44.9556063], [39.5369882, 44.9557707], [39.536527, 44.9577236], [39.535413, 44.962441], [39.5300288, 44.9619592], [39.5283932, 44.9615545], [39.5246828, 44.9614627], [39.5234799, 44.9618882], [39.5223439, 44.9635904], [39.5215086, 44.9645834], [39.5200309, 44.9654338], [39.5184229, 44.9655644], [39.5175659, 44.9672311], [39.5164299, 44.9675621], [39.5132556, 44.9675621], [39.5127745, 44.9673683], [39.5108499, 44.9665928], [39.6409238, 44.8955618]]], [[[39.5288615, 44.8118194], [39.5562681, 44.8068616], [39.5595782, 44.8069588], [39.561424, 44.8084866], [39.5628083, 44.8090322], [39.5639876, 44.8105236], [39.5651668, 44.8113966], [39.5657571, 44.812483], [39.5648744, 44.8139535], [39.5644282, 44.815108], [39.5649038, 44.81627], [39.5669401, 44.8181496], [39.5665135, 44.8195462], [39.5664012, 44.8210431], [39.5663494, 44.8217341], [39.5671827, 44.8233001], [39.5670714, 44.8240383], [39.5677933, 44.8248995], [39.5689003, 44.8277084], [39.5684824, 44.8293912], [39.567662, 44.8301126], [39.5663494, 44.8303919], [39.5644134, 44.8302755], [39.5614364, 44.8322954], [39.5612422, 44.8330798], [39.5600491, 44.8327888], [39.5596798, 44.8334849], [39.5590581, 44.8335563], [39.5589573, 44.8340687], [39.558504, 44.8345], [39.5589741, 44.8349265], [39.5589962, 44.8351749], [39.5579462, 44.8354541], [39.5574868, 44.8359195], [39.5577871, 44.8366375], [39.5692661, 44.8390147], [39.5742596, 44.8402289], [39.5757469, 44.8407016], [39.5941638, 44.8446569], [39.5943576, 44.8451298], [39.5948617, 44.8453323], [39.5959873, 44.8452251], [39.5969114, 44.8456539], [39.5976338, 44.8463448], [39.5984907, 44.846726], [39.5995323, 44.8472739], [39.600742, 44.8479886], [39.6016156, 44.8479172], [39.6021162, 44.8484671], [39.6029646, 44.8484277], [39.6035131, 44.8471989], [39.6075938, 44.8461567], [39.608274, 44.8467167], [39.6080546, 44.8480077], [39.6076596, 44.8484744], [39.6074622, 44.8492521], [39.6067601, 44.8493299], [39.6067382, 44.8505742], [39.6074999, 44.8508797], [39.6070714, 44.8517911], [39.6088224, 44.8529073], [39.6111919, 44.8532184], [39.6119159, 44.8536539], [39.6134298, 44.8539027], [39.6146145, 44.8546026], [39.6145487, 44.8551625], [39.6155579, 44.8563289], [39.6168962, 44.8567644], [39.6171275, 44.8571581], [39.6167133, 44.8577518], [39.6169579, 44.8584013], [39.6171484, 44.8591865], [39.6185494, 44.8602135], [39.6201949, 44.8603379], [39.6218352, 44.8612754], [39.6232019, 44.8616137], [39.6262152, 44.8623595], [39.6315265, 44.863674], [39.6317098, 44.8637194], [39.6363577, 44.8645759], [39.6419495, 44.8656063], [39.6418623, 44.8659478], [39.6411816, 44.8665393], [39.6414833, 44.8671224], [39.6432385, 44.8671807], [39.6448291, 44.8674528], [39.6452294, 44.8681818], [39.6435631, 44.8683844], [39.6418518, 44.8692707], [39.6415227, 44.8702192], [39.6436948, 44.8712143], [39.6446382, 44.8706234], [39.6460204, 44.8704835], [39.6469857, 44.8708567], [39.6477316, 44.8716341], [39.6489603, 44.8717274], [39.6489603, 44.8704057], [39.6494868, 44.8693795], [39.6509568, 44.8686643], [39.6520099, 44.8691152], [39.6526681, 44.8707167], [39.6519879, 44.8719606], [39.6520318, 44.8730956], [39.6529099, 44.8741744], [39.6519774, 44.8747267], [39.65031, 44.8747578], [39.6469752, 44.873825], [39.6460757, 44.8737006], [39.6443424, 44.8746179], [39.6422699, 44.8747501], [39.6420912, 44.8760728], [39.6409509, 44.8772478], [39.6386016, 44.8777657], [39.6371104, 44.8785319], [39.6372797, 44.8790324], [39.6385828, 44.879577], [39.6386162, 44.8803109], [39.6376608, 44.8807962], [39.6379146, 44.8815657], [39.6387499, 44.8822996], [39.6394516, 44.8835781], [39.6409837, 44.8841625], [39.6433274, 44.8851642], [39.6450983, 44.8852589], [39.6455661, 44.8862769], [39.6457331, 44.8880523], [39.6441293, 44.8895437], [39.6430094, 44.8932958], [39.6419575, 44.8947276], [39.6409238, 44.8955618], [39.5288615, 44.8118194]]], [[[39.4443239, 44.817077], [39.456121, 44.817524], [39.459597, 44.8064349], [39.4697971, 44.8117621], [39.4735687, 44.8094929], [39.4818098, 44.8045343], [39.482861, 44.8052269], [39.4843287, 44.8044419], [39.4848707, 44.8051148], [39.4836965, 44.8068289], [39.4852545, 44.8071173], [39.4855255, 44.807694], [39.4866545, 44.8086232], [39.4868351, 44.8095203], [39.484897, 44.8106977], [39.4821836, 44.8105776], [39.4809191, 44.8107698], [39.4810772, 44.8114105], [39.4829062, 44.8125479], [39.4830868, 44.8138934], [39.4826578, 44.8144381], [39.4815514, 44.8141337], [39.4808514, 44.8139735], [39.4802192, 44.8149827], [39.4787093, 44.8149605], [39.4779753, 44.8153496], [39.4796511, 44.8165697], [39.4806933, 44.8169528], [39.4805773, 44.8180713], [39.4823191, 44.8180901], [39.482861, 44.8174654], [39.4835158, 44.8177537], [39.4830417, 44.8186987], [39.4837191, 44.8193394], [39.4826126, 44.8198359], [39.4829903, 44.8201531], [39.4896379, 44.81896], [39.4979533, 44.8174675], [39.5030629, 44.8165338], [39.5288615, 44.8118194], [39.4443239, 44.817077]]], [[[39.3071045, 44.8251648], [39.3230941, 44.822957], [39.3354231, 44.8212545], [39.3536766, 44.8159999], [39.3533083, 44.8093819], [39.3571894, 44.8087113], [39.3615723, 44.8089109], [39.3602897, 44.8112678], [39.3617098, 44.8115272], [39.3683802, 44.8094153], [39.3697761, 44.814924], [39.3779471, 44.81462], [39.3784147, 44.8146026], [39.3868185, 44.8131441], [39.3901063, 44.8132053], [39.3926586, 44.8132528], [39.4053671, 44.8151795], [39.4136055, 44.8163139], [39.4443239, 44.817077], [39.3071045, 44.8251648]]], [[[39.2481308, 44.8202783], [39.2532473, 44.8218924], [39.2541468, 44.8222959], [39.2548148, 44.8227791], [39.2555754, 44.8236047], [39.256344, 44.8248743], [39.2674303, 44.8252483], [39.2688041, 44.8252946], [39.2871202, 44.8254365], [39.291967, 44.825474], [39.2957989, 44.8255512], [39.3007152, 44.8256503], [39.3049311, 44.8254649], [39.3071045, 44.8251648], [39.2481308, 44.8202783]]], [[[39.2253671, 44.825043], [39.230792, 44.8241243], [39.2380697, 44.8228918], [39.238946, 44.8231247], [39.2393551, 44.8232334], [39.2409967, 44.8233792], [39.2481308, 44.8202783], [39.2253671, 44.825043]]], [[[39.1861195, 44.8307469], [39.205871, 44.8276832], [39.2113229, 44.8264784], [39.2161068, 44.8252938], [39.2244938, 44.825172], [39.224733, 44.8251396], [39.2248843, 44.8251131], [39.2253671, 44.825043], [39.1861195, 44.8307469]]], [[[39.1458094, 44.8359329], [39.1527718, 44.8359185], [39.1567628, 44.8354729], [39.1648278, 44.8338163], [39.1684859, 44.833219], [39.1782603, 44.8318531], [39.1861195, 44.8307469], [39.1458094, 44.8359329]]], [[[39.0371486, 44.8366963], [39.0419289, 44.8355264], [39.0476453, 44.8334618], [39.067075, 44.825873], [39.0753913, 44.8231407], [39.0819123, 44.8244339], [39.0849158, 44.8243944], [39.0861395, 44.8241774], [39.0871685, 44.8245719], [39.0894223, 44.8233274], [39.0900608, 44.8213566], [39.0908395, 44.8191473], [39.0907591, 44.8171631], [39.1113915, 44.824779], [39.1458094, 44.8359329], [39.0371486, 44.8366963]]], [[[38.9880453, 44.8442168], [39.0053631, 44.8431065], [39.0225881, 44.8411854], [39.0265902, 44.8401463], [39.0371486, 44.8366963], [38.9880453, 44.8442168]]], [[[38.9218395, 44.8774], [38.9296463, 44.8750856], [38.942618, 44.8708301], [38.9476708, 44.8687748], [38.9524228, 44.8666152], [38.9565607, 44.8647598], [38.9604803, 44.8629987], [38.9674562, 44.8600365], [38.9737935, 44.8596849], [38.9790259, 44.8585695], [38.9862986, 44.8552628], [38.9865681, 44.8460295], [38.9880453, 44.8442168], [38.9218395, 44.8774]]], [[[38.9003573, 44.884066], [38.9066361, 44.8823927], [38.9189362, 44.879079], [38.9218395, 44.8774], [38.9003573, 44.884066]]], [[[38.8289584, 44.9363744], [38.8290734, 44.9351759], [38.8292846, 44.9341431], [38.829803, 44.933514], [38.8309632, 44.9329898], [38.8318025, 44.9327102], [38.8334564, 44.9326752], [38.8343499, 44.9323287], [38.8347249, 44.931888], [38.8346731, 44.9306176], [38.83454, 44.9293279], [38.8352117, 44.9275262], [38.8360398, 44.9265144], [38.8372878, 44.925841], [38.8390046, 44.9256145], [38.8431135, 44.9256313], [38.8444959, 44.9252643], [38.8454272, 44.9244317], [38.8459071, 44.9233247], [38.8462548, 44.9221512], [38.8462892, 44.9216149], [38.8460342, 44.9209978], [38.8445452, 44.9194438], [38.8437553, 44.9187096], [38.8435085, 44.9180279], [38.84378, 44.9172937], [38.8445236, 44.9168376], [38.8451684, 44.916557], [38.846372, 44.9164896], [38.8475815, 44.9165945], [38.8497291, 44.9169092], [38.8506504, 44.9168418], [38.8517266, 44.9164518], [38.8521027, 44.9163155], [38.8524334, 44.9161065], [38.853142, 44.9155722], [38.8532786, 44.9149082], [38.8526931, 44.9141544], [38.8510161, 44.9131664], [38.8502191, 44.9123889], [38.8499323, 44.9115019], [38.850114, 44.910476], [38.8508216, 44.9094445], [38.8522418, 44.9083547], [38.8535616, 44.9077346], [38.8550757, 44.9075867], [38.8562689, 44.9077638], [38.8578875, 44.9079212], [38.8593694, 44.9078641], [38.8602344, 44.9076382], [38.8610904, 44.9069032], [38.8614284, 44.9059163], [38.8616851, 44.904715], [38.8619739, 44.9037679], [38.8622965, 44.9030697], [38.8621896, 44.9019687], [38.8617699, 44.9007622], [38.8618464, 44.8998899], [38.861918, 44.8988213], [38.8617321, 44.8983786], [38.8611708, 44.8977614], [38.8604517, 44.8975229], [38.8597457, 44.8975273], [38.858398, 44.897875], [38.8573513, 44.8980169], [38.8568086, 44.8979607], [38.8563392, 44.897912], [38.8552283, 44.8974224], [38.8549338, 44.8970335], [38.8547207, 44.8967523], [38.854618, 44.8964155], [38.8545493, 44.8952319], [38.8540687, 44.8944956], [38.8545779, 44.8942846], [38.8547547, 44.8938467], [38.8556618, 44.8940892], [38.857723, 44.8936244], [38.8597841, 44.8932329], [38.8605387, 44.8930701], [38.8608169, 44.8934105], [38.8609716, 44.8934835], [38.8628216, 44.8929995], [38.867197, 44.8920557], [38.8758535, 44.8902131], [38.87586, 44.8903227], [38.8789283, 44.8895053], [38.8820869, 44.8888842], [38.8827417, 44.8887335], [38.8905159, 44.8868361], [38.8909967, 44.886609], [38.8957466, 44.8857525], [38.9003573, 44.884066], [38.8289584, 44.9363744]]], [[[38.6840182, 44.9514152], [38.7212251, 44.9506522], [38.7227856, 44.9505406], [38.725423, 44.950352], [38.7374009, 44.9499239], [38.7470977, 44.9496278], [38.7541974, 44.9494417], [38.7550007, 44.9489722], [38.7550429, 44.9488699], [38.7551526, 44.9486038], [38.7553756, 44.9480624], [38.7563121, 44.9478985], [38.75714, 44.9480157], [38.7574436, 44.9483087], [38.7568877, 44.9487778], [38.7565609, 44.9492024], [38.7563475, 44.9500372], [38.7563397, 44.950262], [38.7549873, 44.9504963], [38.7541181, 44.950515], [38.7538006, 44.9511018], [38.754601, 44.9514143], [38.7557325, 44.9514143], [38.7563397, 44.9511604], [38.7575264, 44.9519026], [38.7577748, 44.95243], [38.7576644, 44.9529769], [38.7569193, 44.9533675], [38.7571952, 44.9537191], [38.7582716, 44.9538362], [38.7586028, 44.9543831], [38.7584648, 44.9550276], [38.7596239, 44.955262], [38.7603139, 44.9548128], [38.7608659, 44.9542855], [38.7616939, 44.9542464], [38.762025, 44.95493], [38.7622578, 44.9550549], [38.7628254, 44.9551839], [38.7640674, 44.9550472], [38.7658998, 44.9564366], [38.766869, 44.9568196], [38.7694713, 44.9581824], [38.7711096, 44.9588784], [38.7723581, 44.9593429], [38.7727669, 44.9595261], [38.773742, 44.9598929], [38.7743036, 44.9601061], [38.7748032, 44.9602843], [38.7755188, 44.9606084], [38.7761134, 44.9619183], [38.7760106, 44.96284], [38.7751878, 44.9635434], [38.7751878, 44.964077], [38.7760106, 44.9643438], [38.7774846, 44.9652413], [38.7774846, 44.9660659], [38.7807756, 44.9667693], [38.7818548, 44.967654], [38.7823655, 44.9670754], [38.7829272, 44.9667293], [38.784076, 44.9664382], [38.7852756, 44.966294], [38.7860512, 44.9660515], [38.7872925, 44.965386], [38.7878753, 44.96444], [38.7874982, 44.9625481], [38.7866755, 44.9607774], [38.7866412, 44.9591037], [38.7873268, 44.9574056], [38.7873268, 44.9565323], [38.7855562, 44.9556326], [38.7837959, 44.9548099], [38.7828659, 44.9538319], [38.7826542, 44.9535981], [38.7825362, 44.9532748], [38.7822818, 44.9525775], [38.7825696, 44.9512483], [38.7827864, 44.9507575], [38.7831385, 44.9499603], [38.7831652, 44.9481729], [38.7833679, 44.9469631], [38.784162, 44.9457969], [38.7852038, 44.9447937], [38.7863397, 44.9439767], [38.7880555, 44.943178], [38.7896454, 44.9426561], [38.7913375, 44.9425866], [38.793632, 44.9427221], [38.7942263, 44.9427068], [38.7956906, 44.9426866], [38.7974991, 44.9423095], [38.8031405, 44.9400961], [38.8055395, 44.9392475], [38.8069875, 44.939036], [38.8083772, 44.939205], [38.8095784, 44.9398264], [38.8099785, 44.9406371], [38.8105191, 44.9417454], [38.8107885, 44.9422684], [38.8111552, 44.9428405], [38.8116241, 44.9432209], [38.8123833, 44.9435214], [38.8134303, 44.9437711], [38.814788, 44.9439458], [38.8157261, 44.9438934], [38.816516, 44.9435265], [38.8180465, 44.9426179], [38.8195276, 44.9412376], [38.8204656, 44.9406435], [38.8222573, 44.9399146], [38.8229692, 44.9392931], [38.8234032, 44.9385642], [38.8241684, 44.9381448], [38.8249522, 44.9377779], [38.8275072, 44.9376206], [38.8285193, 44.9372886], [38.828939, 44.9366945], [38.8289584, 44.9363744], [38.6840182, 44.9514152]]], [[[38.6993329, 45.0663371], [38.6979519, 45.0646389], [38.6931289, 45.0646389], [38.6931124, 45.0641566], [38.6929885, 45.0605324], [38.6918928, 45.0597907], [38.6897178, 45.0599755], [38.689105, 45.0391916], [38.6859068, 45.039156], [38.684445, 45.000459], [38.684639, 44.990928], [38.6840182, 44.9514152], [38.6993329, 45.0663371]]], [[[38.7027799, 45.0659687], [38.6993329, 45.0663371], [38.7027799, 45.0659687]]], [[[38.8213008, 45.0120489], [38.8209322, 45.0122665], [38.8193092, 45.0126043], [38.8174045, 45.0125034], [38.8156517, 45.0118431], [38.8143707, 45.0110195], [38.813559, 45.009571], [38.8131521, 45.0032555], [38.8129209, 45.0014474], [38.8124286, 44.9996676], [38.8117524, 44.9982046], [38.8109848, 44.9972089], [38.8092609, 44.9959439], [38.8077617, 44.9956477], [38.8060531, 44.9956857], [38.8027018, 44.9968083], [38.798707, 44.9982608], [38.7951587, 44.9998296], [38.7905438, 45.0019548], [38.7858694, 45.0045624], [38.7823475, 45.0078111], [38.7807308, 45.0095069], [38.7792536, 45.0118294], [38.7786165, 45.0119846], [38.7779748, 45.0124529], [38.7751747, 45.0160066], [38.7739687, 45.0179529], [38.7732953, 45.0197109], [38.7728896, 45.0220673], [38.771998, 45.0246455], [38.7711584, 45.0260075], [38.7700109, 45.0273808], [38.7686202, 45.0285783], [38.7662823, 45.0297549], [38.7630392, 45.0308913], [38.7586985, 45.031573], [38.7564685, 45.0331227], [38.7552643, 45.0351945], [38.754909, 45.0370994], [38.755905, 45.0389008], [38.7585874, 45.0423215], [38.7610404, 45.0442553], [38.7662482, 45.0470744], [38.7687175, 45.0488689], [38.769685, 45.051066], [38.7699699, 45.0525076], [38.7700925, 45.0539898], [38.76967, 45.0552987], [38.7679097, 45.0566392], [38.7641492, 45.0586504], [38.7615799, 45.059655], [38.76011, 45.0601455], [38.7583109, 45.0603947], [38.7547162, 45.0602762], [38.7499679, 45.0600459], [38.7480129, 45.0595522], [38.746158, 45.057853], [38.7445, 45.0563703], [38.7424892, 45.0550495], [38.7406525, 45.0534063], [38.7391555, 45.0510122], [38.7381739, 45.0485173], [38.7370747, 45.0469321], [38.7355312, 45.0452825], [38.7328062, 45.043156], [38.7304689, 45.0418444], [38.7273894, 45.0408335], [38.7251026, 45.0403592], [38.7232848, 45.0402795], [38.7213208, 45.040611], [38.7201814, 45.0416803], [38.7194752, 45.0429578], [38.7186078, 45.0467572], [38.7184853, 45.0500894], [38.7184787, 45.05415], [38.7180811, 45.0557335], [38.7155604, 45.0595792], [38.7132089, 45.0610829], [38.7097829, 45.0633298], [38.7077929, 45.0645623], [38.7055537, 45.0655051], [38.7027799, 45.0659687], [38.8213008, 45.0120489]]], [[[38.8561379, 45.001299], [38.8548862, 45.0021278], [38.8539866, 45.0031131], [38.8521699, 45.0050087], [38.8499218, 45.0069811], [38.8483776, 45.0077274], [38.8463106, 45.008073], [38.8443913, 45.0081888], [38.8431105, 45.0080213], [38.8409871, 45.0074031], [38.8394526, 45.0067172], [38.8375829, 45.0060313], [38.8345272, 45.005359], [38.8324024, 45.005415], [38.8305219, 45.0058179], [38.8295818, 45.0065595], [38.8274555, 45.0079554], [38.8260121, 45.0089245], [38.8245128, 45.0100718], [38.8230378, 45.0110232], [38.8213008, 45.0120489], [38.8561379, 45.001299]]], [[[38.8583566, 45.0336293], [38.8569108, 45.0327715], [38.8546379, 45.029783], [38.8536012, 45.0263413], [38.8535482, 45.0249046], [38.854198, 45.0235264], [38.8547492, 45.0222407], [38.8552898, 45.0212239], [38.8568438, 45.0196108], [38.8581115, 45.0184809], [38.859779, 45.0168486], [38.8629621, 45.0148572], [38.864786, 45.013267], [38.8660764, 45.0118957], [38.8662507, 45.0103148], [38.866069, 45.0075278], [38.8658921, 45.0066273], [38.8648696, 45.005308], [38.8634248, 45.0037473], [38.8603849, 45.0016211], [38.8590595, 45.0010404], [38.8575672, 45.000918], [38.8561379, 45.001299], [38.8583566, 45.0336293]]], [[[38.9094189, 45.0444479], [38.9093526, 45.0446476], [38.9092969, 45.0450296], [38.9092928, 45.0453359], [38.9092617, 45.0459907], [38.9092683, 45.0481367], [38.909071, 45.0493589], [38.9086977, 45.0503637], [38.9082584, 45.051585], [38.907674, 45.0521701], [38.9055384, 45.052922], [38.9040604, 45.053362], [38.9014753, 45.0539282], [38.899565, 45.054009], [38.8985108, 45.0539941], [38.8977012, 45.0537915], [38.8942627, 45.0521738], [38.8911596, 45.0505755], [38.8894631, 45.0496166], [38.8881344, 45.0487244], [38.8866766, 45.0473811], [38.8848832, 45.0446982], [38.8827375, 45.0423532], [38.8805738, 45.0398716], [38.8779847, 45.0380234], [38.8761108, 45.0371383], [38.8739696, 45.0362096], [38.8727749, 45.0359959], [38.8675836, 45.0349504], [38.8656523, 45.0350151], [38.8630236, 45.0344341], [38.8608415, 45.0342686], [38.8583566, 45.0336293], [38.9094189, 45.0444479]]], [[[38.9477325, 45.0362265], [38.9461866, 45.0362695], [38.9438634, 45.0362902], [38.9406751, 45.0361525], [38.9383602, 45.0356296], [38.9357044, 45.0348102], [38.9313951, 45.033364], [38.9301812, 45.0328979], [38.9290322, 45.0322565], [38.9282681, 45.0315257], [38.9268893, 45.0306001], [38.9250318, 45.0295666], [38.9231047, 45.0288531], [38.9194822, 45.0274667], [38.9186894, 45.0272718], [38.9136942, 45.0256032], [38.909842, 45.0236248], [38.9071594, 45.0222659], [38.9040236, 45.0216376], [38.9013075, 45.0215533], [38.8997742, 45.0224542], [38.8992161, 45.0237977], [38.8994413, 45.0247108], [38.8993001, 45.027035], [38.8994242, 45.0275367], [38.8995357, 45.029409], [38.8999088, 45.0309399], [38.9002051, 45.0316679], [38.9011979, 45.0329842], [38.9020403, 45.034071], [38.9032028, 45.0353071], [38.904015, 45.0362849], [38.90496, 45.0371099], [38.9075326, 45.0402217], [38.9089795, 45.0422017], [38.9094189, 45.0444479], [38.9477325, 45.0362265]]], [[[38.9788137, 45.0103948], [38.9784503, 45.0103925], [38.9767821, 45.0098076], [38.9750395, 45.0088997], [38.9742182, 45.0082843], [38.9734476, 45.0073834], [38.9718136, 45.0038], [38.9709953, 45.0011115], [38.970903, 44.9992039], [38.9713195, 44.9978836], [38.9715397, 44.9965446], [38.9715041, 44.9941031], [38.9709203, 44.9928208], [38.9695786, 44.9918878], [38.9683225, 44.9915352], [38.9667879, 44.99139], [38.9646819, 44.9914354], [38.9628998, 44.9920828], [38.9595819, 44.9937695], [38.9580259, 44.9951475], [38.9569113, 44.995741], [38.9556178, 44.9964832], [38.9544713, 44.9973689], [38.9534881, 44.998205], [38.9527785, 44.9994038], [38.9522318, 45.0008036], [38.9522489, 45.0023577], [38.9521161, 45.0032865], [38.9521237, 45.0043406], [38.9518738, 45.0054342], [38.9508827, 45.0075741], [38.9504593, 45.0084558], [38.9490475, 45.0102997], [38.9484737, 45.0114096], [38.9481583, 45.0131157], [38.9473133, 45.0154858], [38.9471379, 45.0165492], [38.9471839, 45.0175804], [38.9474132, 45.0187015], [38.948639, 45.0208051], [38.9493407, 45.0215589], [38.9510856, 45.0230462], [38.9535994, 45.0245497], [38.9561582, 45.0260982], [38.9572428, 45.0271379], [38.9576386, 45.0276659], [38.9579341, 45.0282639], [38.9580816, 45.0289403], [38.9581167, 45.029823], [38.9577771, 45.0313763], [38.9572916, 45.0324367], [38.9563972, 45.0335659], [38.9547322, 45.0346573], [38.9531737, 45.035477], [38.9530777, 45.0355252], [38.9519097, 45.0358938], [38.9499468, 45.036171], [38.9478846, 45.0362543], [38.9477325, 45.0362265], [38.9788137, 45.0103948]]], [[[38.9892037, 45.0069561], [38.9861566, 45.0092018], [38.9843532, 45.0102296], [38.9830202, 45.0103868], [38.9788137, 45.0103948], [38.9892037, 45.0069561]]], [[[39.0185692, 44.9730167], [39.0186963, 44.9743715], [39.019048, 44.9758544], [39.0197591, 44.9794616], [39.0199242, 44.9819099], [39.019834, 44.9829216], [39.0193753, 44.9851798], [39.0188183, 44.9862679], [39.0188462, 44.9872382], [39.0185095, 44.9881573], [39.0179863, 44.9891874], [39.0168151, 44.9912647], [39.0163989, 44.9919941], [39.0159804, 44.9934813], [39.0158547, 44.9947637], [39.0151745, 44.9956035], [39.0151635, 44.996115], [39.0154879, 44.9967921], [39.0179427, 44.9981427], [39.0184267, 44.9986345], [39.0190625, 44.9992121], [39.0192776, 44.9999281], [39.0190535, 45.0007213], [39.0181797, 45.0016528], [39.0165252, 45.0028489], [39.0151459, 45.0034861], [39.0142255, 45.0039787], [39.0131242, 45.0040656], [39.0123767, 45.0039101], [39.0107361, 45.0032289], [39.0095584, 45.0030833], [39.0075947, 45.0037931], [39.0061764, 45.0040724], [39.0029808, 45.0036853], [38.9989665, 45.0031934], [38.9977685, 45.0033122], [38.9966339, 45.0035991], [38.9935933, 45.0046225], [38.9922534, 45.0050791], [38.9909896, 45.0056934], [38.9892037, 45.0069561], [39.0185692, 44.9730167]]], [[[39.0446063, 44.9847029], [39.0431481, 44.9848432], [39.0414767, 44.9848709], [39.0402718, 44.9844064], [39.0371633, 44.9825908], [39.0345018, 44.9809084], [39.0336055, 44.980208], [39.0331137, 44.9794544], [39.0316797, 44.9752656], [39.0309975, 44.9733098], [39.0294703, 44.9711682], [39.0286207, 44.9701117], [39.0275075, 44.9692506], [39.0254393, 44.9684529], [39.0233913, 44.9679583], [39.0224589, 44.9679589], [39.0215868, 44.9682717], [39.0203838, 44.9690778], [39.0195494, 44.970353], [39.0189092, 44.971687], [39.0185692, 44.9730167], [39.0446063, 44.9847029]]], [[[39.0610226, 44.9744785], [39.0599388, 44.9742876], [39.0559325, 44.9758273], [39.0540041, 44.9781038], [39.0518438, 44.9808397], [39.0505545, 44.982299], [39.0490113, 44.983391], [39.0470301, 44.9843469], [39.0454758, 44.9846237], [39.0446063, 44.9847029], [39.0610226, 44.9744785]]], [[[39.1156094, 44.9979876], [39.1153892, 44.9979393], [39.1151452, 44.9978858], [39.1150399, 44.9978552], [39.1149352, 44.9978118], [39.1109419, 44.9961401], [39.1085117, 44.9952793], [39.1062223, 44.9937769], [39.103461, 44.9916277], [39.1022664, 44.9902523], [39.1008774, 44.9888769], [39.0988601, 44.9880797], [39.092991, 44.9874168], [39.0888762, 44.9868484], [39.0869801, 44.9867548], [39.0855028, 44.986864], [39.0834245, 44.9875834], [39.0809243, 44.9885822], [39.0798585, 44.9888599], [39.0786882, 44.9886031], [39.0776973, 44.9880207], [39.0773066, 44.9866027], [39.0768328, 44.9859692], [39.0760222, 44.9832772], [39.0760442, 44.9805481], [39.0761562, 44.9801062], [39.076418, 44.9799876], [39.0759682, 44.9787164], [39.0749856, 44.9779811], [39.0740986, 44.977407], [39.0715563, 44.9761467], [39.0703064, 44.9755433], [39.0610226, 44.9744785], [39.1156094, 44.9979876]]], [[[39.1349193, 44.9981167], [39.1310499, 44.9958386], [39.1302121, 44.9953241], [39.1277427, 44.9950278], [39.1258466, 44.9953085], [39.1235756, 44.9958386], [39.1228481, 44.9966805], [39.1226276, 44.9974601], [39.1214131, 44.9980724], [39.1188638, 44.998363], [39.1167719, 44.998242], [39.1156094, 44.9979876], [39.1349193, 44.9981167]]], [[[39.3135146, 45.029469], [39.3079543, 45.0297348], [39.3053747, 45.0302179], [39.3031038, 45.0302958], [39.3018704, 45.0301507], [39.3007807, 45.029498], [39.2978043, 45.0265373], [39.2928434, 45.0211219], [39.2903355, 45.019018], [39.2890953, 45.0178296], [39.2866149, 45.0168165], [39.2828505, 45.0161011], [39.2797642, 45.0160267], [39.2768291, 45.0164111], [39.2745581, 45.0172527], [39.2730051, 45.0185239], [39.2727061, 45.0192009], [39.2724194, 45.0209931], [39.2730809, 45.0242346], [39.2741392, 45.0264942], [39.275347, 45.0278821], [39.276714, 45.0291287], [39.277155, 45.029752], [39.2770447, 45.0304064], [39.2765578, 45.0306767], [39.2753681, 45.0307226], [39.2741011, 45.0307093], [39.2727352, 45.0303104], [39.2716741, 45.0298716], [39.2698792, 45.0289621], [39.2686537, 45.0279046], [39.2670161, 45.0249601], [39.2665045, 45.0234766], [39.2655521, 45.0212449], [39.2645819, 45.0199981], [39.2643879, 45.0192002], [39.2643174, 45.0183149], [39.2641057, 45.0172177], [39.263614, 45.0164554], [39.2634486, 45.0150526], [39.2638896, 45.0137862], [39.2646613, 45.0127731], [39.2647991, 45.009831], [39.2647164, 45.0069472], [39.2644683, 45.0056417], [39.2636415, 45.0043945], [39.2623462, 45.0034397], [39.2576059, 45.0019587], [39.2558262, 45.001998], [39.2327086, 45.0100139], [39.2325186, 45.010386], [39.2336431, 45.0113369], [39.235892, 45.0125215], [39.2368842, 45.0129112], [39.2387803, 45.0142516], [39.2394417, 45.0153894], [39.2393315, 45.0160596], [39.239089, 45.0164648], [39.2371487, 45.0172909], [39.2353408, 45.0179766], [39.2335108, 45.018226], [39.2314824, 45.0182728], [39.2304682, 45.0180078], [39.228991, 45.0169324], [39.2273205, 45.0152204], [39.2255549, 45.0130285], [39.2237032, 45.0092839], [39.2226697, 45.0058131], [39.2224113, 45.0033773], [39.2223085, 45.0011604], [39.2223942, 44.9981511], [39.2226328, 44.9944303], [39.2228754, 44.9936195], [39.2231399, 44.9902983], [39.2225887, 44.9893471], [39.2214422, 44.9889885], [39.2198768, 44.9889105], [39.2169241, 44.9891478], [39.2148874, 44.990231], [39.2130673, 44.9918657], [39.2106789, 44.9943024], [39.206348, 44.9985003], [39.2039061, 45.0000759], [39.2022305, 45.0006216], [39.2009517, 45.0005748], [39.1987249, 44.9999512], [39.1961452, 44.9989846], [39.1940286, 44.99794], [39.1926396, 44.9969889], [39.1905741, 44.9949434], [39.1887661, 44.9939952], [39.1860322, 44.9930909], [39.1835628, 44.9913289], [39.182284, 44.9906896], [39.1792193, 44.9898164], [39.1779846, 44.989832], [39.1757844, 44.9903472], [39.1642318, 44.9938251], [39.1623202, 44.9940037], [39.1520541, 44.9936139], [39.1490225, 44.9940524], [39.1481957, 44.9943935], [39.1464732, 44.9952705], [39.1417535, 44.9981939], [39.1399966, 44.998949], [39.138757, 44.9990035], [39.1363194, 44.9986606], [39.1349193, 44.9981167], [39.3135146, 45.029469]]], [[[39.3850758, 45.077695], [39.3836277, 45.0770285], [39.3822498, 45.0761041], [39.3814272, 45.0753313], [39.3802728, 45.0731313], [39.3785072, 45.0663797], [39.3777076, 45.0647934], [39.3772942, 45.0623212], [39.37768, 45.0607638], [39.3776524, 45.058272], [39.3760523, 45.0565539], [39.373358, 45.0552228], [39.3573491, 45.0478871], [39.3548467, 45.0462768], [39.3529464, 45.0449485], [39.3513333, 45.044165], [39.3498175, 45.0436976], [39.3448291, 45.0424708], [39.3412463, 45.0421787], [39.3381044, 45.0421592], [39.3329231, 45.0431329], [39.3287891, 45.0445155], [39.326915, 45.0449049], [39.3260697, 45.0448117], [39.3254151, 45.0436126], [39.3253462, 45.0415193], [39.3257596, 45.0378921], [39.3263453, 45.0366019], [39.3269309, 45.0356038], [39.3269998, 45.0338509], [39.3262075, 45.0328771], [39.3235893, 45.0308807], [39.3220735, 45.0301747], [39.3194553, 45.029566], [39.3166993, 45.0293468], [39.3135146, 45.029469], [39.3850758, 45.077695]]], [[[39.4966022, 45.1393254], [39.4916003, 45.1390652], [39.489094, 45.1384884], [39.485401, 45.137983], [39.4836096, 45.1375747], [39.4818733, 45.1373803], [39.4803918, 45.1366264], [39.4794437, 45.1360509], [39.476761, 45.1339736], [39.4760103, 45.1337247], [39.4736997, 45.1337371], [39.4727296, 45.133426], [39.4721828, 45.1333265], [39.4714243, 45.1330901], [39.4689197, 45.131348], [39.4677059, 45.1299333], [39.4676436, 45.1290177], [39.4678024, 45.1282835], [39.4682433, 45.1274995], [39.4685608, 45.1267403], [39.4694251, 45.1258194], [39.4711537, 45.1244131], [39.4720003, 45.1232557], [39.4720393, 45.1220926], [39.4715199, 45.1212482], [39.4694441, 45.120126], [39.4675745, 45.1196282], [39.4663398, 45.1197402], [39.4631649, 45.1205865], [39.461005, 45.1212012], [39.4598761, 45.1217613], [39.4574773, 45.122284], [39.4564366, 45.1220475], [39.4550608, 45.1216119], [39.4545248, 45.1212092], [39.4541436, 45.1204918], [39.4541084, 45.1196455], [39.4550432, 45.1185751], [39.4568247, 45.1178656], [39.4579359, 45.1177412], [39.459541, 45.1169819], [39.4607021, 45.1161903], [39.4621978, 45.1150153], [39.4639617, 45.1137706], [39.4661489, 45.1120379], [39.4672669, 45.1107172], [39.4677603, 45.1091603], [39.4675763, 45.1079127], [39.4652756, 45.105268], [39.4640079, 45.1028753], [39.4629055, 45.101961], [39.4617204, 45.101786], [39.4602597, 45.1022139], [39.4591022, 45.1030699], [39.4577242, 45.1036535], [39.4563462, 45.1038674], [39.454665, 45.1046261], [39.4526136, 45.1059733], [39.4488379, 45.1070511], [39.4458301, 45.1083508], [39.4449622, 45.1091736], [39.4439508, 45.1099838], [39.4428315, 45.1104483], [39.4412775, 45.110832], [39.4399271, 45.1109098], [39.4385491, 45.1104624], [39.4367301, 45.1091009], [39.4335331, 45.1071752], [39.4310803, 45.1053662], [39.4295448, 45.1040967], [39.4287167, 45.1014065], [39.4292356, 45.0976739], [39.4269122, 45.0924555], [39.4239922, 45.0896768], [39.4216689, 45.0887899], [39.4188045, 45.089092], [39.417575, 45.0898592], [39.4153878, 45.0905748], [39.4130314, 45.091561], [39.4103503, 45.0929856], [39.4076269, 45.0940216], [39.4061171, 45.0943104], [39.4049318, 45.0942924], [39.4033932, 45.0936769], [39.4013474, 45.0923163], [39.4001127, 45.0906726], [39.399513, 45.0892655], [39.3994072, 45.0875968], [39.3998305, 45.0857786], [39.4004655, 45.0844709], [39.4024959, 45.0826565], [39.4031289, 45.0815193], [39.4031564, 45.080989], [39.4031103, 45.0802848], [39.402504, 45.0794285], [39.4007953, 45.0774824], [39.3990867, 45.0767033], [39.3922398, 45.0774124], [39.3896491, 45.0775292], [39.386397, 45.0778795], [39.3850758, 45.077695], [39.4966022, 45.1393254]]], [[[39.5519025, 45.1907814], [39.5478735, 45.1897381], [39.5456117, 45.1885878], [39.5442792, 45.1871219], [39.5433668, 45.18235], [39.5416616, 45.1774183], [39.5416559, 45.1721719], [39.5415308, 45.1652894], [39.5402576, 45.1625493], [39.5386919, 45.1612681], [39.537054, 45.1605531], [39.534441, 45.160654], [39.5300814, 45.161615], [39.5265436, 45.1620977], [39.5226348, 45.1621617], [39.5156149, 45.1617721], [39.5133075, 45.1611763], [39.5041294, 45.1511816], [39.4981479, 45.1403222], [39.4966022, 45.1393254], [39.5519025, 45.1907814]]], [[[39.6054128, 45.212785], [39.5950491, 45.2106168], [39.5916972, 45.2087954], [39.5853013, 45.2024755], [39.5828473, 45.2009393], [39.58053, 45.2003925], [39.5778976, 45.2003696], [39.5738305, 45.2008659], [39.5708405, 45.2004262], [39.5602274, 45.1964376], [39.5578927, 45.1952231], [39.5562027, 45.1927679], [39.5544088, 45.1914304], [39.5519025, 45.1907814], [39.6054128, 45.212785]]], [[[39.6903414, 45.1863385], [39.6916502, 45.1871044], [39.6908783, 45.189538], [39.6881199, 45.1927707], [39.6860997, 45.1945456], [39.6836817, 45.1960663], [39.6801198, 45.1976052], [39.6731356, 45.2027566], [39.6704563, 45.203953], [39.661852, 45.2055526], [39.6395697, 45.2122955], [39.6285617, 45.216601], [39.6250872, 45.2169791], [39.6203276, 45.2171133], [39.6162616, 45.2168098], [39.610309, 45.2141321], [39.6066691, 45.2130478], [39.6054128, 45.212785], [39.6903414, 45.1863385]]], [[[39.6858648, 45.1618163], [39.6800895, 45.166019], [39.6795645, 45.1669201], [39.6796242, 45.1679773], [39.6805895, 45.1688805], [39.6850615, 45.1687046], [39.6859558, 45.1693205], [39.6862886, 45.1709188], [39.6873673, 45.1732771], [39.687391, 45.1747752], [39.686322, 45.1803466], [39.6853039, 45.1820992], [39.683666, 45.1837737], [39.6825074, 45.1845651], [39.6779707, 45.1855672], [39.6773273, 45.1861267], [39.6774001, 45.1870539], [39.678399, 45.1874551], [39.6807629, 45.1878488], [39.683891, 45.1873334], [39.6868159, 45.1859591], [39.6894971, 45.1858445], [39.6903414, 45.1863385], [39.6858648, 45.1618163]]], [[[39.8312926, 45.1131728], [39.8293111, 45.114097], [39.8288851, 45.1151021], [39.8290449, 45.1171688], [39.8298436, 45.1197613], [39.8290199, 45.1212707], [39.8282463, 45.1215567], [39.8275431, 45.1215936], [39.8265239, 45.1211973], [39.8260248, 45.1197443], [39.8259166, 45.1176478], [39.8250345, 45.1165407], [39.8239165, 45.1156967], [39.8223825, 45.1153298], [39.8212294, 45.1155916], [39.8201895, 45.1170135], [39.8202487, 45.1192062], [39.8202545, 45.1194215], [39.8192033, 45.1219095], [39.8176545, 45.122609], [39.815607, 45.122632], [39.8140717, 45.1217503], [39.8135486, 45.1207392], [39.8135192, 45.1189031], [39.8150537, 45.1165302], [39.8151317, 45.1147322], [39.8130258, 45.1138148], [39.8108678, 45.1142001], [39.8096978, 45.1153376], [39.8090478, 45.1202362], [39.8084498, 45.1222909], [39.8072972, 45.1233063], [39.8045966, 45.1247836], [39.8034931, 45.1257519], [39.8032071, 45.1271827], [39.8028952, 45.129017], [39.8022712, 45.1300626], [39.8006592, 45.1306312], [39.7989214, 45.1308025], [39.7966195, 45.1308059], [39.7950414, 45.130515], [39.7938386, 45.130024], [39.7929893, 45.1292053], [39.7916248, 45.1276791], [39.7904268, 45.1270686], [39.7896774, 45.1269839], [39.7889004, 45.1270027], [39.7864532, 45.1281493], [39.7851776, 45.1282561], [39.7846362, 45.1278105], [39.7836512, 45.1247017], [39.7823429, 45.1236969], [39.7807309, 45.1235501], [39.7793269, 45.1242839], [39.7789109, 45.1257147], [39.7791709, 45.1270355], [39.780228, 45.128825], [39.780956, 45.1310628], [39.781164, 45.1326953], [39.780904, 45.1332455], [39.7758911, 45.133976], [39.7741271, 45.1341447], [39.7711787, 45.1341823], [39.7691962, 45.1346409], [39.7660763, 45.1365208], [39.7643596, 45.1371756], [39.7609889, 45.1371931], [39.758794, 45.1363732], [39.7566, 45.1340522], [39.7537724, 45.1322816], [39.7501844, 45.1316029], [39.7478185, 45.1322449], [39.7452962, 45.1336014], [39.7440455, 45.1345266], [39.7405978, 45.1360948], [39.7396526, 45.137832], [39.7395886, 45.137927], [39.7388536, 45.1390179], [39.7383072, 45.1395002], [39.7374212, 45.1398848], [39.7366459, 45.14069], [39.7354702, 45.1416575], [39.7351097, 45.1424921], [39.7345714, 45.143889], [39.733871, 45.1447949], [39.7327832, 45.1459119], [39.7305785, 45.1496086], [39.7294541, 45.1507329], [39.727139, 45.1517847], [39.7259142, 45.152039], [39.7226863, 45.1511909], [39.7208226, 45.1510126], [39.7194996, 45.1507026], [39.7176398, 45.1495552], [39.7168494, 45.1488217], [39.7167246, 45.1474721], [39.7169326, 45.1453303], [39.716475, 45.1439807], [39.7152478, 45.1435112], [39.7138543, 45.1433792], [39.7128975, 45.1438046], [39.7114831, 45.1449929], [39.7108383, 45.1462105], [39.7111919, 45.1470467], [39.7122527, 45.1479856], [39.7131471, 45.1491005], [39.7137087, 45.1510661], [39.7130223, 45.1524743], [39.7117831, 45.1531703], [39.7097908, 45.1533264], [39.7079448, 45.1530514], [39.7060469, 45.1513095], [39.7052929, 45.1491092], [39.7037329, 45.1477156], [39.7019129, 45.1467254], [39.6998281, 45.1470497], [39.698767, 45.1477889], [39.698065, 45.1490175], [39.698689, 45.1511262], [39.7004309, 45.1522263], [39.7025369, 45.1552149], [39.7021469, 45.15615], [39.7004366, 45.156724], [39.6984616, 45.1560944], [39.6966104, 45.1552437], [39.6915561, 45.1539529], [39.6896633, 45.1540263], [39.6879161, 45.154833], [39.6872714, 45.1557424], [39.6873546, 45.1568131], [39.6884985, 45.1594825], [39.6883113, 45.1607585], [39.687417, 45.1613891], [39.6858648, 45.1618163], [39.8312926, 45.1131728]]], [[[39.8444209, 45.1156846], [39.8442847, 45.1168478], [39.8432572, 45.1175237], [39.8419127, 45.117768], [39.8406082, 45.1177867], [39.8387039, 45.1172788], [39.8363902, 45.1149387], [39.8341456, 45.1135161], [39.8328643, 45.1131605], [39.8312926, 45.1131728], [39.8444209, 45.1156846]]], [[[39.9002614, 45.0865507], [39.8975578, 45.0854652], [39.8954518, 45.0847677], [39.8940739, 45.0846942], [39.8929559, 45.0853918], [39.8930599, 45.0861811], [39.8937879, 45.0882187], [39.8945158, 45.0896505], [39.8954134, 45.0905881], [39.8970298, 45.0917078], [39.8991097, 45.0934973], [39.9004422, 45.0952639], [39.9001473, 45.0966772], [39.8989513, 45.0977049], [39.8954239, 45.0997471], [39.8887262, 45.1018754], [39.8841563, 45.1039703], [39.8812627, 45.1045889], [39.8766146, 45.1048079], [39.8744477, 45.1050699], [39.8737332, 45.105409], [39.8727897, 45.1063139], [39.8720836, 45.1075783], [39.8722658, 45.1084831], [39.8733844, 45.1107996], [39.8722664, 45.1119556], [39.8705943, 45.1125852], [39.8676495, 45.1129446], [39.8642787, 45.1128849], [39.8613251, 45.1123125], [39.8587712, 45.112429], [39.8571877, 45.1129599], [39.8559034, 45.1144904], [39.854593, 45.1167068], [39.853137, 45.1177782], [39.8518059, 45.1180278], [39.8507659, 45.117426], [39.8497883, 45.1162371], [39.849409, 45.1145199], [39.8499978, 45.1113909], [39.8495169, 45.1095254], [39.8483937, 45.1079547], [39.8467713, 45.1070739], [39.8443378, 45.1070005], [39.841613, 45.1082777], [39.8407436, 45.1103416], [39.8411596, 45.1123027], [39.8434226, 45.1142873], [39.8443243, 45.1155494], [39.8444209, 45.1156846], [39.9002614, 45.0865507]]], [[[39.9404283, 45.0934285], [39.9385001, 45.0927003], [39.9363664, 45.0921299], [39.9345098, 45.0925986], [39.9341714, 45.0939157], [39.9343471, 45.0951507], [39.9334773, 45.0959927], [39.9312725, 45.0957578], [39.9289008, 45.0949275], [39.9270871, 45.0944928], [39.9245745, 45.0943519], [39.9225972, 45.0948433], [39.9202508, 45.0959366], [39.9164047, 45.0948056], [39.9114285, 45.0944222], [39.9074272, 45.0937598], [39.9014536, 45.0918803], [39.899723, 45.0911989], [39.8993403, 45.0904001], [39.8996638, 45.0896688], [39.9009224, 45.0880769], [39.9008423, 45.0870896], [39.9002614, 45.0865507], [39.9404283, 45.0934285]]], [[[40.009744, 45.0910832], [40.0087432, 45.0907877], [40.0064052, 45.089861], [40.0052725, 45.089966], [40.000043, 45.0938653], [39.9969645, 45.0947928], [39.9944946, 45.0953068], [39.9918946, 45.0945726], [39.9904697, 45.0929373], [39.9909879, 45.0914523], [39.9917728, 45.0904256], [39.9906746, 45.0884285], [39.9878292, 45.087383], [39.9848008, 45.0868543], [39.98322, 45.0871245], [39.9815661, 45.0878956], [39.9801996, 45.0899994], [39.978716, 45.09101], [39.9764942, 45.0913723], [39.9742999, 45.0892016], [39.9734959, 45.0876633], [39.973054, 45.0864702], [39.9727539, 45.0847899], [39.9725542, 45.083333], [39.9714494, 45.0822217], [39.9706186, 45.0814142], [39.9694458, 45.0808132], [39.9672471, 45.0813308], [39.9664434, 45.0825727], [39.9662254, 45.0843967], [39.9647341, 45.0852953], [39.9636644, 45.0857168], [39.962626, 45.0858057], [39.9613475, 45.0857085], [39.9596639, 45.0854689], [39.9586737, 45.0841314], [39.9567134, 45.0833264], [39.9550177, 45.083392], [39.9509274, 45.08492], [39.9500339, 45.0851285], [39.9495219, 45.0854809], [39.948805, 45.0861828], [39.9484271, 45.0874378], [39.9485344, 45.0884657], [39.9494757, 45.0896255], [39.9509097, 45.0899407], [39.9517487, 45.0900319], [39.952523, 45.0903257], [39.9532082, 45.0913675], [39.952367, 45.0920733], [39.9508347, 45.0921913], [39.9500066, 45.0933746], [39.9484206, 45.0945125], [39.9464707, 45.0948062], [39.9442087, 45.0948246], [39.9425041, 45.0945069], [39.9409707, 45.0936333], [39.9404283, 45.0934285], [40.009744, 45.0910832]]], [[[40.0534642, 45.0989901], [40.0514666, 45.0999444], [40.0505751, 45.1005549], [40.0491731, 45.1003426], [40.0477758, 45.0996535], [40.047327, 45.09821], [40.048913, 45.0966257], [40.0491684, 45.095754], [40.0485855, 45.094993], [40.0469699, 45.0943828], [40.0456154, 45.0948922], [40.0442797, 45.096514], [40.044707, 45.0980062], [40.0444697, 45.0991857], [40.0429772, 45.1004687], [40.0419518, 45.1017151], [40.041127, 45.10292], [40.040385, 45.1031896], [40.0395289, 45.1027797], [40.0393121, 45.1022887], [40.0385998, 45.1017405], [40.0333557, 45.0996993], [40.02942, 45.0975931], [40.0277912, 45.0940167], [40.0265359, 45.0926755], [40.0241296, 45.092238], [40.0227853, 45.0924891], [40.0218178, 45.0930788], [40.0203256, 45.0950579], [40.0152488, 45.0963774], [40.0138722, 45.0962003], [40.0133653, 45.095593], [40.0133048, 45.0943512], [40.009744, 45.0910832], [40.0534642, 45.0989901]]], [[[40.0882908, 45.1092806], [40.0882568, 45.108936], [40.0879576, 45.1086222], [40.0871361, 45.108197], [40.0868795, 45.1074876], [40.0872924, 45.1070439], [40.0876507, 45.106794], [40.0889478, 45.1063328], [40.0896512, 45.1057317], [40.0904828, 45.1045369], [40.0907895, 45.1033134], [40.0907928, 45.1022956], [40.0905878, 45.1003701], [40.0902554, 45.0997437], [40.0894611, 45.0991463], [40.0878865, 45.0989338], [40.0859596, 45.0993142], [40.0836795, 45.1008501], [40.0820355, 45.1029769], [40.0808508, 45.1047961], [40.0808329, 45.1078277], [40.0803561, 45.1086244], [40.0790076, 45.1098863], [40.0765964, 45.1101251], [40.0738084, 45.1099091], [40.0717189, 45.1089555], [40.0707422, 45.107861], [40.0717256, 45.1064856], [40.0755427, 45.1061182], [40.0766982, 45.1049676], [40.0763262, 45.1036303], [40.0744398, 45.1023172], [40.0720077, 45.10102], [40.0708722, 45.0987443], [40.0691645, 45.0965121], [40.0675773, 45.0955242], [40.065039, 45.0949599], [40.0631009, 45.0958296], [40.0626207, 45.0969248], [40.0614038, 45.0985497], [40.0590185, 45.0991936], [40.0566023, 45.0992774], [40.0547029, 45.0988163], [40.0534642, 45.0989901], [40.0882908, 45.1092806]]], [[[40.1790489, 45.1103109], [40.1740829, 45.1105972], [40.1738381, 45.1115408], [40.1743435, 45.1147384], [40.1740473, 45.1155378], [40.1729493, 45.1162511], [40.1710846, 45.1164725], [40.1686622, 45.1165121], [40.1678106, 45.1170862], [40.1678164, 45.1179761], [40.1685833, 45.1186647], [40.1689039, 45.1193337], [40.1682347, 45.1205142], [40.1662828, 45.1218718], [40.1652651, 45.1217734], [40.1643031, 45.1208487], [40.1641915, 45.1197764], [40.1635223, 45.1181728], [40.1633846, 45.117369], [40.163791, 45.1165877], [40.1641206, 45.1157655], [40.1641585, 45.1153146], [40.1636459, 45.1147684], [40.1631776, 45.1145852], [40.1624238, 45.1145346], [40.1618141, 45.1146674], [40.1613626, 45.1150494], [40.1613817, 45.1156726], [40.1615373, 45.116285], [40.1614094, 45.1169321], [40.1608176, 45.1174753], [40.1603115, 45.1179037], [40.1597139, 45.118334], [40.1587856, 45.1191111], [40.1575052, 45.1197], [40.1568836, 45.1200848], [40.156021, 45.1204758], [40.1552576, 45.1209434], [40.1539408, 45.1214467], [40.149497, 45.1218566], [40.1470011, 45.12212], [40.144704, 45.1221546], [40.1431096, 45.1220032], [40.1414008, 45.1219633], [40.1398165, 45.1215053], [40.1360345, 45.120171], [40.1346617, 45.1196823], [40.1338562, 45.1190173], [40.1332649, 45.1173437], [40.1326499, 45.1139364], [40.1320834, 45.1132115], [40.131021, 45.1127399], [40.1289736, 45.1126149], [40.1275006, 45.1126525], [40.1261422, 45.1129362], [40.124821, 45.1137769], [40.1230093, 45.1156614], [40.1220616, 45.1165125], [40.1210418, 45.1166943], [40.1193309, 45.1166449], [40.116585, 45.1164049], [40.1128203, 45.1159813], [40.1112966, 45.1155467], [40.1093338, 45.114762], [40.108145, 45.1139611], [40.104988, 45.11113], [40.1036224, 45.1098838], [40.1019641, 45.1092359], [40.0995787, 45.1091789], [40.0966883, 45.1096945], [40.0939442, 45.1102038], [40.0910486, 45.1103141], [40.0892318, 45.1100533], [40.0882908, 45.1092806], [40.1790489, 45.1103109]]], [[[40.2289727, 45.1172406], [40.227033, 45.1177569], [40.225714, 45.1176068], [40.2206509, 45.1173666], [40.2201403, 45.1169163], [40.2195021, 45.115415], [40.2177962, 45.1140728], [40.2164228, 45.1141057], [40.2157692, 45.1142594], [40.2145929, 45.1149666], [40.2133948, 45.1163655], [40.2124145, 45.1164731], [40.2107153, 45.1158736], [40.2097786, 45.1146437], [40.208319, 45.1137367], [40.2069248, 45.1129988], [40.2048989, 45.1125222], [40.2037142, 45.1126106], [40.2033111, 45.1126598], [40.2027185, 45.1133485], [40.2019343, 45.1152424], [40.2004356, 45.1164231], [40.1993028, 45.116337], [40.1983094, 45.1155991], [40.1959393, 45.114689], [40.193402, 45.1140245], [40.1918078, 45.1156862], [40.1908929, 45.1177307], [40.1897383, 45.1182994], [40.1885402, 45.1182841], [40.1870371, 45.1179766], [40.1866253, 45.1176185], [40.1864336, 45.1164994], [40.1862746, 45.1162655], [40.1858536, 45.1162509], [40.1839872, 45.1169363], [40.1798346, 45.1166481], [40.1786773, 45.1159515], [40.1780646, 45.1150868], [40.1779625, 45.114174], [40.1774519, 45.1134775], [40.1782348, 45.1115558], [40.179563, 45.1110776], [40.1796589, 45.1105077], [40.1790489, 45.1103109], [40.2289727, 45.1172406]]], [[[40.3507372, 45.04517], [40.3501253, 45.0473058], [40.3490706, 45.0475795], [40.3470917, 45.0476814], [40.3451211, 45.0461139], [40.3415721, 45.0445118], [40.3389433, 45.0443725], [40.3376571, 45.0452327], [40.3372345, 45.0459513], [40.3376288, 45.0469729], [40.340422, 45.0480873], [40.3430509, 45.0503161], [40.3459426, 45.0514768], [40.3476843, 45.0536358], [40.3478486, 45.0548894], [40.3470917, 45.0558429], [40.3447628, 45.0562416], [40.3425165, 45.0557428], [40.3411045, 45.0549267], [40.3407194, 45.052433], [40.3391149, 45.0512541], [40.3369969, 45.0511634], [40.3339803, 45.0540199], [40.3319907, 45.0567403], [40.3294876, 45.0575564], [40.328223, 45.0573141], [40.3278944, 45.0560606], [40.3281573, 45.0536463], [40.3244769, 45.0522999], [40.3217823, 45.0522767], [40.320205, 45.0535302], [40.3201392, 45.0547838], [40.321618, 45.0559909], [40.3224724, 45.0572909], [40.3234546, 45.0591885], [40.3223877, 45.0605083], [40.319751, 45.0615336], [40.3176459, 45.0613486], [40.313012, 45.0599015], [40.3107014, 45.0597655], [40.3086476, 45.0602642], [40.3069789, 45.0619869], [40.3041549, 45.0616696], [40.3008175, 45.0632563], [40.296733, 45.062473], [40.2951201, 45.0626584], [40.2947288, 45.0625986], [40.2931873, 45.062363], [40.2904921, 45.0620386], [40.2894356, 45.0619791], [40.2886174, 45.062003], [40.2874813, 45.062088], [40.2864468, 45.0622311], [40.285689, 45.0624136], [40.2850489, 45.0627131], [40.2846266, 45.0630098], [40.2843472, 45.0633397], [40.2841865, 45.0636756], [40.2841393, 45.0639258], [40.2841585, 45.0641713], [40.2842399, 45.0643836], [40.2844248, 45.0646091], [40.2847533, 45.064814], [40.285155, 45.0649527], [40.2858515, 45.0650695], [40.2875989, 45.0651054], [40.2888222, 45.0651532], [40.2909947, 45.0655647], [40.2929728, 45.0662593], [40.2931875, 45.067313], [40.2923059, 45.0690533], [40.2914243, 45.0696121], [40.2902035, 45.0697638], [40.2882481, 45.0695403], [40.2872309, 45.069652], [40.2851624, 45.0701469], [40.284213, 45.0707376], [40.2836704, 45.071496], [40.2842554, 45.0727314], [40.284552, 45.0732202], [40.2854111, 45.0736273], [40.2882255, 45.0743057], [40.292871, 45.075056], [40.2938431, 45.0754392], [40.2942274, 45.0761017], [40.2941566, 45.076735], [40.2933973, 45.0772147], [40.2912314, 45.0777057], [40.2885631, 45.0790165], [40.2888328, 45.0799798], [40.2895514, 45.0807162], [40.2894572, 45.080905], [40.2896466, 45.0815797], [40.2897769, 45.0826268], [40.2858969, 45.0838193], [40.2844079, 45.0845806], [40.284041, 45.0862189], [40.2852578, 45.0868086], [40.2892832, 45.0867216], [40.2926925, 45.0843145], [40.2940891, 45.0848655], [40.2946642, 45.0860836], [40.2925282, 45.0882877], [40.2878456, 45.0904917], [40.2859971, 45.0925796], [40.2855453, 45.0955953], [40.284313, 45.097857], [40.2827111, 45.0986979], [40.2809037, 45.0992198], [40.2795416, 45.1000621], [40.2794574, 45.1014654], [40.2808766, 45.1032152], [40.2807739, 45.1039037], [40.2765122, 45.1055708], [40.26994, 45.1056795], [40.2679376, 45.1049547], [40.2654634, 45.1031081], [40.2643818, 45.1022603], [40.2627087, 45.1010461], [40.2612573, 45.1000564], [40.2610887, 45.1000973], [40.258515, 45.0999821], [40.2557508, 45.1002151], [40.2530831, 45.1012014], [40.2514621, 45.1004613], [40.2504099, 45.0979542], [40.2486596, 45.0973474], [40.2478019, 45.0980303], [40.2477343, 45.0988918], [40.2484962, 45.1007096], [40.2483873, 45.1013862], [40.2488012, 45.1018013], [40.2495418, 45.1022473], [40.249629, 45.1026624], [40.2493675, 45.1033543], [40.2484308, 45.1040155], [40.2463613, 45.104323], [40.2452721, 45.1049688], [40.2438763, 45.1068327], [40.2396215, 45.1080338], [40.2387706, 45.1090848], [40.2389462, 45.1098301], [40.2401376, 45.1102505], [40.241882, 45.1105736], [40.2426172, 45.1111694], [40.243298, 45.1124185], [40.2431891, 45.1131295], [40.2426445, 45.1136291], [40.2415825, 45.1137829], [40.2402754, 45.1131871], [40.2394585, 45.1130718], [40.2388612, 45.1133733], [40.2371167, 45.1144242], [40.2345639, 45.115415], [40.2317983, 45.116586], [40.2295858, 45.1169763], [40.2289727, 45.1172406], [40.3507372, 45.04517]]], [[[40.3595019, 45.0523388], [40.3534695, 45.0476738], [40.3509208, 45.0454283], [40.3507372, 45.04517], [40.3595019, 45.0523388]]], [[[40.4005664, 45.0240442], [40.3889458, 45.0339968], [40.3707967, 45.0457877], [40.3609877, 45.0515345], [40.3595019, 45.0523388], [40.4005664, 45.0240442]]], [[[40.4823196, 44.9610932], [40.4774335, 44.9638272], [40.461691, 44.9732491], [40.4504159, 44.9800512], [40.4477924, 44.9821345], [40.4482008, 44.983266], [40.4461245, 44.9859143], [40.4441844, 44.9867328], [40.4416996, 44.9881532], [40.4341279, 44.9960982], [40.4340843, 44.9978389], [40.4337357, 44.9990713], [40.4336704, 45.0007503], [40.4331694, 45.0011508], [40.4309256, 45.0016899], [40.4300542, 45.0014742], [40.4290739, 45.0009351], [40.4260241, 45.0040312], [40.4244977, 45.0032901], [40.4121026, 45.0128896], [40.4005664, 45.0240442], [40.4823196, 44.9610932]]]]}	44.77788090018502,40.06460274817761	5842238	Europe/Moscow	2026-03-21 20:50:38.711698+00
3	городской округ Краснодар	gorodskoy-okrug-krasnodar	district	2	\N	45.0937763,39.0164697	\N	\N	2026-03-21 20:52:33.744698+00
4	Динской район	dinskoy-rayon	district	2	\N	45.2512976,39.0729717	\N	\N	2026-03-21 20:52:33.744698+00
5	Красноармейский район	krasnoarmeyskiy-rayon	district	2	\N	45.3258944,38.4107362	\N	\N	2026-03-21 20:52:33.744698+00
6	Северский район	severskiy-rayon	district	2	\N	44.7870953,38.7177143	\N	\N	2026-03-21 20:52:33.744698+00
7	Абинский район	abinskiy-rayon	district	2	\N	44.8849241,38.2878967	\N	\N	2026-03-21 20:52:33.744698+00
8	Славянский район	slavyanskiy-rayon	district	2	\N	45.4322275,37.8912155	\N	\N	2026-03-21 20:52:33.744698+00
9	Крымский район	krymskiy-rayon	district	2	\N	44.9625269,37.8329466	\N	\N	2026-03-21 20:52:33.744698+00
10	Темрюкский район	temryukskiy-rayon	district	2	\N	45.2643139,37.1537616	\N	\N	2026-03-21 20:52:33.744698+00
11	муниципальный округ Анапа	munitsipalnyy-okrug-anapa	district	2	\N	44.9513051,37.2719538	\N	\N	2026-03-21 20:52:33.744698+00
12	городской округ Новороссийск	gorodskoy-okrug-novorossiysk	district	2	\N	44.8305287,37.6731303	\N	\N	2026-03-21 20:52:33.744698+00
13	городской округ Геленджик	gorodskoy-okrug-gelendzhik	district	2	\N	44.5483408,38.2775379	\N	\N	2026-03-21 20:52:33.744698+00
14	муниципальный округ Горячий Ключ	munitsipalnyy-okrug-goryachiy-klyuch	district	2	\N	44.6128185,39.2430691	\N	\N	2026-03-21 20:52:33.744698+00
15	Белореченский район	belorechenskiy-rayon	district	2	\N	44.7819868,39.7497583	\N	\N	2026-03-21 20:52:33.744698+00
16	Апшеронский район	apsheronskiy-rayon	district	2	\N	44.3012439,39.6819443	\N	\N	2026-03-21 20:52:33.744698+00
17	Туапсинский муниципальный округ	tuapsinskiy-munitsipalnyy-okrug	district	2	\N	44.2686691,39.0958981	\N	\N	2026-03-21 20:52:33.744698+00
18	городской округ Сочи	gorodskoy-okrug-sochi	district	2	\N	43.7611586,39.9055726	\N	\N	2026-03-21 20:52:33.744698+00
19	Мостовский район	mostovskiy-rayon	district	2	\N	44.147479,40.6360521	\N	\N	2026-03-21 20:52:33.744698+00
20	Ейский район	eyskiy-rayon	district	2	\N	46.440845,38.1621064	\N	\N	2026-03-21 20:52:33.744698+00
21	Щербиновский район	scherbinovskiy-rayon	district	2	\N	46.6270554,38.6635572	\N	\N	2026-03-21 20:52:33.744698+00
22	Староминский район	starominskiy-rayon	district	2	\N	46.500066,39.0339113	\N	\N	2026-03-21 20:52:33.744698+00
23	Приморско-Ахтарский муниципальный округ	primorsko-ahtarskiy-munitsipalnyy-okrug	district	2	\N	45.9658004,38.2458817	\N	\N	2026-03-21 20:52:33.744698+00
24	Калининский район	kalininskiy-rayon	district	2	\N	45.5305453,38.3965172	\N	\N	2026-03-21 20:52:33.744698+00
25	Тимашёвский район	timashyovskiy-rayon	district	2	\N	45.5674671,38.9780234	\N	\N	2026-03-21 20:52:33.744698+00
26	Брюховецкий район	bryuhovetskiy-rayon	district	2	\N	45.8546073,39.0608558	\N	\N	2026-03-21 20:52:33.744698+00
27	Кущёвский район	kuschyovskiy-rayon	district	2	\N	46.5645301,39.6863422	\N	\N	2026-03-21 20:52:33.744698+00
28	Крыловский район	krylovskiy-rayon	district	2	\N	46.398871,40.0499186	\N	\N	2026-03-21 20:52:33.744698+00
29	Каневской район	kanevskoy-rayon	district	2	\N	46.137344,39.0081287	\N	\N	2026-03-21 20:52:33.744698+00
30	Ленинградский муниципальный округ	leningradskiy-munitsipalnyy-okrug	district	2	\N	46.2259654,39.417124	\N	\N	2026-03-21 20:52:33.744698+00
31	Лабинский район	labinskiy-rayon	district	2	\N	44.4408676,40.9405803	\N	\N	2026-03-21 20:52:33.744698+00
32	Отрадненский район	otradnenskiy-rayon	district	2	\N	44.308353,41.3975382	\N	\N	2026-03-21 20:52:33.744698+00
33	Успенский район	uspenskiy-rayon	district	2	\N	44.8334244,41.4054616	\N	\N	2026-03-21 20:52:33.744698+00
34	городской округ Армавир	gorodskoy-okrug-armavir	district	2	\N	44.9207619,41.0792476	\N	\N	2026-03-21 20:52:33.744698+00
35	Новокубанский район	novokubanskiy-rayon	district	2	\N	44.8909105,41.086172	\N	\N	2026-03-21 20:52:33.744698+00
36	Курганинский район	kurganinskiy-rayon	district	2	\N	44.9583917,40.5554569	\N	\N	2026-03-21 20:52:33.744698+00
37	Гулькевичский район	gulkevichskiy-rayon	district	2	\N	45.2512851,40.6553703	\N	\N	2026-03-21 20:52:33.744698+00
38	Кавказский район	kavkazskiy-rayon	district	2	\N	45.523757,40.5997104	\N	\N	2026-03-21 20:52:33.744698+00
39	Белоглинский район	beloglinskiy-rayon	district	2	\N	45.9864011,40.9013374	\N	\N	2026-03-21 20:52:33.744698+00
40	Новопокровский район	novopokrovskiy-rayon	district	2	\N	45.968912,40.6050434	\N	\N	2026-03-21 20:52:33.744698+00
41	Павловский район	pavlovskiy-rayon	district	2	\N	46.0803824,39.9225048	\N	\N	2026-03-21 20:52:33.744698+00
42	Кореновский район	korenovskiy-rayon	district	2	\N	45.5610498,39.3911936	\N	\N	2026-03-21 20:52:33.744698+00
43	Тбилисский район	tbilisskiy-rayon	district	2	\N	45.3846998,40.1606622	\N	\N	2026-03-21 20:52:33.744698+00
44	Тихорецкий район	tihoretskiy-rayon	district	2	\N	45.8283988,40.1901302	\N	\N	2026-03-21 20:52:33.744698+00
45	Выселковский район	vyselkovskiy-rayon	district	2	\N	45.6643217,39.8382777	\N	\N	2026-03-21 20:52:33.744698+00
46	Усть-Лабинский район	ust-labinskiy-rayon	district	2	\N	45.2697602,39.7456249	\N	\N	2026-03-21 20:52:33.744698+00
47	городской округ Сириус	gorodskoy-okrug-sirius	district	2	\N	43.4067304,39.9664535	\N	\N	2026-03-21 20:52:33.744698+00
48	Краснодар	krasnodar	city	2	\N	45.0351532,38.9772396	1154885	\N	2026-03-21 20:52:49.875179+00
49	Славянск-на-Кубани	slavyansk-na-kubani	city	2	\N	45.2590875,38.1244609	61449	\N	2026-03-21 20:52:49.875179+00
50	Темрюк	temryuk	city	2	\N	45.2823609,37.3658235	39164	\N	2026-03-21 20:52:49.875179+00
51	Анапа	anapa	city	2	\N	44.894272,37.316887	82695	\N	2026-03-21 20:52:49.875179+00
52	Приморско-Ахтарск	primorsko-ahtarsk	city	2	\N	46.0433467,38.1560033	30465	\N	2026-03-21 20:52:49.875179+00
53	Ейск	eysk	city	2	\N	46.7112094,38.2747987	82534	\N	2026-03-21 20:52:49.875179+00
54	Сочи	sochi	city	2	\N	43.5854823,39.723109	446599	\N	2026-03-21 20:52:49.875179+00
55	Геленджик	gelendzhik	city	2	\N	44.5609447,38.0766832	80296	\N	2026-03-21 20:52:49.875179+00
56	Кабардинка	kabardinka	city	2	\N	44.6515718,37.9395292	7550	\N	2026-03-21 20:52:49.875179+00
57	Горячий Ключ	goryachiy-klyuch	city	2	\N	44.6342653,39.1363613	34585	\N	2026-03-21 20:52:49.875179+00
58	Туапсе	tuapse	city	2	\N	44.0984747,39.0718875	60707	\N	2026-03-21 20:52:49.875179+00
59	Новороссийск	novorossiysk	city	2	\N	44.7239578,37.7690711	261973	\N	2026-03-21 20:52:49.875179+00
60	Армавир	armavir	city	2	\N	44.9993585,41.1294061	187215	\N	2026-03-21 20:52:49.875179+00
61	Тимашёвск	timashyovsk	city	2	\N	45.6129685,38.9357743	52641	\N	2026-03-21 20:52:49.875179+00
62	Павловская	pavlovskaya	city	2	\N	46.1352,39.783	\N	\N	2026-03-21 20:52:49.875179+00
63	Витязево	vityazevo	city	2	\N	44.9897066,37.2607195	7936	\N	2026-03-21 20:52:49.875179+00
64	Джубга	dzhubga	city	2	\N	44.3170538,38.7043664	7024	\N	2026-03-21 20:52:49.875179+00
65	Дагомыс	dagomys	city	2	\N	43.6590048,39.6544373	17841	\N	2026-03-21 20:52:49.875179+00
66	Усть-Лабинск	ust-labinsk	city	2	\N	45.2094926,39.6901178	42062	\N	2026-03-21 20:52:49.875179+00
67	Васюринская	vasyurinskaya	city	2	\N	45.1183262,39.4200463	13339	\N	2026-03-21 20:52:49.875179+00
68	Воронежская	voronezhskaya	city	2	\N	45.2120476,39.5670828	8562	\N	2026-03-21 20:52:49.875179+00
69	Пластуновская	plastunovskaya	city	2	\N	45.2962422,39.2662799	10264	\N	2026-03-21 20:52:49.875179+00
70	Платнировская	platnirovskaya	city	2	\N	45.391981,39.3903857	12004	\N	2026-03-21 20:52:49.875179+00
71	Елизаветинская	elizavetinskaya	city	2	\N	45.0480573,38.7928963	24755	\N	2026-03-21 20:52:49.875179+00
72	Новомышастовская	novomyshastovskaya	city	2	\N	45.1987319,38.5795212	10032	\N	2026-03-21 20:52:49.875179+00
73	Динская	dinskaya	city	2	\N	45.2168713,39.2249757	34848	\N	2026-03-21 20:52:49.875179+00
74	Белореченск	belorechensk	city	2	\N	44.7614149,39.8712943	52322	\N	2026-03-21 20:52:49.875179+00
75	Выселки	vyselki	city	2	\N	45.5806221,39.6574237	19426	\N	2026-03-21 20:52:49.875179+00
76	Афипский	afipskiy	city	2	\N	44.9040435,38.8426821	19956	\N	2026-03-21 20:52:49.875179+00
77	Северская	severskaya	city	2	\N	44.853421,38.6781253	24867	\N	2026-03-21 20:52:49.875179+00
78	Ильский	ilskiy	city	2	\N	44.8458544,38.5608255	24831	\N	2026-03-21 20:52:49.875179+00
79	Крымск	krymsk	city	2	\N	44.9295889,37.9880177	54420	\N	2026-03-21 20:52:49.875179+00
80	Курганинск	kurganinsk	city	2	\N	44.8851635,40.5894674	48194	\N	2026-03-21 20:52:49.875179+00
81	Калининская	kalininskaya	city	2	\N	45.4856626,38.6598137	13391	\N	2026-03-21 20:52:49.875179+00
82	Брюховецкая	bryuhovetskaya	city	2	\N	45.8006933,39.0006977	22024	\N	2026-03-21 20:52:49.875179+00
83	Переясловская	pereyaslovskaya	city	2	\N	45.844673,39.021858	8424	\N	2026-03-21 20:52:49.875179+00
84	Каневская	kanevskaya	city	2	\N	46.0845999,38.9721929	41721	\N	2026-03-21 20:52:49.875179+00
85	Стародеревянковская	staroderevyankovskaya	city	2	\N	46.1277738,38.9713729	13482	\N	2026-03-21 20:52:49.875179+00
86	Варениковская	varenikovskaya	city	2	\N	45.121292,37.638737	14881	\N	2026-03-21 20:52:49.875179+00
87	Старотитаровская	starotitarovskaya	city	2	\N	45.2188185,37.1480059	12164	\N	2026-03-21 20:52:49.875179+00
88	Тбилисская	tbilisskaya	city	2	\N	45.3635681,40.1898342	25317	\N	2026-03-21 20:52:49.875179+00
89	Ладожская	ladozhskaya	city	2	\N	45.3076593,39.9268511	14828	\N	2026-03-21 20:52:49.875179+00
90	Медвёдовская	medvyodovskaya	city	2	\N	45.4525812,39.0167858	16793	\N	2026-03-21 20:52:49.875179+00
91	Холмская	holmskaya	city	2	\N	44.8432658,38.3950178	17585	\N	2026-03-21 20:52:49.875179+00
92	Ахтырский	ahtyrskiy	city	2	\N	44.8559341,38.2941737	20863	\N	2026-03-21 20:52:49.875179+00
93	Абинск	abinsk	city	2	\N	44.8649528,38.1578189	36986	\N	2026-03-21 20:52:49.875179+00
94	Старощербиновская	staroscherbinovskaya	city	2	\N	46.6284506,38.6624971	18010	\N	2026-03-21 20:52:49.875179+00
95	Новотитаровская	novotitarovskaya	city	2	\N	45.2360889,38.9712606	24754	\N	2026-03-21 20:52:49.875179+00
96	Апшеронск	apsheronsk	city	2	\N	44.4674401,39.733173	40244	\N	2026-03-21 20:52:49.875179+00
97	Тихорецк	tihoretsk	city	2	\N	45.854679,40.128124	54582	\N	2026-03-21 20:52:49.875179+00
98	Роговская	rogovskaya	city	2	\N	45.734535,38.739555	7864	\N	2026-03-21 20:52:49.875179+00
99	Новопокровская	novopokrovskaya	city	2	\N	45.953815,40.707203	19684	\N	2026-03-21 20:52:49.875179+00
100	Белая Глина	belaya-glina	city	2	\N	46.0778137,40.8739482	17320	\N	2026-03-21 20:52:49.875179+00
101	Архангельская	arhangelskaya	city	2	\N	45.6725524,40.2796117	8714	\N	2026-03-21 20:52:49.875179+00
102	Нижнебаканская	nizhnebakanskaya	city	2	\N	44.8646355,37.8608578	8277	\N	2026-03-21 20:52:49.875179+00
103	Анапская	anapskaya	city	2	\N	44.9002856,37.3832216	16107	\N	2026-03-21 20:52:49.875179+00
104	Псебай	psebay	city	2	\N	44.1092655,40.7902989	10613	\N	2026-03-21 20:52:49.875179+00
105	Лабинск	labinsk	city	2	\N	44.6347953,40.7242185	60971	\N	2026-03-21 20:52:49.875179+00
106	Мостовской	mostovskoy	city	2	\N	44.4138041,40.7899446	25006	\N	2026-03-21 20:52:49.875179+00
107	Архипо-Осиповка	arhipo-osipovka	city	2	\N	44.3703184,38.533611	7853	\N	2026-03-21 20:52:49.875179+00
108	Новомихайловский	novomihaylovskiy	city	2	\N	44.2533593,38.8447977	10792	\N	2026-03-21 20:52:49.875179+00
109	Нефтегорск	neftegorsk	city	2	\N	44.3555651,39.7034985	5188	\N	2026-03-21 20:52:49.875179+00
110	Крыловская	krylovskaya	city	2	\N	46.321865,39.962914	13621	\N	2026-03-21 20:52:49.875179+00
111	Ленинградская	leningradskaya	city	2	\N	46.3212449,39.389554	36940	\N	2026-03-21 20:52:49.875179+00
112	Новоминская	novominskaya	city	2	\N	46.317478,38.955532	11595	\N	2026-03-21 20:52:49.875179+00
113	Кущёвская	kuschyovskaya	city	2	\N	46.5650084,39.6273712	30200	\N	2026-03-21 20:52:49.875179+00
114	Староминская	starominskaya	city	2	\N	46.5359488,39.0625056	29809	\N	2026-03-21 20:52:49.875179+00
115	Михайловская	mihaylovskaya	city	2	\N	44.990738,40.5999124	8245	\N	2026-03-21 20:52:49.875179+00
116	Фастовецкая	fastovetskaya	city	2	\N	45.917324,40.154659	8573	\N	2026-03-21 20:52:49.875179+00
117	Казанская	kazanskaya	city	2	\N	45.4074844,40.4406018	10991	\N	2026-03-21 20:52:49.875179+00
118	Кавказская	kavkazskaya	city	2	\N	45.4393405,40.6697566	11164	\N	2026-03-21 20:52:49.875179+00
119	Петровская	petrovskaya	city	2	\N	45.430317,37.956711	13554	\N	2026-03-21 20:52:49.875179+00
120	Новокубанск	novokubansk	city	2	\N	45.1083184,41.0366896	35251	\N	2026-03-21 20:52:49.875179+00
121	Гулькевичи	gulkevichi	city	2	\N	45.3565119,40.6962256	34347	\N	2026-03-21 20:52:49.875179+00
122	Советская	sovetskaya	city	2	\N	44.7836633,41.1711179	9021	\N	2026-03-21 20:52:49.875179+00
123	Тамань	taman	city	2	\N	45.2158646,36.7191326	10827	\N	2026-03-21 20:52:49.875179+00
124	Марьянская	maryanskaya	city	2	\N	45.0991226,38.6367903	10643	\N	2026-03-21 20:52:49.875179+00
125	Октябрьская	oktyabrskaya	city	2	\N	46.2837923,39.8102996	11252	\N	2026-03-21 20:52:49.875179+00
126	Красносельский	krasnoselskiy	city	2	\N	45.3934779,40.598473	7676	\N	2026-03-21 20:52:49.875179+00
127	Успенское	uspenskoe	city	2	\N	44.8346548,41.3850485	12409	\N	2026-03-21 20:52:49.875179+00
128	Коноково	konokovo	city	2	\N	44.8617355,41.325343	7880	\N	2026-03-21 20:52:49.875179+00
129	Черноморский	chernomorskiy	city	2	\N	44.849996,38.4944065	8512	\N	2026-03-21 20:52:49.875179+00
130	Родниковская	rodnikovskaya	city	2	\N	44.7685255,40.6579706	8346	\N	2026-03-21 20:52:49.875179+00
131	Отрадная	otradnaya	city	2	\N	44.3975687,41.5263169	23204	\N	2026-03-21 20:52:49.875179+00
132	Кропоткин	kropotkin	city	2	\N	45.4344413,40.5750274	79795	\N	2026-03-21 20:52:49.875179+00
133	Кореновск	korenovsk	city	2	\N	45.4635863,39.4487565	41828	\N	2026-03-21 20:52:49.875179+00
134	Старокорсунская	starokorsunskaya	city	2	\N	45.0506551,39.3130266	12238	\N	2026-03-21 20:52:49.875179+00
135	Хадыженск	hadyzhensk	city	2	\N	44.4231032,39.5369484	22430	\N	2026-03-21 20:52:49.875179+00
136	Гирей	girey	city	2	\N	45.4024641,40.6581862	6441	\N	2026-03-21 20:52:49.875179+00
137	Владимирская	vladimirskaya	city	2	\N	44.5446631,40.8043345	7217	\N	2026-03-21 20:52:49.875179+00
138	Старомышастовская	staromyshastovskaya	city	2	\N	45.3419471,39.0729692	10610	\N	2026-03-21 20:52:49.875179+00
139	Гостагаевская	gostagaevskaya	city	2	\N	45.024044,37.502266	9772	\N	2026-03-21 20:52:49.875179+00
140	Нововеличковская	novovelichkovskaya	city	2	\N	45.2787805,38.8377083	9169	\N	2026-03-21 20:52:49.875179+00
141	Ивановская	ivanovskaya	city	2	\N	45.2672191,38.4653294	9473	\N	2026-03-21 20:52:49.875179+00
142	Старая Станица	staraya-stanitsa	city	2	\N	45.0143064,41.1490284	7612	\N	2026-03-21 20:52:49.875179+00
143	Красная Поляна	krasnaya-polyana	city	2	\N	43.6779574,40.2069574	9165	\N	2026-03-21 20:52:49.875179+00
144	Полтавская	poltavskaya	city	2	\N	45.366794,38.2115057	26490	\N	2026-03-21 20:52:49.875179+00
145	Сириус	sirius	city	2	\N	43.4062071,39.9545377	\N	\N	2026-03-21 20:52:49.875179+00
\.


--
-- Data for Name: interests; Type: TABLE DATA; Schema: public; Owner: kraeved_user
--

COPY public.interests (id, name, emoji) FROM stdin;
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
1	1	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Кавказская кухня "Хаш"	0	2026-03-21 21:03:49.269188+00
2	1	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Кавказская кухня "Хаш"	1	2026-03-21 21:03:49.269188+00
3	2	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Ресторан	0	2026-03-21 21:03:49.269188+00
4	2	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Ресторан	1	2026-03-21 21:03:49.269188+00
5	3	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Старина Герман	0	2026-03-21 21:03:49.269188+00
6	3	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Старина Герман	1	2026-03-21 21:03:49.269188+00
7	4	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Хванчкара	0	2026-03-21 21:03:49.269188+00
8	4	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Хванчкара	1	2026-03-21 21:03:49.269188+00
9	5	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Пенальти	0	2026-03-21 21:03:49.269188+00
10	5	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Пенальти	1	2026-03-21 21:03:49.269188+00
11	6	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Сербский ресторан	0	2026-03-21 21:03:49.269188+00
12	6	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Сербский ресторан	1	2026-03-21 21:03:49.269188+00
13	7	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Пивница	0	2026-03-21 21:03:49.269188+00
117	60	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/%D0%90%D1%80%D1%85%D0%B8%D0%BF%D0%BE-%D0%9E%D1%81%D0%B8%D0%BF%D0%BE%D0%B2%D0%BA%D0%B0._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B9._-_panoramio.jpg/960px-%D0%90%D1%80%D1%85%D0%B8%D0%BF%D0%BE-%D0%9E%D1%81%D0%B8%D0%BF%D0%BE%D0%B2%D0%BA%D0%B0._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B9._-_panoramio.jpg	Кавказ	0	2026-03-21 21:04:53.165994+00
14	7	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Пивница	1	2026-03-21 21:03:49.269188+00
15	8	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Версаль	0	2026-03-21 21:03:49.269188+00
16	8	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Версаль	1	2026-03-21 21:03:49.269188+00
17	9	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Грааль	0	2026-03-21 21:03:49.269188+00
18	9	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Грааль	1	2026-03-21 21:03:49.269188+00
19	10	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Мадьяр	0	2026-03-21 21:03:49.269188+00
20	10	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Мадьяр	1	2026-03-21 21:03:49.269188+00
21	11	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	У Близнецов	0	2026-03-21 21:04:02.982376+00
22	11	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	У Близнецов	1	2026-03-21 21:04:02.982376+00
23	12	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Казачок	0	2026-03-21 21:04:02.982376+00
24	12	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Казачок	1	2026-03-21 21:04:02.982376+00
25	13	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Кафе молодежное	0	2026-03-21 21:04:02.982376+00
26	13	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Кафе молодежное	1	2026-03-21 21:04:02.982376+00
27	14	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Big Bull	0	2026-03-21 21:04:02.982376+00
28	14	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Big Bull	1	2026-03-21 21:04:02.982376+00
29	15	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Променад	0	2026-03-21 21:04:02.982376+00
30	15	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Променад	1	2026-03-21 21:04:02.982376+00
31	16	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Pn-2014-09-10-n35.pdf/page1-960px-Pn-2014-09-10-n35.pdf.jpg	Старый Базар	0	2026-03-21 21:04:02.982376+00
32	17	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Оливье	0	2026-03-21 21:04:02.982376+00
33	17	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Оливье	1	2026-03-21 21:04:02.982376+00
34	18	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Федина дача	0	2026-03-21 21:04:02.982376+00
35	18	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Федина дача	1	2026-03-21 21:04:02.982376+00
36	19	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Восточный квартал	0	2026-03-21 21:04:02.982376+00
37	19	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Восточный квартал	1	2026-03-21 21:04:02.982376+00
38	20	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/%22%D0%9A%D0%B0%D1%82%D1%8E%D1%88%D0%B0%22.JPG/960px-%22%D0%9A%D0%B0%D1%82%D1%8E%D1%88%D0%B0%22.JPG	Катюша	0	2026-03-21 21:04:02.982376+00
39	20	https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/%D0%A0%D0%B5%D0%B0%D0%BA%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B5_%D0%BE%D1%80%D1%83%D0%B4%D0%B8%D0%B5_%22%D0%9A%D0%B0%D1%82%D1%8E%D1%88%D0%B0%22.jpg/960px-%D0%A0%D0%B5%D0%B0%D0%BA%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B5_%D0%BE%D1%80%D1%83%D0%B4%D0%B8%D0%B5_%22%D0%9A%D0%B0%D1%82%D1%8E%D1%88%D0%B0%22.jpg	Катюша	1	2026-03-21 21:04:02.982376+00
40	21	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	«Ё-Моё»	0	2026-03-21 21:04:15.800314+00
41	21	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	«Ё-Моё»	1	2026-03-21 21:04:15.800314+00
42	22	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Amsterdam Bar	0	2026-03-21 21:04:15.800314+00
118	60	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/%D0%91%D0%B5%D1%81%D0%BA%D0%BE%D0%BD%D0%B5%D1%87%D0%BD%D1%8B%D0%B9_%D0%9A%D0%B0%D0%B2%D0%BA%D0%B0%D0%B7.jpg/960px-%D0%91%D0%B5%D1%81%D0%BA%D0%BE%D0%BD%D0%B5%D1%87%D0%BD%D1%8B%D0%B9_%D0%9A%D0%B0%D0%B2%D0%BA%D0%B0%D0%B7.jpg	Кавказ	1	2026-03-21 21:04:53.165994+00
43	22	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Amsterdam Bar	1	2026-03-21 21:04:15.800314+00
44	23	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/%D0%94%D0%B5%D0%BD%D0%B4%D1%80%D0%B0%D1%80%D0%B8%D0%B9_%D0%A1%D0%BE%D1%87%D0%B8_%D0%9F%D0%B0%D0%BB%D1%8C%D0%BC%D0%B0_%D0%A4%D0%BE%D1%82%D0%BE_4.jpg/960px-%D0%94%D0%B5%D0%BD%D0%B4%D1%80%D0%B0%D1%80%D0%B8%D0%B9_%D0%A1%D0%BE%D1%87%D0%B8_%D0%9F%D0%B0%D0%BB%D1%8C%D0%BC%D0%B0_%D0%A4%D0%BE%D1%82%D0%BE_4.jpg	Пальма	0	2026-03-21 21:04:15.800314+00
45	23	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/%D0%9F%D0%B0%D0%BB%D1%8C%D0%BC%D0%B0_%D0%92%D0%B0%D1%88%D0%B8%D0%BD%D0%B3%D1%82%D0%BE%D0%BD%D0%B8%D1%8F._%D0%A1%D0%BE%D1%87%D0%B8.jpg/960px-%D0%9F%D0%B0%D0%BB%D1%8C%D0%BC%D0%B0_%D0%92%D0%B0%D1%88%D0%B8%D0%BD%D0%B3%D1%82%D0%BE%D0%BD%D0%B8%D1%8F._%D0%A1%D0%BE%D1%87%D0%B8.jpg	Пальма	1	2026-03-21 21:04:15.800314+00
46	24	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Nippon House	0	2026-03-21 21:04:15.800314+00
47	24	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Nippon House	1	2026-03-21 21:04:15.800314+00
48	25	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Таверна Каньон	0	2026-03-21 21:04:15.800314+00
49	25	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Таверна Каньон	1	2026-03-21 21:04:15.800314+00
50	26	https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/%D0%9F%D1%80%D0%BE%D1%85%D0%BB%D0%B0%D0%B4%D0%B0.jpg/960px-%D0%9F%D1%80%D0%BE%D1%85%D0%BB%D0%B0%D0%B4%D0%B0.jpg	Прохлада	0	2026-03-21 21:04:15.800314+00
51	26	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/%D0%A0%D0%BE%D0%B4%D0%BD%D0%B8%D0%BA_%D0%9F%D1%80%D0%BE%D1%85%D0%BB%D0%B0%D0%B4%D0%B0%2C_%D0%BF._%D0%93%D0%B8%D1%80%D0%B5%D0%B9.jpg/960px-%D0%A0%D0%BE%D0%B4%D0%BD%D0%B8%D0%BA_%D0%9F%D1%80%D0%BE%D1%85%D0%BB%D0%B0%D0%B4%D0%B0%2C_%D0%BF._%D0%93%D0%B8%D1%80%D0%B5%D0%B9.jpg	Прохлада	1	2026-03-21 21:04:15.800314+00
52	27	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Аурум	0	2026-03-21 21:04:15.800314+00
53	27	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Аурум	1	2026-03-21 21:04:15.800314+00
54	28	https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Sochi._Two_anchors_are_manufactured_at_the_Votkinsk_plant_2.jpg/960px-Sochi._Two_anchors_are_manufactured_at_the_Votkinsk_plant_2.jpg	Cinema	0	2026-03-21 21:04:15.800314+00
55	28	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/%D0%9A%D0%B8%D0%BD%D0%BE%D1%82%D0%B5%D0%B0%D1%82%D1%80_%D0%90%D0%B2%D1%80%D0%BE%D1%80%D0%B0_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80.jpg/960px-%D0%9A%D0%B8%D0%BD%D0%BE%D1%82%D0%B5%D0%B0%D1%82%D1%80_%D0%90%D0%B2%D1%80%D0%BE%D1%80%D0%B0_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80.jpg	Cinema	1	2026-03-21 21:04:15.800314+00
56	29	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Индус	0	2026-03-21 21:04:15.800314+00
57	29	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Индус	1	2026-03-21 21:04:15.800314+00
58	30	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Фидан	0	2026-03-21 21:04:15.800314+00
226	142	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1897_40.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1897_40.pdf.jpg	Надежда	0	2026-03-21 21:06:46.247618+00
59	30	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Фидан	1	2026-03-21 21:04:15.800314+00
60	31	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Алекс	0	2026-03-21 21:04:27.769475+00
61	31	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Алекс	1	2026-03-21 21:04:27.769475+00
62	32	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Флагман	0	2026-03-21 21:04:27.769475+00
63	32	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Флагман	1	2026-03-21 21:04:27.769475+00
64	33	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Прайд	0	2026-03-21 21:04:27.769475+00
65	33	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Прайд	1	2026-03-21 21:04:27.769475+00
66	34	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Япона Мама	0	2026-03-21 21:04:27.769475+00
67	34	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Япона Мама	1	2026-03-21 21:04:27.769475+00
68	35	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	London	0	2026-03-21 21:04:27.769475+00
69	35	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	London	1	2026-03-21 21:04:27.769475+00
70	36	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	На Краю Земли	0	2026-03-21 21:04:27.769475+00
71	36	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	На Краю Земли	1	2026-03-21 21:04:27.769475+00
72	37	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Шереметьево-4 (самолет)	0	2026-03-21 21:04:27.769475+00
73	37	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Шереметьево-4 (самолет)	1	2026-03-21 21:04:27.769475+00
74	38	https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Pn-2016-11-02-n45.pdf/page1-960px-Pn-2016-11-02-n45.pdf.jpg	Дом 1934 г	0	2026-03-21 21:04:27.769475+00
75	39	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Малый Ахун	0	2026-03-21 21:04:27.769475+00
76	39	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Малый Ахун	1	2026-03-21 21:04:27.769475+00
77	40	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Чайхона №1	0	2026-03-21 21:04:27.769475+00
78	40	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Чайхона №1	1	2026-03-21 21:04:27.769475+00
79	41	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Pn-2014-09-10-n35.pdf/page1-960px-Pn-2014-09-10-n35.pdf.jpg	Старый город	0	2026-03-21 21:04:41.3473+00
80	41	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/%D0%91%D0%BE%D0%BB%D1%8C%D1%88%D0%BE%D0%B9_%D0%A3%D1%82%D1%80%D0%B8%D1%88_%28%D0%90%D0%BD%D0%B0%D0%BF%D0%B0%291.jpg/960px-%D0%91%D0%BE%D0%BB%D1%8C%D1%88%D0%BE%D0%B9_%D0%A3%D1%82%D1%80%D0%B8%D1%88_%28%D0%90%D0%BD%D0%B0%D0%BF%D0%B0%291.jpg	Старый город	1	2026-03-21 21:04:41.3473+00
81	42	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/%D0%A7%D0%B0%D0%B9%D0%BA%D0%B0._%D0%9A%D0%BE%D1%80%D0%BF%D1%83%D1%81_%D0%91.jpg/960px-%D0%A7%D0%B0%D0%B9%D0%BA%D0%B0._%D0%9A%D0%BE%D1%80%D0%BF%D1%83%D1%81_%D0%91.jpg	Чайка	0	2026-03-21 21:04:41.3473+00
82	42	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/%D0%A7%D0%B0%D0%B9%D0%BA%D0%B0._%D0%9B%D0%B5%D1%87%D0%B5%D0%B1%D0%BD%D1%8B%D0%B9_%D0%BA%D0%BE%D1%80%D0%BF%D1%83%D1%81.jpg/960px-%D0%A7%D0%B0%D0%B9%D0%BA%D0%B0._%D0%9B%D0%B5%D1%87%D0%B5%D0%B1%D0%BD%D1%8B%D0%B9_%D0%BA%D0%BE%D1%80%D0%BF%D1%83%D1%81.jpg	Чайка	1	2026-03-21 21:04:41.3473+00
83	43	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Духанъ	0	2026-03-21 21:04:41.3473+00
84	43	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Духанъ	1	2026-03-21 21:04:41.3473+00
85	44	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Белый рояль	0	2026-03-21 21:04:41.3473+00
86	44	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Белый рояль	1	2026-03-21 21:04:41.3473+00
87	45	https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Outline_Map_of_Krasnodarski_Krai_%28with_Crimea_disputed%29.svg/960px-Outline_Map_of_Krasnodarski_Krai_%28with_Crimea_disputed%29.svg.png	Восток	0	2026-03-21 21:04:41.3473+00
88	45	https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/%D0%92%D0%BE%D0%B4%D0%BE%D0%BF%D0%B0%D0%B4_%D0%98%D1%81%D0%B8%D1%87%D0%B5%D0%BD%D0%BA%D0%BE._%D0%92%D0%B5%D1%81%D0%BD%D0%B0.jpg/960px-%D0%92%D0%BE%D0%B4%D0%BE%D0%BF%D0%B0%D0%B4_%D0%98%D1%81%D0%B8%D1%87%D0%B5%D0%BD%D0%BA%D0%BE._%D0%92%D0%B5%D1%81%D0%BD%D0%B0.jpg	Восток	1	2026-03-21 21:04:41.3473+00
89	46	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Калинка	0	2026-03-21 21:04:41.3473+00
227	142	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1908_38.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1908_38.pdf.jpg	Надежда	1	2026-03-21 21:06:46.247618+00
90	46	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Калинка	1	2026-03-21 21:04:41.3473+00
91	47	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Спортбар	0	2026-03-21 21:04:41.3473+00
92	47	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Спортбар	1	2026-03-21 21:04:41.3473+00
93	48	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Грац	0	2026-03-21 21:04:41.3473+00
94	48	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Грац	1	2026-03-21 21:04:41.3473+00
95	49	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Таверна у Замка	0	2026-03-21 21:04:41.3473+00
96	49	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Таверна у Замка	1	2026-03-21 21:04:41.3473+00
97	50	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Бомонд	0	2026-03-21 21:04:41.3473+00
98	50	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Бомонд	1	2026-03-21 21:04:41.3473+00
99	51	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Баден-Баден	0	2026-03-21 21:04:53.165994+00
100	51	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Баден-Баден	1	2026-03-21 21:04:53.165994+00
101	52	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Амара	0	2026-03-21 21:04:53.165994+00
102	52	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Амара	1	2026-03-21 21:04:53.165994+00
103	53	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Суши-бар "Минами"	0	2026-03-21 21:04:53.165994+00
104	53	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Суши-бар "Минами"	1	2026-03-21 21:04:53.165994+00
105	54	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Хижина рыбака	0	2026-03-21 21:04:53.165994+00
106	54	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Хижина рыбака	1	2026-03-21 21:04:53.165994+00
107	55	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	McKEY	0	2026-03-21 21:04:53.165994+00
108	55	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	McKEY	1	2026-03-21 21:04:53.165994+00
109	56	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/%D0%9C%D0%B5%D0%BC%D0%BE%D1%80%D0%B8%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9_%D0%BA%D0%BE%D0%BC%D0%BF%D0%BB%D0%B5%D0%BA%D1%81_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D1%8C_%D0%93%D0%B5%D1%80%D0%BE%D0%B5%D0%B2_%28%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0%29_%D0%9D%D0%BE%D0%B2%D0%BE%D1%80%D0%BE%D1%81%D1%81%D0%B8%D0%B9%D1%81%D0%BA.jpg/960px-%D0%9C%D0%B5%D0%BC%D0%BE%D1%80%D0%B8%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9_%D0%BA%D0%BE%D0%BC%D0%BF%D0%BB%D0%B5%D0%BA%D1%81_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D1%8C_%D0%93%D0%B5%D1%80%D0%BE%D0%B5%D0%B2_%28%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0%29_%D0%9D%D0%BE%D0%B2%D0%BE%D1%80%D0%BE%D1%81%D1%81%D0%B8%D0%B9%D1%81%D0%BA.jpg	Москва	0	2026-03-21 21:04:53.165994+00
110	56	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/%D0%AD%D0%9F20-002%2C_%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D1%8F%2C_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B9%2C_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%D0%A7%D0%B5%D0%BC%D0%B8%D1%82%D0%BE%D0%BA%D0%B2%D0%B0%D0%B4%D0%B6%D0%B5_%28Trainpix_212458%29.jpg/960px-%D0%AD%D0%9F20-002%2C_%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D1%8F%2C_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B9%2C_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%D0%A7%D0%B5%D0%BC%D0%B8%D1%82%D0%BE%D0%BA%D0%B2%D0%B0%D0%B4%D0%B6%D0%B5_%28Trainpix_212458%29.jpg	Москва	1	2026-03-21 21:04:53.165994+00
111	57	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Русское застолье	0	2026-03-21 21:04:53.165994+00
112	57	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Русское застолье	1	2026-03-21 21:04:53.165994+00
113	58	https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/%D0%9A%D1%83%D0%BB%D1%8C%D1%82%D1%83%D1%80%D0%BD%D1%8B%D0%B9_%D0%BB%D0%B0%D0%BD%D0%B4%D1%88%D0%B0%D1%84%D1%82_%D1%80%D0%B5%D0%B3%D0%B8%D0%BE%D0%BD%D0%BE%D0%B2._%D0%A2%D0%BE%D0%BC_3_%E2%84%963-4_%282021%29.pdf/page1-960px-%D0%9A%D1%83%D0%BB%D1%8C%D1%82%D1%83%D1%80%D0%BD%D1%8B%D0%B9_%D0%BB%D0%B0%D0%BD%D0%B4%D1%88%D0%B0%D1%84%D1%82_%D1%80%D0%B5%D0%B3%D0%B8%D0%BE%D0%BD%D0%BE%D0%B2._%D0%A2%D0%BE%D0%BC_3_%E2%84%963-4_%282021%29.pdf.jpg	Прибой	0	2026-03-21 21:04:53.165994+00
114	58	https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/%D0%A3%D0%BB._%D0%9A%D0%B8%D1%80%D0%BE%D0%B2%D0%B0._%D0%93%D0%BE%D1%81%D1%82%D0%B5%D0%B2%D0%BE%D0%B9_%D0%B4%D0%BE%D0%BC_%22%D0%9F%D1%80%D0%B8%D0%B1%D0%BE%D0%B9%22_-_panoramio.jpg/960px-%D0%A3%D0%BB._%D0%9A%D0%B8%D1%80%D0%BE%D0%B2%D0%B0._%D0%93%D0%BE%D1%81%D1%82%D0%B5%D0%B2%D0%BE%D0%B9_%D0%B4%D0%BE%D0%BC_%22%D0%9F%D1%80%D0%B8%D0%B1%D0%BE%D0%B9%22_-_panoramio.jpg	Прибой	1	2026-03-21 21:04:53.165994+00
115	59	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Кафе "Старая мельница"	0	2026-03-21 21:04:53.165994+00
116	59	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Кафе "Старая мельница"	1	2026-03-21 21:04:53.165994+00
283	244	https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Pn-2011-11-30-n47.pdf/page1-960px-Pn-2011-11-30-n47.pdf.jpg	Не работает	0	2026-03-21 21:07:53.175794+00
119	61	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Водолей	0	2026-03-21 21:05:06.933135+00
120	61	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Водолей	1	2026-03-21 21:05:06.933135+00
121	62	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/%D0%92%D0%B5%D1%87%D0%BD%D0%B0%D1%8F_%D0%BC%D0%B0%D0%B3%D0%BD%D0%BE%D0%BB%D0%B8%D1%8F.jpg/960px-%D0%92%D0%B5%D1%87%D0%BD%D0%B0%D1%8F_%D0%BC%D0%B0%D0%B3%D0%BD%D0%BE%D0%BB%D0%B8%D1%8F.jpg	Магнолия	0	2026-03-21 21:05:06.933135+00
122	62	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9C%D0%B0%D0%B3%D0%BD%D0%BE%D0%BB%D0%B8%D1%8F_%D0%A1%D0%BE%D1%87%D0%B83.jpg/960px-%D0%9C%D0%B0%D0%B3%D0%BD%D0%BE%D0%BB%D0%B8%D1%8F_%D0%A1%D0%BE%D1%87%D0%B83.jpg	Магнолия	1	2026-03-21 21:05:06.933135+00
123	63	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Чешское пиво	0	2026-03-21 21:05:06.933135+00
124	63	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Чешское пиво	1	2026-03-21 21:05:06.933135+00
125	64	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Золотой Якорь	0	2026-03-21 21:05:06.933135+00
126	64	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Золотой Якорь	1	2026-03-21 21:05:06.933135+00
127	65	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Кальвадос	0	2026-03-21 21:05:06.933135+00
128	65	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Кальвадос	1	2026-03-21 21:05:06.933135+00
129	66	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Пиноккио Djan	0	2026-03-21 21:05:06.933135+00
130	66	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Пиноккио Djan	1	2026-03-21 21:05:06.933135+00
131	67	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Венец	0	2026-03-21 21:05:06.933135+00
132	67	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Венец	1	2026-03-21 21:05:06.933135+00
133	68	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Пиццерия Пьеtро	0	2026-03-21 21:05:06.933135+00
134	68	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Пиццерия Пьеtро	1	2026-03-21 21:05:06.933135+00
135	69	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Экзотик	0	2026-03-21 21:05:06.933135+00
136	69	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Экзотик	1	2026-03-21 21:05:06.933135+00
137	70	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Диканька	0	2026-03-21 21:05:06.933135+00
138	70	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Диканька	1	2026-03-21 21:05:06.933135+00
139	71	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	СушиWok	0	2026-03-21 21:05:19.433504+00
140	71	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	СушиWok	1	2026-03-21 21:05:19.433504+00
141	72	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Сатин	0	2026-03-21 21:05:19.433504+00
142	72	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Сатин	1	2026-03-21 21:05:19.433504+00
143	73	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Prosushi	0	2026-03-21 21:05:19.433504+00
144	73	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Prosushi	1	2026-03-21 21:05:19.433504+00
145	74	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Восьмое небо	0	2026-03-21 21:05:19.433504+00
146	74	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Восьмое небо	1	2026-03-21 21:05:19.433504+00
147	75	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Music Hall	0	2026-03-21 21:05:19.433504+00
148	75	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Music Hall	1	2026-03-21 21:05:19.433504+00
149	76	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/%D0%92%D0%B8%D0%B4_%D1%81_%D1%83%D0%BB%D0%B8%D1%86%D1%8B_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9.webp/960px-%D0%92%D0%B8%D0%B4_%D1%81_%D1%83%D0%BB%D0%B8%D1%86%D1%8B_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9.webp.png	Мария	0	2026-03-21 21:05:19.433504+00
150	76	https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/%D0%92%D0%BD%D1%83%D1%82%D1%80%D0%B8_%D1%83%D1%81%D0%BF%D0%B5%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%85%D1%80%D0%B0%D0%BC%D0%B0.webp/960px-%D0%92%D0%BD%D1%83%D1%82%D1%80%D0%B8_%D1%83%D1%81%D0%BF%D0%B5%D0%BD%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_%D1%85%D1%80%D0%B0%D0%BC%D0%B0.webp.png	Мария	1	2026-03-21 21:05:19.433504+00
151	77	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Трофей	0	2026-03-21 21:05:19.433504+00
152	77	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Трофей	1	2026-03-21 21:05:19.433504+00
153	78	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Трикони	0	2026-03-21 21:05:19.433504+00
154	78	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Трикони	1	2026-03-21 21:05:19.433504+00
155	79	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/%D0%9A%D0%BB%D1%83%D0%B1._%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F.jpg/960px-%D0%9A%D0%BB%D1%83%D0%B1._%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F.jpg	Столовая	0	2026-03-21 21:05:19.433504+00
156	79	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F_%D1%81%D0%B0%D0%BD%D0%B0%D1%82%D0%BE%D1%80%D0%B8%D1%8F_%D0%B8%D0%BC._%D0%92%D0%BE%D1%80%D0%BE%D1%88%D0%B8%D0%BB%D0%BE%D0%B2%D0%B0.jpg/960px-%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F_%D1%81%D0%B0%D0%BD%D0%B0%D1%82%D0%BE%D1%80%D0%B8%D1%8F_%D0%B8%D0%BC._%D0%92%D0%BE%D1%80%D0%BE%D1%88%D0%B8%D0%BB%D0%BE%D0%B2%D0%B0.jpg	Столовая	1	2026-03-21 21:05:19.433504+00
157	80	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Kuvee Karsov	0	2026-03-21 21:05:19.433504+00
158	80	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Kuvee Karsov	1	2026-03-21 21:05:19.433504+00
159	81	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Банкет	0	2026-03-21 21:05:31.72665+00
160	81	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Банкет	1	2026-03-21 21:05:31.72665+00
161	82	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	La Vash	0	2026-03-21 21:05:31.72665+00
162	82	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	La Vash	1	2026-03-21 21:05:31.72665+00
346	116	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	«Куманек» (не работает)	1	2026-03-21 21:08:45.769878+00
163	83	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Астория	0	2026-03-21 21:05:31.72665+00
164	83	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Астория	1	2026-03-21 21:05:31.72665+00
165	84	https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/RMS_08-48_ashore_on_the_Quay_13_in_Port_of_Sochi_Krasnodarskiy_Kray_Sochi_1_November_2016.jpg/960px-RMS_08-48_ashore_on_the_Quay_13_in_Port_of_Sochi_Krasnodarskiy_Kray_Sochi_1_November_2016.jpg	Причал №1	0	2026-03-21 21:05:31.72665+00
166	84	https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/%D0%9F%D1%80%D0%B8%D1%87%D0%B0%D0%BB_-_panoramio_%2823%29.jpg/960px-%D0%9F%D1%80%D0%B8%D1%87%D0%B0%D0%BB_-_panoramio_%2823%29.jpg	Причал №1	1	2026-03-21 21:05:31.72665+00
167	85	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Кофемания	0	2026-03-21 21:05:31.72665+00
168	85	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Кофемания	1	2026-03-21 21:05:31.72665+00
169	86	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Флагман	0	2026-03-21 21:05:31.72665+00
170	86	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Флагман	1	2026-03-21 21:05:31.72665+00
171	87	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	кафе "Молодежное"	0	2026-03-21 21:05:31.72665+00
172	87	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	кафе "Молодежное"	1	2026-03-21 21:05:31.72665+00
173	88	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Литораль	0	2026-03-21 21:05:31.72665+00
174	88	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Литораль	1	2026-03-21 21:05:31.72665+00
175	89	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Меридиан	0	2026-03-21 21:05:31.72665+00
176	89	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Меридиан	1	2026-03-21 21:05:31.72665+00
177	90	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/%D0%A1%D0%BE%D0%BB%D0%B5%D0%BD%D0%BE%D0%B5_%D0%BE%D0%B7%D0%B5%D1%80%D0%BE_%D0%BA%D0%B0%D0%BA_%D0%BF%D0%B5%D0%BD%D0%B0.jpg/960px-%D0%A1%D0%BE%D0%BB%D0%B5%D0%BD%D0%BE%D0%B5_%D0%BE%D0%B7%D0%B5%D1%80%D0%BE_%D0%BA%D0%B0%D0%BA_%D0%BF%D0%B5%D0%BD%D0%B0.jpg	Пена	0	2026-03-21 21:05:31.72665+00
284	246	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Moscow%2C_Krasina_Street%2C_Gas_Station.JPG/960px-Moscow%2C_Krasina_Street%2C_Gas_Station.JPG	Газпромнефть	0	2026-03-21 21:07:53.175794+00
178	91	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	У Бочки	0	2026-03-21 21:05:44.705869+00
179	91	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	У Бочки	1	2026-03-21 21:05:44.705869+00
180	92	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Виола	0	2026-03-21 21:05:44.705869+00
181	92	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Виола	1	2026-03-21 21:05:44.705869+00
182	93	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	"Pesto" "Песто"	0	2026-03-21 21:05:44.705869+00
183	93	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	"Pesto" "Песто"	1	2026-03-21 21:05:44.705869+00
184	94	https://upload.wikimedia.org/wikipedia/commons/2/2c/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%BE%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%BE%D1%80%D1%8B_%D0%B1%D0%B0%D1%80%D0%BE%D0%BD%D0%B0_%D0%A8%D1%82%D0%B5%D0%B9%D0%BD%D0%B3%D0%B5%D0%BB%D1%8F._%D0%A1%D0%B5%D0%B9%D1%87%D0%B0%D1%81_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_%22%D0%9B%D0%B5%D0%B3%D0%B5%D0%BD%D0%B4%D0%B0%22.jpg	Банкет-холл "Гости"	0	2026-03-21 21:05:44.705869+00
185	94	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG/960px-%D0%9C%D0%BE%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%B2%D0%BE%D0%BA%D0%B7%D0%B0%D0%BB_%D0%B2_%D0%A1%D0%BE%D1%87%D0%B8_%28%D0%B2%D1%85%D0%BE%D0%B4_%D0%B2_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD_c_%D1%82%D0%BE%D1%80%D1%86%D0%B0_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F%29.JPG	Банкет-холл "Гости"	1	2026-03-21 21:05:44.705869+00
186	95	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg	Пингвин	0	2026-03-21 21:05:44.705869+00
187	95	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg	Пингвин	1	2026-03-21 21:05:44.705869+00
188	96	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg	Дворик	0	2026-03-21 21:05:44.705869+00
189	96	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg	Дворик	1	2026-03-21 21:05:44.705869+00
190	97	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg	Леди Мармелад	0	2026-03-21 21:05:44.705869+00
191	97	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg	Леди Мармелад	1	2026-03-21 21:05:44.705869+00
192	98	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg	Кафе "Любо"	0	2026-03-21 21:05:44.705869+00
193	98	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg	Кафе "Любо"	1	2026-03-21 21:05:44.705869+00
194	99	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg	Холостяк	0	2026-03-21 21:05:44.705869+00
195	99	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg	Холостяк	1	2026-03-21 21:05:44.705869+00
196	100	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22Sea_Zone%22_-_panoramio.jpg	The Печь	0	2026-03-21 21:05:44.705869+00
197	100	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%9A%D1%83%D1%80%D0%BE%D1%80%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D0%BB%D1%8E%D1%81%22_-_panoramio.jpg	The Печь	1	2026-03-21 21:05:44.705869+00
198	105	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/%D0%94%D0%BE%D0%BD%D1%86%D1%8B._%D0%9D%D0%BE%D0%B2%D0%BE%D1%87%D0%B5%D1%80%D0%BA%D0%B0%D1%81%D1%81%D0%BA.webp/960px-%D0%94%D0%BE%D0%BD%D1%86%D1%8B._%D0%9D%D0%BE%D0%B2%D0%BE%D1%87%D0%B5%D1%80%D0%BA%D0%B0%D1%81%D1%81%D0%BA.webp.png	Столовая	0	2026-03-21 21:06:18.883312+00
199	105	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F%2C_%D0%9A%D0%B0%D1%84%D0%B5%2C_%D0%9A%D0%BB%D0%B5%D1%86%D0%BA.jpg/960px-%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F%2C_%D0%9A%D0%B0%D1%84%D0%B5%2C_%D0%9A%D0%BB%D0%B5%D1%86%D0%BA.jpg	Столовая	1	2026-03-21 21:06:18.883312+00
200	106	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Mv-34-2024.pdf/page1-960px-Mv-34-2024.pdf.jpg	Куба	0	2026-03-21 21:06:18.883312+00
201	106	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/OJ_L_202501093_of_2025_-_BG_Bulgarian.pdf/page1-960px-OJ_L_202501093_of_2025_-_BG_Bulgarian.pdf.jpg	Куба	1	2026-03-21 21:06:18.883312+00
202	109	https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/%D0%91%D0%BE%D0%B6%D0%B8%D1%8F_%D0%BD%D0%B8%D0%B2%D0%B0._1905._%E2%84%9637.pdf/page1-927px-%D0%91%D0%BE%D0%B6%D0%B8%D1%8F_%D0%BD%D0%B8%D0%B2%D0%B0._1905._%E2%84%9637.pdf.jpg	Заря	0	2026-03-21 21:06:18.883312+00
203	109	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/%D0%9D%D0%B8%D0%BA%D0%BE%D0%BB%D0%B0%D0%B9_%D0%93%D1%83%D0%BC%D0%B8%D0%BB%D0%B5%D0%B2._%D0%9A%D0%BE%D0%BB%D1%87%D0%B0%D0%BD_%281916%29.pdf/page1-804px-%D0%9D%D0%B8%D0%BA%D0%BE%D0%BB%D0%B0%D0%B9_%D0%93%D1%83%D0%BC%D0%B8%D0%BB%D0%B5%D0%B2._%D0%9A%D0%BE%D0%BB%D1%87%D0%B0%D0%BD_%281916%29.pdf.jpg	Заря	1	2026-03-21 21:06:18.883312+00
204	110	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/%D0%94%D0%BE%D0%BD%D1%86%D1%8B._%D0%9D%D0%BE%D0%B2%D0%BE%D1%87%D0%B5%D1%80%D0%BA%D0%B0%D1%81%D1%81%D0%BA.webp/960px-%D0%94%D0%BE%D0%BD%D1%86%D1%8B._%D0%9D%D0%BE%D0%B2%D0%BE%D1%87%D0%B5%D1%80%D0%BA%D0%B0%D1%81%D1%81%D0%BA.webp.png	Столовая	0	2026-03-21 21:06:18.883312+00
205	110	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F%2C_%D0%9A%D0%B0%D1%84%D0%B5%2C_%D0%9A%D0%BB%D0%B5%D1%86%D0%BA.jpg/960px-%D0%A1%D1%82%D0%BE%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F%2C_%D0%9A%D0%B0%D1%84%D0%B5%2C_%D0%9A%D0%BB%D0%B5%D1%86%D0%BA.jpg	Столовая	1	2026-03-21 21:06:18.883312+00
206	111	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1904_21.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1904_21.pdf.jpg	Жаровня	0	2026-03-21 21:06:18.883312+00
207	112	https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%90%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D1%83%D0%BC%22_%28%D0%98%D1%81%D0%BC.%D0%90%D0%BB%D1%8C%D0%B1%D0%B5%D1%80%D1%82_%D1%82-%D1%84-85%29_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%90%D0%BA%D0%B2%D0%B0%D1%80%D0%B8%D1%83%D0%BC%22_%28%D0%98%D1%81%D0%BC.%D0%90%D0%BB%D1%8C%D0%B1%D0%B5%D1%80%D1%82_%D1%82-%D1%84-85%29_-_panoramio.jpg	Т-кафе	0	2026-03-21 21:06:18.883312+00
208	112	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/%D0%9A%D0%B0%D1%84%D0%B5_%28%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD%29_%C2%AB%D0%92%D0%B5%D1%81%D0%BD%D0%B0%C2%BB_2.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%28%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD%29_%C2%AB%D0%92%D0%B5%D1%81%D0%BD%D0%B0%C2%BB_2.jpg	Т-кафе	1	2026-03-21 21:06:18.883312+00
209	114	https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Alexander_Shchetynsky_Lviv_2016.jpg/960px-Alexander_Shchetynsky_Lviv_2016.jpg	Квартира	0	2026-03-21 21:06:18.883312+00
210	114	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Sergej_Newski_Lviv_2016_01.jpg/960px-Sergej_Newski_Lviv_2016_01.jpg	Квартира	1	2026-03-21 21:06:18.883312+00
211	115	https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/OJ_L_365_of_2021_-_BG_Bulgarian.pdf/page1-960px-OJ_L_365_of_2021_-_BG_Bulgarian.pdf.jpg	Sweet Beans	0	2026-03-21 21:06:18.883312+00
212	125	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Кубань	0	2026-03-21 21:06:32.472473+00
213	125	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Кубань	1	2026-03-21 21:06:32.472473+00
214	126	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Шашлык	0	2026-03-21 21:06:32.472473+00
215	126	https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pn-2009-07-29-n30.pdf/page1-960px-Pn-2009-07-29-n30.pdf.jpg	Шашлык	1	2026-03-21 21:06:32.472473+00
216	129	https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Kovsh_-_stikhi_%28IA_kovshstikhi00verm%29.pdf/page1-960px-Kovsh_-_stikhi_%28IA_kovshstikhi00verm%29.pdf.jpg	Мир Любви	0	2026-03-21 21:06:32.472473+00
217	129	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Pn-2009-05-06-n18.pdf/page1-960px-Pn-2009-05-06-n18.pdf.jpg	Мир Любви	1	2026-03-21 21:06:32.472473+00
218	130	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Pizza%2C_Georgian_cafe.jpg/960px-Pizza%2C_Georgian_cafe.jpg	Кафе Пицца	0	2026-03-21 21:06:32.472473+00
219	130	https://upload.wikimedia.org/wikipedia/commons/f/fb/Sluch.jpg	Кафе Пицца	1	2026-03-21 21:06:32.472473+00
220	132	https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Kavkaz_1880_N160.pdf/page1-960px-Kavkaz_1880_N160.pdf.jpg	Сенатор	0	2026-03-21 21:06:32.472473+00
221	132	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Kavkaz_1880_N325.pdf/page1-960px-Kavkaz_1880_N325.pdf.jpg	Сенатор	1	2026-03-21 21:06:32.472473+00
222	137	https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/%D0%9A%D0%B0%D1%84%D0%B5_-_%D0%B1%D0%B0%D1%80_%22_%D0%91%D0%B5%D1%80%D1%91%D0%B7%D0%BA%D0%B0_%22._%D0%A1%D1%82%D0%BE%D0%BA%D0%BE%D0%B2%D0%BE%D0%B5_%D1%84%D0%BE%D1%82%D0%BE_%E2%84%96_1.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_-_%D0%B1%D0%B0%D1%80_%22_%D0%91%D0%B5%D1%80%D1%91%D0%B7%D0%BA%D0%B0_%22._%D0%A1%D1%82%D0%BE%D0%BA%D0%BE%D0%B2%D0%BE%D0%B5_%D1%84%D0%BE%D1%82%D0%BE_%E2%84%96_1.jpg	Берёзка	0	2026-03-21 21:06:32.472473+00
223	137	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/%D0%9A%D0%B0%D1%84%D0%B5_-_%D0%B1%D0%B0%D1%80_%22_%D0%91%D0%B5%D1%80%D1%91%D0%B7%D0%BA%D0%B0_%22._%D0%A1%D1%82%D0%BE%D0%BA%D0%BE%D0%B2%D0%BE%D0%B5_%D1%84%D0%BE%D1%82%D0%BE_%E2%84%96_2.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_-_%D0%B1%D0%B0%D1%80_%22_%D0%91%D0%B5%D1%80%D1%91%D0%B7%D0%BA%D0%B0_%22._%D0%A1%D1%82%D0%BE%D0%BA%D0%BE%D0%B2%D0%BE%D0%B5_%D1%84%D0%BE%D1%82%D0%BE_%E2%84%96_2.jpg	Берёзка	1	2026-03-21 21:06:32.472473+00
224	140	https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Pn-2008-10-08-n41.pdf/page1-960px-Pn-2008-10-08-n41.pdf.jpg	Уют	0	2026-03-21 21:06:32.472473+00
225	140	https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Pn-2015-12-09-n48.pdf/page1-960px-Pn-2015-12-09-n48.pdf.jpg	Уют	1	2026-03-21 21:06:32.472473+00
228	143	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/%D0%92%D0%B8%D0%BA%D0%B8-%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%8B_%D0%B2_%D0%BA%D0%B0%D1%84%D0%B5_%D0%9B%D0%B8%D0%BD%D0%B4%D1%84%D0%BE%D1%80%D1%81_02.jpg/960px-%D0%92%D0%B8%D0%BA%D0%B8-%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%8B_%D0%B2_%D0%BA%D0%B0%D1%84%D0%B5_%D0%9B%D0%B8%D0%BD%D0%B4%D1%84%D0%BE%D1%80%D1%81_02.jpg	Встреча	0	2026-03-21 21:06:46.247618+00
229	143	https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%92%D1%81%D1%82%D1%80%D0%B5%D1%87%D0%B0%22_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%22%D0%92%D1%81%D1%82%D1%80%D0%B5%D1%87%D0%B0%22_-_panoramio.jpg	Встреча	1	2026-03-21 21:06:46.247618+00
230	144	https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/960px-A_small_cup_of_coffee.JPG	Coffee	0	2026-03-21 21:06:46.247618+00
231	144	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Palestinian_women_grinding_coffee_beans.jpg/960px-Palestinian_women_grinding_coffee_beans.jpg	Coffee	1	2026-03-21 21:06:46.247618+00
232	145	https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Pn-2011-02-09-n05.pdf/page1-960px-Pn-2011-02-09-n05.pdf.jpg	Оазис	0	2026-03-21 21:06:46.247618+00
233	145	https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Pn-2013-02-13-n06.pdf/page1-960px-Pn-2013-02-13-n06.pdf.jpg	Оазис	1	2026-03-21 21:06:46.247618+00
234	147	https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/960px-A_small_cup_of_coffee.JPG	Кафе	0	2026-03-21 21:06:46.247618+00
235	147	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/The_7_Breakfasts_-_Caf%C3%A9_Caf%C3%A9.jpg/960px-The_7_Breakfasts_-_Caf%C3%A9_Caf%C3%A9.jpg	Кафе	1	2026-03-21 21:06:46.247618+00
236	148	https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/960px-A_small_cup_of_coffee.JPG	Кафе	0	2026-03-21 21:06:46.247618+00
237	148	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/The_7_Breakfasts_-_Caf%C3%A9_Caf%C3%A9.jpg/960px-The_7_Breakfasts_-_Caf%C3%A9_Caf%C3%A9.jpg	Кафе	1	2026-03-21 21:06:46.247618+00
238	149	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/History_of_International_Women%27s_Day_in_Moscow_14.jpg/960px-History_of_International_Women%27s_Day_in_Moscow_14.jpg	Арбат	0	2026-03-21 21:06:46.247618+00
239	149	https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Ice_cream_Fortepan_89330.jpg/960px-Ice_cream_Fortepan_89330.jpg	Арбат	1	2026-03-21 21:06:46.247618+00
240	150	https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/%D0%9E%D0%B3%D0%BE%D0%BD%D0%B5%D0%BA_1940-27.pdf/page1-960px-%D0%9E%D0%B3%D0%BE%D0%BD%D0%B5%D0%BA_1940-27.pdf.jpg	Банкир	0	2026-03-21 21:06:46.247618+00
241	150	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/%D0%A1%D0%B8%D0%B1%D0%B8%D1%80%D1%81%D0%BA%D0%B0%D1%8F_%D0%B6%D0%B8%D0%B7%D0%BD%D1%8C._1913._%E2%84%96242.pdf/page1-960px-%D0%A1%D0%B8%D0%B1%D0%B8%D1%80%D1%81%D0%BA%D0%B0%D1%8F_%D0%B6%D0%B8%D0%B7%D0%BD%D1%8C._1913._%E2%84%96242.pdf.jpg	Банкир	1	2026-03-21 21:06:46.247618+00
242	151	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/%28Risunki_k_voennym_razskazam_-prilozhenie_k_Sborniku_voennykh_razskazov%29._%28IA_risunkikvoennymr00unse%29.pdf/page1-960px-%28Risunki_k_voennym_razskazam_-prilozhenie_k_Sborniku_voennykh_razskazov%29._%28IA_risunkikvoennymr00unse%29.pdf.jpg	Столовая на Роз	0	2026-03-21 21:06:46.247618+00
243	151	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/%D0%A1%D0%B0%D1%82%D0%B8%D1%80%D0%B8%D0%BA%D0%BE%D0%BD._1909._%E2%84%9606.pdf/page1-960px-%D0%A1%D0%B0%D1%82%D0%B8%D1%80%D0%B8%D0%BA%D0%BE%D0%BD._1909._%E2%84%9606.pdf.jpg	Столовая на Роз	1	2026-03-21 21:06:46.247618+00
244	152	https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/960px-A_small_cup_of_coffee.JPG	Кафе	0	2026-03-21 21:06:46.247618+00
245	152	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/The_7_Breakfasts_-_Caf%C3%A9_Caf%C3%A9.jpg/960px-The_7_Breakfasts_-_Caf%C3%A9_Caf%C3%A9.jpg	Кафе	1	2026-03-21 21:06:46.247618+00
246	154	https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Inbound4033890271391797774.jpg/960px-Inbound4033890271391797774.jpg	Маяк	0	2026-03-21 21:06:46.247618+00
247	154	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/%D0%9A%D0%B0%D1%84%D0%B5_%D0%9C%D0%B0%D1%8F%D0%BA.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5_%D0%9C%D0%B0%D1%8F%D0%BA.jpg	Маяк	1	2026-03-21 21:06:46.247618+00
248	155	https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Culture_and_life%2C_06-2020.pdf/page1-960px-Culture_and_life%2C_06-2020.pdf.jpg	ВУЛКАН	0	2026-03-21 21:06:46.247618+00
249	155	https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Culture_and_life%2C_08-2018.pdf/page1-960px-Culture_and_life%2C_08-2018.pdf.jpg	ВУЛКАН	1	2026-03-21 21:06:46.247618+00
250	156	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Nn02-2021.pdf/page1-960px-Nn02-2021.pdf.jpg	У мельника	0	2026-03-21 21:06:46.247618+00
251	156	https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Pn-2014-02-12-n05.pdf/page1-960px-Pn-2014-02-12-n05.pdf.jpg	У мельника	1	2026-03-21 21:06:46.247618+00
252	157	https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Pn-2008-12-10-n50.pdf/page1-960px-Pn-2008-12-10-n50.pdf.jpg	Родничок	0	2026-03-21 21:06:46.247618+00
253	157	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Pn-2014-11-19-n45.pdf/page1-960px-Pn-2014-11-19-n45.pdf.jpg	Родничок	1	2026-03-21 21:06:46.247618+00
254	158	https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Concession_stand_at_a_Guantanamo_threatre.jpg/960px-Concession_stand_at_a_Guantanamo_threatre.jpg	Закусочная	0	2026-03-21 21:06:46.247618+00
255	158	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Concessions_at_Nelson_W._Wolff_Municipal_Stadium.jpg/960px-Concessions_at_Nelson_W._Wolff_Municipal_Stadium.jpg	Закусочная	1	2026-03-21 21:06:46.247618+00
256	159	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/%D0%92%D0%BE%D1%81%D1%82%D0%BE%D0%BA_1867_%E2%84%9642.pdf/page1-960px-%D0%92%D0%BE%D1%81%D1%82%D0%BE%D0%BA_1867_%E2%84%9642.pdf.jpg	Восток	0	2026-03-21 21:06:46.247618+00
257	159	https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/%D0%9A%D0%B0%D1%84%D0%B5-%D0%B1%D0%B0%D1%80_%22%D0%92%D0%BE%D0%B4%D0%BE%D0%BB%D0%B5%D0%B9%22_%28%D0%B0%D0%BF%D1%80%D0%B5%D0%BB%D1%8C_2012%29_-_panoramio.jpg/960px-%D0%9A%D0%B0%D1%84%D0%B5-%D0%B1%D0%B0%D1%80_%22%D0%92%D0%BE%D0%B4%D0%BE%D0%BB%D0%B5%D0%B9%22_%28%D0%B0%D0%BF%D1%80%D0%B5%D0%BB%D1%8C_2012%29_-_panoramio.jpg	Восток	1	2026-03-21 21:06:46.247618+00
258	160	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Pn-2015-08-05-n30.pdf/page1-960px-Pn-2015-08-05-n30.pdf.jpg	Белые ночи	0	2026-03-21 21:06:46.247618+00
285	246	https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG/960px-%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG	Газпромнефть	1	2026-03-21 21:07:53.175794+00
259	160	https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/%D0%90%D0%BB%D0%B5%D0%BA%D1%81%D0%B0%D0%BD%D0%B4%D1%80_%D0%A1%D0%B5%D1%80%D0%B3%D0%B5%D0%B5%D0%B2%D0%B8%D1%87_%D0%9D%D0%B5%D0%B2%D0%B5%D1%80%D0%BE%D0%B2._%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D0%B5_%D1%81%D0%BE%D0%B1%D1%80%D0%B0%D0%BD%D0%B8%D0%B5_%D1%81%D0%BE%D1%87%D0%B8%D0%BD%D0%B5%D0%BD%D0%B8%D0%B9._%D0%A2%D0%BE%D0%BC_1._%D0%90%D0%B2%D0%B4%D0%BE%D1%82%D1%8C%D0%B8%D0%BD%D0%B0_%D0%B6%D0%B8%D0%B7%D0%BD%D1%8C_%281927%29.pdf/page1-779px-%D0%90%D0%BB%D0%B5%D0%BA%D1%81%D0%B0%D0%BD%D0%B4%D1%80_%D0%A1%D0%B5%D1%80%D0%B3%D0%B5%D0%B5%D0%B2%D0%B8%D1%87_%D0%9D%D0%B5%D0%B2%D0%B5%D1%80%D0%BE%D0%B2._%D0%9F%D0%BE%D0%BB%D0%BD%D0%BE%D0%B5_%D1%81%D0%BE%D0%B1%D1%80%D0%B0%D0%BD%D0%B8%D0%B5_%D1%81%D0%BE%D1%87%D0%B8%D0%BD%D0%B5%D0%BD%D0%B8%D0%B9._%D0%A2%D0%BE%D0%BC_1._%D0%90%D0%B2%D0%B4%D0%BE%D1%82%D1%8C%D0%B8%D0%BD%D0%B0_%D0%B6%D0%B8%D0%B7%D0%BD%D1%8C_%281927%29.pdf.jpg	Белые ночи	1	2026-03-21 21:06:46.247618+00
260	168	https://upload.wikimedia.org/wikipedia/commons/9/9f/Cat_from_roadside_cafe_in_Kadyysky_District_01.jpg	«Привал»	0	2026-03-21 21:07:00.617463+00
261	168	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Mv-34-2024.pdf/page1-960px-Mv-34-2024.pdf.jpg	«Привал»	1	2026-03-21 21:07:00.617463+00
262	172	https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Pn-2017-10-27-n46.pdf/page1-960px-Pn-2017-10-27-n46.pdf.jpg	Неро	0	2026-03-21 21:07:00.617463+00
263	172	https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/%D0%91%D0%BE%D0%B6%D0%B8%D1%8F_%D0%BD%D0%B8%D0%B2%D0%B0._1905._%E2%84%9637.pdf/page1-927px-%D0%91%D0%BE%D0%B6%D0%B8%D1%8F_%D0%BD%D0%B8%D0%B2%D0%B0._1905._%E2%84%9637.pdf.jpg	Неро	1	2026-03-21 21:07:00.617463+00
264	173	https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/%D0%9A%D0%B0%D0%BC%D0%B0%D1%80%D1%8B%D0%BD2.JPG/960px-%D0%9A%D0%B0%D0%BC%D0%B0%D1%80%D1%8B%D0%BD2.JPG	Белая Русь	0	2026-03-21 21:07:00.617463+00
265	176	https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Gesellius-Lindgren-Saarinen._%D0%9C%D1%83%D0%B7%D0%B5%D0%B9_-_%D0%B7%D0%B0%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F_%D1%83%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%AD%D0%BB%D0%B8%D0%B5%D0%BB%D1%8F_%D0%A1%D0%B0%D0%B0%D1%80%D0%B8%D0%BD%D0%B5%D0%BD%D0%B0._%D0%9A%D0%B0%D1%84%D0%B5_%D0%B8_%D1%80%D0%B5%D1%81%D1%82%D0%BE%D1%80%D0%B0%D0%BD._Photo_Victor_Belousov._-_panoramio.jpg/960px-thumbnail.jpg	Усадьба	0	2026-03-21 21:07:00.617463+00
266	176	https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/%D0%94%D0%BE%D0%BC_%D0%94%D0%B5%D0%BC%D0%B8%D0%B4%D0%BE%D0%B2%D1%8B%D1%85._%D0%9A%D0%B0%D1%84%D0%B5.jpg/960px-%D0%94%D0%BE%D0%BC_%D0%94%D0%B5%D0%BC%D0%B8%D0%B4%D0%BE%D0%B2%D1%8B%D1%85._%D0%9A%D0%B0%D1%84%D0%B5.jpg	Усадьба	1	2026-03-21 21:07:00.617463+00
267	177	https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1890_48.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1890_48.pdf.jpg	Три берёзы	0	2026-03-21 21:07:00.617463+00
268	177	https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1902_09.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1902_09.pdf.jpg	Три берёзы	1	2026-03-21 21:07:00.617463+00
269	178	https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1890_48.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1890_48.pdf.jpg	Небеса	0	2026-03-21 21:07:00.617463+00
270	178	https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1902_09.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1902_09.pdf.jpg	Небеса	1	2026-03-21 21:07:00.617463+00
271	179	https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/%D0%94%D0%B5%D0%BB%D0%BE%D0%B2%D0%BE%D0%B9_%D0%94%D0%BE%D0%BC.JPG/960px-%D0%94%D0%B5%D0%BB%D0%BE%D0%B2%D0%BE%D0%B9_%D0%94%D0%BE%D0%BC.JPG	Натали	0	2026-03-21 21:07:00.617463+00
272	179	https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1912_45.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1912_45.pdf.jpg	Натали	1	2026-03-21 21:07:00.617463+00
273	180	https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Pn-2017-09-06-n38.pdf/page1-960px-Pn-2017-09-06-n38.pdf.jpg	Лиза	0	2026-03-21 21:07:00.617463+00
274	180	https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1882_22.pdf/page1-960px-%D0%9E%D1%81%D0%BA%D0%BE%D0%BB%D0%BA%D0%B8_1882_22.pdf.jpg	Лиза	1	2026-03-21 21:07:00.617463+00
275	182	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/KV-22-2014.pdf/page1-960px-KV-22-2014.pdf.jpg	Бали	0	2026-03-21 21:07:13.776444+00
276	182	https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/%D0%9E%D1%82%D1%87%D0%B8%D0%B9_%D0%BF%D0%BE%D1%80%D1%96%D0%B3_140_%2808.2013%29.pdf/page1-960px-%D0%9E%D1%82%D1%87%D0%B8%D0%B9_%D0%BF%D0%BE%D1%80%D1%96%D0%B3_140_%2808.2013%29.pdf.jpg	Бали	1	2026-03-21 21:07:13.776444+00
277	191	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/KS-26-2017.pdf/page1-960px-KS-26-2017.pdf.jpg	Лев	0	2026-03-21 21:07:13.776444+00
278	204	https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/%D0%9A%D0%B0%D1%81%D0%BA%D0%B0%D0%B4%D0%BD%D1%8B%D0%B9_%D1%84%D0%BE%D0%BD%D1%82%D0%B0%D0%BD_%D0%B2_%D0%9F%D0%B0%D1%80%D0%BA%D0%B5_40-%D0%BB%D0%B5%D1%82%D0%B8%D1%8F_%D0%9F%D0%BE%D0%B1%D0%B5%D0%B4%D1%8B.jpg/960px-%D0%9A%D0%B0%D1%81%D0%BA%D0%B0%D0%B4%D0%BD%D1%8B%D0%B9_%D1%84%D0%BE%D0%BD%D1%82%D0%B0%D0%BD_%D0%B2_%D0%9F%D0%B0%D1%80%D0%BA%D0%B5_40-%D0%BB%D0%B5%D1%82%D0%B8%D1%8F_%D0%9F%D0%BE%D0%B1%D0%B5%D0%B4%D1%8B.jpg	Каскадный	0	2026-03-21 21:07:27.900186+00
279	213	https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/%D0%A1%D1%83%D0%B2%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B5_%D1%81%D1%82%D0%BE%D0%BB%D0%B1%D1%8B-%D0%B4%D0%BE%D1%81%D1%82%D0%BE%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%87%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D1%8C_%D0%91%D0%B0%D1%80%D0%B3%D1%83%D0%B7%D0%B8%D0%BD%D1%81%D0%BA%D0%BE%D0%B9_%D0%B4%D0%BE%D0%BB%D0%B8%D0%BD%D1%8B.jpg/960px-%D0%A1%D1%83%D0%B2%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B5_%D1%81%D1%82%D0%BE%D0%BB%D0%B1%D1%8B-%D0%B4%D0%BE%D1%81%D1%82%D0%BE%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%87%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D1%8C_%D0%91%D0%B0%D1%80%D0%B3%D1%83%D0%B7%D0%B8%D0%BD%D1%81%D0%BA%D0%BE%D0%B9_%D0%B4%D0%BE%D0%BB%D0%B8%D0%BD%D1%8B.jpg	Столбы	0	2026-03-21 21:07:27.900186+00
280	239	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg/960px-Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg	Газпром	0	2026-03-21 21:07:40.730001+00
281	241	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Moscow%2C_Krasina_Street%2C_Gas_Station.JPG/960px-Moscow%2C_Krasina_Street%2C_Gas_Station.JPG	Газпромнефть	0	2026-03-21 21:07:53.175794+00
282	241	https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG/960px-%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG	Газпромнефть	1	2026-03-21 21:07:53.175794+00
286	250	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg/960px-Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg	Газпром	0	2026-03-21 21:07:53.175794+00
287	254	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg/960px-Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg	Газпром	0	2026-03-21 21:07:53.175794+00
288	257	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Moscow%2C_Krasina_Street%2C_Gas_Station.JPG/960px-Moscow%2C_Krasina_Street%2C_Gas_Station.JPG	Газпромнефть	0	2026-03-21 21:07:53.175794+00
289	257	https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG/960px-%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG	Газпромнефть	1	2026-03-21 21:07:53.175794+00
290	262	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg/960px-Bishkek_03-2016_img21_Akhunbaev_Street_petrol_station.jpg	Petrol	0	2026-03-21 21:08:03.985627+00
291	262	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Nam_Kwong_Filling_Station.JPG/960px-Nam_Kwong_Filling_Station.JPG	Petrol	1	2026-03-21 21:08:03.985627+00
292	265	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Moscow%2C_Krasina_Street%2C_Gas_Station.JPG/960px-Moscow%2C_Krasina_Street%2C_Gas_Station.JPG	Газпромнефть	0	2026-03-21 21:08:03.985627+00
293	265	https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG/960px-%D0%9A%D0%B0%D0%B7%D0%B0%D0%BD%D1%8C._%D0%90%D0%B2%D1%82%D0%BE%D0%B7%D0%B0%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B0%D1%8F_%D1%81%D1%82%D0%B0%D0%BD%D1%86%D0%B8%D1%8F_%C2%AB%D0%93%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC%D0%BD%D0%B5%D1%84%D1%82%D1%8C%C2%BB_-_%D1%83%D0%BB%D0%B8%D1%86%D0%B0_%D0%9C%D0%B8%D0%BD%D1%81%D0%BA%D0%B0%D1%8F%2C_1%D0%90_%281%29.JPG	Газпромнефть	1	2026-03-21 21:08:03.985627+00
294	330	https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Postcards_signed_Sara%2C_Cannes%2C_to_%28Ernst_Filsinger%29%2C_October_9%2C_1924_-_DPLA_-_27de99c61906750301cfc5cef77d54db_%28page_13%29.jpg/960px-Postcards_signed_Sara%2C_Cannes%2C_to_%28Ernst_Filsinger%29%2C_October_9%2C_1924_-_DPLA_-_27de99c61906750301cfc5cef77d54db_%28page_13%29.jpg	Пансионат "Лазурный берег"	0	2026-03-21 21:08:03.985627+00
295	330	https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Postcards_signed_Sara%2C_Cannes%2C_to_%28Ernst_Filsinger%29%2C_October_9%2C_1924_-_DPLA_-_27de99c61906750301cfc5cef77d54db_%28page_3%29.jpg/960px-Postcards_signed_Sara%2C_Cannes%2C_to_%28Ernst_Filsinger%29%2C_October_9%2C_1924_-_DPLA_-_27de99c61906750301cfc5cef77d54db_%28page_3%29.jpg	Пансионат "Лазурный берег"	1	2026-03-21 21:08:03.985627+00
296	274	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/%D0%92%D0%B8%D0%B4_%D0%BD%D0%B0_%D0%98%D1%81%D1%82%D0%BE%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%B2_%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D1%83_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D0%B8.jpg/960px-%D0%92%D0%B8%D0%B4_%D0%BD%D0%B0_%D0%98%D1%81%D1%82%D0%BE%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%B2_%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D1%83_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D0%B8.jpg	Музей	0	2026-03-21 21:08:03.985627+00
297	274	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/%D0%9C%D0%BE%D0%BD%D0%B0%D1%81%D1%82%D0%B8%D1%80%D0%B8%D1%89%D0%B5._%D0%9C%D1%83%D0%B7%D0%B5%D0%B9.jpg/960px-%D0%9C%D0%BE%D0%BD%D0%B0%D1%81%D1%82%D0%B8%D1%80%D0%B8%D1%89%D0%B5._%D0%9C%D1%83%D0%B7%D0%B5%D0%B9.jpg	Музей	1	2026-03-21 21:08:03.985627+00
298	275	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Museum_of_Sochi_resort_city_History.jpg/960px-Museum_of_Sochi_resort_city_History.jpg	Музей истории Сочи	0	2026-03-21 21:08:03.985627+00
299	275	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/%D0%9C%D1%83%D0%B7%D0%B5%D0%B9_%D1%81%D0%BF%D0%BE%D1%80%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B9_%D1%81%D0%BB%D0%B0%D0%B2%D1%8B_%D0%A1%D0%BE%D1%87%D0%B8_01.jpg/960px-%D0%9C%D1%83%D0%B7%D0%B5%D0%B9_%D1%81%D0%BF%D0%BE%D1%80%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B9_%D1%81%D0%BB%D0%B0%D0%B2%D1%8B_%D0%A1%D0%BE%D1%87%D0%B8_01.jpg	Музей истории Сочи	1	2026-03-21 21:08:03.985627+00
300	276	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/%D0%92%D0%B8%D0%B4_%D0%BD%D0%B0_%D0%98%D1%81%D1%82%D0%BE%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%B2_%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D1%83_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D0%B8.jpg/960px-%D0%92%D0%B8%D0%B4_%D0%BD%D0%B0_%D0%98%D1%81%D1%82%D0%BE%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%B2_%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D1%83_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9_%D0%BF%D0%BB%D0%BE%D1%89%D0%B0%D0%B4%D0%B8.jpg	Музей	0	2026-03-21 21:08:03.985627+00
301	276	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/%D0%9C%D0%BE%D0%BD%D0%B0%D1%81%D1%82%D0%B8%D1%80%D0%B8%D1%89%D0%B5._%D0%9C%D1%83%D0%B7%D0%B5%D0%B9.jpg/960px-%D0%9C%D0%BE%D0%BD%D0%B0%D1%81%D1%82%D0%B8%D1%80%D0%B8%D1%89%D0%B5._%D0%9C%D1%83%D0%B7%D0%B5%D0%B9.jpg	Музей	1	2026-03-21 21:08:03.985627+00
302	277	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/%D0%90%D1%80%D1%85%D0%B5%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.jpg/960px-%D0%90%D1%80%D1%85%D0%B5%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.jpg	Археологический музей	0	2026-03-21 21:08:03.985627+00
303	277	https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D1%8B%D0%B9_%D0%B8%D1%81%D1%82%D0%BE%D1%80%D0%B8%D0%BA%D0%BE-%D0%B0%D1%80%D1%85%D0%B5%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_2023-02-02.jpg/960px-%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D1%8B%D0%B9_%D0%B8%D1%81%D1%82%D0%BE%D1%80%D0%B8%D0%BA%D0%BE-%D0%B0%D1%80%D1%85%D0%B5%D0%BE%D0%BB%D0%BE%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_2023-02-02.jpg	Археологический музей	1	2026-03-21 21:08:03.985627+00
344	113	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Жар-пицца	1	2026-03-21 21:08:45.769878+00
304	278	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/%D0%94%D0%BE%D0%BC-%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%9C.%D0%AE._%D0%9B%D0%B5%D1%80%D0%BC%D0%BE%D0%BD%D1%82%D0%BE%D0%B2%D0%B0.jpg/960px-%D0%94%D0%BE%D0%BC-%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%9C.%D0%AE._%D0%9B%D0%B5%D1%80%D0%BC%D0%BE%D0%BD%D1%82%D0%BE%D0%B2%D0%B0.jpg	Дом-музей М.Ю. Лермонтова	0	2026-03-21 21:08:03.985627+00
305	278	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/%D0%94%D0%BE%D0%BC-%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%9C.%D0%AE._%D0%9B%D0%B5%D1%80%D0%BC%D0%BE%D0%BD%D1%82%D0%BE%D0%B2%D0%B0_01.jpg/960px-%D0%94%D0%BE%D0%BC-%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%9C.%D0%AE._%D0%9B%D0%B5%D1%80%D0%BC%D0%BE%D0%BD%D1%82%D0%BE%D0%B2%D0%B0_01.jpg	Дом-музей М.Ю. Лермонтова	1	2026-03-21 21:08:03.985627+00
306	279	https://upload.wikimedia.org/wikipedia/commons/2/26/%D0%91%D0%B8%D0%BB%D0%B5%D1%82_%D0%B2_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%B8%D1%81%D1%82%D0%BE%D1%80%D0%B8_%D0%BE%D0%B1%D0%BE%D1%80%D0%BE%D0%BD%D1%8B_%D0%90%D0%B4%D0%B6%D0%B8%D0%BC%D1%83%D1%88%D0%BA%D0%B0%D0%B9%D1%81%D0%BA%D0%B8%D1%85_%D0%BA%D0%B0%D0%BC%D0%B5%D0%BD%D0%BE%D0%BB%D0%BE%D0%BC%D0%B5%D0%BD.jpg	Музей обороны Аджимушкайских каменоломен	0	2026-03-21 21:08:03.985627+00
307	280	https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/%D0%A2%D0%B8%D0%BC%D0%B0%D1%88%D0%B5%D0%B2%D1%81%D0%BA_0277.jpg/960px-%D0%A2%D0%B8%D0%BC%D0%B0%D1%88%D0%B5%D0%B2%D1%81%D0%BA_0277.jpg	Музей семьи Степановых	0	2026-03-21 21:08:18.024242+00
308	281	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Kuban-ukraina_vyp_2_2007_ocr.pdf/page1-806px-Kuban-ukraina_vyp_2_2007_ocr.pdf.jpg	Дом-музей В. Г. Короленко	0	2026-03-21 21:08:18.024242+00
309	281	https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Summer_house_of_V_G_Korolenko.jpg/960px-Summer_house_of_V_G_Korolenko.jpg	Дом-музей В. Г. Короленко	1	2026-03-21 21:08:18.024242+00
310	282	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg/960px-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg	Краеведческий музей	0	2026-03-21 21:08:18.024242+00
311	282	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg/960px-%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg	Краеведческий музей	1	2026-03-21 21:08:18.024242+00
312	283	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/089_%D0%AD%D1%82%D0%BD%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.JPG/960px-089_%D0%AD%D1%82%D0%BD%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.JPG	сельский музей	0	2026-03-21 21:08:18.024242+00
313	283	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/091_%D0%AD%D1%82%D0%BD%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.JPG/960px-091_%D0%AD%D1%82%D0%BD%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.JPG	сельский музей	1	2026-03-21 21:08:18.024242+00
314	284	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg/960px-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg	Краеведческий музей	0	2026-03-21 21:08:18.024242+00
315	284	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg/960px-%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg	Краеведческий музей	1	2026-03-21 21:08:18.024242+00
316	285	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg/960px-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg	Краеведческий музей	0	2026-03-21 21:08:18.024242+00
317	285	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg/960px-%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg	Краеведческий музей	1	2026-03-21 21:08:18.024242+00
318	286	https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/EH1211481_National_Maritime_Museum_10_%28cropped%29.JPG/960px-EH1211481_National_Maritime_Museum_10_%28cropped%29.JPG	Морской музей	0	2026-03-21 21:08:18.024242+00
319	286	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/EH1211481_National_Maritime_Museum_17.JPG/960px-EH1211481_National_Maritime_Museum_17.JPG	Морской музей	1	2026-03-21 21:08:18.024242+00
320	287	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg/960px-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg	Краеведческий музей	0	2026-03-21 21:08:18.024242+00
321	287	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg/960px-%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg	Краеведческий музей	1	2026-03-21 21:08:18.024242+00
322	288	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg/960px-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg	Краеведческий музей	0	2026-03-21 21:08:18.024242+00
345	116	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	«Куманек» (не работает)	0	2026-03-21 21:08:45.769878+00
323	288	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg/960px-%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg	Краеведческий музей	1	2026-03-21 21:08:18.024242+00
324	289	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/%D0%91%D0%B0%D0%BB%D0%B0%D1%88%D0%B8%D1%85%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%B8%D1%81%D1%82%D0%BE%D1%80%D0%B8%D0%BA%D0%BE-%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.jpg/960px-%D0%91%D0%B0%D0%BB%D0%B0%D1%88%D0%B8%D1%85%D0%B8%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%B8%D1%81%D1%82%D0%BE%D1%80%D0%B8%D0%BA%D0%BE-%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9.jpg	Историко-краеведческий музей	0	2026-03-21 21:08:18.024242+00
325	289	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/%D0%92%D0%B5%D1%80%D1%85%D0%BD%D0%B5%D1%82%D0%B0%D0%B3%D0%B8%D0%BB%D1%8C%D1%81%D0%BA%D0%B8%D0%B9_%D0%98%D1%81%D1%82%D0%BE%D1%80%D0%B8%D0%BA%D0%BE-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%9C%D1%83%D0%B7%D0%B5%D0%B9.jpg/960px-%D0%92%D0%B5%D1%80%D1%85%D0%BD%D0%B5%D1%82%D0%B0%D0%B3%D0%B8%D0%BB%D1%8C%D1%81%D0%BA%D0%B8%D0%B9_%D0%98%D1%81%D1%82%D0%BE%D1%80%D0%B8%D0%BA%D0%BE-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%9C%D1%83%D0%B7%D0%B5%D0%B9.jpg	Историко-краеведческий музей	1	2026-03-21 21:08:18.024242+00
326	290	https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg/960px-%D0%9A%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_%D0%A1%D1%83%D1%80%D0%B3%D1%83%D1%82%D0%B0.jpg	Краеведческий музей	0	2026-03-21 21:08:18.024242+00
327	290	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg/960px-%D0%A1%D1%83%D0%B7%D1%83%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%BA%D1%80%D0%B0%D0%B5%D0%B2%D0%B5%D0%B4%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D0%BC%D1%83%D0%B7%D0%B5%D0%B9_27.jpg	Краеведческий музей	1	2026-03-21 21:08:18.024242+00
328	291	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Museo_Maffeiano_%28Verona%29.jpg/960px-Museo_Maffeiano_%28Verona%29.jpg	Лапидарий	0	2026-03-21 21:08:18.024242+00
329	291	https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Museo_lapidario_maffeiano_-_Wikigita_Verona_22-09-2018_f04.jpg/960px-Museo_lapidario_maffeiano_-_Wikigita_Verona_22-09-2018_f04.jpg	Лапидарий	1	2026-03-21 21:08:18.024242+00
330	295	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Pn-2012-08-29-n34.pdf/page1-960px-Pn-2012-08-29-n34.pdf.jpg	Выставка изделий из стекла	0	2026-03-21 21:08:18.024242+00
331	101	https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D1%81%D0%BA%D0%B5%D1%82%D0%B8%D0%BD%D0%B3-%D1%80%D0%B8%D0%BD%D0%BA%D0%B0_%D0%B8_%D1%8D%D0%BB%D0%B5%D0%BA%D1%82%D1%80%D0%BE%D0%B1%D0%B8%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B0_%C2%AB%D0%9C%D0%BE%D0%BD_%D0%9F%D0%BB%D0%B5%D0%B7%D0%B8%D1%80%C2%BB._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80_01.jpg/960px-%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D1%81%D0%BA%D0%B5%D1%82%D0%B8%D0%BD%D0%B3-%D1%80%D0%B8%D0%BD%D0%BA%D0%B0_%D0%B8_%D1%8D%D0%BB%D0%B5%D0%BA%D1%82%D1%80%D0%BE%D0%B1%D0%B8%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B0_%C2%AB%D0%9C%D0%BE%D0%BD_%D0%9F%D0%BB%D0%B5%D0%B7%D0%B8%D1%80%C2%BB._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80_01.jpg	Плезир	0	2026-03-21 21:08:45.769878+00
332	101	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D1%81%D0%BA%D0%B5%D1%82%D0%B8%D0%BD%D0%B3-%D1%80%D0%B8%D0%BD%D0%BA%D0%B0_%D0%B8_%D1%8D%D0%BB%D0%B5%D0%BA%D1%82%D1%80%D0%BE%D0%B1%D0%B8%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B0_%C2%AB%D0%9C%D0%BE%D0%BD_%D0%9F%D0%BB%D0%B5%D0%B7%D0%B8%D1%80%C2%BB._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80_02.jpg/960px-%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D1%81%D0%BA%D0%B5%D1%82%D0%B8%D0%BD%D0%B3-%D1%80%D0%B8%D0%BD%D0%BA%D0%B0_%D0%B8_%D1%8D%D0%BB%D0%B5%D0%BA%D1%82%D1%80%D0%BE%D0%B1%D0%B8%D0%BE%D0%B3%D1%80%D0%B0%D1%84%D0%B0_%C2%AB%D0%9C%D0%BE%D0%BD_%D0%9F%D0%BB%D0%B5%D0%B7%D0%B8%D1%80%C2%BB._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80_02.jpg	Плезир	1	2026-03-21 21:08:45.769878+00
333	102	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Холостядзе	0	2026-03-21 21:08:45.769878+00
334	102	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Холостядзе	1	2026-03-21 21:08:45.769878+00
335	103	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Любо Кондитерская	0	2026-03-21 21:08:45.769878+00
336	103	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Любо Кондитерская	1	2026-03-21 21:08:45.769878+00
337	104	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Мэни Пельмени	0	2026-03-21 21:08:45.769878+00
338	104	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Мэни Пельмени	1	2026-03-21 21:08:45.769878+00
339	107	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Уни Пицца	0	2026-03-21 21:08:45.769878+00
340	107	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Уни Пицца	1	2026-03-21 21:08:45.769878+00
341	108	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Уни пицца	0	2026-03-21 21:08:45.769878+00
342	108	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Уни пицца	1	2026-03-21 21:08:45.769878+00
343	113	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Жар-пицца	0	2026-03-21 21:08:45.769878+00
347	117	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Don Cappuccino	0	2026-03-21 21:08:45.769878+00
348	117	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Don Cappuccino	1	2026-03-21 21:08:45.769878+00
349	118	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Патрик & Мари	0	2026-03-21 21:08:45.769878+00
350	118	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Патрик & Мари	1	2026-03-21 21:08:45.769878+00
351	119	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Пиццерия "Сатурн"	0	2026-03-21 21:08:45.769878+00
352	119	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Пиццерия "Сатурн"	1	2026-03-21 21:08:45.769878+00
353	120	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Корсар	0	2026-03-21 21:08:45.769878+00
354	120	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Корсар	1	2026-03-21 21:08:45.769878+00
355	121	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Сгущёнка	0	2026-03-21 21:08:45.769878+00
356	121	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Сгущёнка	1	2026-03-21 21:08:45.769878+00
357	122	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Пицца-Лав	0	2026-03-21 21:08:45.769878+00
358	122	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Пицца-Лав	1	2026-03-21 21:08:45.769878+00
359	123	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Saloon Western	0	2026-03-21 21:08:45.769878+00
360	123	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Saloon Western	1	2026-03-21 21:08:45.769878+00
361	124	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Эдем	0	2026-03-21 21:08:45.769878+00
362	124	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Эдем	1	2026-03-21 21:08:45.769878+00
363	127	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	барракуда	0	2026-03-21 21:08:45.769878+00
364	127	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	барракуда	1	2026-03-21 21:08:45.769878+00
365	128	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Off-Road Кафе	0	2026-03-21 21:08:45.769878+00
366	128	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Off-Road Кафе	1	2026-03-21 21:08:45.769878+00
367	131	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Жар-Пицца	0	2026-03-21 21:08:45.769878+00
368	131	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Жар-Пицца	1	2026-03-21 21:08:45.769878+00
369	133	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	5 Авеню	0	2026-03-21 21:08:45.769878+00
370	133	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	5 Авеню	1	2026-03-21 21:08:45.769878+00
371	134	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	У Джафара	0	2026-03-21 21:09:08.572712+00
372	134	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	У Джафара	1	2026-03-21 21:09:08.572712+00
373	135	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Хычины	0	2026-03-21 21:09:08.572712+00
374	135	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Хычины	1	2026-03-21 21:09:08.572712+00
375	136	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Пицерия "Сеньора"	0	2026-03-21 21:09:08.572712+00
376	136	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Пицерия "Сеньора"	1	2026-03-21 21:09:08.572712+00
377	138	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Сармат	0	2026-03-21 21:09:08.572712+00
378	138	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Сармат	1	2026-03-21 21:09:08.572712+00
379	139	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Zohan bar	0	2026-03-21 21:09:08.572712+00
380	139	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Zohan bar	1	2026-03-21 21:09:08.572712+00
381	141	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Слоёнка	0	2026-03-21 21:09:08.572712+00
382	141	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Слоёнка	1	2026-03-21 21:09:08.572712+00
383	146	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	«Пирожковое»	0	2026-03-21 21:09:08.572712+00
384	146	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	«Пирожковое»	1	2026-03-21 21:09:08.572712+00
385	153	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Pankiss	0	2026-03-21 21:09:08.572712+00
386	153	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Pankiss	1	2026-03-21 21:09:08.572712+00
387	161	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Чёрный жемчуг	0	2026-03-21 21:09:08.572712+00
388	161	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Чёрный жемчуг	1	2026-03-21 21:09:08.572712+00
389	162	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Калифорния	0	2026-03-21 21:09:08.572712+00
390	162	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Калифорния	1	2026-03-21 21:09:08.572712+00
391	163	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Бабаева	0	2026-03-21 21:09:08.572712+00
392	163	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Бабаева	1	2026-03-21 21:09:08.572712+00
393	164	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Эдем	0	2026-03-21 21:09:08.572712+00
394	164	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Эдем	1	2026-03-21 21:09:08.572712+00
395	165	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Seafood market	0	2026-03-21 21:09:08.572712+00
396	165	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Seafood market	1	2026-03-21 21:09:08.572712+00
397	166	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Молодежное	0	2026-03-21 21:09:08.572712+00
398	166	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Молодежное	1	2026-03-21 21:09:08.572712+00
399	167	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Вкусноежка	0	2026-03-21 21:09:08.572712+00
400	167	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Вкусноежка	1	2026-03-21 21:09:08.572712+00
401	169	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Синьор Помидор	0	2026-03-21 21:09:08.572712+00
402	169	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Синьор Помидор	1	2026-03-21 21:09:08.572712+00
403	170	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Золотое руно	0	2026-03-21 21:09:08.572712+00
404	170	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Золотое руно	1	2026-03-21 21:09:08.572712+00
405	171	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Шанталь	0	2026-03-21 21:09:08.572712+00
406	171	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Шанталь	1	2026-03-21 21:09:08.572712+00
407	174	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Курьер	0	2026-03-21 21:09:08.572712+00
408	174	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Курьер	1	2026-03-21 21:09:08.572712+00
409	175	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Тихий омут	0	2026-03-21 21:09:08.572712+00
410	175	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Тихий омут	1	2026-03-21 21:09:08.572712+00
411	181	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	У трех берез	0	2026-03-21 21:09:32.642617+00
412	181	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	У трех берез	1	2026-03-21 21:09:32.642617+00
413	183	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Палуба Ресторан	0	2026-03-21 21:09:32.642617+00
414	183	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Палуба Ресторан	1	2026-03-21 21:09:32.642617+00
415	184	https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG/960px-Karachayevsk%2C_Republic_of_Karachayevo-Cherkessya%2C_Caucasus%2C_Russia._Shashlik_maker_near_Kuban_river..JPG	Mocco	0	2026-03-21 21:09:32.642617+00
416	184	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nn03-2016.pdf/page1-960px-Nn03-2016.pdf.jpg	Mocco	1	2026-03-21 21:09:32.642617+00
417	185	https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/%D0%A6%D0%B2%D0%B5%D1%82%D0%BE%D1%87%D0%BD%D1%8B%D0%B5_%D1%87%D0%B0%D1%81%D1%8B_%D0%B2_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D0%B5_%2801%29.jpg/960px-%D0%A6%D0%B2%D0%B5%D1%82%D0%BE%D1%87%D0%BD%D1%8B%D0%B5_%D1%87%D0%B0%D1%81%D1%8B_%D0%B2_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D0%B5_%2801%29.jpg	Цветочные часы	0	2026-03-21 21:09:32.642617+00
418	185	https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/%D0%A6%D0%B2%D0%B5%D1%82%D0%BE%D1%87%D0%BD%D1%8B%D0%B5_%D1%87%D0%B0%D1%81%D1%8B_%D0%B2_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D0%B5_%2802%29.jpg/960px-%D0%A6%D0%B2%D0%B5%D1%82%D0%BE%D1%87%D0%BD%D1%8B%D0%B5_%D1%87%D0%B0%D1%81%D1%8B_%D0%B2_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80%D0%B5_%2802%29.jpg	Цветочные часы	1	2026-03-21 21:09:32.642617+00
419	193	https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/%D0%A0%D0%B5%D0%B0%D0%BA%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B5_%D0%BE%D1%80%D1%83%D0%B4%D0%B8%D0%B5_%D0%9A%D0%B0%D1%82%D1%8E%D1%88%D0%B0%2C_%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B5_%D0%B2_%D1%87%D0%B5%D1%81%D1%82%D1%8C_%D0%B3%D0%B2%D0%B0%D1%80%D0%B4%D0%B5%D0%B9%D1%86%D0%B5%D0%B2-%D0%BC%D0%B8%D0%BD%D0%BE%D0%BC%D0%B5%D1%82%D1%87%D0%B8%D0%BA%D0%BE%D0%B2._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80_01.jpg/960px-thumbnail.jpg	Катюша	0	2026-03-21 21:09:32.642617+00
420	193	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/%D0%A0%D0%B5%D0%B0%D0%BA%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B5_%D0%BE%D1%80%D1%83%D0%B4%D0%B8%D0%B5_%D0%9A%D0%B0%D1%82%D1%8E%D1%88%D0%B0%2C_%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B5_%D0%B2_%D1%87%D0%B5%D1%81%D1%82%D1%8C_%D0%B3%D0%B2%D0%B0%D1%80%D0%B4%D0%B5%D0%B9%D1%86%D0%B5%D0%B2-%D0%BC%D0%B8%D0%BD%D0%BE%D0%BC%D0%B5%D1%82%D1%87%D0%B8%D0%BA%D0%BE%D0%B2._%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B4%D0%B0%D1%80_02.jpg/960px-thumbnail.jpg	Катюша	1	2026-03-21 21:09:32.642617+00
421	196	https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/%D0%9F%D0%B0%D0%BC%D1%8F%D1%82%D0%BD%D0%B8%D0%BA_%D1%83%D1%87%D0%B0%D1%81%D1%82%D0%BD%D0%B8%D0%BA%D0%B0%D0%BC_%D0%BF%D0%BE%D1%85%D0%BE%D0%B4%D0%B0_%D0%A2%D0%B0%D0%BC%D0%B0%D0%BD%D1%81%D0%BA%D0%BE%D0%B9_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9_%D0%90%D1%80%D0%BC%D0%B8%D0%B8._%D0%90%D0%BA%D1%82_%D1%8D%D0%BA%D1%81%D0%BF%D0%B5%D1%80%D1%82%D0%B8%D0%B7%D1%8B.pdf/page1-960px-%D0%9F%D0%B0%D0%BC%D1%8F%D1%82%D0%BD%D0%B8%D0%BA_%D1%83%D1%87%D0%B0%D1%81%D1%82%D0%BD%D0%B8%D0%BA%D0%B0%D0%BC_%D0%BF%D0%BE%D1%85%D0%BE%D0%B4%D0%B0_%D0%A2%D0%B0%D0%BC%D0%B0%D0%BD%D1%81%D0%BA%D0%BE%D0%B9_%D0%9A%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B9_%D0%90%D1%80%D0%BC%D0%B8%D0%B8._%D0%90%D0%BA%D1%82_%D1%8D%D0%BA%D1%81%D0%BF%D0%B5%D1%80%D1%82%D0%B8%D0%B7%D1%8B.pdf.jpg	Чаша	0	2026-03-21 21:09:32.642617+00
422	202	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/%D0%9A%D0%B0%D1%82%D0%B0%D0%BB%D0%BE%D0%B3_%D0%BA%D0%BD%D0%B8%D0%B6%D0%BE%D0%BA_%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B3%D0%BE_%D0%BF%D0%B8%D1%81%D1%8C%D0%BC%D0%B5%D0%BD%D1%81%D1%82%D0%B2%D0%B0._1926.pdf/page1-829px-%D0%9A%D0%B0%D1%82%D0%B0%D0%BB%D0%BE%D0%B3_%D0%BA%D0%BD%D0%B8%D0%B6%D0%BE%D0%BA_%D0%BA%D1%80%D0%B0%D1%81%D0%BD%D0%BE%D0%B3%D0%BE_%D0%BF%D0%B8%D1%81%D1%8C%D0%BC%D0%B5%D0%BD%D1%81%D1%82%D0%B2%D0%B0._1926.pdf.jpg	Шум	0	2026-03-21 21:09:32.642617+00
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
1	1	Через перевал Аишха к Черному морю	hiking	\N	\N	1	\N	fresh	0	0	0	osm-1474673	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
2	1	Дорога к зоне	hiking	\N	\N	1	\N	fresh	0	0	0	osm-1842873	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
3	1	Тропа к водопаду	hiking	\N	\N	1	\N	fresh	0	0	0	osm-1842953	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
4	1	Тропа к водопаду	hiking	\N	\N	1	\N	fresh	0	0	0	osm-1842954	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
5	1	Малое кольцо	hiking	\N	\N	1	\N	fresh	0	0	0	osm-3748147	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
6	1	Большое кольцо	hiking	\N	\N	1	\N	fresh	0	0	0	osm-3748250	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
7	1	30-ка	hiking, 93 km	\N	\N	1	\N	fresh	0	0	0	osm-4509282	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
8	1	Через Фишт-Оштеновский перевал	hiking	\N	\N	1	\N	fresh	0	0	0	osm-4509283	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
9	1	Через водопадный	hiking	\N	\N	1	\N	fresh	0	0	0	osm-4509285	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
10	1	каньон	foot	\N	\N	1	\N	fresh	0	0	0	osm-7400123	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
11	1	Тропа здоровья Малое кольцо	foot	\N	\N	1	\N	fresh	0	0	0	osm-9403239	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
12	1	Тропа здоровья Большое и среднее кольцо	foot	\N	\N	1	\N	fresh	0	0	0	osm-9403246	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
13	1	водопад Кейву	hiking	\N	\N	1	\N	fresh	0	0	0	osm-10626407	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
14	1	Тропа здоровья	foot	\N	\N	1	\N	fresh	0	0	0	osm-10928641	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
15	1	Урочище Медвежьи ворота – Бзерпинский карниз - Лагерь Холодный	hiking	\N	\N	1	\N	fresh	0	0	0	osm-11566519	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
16	1	Реликтовый лес	hiking	\N	\N	1	\N	fresh	0	0	0	osm-11681960	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
17	1	Каверзинские водопады	hiking	\N	\N	1	\N	fresh	0	0	0	osm-12328003	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
18	1	Индюк тропа.	hiking	\N	\N	1	\N	fresh	0	0	0	osm-12350723	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
19	1	Дантово ущелье - гора Сапун	hiking	\N	\N	1	\N	fresh	0	0	0	osm-12404970	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
20	1	Вододопады на Мальцевом ручье	hiking	\N	\N	1	\N	fresh	0	0	0	osm-12404988	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
21	1	Тропа здоровья	hiking	\N	\N	1	\N	fresh	0	0	0	osm-12406143	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
22	1	Бор-дол	hiking	\N	\N	1	\N	fresh	0	0	0	osm-13014211	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
23	1	тропа	hiking	\N	\N	1	\N	fresh	0	0	0	osm-13014212	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
24	1	Харгинский лес	hiking	\N	\N	1	\N	fresh	0	0	0	osm-13021062	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
25	1	Водопад Поликаря	hiking	\N	\N	1	\N	fresh	0	0	0	osm-13025082	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
26	1	Тропа здоровья	hiking	\N	\N	1	\N	fresh	0	0	0	osm-13030392	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
27	1	Путь к водопадам	foot, 7.1 km	\N	\N	1	\N	fresh	0	0	0	osm-13232467	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
28	1	Каменный столб	foot, 4.4 km	\N	\N	1	\N	fresh	0	0	0	osm-13232468	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
29	1	Юрьев Хутор	hiking	\N	\N	1	\N	fresh	0	0	0	osm-13232469	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
30	1	Озёрный траверс	foot, 6.7 km	\N	\N	1	\N	fresh	0	0	0	osm-13232470	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
31	1	10 памятников ВОВ	hiking, 12.3 km	\N	\N	1	\N	fresh	0	0	0	osm-14270035	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
32	1	к Купели	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376203	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
33	1	К Ачипсинским водопадам	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376257	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
34	1	Черничная тропа	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376382	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
35	1	Альпийские луга	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376417	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
36	1	Два водопада	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376574	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
37	1	Черная пирамида	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376588	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
38	1	Перевал Седой	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376599	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
39	1	Перевал Аибга	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376615	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
40	1	Два Озера	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376633	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
41	1	Беседка любви	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376657	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
42	1	От снежников к Водопадам "Менделиха"	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376701	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
43	1	Урочище Энгельмановы поляны – озеро Кардывач	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14376817	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
44	1	Воопад Хрустальный	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14378644	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
45	1	Хмелевские озера + 2 смотровых площадки	hiking	\N	\N	1	\N	fresh	0	0	0	osm-14378669	\N	ready	2026-03-21 20:58:39.442378+00	2026-03-21 20:58:39.442378+00
46	1	Ресторан + Кафе + Автозаправочная станция near Ресторан	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-2	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
47	1	Ресторан + Автозаправочная станция + Гостиница near Старина Герман	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-3	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
48	1	Ресторан + Кафе + Автозаправочная станция near Пенальти	4 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-5	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
49	1	Ресторан + Кафе near Сербский ресторан	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-6	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
50	1	Ресторан + Кафе + Гостиница near Пивница	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-7	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
51	1	Ресторан + Гостиница near Версаль	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-8	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
52	1	Ресторан + Кафе near Мадьяр	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-10	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
53	1	Ресторан + Достопримечательность + Гостиница near Казачок	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-12	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
54	1	Ресторан + Кафе near Кафе молодежное	3 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-13	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
55	1	Ресторан + Кафе near Big Bull	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-14	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
56	1	Ресторан + Кафе near Променад	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-15	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
57	1	Ресторан + Музей + Кафе near Оливье	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-17	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
58	1	Ресторан + Гостиница near Федина дача	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-18	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
59	1	Ресторан + Кафе near Катюша	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-20	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
60	1	Ресторан + Гостиница + Кафе near «Ё-Моё»	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-21	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
61	1	Ресторан + Кафе near Amsterdam Bar	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-22	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
62	1	Ресторан + Кафе near Прохлада	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-26	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
63	1	Ресторан + Кафе near Аурум	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-27	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
64	1	Ресторан + Гостиница + Кафе near Cinema	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-28	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
65	1	Ресторан + Кафе near Фидан	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-30	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
66	1	Ресторан + Музей + Кафе near Алекс	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-31	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
67	1	Ресторан + Кафе near Прайд	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-33	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
68	1	Ресторан + Музей + Кафе near Малый Ахун	3 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-39	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
69	1	Ресторан near Чайка	3 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-42	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
70	1	Ресторан + Кафе near Духанъ	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-43	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
71	1	Ресторан + Гостиница + Кафе near Калинка	3 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-46	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
72	1	Ресторан + Музей + Достопримечательность near Спортбар	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-47	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
73	1	Ресторан + Кафе + Достопримечательность near Грац	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-48	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
74	1	Ресторан + Кафе + Гостиница near Баден-Баден	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-51	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
75	1	Ресторан + Кафе near Суши-бар "Минами"	5 spots within 5km	\N	\N	1	\N	fresh	0	0	0	auto-53	\N	ready	2026-03-21 20:58:39.672952+00	2026-03-21 20:58:39.672952+00
76	2	Маршрут couple	\N	\N	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 22:22:26.137707+00	2026-03-21 22:22:26.197463+00
77	2	Маршрут couple	\N	\N	Маршрут для solo по 5 точкам.\nПогода: Переменная облачность, 9.7°C.\n1. Mocco: Кафе\n2. Усадьба-винодельня Кантина: Винодельня\n3. Шумринка: Винодельня\n4. Шато Ле Гран Восток: Винодельня\n5. Раевское: Винодельня	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "weather": {"time": "2026-03-22T01:15", "weather": "Переменная облачность", "windspeed": 3.8, "temperature": 9.7, "weathercode": 2, "winddirection": 49}, "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	ready	2026-03-21 22:23:35.419471+00	2026-03-21 22:23:35.963605+00
78	2	Маршрут couple	\N	\N	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Переменная облачность, 9.7°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}]}	ready	2026-03-21 22:32:41.597564+00	2026-03-21 22:32:42.948237+00
81	5	Маршрут couple	\N	\N	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Преимущественно ясно, 9.9°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}]}	ready	2026-03-21 23:09:28.29761+00	2026-03-21 23:09:29.691522+00
79	2	Маршрут couple	\N	\N	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Переменная облачность, 9.7°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T01:30", "weather": "Переменная облачность", "windspeed": 3.6, "temperature": 9.7, "weathercode": 2, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 9.7, "weather": "Переменная облачность"}]}	ready	2026-03-21 22:38:23.241927+00	2026-03-21 22:38:24.600878+00
80	2	Маршрут couple	\N	\N	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Преимущественно ясно, 9.9°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}]}	ready	2026-03-21 23:05:49.410342+00	2026-03-21 23:05:51.068852+00
85	9	Маршрут couple	\N	\N	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 23:13:43.578494+00	2026-03-21 23:13:43.657278+00
82	6	Маршрут couple	\N	\N	Маршрут для couple, 5 точек, 279.6 км.\nПогода: Преимущественно ясно, 9.9°C.\n\n1. Mocco — Кафе (→ 230.4 км, ~230 мин)\n2. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n3. Шумринка — Винодельня (→ 29.1 км, ~29 мин)\n4. Шато Ле Гран Восток — Винодельня (→ 17.8 км, ~18 мин)\n5. Раевское — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	\N	\N	fresh	5	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "dateFrom": "2026-04-15", "total_km": 279.6, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "description": "Кафе", "distance_to_next_km": 230.4, "duration_to_next_min": 230}, {"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 29.1, "duration_to_next_min": 29}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 279.6, "weather": {"time": "2026-03-22T02:00", "weather": "Преимущественно ясно", "windspeed": 5.1, "temperature": 9.9, "weathercode": 1, "winddirection": 45}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}], "recommendations": [{"type": "food", "options": [{"lat": 43.5784046, "lng": 39.7287965, "name": "Mocco", "type": "Кафе", "post_id": 184, "distance_km": 0.0}, {"lat": 43.5774093, "lng": 39.730954, "name": "Фидан", "type": "Ресторан", "post_id": 30, "distance_km": 0.2}, {"lat": 43.576863, "lng": 39.7260936, "name": "Белые ночи", "type": "Кафе", "post_id": 160, "distance_km": 0.3}]}, {"type": "fuel", "options": [{"lat": 44.898448, "lng": 37.449008, "name": "Роснефть", "post_id": 253, "distance_km": 5.3}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.7}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-16", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}, {"date": "2026-04-17", "icon": 1, "tempC": 9.9, "weather": "Преимущественно ясно"}]}	ready	2026-03-21 23:10:16.925514+00	2026-03-21 23:10:18.348026+00
83	7	Маршрут couple	\N	\N	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 23:11:06.108409+00	2026-03-21 23:11:06.177057+00
84	8	Маршрут couple	\N	\N	\N	\N	\N	fresh	0	0	0	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}	stale	2026-03-21 23:11:49.295217+00	2026-03-21 23:11:49.34056+00
86	10	Маршрут couple	\N	\N	Маршрут для couple, 12 точек, 77.9 км.\nПогода: Переменная облачность, 7.8°C.\n\n1. Усадьба-винодельня Кантина — Винодельня (→ 2.3 км, ~2 мин)\n2. Шумринка — Винодельня (→ 10.8 км, ~11 мин)\n3. Абрау-Дюрсо — Винодельня\n4. \n5. \n6. \n7. Шумринка — Винодельня\n8. Fanagoria — Винодельня (→ 11.6 км, ~12 мин)\n9. Винодельня Бердяева — Винодельня (→ 14.6 км, ~15 мин)\n10. Винодельня LETO — Винодельня (→ 20.8 км, ~21 мин)\n11. Раевское — Винодельня (→ 17.8 км, ~18 мин)\n12. Шато Ле Гран Восток — Винодельня\n\nСобытия на ваши даты:\n  • Фестиваль молодого вина (2026-04-15 — 2026-04-17)\n  • Фермерский рынок Абрау (2026-04-05 — 2026-10-25)\n\nАктуальные акции:\n  • Скидка 20% на дегустацию: При бронировании через приложение\n  • Бесплатный трансфер: При заказе тура от 2 дней\n  • Детям до 7 бесплатно: На все экскурсии	3	\N	fresh	9	3	1	\N	{"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "weather": {"time": "2026-03-22T02:00", "weather": "Переменная облачность", "windspeed": 19.6, "temperature": 7.8, "weathercode": 2, "winddirection": 84}, "dateFrom": "2026-04-15", "total_km": 77.9, "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car", "llm_context": {"stops": [{"lat": 44.8661441, "lng": 37.4627079, "name": "Усадьба-винодельня Кантина", "description": "Винодельня", "distance_to_next_km": 2.3, "duration_to_next_min": 2}, {"lat": 44.8509508, "lng": 37.4425334, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 10.8, "duration_to_next_min": 11}, {"lat": 44.8770928, "lng": 37.3111542, "name": "Абрау-Дюрсо", "description": "Винодельня", "distance_to_next_km": 0.0, "duration_to_next_min": 0}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": null, "lng": null, "name": "", "description": "", "distance_to_next_km": null, "duration_to_next_min": null}, {"lat": 44.877187, "lng": 37.3110563, "name": "Шумринка", "description": "Винодельня", "distance_to_next_km": 0.0, "duration_to_next_min": 0}, {"lat": 44.8773243, "lng": 37.3109261, "name": "Fanagoria", "description": "Винодельня", "distance_to_next_km": 11.6, "duration_to_next_min": 12}, {"lat": 44.981751, "lng": 37.3125481, "name": "Винодельня Бердяева", "description": "Винодельня", "distance_to_next_km": 14.6, "duration_to_next_min": 15}, {"lat": 45.0732822, "lng": 37.4463748, "name": "Винодельня LETO", "description": "Винодельня", "distance_to_next_km": 20.8, "duration_to_next_min": 21}, {"lat": 44.9057375, "lng": 37.5637933, "name": "Раевское", "description": "Винодельня", "distance_to_next_km": 17.8, "duration_to_next_min": 18}, {"lat": 45.0010209, "lng": 37.7452316, "name": "Шато Ле Гран Восток", "description": "Винодельня", "distance_to_next_km": null, "duration_to_next_min": null}], "events": [{"id": 1, "title": "Фестиваль молодого вина", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "description": "Дегустация 20 виноделен края"}, {"id": 6, "title": "Фермерский рынок Абрау", "dateTo": "2026-10-25", "dateFrom": "2026-04-05", "description": "Еженедельный рынок фермеров"}], "offers": [{"id": 1, "title": "Скидка 20% на дегустацию", "validTo": "2026-06-30", "discount": 20, "validFrom": "2026-04-01", "description": "При бронировании через приложение"}, {"id": 2, "title": "Бесплатный трансфер", "validTo": "2026-05-31", "discount": null, "validFrom": "2026-04-01", "description": "При заказе тура от 2 дней"}, {"id": 4, "title": "Детям до 7 бесплатно", "validTo": "2026-12-31", "discount": 100, "validFrom": "2026-04-01", "description": "На все экскурсии"}], "filters": {"pace": "balanced", "budget": "mid", "dateTo": "2026-04-17", "dateFrom": "2026-04-15", "groupType": "couple", "interests": ["wine", "gastro"], "transport": "car"}, "totalKm": 77.9, "weather": {"time": "2026-03-22T02:00", "weather": "Переменная облачность", "windspeed": 19.6, "temperature": 7.8, "weathercode": 2, "winddirection": 84}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}], "recommendations": [{"type": "food", "options": [{"lat": 44.978699, "lng": 37.271429, "name": "Столовая", "type": "Ресторан", "post_id": 79, "distance_km": 3.3}]}, {"type": "food", "options": [{"lat": 45.015743, "lng": 37.7545527, "name": "Kuvee Karsov", "type": "Ресторан", "post_id": 80, "distance_km": 1.8}]}, {"type": "fuel", "options": [{"lat": 44.9105977, "lng": 37.3285363, "name": "Роснефть", "post_id": 251, "distance_km": 4.0}, {"lat": 44.8994488, "lng": 37.3914293, "name": "Роснефть", "post_id": 252, "distance_km": 6.8}]}]}, "weatherPerDay": [{"date": "2026-04-15", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-16", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}, {"date": "2026-04-17", "icon": 2, "tempC": 7.8, "weather": "Переменная облачность"}]}	ready	2026-03-21 23:14:51.966681+00	2026-03-21 23:14:53.555453+00
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
2	+79001111111	\N	\N	\N	tourist	\N	2026-03-21 21:33:21.173067+00	2026-03-21 21:33:21.173067+00
3	+79001234567	\N	\N	\N	tourist	\N	2026-03-21 21:40:57.878791+00	2026-03-21 21:40:57.878791+00
4	+79999999999	\N	\N	\N	tourist	\N	2026-03-21 21:41:04.695557+00	2026-03-21 21:41:04.695557+00
5	+79002222222	\N	\N	\N	tourist	\N	2026-03-21 23:09:28.245451+00	2026-03-21 23:09:28.245451+00
6	+79003333333	\N	\N	\N	tourist	\N	2026-03-21 23:10:16.889076+00	2026-03-21 23:10:16.889076+00
7	+79004444444	\N	\N	\N	tourist	\N	2026-03-21 23:11:06.066845+00	2026-03-21 23:11:06.066845+00
8	+79005555555	\N	\N	\N	tourist	\N	2026-03-21 23:11:49.249021+00	2026-03-21 23:11:49.249021+00
9	+79006666666	\N	\N	\N	tourist	\N	2026-03-21 23:13:43.537559+00	2026-03-21 23:13:43.537559+00
10	+79007777777	\N	\N	\N	tourist	\N	2026-03-21 23:14:51.925214+00	2026-03-21 23:14:51.925214+00
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

SELECT pg_catalog.setval('public.interests_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.post_media_id_seq', 422, true);


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

\unrestrict qbhmFdbuMWGgvcsszbpUdMs0Xjnruga4L2wD41QbsuOsstiCcBLCKr7kXkxY1MT

