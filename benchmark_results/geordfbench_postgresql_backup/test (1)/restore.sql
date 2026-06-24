--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE geordfbench;
--
-- Name: geordfbench; Type: DATABASE; Schema: -; Owner: geordfbench
--

CREATE DATABASE geordfbench WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE geordfbench OWNER TO geordfbench;

\unrestrict (null)
\connect geordfbench
\restrict (null)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: EXPERIMENT; Type: TABLE; Schema: public; Owner: geordfbench
--

CREATE TABLE public."EXPERIMENT" (
    id integer NOT NULL,
    instime timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone,
    exectime timestamp(3) with time zone,
    description character varying(100),
    host character varying(200),
    os character varying(100),
    sut character varying(200),
    queryset character varying(200),
    dataset character varying(150),
    executionspec character varying(200),
    reportspec character varying(150),
    type character varying(50)
);


ALTER TABLE public."EXPERIMENT" OWNER TO geordfbench;

--
-- Name: EXPERIMENT_id_seq; Type: SEQUENCE; Schema: public; Owner: geordfbench
--

CREATE SEQUENCE public."EXPERIMENT_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."EXPERIMENT_id_seq" OWNER TO geordfbench;

--
-- Name: EXPERIMENT_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geordfbench
--

ALTER SEQUENCE public."EXPERIMENT_id_seq" OWNED BY public."EXPERIMENT".id;


--
-- Name: QUERYEXECUTION; Type: TABLE; Schema: public; Owner: geordfbench
--

CREATE TABLE public."QUERYEXECUTION" (
    id integer NOT NULL,
    experiment_id integer NOT NULL,
    query_no integer NOT NULL,
    query_label character varying(100),
    cache_type character varying(15),
    iteration smallint,
    eval_time bigint,
    scan_time bigint,
    no_results bigint,
    no_scan_errors bigint,
    eval_flag character varying(35),
    res_exception character varying(35)
);


ALTER TABLE public."QUERYEXECUTION" OWNER TO geordfbench;

--
-- Name: QUERYEXECUTION_experiment_id_seq; Type: SEQUENCE; Schema: public; Owner: geordfbench
--

CREATE SEQUENCE public."QUERYEXECUTION_experiment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."QUERYEXECUTION_experiment_id_seq" OWNER TO geordfbench;

--
-- Name: QUERYEXECUTION_experiment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geordfbench
--

ALTER SEQUENCE public."QUERYEXECUTION_experiment_id_seq" OWNED BY public."QUERYEXECUTION".experiment_id;


--
-- Name: QUERYEXECUTION_id_seq; Type: SEQUENCE; Schema: public; Owner: geordfbench
--

CREATE SEQUENCE public."QUERYEXECUTION_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."QUERYEXECUTION_id_seq" OWNER TO geordfbench;

--
-- Name: QUERYEXECUTION_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geordfbench
--

ALTER SEQUENCE public."QUERYEXECUTION_id_seq" OWNED BY public."QUERYEXECUTION".id;


--
-- Name: vqueryexecution; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vqueryexecution AS
 SELECT "QUERYEXECUTION".id,
    "QUERYEXECUTION".experiment_id,
    "EXPERIMENT".type,
    "QUERYEXECUTION".query_label,
    "QUERYEXECUTION".query_no,
    "QUERYEXECUTION".cache_type,
    "QUERYEXECUTION".iteration,
    "QUERYEXECUTION".eval_time,
    "QUERYEXECUTION".scan_time,
    "QUERYEXECUTION".no_results,
    "QUERYEXECUTION".no_scan_errors,
    "QUERYEXECUTION".eval_flag,
    "QUERYEXECUTION".res_exception,
    ("QUERYEXECUTION".eval_time + "QUERYEXECUTION".scan_time) AS total_time,
    round(((("QUERYEXECUTION".eval_time + "QUERYEXECUTION".scan_time))::numeric / 1000000000.0), 3) AS total_time_s
   FROM public."QUERYEXECUTION",
    public."EXPERIMENT"
  WHERE ("QUERYEXECUTION".experiment_id = "EXPERIMENT".id);


ALTER TABLE public.vqueryexecution OWNER TO geordfbench;

--
-- Name: vquery_ordered_aggrs; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vquery_ordered_aggrs AS
 SELECT vqueryexecution.experiment_id,
    vqueryexecution.query_no,
    vqueryexecution.cache_type,
    count(vqueryexecution.iteration) AS no_iterations,
    round(avg(vqueryexecution.total_time_s), 3) AS mean,
    percentile_disc((0.5)::double precision) WITHIN GROUP (ORDER BY vqueryexecution.total_time_s) AS median
   FROM public.vqueryexecution
  GROUP BY vqueryexecution.experiment_id, vqueryexecution.query_no, vqueryexecution.cache_type;


ALTER TABLE public.vquery_ordered_aggrs OWNER TO geordfbench;

--
-- Name: vqueryexecution2; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vqueryexecution2 AS
 SELECT "QUERYEXECUTION".id,
    "QUERYEXECUTION".experiment_id,
    "EXPERIMENT".type,
    "QUERYEXECUTION".query_label,
    "QUERYEXECUTION".query_no,
    "QUERYEXECUTION".cache_type,
    "QUERYEXECUTION".iteration,
    "QUERYEXECUTION".eval_time,
    "QUERYEXECUTION".scan_time,
    "QUERYEXECUTION".no_results,
    "QUERYEXECUTION".no_scan_errors,
    "QUERYEXECUTION".eval_flag,
    "QUERYEXECUTION".res_exception,
    ("QUERYEXECUTION".eval_time + "QUERYEXECUTION".scan_time) AS total_time,
    round(((("QUERYEXECUTION".eval_time + "QUERYEXECUTION".scan_time))::numeric / 1000000000.0), 3) AS total_time_s,
        CASE
            WHEN (("QUERYEXECUTION".res_exception)::text <> 'NONE'::text) THEN 'Failed'::text
            ELSE 'Success'::text
        END AS validflag
   FROM public."QUERYEXECUTION",
    public."EXPERIMENT"
  WHERE ("QUERYEXECUTION".experiment_id = "EXPERIMENT".id);


ALTER TABLE public.vqueryexecution2 OWNER TO geordfbench;

--
-- Name: vquery_ordered_aggrs2; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vquery_ordered_aggrs2 AS
 SELECT vqueryexecution2.experiment_id,
    vqueryexecution2.query_no,
    vqueryexecution2.cache_type,
    count(vqueryexecution2.iteration) AS no_iterations,
    round(avg(vqueryexecution2.total_time_s), 3) AS mean,
    percentile_disc((0.5)::double precision) WITHIN GROUP (ORDER BY vqueryexecution2.total_time_s) AS median
   FROM public.vqueryexecution2
  GROUP BY vqueryexecution2.validflag, vqueryexecution2.experiment_id, vqueryexecution2.query_no, vqueryexecution2.cache_type
 HAVING (vqueryexecution2.validflag = 'Success'::text);


ALTER TABLE public.vquery_ordered_aggrs2 OWNER TO geordfbench;

--
-- Name: vqueryexecution3; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vqueryexecution3 AS
 SELECT q.id,
    q.experiment_id,
    e.description,
    e.host,
    e.sut,
    e.queryset,
    e.dataset,
    e.type,
    q.query_label,
    q.query_no,
    q.cache_type,
    q.iteration,
    q.eval_time,
    q.scan_time,
    q.no_results,
    q.no_scan_errors,
    q.eval_flag,
    q.res_exception,
    (q.eval_time + q.scan_time) AS total_time,
    round((((q.eval_time + q.scan_time))::numeric / 1000000000.0), 3) AS total_time_s,
        CASE
            WHEN ((q.res_exception)::text <> 'NONE'::text) THEN 'Failed'::text
            ELSE 'Success'::text
        END AS validflag
   FROM public."QUERYEXECUTION" q,
    public."EXPERIMENT" e
  WHERE (q.experiment_id = e.id);


ALTER TABLE public.vqueryexecution3 OWNER TO geordfbench;

--
-- Name: vquery_ordered_aggrs_3; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vquery_ordered_aggrs_3 AS
 SELECT v.experiment_id,
    v.sut,
    v.queryset,
    v.dataset,
    v.query_label,
    v.query_no,
    v.validflag,
    v.cache_type,
    count(v.iteration) AS no_iterations,
    round(avg(v.total_time_s), 3) AS mean,
    percentile_disc((0.5)::double precision) WITHIN GROUP (ORDER BY v.total_time_s) AS median
   FROM public.vqueryexecution3 v
  GROUP BY v.experiment_id, v.sut, v.queryset, v.dataset, v.query_label, v.query_no, v.validflag, v.cache_type;


ALTER TABLE public.vquery_ordered_aggrs_3 OWNER TO geordfbench;

--
-- Name: vqueryexecution4; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vqueryexecution4 AS
 SELECT q.id,
    q.experiment_id,
    e.description,
    e.host,
    e.sut,
        CASE
            WHEN ((e.id >= 15) AND (e.id <= 17)) THEN ("substring"((e.sut)::text, 1, (length((e.sut)::text) - 3)) || '+'::text)
            WHEN ((e.id >= 18) AND (e.id <= 20)) THEN ("substring"((e.sut)::text, 1, (length((e.sut)::text) - 3)) || '+P'::text)
            WHEN ((e.id >= 21) AND (e.id <= 23)) THEN ("substring"((e.sut)::text, 1, (length((e.sut)::text) - 3)) || '+'::text)
            ELSE "substring"((e.sut)::text, 1, (length((e.sut)::text) - 3))
        END AS effectivesut,
    e.queryset,
    e.dataset,
    e.type,
    q.query_label,
    q.query_no,
    q.cache_type,
    q.iteration,
    q.eval_time,
    q.scan_time,
    q.no_results,
    q.no_scan_errors,
    q.eval_flag,
    q.res_exception,
    (q.eval_time + q.scan_time) AS total_time,
    round((((q.eval_time + q.scan_time))::numeric / 1000000000.0), 3) AS total_time_s,
        CASE
            WHEN ((q.res_exception)::text <> 'NONE'::text) THEN 'Failed'::text
            ELSE 'Success'::text
        END AS validflag
   FROM public."QUERYEXECUTION" q,
    public."EXPERIMENT" e
  WHERE (q.experiment_id = e.id);


ALTER TABLE public.vqueryexecution4 OWNER TO postgres;

--
-- Name: vquery_ordered_aggrs_4; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vquery_ordered_aggrs_4 AS
 SELECT v.experiment_id,
    v.sut,
    v.effectivesut,
    v.queryset,
    v.dataset,
    v.query_label,
    v.query_no,
    v.validflag,
    v.cache_type,
    count(v.iteration) AS no_iterations,
    round(avg(v.total_time_s), 3) AS mean,
    percentile_disc((0.5)::double precision) WITHIN GROUP (ORDER BY v.total_time_s) AS median
   FROM public.vqueryexecution4 v
  GROUP BY v.experiment_id, v.sut, v.effectivesut, v.queryset, v.dataset, v.query_label, v.query_no, v.validflag, v.cache_type;


ALTER TABLE public.vquery_ordered_aggrs_4 OWNER TO postgres;

--
-- Name: vreport; Type: VIEW; Schema: public; Owner: geordfbench
--

CREATE VIEW public.vreport AS
 SELECT v.cache_type,
    v.query_no,
    v.query_label,
    v.validflag,
    v.sut,
    v.mean,
    v.median
   FROM public.vquery_ordered_aggrs_3 v;


ALTER TABLE public.vreport OWNER TO geordfbench;

--
-- Name: EXPERIMENT id; Type: DEFAULT; Schema: public; Owner: geordfbench
--

ALTER TABLE ONLY public."EXPERIMENT" ALTER COLUMN id SET DEFAULT nextval('public."EXPERIMENT_id_seq"'::regclass);


--
-- Name: QUERYEXECUTION id; Type: DEFAULT; Schema: public; Owner: geordfbench
--

ALTER TABLE ONLY public."QUERYEXECUTION" ALTER COLUMN id SET DEFAULT nextval('public."QUERYEXECUTION_id_seq"'::regclass);


--
-- Data for Name: EXPERIMENT; Type: TABLE DATA; Schema: public; Owner: geordfbench
--

COPY public."EXPERIMENT" (id, instime, exectime, description, host, os, sut, queryset, dataset, executionspec, reportspec, type) FROM stdin;
\.
COPY public."EXPERIMENT" (id, instime, exectime, description, host, os, sut, queryset, dataset, executionspec, reportspec, type) FROM '$$PATH$$/3405.dat';

--
-- Data for Name: QUERYEXECUTION; Type: TABLE DATA; Schema: public; Owner: geordfbench
--

COPY public."QUERYEXECUTION" (id, experiment_id, query_no, query_label, cache_type, iteration, eval_time, scan_time, no_results, no_scan_errors, eval_flag, res_exception) FROM stdin;
\.
COPY public."QUERYEXECUTION" (id, experiment_id, query_no, query_label, cache_type, iteration, eval_time, scan_time, no_results, no_scan_errors, eval_flag, res_exception) FROM '$$PATH$$/3407.dat';

--
-- Name: EXPERIMENT_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geordfbench
--

SELECT pg_catalog.setval('public."EXPERIMENT_id_seq"', 124, true);


--
-- Name: QUERYEXECUTION_experiment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geordfbench
--

SELECT pg_catalog.setval('public."QUERYEXECUTION_experiment_id_seq"', 1, false);


--
-- Name: QUERYEXECUTION_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geordfbench
--

SELECT pg_catalog.setval('public."QUERYEXECUTION_id_seq"', 1638, true);


--
-- Name: EXPERIMENT EXPERIMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: geordfbench
--

ALTER TABLE ONLY public."EXPERIMENT"
    ADD CONSTRAINT "EXPERIMENT_pkey" PRIMARY KEY (id);


--
-- Name: QUERYEXECUTION FK_EXPERIMENT_ID; Type: FK CONSTRAINT; Schema: public; Owner: geordfbench
--

ALTER TABLE ONLY public."QUERYEXECUTION"
    ADD CONSTRAINT "FK_EXPERIMENT_ID" FOREIGN KEY (experiment_id) REFERENCES public."EXPERIMENT"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

