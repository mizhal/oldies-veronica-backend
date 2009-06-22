--
-- PostgreSQL database dump
--

-- Started on 2009-06-22 13:11:08

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1101 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: root
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO root;

SET search_path = public, pg_catalog;

--
-- TOC entry 2642 (class 1259 OID 134851)
-- Dependencies: 3
-- Name: art_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE art_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.art_seq OWNER TO root;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2641 (class 1259 OID 134840)
-- Dependencies: 2940 3
-- Name: articles; Type: TABLE; Schema: public; Owner: mizhal; Tablespace: 
--

CREATE TABLE articles (
    feed bigint NOT NULL,
    link text NOT NULL,
    title text,
    content text,
    published timestamp without time zone,
    fetch_date timestamp without time zone NOT NULL,
    created timestamp without time zone,
    id bigint DEFAULT nextval('art_seq'::regclass) NOT NULL
);


ALTER TABLE public.articles OWNER TO mizhal;

--
-- TOC entry 1018 (class 0 OID 0)
-- Name: chkpass; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE chkpass;


--
-- TOC entry 143 (class 1255 OID 16845)
-- Dependencies: 3 1018
-- Name: chkpass_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION chkpass_in(cstring) RETURNS chkpass
    AS '$libdir/chkpass', 'chkpass_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.chkpass_in(cstring) OWNER TO root;

--
-- TOC entry 144 (class 1255 OID 16846)
-- Dependencies: 3 1018
-- Name: chkpass_out(chkpass); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION chkpass_out(chkpass) RETURNS cstring
    AS '$libdir/chkpass', 'chkpass_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.chkpass_out(chkpass) OWNER TO root;

--
-- TOC entry 1017 (class 1247 OID 16844)
-- Dependencies: 144 3 143
-- Name: chkpass; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE chkpass (
    INTERNALLENGTH = 16,
    INPUT = chkpass_in,
    OUTPUT = chkpass_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.chkpass OWNER TO root;

--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 1017
-- Name: TYPE chkpass; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE chkpass IS 'password type with checks';


--
-- TOC entry 1021 (class 0 OID 0)
-- Name: cube; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE cube;


--
-- TOC entry 148 (class 1255 OID 16854)
-- Dependencies: 3 1021
-- Name: cube_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_in(cstring) RETURNS cube
    AS '$libdir/cube', 'cube_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_in(cstring) OWNER TO root;

--
-- TOC entry 151 (class 1255 OID 16857)
-- Dependencies: 3 1021
-- Name: cube_out(cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_out(cube) RETURNS cstring
    AS '$libdir/cube', 'cube_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_out(cube) OWNER TO root;

--
-- TOC entry 1020 (class 1247 OID 16853)
-- Dependencies: 151 3 148
-- Name: cube; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE cube (
    INTERNALLENGTH = variable,
    INPUT = cube_in,
    OUTPUT = cube_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.cube OWNER TO root;

--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 1020
-- Name: TYPE cube; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE cube IS 'multi-dimensional cube ''(FLOAT-1, FLOAT-2, ..., FLOAT-N), (FLOAT-1, FLOAT-2, ..., FLOAT-N)''';


--
-- TOC entry 1023 (class 1247 OID 16952)
-- Dependencies: 3 2635
-- Name: dblink_pkey_results; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE dblink_pkey_results AS (
	"position" integer,
	colname text
);


ALTER TYPE public.dblink_pkey_results OWNER TO root;

--
-- TOC entry 1042 (class 0 OID 0)
-- Name: ean13; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ean13;


--
-- TOC entry 314 (class 1255 OID 17162)
-- Dependencies: 3 1042
-- Name: ean13_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ean13_in(cstring) RETURNS ean13
    AS '$libdir/isn', 'ean13_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ean13_in(cstring) OWNER TO root;

--
-- TOC entry 315 (class 1255 OID 17163)
-- Dependencies: 3 1042
-- Name: ean13_out(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ean13_out(ean13) RETURNS cstring
    AS '$libdir/isn', 'ean13_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ean13_out(ean13) OWNER TO root;

--
-- TOC entry 1041 (class 1247 OID 17161)
-- Dependencies: 3 315 314
-- Name: ean13; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ean13 (
    INTERNALLENGTH = 8,
    INPUT = ean13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ean13 OWNER TO root;

--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 1041
-- Name: TYPE ean13; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE ean13 IS 'International European Article Number (EAN13)';


--
-- TOC entry 2640 (class 1259 OID 134826)
-- Dependencies: 3
-- Name: feed_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE feed_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.feed_seq OWNER TO root;

--
-- TOC entry 2639 (class 1259 OID 134815)
-- Dependencies: 2934 2935 2936 2937 2938 2939 3
-- Name: feeds; Type: TABLE; Schema: public; Owner: mizhal; Tablespace: 
--

CREATE TABLE feeds (
    id bigint DEFAULT nextval('feed_seq'::regclass) NOT NULL,
    title text,
    rss text NOT NULL,
    site text,
    last_read timestamp without time zone DEFAULT now() NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    errors integer DEFAULT 0,
    last_err text,
    response real,
    freq real DEFAULT 1 NOT NULL,
    last_news integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.feeds OWNER TO mizhal;

--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 2639
-- Name: COLUMN feeds.errors; Type: COMMENT; Schema: public; Owner: mizhal
--

COMMENT ON COLUMN feeds.errors IS 'cuenta de errores detectados';


--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 2639
-- Name: COLUMN feeds.response; Type: COMMENT; Schema: public; Owner: mizhal
--

COMMENT ON COLUMN feeds.response IS 'tiempo de respuesta';


--
-- TOC entry 1009 (class 0 OID 0)
-- Name: gbtreekey16; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey16;


--
-- TOC entry 26 (class 1255 OID 16414)
-- Dependencies: 3 1009
-- Name: gbtreekey16_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey16_in(cstring) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbtreekey_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey16_in(cstring) OWNER TO root;

--
-- TOC entry 27 (class 1255 OID 16415)
-- Dependencies: 3 1009
-- Name: gbtreekey16_out(gbtreekey16); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey16_out(gbtreekey16) RETURNS cstring
    AS '$libdir/btree_gist', 'gbtreekey_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey16_out(gbtreekey16) OWNER TO root;

--
-- TOC entry 1008 (class 1247 OID 16413)
-- Dependencies: 3 26 27
-- Name: gbtreekey16; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey16 (
    INTERNALLENGTH = 16,
    INPUT = gbtreekey16_in,
    OUTPUT = gbtreekey16_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey16 OWNER TO root;

--
-- TOC entry 1012 (class 0 OID 0)
-- Name: gbtreekey32; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey32;


--
-- TOC entry 28 (class 1255 OID 16418)
-- Dependencies: 3 1012
-- Name: gbtreekey32_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey32_in(cstring) RETURNS gbtreekey32
    AS '$libdir/btree_gist', 'gbtreekey_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey32_in(cstring) OWNER TO root;

--
-- TOC entry 29 (class 1255 OID 16419)
-- Dependencies: 3 1012
-- Name: gbtreekey32_out(gbtreekey32); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey32_out(gbtreekey32) RETURNS cstring
    AS '$libdir/btree_gist', 'gbtreekey_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey32_out(gbtreekey32) OWNER TO root;

--
-- TOC entry 1011 (class 1247 OID 16417)
-- Dependencies: 28 3 29
-- Name: gbtreekey32; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey32 (
    INTERNALLENGTH = 32,
    INPUT = gbtreekey32_in,
    OUTPUT = gbtreekey32_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey32 OWNER TO root;

--
-- TOC entry 967 (class 0 OID 0)
-- Name: gbtreekey4; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey4;


--
-- TOC entry 22 (class 1255 OID 16406)
-- Dependencies: 3 967
-- Name: gbtreekey4_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey4_in(cstring) RETURNS gbtreekey4
    AS '$libdir/btree_gist', 'gbtreekey_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey4_in(cstring) OWNER TO root;

--
-- TOC entry 23 (class 1255 OID 16407)
-- Dependencies: 3 967
-- Name: gbtreekey4_out(gbtreekey4); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey4_out(gbtreekey4) RETURNS cstring
    AS '$libdir/btree_gist', 'gbtreekey_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey4_out(gbtreekey4) OWNER TO root;

--
-- TOC entry 966 (class 1247 OID 16405)
-- Dependencies: 22 23 3
-- Name: gbtreekey4; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey4 (
    INTERNALLENGTH = 4,
    INPUT = gbtreekey4_in,
    OUTPUT = gbtreekey4_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey4 OWNER TO root;

--
-- TOC entry 1006 (class 0 OID 0)
-- Name: gbtreekey8; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey8;


--
-- TOC entry 24 (class 1255 OID 16410)
-- Dependencies: 3 1006
-- Name: gbtreekey8_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey8_in(cstring) RETURNS gbtreekey8
    AS '$libdir/btree_gist', 'gbtreekey_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey8_in(cstring) OWNER TO root;

--
-- TOC entry 25 (class 1255 OID 16411)
-- Dependencies: 3 1006
-- Name: gbtreekey8_out(gbtreekey8); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey8_out(gbtreekey8) RETURNS cstring
    AS '$libdir/btree_gist', 'gbtreekey_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey8_out(gbtreekey8) OWNER TO root;

--
-- TOC entry 1005 (class 1247 OID 16409)
-- Dependencies: 3 24 25
-- Name: gbtreekey8; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey8 (
    INTERNALLENGTH = 8,
    INPUT = gbtreekey8_in,
    OUTPUT = gbtreekey8_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey8 OWNER TO root;

--
-- TOC entry 1015 (class 0 OID 0)
-- Name: gbtreekey_var; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey_var;


--
-- TOC entry 30 (class 1255 OID 16422)
-- Dependencies: 3 1015
-- Name: gbtreekey_var_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey_var_in(cstring) RETURNS gbtreekey_var
    AS '$libdir/btree_gist', 'gbtreekey_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey_var_in(cstring) OWNER TO root;

--
-- TOC entry 31 (class 1255 OID 16423)
-- Dependencies: 3 1015
-- Name: gbtreekey_var_out(gbtreekey_var); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbtreekey_var_out(gbtreekey_var) RETURNS cstring
    AS '$libdir/btree_gist', 'gbtreekey_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbtreekey_var_out(gbtreekey_var) OWNER TO root;

--
-- TOC entry 1014 (class 1247 OID 16421)
-- Dependencies: 31 3 30
-- Name: gbtreekey_var; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE gbtreekey_var (
    INTERNALLENGTH = variable,
    INPUT = gbtreekey_var_in,
    OUTPUT = gbtreekey_var_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.gbtreekey_var OWNER TO root;

--
-- TOC entry 1033 (class 0 OID 0)
-- Name: ghstore; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ghstore;


--
-- TOC entry 254 (class 1255 OID 17014)
-- Dependencies: 3 1033
-- Name: ghstore_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_in(cstring) RETURNS ghstore
    AS '$libdir/hstore', 'ghstore_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ghstore_in(cstring) OWNER TO root;

--
-- TOC entry 255 (class 1255 OID 17015)
-- Dependencies: 3 1033
-- Name: ghstore_out(ghstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_out(ghstore) RETURNS cstring
    AS '$libdir/hstore', 'ghstore_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ghstore_out(ghstore) OWNER TO root;

--
-- TOC entry 1032 (class 1247 OID 17013)
-- Dependencies: 255 3 254
-- Name: ghstore; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ghstore (
    INTERNALLENGTH = variable,
    INPUT = ghstore_in,
    OUTPUT = ghstore_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ghstore OWNER TO root;

--
-- TOC entry 1085 (class 0 OID 0)
-- Name: gtrgm; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE gtrgm;


--
-- TOC entry 645 (class 1255 OID 18037)
-- Dependencies: 3 1085
-- Name: gtrgm_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_in(cstring) RETURNS gtrgm
    AS '$libdir/pg_trgm', 'gtrgm_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gtrgm_in(cstring) OWNER TO root;

--
-- TOC entry 646 (class 1255 OID 18038)
-- Dependencies: 3 1085
-- Name: gtrgm_out(gtrgm); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_out(gtrgm) RETURNS cstring
    AS '$libdir/pg_trgm', 'gtrgm_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gtrgm_out(gtrgm) OWNER TO root;

--
-- TOC entry 1084 (class 1247 OID 18036)
-- Dependencies: 646 645 3
-- Name: gtrgm; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE gtrgm (
    INTERNALLENGTH = variable,
    INPUT = gtrgm_in,
    OUTPUT = gtrgm_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gtrgm OWNER TO root;

--
-- TOC entry 1030 (class 0 OID 0)
-- Name: hstore; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE hstore;


--
-- TOC entry 237 (class 1255 OID 16987)
-- Dependencies: 3 1030
-- Name: hstore_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hstore_in(cstring) RETURNS hstore
    AS '$libdir/hstore', 'hstore_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.hstore_in(cstring) OWNER TO root;

--
-- TOC entry 238 (class 1255 OID 16988)
-- Dependencies: 3 1030
-- Name: hstore_out(hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hstore_out(hstore) RETURNS cstring
    AS '$libdir/hstore', 'hstore_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.hstore_out(hstore) OWNER TO root;

--
-- TOC entry 1029 (class 1247 OID 16986)
-- Dependencies: 238 3 237
-- Name: hstore; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE hstore (
    INTERNALLENGTH = variable,
    INPUT = hstore_in,
    OUTPUT = hstore_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.hstore OWNER TO root;

--
-- TOC entry 1039 (class 0 OID 0)
-- Name: intbig_gkey; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE intbig_gkey;


--
-- TOC entry 303 (class 1255 OID 17120)
-- Dependencies: 3 1039
-- Name: _intbig_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _intbig_in(cstring) RETURNS intbig_gkey
    AS '$libdir/_int', '_intbig_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._intbig_in(cstring) OWNER TO root;

--
-- TOC entry 304 (class 1255 OID 17121)
-- Dependencies: 3 1039
-- Name: _intbig_out(intbig_gkey); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _intbig_out(intbig_gkey) RETURNS cstring
    AS '$libdir/_int', '_intbig_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._intbig_out(intbig_gkey) OWNER TO root;

--
-- TOC entry 1038 (class 1247 OID 17119)
-- Dependencies: 3 304 303
-- Name: intbig_gkey; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE intbig_gkey (
    INTERNALLENGTH = variable,
    INPUT = _intbig_in,
    OUTPUT = _intbig_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.intbig_gkey OWNER TO root;

--
-- TOC entry 1054 (class 0 OID 0)
-- Name: isbn; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE isbn;


--
-- TOC entry 322 (class 1255 OID 17178)
-- Dependencies: 3 1054
-- Name: isbn_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isbn_in(cstring) RETURNS isbn
    AS '$libdir/isn', 'isbn_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isbn_in(cstring) OWNER TO root;

--
-- TOC entry 323 (class 1255 OID 17179)
-- Dependencies: 3 1054
-- Name: isn_out(isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isn_out(isbn) RETURNS cstring
    AS '$libdir/isn', 'isn_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isn_out(isbn) OWNER TO root;

--
-- TOC entry 1053 (class 1247 OID 17177)
-- Dependencies: 3 323 322
-- Name: isbn; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE isbn (
    INTERNALLENGTH = 8,
    INPUT = isbn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.isbn OWNER TO root;

--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 1053
-- Name: TYPE isbn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE isbn IS 'International Standard Book Number (ISBN)';


--
-- TOC entry 1045 (class 0 OID 0)
-- Name: isbn13; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE isbn13;


--
-- TOC entry 317 (class 1255 OID 17167)
-- Dependencies: 3 1045
-- Name: ean13_out(isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ean13_out(isbn13) RETURNS cstring
    AS '$libdir/isn', 'ean13_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ean13_out(isbn13) OWNER TO root;

--
-- TOC entry 316 (class 1255 OID 17166)
-- Dependencies: 3 1045
-- Name: isbn13_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isbn13_in(cstring) RETURNS isbn13
    AS '$libdir/isn', 'isbn_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isbn13_in(cstring) OWNER TO root;

--
-- TOC entry 1044 (class 1247 OID 17165)
-- Dependencies: 316 3 317
-- Name: isbn13; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE isbn13 (
    INTERNALLENGTH = 8,
    INPUT = isbn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.isbn13 OWNER TO root;

--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 1044
-- Name: TYPE isbn13; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE isbn13 IS 'International Standard Book Number 13 (ISBN13)';


--
-- TOC entry 1057 (class 0 OID 0)
-- Name: ismn; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ismn;


--
-- TOC entry 324 (class 1255 OID 17182)
-- Dependencies: 3 1057
-- Name: ismn_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ismn_in(cstring) RETURNS ismn
    AS '$libdir/isn', 'ismn_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ismn_in(cstring) OWNER TO root;

--
-- TOC entry 325 (class 1255 OID 17183)
-- Dependencies: 3 1057
-- Name: isn_out(ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isn_out(ismn) RETURNS cstring
    AS '$libdir/isn', 'isn_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isn_out(ismn) OWNER TO root;

--
-- TOC entry 1056 (class 1247 OID 17181)
-- Dependencies: 324 325 3
-- Name: ismn; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ismn (
    INTERNALLENGTH = 8,
    INPUT = ismn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ismn OWNER TO root;

--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 1056
-- Name: TYPE ismn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE ismn IS 'International Standard Music Number (ISMN)';


--
-- TOC entry 1048 (class 0 OID 0)
-- Name: ismn13; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ismn13;


--
-- TOC entry 319 (class 1255 OID 17171)
-- Dependencies: 3 1048
-- Name: ean13_out(ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ean13_out(ismn13) RETURNS cstring
    AS '$libdir/isn', 'ean13_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ean13_out(ismn13) OWNER TO root;

--
-- TOC entry 318 (class 1255 OID 17170)
-- Dependencies: 3 1048
-- Name: ismn13_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ismn13_in(cstring) RETURNS ismn13
    AS '$libdir/isn', 'ismn_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ismn13_in(cstring) OWNER TO root;

--
-- TOC entry 1047 (class 1247 OID 17169)
-- Dependencies: 319 3 318
-- Name: ismn13; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ismn13 (
    INTERNALLENGTH = 8,
    INPUT = ismn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ismn13 OWNER TO root;

--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 1047
-- Name: TYPE ismn13; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE ismn13 IS 'International Standard Music Number 13 (ISMN13)';


--
-- TOC entry 1060 (class 0 OID 0)
-- Name: issn; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE issn;


--
-- TOC entry 327 (class 1255 OID 17187)
-- Dependencies: 3 1060
-- Name: isn_out(issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isn_out(issn) RETURNS cstring
    AS '$libdir/isn', 'isn_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isn_out(issn) OWNER TO root;

--
-- TOC entry 326 (class 1255 OID 17186)
-- Dependencies: 3 1060
-- Name: issn_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION issn_in(cstring) RETURNS issn
    AS '$libdir/isn', 'issn_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.issn_in(cstring) OWNER TO root;

--
-- TOC entry 1059 (class 1247 OID 17185)
-- Dependencies: 327 3 326
-- Name: issn; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE issn (
    INTERNALLENGTH = 8,
    INPUT = issn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.issn OWNER TO root;

--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 1059
-- Name: TYPE issn; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE issn IS 'International Standard Serial Number (ISSN)';


--
-- TOC entry 1051 (class 0 OID 0)
-- Name: issn13; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE issn13;


--
-- TOC entry 321 (class 1255 OID 17175)
-- Dependencies: 3 1051
-- Name: ean13_out(issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ean13_out(issn13) RETURNS cstring
    AS '$libdir/isn', 'ean13_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ean13_out(issn13) OWNER TO root;

--
-- TOC entry 320 (class 1255 OID 17174)
-- Dependencies: 3 1051
-- Name: issn13_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION issn13_in(cstring) RETURNS issn13
    AS '$libdir/isn', 'issn_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.issn13_in(cstring) OWNER TO root;

--
-- TOC entry 1050 (class 1247 OID 17173)
-- Dependencies: 3 321 320
-- Name: issn13; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE issn13 (
    INTERNALLENGTH = 8,
    INPUT = issn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.issn13 OWNER TO root;

--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 1050
-- Name: TYPE issn13; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE issn13 IS 'International Standard Serial Number 13 (ISSN13)';


--
-- TOC entry 1070 (class 0 OID 0)
-- Name: lquery; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE lquery;


--
-- TOC entry 592 (class 1255 OID 17890)
-- Dependencies: 3 1070
-- Name: lquery_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lquery_in(cstring) RETURNS lquery
    AS '$libdir/ltree', 'lquery_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.lquery_in(cstring) OWNER TO root;

--
-- TOC entry 593 (class 1255 OID 17891)
-- Dependencies: 3 1070
-- Name: lquery_out(lquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lquery_out(lquery) RETURNS cstring
    AS '$libdir/ltree', 'lquery_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.lquery_out(lquery) OWNER TO root;

--
-- TOC entry 1069 (class 1247 OID 17889)
-- Dependencies: 592 3 593
-- Name: lquery; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE lquery (
    INTERNALLENGTH = variable,
    INPUT = lquery_in,
    OUTPUT = lquery_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.lquery OWNER TO root;

--
-- TOC entry 1067 (class 0 OID 0)
-- Name: ltree; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ltree;


--
-- TOC entry 561 (class 1255 OID 17836)
-- Dependencies: 3 1067
-- Name: ltree_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_in(cstring) RETURNS ltree
    AS '$libdir/ltree', 'ltree_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ltree_in(cstring) OWNER TO root;

--
-- TOC entry 562 (class 1255 OID 17837)
-- Dependencies: 3 1067
-- Name: ltree_out(ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_out(ltree) RETURNS cstring
    AS '$libdir/ltree', 'ltree_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ltree_out(ltree) OWNER TO root;

--
-- TOC entry 1066 (class 1247 OID 17835)
-- Dependencies: 3 562 561
-- Name: ltree; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ltree (
    INTERNALLENGTH = variable,
    INPUT = ltree_in,
    OUTPUT = ltree_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.ltree OWNER TO root;

--
-- TOC entry 1076 (class 0 OID 0)
-- Name: ltree_gist; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ltree_gist;


--
-- TOC entry 602 (class 1255 OID 17916)
-- Dependencies: 3 1076
-- Name: ltree_gist_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_gist_in(cstring) RETURNS ltree_gist
    AS '$libdir/ltree', 'ltree_gist_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ltree_gist_in(cstring) OWNER TO root;

--
-- TOC entry 603 (class 1255 OID 17917)
-- Dependencies: 3 1076
-- Name: ltree_gist_out(ltree_gist); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_gist_out(ltree_gist) RETURNS cstring
    AS '$libdir/ltree', 'ltree_gist_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ltree_gist_out(ltree_gist) OWNER TO root;

--
-- TOC entry 1075 (class 1247 OID 17915)
-- Dependencies: 3 602 603
-- Name: ltree_gist; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ltree_gist (
    INTERNALLENGTH = variable,
    INPUT = ltree_gist_in,
    OUTPUT = ltree_gist_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ltree_gist OWNER TO root;

--
-- TOC entry 1073 (class 0 OID 0)
-- Name: ltxtquery; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE ltxtquery;


--
-- TOC entry 598 (class 1255 OID 17906)
-- Dependencies: 3 1073
-- Name: ltxtq_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltxtq_in(cstring) RETURNS ltxtquery
    AS '$libdir/ltree', 'ltxtq_in'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ltxtq_in(cstring) OWNER TO root;

--
-- TOC entry 599 (class 1255 OID 17907)
-- Dependencies: 3 1073
-- Name: ltxtq_out(ltxtquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltxtq_out(ltxtquery) RETURNS cstring
    AS '$libdir/ltree', 'ltxtq_out'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ltxtq_out(ltxtquery) OWNER TO root;

--
-- TOC entry 1072 (class 1247 OID 17905)
-- Dependencies: 599 3 598
-- Name: ltxtquery; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE ltxtquery (
    INTERNALLENGTH = variable,
    INPUT = ltxtq_in,
    OUTPUT = ltxtq_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.ltxtquery OWNER TO root;

--
-- TOC entry 637 (class 1255 OID 18015)
-- Dependencies: 3
-- Name: pg_buffercache_pages(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pg_buffercache_pages() RETURNS SETOF record
    AS '$libdir/pg_buffercache', 'pg_buffercache_pages'
    LANGUAGE c;


ALTER FUNCTION public.pg_buffercache_pages() OWNER TO root;

--
-- TOC entry 2636 (class 1259 OID 18016)
-- Dependencies: 2720 3
-- Name: pg_buffercache; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW pg_buffercache AS
    SELECT p.bufferid, p.relfilenode, p.reltablespace, p.reldatabase, p.relblocknumber, p.isdirty, p.usagecount FROM pg_buffercache_pages() p(bufferid integer, relfilenode oid, reltablespace oid, reldatabase oid, relblocknumber bigint, isdirty boolean, usagecount smallint);


ALTER TABLE public.pg_buffercache OWNER TO root;

--
-- TOC entry 638 (class 1255 OID 18020)
-- Dependencies: 3
-- Name: pg_freespacemap_pages(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pg_freespacemap_pages() RETURNS SETOF record
    AS '$libdir/pg_freespacemap', 'pg_freespacemap_pages'
    LANGUAGE c;


ALTER FUNCTION public.pg_freespacemap_pages() OWNER TO root;

--
-- TOC entry 2637 (class 1259 OID 18022)
-- Dependencies: 2721 3
-- Name: pg_freespacemap_pages; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW pg_freespacemap_pages AS
    SELECT p.reltablespace, p.reldatabase, p.relfilenode, p.relblocknumber, p.bytes FROM pg_freespacemap_pages() p(reltablespace oid, reldatabase oid, relfilenode oid, relblocknumber bigint, bytes integer);


ALTER TABLE public.pg_freespacemap_pages OWNER TO root;

--
-- TOC entry 639 (class 1255 OID 18021)
-- Dependencies: 3
-- Name: pg_freespacemap_relations(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pg_freespacemap_relations() RETURNS SETOF record
    AS '$libdir/pg_freespacemap', 'pg_freespacemap_relations'
    LANGUAGE c;


ALTER FUNCTION public.pg_freespacemap_relations() OWNER TO root;

--
-- TOC entry 2638 (class 1259 OID 18026)
-- Dependencies: 2722 3
-- Name: pg_freespacemap_relations; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW pg_freespacemap_relations AS
    SELECT p.reltablespace, p.reldatabase, p.relfilenode, p.avgrequest, p.interestingpages, p.storedpages, p.nextpage FROM pg_freespacemap_relations() p(reltablespace oid, reldatabase oid, relfilenode oid, avgrequest integer, interestingpages integer, storedpages integer, nextpage integer);


ALTER TABLE public.pg_freespacemap_relations OWNER TO root;

--
-- TOC entry 1036 (class 0 OID 0)
-- Name: query_int; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE query_int;


--
-- TOC entry 269 (class 1255 OID 17052)
-- Dependencies: 3 1036
-- Name: bqarr_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION bqarr_in(cstring) RETURNS query_int
    AS '$libdir/_int', 'bqarr_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bqarr_in(cstring) OWNER TO root;

--
-- TOC entry 270 (class 1255 OID 17053)
-- Dependencies: 3 1036
-- Name: bqarr_out(query_int); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION bqarr_out(query_int) RETURNS cstring
    AS '$libdir/_int', 'bqarr_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bqarr_out(query_int) OWNER TO root;

--
-- TOC entry 1035 (class 1247 OID 17051)
-- Dependencies: 3 270 269
-- Name: query_int; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE query_int (
    INTERNALLENGTH = variable,
    INPUT = bqarr_in,
    OUTPUT = bqarr_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.query_int OWNER TO root;

--
-- TOC entry 1088 (class 0 OID 0)
-- Name: seg; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE seg;


--
-- TOC entry 690 (class 1255 OID 18101)
-- Dependencies: 3 1088
-- Name: seg_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_in(cstring) RETURNS seg
    AS '$libdir/seg', 'seg_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_in(cstring) OWNER TO root;

--
-- TOC entry 691 (class 1255 OID 18102)
-- Dependencies: 3 1088
-- Name: seg_out(seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_out(seg) RETURNS cstring
    AS '$libdir/seg', 'seg_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_out(seg) OWNER TO root;

--
-- TOC entry 1087 (class 1247 OID 18100)
-- Dependencies: 3 690 691
-- Name: seg; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE seg (
    INTERNALLENGTH = 12,
    INPUT = seg_in,
    OUTPUT = seg_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.seg OWNER TO root;

--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 1087
-- Name: TYPE seg; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE seg IS 'floating point interval ''FLOAT .. FLOAT'', ''.. FLOAT'', ''FLOAT ..'' or ''FLOAT''';


--
-- TOC entry 2644 (class 1259 OID 135069)
-- Dependencies: 3
-- Name: session_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE session_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.session_seq OWNER TO root;

--
-- TOC entry 2643 (class 1259 OID 135066)
-- Dependencies: 2941 2942 3
-- Name: sessions; Type: TABLE; Schema: public; Owner: mizhal; Tablespace: 
--

CREATE TABLE sessions (
    id bigint DEFAULT nextval('session_seq'::regclass) NOT NULL,
    instant timestamp without time zone DEFAULT now() NOT NULL,
    elapsed_time real,
    feeds_fetched integer,
    entries_got integer,
    net_total real,
    net_mean real,
    net_variance real
);


ALTER TABLE public.sessions OWNER TO mizhal;

--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 2643
-- Name: COLUMN sessions.elapsed_time; Type: COMMENT; Schema: public; Owner: mizhal
--

COMMENT ON COLUMN sessions.elapsed_time IS 'segundos';


--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 2643
-- Name: COLUMN sessions.net_total; Type: COMMENT; Schema: public; Owner: mizhal
--

COMMENT ON COLUMN sessions.net_total IS 'tiempo de red total';


--
-- TOC entry 1063 (class 0 OID 0)
-- Name: upc; Type: SHELL TYPE; Schema: public; Owner: root
--

CREATE TYPE upc;


--
-- TOC entry 329 (class 1255 OID 17191)
-- Dependencies: 3 1063
-- Name: isn_out(upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isn_out(upc) RETURNS cstring
    AS '$libdir/isn', 'isn_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isn_out(upc) OWNER TO root;

--
-- TOC entry 328 (class 1255 OID 17190)
-- Dependencies: 3 1063
-- Name: upc_in(cstring); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION upc_in(cstring) RETURNS upc
    AS '$libdir/isn', 'upc_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.upc_in(cstring) OWNER TO root;

--
-- TOC entry 1062 (class 1247 OID 17189)
-- Dependencies: 328 3 329
-- Name: upc; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE upc (
    INTERNALLENGTH = 8,
    INPUT = upc_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.upc OWNER TO root;

--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 1062
-- Name: TYPE upc; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TYPE upc IS 'Universal Product Code (UPC)';


--
-- TOC entry 167 (class 1255 OID 16874)
-- Dependencies: 3 1020
-- Name: cube_dim(cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_dim(cube) RETURNS integer
    AS '$libdir/cube', 'cube_dim'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_dim(cube) OWNER TO root;

--
-- TOC entry 166 (class 1255 OID 16873)
-- Dependencies: 3 1020 1020
-- Name: cube_distance(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_distance(cube, cube) RETURNS double precision
    AS '$libdir/cube', 'cube_distance'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_distance(cube, cube) OWNER TO root;

--
-- TOC entry 174 (class 1255 OID 16881)
-- Dependencies: 1020 3
-- Name: cube_is_point(cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_is_point(cube) RETURNS boolean
    AS '$libdir/cube', 'cube_is_point'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_is_point(cube) OWNER TO root;

--
-- TOC entry 221 (class 1255 OID 16965)
-- Dependencies: 3
-- Name: earth(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION earth() RETURNS double precision
    AS $$SELECT '6378168'::float8$$
    LANGUAGE sql IMMUTABLE;


ALTER FUNCTION public.earth() OWNER TO root;

--
-- TOC entry 1025 (class 1247 OID 16966)
-- Dependencies: 1026 1027 1028 1020 151 3
-- Name: earth; Type: DOMAIN; Schema: public; Owner: root
--

CREATE DOMAIN earth AS cube
	CONSTRAINT not_3d CHECK ((cube_dim(VALUE) <= 3))
	CONSTRAINT not_point CHECK (cube_is_point(VALUE))
	CONSTRAINT on_surface CHECK ((abs(((cube_distance(VALUE, '(0)'::cube) / earth()) - (1)::double precision)) < 9.9999999999999995e-007::double precision));


ALTER DOMAIN public.earth OWNER TO root;

--
-- TOC entry 1065 (class 1247 OID 17832)
-- Dependencies: 3
-- Name: lo; Type: DOMAIN; Schema: public; Owner: root
--

CREATE DOMAIN lo AS oid;


ALTER DOMAIN public.lo OWNER TO root;

--
-- TOC entry 275 (class 1255 OID 17061)
-- Dependencies: 3
-- Name: _int_contained(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_contained(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_contained(integer[], integer[]) OWNER TO root;

--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 275
-- Name: FUNCTION _int_contained(integer[], integer[]); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION _int_contained(integer[], integer[]) IS 'contained in';


--
-- TOC entry 274 (class 1255 OID 17060)
-- Dependencies: 3
-- Name: _int_contains(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_contains(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_contains(integer[], integer[]) OWNER TO root;

--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 274
-- Name: FUNCTION _int_contains(integer[], integer[]); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION _int_contains(integer[], integer[]) IS 'contains';


--
-- TOC entry 278 (class 1255 OID 17064)
-- Dependencies: 3
-- Name: _int_different(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_different(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_different'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_different(integer[], integer[]) OWNER TO root;

--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 278
-- Name: FUNCTION _int_different(integer[], integer[]); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION _int_different(integer[], integer[]) IS 'different';


--
-- TOC entry 280 (class 1255 OID 17066)
-- Dependencies: 3
-- Name: _int_inter(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_inter(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', '_int_inter'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_inter(integer[], integer[]) OWNER TO root;

--
-- TOC entry 276 (class 1255 OID 17062)
-- Dependencies: 3
-- Name: _int_overlap(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_overlap(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_overlap'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_overlap(integer[], integer[]) OWNER TO root;

--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 276
-- Name: FUNCTION _int_overlap(integer[], integer[]); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION _int_overlap(integer[], integer[]) IS 'overlaps';


--
-- TOC entry 277 (class 1255 OID 17063)
-- Dependencies: 3
-- Name: _int_same(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_same(integer[], integer[]) RETURNS boolean
    AS '$libdir/_int', '_int_same'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_same(integer[], integer[]) OWNER TO root;

--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 277
-- Name: FUNCTION _int_same(integer[], integer[]); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION _int_same(integer[], integer[]) IS 'same as';


--
-- TOC entry 279 (class 1255 OID 17065)
-- Dependencies: 3
-- Name: _int_union(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _int_union(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', '_int_union'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._int_union(integer[], integer[]) OWNER TO root;

--
-- TOC entry 617 (class 1255 OID 17954)
-- Dependencies: 1068 3 1071
-- Name: _lt_q_regex(ltree[], lquery[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _lt_q_regex(ltree[], lquery[]) RETURNS boolean
    AS '$libdir/ltree', '_lt_q_regex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._lt_q_regex(ltree[], lquery[]) OWNER TO root;

--
-- TOC entry 618 (class 1255 OID 17955)
-- Dependencies: 3 1068 1071
-- Name: _lt_q_rregex(lquery[], ltree[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _lt_q_rregex(lquery[], ltree[]) RETURNS boolean
    AS '$libdir/ltree', '_lt_q_rregex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._lt_q_rregex(lquery[], ltree[]) OWNER TO root;

--
-- TOC entry 623 (class 1255 OID 17982)
-- Dependencies: 1066 1069 1068 3
-- Name: _ltq_extract_regex(ltree[], lquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltq_extract_regex(ltree[], lquery) RETURNS ltree
    AS '$libdir/ltree', '_ltq_extract_regex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltq_extract_regex(ltree[], lquery) OWNER TO root;

--
-- TOC entry 615 (class 1255 OID 17952)
-- Dependencies: 3 1068 1069
-- Name: _ltq_regex(ltree[], lquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltq_regex(ltree[], lquery) RETURNS boolean
    AS '$libdir/ltree', '_ltq_regex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltq_regex(ltree[], lquery) OWNER TO root;

--
-- TOC entry 616 (class 1255 OID 17953)
-- Dependencies: 3 1068 1069
-- Name: _ltq_rregex(lquery, ltree[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltq_rregex(lquery, ltree[]) RETURNS boolean
    AS '$libdir/ltree', '_ltq_rregex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltq_rregex(lquery, ltree[]) OWNER TO root;

--
-- TOC entry 626 (class 1255 OID 17987)
-- Dependencies: 3
-- Name: _ltree_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_compress(internal) RETURNS internal
    AS '$libdir/ltree', '_ltree_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public._ltree_compress(internal) OWNER TO root;

--
-- TOC entry 625 (class 1255 OID 17986)
-- Dependencies: 3
-- Name: _ltree_consistent(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_consistent(internal, internal, smallint) RETURNS boolean
    AS '$libdir/ltree', '_ltree_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public._ltree_consistent(internal, internal, smallint) OWNER TO root;

--
-- TOC entry 621 (class 1255 OID 17978)
-- Dependencies: 1068 3 1066 1066
-- Name: _ltree_extract_isparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_extract_isparent(ltree[], ltree) RETURNS ltree
    AS '$libdir/ltree', '_ltree_extract_isparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_extract_isparent(ltree[], ltree) OWNER TO root;

--
-- TOC entry 622 (class 1255 OID 17980)
-- Dependencies: 3 1066 1068 1066
-- Name: _ltree_extract_risparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_extract_risparent(ltree[], ltree) RETURNS ltree
    AS '$libdir/ltree', '_ltree_extract_risparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_extract_risparent(ltree[], ltree) OWNER TO root;

--
-- TOC entry 611 (class 1255 OID 17948)
-- Dependencies: 1068 1066 3
-- Name: _ltree_isparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_isparent(ltree[], ltree) RETURNS boolean
    AS '$libdir/ltree', '_ltree_isparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_isparent(ltree[], ltree) OWNER TO root;

--
-- TOC entry 627 (class 1255 OID 17988)
-- Dependencies: 3
-- Name: _ltree_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/ltree', '_ltree_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 628 (class 1255 OID 17989)
-- Dependencies: 3
-- Name: _ltree_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_picksplit(internal, internal) RETURNS internal
    AS '$libdir/ltree', '_ltree_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public._ltree_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 612 (class 1255 OID 17949)
-- Dependencies: 1066 1068 3
-- Name: _ltree_r_isparent(ltree, ltree[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_r_isparent(ltree, ltree[]) RETURNS boolean
    AS '$libdir/ltree', '_ltree_r_isparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_r_isparent(ltree, ltree[]) OWNER TO root;

--
-- TOC entry 614 (class 1255 OID 17951)
-- Dependencies: 1068 1066 3
-- Name: _ltree_r_risparent(ltree, ltree[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_r_risparent(ltree, ltree[]) RETURNS boolean
    AS '$libdir/ltree', '_ltree_r_risparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_r_risparent(ltree, ltree[]) OWNER TO root;

--
-- TOC entry 613 (class 1255 OID 17950)
-- Dependencies: 3 1066 1068
-- Name: _ltree_risparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_risparent(ltree[], ltree) RETURNS boolean
    AS '$libdir/ltree', '_ltree_risparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltree_risparent(ltree[], ltree) OWNER TO root;

--
-- TOC entry 630 (class 1255 OID 17991)
-- Dependencies: 3
-- Name: _ltree_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_same(internal, internal, internal) RETURNS internal
    AS '$libdir/ltree', '_ltree_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public._ltree_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 629 (class 1255 OID 17990)
-- Dependencies: 3
-- Name: _ltree_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltree_union(internal, internal) RETURNS integer
    AS '$libdir/ltree', '_ltree_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public._ltree_union(internal, internal) OWNER TO root;

--
-- TOC entry 619 (class 1255 OID 17956)
-- Dependencies: 1068 1072 3
-- Name: _ltxtq_exec(ltree[], ltxtquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltxtq_exec(ltree[], ltxtquery) RETURNS boolean
    AS '$libdir/ltree', '_ltxtq_exec'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltxtq_exec(ltree[], ltxtquery) OWNER TO root;

--
-- TOC entry 624 (class 1255 OID 17984)
-- Dependencies: 3 1072 1068 1066
-- Name: _ltxtq_extract_exec(ltree[], ltxtquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltxtq_extract_exec(ltree[], ltxtquery) RETURNS ltree
    AS '$libdir/ltree', '_ltxtq_extract_exec'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltxtq_extract_exec(ltree[], ltxtquery) OWNER TO root;

--
-- TOC entry 620 (class 1255 OID 17957)
-- Dependencies: 1072 1068 3
-- Name: _ltxtq_rexec(ltxtquery, ltree[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION _ltxtq_rexec(ltxtquery, ltree[]) RETURNS boolean
    AS '$libdir/ltree', '_ltxtq_rexec'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public._ltxtq_rexec(ltxtquery, ltree[]) OWNER TO root;

--
-- TOC entry 249 (class 1255 OID 17008)
-- Dependencies: 3 1029
-- Name: akeys(hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION akeys(hstore) RETURNS text[]
    AS '$libdir/hstore', 'akeys'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.akeys(hstore) OWNER TO root;

--
-- TOC entry 688 (class 1255 OID 18098)
-- Dependencies: 3
-- Name: armor(bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION armor(bytea) RETURNS text
    AS '$libdir/pgcrypto', 'pg_armor'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.armor(bytea) OWNER TO root;

--
-- TOC entry 718 (class 1255 OID 18172)
-- Dependencies: 3
-- Name: autoinc(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION autoinc() RETURNS trigger
    AS '$libdir/autoinc', 'autoinc'
    LANGUAGE c;


ALTER FUNCTION public.autoinc() OWNER TO root;

--
-- TOC entry 250 (class 1255 OID 17009)
-- Dependencies: 3 1029
-- Name: avals(hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION avals(hstore) RETURNS text[]
    AS '$libdir/hstore', 'avals'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.avals(hstore) OWNER TO root;

--
-- TOC entry 272 (class 1255 OID 17056)
-- Dependencies: 1035 3
-- Name: boolop(integer[], query_int); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION boolop(integer[], query_int) RETURNS boolean
    AS '$libdir/_int', 'boolop'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.boolop(integer[], query_int) OWNER TO root;

--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 272
-- Name: FUNCTION boolop(integer[], query_int); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION boolop(integer[], query_int) IS 'boolean operation with array';


--
-- TOC entry 634 (class 1255 OID 18012)
-- Dependencies: 3
-- Name: bt_metap(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION bt_metap(relname text, OUT magic integer, OUT version integer, OUT root integer, OUT level integer, OUT fastroot integer, OUT fastlevel integer) RETURNS record
    AS '$libdir/pageinspect', 'bt_metap'
    LANGUAGE c STRICT;


ALTER FUNCTION public.bt_metap(relname text, OUT magic integer, OUT version integer, OUT root integer, OUT level integer, OUT fastroot integer, OUT fastlevel integer) OWNER TO root;

--
-- TOC entry 636 (class 1255 OID 18014)
-- Dependencies: 3
-- Name: bt_page_items(text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION bt_page_items(relname text, blkno integer, OUT itemoffset smallint, OUT ctid tid, OUT itemlen smallint, OUT nulls boolean, OUT vars boolean, OUT data text) RETURNS SETOF record
    AS '$libdir/pageinspect', 'bt_page_items'
    LANGUAGE c STRICT;


ALTER FUNCTION public.bt_page_items(relname text, blkno integer, OUT itemoffset smallint, OUT ctid tid, OUT itemlen smallint, OUT nulls boolean, OUT vars boolean, OUT data text) OWNER TO root;

--
-- TOC entry 635 (class 1255 OID 18013)
-- Dependencies: 3
-- Name: bt_page_stats(text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION bt_page_stats(relname text, blkno integer, OUT blkno integer, OUT type "char", OUT live_items integer, OUT dead_items integer, OUT avg_item_size integer, OUT page_size integer, OUT free_size integer, OUT btpo_prev integer, OUT btpo_next integer, OUT btpo integer, OUT btpo_flags integer) RETURNS record
    AS '$libdir/pageinspect', 'bt_page_stats'
    LANGUAGE c STRICT;


ALTER FUNCTION public.bt_page_stats(relname text, blkno integer, OUT blkno integer, OUT type "char", OUT live_items integer, OUT dead_items integer, OUT avg_item_size integer, OUT page_size integer, OUT free_size integer, OUT btpo_prev integer, OUT btpo_next integer, OUT btpo integer, OUT btpo_flags integer) OWNER TO root;

--
-- TOC entry 498 (class 1255 OID 17531)
-- Dependencies: 3 1041 1041
-- Name: btean13cmp(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, ean13) OWNER TO root;

--
-- TOC entry 500 (class 1255 OID 17543)
-- Dependencies: 1041 3 1044
-- Name: btean13cmp(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, isbn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, isbn13) OWNER TO root;

--
-- TOC entry 501 (class 1255 OID 17544)
-- Dependencies: 1047 1041 3
-- Name: btean13cmp(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, ismn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, ismn13) OWNER TO root;

--
-- TOC entry 502 (class 1255 OID 17545)
-- Dependencies: 1041 3 1050
-- Name: btean13cmp(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, issn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, issn13) OWNER TO root;

--
-- TOC entry 503 (class 1255 OID 17546)
-- Dependencies: 1053 1041 3
-- Name: btean13cmp(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, isbn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, isbn) OWNER TO root;

--
-- TOC entry 504 (class 1255 OID 17547)
-- Dependencies: 3 1041 1056
-- Name: btean13cmp(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, ismn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, ismn) OWNER TO root;

--
-- TOC entry 505 (class 1255 OID 17548)
-- Dependencies: 3 1041 1059
-- Name: btean13cmp(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, issn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, issn) OWNER TO root;

--
-- TOC entry 506 (class 1255 OID 17549)
-- Dependencies: 1062 1041 3
-- Name: btean13cmp(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btean13cmp(ean13, upc) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btean13cmp(ean13, upc) OWNER TO root;

--
-- TOC entry 507 (class 1255 OID 17599)
-- Dependencies: 3 1044 1044
-- Name: btisbn13cmp(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btisbn13cmp(isbn13, isbn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btisbn13cmp(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 509 (class 1255 OID 17611)
-- Dependencies: 3 1041 1044
-- Name: btisbn13cmp(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btisbn13cmp(isbn13, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btisbn13cmp(isbn13, ean13) OWNER TO root;

--
-- TOC entry 510 (class 1255 OID 17612)
-- Dependencies: 1053 3 1044
-- Name: btisbn13cmp(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btisbn13cmp(isbn13, isbn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btisbn13cmp(isbn13, isbn) OWNER TO root;

--
-- TOC entry 511 (class 1255 OID 17627)
-- Dependencies: 3 1053 1053
-- Name: btisbncmp(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btisbncmp(isbn, isbn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btisbncmp(isbn, isbn) OWNER TO root;

--
-- TOC entry 513 (class 1255 OID 17639)
-- Dependencies: 1053 3 1041
-- Name: btisbncmp(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btisbncmp(isbn, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btisbncmp(isbn, ean13) OWNER TO root;

--
-- TOC entry 514 (class 1255 OID 17640)
-- Dependencies: 1044 3 1053
-- Name: btisbncmp(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btisbncmp(isbn, isbn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btisbncmp(isbn, isbn13) OWNER TO root;

--
-- TOC entry 515 (class 1255 OID 17655)
-- Dependencies: 3 1047 1047
-- Name: btismn13cmp(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btismn13cmp(ismn13, ismn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btismn13cmp(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 517 (class 1255 OID 17667)
-- Dependencies: 1047 3 1041
-- Name: btismn13cmp(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btismn13cmp(ismn13, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btismn13cmp(ismn13, ean13) OWNER TO root;

--
-- TOC entry 518 (class 1255 OID 17668)
-- Dependencies: 1056 3 1047
-- Name: btismn13cmp(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btismn13cmp(ismn13, ismn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btismn13cmp(ismn13, ismn) OWNER TO root;

--
-- TOC entry 519 (class 1255 OID 17683)
-- Dependencies: 3 1056 1056
-- Name: btismncmp(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btismncmp(ismn, ismn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btismncmp(ismn, ismn) OWNER TO root;

--
-- TOC entry 521 (class 1255 OID 17695)
-- Dependencies: 3 1041 1056
-- Name: btismncmp(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btismncmp(ismn, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btismncmp(ismn, ean13) OWNER TO root;

--
-- TOC entry 522 (class 1255 OID 17696)
-- Dependencies: 3 1056 1047
-- Name: btismncmp(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btismncmp(ismn, ismn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btismncmp(ismn, ismn13) OWNER TO root;

--
-- TOC entry 523 (class 1255 OID 17711)
-- Dependencies: 1050 3 1050
-- Name: btissn13cmp(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btissn13cmp(issn13, issn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btissn13cmp(issn13, issn13) OWNER TO root;

--
-- TOC entry 525 (class 1255 OID 17723)
-- Dependencies: 1041 1050 3
-- Name: btissn13cmp(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btissn13cmp(issn13, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btissn13cmp(issn13, ean13) OWNER TO root;

--
-- TOC entry 526 (class 1255 OID 17724)
-- Dependencies: 1059 1050 3
-- Name: btissn13cmp(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btissn13cmp(issn13, issn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btissn13cmp(issn13, issn) OWNER TO root;

--
-- TOC entry 527 (class 1255 OID 17739)
-- Dependencies: 1059 1059 3
-- Name: btissncmp(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btissncmp(issn, issn) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btissncmp(issn, issn) OWNER TO root;

--
-- TOC entry 529 (class 1255 OID 17751)
-- Dependencies: 3 1041 1059
-- Name: btissncmp(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btissncmp(issn, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btissncmp(issn, ean13) OWNER TO root;

--
-- TOC entry 530 (class 1255 OID 17752)
-- Dependencies: 3 1050 1059
-- Name: btissncmp(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btissncmp(issn, issn13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btissncmp(issn, issn13) OWNER TO root;

--
-- TOC entry 531 (class 1255 OID 17767)
-- Dependencies: 1062 1062 3
-- Name: btupccmp(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btupccmp(upc, upc) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btupccmp(upc, upc) OWNER TO root;

--
-- TOC entry 533 (class 1255 OID 17779)
-- Dependencies: 1062 1041 3
-- Name: btupccmp(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION btupccmp(upc, ean13) RETURNS integer
    AS $$btint8cmp$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.btupccmp(upc, ean13) OWNER TO root;

--
-- TOC entry 661 (class 1255 OID 18071)
-- Dependencies: 3
-- Name: crypt(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION crypt(text, text) RETURNS text
    AS '$libdir/pgcrypto', 'pg_crypt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.crypt(text, text) OWNER TO root;

--
-- TOC entry 149 (class 1255 OID 16855)
-- Dependencies: 3 1020
-- Name: cube(double precision[], double precision[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube(double precision[], double precision[]) RETURNS cube
    AS '$libdir/cube', 'cube_a_f8_f8'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube(double precision[], double precision[]) OWNER TO root;

--
-- TOC entry 150 (class 1255 OID 16856)
-- Dependencies: 1020 3
-- Name: cube(double precision[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube(double precision[]) RETURNS cube
    AS '$libdir/cube', 'cube_a_f8'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube(double precision[]) OWNER TO root;

--
-- TOC entry 170 (class 1255 OID 16877)
-- Dependencies: 3 1020
-- Name: cube(double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube(double precision) RETURNS cube
    AS '$libdir/cube', 'cube_f8'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube(double precision) OWNER TO root;

--
-- TOC entry 171 (class 1255 OID 16878)
-- Dependencies: 1020 3
-- Name: cube(double precision, double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube(double precision, double precision) RETURNS cube
    AS '$libdir/cube', 'cube_f8_f8'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube(double precision, double precision) OWNER TO root;

--
-- TOC entry 172 (class 1255 OID 16879)
-- Dependencies: 1020 1020 3
-- Name: cube(cube, double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube(cube, double precision) RETURNS cube
    AS '$libdir/cube', 'cube_c_f8'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube(cube, double precision) OWNER TO root;

--
-- TOC entry 173 (class 1255 OID 16880)
-- Dependencies: 3 1020 1020
-- Name: cube(cube, double precision, double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube(cube, double precision, double precision) RETURNS cube
    AS '$libdir/cube', 'cube_c_f8_f8'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube(cube, double precision, double precision) OWNER TO root;

--
-- TOC entry 158 (class 1255 OID 16865)
-- Dependencies: 1020 3 1020
-- Name: cube_cmp(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_cmp(cube, cube) RETURNS integer
    AS '$libdir/cube', 'cube_cmp'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_cmp(cube, cube) OWNER TO root;

--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 158
-- Name: FUNCTION cube_cmp(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_cmp(cube, cube) IS 'btree comparison function';


--
-- TOC entry 160 (class 1255 OID 16867)
-- Dependencies: 3 1020 1020
-- Name: cube_contained(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_contained(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_contained(cube, cube) OWNER TO root;

--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 160
-- Name: FUNCTION cube_contained(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_contained(cube, cube) IS 'contained in';


--
-- TOC entry 159 (class 1255 OID 16866)
-- Dependencies: 1020 1020 3
-- Name: cube_contains(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_contains(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_contains(cube, cube) OWNER TO root;

--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 159
-- Name: FUNCTION cube_contains(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_contains(cube, cube) IS 'contains';


--
-- TOC entry 175 (class 1255 OID 16882)
-- Dependencies: 1020 3 1020
-- Name: cube_enlarge(cube, double precision, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_enlarge(cube, double precision, integer) RETURNS cube
    AS '$libdir/cube', 'cube_enlarge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_enlarge(cube, double precision, integer) OWNER TO root;

--
-- TOC entry 152 (class 1255 OID 16859)
-- Dependencies: 3 1020 1020
-- Name: cube_eq(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_eq(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_eq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_eq(cube, cube) OWNER TO root;

--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 152
-- Name: FUNCTION cube_eq(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_eq(cube, cube) IS 'same as';


--
-- TOC entry 157 (class 1255 OID 16864)
-- Dependencies: 1020 3 1020
-- Name: cube_ge(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_ge(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_ge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_ge(cube, cube) OWNER TO root;

--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 157
-- Name: FUNCTION cube_ge(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_ge(cube, cube) IS 'greater than or equal to';


--
-- TOC entry 155 (class 1255 OID 16862)
-- Dependencies: 1020 3 1020
-- Name: cube_gt(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_gt(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_gt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_gt(cube, cube) OWNER TO root;

--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 155
-- Name: FUNCTION cube_gt(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_gt(cube, cube) IS 'greater than';


--
-- TOC entry 163 (class 1255 OID 16870)
-- Dependencies: 1020 1020 1020 3
-- Name: cube_inter(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_inter(cube, cube) RETURNS cube
    AS '$libdir/cube', 'cube_inter'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_inter(cube, cube) OWNER TO root;

--
-- TOC entry 156 (class 1255 OID 16863)
-- Dependencies: 1020 3 1020
-- Name: cube_le(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_le(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_le'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_le(cube, cube) OWNER TO root;

--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 156
-- Name: FUNCTION cube_le(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_le(cube, cube) IS 'lower than or equal to';


--
-- TOC entry 168 (class 1255 OID 16875)
-- Dependencies: 3 1020
-- Name: cube_ll_coord(cube, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_ll_coord(cube, integer) RETURNS double precision
    AS '$libdir/cube', 'cube_ll_coord'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_ll_coord(cube, integer) OWNER TO root;

--
-- TOC entry 154 (class 1255 OID 16861)
-- Dependencies: 1020 1020 3
-- Name: cube_lt(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_lt(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_lt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_lt(cube, cube) OWNER TO root;

--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 154
-- Name: FUNCTION cube_lt(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_lt(cube, cube) IS 'lower than';


--
-- TOC entry 153 (class 1255 OID 16860)
-- Dependencies: 1020 3 1020
-- Name: cube_ne(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_ne(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_ne'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_ne(cube, cube) OWNER TO root;

--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 153
-- Name: FUNCTION cube_ne(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_ne(cube, cube) IS 'different';


--
-- TOC entry 161 (class 1255 OID 16868)
-- Dependencies: 1020 1020 3
-- Name: cube_overlap(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_overlap(cube, cube) RETURNS boolean
    AS '$libdir/cube', 'cube_overlap'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_overlap(cube, cube) OWNER TO root;

--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 161
-- Name: FUNCTION cube_overlap(cube, cube); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION cube_overlap(cube, cube) IS 'overlaps';


--
-- TOC entry 164 (class 1255 OID 16871)
-- Dependencies: 1020 3
-- Name: cube_size(cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_size(cube) RETURNS double precision
    AS '$libdir/cube', 'cube_size'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_size(cube) OWNER TO root;

--
-- TOC entry 165 (class 1255 OID 16872)
-- Dependencies: 1020 1020 3
-- Name: cube_subset(cube, integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_subset(cube, integer[]) RETURNS cube
    AS '$libdir/cube', 'cube_subset'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_subset(cube, integer[]) OWNER TO root;

--
-- TOC entry 162 (class 1255 OID 16869)
-- Dependencies: 1020 3 1020 1020
-- Name: cube_union(cube, cube); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_union(cube, cube) RETURNS cube
    AS '$libdir/cube', 'cube_union'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_union(cube, cube) OWNER TO root;

--
-- TOC entry 169 (class 1255 OID 16876)
-- Dependencies: 3 1020
-- Name: cube_ur_coord(cube, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cube_ur_coord(cube, integer) RETURNS double precision
    AS '$libdir/cube', 'cube_ur_coord'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.cube_ur_coord(cube, integer) OWNER TO root;

--
-- TOC entry 201 (class 1255 OID 16942)
-- Dependencies: 3
-- Name: dblink(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink(text, text) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_record'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink(text, text) OWNER TO root;

--
-- TOC entry 202 (class 1255 OID 16943)
-- Dependencies: 3
-- Name: dblink(text, text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink(text, text, boolean) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_record'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink(text, text, boolean) OWNER TO root;

--
-- TOC entry 203 (class 1255 OID 16944)
-- Dependencies: 3
-- Name: dblink(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink(text) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_record'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink(text) OWNER TO root;

--
-- TOC entry 204 (class 1255 OID 16945)
-- Dependencies: 3
-- Name: dblink(text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink(text, boolean) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_record'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink(text, boolean) OWNER TO root;

--
-- TOC entry 211 (class 1255 OID 16955)
-- Dependencies: 3
-- Name: dblink_build_sql_delete(text, int2vector, integer, text[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_build_sql_delete(text, int2vector, integer, text[]) RETURNS text
    AS '$libdir/dblink', 'dblink_build_sql_delete'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_build_sql_delete(text, int2vector, integer, text[]) OWNER TO root;

--
-- TOC entry 210 (class 1255 OID 16954)
-- Dependencies: 3
-- Name: dblink_build_sql_insert(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_build_sql_insert(text, int2vector, integer, text[], text[]) RETURNS text
    AS '$libdir/dblink', 'dblink_build_sql_insert'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_build_sql_insert(text, int2vector, integer, text[], text[]) OWNER TO root;

--
-- TOC entry 212 (class 1255 OID 16956)
-- Dependencies: 3
-- Name: dblink_build_sql_update(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_build_sql_update(text, int2vector, integer, text[], text[]) RETURNS text
    AS '$libdir/dblink', 'dblink_build_sql_update'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_build_sql_update(text, int2vector, integer, text[], text[]) OWNER TO root;

--
-- TOC entry 219 (class 1255 OID 16963)
-- Dependencies: 3
-- Name: dblink_cancel_query(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_cancel_query(text) RETURNS text
    AS '$libdir/dblink', 'dblink_cancel_query'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_cancel_query(text) OWNER TO root;

--
-- TOC entry 197 (class 1255 OID 16938)
-- Dependencies: 3
-- Name: dblink_close(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_close(text) RETURNS text
    AS '$libdir/dblink', 'dblink_close'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_close(text) OWNER TO root;

--
-- TOC entry 198 (class 1255 OID 16939)
-- Dependencies: 3
-- Name: dblink_close(text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_close(text, boolean) RETURNS text
    AS '$libdir/dblink', 'dblink_close'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_close(text, boolean) OWNER TO root;

--
-- TOC entry 199 (class 1255 OID 16940)
-- Dependencies: 3
-- Name: dblink_close(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_close(text, text) RETURNS text
    AS '$libdir/dblink', 'dblink_close'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_close(text, text) OWNER TO root;

--
-- TOC entry 200 (class 1255 OID 16941)
-- Dependencies: 3
-- Name: dblink_close(text, text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_close(text, text, boolean) RETURNS text
    AS '$libdir/dblink', 'dblink_close'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_close(text, text, boolean) OWNER TO root;

--
-- TOC entry 183 (class 1255 OID 16924)
-- Dependencies: 3
-- Name: dblink_connect(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_connect(text) RETURNS text
    AS '$libdir/dblink', 'dblink_connect'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_connect(text) OWNER TO root;

--
-- TOC entry 184 (class 1255 OID 16925)
-- Dependencies: 3
-- Name: dblink_connect(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_connect(text, text) RETURNS text
    AS '$libdir/dblink', 'dblink_connect'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_connect(text, text) OWNER TO root;

--
-- TOC entry 185 (class 1255 OID 16926)
-- Dependencies: 3
-- Name: dblink_connect_u(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_connect_u(text) RETURNS text
    AS '$libdir/dblink', 'dblink_connect'
    LANGUAGE c STRICT SECURITY DEFINER;


ALTER FUNCTION public.dblink_connect_u(text) OWNER TO root;

--
-- TOC entry 186 (class 1255 OID 16927)
-- Dependencies: 3
-- Name: dblink_connect_u(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_connect_u(text, text) RETURNS text
    AS '$libdir/dblink', 'dblink_connect'
    LANGUAGE c STRICT SECURITY DEFINER;


ALTER FUNCTION public.dblink_connect_u(text, text) OWNER TO root;

--
-- TOC entry 213 (class 1255 OID 16957)
-- Dependencies: 3
-- Name: dblink_current_query(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_current_query() RETURNS text
    AS '$libdir/dblink', 'dblink_current_query'
    LANGUAGE c;


ALTER FUNCTION public.dblink_current_query() OWNER TO root;

--
-- TOC entry 187 (class 1255 OID 16928)
-- Dependencies: 3
-- Name: dblink_disconnect(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_disconnect() RETURNS text
    AS '$libdir/dblink', 'dblink_disconnect'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_disconnect() OWNER TO root;

--
-- TOC entry 188 (class 1255 OID 16929)
-- Dependencies: 3
-- Name: dblink_disconnect(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_disconnect(text) RETURNS text
    AS '$libdir/dblink', 'dblink_disconnect'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_disconnect(text) OWNER TO root;

--
-- TOC entry 220 (class 1255 OID 16964)
-- Dependencies: 3
-- Name: dblink_error_message(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_error_message(text) RETURNS text
    AS '$libdir/dblink', 'dblink_error_message'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_error_message(text) OWNER TO root;

--
-- TOC entry 205 (class 1255 OID 16946)
-- Dependencies: 3
-- Name: dblink_exec(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_exec(text, text) RETURNS text
    AS '$libdir/dblink', 'dblink_exec'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_exec(text, text) OWNER TO root;

--
-- TOC entry 206 (class 1255 OID 16947)
-- Dependencies: 3
-- Name: dblink_exec(text, text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_exec(text, text, boolean) RETURNS text
    AS '$libdir/dblink', 'dblink_exec'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_exec(text, text, boolean) OWNER TO root;

--
-- TOC entry 207 (class 1255 OID 16948)
-- Dependencies: 3
-- Name: dblink_exec(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_exec(text) RETURNS text
    AS '$libdir/dblink', 'dblink_exec'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_exec(text) OWNER TO root;

--
-- TOC entry 208 (class 1255 OID 16949)
-- Dependencies: 3
-- Name: dblink_exec(text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_exec(text, boolean) RETURNS text
    AS '$libdir/dblink', 'dblink_exec'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_exec(text, boolean) OWNER TO root;

--
-- TOC entry 193 (class 1255 OID 16934)
-- Dependencies: 3
-- Name: dblink_fetch(text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_fetch(text, integer) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_fetch'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_fetch(text, integer) OWNER TO root;

--
-- TOC entry 194 (class 1255 OID 16935)
-- Dependencies: 3
-- Name: dblink_fetch(text, integer, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_fetch(text, integer, boolean) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_fetch'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_fetch(text, integer, boolean) OWNER TO root;

--
-- TOC entry 195 (class 1255 OID 16936)
-- Dependencies: 3
-- Name: dblink_fetch(text, text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_fetch(text, text, integer) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_fetch'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_fetch(text, text, integer) OWNER TO root;

--
-- TOC entry 196 (class 1255 OID 16937)
-- Dependencies: 3
-- Name: dblink_fetch(text, text, integer, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_fetch(text, text, integer, boolean) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_fetch'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_fetch(text, text, integer, boolean) OWNER TO root;

--
-- TOC entry 218 (class 1255 OID 16962)
-- Dependencies: 3
-- Name: dblink_get_connections(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_get_connections() RETURNS text[]
    AS '$libdir/dblink', 'dblink_get_connections'
    LANGUAGE c;


ALTER FUNCTION public.dblink_get_connections() OWNER TO root;

--
-- TOC entry 209 (class 1255 OID 16953)
-- Dependencies: 1023 3
-- Name: dblink_get_pkey(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_get_pkey(text) RETURNS SETOF dblink_pkey_results
    AS '$libdir/dblink', 'dblink_get_pkey'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_get_pkey(text) OWNER TO root;

--
-- TOC entry 216 (class 1255 OID 16960)
-- Dependencies: 3
-- Name: dblink_get_result(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_get_result(text) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_get_result'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_get_result(text) OWNER TO root;

--
-- TOC entry 217 (class 1255 OID 16961)
-- Dependencies: 3
-- Name: dblink_get_result(text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_get_result(text, boolean) RETURNS SETOF record
    AS '$libdir/dblink', 'dblink_get_result'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_get_result(text, boolean) OWNER TO root;

--
-- TOC entry 215 (class 1255 OID 16959)
-- Dependencies: 3
-- Name: dblink_is_busy(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_is_busy(text) RETURNS integer
    AS '$libdir/dblink', 'dblink_is_busy'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_is_busy(text) OWNER TO root;

--
-- TOC entry 189 (class 1255 OID 16930)
-- Dependencies: 3
-- Name: dblink_open(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_open(text, text) RETURNS text
    AS '$libdir/dblink', 'dblink_open'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_open(text, text) OWNER TO root;

--
-- TOC entry 190 (class 1255 OID 16931)
-- Dependencies: 3
-- Name: dblink_open(text, text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_open(text, text, boolean) RETURNS text
    AS '$libdir/dblink', 'dblink_open'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_open(text, text, boolean) OWNER TO root;

--
-- TOC entry 191 (class 1255 OID 16932)
-- Dependencies: 3
-- Name: dblink_open(text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_open(text, text, text) RETURNS text
    AS '$libdir/dblink', 'dblink_open'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_open(text, text, text) OWNER TO root;

--
-- TOC entry 192 (class 1255 OID 16933)
-- Dependencies: 3
-- Name: dblink_open(text, text, text, boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_open(text, text, text, boolean) RETURNS text
    AS '$libdir/dblink', 'dblink_open'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_open(text, text, text, boolean) OWNER TO root;

--
-- TOC entry 214 (class 1255 OID 16958)
-- Dependencies: 3
-- Name: dblink_send_query(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dblink_send_query(text, text) RETURNS integer
    AS '$libdir/dblink', 'dblink_send_query'
    LANGUAGE c STRICT;


ALTER FUNCTION public.dblink_send_query(text, text) OWNER TO root;

--
-- TOC entry 689 (class 1255 OID 18099)
-- Dependencies: 3
-- Name: dearmor(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dearmor(text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_dearmor'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.dearmor(text) OWNER TO root;

--
-- TOC entry 665 (class 1255 OID 18075)
-- Dependencies: 3
-- Name: decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION decrypt(bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_decrypt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.decrypt(bytea, bytea, text) OWNER TO root;

--
-- TOC entry 667 (class 1255 OID 18077)
-- Dependencies: 3
-- Name: decrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION decrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_decrypt_iv'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) OWNER TO root;

--
-- TOC entry 243 (class 1255 OID 16996)
-- Dependencies: 3 1029
-- Name: defined(hstore, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION defined(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'defined'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.defined(hstore, text) OWNER TO root;

--
-- TOC entry 244 (class 1255 OID 16997)
-- Dependencies: 3 1029 1029
-- Name: delete(hstore, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION delete(hstore, text) RETURNS hstore
    AS '$libdir/hstore', 'delete'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.delete(hstore, text) OWNER TO root;

--
-- TOC entry 234 (class 1255 OID 16983)
-- Dependencies: 3
-- Name: difference(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION difference(text, text) RETURNS integer
    AS '$libdir/fuzzystrmatch', 'difference'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.difference(text, text) OWNER TO root;

--
-- TOC entry 657 (class 1255 OID 18067)
-- Dependencies: 3
-- Name: digest(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION digest(text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_digest'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.digest(text, text) OWNER TO root;

--
-- TOC entry 658 (class 1255 OID 18068)
-- Dependencies: 3
-- Name: digest(bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION digest(bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_digest'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.digest(bytea, text) OWNER TO root;

--
-- TOC entry 235 (class 1255 OID 16984)
-- Dependencies: 3
-- Name: dmetaphone(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dmetaphone(text) RETURNS text
    AS '$libdir/fuzzystrmatch', 'dmetaphone'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.dmetaphone(text) OWNER TO root;

--
-- TOC entry 236 (class 1255 OID 16985)
-- Dependencies: 3
-- Name: dmetaphone_alt(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION dmetaphone_alt(text) RETURNS text
    AS '$libdir/fuzzystrmatch', 'dmetaphone_alt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.dmetaphone_alt(text) OWNER TO root;

--
-- TOC entry 253 (class 1255 OID 17012)
-- Dependencies: 3 1029
-- Name: each(hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION each(hs hstore, OUT key text, OUT value text) RETURNS SETOF record
    AS '$libdir/hstore', 'each'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.each(hs hstore, OUT key text, OUT value text) OWNER TO root;

--
-- TOC entry 228 (class 1255 OID 16976)
-- Dependencies: 1025 1020 3
-- Name: earth_box(earth, double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION earth_box(earth, double precision) RETURNS cube
    AS $_$SELECT cube_enlarge($1, gc_to_sec($2), 3)$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.earth_box(earth, double precision) OWNER TO root;

--
-- TOC entry 227 (class 1255 OID 16975)
-- Dependencies: 1025 1025 3
-- Name: earth_distance(earth, earth); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION earth_distance(earth, earth) RETURNS double precision
    AS $_$SELECT sec_to_gc(cube_distance($1, $2))$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.earth_distance(earth, earth) OWNER TO root;

--
-- TOC entry 664 (class 1255 OID 18074)
-- Dependencies: 3
-- Name: encrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION encrypt(bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_encrypt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.encrypt(bytea, bytea, text) OWNER TO root;

--
-- TOC entry 666 (class 1255 OID 18076)
-- Dependencies: 3
-- Name: encrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION encrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_encrypt_iv'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) OWNER TO root;

--
-- TOC entry 146 (class 1255 OID 16849)
-- Dependencies: 3 1017
-- Name: eq(chkpass, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION eq(chkpass, text) RETURNS boolean
    AS '$libdir/chkpass', 'chkpass_eq'
    LANGUAGE c STRICT;


ALTER FUNCTION public.eq(chkpass, text) OWNER TO root;

--
-- TOC entry 241 (class 1255 OID 16993)
-- Dependencies: 3 1029
-- Name: exist(hstore, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION exist(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'exists'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.exist(hstore, text) OWNER TO root;

--
-- TOC entry 239 (class 1255 OID 16990)
-- Dependencies: 3 1029
-- Name: fetchval(hstore, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION fetchval(hstore, text) RETURNS text
    AS '$libdir/hstore', 'fetchval'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.fetchval(hstore, text) OWNER TO root;

--
-- TOC entry 177 (class 1255 OID 16895)
-- Dependencies: 3
-- Name: g_cube_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_compress(internal) RETURNS internal
    AS '$libdir/cube', 'g_cube_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_cube_compress(internal) OWNER TO root;

--
-- TOC entry 176 (class 1255 OID 16894)
-- Dependencies: 1020 3
-- Name: g_cube_consistent(internal, cube, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_consistent(internal, cube, integer) RETURNS boolean
    AS '$libdir/cube', 'g_cube_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_cube_consistent(internal, cube, integer) OWNER TO root;

--
-- TOC entry 178 (class 1255 OID 16896)
-- Dependencies: 3
-- Name: g_cube_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_decompress(internal) RETURNS internal
    AS '$libdir/cube', 'g_cube_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_cube_decompress(internal) OWNER TO root;

--
-- TOC entry 179 (class 1255 OID 16897)
-- Dependencies: 3
-- Name: g_cube_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/cube', 'g_cube_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.g_cube_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 180 (class 1255 OID 16898)
-- Dependencies: 3
-- Name: g_cube_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_picksplit(internal, internal) RETURNS internal
    AS '$libdir/cube', 'g_cube_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_cube_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 182 (class 1255 OID 16900)
-- Dependencies: 3 1020 1020
-- Name: g_cube_same(cube, cube, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_same(cube, cube, internal) RETURNS internal
    AS '$libdir/cube', 'g_cube_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_cube_same(cube, cube, internal) OWNER TO root;

--
-- TOC entry 181 (class 1255 OID 16899)
-- Dependencies: 1020 3
-- Name: g_cube_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_cube_union(internal, internal) RETURNS cube
    AS '$libdir/cube', 'g_cube_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_cube_union(internal, internal) OWNER TO root;

--
-- TOC entry 297 (class 1255 OID 17097)
-- Dependencies: 3
-- Name: g_int_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_compress(internal) RETURNS internal
    AS '$libdir/_int', 'g_int_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_compress(internal) OWNER TO root;

--
-- TOC entry 296 (class 1255 OID 17096)
-- Dependencies: 3
-- Name: g_int_consistent(internal, integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_consistent(internal, integer[], integer) RETURNS boolean
    AS '$libdir/_int', 'g_int_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_consistent(internal, integer[], integer) OWNER TO root;

--
-- TOC entry 298 (class 1255 OID 17098)
-- Dependencies: 3
-- Name: g_int_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_decompress(internal) RETURNS internal
    AS '$libdir/_int', 'g_int_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_decompress(internal) OWNER TO root;

--
-- TOC entry 299 (class 1255 OID 17099)
-- Dependencies: 3
-- Name: g_int_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_int_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.g_int_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 300 (class 1255 OID 17100)
-- Dependencies: 3
-- Name: g_int_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_picksplit(internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_int_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 302 (class 1255 OID 17102)
-- Dependencies: 3
-- Name: g_int_same(integer[], integer[], internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_same(integer[], integer[], internal) RETURNS internal
    AS '$libdir/_int', 'g_int_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_same(integer[], integer[], internal) OWNER TO root;

--
-- TOC entry 301 (class 1255 OID 17101)
-- Dependencies: 3
-- Name: g_int_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_int_union(internal, internal) RETURNS integer[]
    AS '$libdir/_int', 'g_int_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_int_union(internal, internal) OWNER TO root;

--
-- TOC entry 306 (class 1255 OID 17124)
-- Dependencies: 3
-- Name: g_intbig_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_compress(internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_compress(internal) OWNER TO root;

--
-- TOC entry 305 (class 1255 OID 17123)
-- Dependencies: 3
-- Name: g_intbig_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_consistent(internal, internal, integer) RETURNS boolean
    AS '$libdir/_int', 'g_intbig_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_consistent(internal, internal, integer) OWNER TO root;

--
-- TOC entry 307 (class 1255 OID 17125)
-- Dependencies: 3
-- Name: g_intbig_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_decompress(internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_decompress(internal) OWNER TO root;

--
-- TOC entry 308 (class 1255 OID 17126)
-- Dependencies: 3
-- Name: g_intbig_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.g_intbig_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 309 (class 1255 OID 17127)
-- Dependencies: 3
-- Name: g_intbig_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_picksplit(internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 311 (class 1255 OID 17129)
-- Dependencies: 3
-- Name: g_intbig_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_same(internal, internal, internal) RETURNS internal
    AS '$libdir/_int', 'g_intbig_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 310 (class 1255 OID 17128)
-- Dependencies: 3
-- Name: g_intbig_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION g_intbig_union(internal, internal) RETURNS integer[]
    AS '$libdir/_int', 'g_intbig_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.g_intbig_union(internal, internal) OWNER TO root;

--
-- TOC entry 132 (class 1255 OID 16777)
-- Dependencies: 3
-- Name: gbt_bit_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bit_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bit_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bit_compress(internal) OWNER TO root;

--
-- TOC entry 131 (class 1255 OID 16776)
-- Dependencies: 3
-- Name: gbt_bit_consistent(internal, bit, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bit_consistent(internal, bit, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_bit_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bit_consistent(internal, bit, smallint) OWNER TO root;

--
-- TOC entry 133 (class 1255 OID 16778)
-- Dependencies: 3
-- Name: gbt_bit_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bit_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bit_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_bit_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 134 (class 1255 OID 16779)
-- Dependencies: 3
-- Name: gbt_bit_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bit_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bit_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bit_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 136 (class 1255 OID 16781)
-- Dependencies: 3
-- Name: gbt_bit_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bit_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bit_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bit_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 135 (class 1255 OID 16780)
-- Dependencies: 3 1014
-- Name: gbt_bit_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bit_union(bytea, internal) RETURNS gbtreekey_var
    AS '$libdir/btree_gist', 'gbt_bit_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bit_union(bytea, internal) OWNER TO root;

--
-- TOC entry 114 (class 1255 OID 16703)
-- Dependencies: 3
-- Name: gbt_bpchar_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bpchar_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bpchar_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bpchar_compress(internal) OWNER TO root;

--
-- TOC entry 112 (class 1255 OID 16701)
-- Dependencies: 3
-- Name: gbt_bpchar_consistent(internal, character, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bpchar_consistent(internal, character, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_bpchar_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bpchar_consistent(internal, character, smallint) OWNER TO root;

--
-- TOC entry 120 (class 1255 OID 16737)
-- Dependencies: 3
-- Name: gbt_bytea_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bytea_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bytea_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bytea_compress(internal) OWNER TO root;

--
-- TOC entry 119 (class 1255 OID 16736)
-- Dependencies: 3
-- Name: gbt_bytea_consistent(internal, bytea, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bytea_consistent(internal, bytea, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_bytea_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bytea_consistent(internal, bytea, smallint) OWNER TO root;

--
-- TOC entry 121 (class 1255 OID 16738)
-- Dependencies: 3
-- Name: gbt_bytea_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bytea_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bytea_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_bytea_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 122 (class 1255 OID 16739)
-- Dependencies: 3
-- Name: gbt_bytea_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bytea_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bytea_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bytea_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 124 (class 1255 OID 16741)
-- Dependencies: 3
-- Name: gbt_bytea_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bytea_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_bytea_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bytea_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 123 (class 1255 OID 16740)
-- Dependencies: 1014 3
-- Name: gbt_bytea_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_bytea_union(bytea, internal) RETURNS gbtreekey_var
    AS '$libdir/btree_gist', 'gbt_bytea_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_bytea_union(bytea, internal) OWNER TO root;

--
-- TOC entry 100 (class 1255 OID 16661)
-- Dependencies: 3
-- Name: gbt_cash_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_cash_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_cash_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_cash_compress(internal) OWNER TO root;

--
-- TOC entry 99 (class 1255 OID 16660)
-- Dependencies: 3
-- Name: gbt_cash_consistent(internal, money, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_cash_consistent(internal, money, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_cash_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_cash_consistent(internal, money, smallint) OWNER TO root;

--
-- TOC entry 101 (class 1255 OID 16662)
-- Dependencies: 3
-- Name: gbt_cash_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_cash_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_cash_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_cash_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 102 (class 1255 OID 16663)
-- Dependencies: 3
-- Name: gbt_cash_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_cash_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_cash_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_cash_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 104 (class 1255 OID 16665)
-- Dependencies: 3
-- Name: gbt_cash_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_cash_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_cash_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_cash_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 103 (class 1255 OID 16664)
-- Dependencies: 3 1005
-- Name: gbt_cash_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_cash_union(bytea, internal) RETURNS gbtreekey8
    AS '$libdir/btree_gist', 'gbt_cash_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_cash_union(bytea, internal) OWNER TO root;

--
-- TOC entry 87 (class 1255 OID 16620)
-- Dependencies: 3
-- Name: gbt_date_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_date_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_date_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_date_compress(internal) OWNER TO root;

--
-- TOC entry 86 (class 1255 OID 16619)
-- Dependencies: 3
-- Name: gbt_date_consistent(internal, date, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_date_consistent(internal, date, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_date_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_date_consistent(internal, date, smallint) OWNER TO root;

--
-- TOC entry 88 (class 1255 OID 16621)
-- Dependencies: 3
-- Name: gbt_date_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_date_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_date_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_date_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 89 (class 1255 OID 16622)
-- Dependencies: 3
-- Name: gbt_date_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_date_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_date_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_date_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 91 (class 1255 OID 16624)
-- Dependencies: 3
-- Name: gbt_date_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_date_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_date_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_date_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 90 (class 1255 OID 16623)
-- Dependencies: 1005 3
-- Name: gbt_date_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_date_union(bytea, internal) RETURNS gbtreekey8
    AS '$libdir/btree_gist', 'gbt_date_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_date_union(bytea, internal) OWNER TO root;

--
-- TOC entry 34 (class 1255 OID 16427)
-- Dependencies: 3
-- Name: gbt_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_decompress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_decompress(internal) OWNER TO root;

--
-- TOC entry 59 (class 1255 OID 16508)
-- Dependencies: 3
-- Name: gbt_float4_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float4_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float4_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float4_compress(internal) OWNER TO root;

--
-- TOC entry 58 (class 1255 OID 16507)
-- Dependencies: 3
-- Name: gbt_float4_consistent(internal, real, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float4_consistent(internal, real, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_float4_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float4_consistent(internal, real, smallint) OWNER TO root;

--
-- TOC entry 60 (class 1255 OID 16509)
-- Dependencies: 3
-- Name: gbt_float4_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float4_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float4_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_float4_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 61 (class 1255 OID 16510)
-- Dependencies: 3
-- Name: gbt_float4_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float4_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float4_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float4_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 63 (class 1255 OID 16512)
-- Dependencies: 3
-- Name: gbt_float4_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float4_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float4_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float4_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 62 (class 1255 OID 16511)
-- Dependencies: 3 1005
-- Name: gbt_float4_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float4_union(bytea, internal) RETURNS gbtreekey8
    AS '$libdir/btree_gist', 'gbt_float4_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float4_union(bytea, internal) OWNER TO root;

--
-- TOC entry 65 (class 1255 OID 16528)
-- Dependencies: 3
-- Name: gbt_float8_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float8_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float8_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float8_compress(internal) OWNER TO root;

--
-- TOC entry 64 (class 1255 OID 16527)
-- Dependencies: 3
-- Name: gbt_float8_consistent(internal, double precision, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float8_consistent(internal, double precision, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_float8_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float8_consistent(internal, double precision, smallint) OWNER TO root;

--
-- TOC entry 66 (class 1255 OID 16529)
-- Dependencies: 3
-- Name: gbt_float8_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float8_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float8_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_float8_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 67 (class 1255 OID 16530)
-- Dependencies: 3
-- Name: gbt_float8_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float8_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float8_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float8_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 69 (class 1255 OID 16532)
-- Dependencies: 3
-- Name: gbt_float8_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float8_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_float8_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float8_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 68 (class 1255 OID 16531)
-- Dependencies: 3 1008
-- Name: gbt_float8_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_float8_union(bytea, internal) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbt_float8_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_float8_union(bytea, internal) OWNER TO root;

--
-- TOC entry 138 (class 1255 OID 16811)
-- Dependencies: 3
-- Name: gbt_inet_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_inet_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_inet_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_inet_compress(internal) OWNER TO root;

--
-- TOC entry 137 (class 1255 OID 16810)
-- Dependencies: 3
-- Name: gbt_inet_consistent(internal, inet, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_inet_consistent(internal, inet, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_inet_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_inet_consistent(internal, inet, smallint) OWNER TO root;

--
-- TOC entry 139 (class 1255 OID 16812)
-- Dependencies: 3
-- Name: gbt_inet_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_inet_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_inet_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_inet_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 140 (class 1255 OID 16813)
-- Dependencies: 3
-- Name: gbt_inet_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_inet_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_inet_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_inet_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 142 (class 1255 OID 16815)
-- Dependencies: 3
-- Name: gbt_inet_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_inet_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_inet_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_inet_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 141 (class 1255 OID 16814)
-- Dependencies: 1008 3
-- Name: gbt_inet_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_inet_union(bytea, internal) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbt_inet_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_inet_union(bytea, internal) OWNER TO root;

--
-- TOC entry 41 (class 1255 OID 16448)
-- Dependencies: 3
-- Name: gbt_int2_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int2_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int2_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int2_compress(internal) OWNER TO root;

--
-- TOC entry 40 (class 1255 OID 16447)
-- Dependencies: 3
-- Name: gbt_int2_consistent(internal, smallint, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int2_consistent(internal, smallint, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_int2_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int2_consistent(internal, smallint, smallint) OWNER TO root;

--
-- TOC entry 42 (class 1255 OID 16449)
-- Dependencies: 3
-- Name: gbt_int2_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int2_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int2_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_int2_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 43 (class 1255 OID 16450)
-- Dependencies: 3
-- Name: gbt_int2_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int2_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int2_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int2_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 45 (class 1255 OID 16452)
-- Dependencies: 3
-- Name: gbt_int2_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int2_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int2_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int2_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 44 (class 1255 OID 16451)
-- Dependencies: 3 966
-- Name: gbt_int2_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int2_union(bytea, internal) RETURNS gbtreekey4
    AS '$libdir/btree_gist', 'gbt_int2_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int2_union(bytea, internal) OWNER TO root;

--
-- TOC entry 47 (class 1255 OID 16468)
-- Dependencies: 3
-- Name: gbt_int4_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int4_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int4_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int4_compress(internal) OWNER TO root;

--
-- TOC entry 46 (class 1255 OID 16467)
-- Dependencies: 3
-- Name: gbt_int4_consistent(internal, integer, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int4_consistent(internal, integer, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_int4_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int4_consistent(internal, integer, smallint) OWNER TO root;

--
-- TOC entry 48 (class 1255 OID 16469)
-- Dependencies: 3
-- Name: gbt_int4_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int4_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int4_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_int4_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 49 (class 1255 OID 16470)
-- Dependencies: 3
-- Name: gbt_int4_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int4_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int4_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int4_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 51 (class 1255 OID 16472)
-- Dependencies: 3
-- Name: gbt_int4_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int4_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int4_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int4_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 50 (class 1255 OID 16471)
-- Dependencies: 1005 3
-- Name: gbt_int4_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int4_union(bytea, internal) RETURNS gbtreekey8
    AS '$libdir/btree_gist', 'gbt_int4_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int4_union(bytea, internal) OWNER TO root;

--
-- TOC entry 53 (class 1255 OID 16488)
-- Dependencies: 3
-- Name: gbt_int8_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int8_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int8_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int8_compress(internal) OWNER TO root;

--
-- TOC entry 52 (class 1255 OID 16487)
-- Dependencies: 3
-- Name: gbt_int8_consistent(internal, bigint, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int8_consistent(internal, bigint, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_int8_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int8_consistent(internal, bigint, smallint) OWNER TO root;

--
-- TOC entry 54 (class 1255 OID 16489)
-- Dependencies: 3
-- Name: gbt_int8_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int8_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int8_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_int8_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 55 (class 1255 OID 16490)
-- Dependencies: 3
-- Name: gbt_int8_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int8_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int8_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int8_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 57 (class 1255 OID 16492)
-- Dependencies: 3
-- Name: gbt_int8_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int8_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_int8_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int8_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 56 (class 1255 OID 16491)
-- Dependencies: 1008 3
-- Name: gbt_int8_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_int8_union(bytea, internal) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbt_int8_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_int8_union(bytea, internal) OWNER TO root;

--
-- TOC entry 93 (class 1255 OID 16640)
-- Dependencies: 3
-- Name: gbt_intv_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_intv_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_intv_compress(internal) OWNER TO root;

--
-- TOC entry 92 (class 1255 OID 16639)
-- Dependencies: 3
-- Name: gbt_intv_consistent(internal, interval, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_consistent(internal, interval, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_intv_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_intv_consistent(internal, interval, smallint) OWNER TO root;

--
-- TOC entry 94 (class 1255 OID 16641)
-- Dependencies: 3
-- Name: gbt_intv_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_decompress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_intv_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_intv_decompress(internal) OWNER TO root;

--
-- TOC entry 95 (class 1255 OID 16642)
-- Dependencies: 3
-- Name: gbt_intv_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_intv_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_intv_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 96 (class 1255 OID 16643)
-- Dependencies: 3
-- Name: gbt_intv_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_intv_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_intv_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 98 (class 1255 OID 16645)
-- Dependencies: 3
-- Name: gbt_intv_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_intv_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_intv_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 97 (class 1255 OID 16644)
-- Dependencies: 1011 3
-- Name: gbt_intv_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_intv_union(bytea, internal) RETURNS gbtreekey32
    AS '$libdir/btree_gist', 'gbt_intv_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_intv_union(bytea, internal) OWNER TO root;

--
-- TOC entry 106 (class 1255 OID 16681)
-- Dependencies: 3
-- Name: gbt_macad_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_macad_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_macad_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_macad_compress(internal) OWNER TO root;

--
-- TOC entry 105 (class 1255 OID 16680)
-- Dependencies: 3
-- Name: gbt_macad_consistent(internal, macaddr, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_macad_consistent(internal, macaddr, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_macad_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_macad_consistent(internal, macaddr, smallint) OWNER TO root;

--
-- TOC entry 107 (class 1255 OID 16682)
-- Dependencies: 3
-- Name: gbt_macad_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_macad_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_macad_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_macad_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 108 (class 1255 OID 16683)
-- Dependencies: 3
-- Name: gbt_macad_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_macad_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_macad_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_macad_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 110 (class 1255 OID 16685)
-- Dependencies: 3
-- Name: gbt_macad_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_macad_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_macad_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_macad_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 109 (class 1255 OID 16684)
-- Dependencies: 1008 3
-- Name: gbt_macad_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_macad_union(bytea, internal) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbt_macad_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_macad_union(bytea, internal) OWNER TO root;

--
-- TOC entry 126 (class 1255 OID 16757)
-- Dependencies: 3
-- Name: gbt_numeric_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_numeric_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_numeric_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_numeric_compress(internal) OWNER TO root;

--
-- TOC entry 125 (class 1255 OID 16756)
-- Dependencies: 3
-- Name: gbt_numeric_consistent(internal, numeric, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_numeric_consistent(internal, numeric, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_numeric_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_numeric_consistent(internal, numeric, smallint) OWNER TO root;

--
-- TOC entry 127 (class 1255 OID 16758)
-- Dependencies: 3
-- Name: gbt_numeric_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_numeric_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_numeric_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_numeric_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 128 (class 1255 OID 16759)
-- Dependencies: 3
-- Name: gbt_numeric_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_numeric_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_numeric_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_numeric_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 130 (class 1255 OID 16761)
-- Dependencies: 3
-- Name: gbt_numeric_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_numeric_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_numeric_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_numeric_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 129 (class 1255 OID 16760)
-- Dependencies: 3 1014
-- Name: gbt_numeric_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_numeric_union(bytea, internal) RETURNS gbtreekey_var
    AS '$libdir/btree_gist', 'gbt_numeric_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_numeric_union(bytea, internal) OWNER TO root;

--
-- TOC entry 33 (class 1255 OID 16426)
-- Dependencies: 3
-- Name: gbt_oid_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_oid_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_oid_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_oid_compress(internal) OWNER TO root;

--
-- TOC entry 32 (class 1255 OID 16425)
-- Dependencies: 3
-- Name: gbt_oid_consistent(internal, oid, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_oid_consistent(internal, oid, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_oid_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_oid_consistent(internal, oid, smallint) OWNER TO root;

--
-- TOC entry 36 (class 1255 OID 16429)
-- Dependencies: 3
-- Name: gbt_oid_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_oid_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_oid_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_oid_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 37 (class 1255 OID 16430)
-- Dependencies: 3
-- Name: gbt_oid_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_oid_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_oid_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_oid_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 39 (class 1255 OID 16432)
-- Dependencies: 3
-- Name: gbt_oid_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_oid_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_oid_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_oid_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 38 (class 1255 OID 16431)
-- Dependencies: 1005 3
-- Name: gbt_oid_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_oid_union(bytea, internal) RETURNS gbtreekey8
    AS '$libdir/btree_gist', 'gbt_oid_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_oid_union(bytea, internal) OWNER TO root;

--
-- TOC entry 113 (class 1255 OID 16702)
-- Dependencies: 3
-- Name: gbt_text_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_text_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_text_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_text_compress(internal) OWNER TO root;

--
-- TOC entry 111 (class 1255 OID 16700)
-- Dependencies: 3
-- Name: gbt_text_consistent(internal, text, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_text_consistent(internal, text, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_text_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_text_consistent(internal, text, smallint) OWNER TO root;

--
-- TOC entry 115 (class 1255 OID 16704)
-- Dependencies: 3
-- Name: gbt_text_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_text_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_text_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_text_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 116 (class 1255 OID 16705)
-- Dependencies: 3
-- Name: gbt_text_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_text_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_text_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_text_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 118 (class 1255 OID 16707)
-- Dependencies: 3
-- Name: gbt_text_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_text_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_text_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_text_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 117 (class 1255 OID 16706)
-- Dependencies: 1014 3
-- Name: gbt_text_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_text_union(bytea, internal) RETURNS gbtreekey_var
    AS '$libdir/btree_gist', 'gbt_text_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_text_union(bytea, internal) OWNER TO root;

--
-- TOC entry 80 (class 1255 OID 16585)
-- Dependencies: 3
-- Name: gbt_time_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_time_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_time_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_time_compress(internal) OWNER TO root;

--
-- TOC entry 78 (class 1255 OID 16583)
-- Dependencies: 3
-- Name: gbt_time_consistent(internal, time without time zone, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_time_consistent(internal, time without time zone, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_time_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_time_consistent(internal, time without time zone, smallint) OWNER TO root;

--
-- TOC entry 82 (class 1255 OID 16587)
-- Dependencies: 3
-- Name: gbt_time_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_time_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_time_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_time_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 83 (class 1255 OID 16588)
-- Dependencies: 3
-- Name: gbt_time_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_time_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_time_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_time_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 85 (class 1255 OID 16590)
-- Dependencies: 3
-- Name: gbt_time_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_time_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_time_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_time_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 84 (class 1255 OID 16589)
-- Dependencies: 1008 3
-- Name: gbt_time_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_time_union(bytea, internal) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbt_time_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_time_union(bytea, internal) OWNER TO root;

--
-- TOC entry 81 (class 1255 OID 16586)
-- Dependencies: 3
-- Name: gbt_timetz_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_timetz_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_timetz_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_timetz_compress(internal) OWNER TO root;

--
-- TOC entry 79 (class 1255 OID 16584)
-- Dependencies: 3
-- Name: gbt_timetz_consistent(internal, time with time zone, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_timetz_consistent(internal, time with time zone, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_timetz_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_timetz_consistent(internal, time with time zone, smallint) OWNER TO root;

--
-- TOC entry 72 (class 1255 OID 16549)
-- Dependencies: 3
-- Name: gbt_ts_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_ts_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_ts_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_ts_compress(internal) OWNER TO root;

--
-- TOC entry 70 (class 1255 OID 16547)
-- Dependencies: 3
-- Name: gbt_ts_consistent(internal, timestamp without time zone, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_ts_consistent(internal, timestamp without time zone, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_ts_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_ts_consistent(internal, timestamp without time zone, smallint) OWNER TO root;

--
-- TOC entry 74 (class 1255 OID 16551)
-- Dependencies: 3
-- Name: gbt_ts_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_ts_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_ts_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gbt_ts_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 75 (class 1255 OID 16552)
-- Dependencies: 3
-- Name: gbt_ts_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_ts_picksplit(internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_ts_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_ts_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 77 (class 1255 OID 16554)
-- Dependencies: 3
-- Name: gbt_ts_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_ts_same(internal, internal, internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_ts_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_ts_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 76 (class 1255 OID 16553)
-- Dependencies: 1008 3
-- Name: gbt_ts_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_ts_union(bytea, internal) RETURNS gbtreekey16
    AS '$libdir/btree_gist', 'gbt_ts_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_ts_union(bytea, internal) OWNER TO root;

--
-- TOC entry 73 (class 1255 OID 16550)
-- Dependencies: 3
-- Name: gbt_tstz_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_tstz_compress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_tstz_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_tstz_compress(internal) OWNER TO root;

--
-- TOC entry 71 (class 1255 OID 16548)
-- Dependencies: 3
-- Name: gbt_tstz_consistent(internal, timestamp with time zone, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_tstz_consistent(internal, timestamp with time zone, smallint) RETURNS boolean
    AS '$libdir/btree_gist', 'gbt_tstz_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_tstz_consistent(internal, timestamp with time zone, smallint) OWNER TO root;

--
-- TOC entry 35 (class 1255 OID 16428)
-- Dependencies: 3
-- Name: gbt_var_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gbt_var_decompress(internal) RETURNS internal
    AS '$libdir/btree_gist', 'gbt_var_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gbt_var_decompress(internal) OWNER TO root;

--
-- TOC entry 223 (class 1255 OID 16971)
-- Dependencies: 3
-- Name: gc_to_sec(double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gc_to_sec(double precision) RETURNS double precision
    AS $_$SELECT CASE WHEN $1 < 0 THEN 0::float8 WHEN $1/earth() > pi() THEN 2*earth() ELSE 2*earth()*sin($1/(2*earth())) END$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.gc_to_sec(double precision) OWNER TO root;

--
-- TOC entry 668 (class 1255 OID 18078)
-- Dependencies: 3
-- Name: gen_random_bytes(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gen_random_bytes(integer) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_random_bytes'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gen_random_bytes(integer) OWNER TO root;

--
-- TOC entry 662 (class 1255 OID 18072)
-- Dependencies: 3
-- Name: gen_salt(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gen_salt(text) RETURNS text
    AS '$libdir/pgcrypto', 'pg_gen_salt'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gen_salt(text) OWNER TO root;

--
-- TOC entry 663 (class 1255 OID 18073)
-- Dependencies: 3
-- Name: gen_salt(text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gen_salt(text, integer) RETURNS text
    AS '$libdir/pgcrypto', 'pg_gen_salt_rounds'
    LANGUAGE c STRICT;


ALTER FUNCTION public.gen_salt(text, integer) OWNER TO root;

--
-- TOC entry 229 (class 1255 OID 16977)
-- Dependencies: 3
-- Name: geo_distance(point, point); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION geo_distance(point, point) RETURNS double precision
    AS '$libdir/earthdistance', 'geo_distance'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.geo_distance(point, point) OWNER TO root;

--
-- TOC entry 631 (class 1255 OID 18009)
-- Dependencies: 3
-- Name: get_raw_page(text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION get_raw_page(text, integer) RETURNS bytea
    AS '$libdir/pageinspect', 'get_raw_page'
    LANGUAGE c STRICT;


ALTER FUNCTION public.get_raw_page(text, integer) OWNER TO root;

--
-- TOC entry 256 (class 1255 OID 17017)
-- Dependencies: 3
-- Name: ghstore_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_compress(internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_compress(internal) OWNER TO root;

--
-- TOC entry 262 (class 1255 OID 17023)
-- Dependencies: 3
-- Name: ghstore_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_consistent(internal, internal, integer) RETURNS boolean
    AS '$libdir/hstore', 'ghstore_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_consistent(internal, internal, integer) OWNER TO root;

--
-- TOC entry 257 (class 1255 OID 17018)
-- Dependencies: 3
-- Name: ghstore_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_decompress(internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_decompress(internal) OWNER TO root;

--
-- TOC entry 258 (class 1255 OID 17019)
-- Dependencies: 3
-- Name: ghstore_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ghstore_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 259 (class 1255 OID 17020)
-- Dependencies: 3
-- Name: ghstore_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_picksplit(internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 261 (class 1255 OID 17022)
-- Dependencies: 3
-- Name: ghstore_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_same(internal, internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 260 (class 1255 OID 17021)
-- Dependencies: 3
-- Name: ghstore_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ghstore_union(internal, internal) RETURNS internal
    AS '$libdir/hstore', 'ghstore_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ghstore_union(internal, internal) OWNER TO root;

--
-- TOC entry 265 (class 1255 OID 17038)
-- Dependencies: 3
-- Name: gin_consistent_hstore(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gin_consistent_hstore(internal, smallint, internal) RETURNS internal
    AS '$libdir/hstore', 'gin_consistent_hstore'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_consistent_hstore(internal, smallint, internal) OWNER TO root;

--
-- TOC entry 263 (class 1255 OID 17036)
-- Dependencies: 3
-- Name: gin_extract_hstore(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gin_extract_hstore(internal, internal) RETURNS internal
    AS '$libdir/hstore', 'gin_extract_hstore'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_extract_hstore(internal, internal) OWNER TO root;

--
-- TOC entry 264 (class 1255 OID 17037)
-- Dependencies: 3
-- Name: gin_extract_hstore_query(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gin_extract_hstore_query(internal, internal, smallint) RETURNS internal
    AS '$libdir/hstore', 'gin_extract_hstore_query'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_extract_hstore_query(internal, internal, smallint) OWNER TO root;

--
-- TOC entry 654 (class 1255 OID 18057)
-- Dependencies: 3
-- Name: gin_extract_trgm(text, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gin_extract_trgm(text, internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gin_extract_trgm'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_extract_trgm(text, internal) OWNER TO root;

--
-- TOC entry 655 (class 1255 OID 18058)
-- Dependencies: 3
-- Name: gin_extract_trgm(text, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gin_extract_trgm(text, internal, internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gin_extract_trgm'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_extract_trgm(text, internal, internal) OWNER TO root;

--
-- TOC entry 656 (class 1255 OID 18059)
-- Dependencies: 3
-- Name: gin_trgm_consistent(internal, internal, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gin_trgm_consistent(internal, internal, text) RETURNS internal
    AS '$libdir/pg_trgm', 'gin_trgm_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gin_trgm_consistent(internal, internal, text) OWNER TO root;

--
-- TOC entry 313 (class 1255 OID 17147)
-- Dependencies: 3
-- Name: ginint4_consistent(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ginint4_consistent(internal, smallint, internal) RETURNS internal
    AS '$libdir/_int', 'ginint4_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ginint4_consistent(internal, smallint, internal) OWNER TO root;

--
-- TOC entry 312 (class 1255 OID 17146)
-- Dependencies: 3
-- Name: ginint4_queryextract(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ginint4_queryextract(internal, internal, smallint) RETURNS internal
    AS '$libdir/_int', 'ginint4_queryextract'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ginint4_queryextract(internal, internal, smallint) OWNER TO root;

--
-- TOC entry 712 (class 1255 OID 18139)
-- Dependencies: 3
-- Name: gseg_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_compress(internal) RETURNS internal
    AS '$libdir/seg', 'gseg_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gseg_compress(internal) OWNER TO root;

--
-- TOC entry 711 (class 1255 OID 18138)
-- Dependencies: 3 1087
-- Name: gseg_consistent(internal, seg, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_consistent(internal, seg, integer) RETURNS boolean
    AS '$libdir/seg', 'gseg_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gseg_consistent(internal, seg, integer) OWNER TO root;

--
-- TOC entry 713 (class 1255 OID 18140)
-- Dependencies: 3
-- Name: gseg_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_decompress(internal) RETURNS internal
    AS '$libdir/seg', 'gseg_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gseg_decompress(internal) OWNER TO root;

--
-- TOC entry 714 (class 1255 OID 18141)
-- Dependencies: 3
-- Name: gseg_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/seg', 'gseg_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gseg_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 715 (class 1255 OID 18142)
-- Dependencies: 3
-- Name: gseg_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_picksplit(internal, internal) RETURNS internal
    AS '$libdir/seg', 'gseg_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gseg_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 717 (class 1255 OID 18144)
-- Dependencies: 1087 3 1087
-- Name: gseg_same(seg, seg, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_same(seg, seg, internal) RETURNS internal
    AS '$libdir/seg', 'gseg_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gseg_same(seg, seg, internal) OWNER TO root;

--
-- TOC entry 716 (class 1255 OID 18143)
-- Dependencies: 1087 3
-- Name: gseg_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gseg_union(internal, internal) RETURNS seg
    AS '$libdir/seg', 'gseg_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gseg_union(internal, internal) OWNER TO root;

--
-- TOC entry 648 (class 1255 OID 18041)
-- Dependencies: 3
-- Name: gtrgm_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_compress(internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gtrgm_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gtrgm_compress(internal) OWNER TO root;

--
-- TOC entry 647 (class 1255 OID 18040)
-- Dependencies: 1084 3
-- Name: gtrgm_consistent(gtrgm, internal, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_consistent(gtrgm, internal, integer) RETURNS boolean
    AS '$libdir/pg_trgm', 'gtrgm_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gtrgm_consistent(gtrgm, internal, integer) OWNER TO root;

--
-- TOC entry 649 (class 1255 OID 18042)
-- Dependencies: 3
-- Name: gtrgm_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_decompress(internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gtrgm_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gtrgm_decompress(internal) OWNER TO root;

--
-- TOC entry 650 (class 1255 OID 18043)
-- Dependencies: 3
-- Name: gtrgm_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gtrgm_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.gtrgm_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 651 (class 1255 OID 18044)
-- Dependencies: 3
-- Name: gtrgm_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_picksplit(internal, internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gtrgm_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gtrgm_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 653 (class 1255 OID 18046)
-- Dependencies: 1084 3 1084
-- Name: gtrgm_same(gtrgm, gtrgm, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_same(gtrgm, gtrgm, internal) RETURNS internal
    AS '$libdir/pg_trgm', 'gtrgm_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gtrgm_same(gtrgm, gtrgm, internal) OWNER TO root;

--
-- TOC entry 652 (class 1255 OID 18045)
-- Dependencies: 3
-- Name: gtrgm_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION gtrgm_union(bytea, internal) RETURNS integer[]
    AS '$libdir/pg_trgm', 'gtrgm_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.gtrgm_union(bytea, internal) OWNER TO root;

--
-- TOC entry 499 (class 1255 OID 17539)
-- Dependencies: 1041 3
-- Name: hashean13(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashean13(ean13) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashean13(ean13) OWNER TO root;

--
-- TOC entry 512 (class 1255 OID 17635)
-- Dependencies: 1053 3
-- Name: hashisbn(isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashisbn(isbn) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashisbn(isbn) OWNER TO root;

--
-- TOC entry 508 (class 1255 OID 17607)
-- Dependencies: 3 1044
-- Name: hashisbn13(isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashisbn13(isbn13) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashisbn13(isbn13) OWNER TO root;

--
-- TOC entry 520 (class 1255 OID 17691)
-- Dependencies: 1056 3
-- Name: hashismn(ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashismn(ismn) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashismn(ismn) OWNER TO root;

--
-- TOC entry 516 (class 1255 OID 17663)
-- Dependencies: 3 1047
-- Name: hashismn13(ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashismn13(ismn13) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashismn13(ismn13) OWNER TO root;

--
-- TOC entry 528 (class 1255 OID 17747)
-- Dependencies: 3 1059
-- Name: hashissn(issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashissn(issn) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashissn(issn) OWNER TO root;

--
-- TOC entry 524 (class 1255 OID 17719)
-- Dependencies: 1050 3
-- Name: hashissn13(issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashissn13(issn13) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashissn13(issn13) OWNER TO root;

--
-- TOC entry 532 (class 1255 OID 17775)
-- Dependencies: 3 1062
-- Name: hashupc(upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hashupc(upc) RETURNS integer
    AS $$hashint8$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.hashupc(upc) OWNER TO root;

--
-- TOC entry 633 (class 1255 OID 18011)
-- Dependencies: 3
-- Name: heap_page_items(bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION heap_page_items(page bytea, OUT lp smallint, OUT lp_off smallint, OUT lp_flags smallint, OUT lp_len smallint, OUT t_xmin xid, OUT t_xmax xid, OUT t_field3 integer, OUT t_ctid tid, OUT t_infomask2 smallint, OUT t_infomask smallint, OUT t_hoff smallint, OUT t_bits text, OUT t_oid oid) RETURNS SETOF record
    AS '$libdir/pageinspect', 'heap_page_items'
    LANGUAGE c STRICT;


ALTER FUNCTION public.heap_page_items(page bytea, OUT lp smallint, OUT lp_off smallint, OUT lp_flags smallint, OUT lp_len smallint, OUT t_xmin xid, OUT t_xmax xid, OUT t_field3 integer, OUT t_ctid tid, OUT t_infomask2 smallint, OUT t_infomask smallint, OUT t_hoff smallint, OUT t_bits text, OUT t_oid oid) OWNER TO root;

--
-- TOC entry 659 (class 1255 OID 18069)
-- Dependencies: 3
-- Name: hmac(text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hmac(text, text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_hmac'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hmac(text, text, text) OWNER TO root;

--
-- TOC entry 660 (class 1255 OID 18070)
-- Dependencies: 3
-- Name: hmac(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hmac(bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pg_hmac'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hmac(bytea, bytea, text) OWNER TO root;

--
-- TOC entry 245 (class 1255 OID 16998)
-- Dependencies: 1029 1029 1029 3
-- Name: hs_concat(hstore, hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hs_concat(hstore, hstore) RETURNS hstore
    AS '$libdir/hstore', 'hs_concat'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hs_concat(hstore, hstore) OWNER TO root;

--
-- TOC entry 247 (class 1255 OID 17001)
-- Dependencies: 3 1029 1029
-- Name: hs_contained(hstore, hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hs_contained(hstore, hstore) RETURNS boolean
    AS '$libdir/hstore', 'hs_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hs_contained(hstore, hstore) OWNER TO root;

--
-- TOC entry 246 (class 1255 OID 17000)
-- Dependencies: 1029 1029 3
-- Name: hs_contains(hstore, hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION hs_contains(hstore, hstore) RETURNS boolean
    AS '$libdir/hstore', 'hs_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.hs_contains(hstore, hstore) OWNER TO root;

--
-- TOC entry 282 (class 1255 OID 17073)
-- Dependencies: 3
-- Name: icount(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION icount(integer[]) RETURNS integer
    AS '$libdir/_int', 'icount'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.icount(integer[]) OWNER TO root;

--
-- TOC entry 288 (class 1255 OID 17080)
-- Dependencies: 3
-- Name: idx(integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION idx(integer[], integer) RETURNS integer
    AS '$libdir/_int', 'idx'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.idx(integer[], integer) OWNER TO root;

--
-- TOC entry 573 (class 1255 OID 17855)
-- Dependencies: 1066 1066 3
-- Name: index(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION index(ltree, ltree) RETURNS integer
    AS '$libdir/ltree', 'ltree_index'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.index(ltree, ltree) OWNER TO root;

--
-- TOC entry 574 (class 1255 OID 17856)
-- Dependencies: 1066 3 1066
-- Name: index(ltree, ltree, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION index(ltree, ltree, integer) RETURNS integer
    AS '$libdir/ltree', 'ltree_index'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.index(ltree, ltree, integer) OWNER TO root;

--
-- TOC entry 267 (class 1255 OID 17048)
-- Dependencies: 3
-- Name: int_agg_final_array(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION int_agg_final_array(integer[]) RETURNS integer[]
    AS '$libdir/int_aggregate', 'int_agg_final_array'
    LANGUAGE c;


ALTER FUNCTION public.int_agg_final_array(integer[]) OWNER TO root;

--
-- TOC entry 266 (class 1255 OID 17047)
-- Dependencies: 3
-- Name: int_agg_state(integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION int_agg_state(integer[], integer) RETURNS integer[]
    AS '$libdir/int_aggregate', 'int_agg_state'
    LANGUAGE c;


ALTER FUNCTION public.int_agg_state(integer[], integer) OWNER TO root;

--
-- TOC entry 268 (class 1255 OID 17050)
-- Dependencies: 3
-- Name: int_array_enum(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION int_array_enum(integer[]) RETURNS SETOF integer
    AS '$libdir/int_aggregate', 'int_enum'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.int_array_enum(integer[]) OWNER TO root;

--
-- TOC entry 293 (class 1255 OID 17088)
-- Dependencies: 3
-- Name: intarray_del_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION intarray_del_elem(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'intarray_del_elem'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intarray_del_elem(integer[], integer) OWNER TO root;

--
-- TOC entry 292 (class 1255 OID 17086)
-- Dependencies: 3
-- Name: intarray_push_array(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION intarray_push_array(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', 'intarray_push_array'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intarray_push_array(integer[], integer[]) OWNER TO root;

--
-- TOC entry 291 (class 1255 OID 17084)
-- Dependencies: 3
-- Name: intarray_push_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION intarray_push_elem(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'intarray_push_elem'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intarray_push_elem(integer[], integer) OWNER TO root;

--
-- TOC entry 281 (class 1255 OID 17072)
-- Dependencies: 3
-- Name: intset(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION intset(integer) RETURNS integer[]
    AS '$libdir/_int', 'intset'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intset(integer) OWNER TO root;

--
-- TOC entry 295 (class 1255 OID 17093)
-- Dependencies: 3
-- Name: intset_subtract(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION intset_subtract(integer[], integer[]) RETURNS integer[]
    AS '$libdir/_int', 'intset_subtract'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intset_subtract(integer[], integer[]) OWNER TO root;

--
-- TOC entry 294 (class 1255 OID 17090)
-- Dependencies: 3
-- Name: intset_union_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION intset_union_elem(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'intset_union_elem'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.intset_union_elem(integer[], integer) OWNER TO root;

--
-- TOC entry 549 (class 1255 OID 17822)
-- Dependencies: 1041 3
-- Name: is_valid(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(ean13) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(ean13) OWNER TO root;

--
-- TOC entry 550 (class 1255 OID 17823)
-- Dependencies: 3 1044
-- Name: is_valid(isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(isbn13) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(isbn13) OWNER TO root;

--
-- TOC entry 551 (class 1255 OID 17824)
-- Dependencies: 1047 3
-- Name: is_valid(ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(ismn13) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(ismn13) OWNER TO root;

--
-- TOC entry 552 (class 1255 OID 17825)
-- Dependencies: 3 1050
-- Name: is_valid(issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(issn13) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(issn13) OWNER TO root;

--
-- TOC entry 553 (class 1255 OID 17826)
-- Dependencies: 3 1053
-- Name: is_valid(isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(isbn) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(isbn) OWNER TO root;

--
-- TOC entry 554 (class 1255 OID 17827)
-- Dependencies: 3 1056
-- Name: is_valid(ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(ismn) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(ismn) OWNER TO root;

--
-- TOC entry 555 (class 1255 OID 17828)
-- Dependencies: 1059 3
-- Name: is_valid(issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(issn) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(issn) OWNER TO root;

--
-- TOC entry 556 (class 1255 OID 17829)
-- Dependencies: 3 1062
-- Name: is_valid(upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION is_valid(upc) RETURNS boolean
    AS '$libdir/isn', 'is_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.is_valid(upc) OWNER TO root;

--
-- TOC entry 537 (class 1255 OID 17790)
-- Dependencies: 1041 3 1053
-- Name: isbn(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isbn(ean13) RETURNS isbn
    AS '$libdir/isn', 'isbn_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isbn(ean13) OWNER TO root;

--
-- TOC entry 534 (class 1255 OID 17787)
-- Dependencies: 1044 1041 3
-- Name: isbn13(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isbn13(ean13) RETURNS isbn13
    AS '$libdir/isn', 'isbn_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isbn13(ean13) OWNER TO root;

--
-- TOC entry 242 (class 1255 OID 16995)
-- Dependencies: 3 1029
-- Name: isdefined(hstore, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isdefined(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'defined'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isdefined(hstore, text) OWNER TO root;

--
-- TOC entry 240 (class 1255 OID 16992)
-- Dependencies: 3 1029
-- Name: isexists(hstore, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isexists(hstore, text) RETURNS boolean
    AS '$libdir/hstore', 'exists'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isexists(hstore, text) OWNER TO root;

--
-- TOC entry 538 (class 1255 OID 17791)
-- Dependencies: 1041 1056 3
-- Name: ismn(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ismn(ean13) RETURNS ismn
    AS '$libdir/isn', 'ismn_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ismn(ean13) OWNER TO root;

--
-- TOC entry 535 (class 1255 OID 17788)
-- Dependencies: 1047 3 1041
-- Name: ismn13(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ismn13(ean13) RETURNS ismn13
    AS '$libdir/isn', 'ismn_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ismn13(ean13) OWNER TO root;

--
-- TOC entry 557 (class 1255 OID 17830)
-- Dependencies: 3
-- Name: isn_weak(boolean); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isn_weak(boolean) RETURNS boolean
    AS '$libdir/isn', 'accept_weak_input'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isn_weak(boolean) OWNER TO root;

--
-- TOC entry 558 (class 1255 OID 17831)
-- Dependencies: 3
-- Name: isn_weak(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isn_weak() RETURNS boolean
    AS '$libdir/isn', 'weak_input_status'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.isn_weak() OWNER TO root;

--
-- TOC entry 332 (class 1255 OID 17195)
-- Dependencies: 1041 1041 3
-- Name: isneq(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, ean13) OWNER TO root;

--
-- TOC entry 338 (class 1255 OID 17201)
-- Dependencies: 1044 1041 3
-- Name: isneq(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, isbn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, isbn13) OWNER TO root;

--
-- TOC entry 344 (class 1255 OID 17207)
-- Dependencies: 1041 1047 3
-- Name: isneq(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, ismn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, ismn13) OWNER TO root;

--
-- TOC entry 350 (class 1255 OID 17213)
-- Dependencies: 1041 3 1050
-- Name: isneq(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, issn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, issn13) OWNER TO root;

--
-- TOC entry 356 (class 1255 OID 17219)
-- Dependencies: 3 1041 1053
-- Name: isneq(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, isbn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, isbn) OWNER TO root;

--
-- TOC entry 362 (class 1255 OID 17225)
-- Dependencies: 1056 3 1041
-- Name: isneq(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, ismn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, ismn) OWNER TO root;

--
-- TOC entry 368 (class 1255 OID 17231)
-- Dependencies: 1041 1059 3
-- Name: isneq(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, issn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, issn) OWNER TO root;

--
-- TOC entry 374 (class 1255 OID 17237)
-- Dependencies: 1041 3 1062
-- Name: isneq(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ean13, upc) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ean13, upc) OWNER TO root;

--
-- TOC entry 380 (class 1255 OID 17243)
-- Dependencies: 1044 3 1044
-- Name: isneq(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(isbn13, isbn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 386 (class 1255 OID 17249)
-- Dependencies: 1044 1053 3
-- Name: isneq(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(isbn13, isbn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(isbn13, isbn) OWNER TO root;

--
-- TOC entry 392 (class 1255 OID 17255)
-- Dependencies: 1044 1041 3
-- Name: isneq(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(isbn13, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(isbn13, ean13) OWNER TO root;

--
-- TOC entry 398 (class 1255 OID 17261)
-- Dependencies: 3 1053 1053
-- Name: isneq(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(isbn, isbn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(isbn, isbn) OWNER TO root;

--
-- TOC entry 404 (class 1255 OID 17267)
-- Dependencies: 3 1053 1044
-- Name: isneq(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(isbn, isbn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(isbn, isbn13) OWNER TO root;

--
-- TOC entry 410 (class 1255 OID 17273)
-- Dependencies: 3 1053 1041
-- Name: isneq(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(isbn, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(isbn, ean13) OWNER TO root;

--
-- TOC entry 416 (class 1255 OID 17279)
-- Dependencies: 3 1047 1047
-- Name: isneq(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ismn13, ismn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 422 (class 1255 OID 17285)
-- Dependencies: 3 1047 1056
-- Name: isneq(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ismn13, ismn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ismn13, ismn) OWNER TO root;

--
-- TOC entry 428 (class 1255 OID 17291)
-- Dependencies: 3 1047 1041
-- Name: isneq(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ismn13, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ismn13, ean13) OWNER TO root;

--
-- TOC entry 434 (class 1255 OID 17297)
-- Dependencies: 3 1056 1056
-- Name: isneq(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ismn, ismn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ismn, ismn) OWNER TO root;

--
-- TOC entry 440 (class 1255 OID 17303)
-- Dependencies: 3 1056 1047
-- Name: isneq(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ismn, ismn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ismn, ismn13) OWNER TO root;

--
-- TOC entry 446 (class 1255 OID 17309)
-- Dependencies: 3 1056 1041
-- Name: isneq(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(ismn, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(ismn, ean13) OWNER TO root;

--
-- TOC entry 452 (class 1255 OID 17315)
-- Dependencies: 1050 3 1050
-- Name: isneq(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(issn13, issn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(issn13, issn13) OWNER TO root;

--
-- TOC entry 458 (class 1255 OID 17321)
-- Dependencies: 1050 1059 3
-- Name: isneq(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(issn13, issn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(issn13, issn) OWNER TO root;

--
-- TOC entry 464 (class 1255 OID 17327)
-- Dependencies: 1041 3 1050
-- Name: isneq(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(issn13, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(issn13, ean13) OWNER TO root;

--
-- TOC entry 470 (class 1255 OID 17333)
-- Dependencies: 3 1059 1059
-- Name: isneq(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(issn, issn) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(issn, issn) OWNER TO root;

--
-- TOC entry 476 (class 1255 OID 17339)
-- Dependencies: 3 1059 1050
-- Name: isneq(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(issn, issn13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(issn, issn13) OWNER TO root;

--
-- TOC entry 482 (class 1255 OID 17345)
-- Dependencies: 1041 3 1059
-- Name: isneq(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(issn, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(issn, ean13) OWNER TO root;

--
-- TOC entry 488 (class 1255 OID 17351)
-- Dependencies: 1062 1062 3
-- Name: isneq(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(upc, upc) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(upc, upc) OWNER TO root;

--
-- TOC entry 494 (class 1255 OID 17357)
-- Dependencies: 3 1041 1062
-- Name: isneq(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isneq(upc, ean13) RETURNS boolean
    AS $$int8eq$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isneq(upc, ean13) OWNER TO root;

--
-- TOC entry 333 (class 1255 OID 17196)
-- Dependencies: 1041 3 1041
-- Name: isnge(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, ean13) OWNER TO root;

--
-- TOC entry 339 (class 1255 OID 17202)
-- Dependencies: 3 1041 1044
-- Name: isnge(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, isbn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, isbn13) OWNER TO root;

--
-- TOC entry 345 (class 1255 OID 17208)
-- Dependencies: 1041 1047 3
-- Name: isnge(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, ismn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, ismn13) OWNER TO root;

--
-- TOC entry 351 (class 1255 OID 17214)
-- Dependencies: 3 1041 1050
-- Name: isnge(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, issn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, issn13) OWNER TO root;

--
-- TOC entry 357 (class 1255 OID 17220)
-- Dependencies: 1053 1041 3
-- Name: isnge(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, isbn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, isbn) OWNER TO root;

--
-- TOC entry 363 (class 1255 OID 17226)
-- Dependencies: 1041 1056 3
-- Name: isnge(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, ismn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, ismn) OWNER TO root;

--
-- TOC entry 369 (class 1255 OID 17232)
-- Dependencies: 3 1059 1041
-- Name: isnge(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, issn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, issn) OWNER TO root;

--
-- TOC entry 375 (class 1255 OID 17238)
-- Dependencies: 1041 1062 3
-- Name: isnge(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ean13, upc) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ean13, upc) OWNER TO root;

--
-- TOC entry 381 (class 1255 OID 17244)
-- Dependencies: 1044 1044 3
-- Name: isnge(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(isbn13, isbn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 387 (class 1255 OID 17250)
-- Dependencies: 3 1044 1053
-- Name: isnge(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(isbn13, isbn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(isbn13, isbn) OWNER TO root;

--
-- TOC entry 393 (class 1255 OID 17256)
-- Dependencies: 1044 1041 3
-- Name: isnge(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(isbn13, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(isbn13, ean13) OWNER TO root;

--
-- TOC entry 399 (class 1255 OID 17262)
-- Dependencies: 3 1053 1053
-- Name: isnge(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(isbn, isbn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(isbn, isbn) OWNER TO root;

--
-- TOC entry 405 (class 1255 OID 17268)
-- Dependencies: 3 1053 1044
-- Name: isnge(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(isbn, isbn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(isbn, isbn13) OWNER TO root;

--
-- TOC entry 411 (class 1255 OID 17274)
-- Dependencies: 3 1053 1041
-- Name: isnge(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(isbn, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(isbn, ean13) OWNER TO root;

--
-- TOC entry 417 (class 1255 OID 17280)
-- Dependencies: 3 1047 1047
-- Name: isnge(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ismn13, ismn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 423 (class 1255 OID 17286)
-- Dependencies: 3 1047 1056
-- Name: isnge(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ismn13, ismn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ismn13, ismn) OWNER TO root;

--
-- TOC entry 429 (class 1255 OID 17292)
-- Dependencies: 3 1047 1041
-- Name: isnge(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ismn13, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ismn13, ean13) OWNER TO root;

--
-- TOC entry 435 (class 1255 OID 17298)
-- Dependencies: 3 1056 1056
-- Name: isnge(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ismn, ismn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ismn, ismn) OWNER TO root;

--
-- TOC entry 441 (class 1255 OID 17304)
-- Dependencies: 3 1056 1047
-- Name: isnge(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ismn, ismn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ismn, ismn13) OWNER TO root;

--
-- TOC entry 447 (class 1255 OID 17310)
-- Dependencies: 1041 3 1056
-- Name: isnge(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(ismn, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(ismn, ean13) OWNER TO root;

--
-- TOC entry 453 (class 1255 OID 17316)
-- Dependencies: 1050 3 1050
-- Name: isnge(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(issn13, issn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(issn13, issn13) OWNER TO root;

--
-- TOC entry 459 (class 1255 OID 17322)
-- Dependencies: 1059 3 1050
-- Name: isnge(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(issn13, issn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(issn13, issn) OWNER TO root;

--
-- TOC entry 465 (class 1255 OID 17328)
-- Dependencies: 1041 3 1050
-- Name: isnge(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(issn13, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(issn13, ean13) OWNER TO root;

--
-- TOC entry 471 (class 1255 OID 17334)
-- Dependencies: 3 1059 1059
-- Name: isnge(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(issn, issn) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(issn, issn) OWNER TO root;

--
-- TOC entry 477 (class 1255 OID 17340)
-- Dependencies: 1059 3 1050
-- Name: isnge(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(issn, issn13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(issn, issn13) OWNER TO root;

--
-- TOC entry 483 (class 1255 OID 17346)
-- Dependencies: 1059 1041 3
-- Name: isnge(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(issn, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(issn, ean13) OWNER TO root;

--
-- TOC entry 489 (class 1255 OID 17352)
-- Dependencies: 1062 1062 3
-- Name: isnge(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(upc, upc) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(upc, upc) OWNER TO root;

--
-- TOC entry 495 (class 1255 OID 17358)
-- Dependencies: 1041 3 1062
-- Name: isnge(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnge(upc, ean13) RETURNS boolean
    AS $$int8ge$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnge(upc, ean13) OWNER TO root;

--
-- TOC entry 334 (class 1255 OID 17197)
-- Dependencies: 1041 3 1041
-- Name: isngt(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, ean13) OWNER TO root;

--
-- TOC entry 340 (class 1255 OID 17203)
-- Dependencies: 1041 1044 3
-- Name: isngt(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, isbn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, isbn13) OWNER TO root;

--
-- TOC entry 346 (class 1255 OID 17209)
-- Dependencies: 1041 1047 3
-- Name: isngt(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, ismn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, ismn13) OWNER TO root;

--
-- TOC entry 352 (class 1255 OID 17215)
-- Dependencies: 1041 3 1050
-- Name: isngt(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, issn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, issn13) OWNER TO root;

--
-- TOC entry 358 (class 1255 OID 17221)
-- Dependencies: 1053 1041 3
-- Name: isngt(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, isbn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, isbn) OWNER TO root;

--
-- TOC entry 364 (class 1255 OID 17227)
-- Dependencies: 1041 3 1056
-- Name: isngt(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, ismn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, ismn) OWNER TO root;

--
-- TOC entry 370 (class 1255 OID 17233)
-- Dependencies: 3 1059 1041
-- Name: isngt(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, issn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, issn) OWNER TO root;

--
-- TOC entry 376 (class 1255 OID 17239)
-- Dependencies: 3 1062 1041
-- Name: isngt(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ean13, upc) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ean13, upc) OWNER TO root;

--
-- TOC entry 382 (class 1255 OID 17245)
-- Dependencies: 1044 3 1044
-- Name: isngt(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(isbn13, isbn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 388 (class 1255 OID 17251)
-- Dependencies: 3 1044 1053
-- Name: isngt(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(isbn13, isbn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(isbn13, isbn) OWNER TO root;

--
-- TOC entry 394 (class 1255 OID 17257)
-- Dependencies: 3 1044 1041
-- Name: isngt(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(isbn13, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(isbn13, ean13) OWNER TO root;

--
-- TOC entry 400 (class 1255 OID 17263)
-- Dependencies: 3 1053 1053
-- Name: isngt(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(isbn, isbn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(isbn, isbn) OWNER TO root;

--
-- TOC entry 406 (class 1255 OID 17269)
-- Dependencies: 3 1053 1044
-- Name: isngt(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(isbn, isbn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(isbn, isbn13) OWNER TO root;

--
-- TOC entry 412 (class 1255 OID 17275)
-- Dependencies: 3 1053 1041
-- Name: isngt(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(isbn, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(isbn, ean13) OWNER TO root;

--
-- TOC entry 418 (class 1255 OID 17281)
-- Dependencies: 3 1047 1047
-- Name: isngt(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ismn13, ismn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 424 (class 1255 OID 17287)
-- Dependencies: 3 1047 1056
-- Name: isngt(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ismn13, ismn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ismn13, ismn) OWNER TO root;

--
-- TOC entry 430 (class 1255 OID 17293)
-- Dependencies: 3 1047 1041
-- Name: isngt(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ismn13, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ismn13, ean13) OWNER TO root;

--
-- TOC entry 436 (class 1255 OID 17299)
-- Dependencies: 3 1056 1056
-- Name: isngt(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ismn, ismn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ismn, ismn) OWNER TO root;

--
-- TOC entry 442 (class 1255 OID 17305)
-- Dependencies: 3 1056 1047
-- Name: isngt(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ismn, ismn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ismn, ismn13) OWNER TO root;

--
-- TOC entry 448 (class 1255 OID 17311)
-- Dependencies: 3 1041 1056
-- Name: isngt(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(ismn, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(ismn, ean13) OWNER TO root;

--
-- TOC entry 454 (class 1255 OID 17317)
-- Dependencies: 3 1050 1050
-- Name: isngt(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(issn13, issn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(issn13, issn13) OWNER TO root;

--
-- TOC entry 460 (class 1255 OID 17323)
-- Dependencies: 1059 3 1050
-- Name: isngt(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(issn13, issn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(issn13, issn) OWNER TO root;

--
-- TOC entry 466 (class 1255 OID 17329)
-- Dependencies: 1050 1041 3
-- Name: isngt(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(issn13, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(issn13, ean13) OWNER TO root;

--
-- TOC entry 472 (class 1255 OID 17335)
-- Dependencies: 3 1059 1059
-- Name: isngt(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(issn, issn) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(issn, issn) OWNER TO root;

--
-- TOC entry 478 (class 1255 OID 17341)
-- Dependencies: 1059 3 1050
-- Name: isngt(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(issn, issn13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(issn, issn13) OWNER TO root;

--
-- TOC entry 484 (class 1255 OID 17347)
-- Dependencies: 1041 3 1059
-- Name: isngt(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(issn, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(issn, ean13) OWNER TO root;

--
-- TOC entry 490 (class 1255 OID 17353)
-- Dependencies: 3 1062 1062
-- Name: isngt(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(upc, upc) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(upc, upc) OWNER TO root;

--
-- TOC entry 496 (class 1255 OID 17359)
-- Dependencies: 1062 3 1041
-- Name: isngt(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isngt(upc, ean13) RETURNS boolean
    AS $$int8gt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isngt(upc, ean13) OWNER TO root;

--
-- TOC entry 331 (class 1255 OID 17194)
-- Dependencies: 1041 3 1041
-- Name: isnle(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, ean13) OWNER TO root;

--
-- TOC entry 337 (class 1255 OID 17200)
-- Dependencies: 1041 3 1044
-- Name: isnle(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, isbn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, isbn13) OWNER TO root;

--
-- TOC entry 343 (class 1255 OID 17206)
-- Dependencies: 1041 1047 3
-- Name: isnle(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, ismn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, ismn13) OWNER TO root;

--
-- TOC entry 349 (class 1255 OID 17212)
-- Dependencies: 3 1050 1041
-- Name: isnle(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, issn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, issn13) OWNER TO root;

--
-- TOC entry 355 (class 1255 OID 17218)
-- Dependencies: 3 1041 1053
-- Name: isnle(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, isbn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, isbn) OWNER TO root;

--
-- TOC entry 361 (class 1255 OID 17224)
-- Dependencies: 1041 3 1056
-- Name: isnle(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, ismn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, ismn) OWNER TO root;

--
-- TOC entry 367 (class 1255 OID 17230)
-- Dependencies: 1041 3 1059
-- Name: isnle(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, issn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, issn) OWNER TO root;

--
-- TOC entry 373 (class 1255 OID 17236)
-- Dependencies: 3 1062 1041
-- Name: isnle(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ean13, upc) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ean13, upc) OWNER TO root;

--
-- TOC entry 379 (class 1255 OID 17242)
-- Dependencies: 3 1044 1044
-- Name: isnle(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(isbn13, isbn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 385 (class 1255 OID 17248)
-- Dependencies: 1044 3 1053
-- Name: isnle(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(isbn13, isbn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(isbn13, isbn) OWNER TO root;

--
-- TOC entry 391 (class 1255 OID 17254)
-- Dependencies: 1041 3 1044
-- Name: isnle(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(isbn13, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(isbn13, ean13) OWNER TO root;

--
-- TOC entry 397 (class 1255 OID 17260)
-- Dependencies: 3 1053 1053
-- Name: isnle(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(isbn, isbn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(isbn, isbn) OWNER TO root;

--
-- TOC entry 403 (class 1255 OID 17266)
-- Dependencies: 3 1053 1044
-- Name: isnle(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(isbn, isbn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(isbn, isbn13) OWNER TO root;

--
-- TOC entry 409 (class 1255 OID 17272)
-- Dependencies: 3 1053 1041
-- Name: isnle(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(isbn, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(isbn, ean13) OWNER TO root;

--
-- TOC entry 415 (class 1255 OID 17278)
-- Dependencies: 3 1047 1047
-- Name: isnle(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ismn13, ismn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 421 (class 1255 OID 17284)
-- Dependencies: 3 1047 1056
-- Name: isnle(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ismn13, ismn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ismn13, ismn) OWNER TO root;

--
-- TOC entry 427 (class 1255 OID 17290)
-- Dependencies: 3 1047 1041
-- Name: isnle(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ismn13, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ismn13, ean13) OWNER TO root;

--
-- TOC entry 433 (class 1255 OID 17296)
-- Dependencies: 3 1056 1056
-- Name: isnle(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ismn, ismn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ismn, ismn) OWNER TO root;

--
-- TOC entry 439 (class 1255 OID 17302)
-- Dependencies: 3 1056 1047
-- Name: isnle(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ismn, ismn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ismn, ismn13) OWNER TO root;

--
-- TOC entry 445 (class 1255 OID 17308)
-- Dependencies: 3 1056 1041
-- Name: isnle(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(ismn, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(ismn, ean13) OWNER TO root;

--
-- TOC entry 451 (class 1255 OID 17314)
-- Dependencies: 1050 3 1050
-- Name: isnle(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(issn13, issn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(issn13, issn13) OWNER TO root;

--
-- TOC entry 457 (class 1255 OID 17320)
-- Dependencies: 3 1059 1050
-- Name: isnle(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(issn13, issn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(issn13, issn) OWNER TO root;

--
-- TOC entry 463 (class 1255 OID 17326)
-- Dependencies: 3 1041 1050
-- Name: isnle(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(issn13, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(issn13, ean13) OWNER TO root;

--
-- TOC entry 469 (class 1255 OID 17332)
-- Dependencies: 3 1059 1059
-- Name: isnle(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(issn, issn) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(issn, issn) OWNER TO root;

--
-- TOC entry 475 (class 1255 OID 17338)
-- Dependencies: 3 1059 1050
-- Name: isnle(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(issn, issn13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(issn, issn13) OWNER TO root;

--
-- TOC entry 481 (class 1255 OID 17344)
-- Dependencies: 3 1059 1041
-- Name: isnle(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(issn, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(issn, ean13) OWNER TO root;

--
-- TOC entry 487 (class 1255 OID 17350)
-- Dependencies: 1062 3 1062
-- Name: isnle(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(upc, upc) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(upc, upc) OWNER TO root;

--
-- TOC entry 493 (class 1255 OID 17356)
-- Dependencies: 1062 3 1041
-- Name: isnle(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnle(upc, ean13) RETURNS boolean
    AS $$int8le$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnle(upc, ean13) OWNER TO root;

--
-- TOC entry 330 (class 1255 OID 17193)
-- Dependencies: 1041 3 1041
-- Name: isnlt(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, ean13) OWNER TO root;

--
-- TOC entry 336 (class 1255 OID 17199)
-- Dependencies: 1041 1044 3
-- Name: isnlt(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, isbn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, isbn13) OWNER TO root;

--
-- TOC entry 342 (class 1255 OID 17205)
-- Dependencies: 1041 1047 3
-- Name: isnlt(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, ismn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, ismn13) OWNER TO root;

--
-- TOC entry 348 (class 1255 OID 17211)
-- Dependencies: 1041 3 1050
-- Name: isnlt(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, issn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, issn13) OWNER TO root;

--
-- TOC entry 354 (class 1255 OID 17217)
-- Dependencies: 3 1041 1053
-- Name: isnlt(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, isbn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, isbn) OWNER TO root;

--
-- TOC entry 360 (class 1255 OID 17223)
-- Dependencies: 1056 1041 3
-- Name: isnlt(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, ismn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, ismn) OWNER TO root;

--
-- TOC entry 366 (class 1255 OID 17229)
-- Dependencies: 1041 3 1059
-- Name: isnlt(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, issn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, issn) OWNER TO root;

--
-- TOC entry 372 (class 1255 OID 17235)
-- Dependencies: 1041 1062 3
-- Name: isnlt(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ean13, upc) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ean13, upc) OWNER TO root;

--
-- TOC entry 378 (class 1255 OID 17241)
-- Dependencies: 1044 1044 3
-- Name: isnlt(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(isbn13, isbn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 384 (class 1255 OID 17247)
-- Dependencies: 1044 1053 3
-- Name: isnlt(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(isbn13, isbn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(isbn13, isbn) OWNER TO root;

--
-- TOC entry 390 (class 1255 OID 17253)
-- Dependencies: 1041 3 1044
-- Name: isnlt(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(isbn13, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(isbn13, ean13) OWNER TO root;

--
-- TOC entry 396 (class 1255 OID 17259)
-- Dependencies: 3 1053 1053
-- Name: isnlt(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(isbn, isbn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(isbn, isbn) OWNER TO root;

--
-- TOC entry 402 (class 1255 OID 17265)
-- Dependencies: 3 1053 1044
-- Name: isnlt(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(isbn, isbn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(isbn, isbn13) OWNER TO root;

--
-- TOC entry 408 (class 1255 OID 17271)
-- Dependencies: 3 1053 1041
-- Name: isnlt(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(isbn, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(isbn, ean13) OWNER TO root;

--
-- TOC entry 414 (class 1255 OID 17277)
-- Dependencies: 3 1047 1047
-- Name: isnlt(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ismn13, ismn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 420 (class 1255 OID 17283)
-- Dependencies: 3 1047 1056
-- Name: isnlt(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ismn13, ismn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ismn13, ismn) OWNER TO root;

--
-- TOC entry 426 (class 1255 OID 17289)
-- Dependencies: 3 1047 1041
-- Name: isnlt(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ismn13, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ismn13, ean13) OWNER TO root;

--
-- TOC entry 432 (class 1255 OID 17295)
-- Dependencies: 3 1056 1056
-- Name: isnlt(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ismn, ismn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ismn, ismn) OWNER TO root;

--
-- TOC entry 438 (class 1255 OID 17301)
-- Dependencies: 3 1056 1047
-- Name: isnlt(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ismn, ismn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ismn, ismn13) OWNER TO root;

--
-- TOC entry 444 (class 1255 OID 17307)
-- Dependencies: 3 1056 1041
-- Name: isnlt(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(ismn, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(ismn, ean13) OWNER TO root;

--
-- TOC entry 450 (class 1255 OID 17313)
-- Dependencies: 1050 3 1050
-- Name: isnlt(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(issn13, issn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(issn13, issn13) OWNER TO root;

--
-- TOC entry 456 (class 1255 OID 17319)
-- Dependencies: 3 1059 1050
-- Name: isnlt(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(issn13, issn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(issn13, issn) OWNER TO root;

--
-- TOC entry 462 (class 1255 OID 17325)
-- Dependencies: 1050 3 1041
-- Name: isnlt(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(issn13, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(issn13, ean13) OWNER TO root;

--
-- TOC entry 468 (class 1255 OID 17331)
-- Dependencies: 3 1059 1059
-- Name: isnlt(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(issn, issn) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(issn, issn) OWNER TO root;

--
-- TOC entry 474 (class 1255 OID 17337)
-- Dependencies: 3 1059 1050
-- Name: isnlt(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(issn, issn13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(issn, issn13) OWNER TO root;

--
-- TOC entry 480 (class 1255 OID 17343)
-- Dependencies: 3 1059 1041
-- Name: isnlt(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(issn, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(issn, ean13) OWNER TO root;

--
-- TOC entry 486 (class 1255 OID 17349)
-- Dependencies: 3 1062 1062
-- Name: isnlt(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(upc, upc) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(upc, upc) OWNER TO root;

--
-- TOC entry 492 (class 1255 OID 17355)
-- Dependencies: 1062 3 1041
-- Name: isnlt(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnlt(upc, ean13) RETURNS boolean
    AS $$int8lt$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnlt(upc, ean13) OWNER TO root;

--
-- TOC entry 335 (class 1255 OID 17198)
-- Dependencies: 1041 1041 3
-- Name: isnne(ean13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, ean13) OWNER TO root;

--
-- TOC entry 341 (class 1255 OID 17204)
-- Dependencies: 1041 1044 3
-- Name: isnne(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, isbn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, isbn13) OWNER TO root;

--
-- TOC entry 347 (class 1255 OID 17210)
-- Dependencies: 1041 3 1047
-- Name: isnne(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, ismn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, ismn13) OWNER TO root;

--
-- TOC entry 353 (class 1255 OID 17216)
-- Dependencies: 3 1041 1050
-- Name: isnne(ean13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, issn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, issn13) OWNER TO root;

--
-- TOC entry 359 (class 1255 OID 17222)
-- Dependencies: 1041 3 1053
-- Name: isnne(ean13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, isbn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, isbn) OWNER TO root;

--
-- TOC entry 365 (class 1255 OID 17228)
-- Dependencies: 1056 1041 3
-- Name: isnne(ean13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, ismn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, ismn) OWNER TO root;

--
-- TOC entry 371 (class 1255 OID 17234)
-- Dependencies: 1059 3 1041
-- Name: isnne(ean13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, issn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, issn) OWNER TO root;

--
-- TOC entry 377 (class 1255 OID 17240)
-- Dependencies: 3 1062 1041
-- Name: isnne(ean13, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ean13, upc) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ean13, upc) OWNER TO root;

--
-- TOC entry 383 (class 1255 OID 17246)
-- Dependencies: 1044 1044 3
-- Name: isnne(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(isbn13, isbn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(isbn13, isbn13) OWNER TO root;

--
-- TOC entry 389 (class 1255 OID 17252)
-- Dependencies: 3 1044 1053
-- Name: isnne(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(isbn13, isbn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(isbn13, isbn) OWNER TO root;

--
-- TOC entry 395 (class 1255 OID 17258)
-- Dependencies: 3 1044 1041
-- Name: isnne(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(isbn13, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(isbn13, ean13) OWNER TO root;

--
-- TOC entry 401 (class 1255 OID 17264)
-- Dependencies: 3 1053 1053
-- Name: isnne(isbn, isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(isbn, isbn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(isbn, isbn) OWNER TO root;

--
-- TOC entry 407 (class 1255 OID 17270)
-- Dependencies: 3 1053 1044
-- Name: isnne(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(isbn, isbn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(isbn, isbn13) OWNER TO root;

--
-- TOC entry 413 (class 1255 OID 17276)
-- Dependencies: 3 1053 1041
-- Name: isnne(isbn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(isbn, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(isbn, ean13) OWNER TO root;

--
-- TOC entry 419 (class 1255 OID 17282)
-- Dependencies: 3 1047 1047
-- Name: isnne(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ismn13, ismn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ismn13, ismn13) OWNER TO root;

--
-- TOC entry 425 (class 1255 OID 17288)
-- Dependencies: 3 1047 1056
-- Name: isnne(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ismn13, ismn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ismn13, ismn) OWNER TO root;

--
-- TOC entry 431 (class 1255 OID 17294)
-- Dependencies: 3 1047 1041
-- Name: isnne(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ismn13, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ismn13, ean13) OWNER TO root;

--
-- TOC entry 437 (class 1255 OID 17300)
-- Dependencies: 3 1056 1056
-- Name: isnne(ismn, ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ismn, ismn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ismn, ismn) OWNER TO root;

--
-- TOC entry 443 (class 1255 OID 17306)
-- Dependencies: 3 1056 1047
-- Name: isnne(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ismn, ismn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ismn, ismn13) OWNER TO root;

--
-- TOC entry 449 (class 1255 OID 17312)
-- Dependencies: 3 1056 1041
-- Name: isnne(ismn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(ismn, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(ismn, ean13) OWNER TO root;

--
-- TOC entry 455 (class 1255 OID 17318)
-- Dependencies: 1050 3 1050
-- Name: isnne(issn13, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(issn13, issn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(issn13, issn13) OWNER TO root;

--
-- TOC entry 461 (class 1255 OID 17324)
-- Dependencies: 3 1059 1050
-- Name: isnne(issn13, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(issn13, issn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(issn13, issn) OWNER TO root;

--
-- TOC entry 467 (class 1255 OID 17330)
-- Dependencies: 1050 1041 3
-- Name: isnne(issn13, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(issn13, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(issn13, ean13) OWNER TO root;

--
-- TOC entry 473 (class 1255 OID 17336)
-- Dependencies: 3 1059 1059
-- Name: isnne(issn, issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(issn, issn) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(issn, issn) OWNER TO root;

--
-- TOC entry 479 (class 1255 OID 17342)
-- Dependencies: 1050 3 1059
-- Name: isnne(issn, issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(issn, issn13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(issn, issn13) OWNER TO root;

--
-- TOC entry 485 (class 1255 OID 17348)
-- Dependencies: 1041 3 1059
-- Name: isnne(issn, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(issn, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(issn, ean13) OWNER TO root;

--
-- TOC entry 491 (class 1255 OID 17354)
-- Dependencies: 1062 3 1062
-- Name: isnne(upc, upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(upc, upc) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(upc, upc) OWNER TO root;

--
-- TOC entry 497 (class 1255 OID 17360)
-- Dependencies: 1062 1041 3
-- Name: isnne(upc, ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION isnne(upc, ean13) RETURNS boolean
    AS $$int8ne$$
    LANGUAGE internal IMMUTABLE STRICT;


ALTER FUNCTION public.isnne(upc, ean13) OWNER TO root;

--
-- TOC entry 539 (class 1255 OID 17792)
-- Dependencies: 1059 1041 3
-- Name: issn(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION issn(ean13) RETURNS issn
    AS '$libdir/isn', 'issn_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.issn(ean13) OWNER TO root;

--
-- TOC entry 536 (class 1255 OID 17789)
-- Dependencies: 1041 1050 3
-- Name: issn13(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION issn13(ean13) RETURNS issn13
    AS '$libdir/isn', 'issn_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.issn13(ean13) OWNER TO root;

--
-- TOC entry 225 (class 1255 OID 16973)
-- Dependencies: 3 1025
-- Name: latitude(earth); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION latitude(earth) RETURNS double precision
    AS $_$SELECT CASE WHEN cube_ll_coord($1, 3)/earth() < -1 THEN -90::float8 WHEN cube_ll_coord($1, 3)/earth() > 1 THEN 90::float8 ELSE degrees(asin(cube_ll_coord($1, 3)/earth())) END$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.latitude(earth) OWNER TO root;

--
-- TOC entry 578 (class 1255 OID 17860)
-- Dependencies: 1066 3 1068
-- Name: lca(ltree[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree[]) RETURNS ltree
    AS '$libdir/ltree', '_lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree[]) OWNER TO root;

--
-- TOC entry 579 (class 1255 OID 17861)
-- Dependencies: 1066 1066 3 1066
-- Name: lca(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree) OWNER TO root;

--
-- TOC entry 580 (class 1255 OID 17862)
-- Dependencies: 3 1066 1066 1066 1066
-- Name: lca(ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree, ltree) OWNER TO root;

--
-- TOC entry 581 (class 1255 OID 17863)
-- Dependencies: 1066 1066 1066 1066 3 1066
-- Name: lca(ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree) OWNER TO root;

--
-- TOC entry 582 (class 1255 OID 17864)
-- Dependencies: 1066 3 1066 1066 1066 1066 1066
-- Name: lca(ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree) OWNER TO root;

--
-- TOC entry 583 (class 1255 OID 17865)
-- Dependencies: 1066 1066 1066 1066 1066 3 1066 1066
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO root;

--
-- TOC entry 584 (class 1255 OID 17866)
-- Dependencies: 1066 1066 1066 1066 3 1066 1066 1066 1066
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO root;

--
-- TOC entry 585 (class 1255 OID 17867)
-- Dependencies: 1066 1066 1066 1066 1066 1066 1066 1066 1066 3
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'lca'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO root;

--
-- TOC entry 230 (class 1255 OID 16979)
-- Dependencies: 3
-- Name: levenshtein(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION levenshtein(text, text) RETURNS integer
    AS '$libdir/fuzzystrmatch', 'levenshtein'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.levenshtein(text, text) OWNER TO root;

--
-- TOC entry 224 (class 1255 OID 16972)
-- Dependencies: 3 1025
-- Name: ll_to_earth(double precision, double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ll_to_earth(double precision, double precision) RETURNS earth
    AS $_$SELECT cube(cube(cube(earth()*cos(radians($1))*cos(radians($2))),earth()*cos(radians($1))*sin(radians($2))),earth()*sin(radians($1)))::earth$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.ll_to_earth(double precision, double precision) OWNER TO root;

--
-- TOC entry 560 (class 1255 OID 17834)
-- Dependencies: 3
-- Name: lo_manage(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lo_manage() RETURNS trigger
    AS '$libdir/lo', 'lo_manage'
    LANGUAGE c;


ALTER FUNCTION public.lo_manage() OWNER TO root;

--
-- TOC entry 559 (class 1255 OID 17833)
-- Dependencies: 1065 3
-- Name: lo_oid(lo); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lo_oid(lo) RETURNS oid
    AS $_$SELECT $1::pg_catalog.oid$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.lo_oid(lo) OWNER TO root;

--
-- TOC entry 226 (class 1255 OID 16974)
-- Dependencies: 3 1025
-- Name: longitude(earth); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION longitude(earth) RETURNS double precision
    AS $_$SELECT degrees(atan2(cube_ll_coord($1, 2), cube_ll_coord($1, 1)))$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.longitude(earth) OWNER TO root;

--
-- TOC entry 596 (class 1255 OID 17899)
-- Dependencies: 1066 1071 3
-- Name: lt_q_regex(ltree, lquery[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lt_q_regex(ltree, lquery[]) RETURNS boolean
    AS '$libdir/ltree', 'lt_q_regex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lt_q_regex(ltree, lquery[]) OWNER TO root;

--
-- TOC entry 597 (class 1255 OID 17900)
-- Dependencies: 1066 1071 3
-- Name: lt_q_rregex(lquery[], ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION lt_q_rregex(lquery[], ltree) RETURNS boolean
    AS '$libdir/ltree', 'lt_q_rregex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.lt_q_rregex(lquery[], ltree) OWNER TO root;

--
-- TOC entry 594 (class 1255 OID 17893)
-- Dependencies: 1069 1066 3
-- Name: ltq_regex(ltree, lquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltq_regex(ltree, lquery) RETURNS boolean
    AS '$libdir/ltree', 'ltq_regex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltq_regex(ltree, lquery) OWNER TO root;

--
-- TOC entry 595 (class 1255 OID 17894)
-- Dependencies: 1069 3 1066
-- Name: ltq_rregex(lquery, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltq_rregex(lquery, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltq_rregex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltq_rregex(lquery, ltree) OWNER TO root;

--
-- TOC entry 576 (class 1255 OID 17858)
-- Dependencies: 1066 3
-- Name: ltree2text(ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree2text(ltree) RETURNS text
    AS '$libdir/ltree', 'ltree2text'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree2text(ltree) OWNER TO root;

--
-- TOC entry 588 (class 1255 OID 17870)
-- Dependencies: 3 1066 1066 1066
-- Name: ltree_addltree(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_addltree(ltree, ltree) RETURNS ltree
    AS '$libdir/ltree', 'ltree_addltree'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_addltree(ltree, ltree) OWNER TO root;

--
-- TOC entry 589 (class 1255 OID 17871)
-- Dependencies: 1066 3 1066
-- Name: ltree_addtext(ltree, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_addtext(ltree, text) RETURNS ltree
    AS '$libdir/ltree', 'ltree_addtext'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_addtext(ltree, text) OWNER TO root;

--
-- TOC entry 563 (class 1255 OID 17839)
-- Dependencies: 1066 1066 3
-- Name: ltree_cmp(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_cmp(ltree, ltree) RETURNS integer
    AS '$libdir/ltree', 'ltree_cmp'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_cmp(ltree, ltree) OWNER TO root;

--
-- TOC entry 605 (class 1255 OID 17920)
-- Dependencies: 3
-- Name: ltree_compress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_compress(internal) RETURNS internal
    AS '$libdir/ltree', 'ltree_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ltree_compress(internal) OWNER TO root;

--
-- TOC entry 604 (class 1255 OID 17919)
-- Dependencies: 3
-- Name: ltree_consistent(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_consistent(internal, internal, smallint) RETURNS boolean
    AS '$libdir/ltree', 'ltree_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ltree_consistent(internal, internal, smallint) OWNER TO root;

--
-- TOC entry 606 (class 1255 OID 17921)
-- Dependencies: 3
-- Name: ltree_decompress(internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_decompress(internal) RETURNS internal
    AS '$libdir/ltree', 'ltree_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ltree_decompress(internal) OWNER TO root;

--
-- TOC entry 566 (class 1255 OID 17842)
-- Dependencies: 1066 3 1066
-- Name: ltree_eq(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_eq(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_eq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_eq(ltree, ltree) OWNER TO root;

--
-- TOC entry 567 (class 1255 OID 17843)
-- Dependencies: 1066 3 1066
-- Name: ltree_ge(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_ge(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_ge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_ge(ltree, ltree) OWNER TO root;

--
-- TOC entry 568 (class 1255 OID 17844)
-- Dependencies: 1066 1066 3
-- Name: ltree_gt(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_gt(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_gt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_gt(ltree, ltree) OWNER TO root;

--
-- TOC entry 586 (class 1255 OID 17868)
-- Dependencies: 1066 1066 3
-- Name: ltree_isparent(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_isparent(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_isparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_isparent(ltree, ltree) OWNER TO root;

--
-- TOC entry 565 (class 1255 OID 17841)
-- Dependencies: 3 1066 1066
-- Name: ltree_le(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_le(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_le'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_le(ltree, ltree) OWNER TO root;

--
-- TOC entry 564 (class 1255 OID 17840)
-- Dependencies: 3 1066 1066
-- Name: ltree_lt(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_lt(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_lt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_lt(ltree, ltree) OWNER TO root;

--
-- TOC entry 569 (class 1255 OID 17845)
-- Dependencies: 1066 3 1066
-- Name: ltree_ne(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_ne(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_ne'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_ne(ltree, ltree) OWNER TO root;

--
-- TOC entry 607 (class 1255 OID 17922)
-- Dependencies: 3
-- Name: ltree_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/ltree', 'ltree_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_penalty(internal, internal, internal) OWNER TO root;

--
-- TOC entry 608 (class 1255 OID 17923)
-- Dependencies: 3
-- Name: ltree_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_picksplit(internal, internal) RETURNS internal
    AS '$libdir/ltree', 'ltree_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ltree_picksplit(internal, internal) OWNER TO root;

--
-- TOC entry 587 (class 1255 OID 17869)
-- Dependencies: 1066 1066 3
-- Name: ltree_risparent(ltree, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_risparent(ltree, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltree_risparent'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_risparent(ltree, ltree) OWNER TO root;

--
-- TOC entry 610 (class 1255 OID 17925)
-- Dependencies: 3
-- Name: ltree_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_same(internal, internal, internal) RETURNS internal
    AS '$libdir/ltree', 'ltree_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ltree_same(internal, internal, internal) OWNER TO root;

--
-- TOC entry 590 (class 1255 OID 17872)
-- Dependencies: 1066 1066 3
-- Name: ltree_textadd(text, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_textadd(text, ltree) RETURNS ltree
    AS '$libdir/ltree', 'ltree_textadd'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltree_textadd(text, ltree) OWNER TO root;

--
-- TOC entry 609 (class 1255 OID 17924)
-- Dependencies: 3
-- Name: ltree_union(internal, internal); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltree_union(internal, internal) RETURNS integer
    AS '$libdir/ltree', 'ltree_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.ltree_union(internal, internal) OWNER TO root;

--
-- TOC entry 591 (class 1255 OID 17873)
-- Dependencies: 3
-- Name: ltreeparentsel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltreeparentsel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/ltree', 'ltreeparentsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltreeparentsel(internal, oid, internal, integer) OWNER TO root;

--
-- TOC entry 600 (class 1255 OID 17909)
-- Dependencies: 1072 1066 3
-- Name: ltxtq_exec(ltree, ltxtquery); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltxtq_exec(ltree, ltxtquery) RETURNS boolean
    AS '$libdir/ltree', 'ltxtq_exec'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltxtq_exec(ltree, ltxtquery) OWNER TO root;

--
-- TOC entry 601 (class 1255 OID 17910)
-- Dependencies: 1066 3 1072
-- Name: ltxtq_rexec(ltxtquery, ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ltxtq_rexec(ltxtquery, ltree) RETURNS boolean
    AS '$libdir/ltree', 'ltxtq_rexec'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.ltxtq_rexec(ltxtquery, ltree) OWNER TO root;

--
-- TOC entry 541 (class 1255 OID 17814)
-- Dependencies: 3 1041 1041
-- Name: make_valid(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(ean13) RETURNS ean13
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(ean13) OWNER TO root;

--
-- TOC entry 542 (class 1255 OID 17815)
-- Dependencies: 3 1044 1044
-- Name: make_valid(isbn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(isbn13) RETURNS isbn13
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(isbn13) OWNER TO root;

--
-- TOC entry 543 (class 1255 OID 17816)
-- Dependencies: 1047 3 1047
-- Name: make_valid(ismn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(ismn13) RETURNS ismn13
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(ismn13) OWNER TO root;

--
-- TOC entry 544 (class 1255 OID 17817)
-- Dependencies: 3 1050 1050
-- Name: make_valid(issn13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(issn13) RETURNS issn13
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(issn13) OWNER TO root;

--
-- TOC entry 545 (class 1255 OID 17818)
-- Dependencies: 1053 3 1053
-- Name: make_valid(isbn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(isbn) RETURNS isbn
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(isbn) OWNER TO root;

--
-- TOC entry 546 (class 1255 OID 17819)
-- Dependencies: 1056 1056 3
-- Name: make_valid(ismn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(ismn) RETURNS ismn
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(ismn) OWNER TO root;

--
-- TOC entry 547 (class 1255 OID 17820)
-- Dependencies: 3 1059 1059
-- Name: make_valid(issn); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(issn) RETURNS issn
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(issn) OWNER TO root;

--
-- TOC entry 548 (class 1255 OID 17821)
-- Dependencies: 1062 3 1062
-- Name: make_valid(upc); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION make_valid(upc) RETURNS upc
    AS '$libdir/isn', 'make_valid'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.make_valid(upc) OWNER TO root;

--
-- TOC entry 231 (class 1255 OID 16980)
-- Dependencies: 3
-- Name: metaphone(text, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION metaphone(text, integer) RETURNS text
    AS '$libdir/fuzzystrmatch', 'metaphone'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.metaphone(text, integer) OWNER TO root;

--
-- TOC entry 147 (class 1255 OID 16850)
-- Dependencies: 3 1017
-- Name: ne(chkpass, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION ne(chkpass, text) RETURNS boolean
    AS '$libdir/chkpass', 'chkpass_ne'
    LANGUAGE c STRICT;


ALTER FUNCTION public.ne(chkpass, text) OWNER TO root;

--
-- TOC entry 575 (class 1255 OID 17857)
-- Dependencies: 1066 3
-- Name: nlevel(ltree); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION nlevel(ltree) RETURNS integer
    AS '$libdir/ltree', 'nlevel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.nlevel(ltree) OWNER TO root;

--
-- TOC entry 632 (class 1255 OID 18010)
-- Dependencies: 3
-- Name: page_header(bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION page_header(page bytea, OUT lsn text, OUT tli smallint, OUT flags smallint, OUT lower smallint, OUT upper smallint, OUT special smallint, OUT pagesize smallint, OUT version smallint, OUT prune_xid xid) RETURNS record
    AS '$libdir/pageinspect', 'page_header'
    LANGUAGE c STRICT;


ALTER FUNCTION public.page_header(page bytea, OUT lsn text, OUT tli smallint, OUT flags smallint, OUT lower smallint, OUT upper smallint, OUT special smallint, OUT pagesize smallint, OUT version smallint, OUT prune_xid xid) OWNER TO root;

--
-- TOC entry 687 (class 1255 OID 18097)
-- Dependencies: 3
-- Name: pgp_key_id(bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_key_id(bytea) RETURNS text
    AS '$libdir/pgcrypto', 'pgp_key_id_w'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_key_id(bytea) OWNER TO root;

--
-- TOC entry 681 (class 1255 OID 18091)
-- Dependencies: 3
-- Name: pgp_pub_decrypt(bytea, bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea) RETURNS text
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea) OWNER TO root;

--
-- TOC entry 683 (class 1255 OID 18093)
-- Dependencies: 3
-- Name: pgp_pub_decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text) RETURNS text
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) OWNER TO root;

--
-- TOC entry 685 (class 1255 OID 18095)
-- Dependencies: 3
-- Name: pgp_pub_decrypt(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text, text) RETURNS text
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) OWNER TO root;

--
-- TOC entry 682 (class 1255 OID 18092)
-- Dependencies: 3
-- Name: pgp_pub_decrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) OWNER TO root;

--
-- TOC entry 684 (class 1255 OID 18094)
-- Dependencies: 3
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) OWNER TO root;

--
-- TOC entry 686 (class 1255 OID 18096)
-- Dependencies: 3
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) OWNER TO root;

--
-- TOC entry 677 (class 1255 OID 18087)
-- Dependencies: 3
-- Name: pgp_pub_encrypt(text, bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea) OWNER TO root;

--
-- TOC entry 679 (class 1255 OID 18089)
-- Dependencies: 3
-- Name: pgp_pub_encrypt(text, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea, text) OWNER TO root;

--
-- TOC entry 678 (class 1255 OID 18088)
-- Dependencies: 3
-- Name: pgp_pub_encrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) OWNER TO root;

--
-- TOC entry 680 (class 1255 OID 18090)
-- Dependencies: 3
-- Name: pgp_pub_encrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) OWNER TO root;

--
-- TOC entry 673 (class 1255 OID 18083)
-- Dependencies: 3
-- Name: pgp_sym_decrypt(bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text) RETURNS text
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text) OWNER TO root;

--
-- TOC entry 675 (class 1255 OID 18085)
-- Dependencies: 3
-- Name: pgp_sym_decrypt(bytea, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text, text) RETURNS text
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text, text) OWNER TO root;

--
-- TOC entry 674 (class 1255 OID 18084)
-- Dependencies: 3
-- Name: pgp_sym_decrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) OWNER TO root;

--
-- TOC entry 676 (class 1255 OID 18086)
-- Dependencies: 3
-- Name: pgp_sym_decrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) OWNER TO root;

--
-- TOC entry 669 (class 1255 OID 18079)
-- Dependencies: 3
-- Name: pgp_sym_encrypt(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_encrypt(text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_sym_encrypt(text, text) OWNER TO root;

--
-- TOC entry 671 (class 1255 OID 18081)
-- Dependencies: 3
-- Name: pgp_sym_encrypt(text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_encrypt(text, text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_sym_encrypt(text, text, text) OWNER TO root;

--
-- TOC entry 670 (class 1255 OID 18080)
-- Dependencies: 3
-- Name: pgp_sym_encrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) OWNER TO root;

--
-- TOC entry 672 (class 1255 OID 18082)
-- Dependencies: 3
-- Name: pgp_sym_encrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text, text) RETURNS bytea
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea'
    LANGUAGE c STRICT;


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) OWNER TO root;

--
-- TOC entry 271 (class 1255 OID 17055)
-- Dependencies: 3 1035
-- Name: querytree(query_int); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION querytree(query_int) RETURNS text
    AS '$libdir/_int', 'querytree'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.querytree(query_int) OWNER TO root;

--
-- TOC entry 145 (class 1255 OID 16848)
-- Dependencies: 1017 3
-- Name: raw(chkpass); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION raw(chkpass) RETURNS text
    AS '$libdir/chkpass', 'chkpass_rout'
    LANGUAGE c STRICT;


ALTER FUNCTION public.raw(chkpass) OWNER TO root;

--
-- TOC entry 273 (class 1255 OID 17057)
-- Dependencies: 3 1035
-- Name: rboolop(query_int, integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION rboolop(query_int, integer[]) RETURNS boolean
    AS '$libdir/_int', 'rboolop'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.rboolop(query_int, integer[]) OWNER TO root;

--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 273
-- Name: FUNCTION rboolop(query_int, integer[]); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION rboolop(query_int, integer[]) IS 'boolean operation with array';


--
-- TOC entry 222 (class 1255 OID 16970)
-- Dependencies: 3
-- Name: sec_to_gc(double precision); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION sec_to_gc(double precision) RETURNS double precision
    AS $_$SELECT CASE WHEN $1 < 0 THEN 0::float8 WHEN $1/(2*earth()) > 1 THEN pi()*earth() ELSE 2*earth()*asin($1/(2*earth())) END$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.sec_to_gc(double precision) OWNER TO root;

--
-- TOC entry 705 (class 1255 OID 18117)
-- Dependencies: 3 1087 1087
-- Name: seg_cmp(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_cmp(seg, seg) RETURNS integer
    AS '$libdir/seg', 'seg_cmp'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_cmp(seg, seg) OWNER TO root;

--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 705
-- Name: FUNCTION seg_cmp(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_cmp(seg, seg) IS 'btree comparison function';


--
-- TOC entry 701 (class 1255 OID 18113)
-- Dependencies: 1087 3 1087
-- Name: seg_contained(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_contained(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_contained(seg, seg) OWNER TO root;

--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 701
-- Name: FUNCTION seg_contained(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_contained(seg, seg) IS 'contained in';


--
-- TOC entry 700 (class 1255 OID 18112)
-- Dependencies: 1087 3 1087
-- Name: seg_contains(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_contains(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_contains(seg, seg) OWNER TO root;

--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 700
-- Name: FUNCTION seg_contains(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_contains(seg, seg) IS 'contains';


--
-- TOC entry 704 (class 1255 OID 18116)
-- Dependencies: 1087 1087 3
-- Name: seg_different(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_different(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_different'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_different(seg, seg) OWNER TO root;

--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 704
-- Name: FUNCTION seg_different(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_different(seg, seg) IS 'different';


--
-- TOC entry 699 (class 1255 OID 18111)
-- Dependencies: 1087 3 1087
-- Name: seg_ge(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_ge(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_ge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_ge(seg, seg) OWNER TO root;

--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 699
-- Name: FUNCTION seg_ge(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_ge(seg, seg) IS 'greater than or equal';


--
-- TOC entry 698 (class 1255 OID 18110)
-- Dependencies: 1087 3 1087
-- Name: seg_gt(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_gt(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_gt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_gt(seg, seg) OWNER TO root;

--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 698
-- Name: FUNCTION seg_gt(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_gt(seg, seg) IS 'greater than';


--
-- TOC entry 707 (class 1255 OID 18119)
-- Dependencies: 1087 1087 1087 3
-- Name: seg_inter(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_inter(seg, seg) RETURNS seg
    AS '$libdir/seg', 'seg_inter'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_inter(seg, seg) OWNER TO root;

--
-- TOC entry 697 (class 1255 OID 18109)
-- Dependencies: 1087 3 1087
-- Name: seg_le(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_le(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_le'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_le(seg, seg) OWNER TO root;

--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 697
-- Name: FUNCTION seg_le(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_le(seg, seg) IS 'less than or equal';


--
-- TOC entry 694 (class 1255 OID 18106)
-- Dependencies: 1087 3 1087
-- Name: seg_left(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_left(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_left'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_left(seg, seg) OWNER TO root;

--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 694
-- Name: FUNCTION seg_left(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_left(seg, seg) IS 'is left of';


--
-- TOC entry 710 (class 1255 OID 18122)
-- Dependencies: 3 1087
-- Name: seg_lower(seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_lower(seg) RETURNS real
    AS '$libdir/seg', 'seg_lower'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_lower(seg) OWNER TO root;

--
-- TOC entry 696 (class 1255 OID 18108)
-- Dependencies: 1087 3 1087
-- Name: seg_lt(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_lt(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_lt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_lt(seg, seg) OWNER TO root;

--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 696
-- Name: FUNCTION seg_lt(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_lt(seg, seg) IS 'less than';


--
-- TOC entry 692 (class 1255 OID 18104)
-- Dependencies: 1087 3 1087
-- Name: seg_over_left(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_over_left(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_over_left'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_over_left(seg, seg) OWNER TO root;

--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 692
-- Name: FUNCTION seg_over_left(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_over_left(seg, seg) IS 'overlaps or is left of';


--
-- TOC entry 693 (class 1255 OID 18105)
-- Dependencies: 1087 3 1087
-- Name: seg_over_right(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_over_right(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_over_right'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_over_right(seg, seg) OWNER TO root;

--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 693
-- Name: FUNCTION seg_over_right(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_over_right(seg, seg) IS 'overlaps or is right of';


--
-- TOC entry 702 (class 1255 OID 18114)
-- Dependencies: 3 1087 1087
-- Name: seg_overlap(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_overlap(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_overlap'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_overlap(seg, seg) OWNER TO root;

--
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 702
-- Name: FUNCTION seg_overlap(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_overlap(seg, seg) IS 'overlaps';


--
-- TOC entry 695 (class 1255 OID 18107)
-- Dependencies: 3 1087 1087
-- Name: seg_right(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_right(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_right'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_right(seg, seg) OWNER TO root;

--
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 695
-- Name: FUNCTION seg_right(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_right(seg, seg) IS 'is right of';


--
-- TOC entry 703 (class 1255 OID 18115)
-- Dependencies: 1087 3 1087
-- Name: seg_same(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_same(seg, seg) RETURNS boolean
    AS '$libdir/seg', 'seg_same'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_same(seg, seg) OWNER TO root;

--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 703
-- Name: FUNCTION seg_same(seg, seg); Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON FUNCTION seg_same(seg, seg) IS 'same as';


--
-- TOC entry 708 (class 1255 OID 18120)
-- Dependencies: 3 1087
-- Name: seg_size(seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_size(seg) RETURNS real
    AS '$libdir/seg', 'seg_size'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_size(seg) OWNER TO root;

--
-- TOC entry 706 (class 1255 OID 18118)
-- Dependencies: 3 1087 1087 1087
-- Name: seg_union(seg, seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_union(seg, seg) RETURNS seg
    AS '$libdir/seg', 'seg_union'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_union(seg, seg) OWNER TO root;

--
-- TOC entry 709 (class 1255 OID 18121)
-- Dependencies: 3 1087
-- Name: seg_upper(seg); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION seg_upper(seg) RETURNS real
    AS '$libdir/seg', 'seg_upper'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.seg_upper(seg) OWNER TO root;

--
-- TOC entry 640 (class 1255 OID 18030)
-- Dependencies: 3
-- Name: set_limit(real); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION set_limit(real) RETURNS real
    AS '$libdir/pg_trgm', 'set_limit'
    LANGUAGE c STRICT;


ALTER FUNCTION public.set_limit(real) OWNER TO root;

--
-- TOC entry 641 (class 1255 OID 18031)
-- Dependencies: 3
-- Name: show_limit(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION show_limit() RETURNS real
    AS '$libdir/pg_trgm', 'show_limit'
    LANGUAGE c STABLE STRICT;


ALTER FUNCTION public.show_limit() OWNER TO root;

--
-- TOC entry 642 (class 1255 OID 18032)
-- Dependencies: 3
-- Name: show_trgm(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION show_trgm(text) RETURNS text[]
    AS '$libdir/pg_trgm', 'show_trgm'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.show_trgm(text) OWNER TO root;

--
-- TOC entry 643 (class 1255 OID 18033)
-- Dependencies: 3
-- Name: similarity(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION similarity(text, text) RETURNS real
    AS '$libdir/pg_trgm', 'similarity'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.similarity(text, text) OWNER TO root;

--
-- TOC entry 644 (class 1255 OID 18034)
-- Dependencies: 3
-- Name: similarity_op(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION similarity_op(text, text) RETURNS boolean
    AS '$libdir/pg_trgm', 'similarity_op'
    LANGUAGE c STABLE STRICT;


ALTER FUNCTION public.similarity_op(text, text) OWNER TO root;

--
-- TOC entry 251 (class 1255 OID 17010)
-- Dependencies: 3 1029
-- Name: skeys(hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION skeys(hstore) RETURNS SETOF text
    AS '$libdir/hstore', 'skeys'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.skeys(hstore) OWNER TO root;

--
-- TOC entry 283 (class 1255 OID 17075)
-- Dependencies: 3
-- Name: sort(integer[], text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION sort(integer[], text) RETURNS integer[]
    AS '$libdir/_int', 'sort'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort(integer[], text) OWNER TO root;

--
-- TOC entry 284 (class 1255 OID 17076)
-- Dependencies: 3
-- Name: sort(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION sort(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'sort'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort(integer[]) OWNER TO root;

--
-- TOC entry 285 (class 1255 OID 17077)
-- Dependencies: 3
-- Name: sort_asc(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION sort_asc(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'sort_asc'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort_asc(integer[]) OWNER TO root;

--
-- TOC entry 286 (class 1255 OID 17078)
-- Dependencies: 3
-- Name: sort_desc(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION sort_desc(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'sort_desc'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.sort_desc(integer[]) OWNER TO root;

--
-- TOC entry 232 (class 1255 OID 16981)
-- Dependencies: 3
-- Name: soundex(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION soundex(text) RETURNS text
    AS '$libdir/fuzzystrmatch', 'soundex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.soundex(text) OWNER TO root;

--
-- TOC entry 289 (class 1255 OID 17082)
-- Dependencies: 3
-- Name: subarray(integer[], integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION subarray(integer[], integer, integer) RETURNS integer[]
    AS '$libdir/_int', 'subarray'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subarray(integer[], integer, integer) OWNER TO root;

--
-- TOC entry 290 (class 1255 OID 17083)
-- Dependencies: 3
-- Name: subarray(integer[], integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION subarray(integer[], integer) RETURNS integer[]
    AS '$libdir/_int', 'subarray'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subarray(integer[], integer) OWNER TO root;

--
-- TOC entry 570 (class 1255 OID 17852)
-- Dependencies: 3 1066 1066
-- Name: subltree(ltree, integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION subltree(ltree, integer, integer) RETURNS ltree
    AS '$libdir/ltree', 'subltree'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subltree(ltree, integer, integer) OWNER TO root;

--
-- TOC entry 571 (class 1255 OID 17853)
-- Dependencies: 3 1066 1066
-- Name: subpath(ltree, integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION subpath(ltree, integer, integer) RETURNS ltree
    AS '$libdir/ltree', 'subpath'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subpath(ltree, integer, integer) OWNER TO root;

--
-- TOC entry 572 (class 1255 OID 17854)
-- Dependencies: 1066 1066 3
-- Name: subpath(ltree, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION subpath(ltree, integer) RETURNS ltree
    AS '$libdir/ltree', 'subpath'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.subpath(ltree, integer) OWNER TO root;

--
-- TOC entry 252 (class 1255 OID 17011)
-- Dependencies: 1029 3
-- Name: svals(hstore); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION svals(hstore) RETURNS SETOF text
    AS '$libdir/hstore', 'svals'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.svals(hstore) OWNER TO root;

--
-- TOC entry 248 (class 1255 OID 17006)
-- Dependencies: 3 1029
-- Name: tconvert(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION tconvert(text, text) RETURNS hstore
    AS '$libdir/hstore', 'tconvert'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.tconvert(text, text) OWNER TO root;

--
-- TOC entry 577 (class 1255 OID 17859)
-- Dependencies: 3 1066
-- Name: text2ltree(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION text2ltree(text) RETURNS ltree
    AS '$libdir/ltree', 'text2ltree'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.text2ltree(text) OWNER TO root;

--
-- TOC entry 233 (class 1255 OID 16982)
-- Dependencies: 3
-- Name: text_soundex(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION text_soundex(text) RETURNS text
    AS '$libdir/fuzzystrmatch', 'soundex'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.text_soundex(text) OWNER TO root;

--
-- TOC entry 287 (class 1255 OID 17079)
-- Dependencies: 3
-- Name: uniq(integer[]); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION uniq(integer[]) RETURNS integer[]
    AS '$libdir/_int', 'uniq'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.uniq(integer[]) OWNER TO root;

--
-- TOC entry 540 (class 1255 OID 17793)
-- Dependencies: 1041 1062 3
-- Name: upc(ean13); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION upc(ean13) RETURNS upc
    AS '$libdir/isn', 'upc_cast_from_ean13'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.upc(ean13) OWNER TO root;

--
-- TOC entry 721 (class 1255 OID 18175)
-- Dependencies: 3
-- Name: xml_encode_special_chars(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xml_encode_special_chars(text) RETURNS text
    AS '$libdir/pgxml', 'xml_encode_special_chars'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xml_encode_special_chars(text) OWNER TO root;

--
-- TOC entry 719 (class 1255 OID 18173)
-- Dependencies: 3
-- Name: xml_is_well_formed(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xml_is_well_formed(text) RETURNS boolean
    AS '$libdir/pgxml', 'xml_is_well_formed'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xml_is_well_formed(text) OWNER TO root;

--
-- TOC entry 720 (class 1255 OID 18174)
-- Dependencies: 3
-- Name: xml_valid(text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xml_valid(text) RETURNS boolean
    AS '$libdir/pgxml', 'xml_is_well_formed'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xml_valid(text) OWNER TO root;

--
-- TOC entry 725 (class 1255 OID 18179)
-- Dependencies: 3
-- Name: xpath_bool(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_bool(text, text) RETURNS boolean
    AS '$libdir/pgxml', 'xpath_bool'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_bool(text, text) OWNER TO root;

--
-- TOC entry 726 (class 1255 OID 18180)
-- Dependencies: 3
-- Name: xpath_list(text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_list(text, text, text) RETURNS text
    AS '$libdir/pgxml', 'xpath_list'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_list(text, text, text) OWNER TO root;

--
-- TOC entry 727 (class 1255 OID 18181)
-- Dependencies: 3
-- Name: xpath_list(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_list(text, text) RETURNS text
    AS $_$SELECT xpath_list($1,$2,',')$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_list(text, text) OWNER TO root;

--
-- TOC entry 723 (class 1255 OID 18177)
-- Dependencies: 3
-- Name: xpath_nodeset(text, text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_nodeset(text, text, text, text) RETURNS text
    AS '$libdir/pgxml', 'xpath_nodeset'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_nodeset(text, text, text, text) OWNER TO root;

--
-- TOC entry 728 (class 1255 OID 18182)
-- Dependencies: 3
-- Name: xpath_nodeset(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_nodeset(text, text) RETURNS text
    AS $_$SELECT xpath_nodeset($1,$2,'','')$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_nodeset(text, text) OWNER TO root;

--
-- TOC entry 729 (class 1255 OID 18183)
-- Dependencies: 3
-- Name: xpath_nodeset(text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_nodeset(text, text, text) RETURNS text
    AS $_$SELECT xpath_nodeset($1,$2,'',$3)$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_nodeset(text, text, text) OWNER TO root;

--
-- TOC entry 724 (class 1255 OID 18178)
-- Dependencies: 3
-- Name: xpath_number(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_number(text, text) RETURNS real
    AS '$libdir/pgxml', 'xpath_number'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_number(text, text) OWNER TO root;

--
-- TOC entry 722 (class 1255 OID 18176)
-- Dependencies: 3
-- Name: xpath_string(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_string(text, text) RETURNS text
    AS '$libdir/pgxml', 'xpath_string'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xpath_string(text, text) OWNER TO root;

--
-- TOC entry 730 (class 1255 OID 18184)
-- Dependencies: 3
-- Name: xpath_table(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xpath_table(text, text, text, text, text) RETURNS SETOF record
    AS '$libdir/pgxml', 'xpath_table'
    LANGUAGE c STABLE STRICT;


ALTER FUNCTION public.xpath_table(text, text, text, text, text) OWNER TO root;

--
-- TOC entry 731 (class 1255 OID 18185)
-- Dependencies: 3
-- Name: xslt_process(text, text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xslt_process(text, text, text) RETURNS text
    AS '$libdir/pgxml', 'xslt_process'
    LANGUAGE c STRICT;


ALTER FUNCTION public.xslt_process(text, text, text) OWNER TO root;

--
-- TOC entry 732 (class 1255 OID 18186)
-- Dependencies: 3
-- Name: xslt_process(text, text); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION xslt_process(text, text) RETURNS text
    AS '$libdir/pgxml', 'xslt_process'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.xslt_process(text, text) OWNER TO root;

--
-- TOC entry 1102 (class 1255 OID 17049)
-- Dependencies: 267 266 3
-- Name: int_array_aggregate(integer); Type: AGGREGATE; Schema: public; Owner: root
--

CREATE AGGREGATE int_array_aggregate(integer) (
    SFUNC = int_agg_state,
    STYPE = integer[],
    FINALFUNC = int_agg_final_array
);


ALTER AGGREGATE public.int_array_aggregate(integer) OWNER TO root;

--
-- TOC entry 1839 (class 2617 OID 17074)
-- Dependencies: 3 282
-- Name: #; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR # (
    PROCEDURE = icount,
    RIGHTARG = integer[]
);


ALTER OPERATOR public.# (NONE, integer[]) OWNER TO root;

--
-- TOC entry 1840 (class 2617 OID 17081)
-- Dependencies: 288 3
-- Name: #; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR # (
    PROCEDURE = idx,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.# (integer[], integer) OWNER TO root;

--
-- TOC entry 2060 (class 2617 OID 18035)
-- Dependencies: 644 3
-- Name: %; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR % (
    PROCEDURE = similarity_op,
    LEFTARG = text,
    RIGHTARG = text,
    COMMUTATOR = %,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.% (text, text) OWNER TO root;

--
-- TOC entry 1825 (class 2617 OID 17095)
-- Dependencies: 3 280
-- Name: &; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR & (
    PROCEDURE = _int_inter,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &
);


ALTER OPERATOR public.& (integer[], integer[]) OWNER TO root;

--
-- TOC entry 1811 (class 2617 OID 16887)
-- Dependencies: 161 1020 3 1020
-- Name: &&; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR && (
    PROCEDURE = cube_overlap,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = &&,
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (cube, cube) OWNER TO root;

--
-- TOC entry 1833 (class 2617 OID 17067)
-- Dependencies: 276 3
-- Name: &&; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR && (
    PROCEDURE = _int_overlap,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.&& (integer[], integer[]) OWNER TO root;

--
-- TOC entry 2067 (class 2617 OID 18130)
-- Dependencies: 3 702 1087 1087
-- Name: &&; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR && (
    PROCEDURE = seg_overlap,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = &&,
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (seg, seg) OWNER TO root;

--
-- TOC entry 2066 (class 2617 OID 18129)
-- Dependencies: 3 1087 1087 692
-- Name: &<; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR &< (
    PROCEDURE = seg_over_left,
    LEFTARG = seg,
    RIGHTARG = seg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&< (seg, seg) OWNER TO root;

--
-- TOC entry 2068 (class 2617 OID 18131)
-- Dependencies: 693 1087 1087 3
-- Name: &>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR &> (
    PROCEDURE = seg_over_right,
    LEFTARG = seg,
    RIGHTARG = seg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&> (seg, seg) OWNER TO root;

--
-- TOC entry 1841 (class 2617 OID 17085)
-- Dependencies: 291 3
-- Name: +; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.+ (integer[], integer) OWNER TO root;

--
-- TOC entry 1842 (class 2617 OID 17087)
-- Dependencies: 3 292
-- Name: +; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_array,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = +
);


ALTER OPERATOR public.+ (integer[], integer[]) OWNER TO root;

--
-- TOC entry 1843 (class 2617 OID 17089)
-- Dependencies: 293 3
-- Name: -; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR - (
    PROCEDURE = intarray_del_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.- (integer[], integer) OWNER TO root;

--
-- TOC entry 1816 (class 2617 OID 17094)
-- Dependencies: 295 3
-- Name: -; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR - (
    PROCEDURE = intset_subtract,
    LEFTARG = integer[],
    RIGHTARG = integer[]
);


ALTER OPERATOR public.- (integer[], integer[]) OWNER TO root;

--
-- TOC entry 1821 (class 2617 OID 16991)
-- Dependencies: 239 3 1029
-- Name: ->; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR -> (
    PROCEDURE = fetchval,
    LEFTARG = hstore,
    RIGHTARG = text
);


ALTER OPERATOR public.-> (hstore, text) OWNER TO root;

--
-- TOC entry 1807 (class 2617 OID 16885)
-- Dependencies: 1020 1020 3 154
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = cube_lt,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (cube, cube) OWNER TO root;

--
-- TOC entry 1845 (class 2617 OID 17363)
-- Dependencies: 3 1041 1041 330
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ean13) OWNER TO root;

--
-- TOC entry 1849 (class 2617 OID 17369)
-- Dependencies: 1041 336 1044 3
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, isbn13) OWNER TO root;

--
-- TOC entry 1855 (class 2617 OID 17377)
-- Dependencies: 1041 1044 3 390
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, ean13) OWNER TO root;

--
-- TOC entry 1861 (class 2617 OID 17381)
-- Dependencies: 1041 3 342 1047
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ismn13) OWNER TO root;

--
-- TOC entry 1867 (class 2617 OID 17389)
-- Dependencies: 1047 3 426 1041
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ean13) OWNER TO root;

--
-- TOC entry 1873 (class 2617 OID 17393)
-- Dependencies: 348 3 1041 1050
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, issn13) OWNER TO root;

--
-- TOC entry 1975 (class 2617 OID 17401)
-- Dependencies: 462 3 1050 1041
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, ean13) OWNER TO root;

--
-- TOC entry 1879 (class 2617 OID 17405)
-- Dependencies: 3 354 1053 1041
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, isbn) OWNER TO root;

--
-- TOC entry 1927 (class 2617 OID 17413)
-- Dependencies: 3 408 1041 1053
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, ean13) OWNER TO root;

--
-- TOC entry 1885 (class 2617 OID 17417)
-- Dependencies: 1056 360 1041 3
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ismn) OWNER TO root;

--
-- TOC entry 1957 (class 2617 OID 17425)
-- Dependencies: 3 1041 444 1056
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ean13) OWNER TO root;

--
-- TOC entry 1891 (class 2617 OID 17429)
-- Dependencies: 1041 366 3 1059
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, issn) OWNER TO root;

--
-- TOC entry 1993 (class 2617 OID 17437)
-- Dependencies: 1041 1059 3 480
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, ean13) OWNER TO root;

--
-- TOC entry 1897 (class 2617 OID 17441)
-- Dependencies: 372 3 1041 1062
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, upc) OWNER TO root;

--
-- TOC entry 2008 (class 2617 OID 17449)
-- Dependencies: 492 3 1062 1041
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (upc, ean13) OWNER TO root;

--
-- TOC entry 1903 (class 2617 OID 17453)
-- Dependencies: 378 3 1044 1044
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, isbn13) OWNER TO root;

--
-- TOC entry 1909 (class 2617 OID 17459)
-- Dependencies: 384 3 1044 1053
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, isbn) OWNER TO root;

--
-- TOC entry 1921 (class 2617 OID 17467)
-- Dependencies: 1044 3 1053 402
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, isbn13) OWNER TO root;

--
-- TOC entry 1915 (class 2617 OID 17471)
-- Dependencies: 396 1053 1053 3
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, isbn) OWNER TO root;

--
-- TOC entry 1933 (class 2617 OID 17477)
-- Dependencies: 414 1047 1047 3
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ismn13) OWNER TO root;

--
-- TOC entry 1939 (class 2617 OID 17483)
-- Dependencies: 420 3 1047 1056
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ismn) OWNER TO root;

--
-- TOC entry 1951 (class 2617 OID 17491)
-- Dependencies: 3 438 1047 1056
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ismn13) OWNER TO root;

--
-- TOC entry 1945 (class 2617 OID 17495)
-- Dependencies: 1056 432 3 1056
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ismn) OWNER TO root;

--
-- TOC entry 1963 (class 2617 OID 17501)
-- Dependencies: 3 1050 450 1050
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, issn13) OWNER TO root;

--
-- TOC entry 1969 (class 2617 OID 17507)
-- Dependencies: 3 1050 1059 456
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, issn) OWNER TO root;

--
-- TOC entry 1987 (class 2617 OID 17515)
-- Dependencies: 1050 3 1059 474
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, issn13) OWNER TO root;

--
-- TOC entry 1981 (class 2617 OID 17519)
-- Dependencies: 468 1059 1059 3
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, issn) OWNER TO root;

--
-- TOC entry 1999 (class 2617 OID 17525)
-- Dependencies: 1062 486 3 1062
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (upc, upc) OWNER TO root;

--
-- TOC entry 2014 (class 2617 OID 17848)
-- Dependencies: 3 564 1066 1066
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = ltree_lt,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (ltree, ltree) OWNER TO root;

--
-- TOC entry 2061 (class 2617 OID 18125)
-- Dependencies: 1087 3 696 1087
-- Name: <; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR < (
    PROCEDURE = seg_lt,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (seg, seg) OWNER TO root;

--
-- TOC entry 2065 (class 2617 OID 18128)
-- Dependencies: 1087 3 694 1087
-- Name: <<; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR << (
    PROCEDURE = seg_left,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<< (seg, seg) OWNER TO root;

--
-- TOC entry 1809 (class 2617 OID 16886)
-- Dependencies: 1020 1020 156 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = cube_le,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (cube, cube) OWNER TO root;

--
-- TOC entry 1846 (class 2617 OID 17364)
-- Dependencies: 331 1041 1041 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ean13) OWNER TO root;

--
-- TOC entry 1850 (class 2617 OID 17372)
-- Dependencies: 1041 3 337 1044
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, isbn13) OWNER TO root;

--
-- TOC entry 1856 (class 2617 OID 17376)
-- Dependencies: 1044 1041 391 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, ean13) OWNER TO root;

--
-- TOC entry 1862 (class 2617 OID 17384)
-- Dependencies: 1041 1047 343 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ismn13) OWNER TO root;

--
-- TOC entry 1868 (class 2617 OID 17388)
-- Dependencies: 1047 3 427 1041
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ean13) OWNER TO root;

--
-- TOC entry 1874 (class 2617 OID 17396)
-- Dependencies: 349 1050 3 1041
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, issn13) OWNER TO root;

--
-- TOC entry 1976 (class 2617 OID 17400)
-- Dependencies: 1050 463 3 1041
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, ean13) OWNER TO root;

--
-- TOC entry 1880 (class 2617 OID 17408)
-- Dependencies: 1041 3 355 1053
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, isbn) OWNER TO root;

--
-- TOC entry 1928 (class 2617 OID 17412)
-- Dependencies: 1041 1053 3 409
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, ean13) OWNER TO root;

--
-- TOC entry 1886 (class 2617 OID 17420)
-- Dependencies: 1056 3 361 1041
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ismn) OWNER TO root;

--
-- TOC entry 1958 (class 2617 OID 17424)
-- Dependencies: 445 3 1041 1056
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ean13) OWNER TO root;

--
-- TOC entry 1892 (class 2617 OID 17432)
-- Dependencies: 1059 367 1041 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, issn) OWNER TO root;

--
-- TOC entry 1994 (class 2617 OID 17436)
-- Dependencies: 481 3 1059 1041
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, ean13) OWNER TO root;

--
-- TOC entry 1898 (class 2617 OID 17444)
-- Dependencies: 3 1041 1062 373
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, upc) OWNER TO root;

--
-- TOC entry 2009 (class 2617 OID 17448)
-- Dependencies: 493 3 1062 1041
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (upc, ean13) OWNER TO root;

--
-- TOC entry 1904 (class 2617 OID 17454)
-- Dependencies: 3 379 1044 1044
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, isbn13) OWNER TO root;

--
-- TOC entry 1910 (class 2617 OID 17462)
-- Dependencies: 385 3 1044 1053
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, isbn) OWNER TO root;

--
-- TOC entry 1922 (class 2617 OID 17466)
-- Dependencies: 1053 403 1044 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, isbn13) OWNER TO root;

--
-- TOC entry 1916 (class 2617 OID 17472)
-- Dependencies: 397 3 1053 1053
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, isbn) OWNER TO root;

--
-- TOC entry 1934 (class 2617 OID 17478)
-- Dependencies: 415 1047 1047 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ismn13) OWNER TO root;

--
-- TOC entry 1940 (class 2617 OID 17486)
-- Dependencies: 3 421 1056 1047
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ismn) OWNER TO root;

--
-- TOC entry 1952 (class 2617 OID 17490)
-- Dependencies: 1047 3 1056 439
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ismn13) OWNER TO root;

--
-- TOC entry 1946 (class 2617 OID 17496)
-- Dependencies: 1056 3 1056 433
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ismn) OWNER TO root;

--
-- TOC entry 1964 (class 2617 OID 17502)
-- Dependencies: 1050 1050 3 451
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, issn13) OWNER TO root;

--
-- TOC entry 1970 (class 2617 OID 17510)
-- Dependencies: 1059 3 1050 457
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, issn) OWNER TO root;

--
-- TOC entry 1988 (class 2617 OID 17514)
-- Dependencies: 475 3 1059 1050
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, issn13) OWNER TO root;

--
-- TOC entry 1982 (class 2617 OID 17520)
-- Dependencies: 1059 3 1059 469
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, issn) OWNER TO root;

--
-- TOC entry 2002 (class 2617 OID 17526)
-- Dependencies: 487 1062 1062 3
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (upc, upc) OWNER TO root;

--
-- TOC entry 2015 (class 2617 OID 17849)
-- Dependencies: 1066 565 3 1066
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = ltree_le,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (ltree, ltree) OWNER TO root;

--
-- TOC entry 2062 (class 2617 OID 18126)
-- Dependencies: 1087 3 1087 697
-- Name: <=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <= (
    PROCEDURE = seg_le,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (seg, seg) OWNER TO root;

--
-- TOC entry 1806 (class 2617 OID 16851)
-- Dependencies: 1017 3 147
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = ne,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = =
);


ALTER OPERATOR public.<> (chkpass, text) OWNER TO root;

--
-- TOC entry 1814 (class 2617 OID 16888)
-- Dependencies: 153 1020 1020 3
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = cube_ne,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (cube, cube) OWNER TO root;

--
-- TOC entry 1848 (class 2617 OID 17365)
-- Dependencies: 1041 335 1041 3
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ean13) OWNER TO root;

--
-- TOC entry 1854 (class 2617 OID 17374)
-- Dependencies: 3 1041 1044 341
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, isbn13) OWNER TO root;

--
-- TOC entry 1860 (class 2617 OID 17378)
-- Dependencies: 1044 1041 3 395
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, ean13) OWNER TO root;

--
-- TOC entry 1866 (class 2617 OID 17386)
-- Dependencies: 1041 3 347 1047
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ismn13) OWNER TO root;

--
-- TOC entry 1872 (class 2617 OID 17390)
-- Dependencies: 3 1041 431 1047
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ean13) OWNER TO root;

--
-- TOC entry 1878 (class 2617 OID 17398)
-- Dependencies: 1041 3 353 1050
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, issn13) OWNER TO root;

--
-- TOC entry 1980 (class 2617 OID 17402)
-- Dependencies: 3 467 1041 1050
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, ean13) OWNER TO root;

--
-- TOC entry 1884 (class 2617 OID 17410)
-- Dependencies: 359 3 1041 1053
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, isbn) OWNER TO root;

--
-- TOC entry 1932 (class 2617 OID 17414)
-- Dependencies: 1053 3 1041 413
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, ean13) OWNER TO root;

--
-- TOC entry 1890 (class 2617 OID 17422)
-- Dependencies: 3 1056 365 1041
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ismn) OWNER TO root;

--
-- TOC entry 1962 (class 2617 OID 17426)
-- Dependencies: 449 1041 1056 3
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ean13) OWNER TO root;

--
-- TOC entry 1896 (class 2617 OID 17434)
-- Dependencies: 1059 371 1041 3
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, issn) OWNER TO root;

--
-- TOC entry 1998 (class 2617 OID 17438)
-- Dependencies: 3 1059 1041 485
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, ean13) OWNER TO root;

--
-- TOC entry 1902 (class 2617 OID 17446)
-- Dependencies: 377 1062 1041 3
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, upc) OWNER TO root;

--
-- TOC entry 2013 (class 2617 OID 17450)
-- Dependencies: 3 1062 1041 497
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (upc, ean13) OWNER TO root;

--
-- TOC entry 1908 (class 2617 OID 17455)
-- Dependencies: 1044 3 1044 383
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, isbn13) OWNER TO root;

--
-- TOC entry 1914 (class 2617 OID 17464)
-- Dependencies: 3 389 1053 1044
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, isbn) OWNER TO root;

--
-- TOC entry 1926 (class 2617 OID 17468)
-- Dependencies: 407 3 1053 1044
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, isbn13) OWNER TO root;

--
-- TOC entry 1920 (class 2617 OID 17473)
-- Dependencies: 401 1053 1053 3
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, isbn) OWNER TO root;

--
-- TOC entry 1938 (class 2617 OID 17479)
-- Dependencies: 419 3 1047 1047
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ismn13) OWNER TO root;

--
-- TOC entry 1944 (class 2617 OID 17488)
-- Dependencies: 425 3 1047 1056
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ismn) OWNER TO root;

--
-- TOC entry 1956 (class 2617 OID 17492)
-- Dependencies: 3 443 1047 1056
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ismn13) OWNER TO root;

--
-- TOC entry 1950 (class 2617 OID 17497)
-- Dependencies: 1056 3 437 1056
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ismn) OWNER TO root;

--
-- TOC entry 1968 (class 2617 OID 17503)
-- Dependencies: 455 1050 3 1050
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, issn13) OWNER TO root;

--
-- TOC entry 1974 (class 2617 OID 17512)
-- Dependencies: 1059 461 3 1050
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, issn) OWNER TO root;

--
-- TOC entry 1992 (class 2617 OID 17516)
-- Dependencies: 479 3 1059 1050
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, issn13) OWNER TO root;

--
-- TOC entry 1986 (class 2617 OID 17521)
-- Dependencies: 473 3 1059 1059
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, issn) OWNER TO root;

--
-- TOC entry 2007 (class 2617 OID 17527)
-- Dependencies: 1062 491 3 1062
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (upc, upc) OWNER TO root;

--
-- TOC entry 2016 (class 2617 OID 17850)
-- Dependencies: 1066 569 3 1066
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = ltree_ne,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ltree, ltree) OWNER TO root;

--
-- TOC entry 2071 (class 2617 OID 18132)
-- Dependencies: 1087 3 704 1087
-- Name: <>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <> (
    PROCEDURE = seg_different,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (seg, seg) OWNER TO root;

--
-- TOC entry 1817 (class 2617 OID 16890)
-- Dependencies: 1020 160 1020 3
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = cube_contained,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (cube, cube) OWNER TO root;

--
-- TOC entry 1826 (class 2617 OID 17002)
-- Dependencies: 247 1029 1029 3
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (hstore, hstore) OWNER TO root;

--
-- TOC entry 1835 (class 2617 OID 17068)
-- Dependencies: 3 275
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (integer[], integer[]) OWNER TO root;

--
-- TOC entry 2019 (class 2617 OID 17874)
-- Dependencies: 1066 3 591 587 1066
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = ltree_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = @>,
    RESTRICT = ltreeparentsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree, ltree) OWNER TO root;

--
-- TOC entry 2037 (class 2617 OID 17958)
-- Dependencies: 3 1066 1068 612
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = _ltree_r_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree, ltree[]) OWNER TO root;

--
-- TOC entry 2038 (class 2617 OID 17961)
-- Dependencies: 3 613 1066 1068
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = _ltree_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree[], ltree) OWNER TO root;

--
-- TOC entry 2073 (class 2617 OID 18134)
-- Dependencies: 701 3 1087 1087
-- Name: <@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@ (
    PROCEDURE = seg_contained,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (seg, seg) OWNER TO root;

--
-- TOC entry 1820 (class 2617 OID 16978)
-- Dependencies: 229 3
-- Name: <@>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR <@> (
    PROCEDURE = geo_distance,
    LEFTARG = point,
    RIGHTARG = point,
    COMMUTATOR = <@>
);


ALTER OPERATOR public.<@> (point, point) OWNER TO root;

--
-- TOC entry 1805 (class 2617 OID 16852)
-- Dependencies: 3 146 1017
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = eq,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = <>
);


ALTER OPERATOR public.= (chkpass, text) OWNER TO root;

--
-- TOC entry 1812 (class 2617 OID 16889)
-- Dependencies: 152 1020 1020 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = cube_eq,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (cube, cube) OWNER TO root;

--
-- TOC entry 1831 (class 2617 OID 17366)
-- Dependencies: 332 3 1041 1041
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ean13) OWNER TO root;

--
-- TOC entry 1857 (class 2617 OID 17373)
-- Dependencies: 1044 1041 392 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, ean13) OWNER TO root;

--
-- TOC entry 1851 (class 2617 OID 17375)
-- Dependencies: 338 3 1041 1044
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, isbn13) OWNER TO root;

--
-- TOC entry 1869 (class 2617 OID 17385)
-- Dependencies: 1041 428 3 1047
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ean13) OWNER TO root;

--
-- TOC entry 1863 (class 2617 OID 17387)
-- Dependencies: 3 344 1047 1041
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ismn13) OWNER TO root;

--
-- TOC entry 1977 (class 2617 OID 17397)
-- Dependencies: 1050 464 1041 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, ean13) OWNER TO root;

--
-- TOC entry 1875 (class 2617 OID 17399)
-- Dependencies: 3 1050 350 1041
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, issn13) OWNER TO root;

--
-- TOC entry 1929 (class 2617 OID 17409)
-- Dependencies: 3 1053 410 1041
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, ean13) OWNER TO root;

--
-- TOC entry 1881 (class 2617 OID 17411)
-- Dependencies: 1041 356 1053 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, isbn) OWNER TO root;

--
-- TOC entry 1959 (class 2617 OID 17421)
-- Dependencies: 3 1056 1041 446
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ean13) OWNER TO root;

--
-- TOC entry 1887 (class 2617 OID 17423)
-- Dependencies: 3 362 1056 1041
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ismn) OWNER TO root;

--
-- TOC entry 1995 (class 2617 OID 17433)
-- Dependencies: 3 482 1041 1059
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, ean13) OWNER TO root;

--
-- TOC entry 1893 (class 2617 OID 17435)
-- Dependencies: 1041 368 3 1059
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, issn) OWNER TO root;

--
-- TOC entry 2010 (class 2617 OID 17445)
-- Dependencies: 494 1041 1062 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (upc, ean13) OWNER TO root;

--
-- TOC entry 1899 (class 2617 OID 17447)
-- Dependencies: 374 3 1041 1062
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, upc) OWNER TO root;

--
-- TOC entry 1905 (class 2617 OID 17456)
-- Dependencies: 3 1044 1044 380
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, isbn13) OWNER TO root;

--
-- TOC entry 1923 (class 2617 OID 17463)
-- Dependencies: 3 1053 1044 404
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, isbn13) OWNER TO root;

--
-- TOC entry 1911 (class 2617 OID 17465)
-- Dependencies: 1044 386 1053 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, isbn) OWNER TO root;

--
-- TOC entry 1917 (class 2617 OID 17474)
-- Dependencies: 398 3 1053 1053
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, isbn) OWNER TO root;

--
-- TOC entry 1935 (class 2617 OID 17480)
-- Dependencies: 3 416 1047 1047
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ismn13) OWNER TO root;

--
-- TOC entry 1953 (class 2617 OID 17487)
-- Dependencies: 440 1047 1056 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ismn13) OWNER TO root;

--
-- TOC entry 1941 (class 2617 OID 17489)
-- Dependencies: 3 1047 1056 422
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ismn) OWNER TO root;

--
-- TOC entry 1947 (class 2617 OID 17498)
-- Dependencies: 1056 434 3 1056
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ismn) OWNER TO root;

--
-- TOC entry 1965 (class 2617 OID 17504)
-- Dependencies: 3 452 1050 1050
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, issn13) OWNER TO root;

--
-- TOC entry 1989 (class 2617 OID 17511)
-- Dependencies: 476 3 1059 1050
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, issn13) OWNER TO root;

--
-- TOC entry 1971 (class 2617 OID 17513)
-- Dependencies: 1059 458 3 1050
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, issn) OWNER TO root;

--
-- TOC entry 1983 (class 2617 OID 17522)
-- Dependencies: 470 3 1059 1059
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, issn) OWNER TO root;

--
-- TOC entry 2003 (class 2617 OID 17528)
-- Dependencies: 1062 1062 488 3
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (upc, upc) OWNER TO root;

--
-- TOC entry 2004 (class 2617 OID 17851)
-- Dependencies: 1066 566 3 1066
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = ltree_eq,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ltree, ltree) OWNER TO root;

--
-- TOC entry 2070 (class 2617 OID 18133)
-- Dependencies: 1087 3 703 1087
-- Name: =; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR = (
    PROCEDURE = seg_same,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (seg, seg) OWNER TO root;

--
-- TOC entry 1829 (class 2617 OID 17007)
-- Dependencies: 248 3 1029
-- Name: =>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR => (
    PROCEDURE = tconvert,
    LEFTARG = text,
    RIGHTARG = text
);


ALTER OPERATOR public.=> (text, text) OWNER TO root;

--
-- TOC entry 1808 (class 2617 OID 16883)
-- Dependencies: 1020 1020 155 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = cube_gt,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (cube, cube) OWNER TO root;

--
-- TOC entry 1847 (class 2617 OID 17361)
-- Dependencies: 3 1041 1041 334
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ean13) OWNER TO root;

--
-- TOC entry 1859 (class 2617 OID 17367)
-- Dependencies: 394 1041 1044 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, ean13) OWNER TO root;

--
-- TOC entry 1853 (class 2617 OID 17371)
-- Dependencies: 3 1041 1044 340
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, isbn13) OWNER TO root;

--
-- TOC entry 1871 (class 2617 OID 17379)
-- Dependencies: 3 1047 1041 430
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ean13) OWNER TO root;

--
-- TOC entry 1865 (class 2617 OID 17383)
-- Dependencies: 3 346 1047 1041
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ismn13) OWNER TO root;

--
-- TOC entry 1979 (class 2617 OID 17391)
-- Dependencies: 1041 1050 3 466
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, ean13) OWNER TO root;

--
-- TOC entry 1877 (class 2617 OID 17395)
-- Dependencies: 1050 3 352 1041
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, issn13) OWNER TO root;

--
-- TOC entry 1931 (class 2617 OID 17403)
-- Dependencies: 1053 1041 412 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, ean13) OWNER TO root;

--
-- TOC entry 1883 (class 2617 OID 17407)
-- Dependencies: 1041 3 1053 358
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, isbn) OWNER TO root;

--
-- TOC entry 1961 (class 2617 OID 17415)
-- Dependencies: 1056 3 1041 448
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ean13) OWNER TO root;

--
-- TOC entry 1889 (class 2617 OID 17419)
-- Dependencies: 1056 1041 3 364
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ismn) OWNER TO root;

--
-- TOC entry 1997 (class 2617 OID 17427)
-- Dependencies: 3 1059 1041 484
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, ean13) OWNER TO root;

--
-- TOC entry 1895 (class 2617 OID 17431)
-- Dependencies: 3 370 1059 1041
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, issn) OWNER TO root;

--
-- TOC entry 2012 (class 2617 OID 17439)
-- Dependencies: 1062 3 496 1041
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (upc, ean13) OWNER TO root;

--
-- TOC entry 1901 (class 2617 OID 17443)
-- Dependencies: 376 1062 1041 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, upc) OWNER TO root;

--
-- TOC entry 1907 (class 2617 OID 17451)
-- Dependencies: 382 3 1044 1044
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, isbn13) OWNER TO root;

--
-- TOC entry 1925 (class 2617 OID 17457)
-- Dependencies: 3 1053 1044 406
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, isbn13) OWNER TO root;

--
-- TOC entry 1913 (class 2617 OID 17461)
-- Dependencies: 1053 3 388 1044
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, isbn) OWNER TO root;

--
-- TOC entry 1919 (class 2617 OID 17469)
-- Dependencies: 400 3 1053 1053
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, isbn) OWNER TO root;

--
-- TOC entry 1937 (class 2617 OID 17475)
-- Dependencies: 3 418 1047 1047
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ismn13) OWNER TO root;

--
-- TOC entry 1955 (class 2617 OID 17481)
-- Dependencies: 442 1056 1047 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ismn13) OWNER TO root;

--
-- TOC entry 1943 (class 2617 OID 17485)
-- Dependencies: 3 424 1056 1047
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ismn) OWNER TO root;

--
-- TOC entry 1949 (class 2617 OID 17493)
-- Dependencies: 1056 436 1056 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ismn) OWNER TO root;

--
-- TOC entry 1967 (class 2617 OID 17499)
-- Dependencies: 454 1050 3 1050
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, issn13) OWNER TO root;

--
-- TOC entry 1991 (class 2617 OID 17505)
-- Dependencies: 1050 478 3 1059
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, issn13) OWNER TO root;

--
-- TOC entry 1973 (class 2617 OID 17509)
-- Dependencies: 460 1059 1050 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, issn) OWNER TO root;

--
-- TOC entry 1985 (class 2617 OID 17517)
-- Dependencies: 3 472 1059 1059
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, issn) OWNER TO root;

--
-- TOC entry 2006 (class 2617 OID 17523)
-- Dependencies: 490 1062 1062 3
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (upc, upc) OWNER TO root;

--
-- TOC entry 2001 (class 2617 OID 17846)
-- Dependencies: 1066 568 3 1066
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = ltree_gt,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (ltree, ltree) OWNER TO root;

--
-- TOC entry 2063 (class 2617 OID 18123)
-- Dependencies: 3 698 1087 1087
-- Name: >; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR > (
    PROCEDURE = seg_gt,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (seg, seg) OWNER TO root;

--
-- TOC entry 1810 (class 2617 OID 16884)
-- Dependencies: 1020 1020 3 157
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = cube_ge,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (cube, cube) OWNER TO root;

--
-- TOC entry 1837 (class 2617 OID 17362)
-- Dependencies: 333 1041 1041 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ean13) OWNER TO root;

--
-- TOC entry 1852 (class 2617 OID 17368)
-- Dependencies: 3 1044 339 1041
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, isbn13) OWNER TO root;

--
-- TOC entry 1858 (class 2617 OID 17370)
-- Dependencies: 393 3 1041 1044
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, ean13) OWNER TO root;

--
-- TOC entry 1864 (class 2617 OID 17380)
-- Dependencies: 1041 1047 345 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ismn13) OWNER TO root;

--
-- TOC entry 1870 (class 2617 OID 17382)
-- Dependencies: 1041 3 429 1047
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ean13) OWNER TO root;

--
-- TOC entry 1876 (class 2617 OID 17392)
-- Dependencies: 351 1041 3 1050
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, issn13) OWNER TO root;

--
-- TOC entry 1978 (class 2617 OID 17394)
-- Dependencies: 465 3 1041 1050
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, ean13) OWNER TO root;

--
-- TOC entry 1882 (class 2617 OID 17404)
-- Dependencies: 1041 357 3 1053
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, isbn) OWNER TO root;

--
-- TOC entry 1930 (class 2617 OID 17406)
-- Dependencies: 3 1041 411 1053
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, ean13) OWNER TO root;

--
-- TOC entry 1888 (class 2617 OID 17416)
-- Dependencies: 363 1041 3 1056
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ismn) OWNER TO root;

--
-- TOC entry 1960 (class 2617 OID 17418)
-- Dependencies: 447 3 1056 1041
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ean13) OWNER TO root;

--
-- TOC entry 1894 (class 2617 OID 17428)
-- Dependencies: 369 1041 3 1059
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, issn) OWNER TO root;

--
-- TOC entry 1996 (class 2617 OID 17430)
-- Dependencies: 3 1041 483 1059
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, ean13) OWNER TO root;

--
-- TOC entry 1900 (class 2617 OID 17440)
-- Dependencies: 3 1041 1062 375
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, upc) OWNER TO root;

--
-- TOC entry 2011 (class 2617 OID 17442)
-- Dependencies: 495 1041 1062 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (upc, ean13) OWNER TO root;

--
-- TOC entry 1906 (class 2617 OID 17452)
-- Dependencies: 381 3 1044 1044
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, isbn13) OWNER TO root;

--
-- TOC entry 1912 (class 2617 OID 17458)
-- Dependencies: 3 1044 1053 387
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, isbn) OWNER TO root;

--
-- TOC entry 1924 (class 2617 OID 17460)
-- Dependencies: 405 1044 3 1053
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, isbn13) OWNER TO root;

--
-- TOC entry 1918 (class 2617 OID 17470)
-- Dependencies: 399 3 1053 1053
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, isbn) OWNER TO root;

--
-- TOC entry 1936 (class 2617 OID 17476)
-- Dependencies: 1047 417 1047 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ismn13) OWNER TO root;

--
-- TOC entry 1942 (class 2617 OID 17482)
-- Dependencies: 3 423 1056 1047
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ismn) OWNER TO root;

--
-- TOC entry 1954 (class 2617 OID 17484)
-- Dependencies: 1047 3 1056 441
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ismn13) OWNER TO root;

--
-- TOC entry 1948 (class 2617 OID 17494)
-- Dependencies: 1056 435 1056 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ismn) OWNER TO root;

--
-- TOC entry 1966 (class 2617 OID 17500)
-- Dependencies: 1050 1050 3 453
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, issn13) OWNER TO root;

--
-- TOC entry 1972 (class 2617 OID 17506)
-- Dependencies: 3 1050 1059 459
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, issn) OWNER TO root;

--
-- TOC entry 1990 (class 2617 OID 17508)
-- Dependencies: 477 3 1059 1050
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, issn13) OWNER TO root;

--
-- TOC entry 1984 (class 2617 OID 17518)
-- Dependencies: 1059 471 1059 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, issn) OWNER TO root;

--
-- TOC entry 2005 (class 2617 OID 17524)
-- Dependencies: 1062 489 1062 3
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (upc, upc) OWNER TO root;

--
-- TOC entry 2000 (class 2617 OID 17847)
-- Dependencies: 1066 567 3 1066
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = ltree_ge,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (ltree, ltree) OWNER TO root;

--
-- TOC entry 2064 (class 2617 OID 18124)
-- Dependencies: 699 1087 3 1087
-- Name: >=; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >= (
    PROCEDURE = seg_ge,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (seg, seg) OWNER TO root;

--
-- TOC entry 2069 (class 2617 OID 18127)
-- Dependencies: 3 695 1087 1087
-- Name: >>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR >> (
    PROCEDURE = seg_right,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.>> (seg, seg) OWNER TO root;

--
-- TOC entry 1822 (class 2617 OID 16994)
-- Dependencies: 1029 3 241
-- Name: ?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ? (
    PROCEDURE = exist,
    LEFTARG = hstore,
    RIGHTARG = text,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (hstore, text) OWNER TO root;

--
-- TOC entry 2029 (class 2617 OID 17901)
-- Dependencies: 597 1066 1071 3
-- Name: ?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ? (
    PROCEDURE = lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree,
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (lquery[], ltree) OWNER TO root;

--
-- TOC entry 2028 (class 2617 OID 17902)
-- Dependencies: 3 1066 1071 596
-- Name: ?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ? (
    PROCEDURE = lt_q_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (ltree, lquery[]) OWNER TO root;

--
-- TOC entry 2043 (class 2617 OID 17964)
-- Dependencies: 1071 1068 618 3
-- Name: ?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ? (
    PROCEDURE = _lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (lquery[], ltree[]) OWNER TO root;

--
-- TOC entry 2042 (class 2617 OID 17965)
-- Dependencies: 617 3 1068 1071
-- Name: ?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ? (
    PROCEDURE = _lt_q_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (ltree[], lquery[]) OWNER TO root;

--
-- TOC entry 2057 (class 2617 OID 17981)
-- Dependencies: 1066 3 622 1068 1066
-- Name: ?<@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ?<@ (
    PROCEDURE = _ltree_extract_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree
);


ALTER OPERATOR public.?<@ (ltree[], ltree) OWNER TO root;

--
-- TOC entry 2059 (class 2617 OID 17985)
-- Dependencies: 1066 1068 3 624 1072
-- Name: ?@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ?@ (
    PROCEDURE = _ltxtq_extract_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery
);


ALTER OPERATOR public.?@ (ltree[], ltxtquery) OWNER TO root;

--
-- TOC entry 2056 (class 2617 OID 17979)
-- Dependencies: 3 621 1066 1066 1068
-- Name: ?@>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ?@> (
    PROCEDURE = _ltree_extract_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree
);


ALTER OPERATOR public.?@> (ltree[], ltree) OWNER TO root;

--
-- TOC entry 2058 (class 2617 OID 17983)
-- Dependencies: 1069 1068 3 623 1066
-- Name: ?~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ?~ (
    PROCEDURE = _ltq_extract_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery
);


ALTER OPERATOR public.?~ (ltree[], lquery) OWNER TO root;

--
-- TOC entry 1818 (class 2617 OID 16893)
-- Dependencies: 159 3 1020 1020
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = cube_contains,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (cube, cube) OWNER TO root;

--
-- TOC entry 1827 (class 2617 OID 17005)
-- Dependencies: 1029 1029 246 3
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (hstore, hstore) OWNER TO root;

--
-- TOC entry 1836 (class 2617 OID 17071)
-- Dependencies: 3 274
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (integer[], integer[]) OWNER TO root;

--
-- TOC entry 2033 (class 2617 OID 17911)
-- Dependencies: 1072 1066 601 3
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltxtquery, ltree) OWNER TO root;

--
-- TOC entry 2032 (class 2617 OID 17912)
-- Dependencies: 1072 600 3 1066
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = ltxtq_exec,
    LEFTARG = ltree,
    RIGHTARG = ltxtquery,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltree, ltxtquery) OWNER TO root;

--
-- TOC entry 2045 (class 2617 OID 17966)
-- Dependencies: 620 1068 1072 3
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = _ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltxtquery, ltree[]) OWNER TO root;

--
-- TOC entry 2044 (class 2617 OID 17967)
-- Dependencies: 3 619 1072 1068
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = _ltxtq_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltree[], ltxtquery) OWNER TO root;

--
-- TOC entry 2074 (class 2617 OID 18137)
-- Dependencies: 1087 700 3 1087
-- Name: @; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @ (
    PROCEDURE = seg_contains,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (seg, seg) OWNER TO root;

--
-- TOC entry 1815 (class 2617 OID 16891)
-- Dependencies: 1020 3 1020 159
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = cube_contains,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (cube, cube) OWNER TO root;

--
-- TOC entry 1824 (class 2617 OID 17003)
-- Dependencies: 1029 246 3 1029
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (hstore, hstore) OWNER TO root;

--
-- TOC entry 1834 (class 2617 OID 17069)
-- Dependencies: 274 3
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (integer[], integer[]) OWNER TO root;

--
-- TOC entry 2017 (class 2617 OID 17875)
-- Dependencies: 1066 3 1066 586 591
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = ltree_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <@,
    RESTRICT = ltreeparentsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree, ltree) OWNER TO root;

--
-- TOC entry 2036 (class 2617 OID 17959)
-- Dependencies: 611 1068 3 1066
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = _ltree_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree[], ltree) OWNER TO root;

--
-- TOC entry 2039 (class 2617 OID 17960)
-- Dependencies: 1066 3 1068 614
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = _ltree_r_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree, ltree[]) OWNER TO root;

--
-- TOC entry 2072 (class 2617 OID 18135)
-- Dependencies: 700 3 1087 1087
-- Name: @>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @> (
    PROCEDURE = seg_contains,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (seg, seg) OWNER TO root;

--
-- TOC entry 1830 (class 2617 OID 17059)
-- Dependencies: 272 1035 3
-- Name: @@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR @@ (
    PROCEDURE = boolop,
    LEFTARG = integer[],
    RIGHTARG = query_int,
    COMMUTATOR = ~~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (integer[], query_int) OWNER TO root;

--
-- TOC entry 2020 (class 2617 OID 17876)
-- Dependencies: 3 587 1066 1066
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^<@ (
    PROCEDURE = ltree_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree, ltree) OWNER TO root;

--
-- TOC entry 2047 (class 2617 OID 17968)
-- Dependencies: 3 612 1068 1066
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^<@ (
    PROCEDURE = _ltree_r_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree, ltree[]) OWNER TO root;

--
-- TOC entry 2048 (class 2617 OID 17971)
-- Dependencies: 613 3 1068 1066
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^<@ (
    PROCEDURE = _ltree_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree[], ltree) OWNER TO root;

--
-- TOC entry 2031 (class 2617 OID 17903)
-- Dependencies: 3 1071 1066 597
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^? (
    PROCEDURE = lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree,
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (lquery[], ltree) OWNER TO root;

--
-- TOC entry 2030 (class 2617 OID 17904)
-- Dependencies: 1066 1071 3 596
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^? (
    PROCEDURE = lt_q_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (ltree, lquery[]) OWNER TO root;

--
-- TOC entry 2053 (class 2617 OID 17974)
-- Dependencies: 1071 1068 3 618
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^? (
    PROCEDURE = _lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (lquery[], ltree[]) OWNER TO root;

--
-- TOC entry 2052 (class 2617 OID 17975)
-- Dependencies: 1071 3 1068 617
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^? (
    PROCEDURE = _lt_q_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (ltree[], lquery[]) OWNER TO root;

--
-- TOC entry 2035 (class 2617 OID 17913)
-- Dependencies: 1072 3 1066 601
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@ (
    PROCEDURE = ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltxtquery, ltree) OWNER TO root;

--
-- TOC entry 2034 (class 2617 OID 17914)
-- Dependencies: 600 1072 1066 3
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@ (
    PROCEDURE = ltxtq_exec,
    LEFTARG = ltree,
    RIGHTARG = ltxtquery,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltree, ltxtquery) OWNER TO root;

--
-- TOC entry 2055 (class 2617 OID 17976)
-- Dependencies: 3 620 1068 1072
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@ (
    PROCEDURE = _ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltxtquery, ltree[]) OWNER TO root;

--
-- TOC entry 2054 (class 2617 OID 17977)
-- Dependencies: 1072 3 1068 619
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@ (
    PROCEDURE = _ltxtq_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltree[], ltxtquery) OWNER TO root;

--
-- TOC entry 2018 (class 2617 OID 17877)
-- Dependencies: 586 1066 1066 3
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@> (
    PROCEDURE = ltree_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree, ltree) OWNER TO root;

--
-- TOC entry 2046 (class 2617 OID 17969)
-- Dependencies: 611 3 1068 1066
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@> (
    PROCEDURE = _ltree_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree[], ltree) OWNER TO root;

--
-- TOC entry 2049 (class 2617 OID 17970)
-- Dependencies: 614 3 1066 1068
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^@> (
    PROCEDURE = _ltree_r_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree, ltree[]) OWNER TO root;

--
-- TOC entry 2027 (class 2617 OID 17897)
-- Dependencies: 595 3 1069 1066
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^~ (
    PROCEDURE = ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (lquery, ltree) OWNER TO root;

--
-- TOC entry 2026 (class 2617 OID 17898)
-- Dependencies: 594 3 1066 1069
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^~ (
    PROCEDURE = ltq_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (ltree, lquery) OWNER TO root;

--
-- TOC entry 2051 (class 2617 OID 17972)
-- Dependencies: 1068 3 1069 616
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^~ (
    PROCEDURE = _ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (lquery, ltree[]) OWNER TO root;

--
-- TOC entry 2050 (class 2617 OID 17973)
-- Dependencies: 615 3 1068 1069
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ^~ (
    PROCEDURE = _ltq_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (ltree[], lquery) OWNER TO root;

--
-- TOC entry 1844 (class 2617 OID 17091)
-- Dependencies: 294 3
-- Name: |; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR | (
    PROCEDURE = intset_union_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.| (integer[], integer) OWNER TO root;

--
-- TOC entry 1813 (class 2617 OID 17092)
-- Dependencies: 3 279
-- Name: |; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR | (
    PROCEDURE = _int_union,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = |
);


ALTER OPERATOR public.| (integer[], integer[]) OWNER TO root;

--
-- TOC entry 1823 (class 2617 OID 16999)
-- Dependencies: 245 1029 3 1029 1029
-- Name: ||; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR || (
    PROCEDURE = hs_concat,
    LEFTARG = hstore,
    RIGHTARG = hstore
);


ALTER OPERATOR public.|| (hstore, hstore) OWNER TO root;

--
-- TOC entry 2021 (class 2617 OID 17878)
-- Dependencies: 1066 1066 1066 588 3
-- Name: ||; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR || (
    PROCEDURE = ltree_addltree,
    LEFTARG = ltree,
    RIGHTARG = ltree
);


ALTER OPERATOR public.|| (ltree, ltree) OWNER TO root;

--
-- TOC entry 2022 (class 2617 OID 17879)
-- Dependencies: 1066 589 3 1066
-- Name: ||; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR || (
    PROCEDURE = ltree_addtext,
    LEFTARG = ltree,
    RIGHTARG = text
);


ALTER OPERATOR public.|| (ltree, text) OWNER TO root;

--
-- TOC entry 2023 (class 2617 OID 17880)
-- Dependencies: 1066 590 1066 3
-- Name: ||; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR || (
    PROCEDURE = ltree_textadd,
    LEFTARG = text,
    RIGHTARG = ltree
);


ALTER OPERATOR public.|| (text, ltree) OWNER TO root;

--
-- TOC entry 1819 (class 2617 OID 16892)
-- Dependencies: 1020 1020 3 160
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = cube_contained,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (cube, cube) OWNER TO root;

--
-- TOC entry 1828 (class 2617 OID 17004)
-- Dependencies: 1029 1029 3 247
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (hstore, hstore) OWNER TO root;

--
-- TOC entry 1838 (class 2617 OID 17070)
-- Dependencies: 275 3
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (integer[], integer[]) OWNER TO root;

--
-- TOC entry 2025 (class 2617 OID 17895)
-- Dependencies: 595 3 1069 1066
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (lquery, ltree) OWNER TO root;

--
-- TOC entry 2024 (class 2617 OID 17896)
-- Dependencies: 3 594 1069 1066
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = ltq_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (ltree, lquery) OWNER TO root;

--
-- TOC entry 2041 (class 2617 OID 17962)
-- Dependencies: 1068 3 1069 616
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = _ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (lquery, ltree[]) OWNER TO root;

--
-- TOC entry 2040 (class 2617 OID 17963)
-- Dependencies: 3 1068 1069 615
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = _ltq_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (ltree[], lquery) OWNER TO root;

--
-- TOC entry 2075 (class 2617 OID 18136)
-- Dependencies: 1087 701 3 1087
-- Name: ~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~ (
    PROCEDURE = seg_contained,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (seg, seg) OWNER TO root;

--
-- TOC entry 1832 (class 2617 OID 17058)
-- Dependencies: 3 1035 273
-- Name: ~~; Type: OPERATOR; Schema: public; Owner: root
--

CREATE OPERATOR ~~ (
    PROCEDURE = rboolop,
    LEFTARG = query_int,
    RIGHTARG = integer[],
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~~ (query_int, integer[]) OWNER TO root;

--
-- TOC entry 2210 (class 2616 OID 16902)
-- Dependencies: 1020 3 2369
-- Name: cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS cube_ops
    DEFAULT FOR TYPE cube USING btree AS
    OPERATOR 1 <(cube,cube) ,
    OPERATOR 2 <=(cube,cube) ,
    OPERATOR 3 =(cube,cube) ,
    OPERATOR 4 >=(cube,cube) ,
    OPERATOR 5 >(cube,cube) ,
    FUNCTION 1 cube_cmp(cube,cube);


ALTER OPERATOR CLASS public.cube_ops USING btree OWNER TO root;

--
-- TOC entry 2376 (class 2753 OID 17529)
-- Dependencies: 3
-- Name: isn_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY isn_ops USING btree;
ALTER OPERATOR FAMILY isn_ops USING btree ADD
    OPERATOR 1 <(ismn,ean13) ,
    OPERATOR 1 <(ismn13,ismn) ,
    OPERATOR 1 <(ismn13,ean13) ,
    OPERATOR 1 <(isbn,isbn13) ,
    OPERATOR 1 <(isbn,ean13) ,
    OPERATOR 1 <(isbn13,isbn) ,
    OPERATOR 1 <(isbn13,ean13) ,
    OPERATOR 1 <(ean13,ismn13) ,
    OPERATOR 1 <(ean13,issn13) ,
    OPERATOR 1 <(ean13,isbn) ,
    OPERATOR 1 <(ean13,ismn) ,
    OPERATOR 1 <(ean13,issn) ,
    OPERATOR 1 <(ean13,isbn13) ,
    OPERATOR 1 <(ean13,upc) ,
    OPERATOR 1 <(upc,ean13) ,
    OPERATOR 1 <(issn,issn13) ,
    OPERATOR 1 <(issn,ean13) ,
    OPERATOR 1 <(issn13,issn) ,
    OPERATOR 1 <(issn13,ean13) ,
    OPERATOR 1 <(ismn,ismn13) ,
    OPERATOR 2 <=(ean13,issn) ,
    OPERATOR 2 <=(ean13,isbn13) ,
    OPERATOR 2 <=(ean13,ismn13) ,
    OPERATOR 2 <=(ean13,issn13) ,
    OPERATOR 2 <=(ean13,isbn) ,
    OPERATOR 2 <=(ean13,ismn) ,
    OPERATOR 2 <=(ean13,upc) ,
    OPERATOR 2 <=(isbn13,ean13) ,
    OPERATOR 2 <=(isbn13,isbn) ,
    OPERATOR 2 <=(isbn,ean13) ,
    OPERATOR 2 <=(isbn,isbn13) ,
    OPERATOR 2 <=(ismn13,ean13) ,
    OPERATOR 2 <=(ismn13,ismn) ,
    OPERATOR 2 <=(ismn,ean13) ,
    OPERATOR 2 <=(ismn,ismn13) ,
    OPERATOR 2 <=(issn13,ean13) ,
    OPERATOR 2 <=(issn13,issn) ,
    OPERATOR 2 <=(issn,ean13) ,
    OPERATOR 2 <=(issn,issn13) ,
    OPERATOR 2 <=(upc,ean13) ,
    OPERATOR 3 =(ean13,issn13) ,
    OPERATOR 3 =(issn,ean13) ,
    OPERATOR 3 =(issn,issn13) ,
    OPERATOR 3 =(isbn,ean13) ,
    OPERATOR 3 =(isbn,isbn13) ,
    OPERATOR 3 =(ismn13,ean13) ,
    OPERATOR 3 =(ismn13,ismn) ,
    OPERATOR 3 =(ean13,upc) ,
    OPERATOR 3 =(ean13,issn) ,
    OPERATOR 3 =(ismn,ean13) ,
    OPERATOR 3 =(ismn,ismn13) ,
    OPERATOR 3 =(ean13,ismn) ,
    OPERATOR 3 =(ean13,isbn) ,
    OPERATOR 3 =(ean13,isbn13) ,
    OPERATOR 3 =(issn13,ean13) ,
    OPERATOR 3 =(issn13,issn) ,
    OPERATOR 3 =(isbn13,isbn) ,
    OPERATOR 3 =(ean13,ismn13) ,
    OPERATOR 3 =(upc,ean13) ,
    OPERATOR 3 =(isbn13,ean13) ,
    OPERATOR 4 >=(ean13,ismn) ,
    OPERATOR 4 >=(ismn13,ean13) ,
    OPERATOR 4 >=(ismn13,ismn) ,
    OPERATOR 4 >=(ean13,upc) ,
    OPERATOR 4 >=(ismn,ean13) ,
    OPERATOR 4 >=(ismn,ismn13) ,
    OPERATOR 4 >=(ean13,issn) ,
    OPERATOR 4 >=(isbn13,ean13) ,
    OPERATOR 4 >=(isbn13,isbn) ,
    OPERATOR 4 >=(ean13,isbn) ,
    OPERATOR 4 >=(ean13,issn13) ,
    OPERATOR 4 >=(issn13,ean13) ,
    OPERATOR 4 >=(issn13,issn) ,
    OPERATOR 4 >=(isbn,ean13) ,
    OPERATOR 4 >=(isbn,isbn13) ,
    OPERATOR 4 >=(ean13,ismn13) ,
    OPERATOR 4 >=(ean13,isbn13) ,
    OPERATOR 4 >=(issn,ean13) ,
    OPERATOR 4 >=(issn,issn13) ,
    OPERATOR 4 >=(upc,ean13) ,
    OPERATOR 5 >(issn13,issn) ,
    OPERATOR 5 >(isbn,ean13) ,
    OPERATOR 5 >(isbn,isbn13) ,
    OPERATOR 5 >(ismn13,ean13) ,
    OPERATOR 5 >(ismn13,ismn) ,
    OPERATOR 5 >(isbn13,ean13) ,
    OPERATOR 5 >(ean13,isbn13) ,
    OPERATOR 5 >(issn,ean13) ,
    OPERATOR 5 >(issn,issn13) ,
    OPERATOR 5 >(ean13,ismn13) ,
    OPERATOR 5 >(ean13,issn13) ,
    OPERATOR 5 >(isbn13,isbn) ,
    OPERATOR 5 >(issn13,ean13) ,
    OPERATOR 5 >(ismn,ean13) ,
    OPERATOR 5 >(ismn,ismn13) ,
    OPERATOR 5 >(ean13,isbn) ,
    OPERATOR 5 >(ean13,ismn) ,
    OPERATOR 5 >(ean13,issn) ,
    OPERATOR 5 >(upc,ean13) ,
    OPERATOR 5 >(ean13,upc) ,
    FUNCTION 1 (ean13, isbn13) btean13cmp(ean13,isbn13) ,
    FUNCTION 1 (ean13, ismn13) btean13cmp(ean13,ismn13) ,
    FUNCTION 1 (ean13, issn13) btean13cmp(ean13,issn13) ,
    FUNCTION 1 (ean13, isbn) btean13cmp(ean13,isbn) ,
    FUNCTION 1 (ean13, ismn) btean13cmp(ean13,ismn) ,
    FUNCTION 1 (ean13, issn) btean13cmp(ean13,issn) ,
    FUNCTION 1 (ean13, upc) btean13cmp(ean13,upc) ,
    FUNCTION 1 (isbn13, ean13) btisbn13cmp(isbn13,ean13) ,
    FUNCTION 1 (isbn13, isbn) btisbn13cmp(isbn13,isbn) ,
    FUNCTION 1 (isbn, ean13) btisbncmp(isbn,ean13) ,
    FUNCTION 1 (isbn, isbn13) btisbncmp(isbn,isbn13) ,
    FUNCTION 1 (ismn13, ean13) btismn13cmp(ismn13,ean13) ,
    FUNCTION 1 (ismn13, ismn) btismn13cmp(ismn13,ismn) ,
    FUNCTION 1 (ismn, ean13) btismncmp(ismn,ean13) ,
    FUNCTION 1 (ismn, ismn13) btismncmp(ismn,ismn13) ,
    FUNCTION 1 (issn13, ean13) btissn13cmp(issn13,ean13) ,
    FUNCTION 1 (issn13, issn) btissn13cmp(issn13,issn) ,
    FUNCTION 1 (issn, ean13) btissncmp(issn,ean13) ,
    FUNCTION 1 (issn, issn13) btissncmp(issn,issn13) ,
    FUNCTION 1 (upc, ean13) btupccmp(upc,ean13);


ALTER OPERATOR FAMILY public.isn_ops USING btree OWNER TO root;

--
-- TOC entry 2217 (class 2616 OID 17532)
-- Dependencies: 1041 2376 3
-- Name: ean13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ean13_ops
    DEFAULT FOR TYPE ean13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ean13,ean13) ,
    OPERATOR 2 <=(ean13,ean13) ,
    OPERATOR 3 =(ean13,ean13) ,
    OPERATOR 4 >=(ean13,ean13) ,
    OPERATOR 5 >(ean13,ean13) ,
    FUNCTION 1 btean13cmp(ean13,ean13);


ALTER OPERATOR CLASS public.ean13_ops USING btree OWNER TO root;

--
-- TOC entry 2377 (class 2753 OID 17530)
-- Dependencies: 3
-- Name: isn_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY isn_ops USING hash;
ALTER OPERATOR FAMILY isn_ops USING hash ADD
    OPERATOR 1 =(upc,ean13) ,
    OPERATOR 1 =(issn,issn13) ,
    OPERATOR 1 =(issn,ean13) ,
    OPERATOR 1 =(issn13,issn) ,
    OPERATOR 1 =(issn13,ean13) ,
    OPERATOR 1 =(ismn,ismn13) ,
    OPERATOR 1 =(ismn,ean13) ,
    OPERATOR 1 =(ismn13,ismn) ,
    OPERATOR 1 =(ismn13,ean13) ,
    OPERATOR 1 =(isbn,isbn13) ,
    OPERATOR 1 =(isbn,ean13) ,
    OPERATOR 1 =(isbn13,isbn) ,
    OPERATOR 1 =(isbn13,ean13) ,
    OPERATOR 1 =(ean13,upc) ,
    OPERATOR 1 =(ean13,issn) ,
    OPERATOR 1 =(ean13,ismn) ,
    OPERATOR 1 =(ean13,isbn) ,
    OPERATOR 1 =(ean13,issn13) ,
    OPERATOR 1 =(ean13,ismn13) ,
    OPERATOR 1 =(ean13,isbn13);


ALTER OPERATOR FAMILY public.isn_ops USING hash OWNER TO root;

--
-- TOC entry 2218 (class 2616 OID 17540)
-- Dependencies: 3 1041 2377
-- Name: ean13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ean13_ops
    DEFAULT FOR TYPE ean13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ean13,ean13) ,
    FUNCTION 1 hashean13(ean13);


ALTER OPERATOR CLASS public.ean13_ops USING hash OWNER TO root;

--
-- TOC entry 2216 (class 2616 OID 17149)
-- Dependencies: 3 2375
-- Name: gin__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gin__int_ops
    FOR TYPE integer[] USING gin AS
    STORAGE integer ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) RECHECK ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) RECHECK ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) RECHECK ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 ginarrayextract(anyarray,internal) ,
    FUNCTION 3 ginint4_queryextract(internal,internal,smallint) ,
    FUNCTION 4 ginint4_consistent(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin__int_ops USING gin OWNER TO root;

--
-- TOC entry 2213 (class 2616 OID 17040)
-- Dependencies: 3 2372 1029
-- Name: gin_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gin_hstore_ops
    DEFAULT FOR TYPE hstore USING gin AS
    STORAGE text ,
    OPERATOR 7 @>(hstore,hstore) RECHECK ,
    OPERATOR 9 ?(hstore,text) ,
    FUNCTION 1 bttextcmp(text,text) ,
    FUNCTION 2 gin_extract_hstore(internal,internal) ,
    FUNCTION 3 gin_extract_hstore_query(internal,internal,smallint) ,
    FUNCTION 4 gin_consistent_hstore(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin_hstore_ops USING gin OWNER TO root;

--
-- TOC entry 2237 (class 2616 OID 18061)
-- Dependencies: 3 2382
-- Name: gin_trgm_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gin_trgm_ops
    FOR TYPE text USING gin AS
    STORAGE integer ,
    OPERATOR 1 %(text,text) RECHECK ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 gin_extract_trgm(text,internal) ,
    FUNCTION 3 gin_extract_trgm(text,internal,internal) ,
    FUNCTION 4 gin_trgm_consistent(internal,internal,text);


ALTER OPERATOR CLASS public.gin_trgm_ops USING gin OWNER TO root;

--
-- TOC entry 2214 (class 2616 OID 17104)
-- Dependencies: 3 2373
-- Name: gist__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist__int_ops
    DEFAULT FOR TYPE integer[] USING gist AS
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) RECHECK ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_int_consistent(internal,integer[],integer) ,
    FUNCTION 2 g_int_union(internal,internal) ,
    FUNCTION 3 g_int_compress(internal) ,
    FUNCTION 4 g_int_decompress(internal) ,
    FUNCTION 5 g_int_penalty(internal,internal,internal) ,
    FUNCTION 6 g_int_picksplit(internal,internal) ,
    FUNCTION 7 g_int_same(integer[],integer[],internal);


ALTER OPERATOR CLASS public.gist__int_ops USING gist OWNER TO root;

--
-- TOC entry 2215 (class 2616 OID 17131)
-- Dependencies: 1038 3 2374
-- Name: gist__intbig_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist__intbig_ops
    FOR TYPE integer[] USING gist AS
    STORAGE intbig_gkey ,
    OPERATOR 3 &&(integer[],integer[]) RECHECK ,
    OPERATOR 6 =(anyarray,anyarray) RECHECK ,
    OPERATOR 7 @>(integer[],integer[]) RECHECK ,
    OPERATOR 8 <@(integer[],integer[]) RECHECK ,
    OPERATOR 13 @(integer[],integer[]) RECHECK ,
    OPERATOR 14 ~(integer[],integer[]) RECHECK ,
    OPERATOR 20 @@(integer[],query_int) RECHECK ,
    FUNCTION 1 g_intbig_consistent(internal,internal,integer) ,
    FUNCTION 2 g_intbig_union(internal,internal) ,
    FUNCTION 3 g_intbig_compress(internal) ,
    FUNCTION 4 g_intbig_decompress(internal) ,
    FUNCTION 5 g_intbig_penalty(internal,internal,internal) ,
    FUNCTION 6 g_intbig_picksplit(internal,internal) ,
    FUNCTION 7 g_intbig_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__intbig_ops USING gist OWNER TO root;

--
-- TOC entry 2235 (class 2616 OID 17993)
-- Dependencies: 1075 3 2380 1068
-- Name: gist__ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist__ltree_ops
    DEFAULT FOR TYPE ltree[] USING gist AS
    STORAGE ltree_gist ,
    OPERATOR 10 <@(ltree[],ltree) RECHECK ,
    OPERATOR 11 @>(ltree,ltree[]) RECHECK ,
    OPERATOR 12 ~(ltree[],lquery) RECHECK ,
    OPERATOR 13 ~(lquery,ltree[]) RECHECK ,
    OPERATOR 14 @(ltree[],ltxtquery) RECHECK ,
    OPERATOR 15 @(ltxtquery,ltree[]) RECHECK ,
    OPERATOR 16 ?(ltree[],lquery[]) RECHECK ,
    OPERATOR 17 ?(lquery[],ltree[]) RECHECK ,
    FUNCTION 1 _ltree_consistent(internal,internal,smallint) ,
    FUNCTION 2 _ltree_union(internal,internal) ,
    FUNCTION 3 _ltree_compress(internal) ,
    FUNCTION 4 ltree_decompress(internal) ,
    FUNCTION 5 _ltree_penalty(internal,internal,internal) ,
    FUNCTION 6 _ltree_picksplit(internal,internal) ,
    FUNCTION 7 _ltree_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__ltree_ops USING gist OWNER TO root;

--
-- TOC entry 2206 (class 2616 OID 16783)
-- Dependencies: 2365 1014 3
-- Name: gist_bit_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_bit_ops
    DEFAULT FOR TYPE bit USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bit,bit) ,
    OPERATOR 2 <=(bit,bit) ,
    OPERATOR 3 =(bit,bit) ,
    OPERATOR 4 >=(bit,bit) ,
    OPERATOR 5 >(bit,bit) ,
    FUNCTION 1 gbt_bit_consistent(internal,bit,smallint) ,
    FUNCTION 2 gbt_bit_union(bytea,internal) ,
    FUNCTION 3 gbt_bit_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bit_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bit_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bit_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bit_ops USING gist OWNER TO root;

--
-- TOC entry 2203 (class 2616 OID 16723)
-- Dependencies: 3 1014 2362
-- Name: gist_bpchar_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_bpchar_ops
    DEFAULT FOR TYPE character USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(character,character) ,
    OPERATOR 2 <=(character,character) ,
    OPERATOR 3 =(character,character) ,
    OPERATOR 4 >=(character,character) ,
    OPERATOR 5 >(character,character) ,
    FUNCTION 1 gbt_bpchar_consistent(internal,character,smallint) ,
    FUNCTION 2 gbt_text_union(bytea,internal) ,
    FUNCTION 3 gbt_bpchar_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_text_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_text_picksplit(internal,internal) ,
    FUNCTION 7 gbt_text_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bpchar_ops USING gist OWNER TO root;

--
-- TOC entry 2204 (class 2616 OID 16743)
-- Dependencies: 3 1014 2363
-- Name: gist_bytea_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_bytea_ops
    DEFAULT FOR TYPE bytea USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bytea,bytea) ,
    OPERATOR 2 <=(bytea,bytea) ,
    OPERATOR 3 =(bytea,bytea) ,
    OPERATOR 4 >=(bytea,bytea) ,
    OPERATOR 5 >(bytea,bytea) ,
    FUNCTION 1 gbt_bytea_consistent(internal,bytea,smallint) ,
    FUNCTION 2 gbt_bytea_union(bytea,internal) ,
    FUNCTION 3 gbt_bytea_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bytea_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bytea_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bytea_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bytea_ops USING gist OWNER TO root;

--
-- TOC entry 2200 (class 2616 OID 16667)
-- Dependencies: 3 2359 1008
-- Name: gist_cash_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_cash_ops
    DEFAULT FOR TYPE money USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(money,money) ,
    OPERATOR 2 <=(money,money) ,
    OPERATOR 3 =(money,money) ,
    OPERATOR 4 >=(money,money) ,
    OPERATOR 5 >(money,money) ,
    FUNCTION 1 gbt_cash_consistent(internal,money,smallint) ,
    FUNCTION 2 gbt_cash_union(bytea,internal) ,
    FUNCTION 3 gbt_cash_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_cash_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_cash_picksplit(internal,internal) ,
    FUNCTION 7 gbt_cash_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_cash_ops USING gist OWNER TO root;

--
-- TOC entry 2209 (class 2616 OID 16831)
-- Dependencies: 1008 3 2368
-- Name: gist_cidr_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_cidr_ops
    DEFAULT FOR TYPE cidr USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(inet,inet) RECHECK ,
    OPERATOR 2 <=(inet,inet) RECHECK ,
    OPERATOR 3 =(inet,inet) RECHECK ,
    OPERATOR 4 >=(inet,inet) RECHECK ,
    OPERATOR 5 >(inet,inet) RECHECK ,
    FUNCTION 1 gbt_inet_consistent(internal,inet,smallint) ,
    FUNCTION 2 gbt_inet_union(bytea,internal) ,
    FUNCTION 3 gbt_inet_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_inet_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_inet_picksplit(internal,internal) ,
    FUNCTION 7 gbt_inet_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_cidr_ops USING gist OWNER TO root;

--
-- TOC entry 2211 (class 2616 OID 16910)
-- Dependencies: 1020 2370 3
-- Name: gist_cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_cube_ops
    DEFAULT FOR TYPE cube USING gist AS
    OPERATOR 3 &&(cube,cube) ,
    OPERATOR 6 =(cube,cube) ,
    OPERATOR 7 @>(cube,cube) ,
    OPERATOR 8 <@(cube,cube) ,
    OPERATOR 13 @(cube,cube) ,
    OPERATOR 14 ~(cube,cube) ,
    FUNCTION 1 g_cube_consistent(internal,cube,integer) ,
    FUNCTION 2 g_cube_union(internal,internal) ,
    FUNCTION 3 g_cube_compress(internal) ,
    FUNCTION 4 g_cube_decompress(internal) ,
    FUNCTION 5 g_cube_penalty(internal,internal,internal) ,
    FUNCTION 6 g_cube_picksplit(internal,internal) ,
    FUNCTION 7 g_cube_same(cube,cube,internal);


ALTER OPERATOR CLASS public.gist_cube_ops USING gist OWNER TO root;

--
-- TOC entry 2198 (class 2616 OID 16626)
-- Dependencies: 2357 3 1005
-- Name: gist_date_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_date_ops
    DEFAULT FOR TYPE date USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(date,date) ,
    OPERATOR 2 <=(date,date) ,
    OPERATOR 3 =(date,date) ,
    OPERATOR 4 >=(date,date) ,
    OPERATOR 5 >(date,date) ,
    FUNCTION 1 gbt_date_consistent(internal,date,smallint) ,
    FUNCTION 2 gbt_date_union(bytea,internal) ,
    FUNCTION 3 gbt_date_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_date_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_date_picksplit(internal,internal) ,
    FUNCTION 7 gbt_date_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_date_ops USING gist OWNER TO root;

--
-- TOC entry 2192 (class 2616 OID 16514)
-- Dependencies: 2351 1005 3
-- Name: gist_float4_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_float4_ops
    DEFAULT FOR TYPE real USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(real,real) ,
    OPERATOR 2 <=(real,real) ,
    OPERATOR 3 =(real,real) ,
    OPERATOR 4 >=(real,real) ,
    OPERATOR 5 >(real,real) ,
    FUNCTION 1 gbt_float4_consistent(internal,real,smallint) ,
    FUNCTION 2 gbt_float4_union(bytea,internal) ,
    FUNCTION 3 gbt_float4_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_float4_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_float4_picksplit(internal,internal) ,
    FUNCTION 7 gbt_float4_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_float4_ops USING gist OWNER TO root;

--
-- TOC entry 2193 (class 2616 OID 16534)
-- Dependencies: 3 1008 2352
-- Name: gist_float8_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_float8_ops
    DEFAULT FOR TYPE double precision USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(double precision,double precision) ,
    OPERATOR 2 <=(double precision,double precision) ,
    OPERATOR 3 =(double precision,double precision) ,
    OPERATOR 4 >=(double precision,double precision) ,
    OPERATOR 5 >(double precision,double precision) ,
    FUNCTION 1 gbt_float8_consistent(internal,double precision,smallint) ,
    FUNCTION 2 gbt_float8_union(bytea,internal) ,
    FUNCTION 3 gbt_float8_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_float8_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_float8_picksplit(internal,internal) ,
    FUNCTION 7 gbt_float8_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_float8_ops USING gist OWNER TO root;

--
-- TOC entry 2212 (class 2616 OID 17025)
-- Dependencies: 1029 3 2371 1032
-- Name: gist_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_hstore_ops
    DEFAULT FOR TYPE hstore USING gist AS
    STORAGE ghstore ,
    OPERATOR 7 @>(hstore,hstore) RECHECK ,
    OPERATOR 9 ?(hstore,text) RECHECK ,
    OPERATOR 13 @(hstore,hstore) RECHECK ,
    FUNCTION 1 ghstore_consistent(internal,internal,integer) ,
    FUNCTION 2 ghstore_union(internal,internal) ,
    FUNCTION 3 ghstore_compress(internal) ,
    FUNCTION 4 ghstore_decompress(internal) ,
    FUNCTION 5 ghstore_penalty(internal,internal,internal) ,
    FUNCTION 6 ghstore_picksplit(internal,internal) ,
    FUNCTION 7 ghstore_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_hstore_ops USING gist OWNER TO root;

--
-- TOC entry 2208 (class 2616 OID 16817)
-- Dependencies: 3 1008 2367
-- Name: gist_inet_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_inet_ops
    DEFAULT FOR TYPE inet USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(inet,inet) RECHECK ,
    OPERATOR 2 <=(inet,inet) RECHECK ,
    OPERATOR 3 =(inet,inet) RECHECK ,
    OPERATOR 4 >=(inet,inet) RECHECK ,
    OPERATOR 5 >(inet,inet) RECHECK ,
    FUNCTION 1 gbt_inet_consistent(internal,inet,smallint) ,
    FUNCTION 2 gbt_inet_union(bytea,internal) ,
    FUNCTION 3 gbt_inet_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_inet_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_inet_picksplit(internal,internal) ,
    FUNCTION 7 gbt_inet_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_inet_ops USING gist OWNER TO root;

--
-- TOC entry 2189 (class 2616 OID 16454)
-- Dependencies: 966 2348 3
-- Name: gist_int2_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_int2_ops
    DEFAULT FOR TYPE smallint USING gist AS
    STORAGE gbtreekey4 ,
    OPERATOR 1 <(smallint,smallint) ,
    OPERATOR 2 <=(smallint,smallint) ,
    OPERATOR 3 =(smallint,smallint) ,
    OPERATOR 4 >=(smallint,smallint) ,
    OPERATOR 5 >(smallint,smallint) ,
    FUNCTION 1 gbt_int2_consistent(internal,smallint,smallint) ,
    FUNCTION 2 gbt_int2_union(bytea,internal) ,
    FUNCTION 3 gbt_int2_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int2_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int2_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int2_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int2_ops USING gist OWNER TO root;

--
-- TOC entry 2190 (class 2616 OID 16474)
-- Dependencies: 1005 3 2349
-- Name: gist_int4_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_int4_ops
    DEFAULT FOR TYPE integer USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(integer,integer) ,
    OPERATOR 2 <=(integer,integer) ,
    OPERATOR 3 =(integer,integer) ,
    OPERATOR 4 >=(integer,integer) ,
    OPERATOR 5 >(integer,integer) ,
    FUNCTION 1 gbt_int4_consistent(internal,integer,smallint) ,
    FUNCTION 2 gbt_int4_union(bytea,internal) ,
    FUNCTION 3 gbt_int4_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int4_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int4_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int4_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int4_ops USING gist OWNER TO root;

--
-- TOC entry 2191 (class 2616 OID 16494)
-- Dependencies: 2350 3 1008
-- Name: gist_int8_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_int8_ops
    DEFAULT FOR TYPE bigint USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(bigint,bigint) ,
    OPERATOR 2 <=(bigint,bigint) ,
    OPERATOR 3 =(bigint,bigint) ,
    OPERATOR 4 >=(bigint,bigint) ,
    OPERATOR 5 >(bigint,bigint) ,
    FUNCTION 1 gbt_int8_consistent(internal,bigint,smallint) ,
    FUNCTION 2 gbt_int8_union(bytea,internal) ,
    FUNCTION 3 gbt_int8_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int8_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int8_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int8_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int8_ops USING gist OWNER TO root;

--
-- TOC entry 2199 (class 2616 OID 16647)
-- Dependencies: 2358 1011 3
-- Name: gist_interval_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_interval_ops
    DEFAULT FOR TYPE interval USING gist AS
    STORAGE gbtreekey32 ,
    OPERATOR 1 <(interval,interval) ,
    OPERATOR 2 <=(interval,interval) ,
    OPERATOR 3 =(interval,interval) ,
    OPERATOR 4 >=(interval,interval) ,
    OPERATOR 5 >(interval,interval) ,
    FUNCTION 1 gbt_intv_consistent(internal,interval,smallint) ,
    FUNCTION 2 gbt_intv_union(bytea,internal) ,
    FUNCTION 3 gbt_intv_compress(internal) ,
    FUNCTION 4 gbt_intv_decompress(internal) ,
    FUNCTION 5 gbt_intv_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_intv_picksplit(internal,internal) ,
    FUNCTION 7 gbt_intv_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_interval_ops USING gist OWNER TO root;

--
-- TOC entry 2234 (class 2616 OID 17927)
-- Dependencies: 1075 3 1066 2379
-- Name: gist_ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_ltree_ops
    DEFAULT FOR TYPE ltree USING gist AS
    STORAGE ltree_gist ,
    OPERATOR 1 <(ltree,ltree) ,
    OPERATOR 2 <=(ltree,ltree) ,
    OPERATOR 3 =(ltree,ltree) ,
    OPERATOR 4 >=(ltree,ltree) ,
    OPERATOR 5 >(ltree,ltree) ,
    OPERATOR 10 @>(ltree,ltree) ,
    OPERATOR 11 <@(ltree,ltree) ,
    OPERATOR 12 ~(ltree,lquery) ,
    OPERATOR 13 ~(lquery,ltree) ,
    OPERATOR 14 @(ltree,ltxtquery) ,
    OPERATOR 15 @(ltxtquery,ltree) ,
    OPERATOR 16 ?(ltree,lquery[]) ,
    OPERATOR 17 ?(lquery[],ltree) ,
    FUNCTION 1 ltree_consistent(internal,internal,smallint) ,
    FUNCTION 2 ltree_union(internal,internal) ,
    FUNCTION 3 ltree_compress(internal) ,
    FUNCTION 4 ltree_decompress(internal) ,
    FUNCTION 5 ltree_penalty(internal,internal,internal) ,
    FUNCTION 6 ltree_picksplit(internal,internal) ,
    FUNCTION 7 ltree_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_ltree_ops USING gist OWNER TO root;

--
-- TOC entry 2201 (class 2616 OID 16687)
-- Dependencies: 3 1008 2360
-- Name: gist_macaddr_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_macaddr_ops
    DEFAULT FOR TYPE macaddr USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(macaddr,macaddr) ,
    OPERATOR 2 <=(macaddr,macaddr) ,
    OPERATOR 3 =(macaddr,macaddr) ,
    OPERATOR 4 >=(macaddr,macaddr) ,
    OPERATOR 5 >(macaddr,macaddr) ,
    FUNCTION 1 gbt_macad_consistent(internal,macaddr,smallint) ,
    FUNCTION 2 gbt_macad_union(bytea,internal) ,
    FUNCTION 3 gbt_macad_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_macad_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_macad_picksplit(internal,internal) ,
    FUNCTION 7 gbt_macad_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_macaddr_ops USING gist OWNER TO root;

--
-- TOC entry 2205 (class 2616 OID 16763)
-- Dependencies: 3 2364 1014
-- Name: gist_numeric_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_numeric_ops
    DEFAULT FOR TYPE numeric USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(numeric,numeric) ,
    OPERATOR 2 <=(numeric,numeric) ,
    OPERATOR 3 =(numeric,numeric) ,
    OPERATOR 4 >=(numeric,numeric) ,
    OPERATOR 5 >(numeric,numeric) ,
    FUNCTION 1 gbt_numeric_consistent(internal,numeric,smallint) ,
    FUNCTION 2 gbt_numeric_union(bytea,internal) ,
    FUNCTION 3 gbt_numeric_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_numeric_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_numeric_picksplit(internal,internal) ,
    FUNCTION 7 gbt_numeric_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_numeric_ops USING gist OWNER TO root;

--
-- TOC entry 2188 (class 2616 OID 16434)
-- Dependencies: 2347 1005 3
-- Name: gist_oid_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_oid_ops
    DEFAULT FOR TYPE oid USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(oid,oid) ,
    OPERATOR 2 <=(oid,oid) ,
    OPERATOR 3 =(oid,oid) ,
    OPERATOR 4 >=(oid,oid) ,
    OPERATOR 5 >(oid,oid) ,
    FUNCTION 1 gbt_oid_consistent(internal,oid,smallint) ,
    FUNCTION 2 gbt_oid_union(bytea,internal) ,
    FUNCTION 3 gbt_oid_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_oid_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_oid_picksplit(internal,internal) ,
    FUNCTION 7 gbt_oid_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_oid_ops USING gist OWNER TO root;

--
-- TOC entry 2239 (class 2616 OID 18154)
-- Dependencies: 1087 3 2384
-- Name: gist_seg_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_seg_ops
    DEFAULT FOR TYPE seg USING gist AS
    OPERATOR 1 <<(seg,seg) ,
    OPERATOR 2 &<(seg,seg) ,
    OPERATOR 3 &&(seg,seg) ,
    OPERATOR 4 &>(seg,seg) ,
    OPERATOR 5 >>(seg,seg) ,
    OPERATOR 6 =(seg,seg) ,
    OPERATOR 7 @>(seg,seg) ,
    OPERATOR 8 <@(seg,seg) ,
    OPERATOR 13 @(seg,seg) ,
    OPERATOR 14 ~(seg,seg) ,
    FUNCTION 1 gseg_consistent(internal,seg,integer) ,
    FUNCTION 2 gseg_union(internal,internal) ,
    FUNCTION 3 gseg_compress(internal) ,
    FUNCTION 4 gseg_decompress(internal) ,
    FUNCTION 5 gseg_penalty(internal,internal,internal) ,
    FUNCTION 6 gseg_picksplit(internal,internal) ,
    FUNCTION 7 gseg_same(seg,seg,internal);


ALTER OPERATOR CLASS public.gist_seg_ops USING gist OWNER TO root;

--
-- TOC entry 2202 (class 2616 OID 16709)
-- Dependencies: 1014 2361 3
-- Name: gist_text_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_text_ops
    DEFAULT FOR TYPE text USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(text,text) ,
    OPERATOR 2 <=(text,text) ,
    OPERATOR 3 =(text,text) ,
    OPERATOR 4 >=(text,text) ,
    OPERATOR 5 >(text,text) ,
    FUNCTION 1 gbt_text_consistent(internal,text,smallint) ,
    FUNCTION 2 gbt_text_union(bytea,internal) ,
    FUNCTION 3 gbt_text_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_text_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_text_picksplit(internal,internal) ,
    FUNCTION 7 gbt_text_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_text_ops USING gist OWNER TO root;

--
-- TOC entry 2196 (class 2616 OID 16592)
-- Dependencies: 3 2355 1008
-- Name: gist_time_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_time_ops
    DEFAULT FOR TYPE time without time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(time without time zone,time without time zone) ,
    OPERATOR 2 <=(time without time zone,time without time zone) ,
    OPERATOR 3 =(time without time zone,time without time zone) ,
    OPERATOR 4 >=(time without time zone,time without time zone) ,
    OPERATOR 5 >(time without time zone,time without time zone) ,
    FUNCTION 1 gbt_time_consistent(internal,time without time zone,smallint) ,
    FUNCTION 2 gbt_time_union(bytea,internal) ,
    FUNCTION 3 gbt_time_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_time_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_time_picksplit(internal,internal) ,
    FUNCTION 7 gbt_time_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_time_ops USING gist OWNER TO root;

--
-- TOC entry 2194 (class 2616 OID 16556)
-- Dependencies: 2353 3 1008
-- Name: gist_timestamp_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_timestamp_ops
    DEFAULT FOR TYPE timestamp without time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 2 <=(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 3 =(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 4 >=(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 5 >(timestamp without time zone,timestamp without time zone) ,
    FUNCTION 1 gbt_ts_consistent(internal,timestamp without time zone,smallint) ,
    FUNCTION 2 gbt_ts_union(bytea,internal) ,
    FUNCTION 3 gbt_ts_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_ts_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_ts_picksplit(internal,internal) ,
    FUNCTION 7 gbt_ts_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timestamp_ops USING gist OWNER TO root;

--
-- TOC entry 2195 (class 2616 OID 16570)
-- Dependencies: 1008 2354 3
-- Name: gist_timestamptz_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_timestamptz_ops
    DEFAULT FOR TYPE timestamp with time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 2 <=(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 3 =(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 4 >=(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 5 >(timestamp with time zone,timestamp with time zone) ,
    FUNCTION 1 gbt_tstz_consistent(internal,timestamp with time zone,smallint) ,
    FUNCTION 2 gbt_ts_union(bytea,internal) ,
    FUNCTION 3 gbt_tstz_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_ts_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_ts_picksplit(internal,internal) ,
    FUNCTION 7 gbt_ts_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timestamptz_ops USING gist OWNER TO root;

--
-- TOC entry 2197 (class 2616 OID 16606)
-- Dependencies: 3 2356 1008
-- Name: gist_timetz_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_timetz_ops
    DEFAULT FOR TYPE time with time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(time with time zone,time with time zone) RECHECK ,
    OPERATOR 2 <=(time with time zone,time with time zone) RECHECK ,
    OPERATOR 3 =(time with time zone,time with time zone) RECHECK ,
    OPERATOR 4 >=(time with time zone,time with time zone) RECHECK ,
    OPERATOR 5 >(time with time zone,time with time zone) RECHECK ,
    FUNCTION 1 gbt_timetz_consistent(internal,time with time zone,smallint) ,
    FUNCTION 2 gbt_time_union(bytea,internal) ,
    FUNCTION 3 gbt_timetz_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_time_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_time_picksplit(internal,internal) ,
    FUNCTION 7 gbt_time_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timetz_ops USING gist OWNER TO root;

--
-- TOC entry 2236 (class 2616 OID 18048)
-- Dependencies: 3 2381 1084
-- Name: gist_trgm_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_trgm_ops
    FOR TYPE text USING gist AS
    STORAGE gtrgm ,
    OPERATOR 1 %(text,text) ,
    FUNCTION 1 gtrgm_consistent(gtrgm,internal,integer) ,
    FUNCTION 2 gtrgm_union(bytea,internal) ,
    FUNCTION 3 gtrgm_compress(internal) ,
    FUNCTION 4 gtrgm_decompress(internal) ,
    FUNCTION 5 gtrgm_penalty(internal,internal,internal) ,
    FUNCTION 6 gtrgm_picksplit(internal,internal) ,
    FUNCTION 7 gtrgm_same(gtrgm,gtrgm,internal);


ALTER OPERATOR CLASS public.gist_trgm_ops USING gist OWNER TO root;

--
-- TOC entry 2207 (class 2616 OID 16797)
-- Dependencies: 3 1014 2366
-- Name: gist_vbit_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS gist_vbit_ops
    DEFAULT FOR TYPE bit varying USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bit varying,bit varying) ,
    OPERATOR 2 <=(bit varying,bit varying) ,
    OPERATOR 3 =(bit varying,bit varying) ,
    OPERATOR 4 >=(bit varying,bit varying) ,
    OPERATOR 5 >(bit varying,bit varying) ,
    FUNCTION 1 gbt_bit_consistent(internal,bit,smallint) ,
    FUNCTION 2 gbt_bit_union(bytea,internal) ,
    FUNCTION 3 gbt_bit_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bit_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bit_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bit_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_vbit_ops USING gist OWNER TO root;

--
-- TOC entry 2219 (class 2616 OID 17600)
-- Dependencies: 2376 3 1044
-- Name: isbn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS isbn13_ops
    DEFAULT FOR TYPE isbn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(isbn13,isbn13) ,
    OPERATOR 2 <=(isbn13,isbn13) ,
    OPERATOR 3 =(isbn13,isbn13) ,
    OPERATOR 4 >=(isbn13,isbn13) ,
    OPERATOR 5 >(isbn13,isbn13) ,
    FUNCTION 1 btisbn13cmp(isbn13,isbn13);


ALTER OPERATOR CLASS public.isbn13_ops USING btree OWNER TO root;

--
-- TOC entry 2220 (class 2616 OID 17608)
-- Dependencies: 3 2377 1044
-- Name: isbn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS isbn13_ops
    DEFAULT FOR TYPE isbn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(isbn13,isbn13) ,
    FUNCTION 1 hashisbn13(isbn13);


ALTER OPERATOR CLASS public.isbn13_ops USING hash OWNER TO root;

--
-- TOC entry 2221 (class 2616 OID 17628)
-- Dependencies: 3 2376 1053
-- Name: isbn_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS isbn_ops
    DEFAULT FOR TYPE isbn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(isbn,isbn) ,
    OPERATOR 2 <=(isbn,isbn) ,
    OPERATOR 3 =(isbn,isbn) ,
    OPERATOR 4 >=(isbn,isbn) ,
    OPERATOR 5 >(isbn,isbn) ,
    FUNCTION 1 btisbncmp(isbn,isbn);


ALTER OPERATOR CLASS public.isbn_ops USING btree OWNER TO root;

--
-- TOC entry 2222 (class 2616 OID 17636)
-- Dependencies: 1053 3 2377
-- Name: isbn_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS isbn_ops
    DEFAULT FOR TYPE isbn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(isbn,isbn) ,
    FUNCTION 1 hashisbn(isbn);


ALTER OPERATOR CLASS public.isbn_ops USING hash OWNER TO root;

--
-- TOC entry 2223 (class 2616 OID 17656)
-- Dependencies: 2376 1047 3
-- Name: ismn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ismn13_ops
    DEFAULT FOR TYPE ismn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ismn13,ismn13) ,
    OPERATOR 2 <=(ismn13,ismn13) ,
    OPERATOR 3 =(ismn13,ismn13) ,
    OPERATOR 4 >=(ismn13,ismn13) ,
    OPERATOR 5 >(ismn13,ismn13) ,
    FUNCTION 1 btismn13cmp(ismn13,ismn13);


ALTER OPERATOR CLASS public.ismn13_ops USING btree OWNER TO root;

--
-- TOC entry 2224 (class 2616 OID 17664)
-- Dependencies: 3 2377 1047
-- Name: ismn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ismn13_ops
    DEFAULT FOR TYPE ismn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ismn13,ismn13) ,
    FUNCTION 1 hashismn13(ismn13);


ALTER OPERATOR CLASS public.ismn13_ops USING hash OWNER TO root;

--
-- TOC entry 2225 (class 2616 OID 17684)
-- Dependencies: 1056 3 2376
-- Name: ismn_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ismn_ops
    DEFAULT FOR TYPE ismn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ismn,ismn) ,
    OPERATOR 2 <=(ismn,ismn) ,
    OPERATOR 3 =(ismn,ismn) ,
    OPERATOR 4 >=(ismn,ismn) ,
    OPERATOR 5 >(ismn,ismn) ,
    FUNCTION 1 btismncmp(ismn,ismn);


ALTER OPERATOR CLASS public.ismn_ops USING btree OWNER TO root;

--
-- TOC entry 2226 (class 2616 OID 17692)
-- Dependencies: 1056 2377 3
-- Name: ismn_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ismn_ops
    DEFAULT FOR TYPE ismn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ismn,ismn) ,
    FUNCTION 1 hashismn(ismn);


ALTER OPERATOR CLASS public.ismn_ops USING hash OWNER TO root;

--
-- TOC entry 2227 (class 2616 OID 17712)
-- Dependencies: 1050 3 2376
-- Name: issn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS issn13_ops
    DEFAULT FOR TYPE issn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(issn13,issn13) ,
    OPERATOR 2 <=(issn13,issn13) ,
    OPERATOR 3 =(issn13,issn13) ,
    OPERATOR 4 >=(issn13,issn13) ,
    OPERATOR 5 >(issn13,issn13) ,
    FUNCTION 1 btissn13cmp(issn13,issn13);


ALTER OPERATOR CLASS public.issn13_ops USING btree OWNER TO root;

--
-- TOC entry 2228 (class 2616 OID 17720)
-- Dependencies: 1050 3 2377
-- Name: issn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS issn13_ops
    DEFAULT FOR TYPE issn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(issn13,issn13) ,
    FUNCTION 1 hashissn13(issn13);


ALTER OPERATOR CLASS public.issn13_ops USING hash OWNER TO root;

--
-- TOC entry 2229 (class 2616 OID 17740)
-- Dependencies: 3 2376 1059
-- Name: issn_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS issn_ops
    DEFAULT FOR TYPE issn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(issn,issn) ,
    OPERATOR 2 <=(issn,issn) ,
    OPERATOR 3 =(issn,issn) ,
    OPERATOR 4 >=(issn,issn) ,
    OPERATOR 5 >(issn,issn) ,
    FUNCTION 1 btissncmp(issn,issn);


ALTER OPERATOR CLASS public.issn_ops USING btree OWNER TO root;

--
-- TOC entry 2230 (class 2616 OID 17748)
-- Dependencies: 3 1059 2377
-- Name: issn_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS issn_ops
    DEFAULT FOR TYPE issn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(issn,issn) ,
    FUNCTION 1 hashissn(issn);


ALTER OPERATOR CLASS public.issn_ops USING hash OWNER TO root;

--
-- TOC entry 2233 (class 2616 OID 17882)
-- Dependencies: 2378 3 1066
-- Name: ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS ltree_ops
    DEFAULT FOR TYPE ltree USING btree AS
    OPERATOR 1 <(ltree,ltree) ,
    OPERATOR 2 <=(ltree,ltree) ,
    OPERATOR 3 =(ltree,ltree) ,
    OPERATOR 4 >=(ltree,ltree) ,
    OPERATOR 5 >(ltree,ltree) ,
    FUNCTION 1 ltree_cmp(ltree,ltree);


ALTER OPERATOR CLASS public.ltree_ops USING btree OWNER TO root;

--
-- TOC entry 2238 (class 2616 OID 18146)
-- Dependencies: 3 2383 1087
-- Name: seg_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS seg_ops
    DEFAULT FOR TYPE seg USING btree AS
    OPERATOR 1 <(seg,seg) ,
    OPERATOR 2 <=(seg,seg) ,
    OPERATOR 3 =(seg,seg) ,
    OPERATOR 4 >=(seg,seg) ,
    OPERATOR 5 >(seg,seg) ,
    FUNCTION 1 seg_cmp(seg,seg);


ALTER OPERATOR CLASS public.seg_ops USING btree OWNER TO root;

--
-- TOC entry 2231 (class 2616 OID 17768)
-- Dependencies: 1062 3 2376
-- Name: upc_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS upc_ops
    DEFAULT FOR TYPE upc USING btree FAMILY isn_ops AS
    OPERATOR 1 <(upc,upc) ,
    OPERATOR 2 <=(upc,upc) ,
    OPERATOR 3 =(upc,upc) ,
    OPERATOR 4 >=(upc,upc) ,
    OPERATOR 5 >(upc,upc) ,
    FUNCTION 1 btupccmp(upc,upc);


ALTER OPERATOR CLASS public.upc_ops USING btree OWNER TO root;

--
-- TOC entry 2232 (class 2616 OID 17776)
-- Dependencies: 2377 1062 3
-- Name: upc_ops; Type: OPERATOR CLASS; Schema: public; Owner: root
--

CREATE OPERATOR CLASS upc_ops
    DEFAULT FOR TYPE upc USING hash FAMILY isn_ops AS
    OPERATOR 1 =(upc,upc) ,
    FUNCTION 1 hashupc(upc);


ALTER OPERATOR CLASS public.upc_ops USING hash OWNER TO root;

SET search_path = pg_catalog;

--
-- TOC entry 2917 (class 2605 OID 17795)
-- Dependencies: 537 1053 537 1041
-- Name: CAST (public.ean13 AS public.isbn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.isbn) WITH FUNCTION public.isbn(public.ean13);


--
-- TOC entry 2914 (class 2605 OID 17794)
-- Dependencies: 534 534 1044 1041
-- Name: CAST (public.ean13 AS public.isbn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.isbn13) WITH FUNCTION public.isbn13(public.ean13);


--
-- TOC entry 2918 (class 2605 OID 17797)
-- Dependencies: 538 1056 1041 538
-- Name: CAST (public.ean13 AS public.ismn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.ismn) WITH FUNCTION public.ismn(public.ean13);


--
-- TOC entry 2915 (class 2605 OID 17796)
-- Dependencies: 535 1041 1047 535
-- Name: CAST (public.ean13 AS public.ismn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.ismn13) WITH FUNCTION public.ismn13(public.ean13);


--
-- TOC entry 2919 (class 2605 OID 17799)
-- Dependencies: 539 1041 539 1059
-- Name: CAST (public.ean13 AS public.issn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.issn) WITH FUNCTION public.issn(public.ean13);


--
-- TOC entry 2916 (class 2605 OID 17798)
-- Dependencies: 536 1050 536 1041
-- Name: CAST (public.ean13 AS public.issn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.issn13) WITH FUNCTION public.issn13(public.ean13);


--
-- TOC entry 2920 (class 2605 OID 17800)
-- Dependencies: 540 540 1041 1062
-- Name: CAST (public.ean13 AS public.upc); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.upc) WITH FUNCTION public.upc(public.ean13);


--
-- TOC entry 2927 (class 2605 OID 17802)
-- Dependencies: 1041 1053
-- Name: CAST (public.isbn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2928 (class 2605 OID 17808)
-- Dependencies: 1053 1044
-- Name: CAST (public.isbn AS public.isbn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn AS public.isbn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2921 (class 2605 OID 17801)
-- Dependencies: 1044 1041
-- Name: CAST (public.isbn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2922 (class 2605 OID 17809)
-- Dependencies: 1053 1044
-- Name: CAST (public.isbn13 AS public.isbn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn13 AS public.isbn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2929 (class 2605 OID 17804)
-- Dependencies: 1041 1056
-- Name: CAST (public.ismn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2930 (class 2605 OID 17810)
-- Dependencies: 1047 1056
-- Name: CAST (public.ismn AS public.ismn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn AS public.ismn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2923 (class 2605 OID 17803)
-- Dependencies: 1041 1047
-- Name: CAST (public.ismn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2924 (class 2605 OID 17811)
-- Dependencies: 1056 1047
-- Name: CAST (public.ismn13 AS public.ismn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn13 AS public.ismn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2931 (class 2605 OID 17806)
-- Dependencies: 1059 1041
-- Name: CAST (public.issn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2932 (class 2605 OID 17812)
-- Dependencies: 1050 1059
-- Name: CAST (public.issn AS public.issn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn AS public.issn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2925 (class 2605 OID 17805)
-- Dependencies: 1041 1050
-- Name: CAST (public.issn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2926 (class 2605 OID 17813)
-- Dependencies: 1050 1059
-- Name: CAST (public.issn13 AS public.issn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn13 AS public.issn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 2933 (class 2605 OID 17807)
-- Dependencies: 1062 1041
-- Name: CAST (public.upc AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.upc AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


SET search_path = public, pg_catalog;

--
-- TOC entry 2950 (class 2606 OID 136211)
-- Dependencies: 2641 2641 2641
-- Name: articles_feed_key; Type: CONSTRAINT; Schema: public; Owner: mizhal; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_feed_key UNIQUE (feed, link);


--
-- TOC entry 2952 (class 2606 OID 134855)
-- Dependencies: 2641 2641
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: mizhal; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- TOC entry 2944 (class 2606 OID 134823)
-- Dependencies: 2639 2639
-- Name: feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: mizhal; Tablespace: 
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (id);


--
-- TOC entry 2946 (class 2606 OID 134825)
-- Dependencies: 2639 2639
-- Name: feeds_rss_key; Type: CONSTRAINT; Schema: public; Owner: mizhal; Tablespace: 
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_rss_key UNIQUE (rss);


--
-- TOC entry 2948 (class 2606 OID 136267)
-- Dependencies: 2639 2639
-- Name: feeds_rss_key1; Type: CONSTRAINT; Schema: public; Owner: mizhal; Tablespace: 
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_rss_key1 UNIQUE (rss);


--
-- TOC entry 2954 (class 2606 OID 135074)
-- Dependencies: 2643 2643
-- Name: session_pkey; Type: CONSTRAINT; Schema: public; Owner: mizhal; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- TOC entry 2955 (class 2606 OID 134846)
-- Dependencies: 2943 2641 2639
-- Name: articles_feed_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mizhal
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_feed_fkey FOREIGN KEY (feed) REFERENCES feeds(id);


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: root
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM root;
GRANT ALL ON SCHEMA public TO root;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 2642
-- Name: art_seq; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON SEQUENCE art_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE art_seq FROM root;
GRANT ALL ON SEQUENCE art_seq TO root;
GRANT SELECT,USAGE ON SEQUENCE art_seq TO vigilante;


--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 2641
-- Name: articles; Type: ACL; Schema: public; Owner: mizhal
--

REVOKE ALL ON TABLE articles FROM PUBLIC;
REVOKE ALL ON TABLE articles FROM mizhal;
GRANT ALL ON TABLE articles TO mizhal;
GRANT SELECT,INSERT,UPDATE ON TABLE articles TO vigilante;


--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 2639
-- Name: feeds; Type: ACL; Schema: public; Owner: mizhal
--

REVOKE ALL ON TABLE feeds FROM PUBLIC;
REVOKE ALL ON TABLE feeds FROM mizhal;
GRANT ALL ON TABLE feeds TO mizhal;
GRANT ALL ON TABLE feeds TO vigilante;


--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 637
-- Name: pg_buffercache_pages(); Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON FUNCTION pg_buffercache_pages() FROM PUBLIC;
REVOKE ALL ON FUNCTION pg_buffercache_pages() FROM root;
GRANT ALL ON FUNCTION pg_buffercache_pages() TO root;


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 2636
-- Name: pg_buffercache; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE pg_buffercache FROM PUBLIC;
REVOKE ALL ON TABLE pg_buffercache FROM root;
GRANT ALL ON TABLE pg_buffercache TO root;


--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 638
-- Name: pg_freespacemap_pages(); Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON FUNCTION pg_freespacemap_pages() FROM PUBLIC;
REVOKE ALL ON FUNCTION pg_freespacemap_pages() FROM root;
GRANT ALL ON FUNCTION pg_freespacemap_pages() TO root;


--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 2637
-- Name: pg_freespacemap_pages; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE pg_freespacemap_pages FROM PUBLIC;
REVOKE ALL ON TABLE pg_freespacemap_pages FROM root;
GRANT ALL ON TABLE pg_freespacemap_pages TO root;


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 639
-- Name: pg_freespacemap_relations(); Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON FUNCTION pg_freespacemap_relations() FROM PUBLIC;
REVOKE ALL ON FUNCTION pg_freespacemap_relations() FROM root;
GRANT ALL ON FUNCTION pg_freespacemap_relations() TO root;


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 2638
-- Name: pg_freespacemap_relations; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE pg_freespacemap_relations FROM PUBLIC;
REVOKE ALL ON TABLE pg_freespacemap_relations FROM root;
GRANT ALL ON TABLE pg_freespacemap_relations TO root;


--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 2643
-- Name: sessions; Type: ACL; Schema: public; Owner: mizhal
--

REVOKE ALL ON TABLE sessions FROM PUBLIC;
REVOKE ALL ON TABLE sessions FROM mizhal;
GRANT ALL ON TABLE sessions TO mizhal;
GRANT INSERT ON TABLE sessions TO vigilante;


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 185
-- Name: dblink_connect_u(text); Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM root;
GRANT ALL ON FUNCTION dblink_connect_u(text) TO root;


--
-- TOC entry 3003 (class 0 OID 0)
-- Dependencies: 186
-- Name: dblink_connect_u(text, text); Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM root;
GRANT ALL ON FUNCTION dblink_connect_u(text, text) TO root;


-- Completed on 2009-06-22 13:11:11

--
-- PostgreSQL database dump complete
--

