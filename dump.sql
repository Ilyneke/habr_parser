--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg110+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg110+2)

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
-- Name: parser_hub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parser_hub (
    id bigint NOT NULL,
    name character varying NOT NULL,
    url character varying(200) NOT NULL
);


ALTER TABLE public.parser_hub OWNER TO postgres;

--
-- Name: parser_hub_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.parser_hub ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.parser_hub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: parser_hub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parser_hub (id, name, url) FROM stdin;
1	Информационная безопасность	https://habr.com/ru/hubs/infosecurity/articles/
2	Карьера в IT-индустрии	https://habr.com/ru/hubs/career/articles/
3	Программирование	https://habr.com/ru/hubs/programming/articles/
\.


--
-- Name: parser_hub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parser_hub_id_seq', 3, true);


--
-- Name: parser_hub parser_hub_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parser_hub
    ADD CONSTRAINT parser_hub_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--
