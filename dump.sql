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
-- Data for Name: django_celery_beat_crontabschedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_beat_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year, timezone) FROM stdin;
1	*/10	*	*	*	*	Asia/Yekaterinburg
2	0	4	*	*	*	Asia/Yekaterinburg
\.


--
-- Data for Name: django_celery_beat_periodictask; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_beat_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id, solar_id, one_off, start_time, priority, headers, clocked_id, expire_seconds) FROM stdin;
2	celery.backend_cleanup	celery.backend_cleanup	[]	{}	\N	\N	\N	\N	t	\N	0	2024-03-06 13:57:02.285903+00		2	\N	\N	f	\N	\N	{}	\N	43200
1	habr_parse	parser.tasks.parser	[]	{}	\N	\N	\N	\N	t	2024-03-06 15:00:00.00599+00	70	2024-03-06 15:00:35.074457+00		1	\N	\N	f	\N	\N	{}	\N	\N
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

