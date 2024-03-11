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
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$720000$bcheptMtbR7RCuTmqzwRHh$SBjvY6bNi6Yxq7szqouFLsjtN2Ws13aq7fmYmauV7YE=	2024-03-05 13:28:45.722487+00	t	superuser				t	t	2024-03-05 13:28:36.018775+00
\.


--
-- Data for Name: parser_hub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parser_hub (id, name, url) FROM stdin;
1	Информационная безопасность	https://habr.com/ru/hubs/infosecurity/articles/
2	Карьера в IT-индустрии	https://habr.com/ru/hubs/career/articles/
3	Программирование	https://habr.com/ru/hubs/programming/articles/
\.


--
-- PostgreSQL database dump complete
--

