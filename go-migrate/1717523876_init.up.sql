--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg120+1)

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

--
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: evaluation_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluation_statuses (
    id text NOT NULL,
    description_en text NOT NULL,
    description_lv text NOT NULL,
    dev_notes text
);


ALTER TABLE public.evaluation_statuses OWNER TO postgres;

--
-- Name: evaluation_test_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluation_test_results (
    id bigint NOT NULL,
    evaluation_id bigint NOT NULL,
    eval_status_id text NOT NULL,
    task_v_test_id bigint NOT NULL,
    exec_r_data_id bigint,
    checker_r_data_id bigint
);


ALTER TABLE public.evaluation_test_results OWNER TO postgres;

--
-- Name: evaluation_test_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluation_test_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluation_test_results_id_seq OWNER TO postgres;

--
-- Name: evaluation_test_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluation_test_results_id_seq OWNED BY public.evaluation_test_results.id;


--
-- Name: evaluations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluations (
    id bigint NOT NULL,
    eval_status_id text NOT NULL,
    eval_total_score bigint DEFAULT 0 NOT NULL,
    eval_possible_score bigint,
    test_runtime_statistics_id bigint,
    compilation_data_id bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    task_version_id bigint NOT NULL
);


ALTER TABLE public.evaluations OWNER TO postgres;

--
-- Name: evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.evaluations_id_seq OWNER TO postgres;

--
-- Name: evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluations_id_seq OWNED BY public.evaluations.id;


--
-- Name: example_sets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.example_sets (
    id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.example_sets OWNER TO postgres;

--
-- Name: example_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.example_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.example_sets_id_seq OWNER TO postgres;

--
-- Name: example_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.example_sets_id_seq OWNED BY public.example_sets.id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: markdown_statements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.markdown_statements (
    id bigint NOT NULL,
    story text NOT NULL,
    input text NOT NULL,
    output text NOT NULL,
    notes text,
    scoring text,
    lang_iso639_1 text NOT NULL
);


ALTER TABLE public.markdown_statements OWNER TO postgres;

--
-- Name: markdown_statements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.markdown_statements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.markdown_statements_id_seq OWNER TO postgres;

--
-- Name: markdown_statements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.markdown_statements_id_seq OWNED BY public.markdown_statements.id;


--
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.problem_tags (
    id text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    color_rgb_hex text,
    description_lv text,
    CONSTRAINT tags_color_rgb_hex_check CHECK ((color_rgb_hex ~* '^#[0-9a-f]{6}$'::text))
);


ALTER TABLE public.problem_tags OWNER TO postgres;

--
-- Name: programming_languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.programming_languages (
    id text NOT NULL,
    full_name text NOT NULL,
    code_filename text NOT NULL,
    compile_cmd text,
    execute_cmd text NOT NULL,
    env_version_cmd text,
    hello_world_code text,
    monaco_id text,
    compiled_filename text,
    enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.programming_languages OWNER TO postgres;

--
-- Name: published_task_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.published_task_codes (
    task_code character varying(255) NOT NULL,
    task_id bigint NOT NULL
);


ALTER TABLE public.published_task_codes OWNER TO postgres;

--
-- Name: runtime_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.runtime_data (
    id bigint NOT NULL,
    stdout text,
    stderr text,
    time_millis bigint,
    memory_kibibytes bigint,
    time_wall_millis bigint,
    exit_code bigint
);


ALTER TABLE public.runtime_data OWNER TO postgres;

--
-- Name: runtime_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.runtime_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.runtime_data_id_seq OWNER TO postgres;

--
-- Name: runtime_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.runtime_data_id_seq OWNED BY public.runtime_data.id;


--
-- Name: runtime_statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.runtime_statistics (
    id bigint NOT NULL,
    maximum_time_millis bigint DEFAULT 0 NOT NULL,
    maximum_memory_kibibytes bigint DEFAULT 0 NOT NULL,
    total_time_millis bigint DEFAULT 0 NOT NULL,
    total_memory_kibibytes bigint DEFAULT 0 NOT NULL,
    avg_time_millis double precision NOT NULL,
    avg_memory_kibibytes double precision NOT NULL
);


ALTER TABLE public.runtime_statistics OWNER TO postgres;

--
-- Name: runtime_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.runtime_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.runtime_statistics_id_seq OWNER TO postgres;

--
-- Name: runtime_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.runtime_statistics_id_seq OWNED BY public.runtime_statistics.id;


--
-- Name: statement_examples; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statement_examples (
    id bigint NOT NULL,
    input text NOT NULL,
    answer text NOT NULL,
    example_set_id bigint NOT NULL
);


ALTER TABLE public.statement_examples OWNER TO postgres;

--
-- Name: statement_examples_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statement_examples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statement_examples_id_seq OWNER TO postgres;

--
-- Name: statement_examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statement_examples_id_seq OWNED BY public.statement_examples.id;


--
-- Name: submission_evaluations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submission_evaluations (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    evaluation_id bigint NOT NULL
);


ALTER TABLE public.submission_evaluations OWNER TO postgres;

--
-- Name: submission_evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submission_evaluations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submission_evaluations_id_seq OWNER TO postgres;

--
-- Name: submission_evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submission_evaluations_id_seq OWNED BY public.submission_evaluations.id;


--
-- Name: task_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_origins (
    abbreviation text NOT NULL,
    full_name text NOT NULL,
    CONSTRAINT task_sources_full_name_not_empty CHECK ((full_name <> ''::text))
);


ALTER TABLE public.task_origins OWNER TO postgres;

--
-- Name: task_submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_submissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    task_id bigint NOT NULL,
    programming_lang_id text NOT NULL,
    submission text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    visible_eval_id bigint,
    CONSTRAINT submission CHECK ((submission <> ''::text))
);


ALTER TABLE public.task_submissions OWNER TO postgres;

--
-- Name: task_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_submissions_id_seq OWNER TO postgres;

--
-- Name: task_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_submissions_id_seq OWNED BY public.task_submissions.id;


--
-- Name: test_set_tests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_set_tests (
    id bigint NOT NULL,
    test_filename text NOT NULL,
    test_set_id bigint NOT NULL,
    input_text_file_id bigint NOT NULL,
    answer_text_file_id bigint NOT NULL
);


ALTER TABLE public.test_set_tests OWNER TO postgres;

--
-- Name: task_version_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_version_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_version_tests_id_seq OWNER TO postgres;

--
-- Name: task_version_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_version_tests_id_seq OWNED BY public.test_set_tests.id;


--
-- Name: task_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_versions (
    id bigint NOT NULL,
    task_id bigint NOT NULL,
    short_code text NOT NULL,
    full_name text NOT NULL,
    time_lim_ms bigint NOT NULL,
    mem_lim_kibibytes bigint NOT NULL,
    testing_type_id text NOT NULL,
    origin text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    checker_id bigint,
    interactor_id bigint,
    md_statement_id bigint,
    example_set_id bigint,
    test_set_id bigint
);


ALTER TABLE public.task_versions OWNER TO postgres;

--
-- Name: task_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_versions_id_seq OWNER TO postgres;

--
-- Name: task_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_versions_id_seq OWNED BY public.task_versions.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by_id bigint NOT NULL,
    current_version_id bigint,
    stable_version_id bigint,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: text_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.text_files (
    id bigint NOT NULL,
    sha256 text NOT NULL,
    content text,
    created_at timestamp with time zone DEFAULT now(),
    compression text DEFAULT 'raw'::text NOT NULL
);


ALTER TABLE public.text_files OWNER TO postgres;

--
-- Name: test_files_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_files_id_seq OWNER TO postgres;

--
-- Name: test_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_files_id_seq OWNED BY public.text_files.id;


--
-- Name: test_sets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_sets (
    id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.test_sets OWNER TO postgres;

--
-- Name: test_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_sets_id_seq OWNER TO postgres;

--
-- Name: test_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_sets_id_seq OWNED BY public.test_sets.id;


--
-- Name: testing_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testing_types (
    id text NOT NULL,
    description_en text NOT NULL
);


ALTER TABLE public.testing_types OWNER TO postgres;

--
-- Name: testlib_checkers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testlib_checkers (
    id bigint NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.testlib_checkers OWNER TO postgres;

--
-- Name: testlib_checkers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testlib_checkers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testlib_checkers_id_seq OWNER TO postgres;

--
-- Name: testlib_checkers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testlib_checkers_id_seq OWNED BY public.testlib_checkers.id;


--
-- Name: testlib_interactors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testlib_interactors (
    id bigint NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.testlib_interactors OWNER TO postgres;

--
-- Name: testlib_interactors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testlib_interactors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testlib_interactors_id_seq OWNER TO postgres;

--
-- Name: testlib_interactors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testlib_interactors_id_seq OWNED BY public.testlib_interactors.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    hashed_password text NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    is_admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: evaluation_test_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results ALTER COLUMN id SET DEFAULT nextval('public.evaluation_test_results_id_seq'::regclass);


--
-- Name: evaluations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations ALTER COLUMN id SET DEFAULT nextval('public.evaluations_id_seq'::regclass);


--
-- Name: example_sets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.example_sets ALTER COLUMN id SET DEFAULT nextval('public.example_sets_id_seq'::regclass);


--
-- Name: markdown_statements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.markdown_statements ALTER COLUMN id SET DEFAULT nextval('public.markdown_statements_id_seq'::regclass);


--
-- Name: runtime_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.runtime_data ALTER COLUMN id SET DEFAULT nextval('public.runtime_data_id_seq'::regclass);


--
-- Name: runtime_statistics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.runtime_statistics ALTER COLUMN id SET DEFAULT nextval('public.runtime_statistics_id_seq'::regclass);


--
-- Name: statement_examples id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statement_examples ALTER COLUMN id SET DEFAULT nextval('public.statement_examples_id_seq'::regclass);


--
-- Name: submission_evaluations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_evaluations ALTER COLUMN id SET DEFAULT nextval('public.submission_evaluations_id_seq'::regclass);


--
-- Name: task_submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_submissions ALTER COLUMN id SET DEFAULT nextval('public.task_submissions_id_seq'::regclass);


--
-- Name: task_versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions ALTER COLUMN id SET DEFAULT nextval('public.task_versions_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: test_set_tests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_set_tests ALTER COLUMN id SET DEFAULT nextval('public.task_version_tests_id_seq'::regclass);


--
-- Name: test_sets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_sets ALTER COLUMN id SET DEFAULT nextval('public.test_sets_id_seq'::regclass);


--
-- Name: testlib_checkers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testlib_checkers ALTER COLUMN id SET DEFAULT nextval('public.testlib_checkers_id_seq'::regclass);


--
-- Name: testlib_interactors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testlib_interactors ALTER COLUMN id SET DEFAULT nextval('public.testlib_interactors_id_seq'::regclass);


--
-- Name: text_files id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.text_files ALTER COLUMN id SET DEFAULT nextval('public.test_files_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: evaluation_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluation_statuses (id, description_en, description_lv, dev_notes) FROM stdin;
IQ	in queue	gaida rindā	(submission)
R	received	saņemts	(submission)
C	compiling	tiek kompilēts	(submission)
T	testing	tiek testēts	(submission)
F	finished	pabeigts	(submission)
CE	compilation error	kompilācijas kļūda	(submission)
RJ	rejected	noraidīts	(submission)
AC	accepted	pieņemts	(test)
PT	partially correct	daļēji pareizi	(test)
WA	wrong answer	nepareiza atbilde	(test)
PE	presentation error	prezentācijas kļūda	(test)
TLE	time limit exceeded	laika limits pārsniegts	(test)
MLE	memory limit exceeded	atmiņas limits pārsniegts	(test)
ILE	idleness limit exceeded	darbības trūkums	(test)
IG	ignored	noignorēts	(test)
RE	runtime error	izpildes laika kļūda	(test)
SV	security violation	drošības pārkāpums	(common)
ISE	internal server error	iekšēja servera kļūda	(common)
\.


--
-- Data for Name: evaluation_test_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluation_test_results (id, evaluation_id, eval_status_id, task_v_test_id, exec_r_data_id, checker_r_data_id) FROM stdin;
\.


--
-- Data for Name: evaluations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluations (id, eval_status_id, eval_total_score, eval_possible_score, test_runtime_statistics_id, compilation_data_id, created_at, task_version_id) FROM stdin;
\.


--
-- Data for Name: example_sets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.example_sets (id, created_at) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	0001	create table users	SQL	V0001__create_table_users.sql	-1037636126	postgres	2024-06-04 17:53:41.646495	41	t
2	0002	programming languages	SQL	V0002__programming_languages.sql	-288503707	postgres	2024-06-04 17:53:41.715115	29	t
3	0003	add programming langs	SQL	V0003__add_programming_langs.sql	180237189	postgres	2024-06-04 17:53:41.758372	1	t
4	0004	users updated at trigger	SQL	V0004__users_updated_at_trigger.sql	-464124040	postgres	2024-06-04 17:53:41.770245	3	t
5	0005	create eval types table	SQL	V0005__create_eval_types_table.sql	-58587154	postgres	2024-06-04 17:53:41.786406	20	t
6	0006	add eval types	SQL	V0006__add_eval_types.sql	-1065952079	postgres	2024-06-04 17:53:41.816947	1	t
7	0007	create task sources table	SQL	V0007__create_task_sources_table.sql	850450997	postgres	2024-06-04 17:53:41.827922	29	t
8	0008	create table tasks	SQL	V0008__create_table_tasks.sql	-855476166	postgres	2024-06-04 17:53:41.86741	10	t
9	0009	create task authors table	SQL	V0009__create_task_authors_table.sql	1389756747	postgres	2024-06-04 17:53:41.887789	21	t
10	0010	create task versions table	SQL	V0010__create_task_versions_table.sql	-64443910	postgres	2024-06-04 17:53:41.918785	48	t
11	0011	create task submissions	SQL	V0011__create_task_submissions.sql	-1388864369	postgres	2024-06-04 17:53:41.978472	21	t
12	0012	create tags table	SQL	V0012__create_tags_table.sql	195375357	postgres	2024-06-04 17:53:42.010228	20	t
13	0013	create eval status table	SQL	V0013__create_eval_status_table.sql	138658003	postgres	2024-06-04 17:53:42.040059	19	t
14	0014	add eval statuses	SQL	V0014__add_eval_statuses.sql	-160066583	postgres	2024-06-04 17:53:42.069167	2	t
15	0015	create subm eval table	SQL	V0015__create_subm_eval_table.sql	-1379941344	postgres	2024-06-04 17:53:42.08159	20	t
16	0016	subm evals update at trig	SQL	V0016__subm_evals_update_at_trig.sql	1986500714	postgres	2024-06-04 17:53:42.112603	1	t
17	0017	create test files table	SQL	V0017__create_test_files_table.sql	-1966901806	postgres	2024-06-04 17:53:42.123559	28	t
18	0018	create task version tests table	SQL	V0018__create_task_version_tests_table.sql	-59161334	postgres	2024-06-04 17:53:42.161579	22	t
19	0019	add hello world column	SQL	V0019__add_hello_world_column.sql	-778913337	postgres	2024-06-04 17:53:42.193186	2	t
20	0020	add monaco id column	SQL	V0020__add_monaco_id_column.sql	-918129798	postgres	2024-06-04 17:53:42.204624	1	t
21	0022	default val created at tasks	SQL	V0022__default_val_created_at_tasks.sql	-297762893	postgres	2024-06-04 17:53:42.217077	1	t
22	0023	rename eval type add id	SQL	V0023__rename_eval_type_add_id.sql	805193433	postgres	2024-06-04 17:53:42.227302	1	t
23	0024	drop task source description	SQL	V0024__drop_task_source_description.sql	1540031041	postgres	2024-06-04 17:53:42.237531	1	t
24	0025	add more task sources	SQL	V0025__add_more_task_sources.sql	464297151	postgres	2024-06-04 17:53:42.248127	1	t
25	0027	add admin field to users	SQL	V0027__add_admin_field_to_users.sql	-242790776	postgres	2024-06-04 17:53:42.258465	0	t
26	0028	track owner of task	SQL	V0028__track_owner_of_task.sql	1625004400	postgres	2024-06-04 17:53:42.267805	1	t
27	0029	rename test name test filename	SQL	V0029__rename_test_name_test_filename.sql	-2112769979	postgres	2024-06-04 17:53:42.277447	0	t
28	0030	rename sources origins	SQL	V0030__rename_sources_origins.sql	709329549	postgres	2024-06-04 17:53:42.287028	0	t
29	0031	rename subm evaluations	SQL	V0031__rename_subm_evaluations.sql	-2129481655	postgres	2024-06-04 17:53:42.296269	1	t
30	0032	rename tags to problem tags	SQL	V0032__rename_tags_to_problem_tags.sql	-888001855	postgres	2024-06-04 17:53:42.305745	1	t
31	0033	rename eval types testing types	SQL	V0033__rename_eval_types_testing_types.sql	-842665464	postgres	2024-06-04 17:53:42.315607	0	t
32	0034	rename test files to text files	SQL	V0034__rename_test_files_to_text_files.sql	785059912	postgres	2024-06-04 17:53:42.325154	0	t
33	0035	add relevant version tasks table	SQL	V0035__add_relevant_version_tasks_table.sql	1452506156	postgres	2024-06-04 17:53:42.33464	1	t
34	0036	create markdown statements table	SQL	V0036__create_markdown_statements_table.sql	-2068147870	postgres	2024-06-04 17:53:42.345049	19	t
35	0037	create evaluation test verdicts table	SQL	V0037__create_evaluation_test_verdicts_table.sql	-2054532311	postgres	2024-06-04 17:53:42.373262	19	t
36	0038	drop owner user id column	SQL	V0038__drop_owner_user_id_column.sql	-899626340	postgres	2024-06-04 17:53:42.402402	1	t
37	0039	drop version name	SQL	V0039__drop_version_name.sql	774532735	postgres	2024-06-04 17:53:42.413713	1	t
38	0040	rename eval type id testing type	SQL	V0040__rename_eval_type_id_testing_type.sql	1043679239	postgres	2024-06-04 17:53:42.424741	1	t
39	0041	drop unique task version name	SQL	V0041__drop_unique_task_version_name.sql	105029791	postgres	2024-06-04 17:53:42.436734	1	t
40	0042	add published version tasks	SQL	V0042__add_published_version_tasks.sql	1942166277	postgres	2024-06-04 17:53:42.449067	1	t
41	0043	rename tasks columns	SQL	V0043__rename_tasks_columns.sql	1928963466	postgres	2024-06-04 17:53:42.458896	1	t
42	0044	add column md statement id	SQL	V0044__add_column_md_statement_id.sql	-775620596	postgres	2024-06-04 17:53:42.468609	1	t
43	0045	replace task authors by version authors	SQL	V0045__replace_task_authors_by_version_authors.sql	1961573892	postgres	2024-06-04 17:53:42.478627	20	t
44	0046	rename test to text file id	SQL	V0046__rename_test_to_text_file_id.sql	-1905396018	postgres	2024-06-04 17:53:42.508079	1	t
45	0047	add checker and interactor column	SQL	V0047__add_checker_and_interactor_column.sql	-299085707	postgres	2024-06-04 17:53:42.517782	1	t
46	0048	checker interactor as referrences	SQL	V0048__checker_interactor_as_referrences.sql	-689454598	postgres	2024-06-04 17:53:42.527472	2	t
47	0049	create checker table	SQL	V0049__create_checker_table.sql	566911451	postgres	2024-06-04 17:53:42.538415	19	t
48	0050	create interactor table	SQL	V0050__create_interactor_table.sql	1617189013	postgres	2024-06-04 17:53:42.566774	19	t
49	0051	checker interactor primary key	SQL	V0051__checker_interactor_primary_key.sql	-2146994657	postgres	2024-06-04 17:53:42.59703	19	t
50	0052	change checker interactor ref	SQL	V0052__change_checker_interactor_ref.sql	705808235	postgres	2024-06-04 17:53:42.625405	2	t
51	0053	add lang col to md	SQL	V0053__add_lang_col_to_md.sql	-2131626738	postgres	2024-06-04 17:53:42.637731	1	t
52	0054	create statement examples table	SQL	V0054__create_statement_examples_table.sql	-1206812914	postgres	2024-06-04 17:53:42.648067	11	t
53	0055	submission evals col constraints	SQL	V0055__submission_evals_col_constraints.sql	-1967879485	postgres	2024-06-04 17:53:42.668237	1	t
54	0056	rename submission evals cols	SQL	V0056__rename_submission_evals_cols.sql	-1989461230	postgres	2024-06-04 17:53:42.678927	1	t
55	0057	rename subm evals col	SQL	V0057__rename_subm_evals_col.sql	1345560975	postgres	2024-06-04 17:53:42.688486	0	t
56	0058	add notes col statuses	SQL	V0058__add_notes_col_statuses.sql	-1479909242	postgres	2024-06-04 17:53:42.697777	1	t
57	0059	create evaluation test results	SQL	V0059__create_evaluation_test_results.sql	-638309233	postgres	2024-06-04 17:53:42.70748	21	t
58	0060	add compiled filename col	SQL	V0060__add_compiled_filename_col.sql	-985910358	postgres	2024-06-04 17:53:42.737934	1	t
59	0061	add hidden to submissions	SQL	V0061__add_hidden_to_submissions.sql	761480001	postgres	2024-06-04 17:53:42.747318	1	t
60	0062	create runtime data table	SQL	V0062__create_runtime_data_table.sql	1039985789	postgres	2024-06-04 17:53:42.756876	23	t
61	0063	create runtime statistics table	SQL	V0063__create_runtime_statistics_table.sql	-841138336	postgres	2024-06-04 17:53:42.788845	10	t
62	0064	create evaluations table	SQL	V0064__create_evaluations_table.sql	-1731847511	postgres	2024-06-04 17:53:42.80772	19	t
63	0065	decompose eval test results	SQL	V0065__decompose_eval_test_results.sql	1575035271	postgres	2024-06-04 17:53:42.836004	21	t
64	0066	decompose subm evals	SQL	V0066__decompose_subm_evals.sql	-531889566	postgres	2024-06-04 17:53:42.866976	12	t
65	0067	add task version id evaluations	SQL	V0067__add_task_version_id_evaluations.sql	1784908217	postgres	2024-06-04 17:53:42.889072	1	t
66	0068	add visible eval id column	SQL	V0068__add_visible_eval_id_column.sql	-2112744287	postgres	2024-06-04 17:53:42.898672	1	t
67	0069	change dtype exitcode	SQL	V0069__change_dtype_exitcode.sql	-226613634	postgres	2024-06-04 17:53:42.908107	19	t
68	0070	add enabled col langs	SQL	V0070__add_enabled_col_langs.sql	-538209192	postgres	2024-06-04 17:53:42.936053	0	t
69	0071	deferable fk langs	SQL	V0071__deferable_fk_langs.sql	-1077856428	postgres	2024-06-04 17:53:42.945019	1	t
70	0072	rename kb to kibibytes	SQL	V0072__rename_kb_to_kibibytes.sql	-285335031	postgres	2024-06-04 17:53:42.954631	0	t
71	0073	add cols runtime statistics	SQL	V0073__add_cols_runtime_statistics.sql	1123684174	postgres	2024-06-04 17:53:42.963537	1	t
72	0074	change avg dtype	SQL	V0074__change_avg_dtype.sql	1877039726	postgres	2024-06-04 17:53:42.973379	19	t
73	0075	make content nullable	SQL	V0075__make_content_nullable.sql	-1005957509	postgres	2024-06-04 17:53:43.004274	0	t
74	0076	compression col	SQL	V0076__compression_col.sql	-156233277	postgres	2024-06-04 17:53:43.013439	0	t
75	0077	create table published task codes	SQL	V0077__create_table_published_task_codes.sql	-478627380	postgres	2024-06-04 17:53:43.022678	10	t
76	0078	rename col relevant version id	SQL	V0078__rename_col_relevant_version_id.sql	-8494722	postgres	2024-06-04 17:53:43.041272	1	t
77	0079	rename col published version id	SQL	V0079__rename_col_published_version_id.sql	450437643	postgres	2024-06-04 17:53:43.051379	1	t
78	0080	bigint stable version id	SQL	V0080__bigint_stable_version_id.sql	-44137564	postgres	2024-06-04 17:53:43.061708	15	t
79	0081	add deleted flag tasks	SQL	V0081__add_deleted_flag_tasks.sql	819094540	postgres	2024-06-04 17:53:43.085811	1	t
80	0082	deleted at tasks table	SQL	V0082__deleted_at_tasks_table.sql	437664300	postgres	2024-06-04 17:53:43.099755	8	t
81	0083	remove t vers id stmts	SQL	V0083__remove_t_vers_id_stmts.sql	-771840384	postgres	2024-06-04 17:53:43.113735	2	t
82	0084	drop version authors	SQL	V0084__drop_version_authors.sql	701815260	postgres	2024-06-04 17:53:43.124144	1	t
83	0085	refactor t vers duplication	SQL	V0085__refactor_t_vers_duplication.sql	-88099552	postgres	2024-06-04 17:53:43.134529	23	t
84	0086	rename t vers tests table	SQL	V0086__rename_t_vers_tests_table.sql	77187586	postgres	2024-06-04 17:53:43.167234	0	t
85	0087	add set ids cols t vers	SQL	V0087__add_set_ids_cols_t_vers.sql	-1887242816	postgres	2024-06-04 17:53:43.176628	2	t
86	0088	change task id bigint	SQL	V0088__change_task_id_bigint.sql	-1363544710	postgres	2024-06-04 17:53:43.187777	10	t
87	0089	drop updated at from t versions	SQL	V0089__drop_updated_at_from_t_versions.sql	1377085810	postgres	2024-06-04 17:53:43.208916	0	t
88	\N	evaluation statuses	SQL	R__evaluation_statuses.sql	280868094	postgres	2024-06-04 17:53:43.218034	2	t
89	\N	programming languages	SQL	R__programming_languages.sql	-510021202	postgres	2024-06-04 17:53:43.229353	6	t
\.


--
-- Data for Name: markdown_statements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.markdown_statements (id, story, input, output, notes, scoring, lang_iso639_1) FROM stdin;
\.


--
-- Data for Name: problem_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.problem_tags (id, created_at, updated_at, color_rgb_hex, description_lv) FROM stdin;
\.


--
-- Data for Name: programming_languages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.programming_languages (id, full_name, code_filename, compile_cmd, execute_cmd, env_version_cmd, hello_world_code, monaco_id, compiled_filename, enabled) FROM stdin;
python3.10	Python 3.10	main.py	\N	python3.10 main.py	python3.10 --version	print("Hello, World!")	python	\N	f
java18	Java 18	Main.java	javac Main.java	java Main	java --version	public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}	java	Main	f
python3.11	Python 3.11	main.py	\N	python3.11 main.py	python3.10 --version	print("Hello, World!")	python	\N	t
go1.19	Go 1.19	main.go	go build main.go	./main	go version	package main\nimport "fmt"\nfunc main() {\n    fmt.Println("Hello, World!")\n}	go	main	t
cpp17	C++17 (GNU G++)	main.cpp	g++ -std=c++17 -o main main.cpp	./main	g++ --version	#include <iostream>\nint main() { std::cout << "Hello, World!" << std::endl; }	cpp	main	t
\.


--
-- Data for Name: published_task_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.published_task_codes (task_code, task_id) FROM stdin;
\.


--
-- Data for Name: runtime_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.runtime_data (id, stdout, stderr, time_millis, memory_kibibytes, time_wall_millis, exit_code) FROM stdin;
\.


--
-- Data for Name: runtime_statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.runtime_statistics (id, maximum_time_millis, maximum_memory_kibibytes, total_time_millis, total_memory_kibibytes, avg_time_millis, avg_memory_kibibytes) FROM stdin;
\.


--
-- Data for Name: statement_examples; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statement_examples (id, input, answer, example_set_id) FROM stdin;
\.


--
-- Data for Name: submission_evaluations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submission_evaluations (id, submission_id, evaluation_id) FROM stdin;
\.


--
-- Data for Name: task_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_origins (abbreviation, full_name) FROM stdin;
LIO	Latvijas informātikas olimpiāde
ICPC	Starptautiskās studentu programmēšanas sacensības
IOI	Pasaules informātikas olimpiāde
BOI	Baltijas informātikas olimpiāde
ECOO	Austrum-Kanādas datorzinātņu olimpiāde
COCI	Horvātijas atvērtās informātikas olimpiāde
POI	Polijas informātikas olimpiāde
CEOI	Centrāleiropas informātikas olimpiāde
INOI	Indijas nacionālā informātikas olimpiāde
USACO	ASV Datorzinātņu olimpiāde
\.


--
-- Data for Name: task_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_submissions (id, user_id, task_id, programming_lang_id, submission, created_at, hidden, visible_eval_id) FROM stdin;
\.


--
-- Data for Name: task_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_versions (id, task_id, short_code, full_name, time_lim_ms, mem_lim_kibibytes, testing_type_id, origin, created_at, checker_id, interactor_id, md_statement_id, example_set_id, test_set_id) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, created_at, created_by_id, current_version_id, stable_version_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: test_set_tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_set_tests (id, test_filename, test_set_id, input_text_file_id, answer_text_file_id) FROM stdin;
\.


--
-- Data for Name: test_sets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_sets (id, created_at) FROM stdin;
\.


--
-- Data for Name: testing_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testing_types (id, description_en) FROM stdin;
simple	Predetermined stdin with one and only one correct stdout.
checker	Predetermined stdin with one or more correct std outputs. Output checked by checker.
interactive	Stdin determined during execution by the interactor. Output checked by checker.
\.


--
-- Data for Name: testlib_checkers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testlib_checkers (id, code) FROM stdin;
\.


--
-- Data for Name: testlib_interactors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testlib_interactors (id, code) FROM stdin;
\.


--
-- Data for Name: text_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.text_files (id, sha256, content, created_at, compression) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, hashed_password, first_name, last_name, created_at, updated_at, is_admin) FROM stdin;
\.


--
-- Name: evaluation_test_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluation_test_results_id_seq', 1, false);


--
-- Name: evaluations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluations_id_seq', 1, false);


--
-- Name: example_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.example_sets_id_seq', 1, false);


--
-- Name: markdown_statements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.markdown_statements_id_seq', 1, false);


--
-- Name: runtime_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.runtime_data_id_seq', 1, false);


--
-- Name: runtime_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.runtime_statistics_id_seq', 1, false);


--
-- Name: statement_examples_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statement_examples_id_seq', 1, false);


--
-- Name: submission_evaluations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submission_evaluations_id_seq', 1, false);


--
-- Name: task_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_submissions_id_seq', 1, false);


--
-- Name: task_version_tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_version_tests_id_seq', 1, false);


--
-- Name: task_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_versions_id_seq', 1, false);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- Name: test_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_files_id_seq', 1, false);


--
-- Name: test_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_sets_id_seq', 1, false);


--
-- Name: testlib_checkers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testlib_checkers_id_seq', 1, false);


--
-- Name: testlib_interactors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testlib_interactors_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: testing_types eval_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testing_types
    ADD CONSTRAINT eval_types_pkey PRIMARY KEY (id);


--
-- Name: evaluation_statuses evaluation_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_statuses
    ADD CONSTRAINT evaluation_statuses_pkey PRIMARY KEY (id);


--
-- Name: evaluation_test_results evaluation_test_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_pkey PRIMARY KEY (id);


--
-- Name: evaluations evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_pkey PRIMARY KEY (id);


--
-- Name: example_sets example_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.example_sets
    ADD CONSTRAINT example_sets_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: markdown_statements markdown_statements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.markdown_statements
    ADD CONSTRAINT markdown_statements_pkey PRIMARY KEY (id);


--
-- Name: programming_languages programming_languages_full_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programming_languages
    ADD CONSTRAINT programming_languages_full_name_key UNIQUE (full_name);


--
-- Name: programming_languages programming_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programming_languages
    ADD CONSTRAINT programming_languages_pkey PRIMARY KEY (id);


--
-- Name: published_task_codes published_task_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.published_task_codes
    ADD CONSTRAINT published_task_codes_pkey PRIMARY KEY (task_code);


--
-- Name: runtime_data runtime_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.runtime_data
    ADD CONSTRAINT runtime_data_pkey PRIMARY KEY (id);


--
-- Name: runtime_statistics runtime_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.runtime_statistics
    ADD CONSTRAINT runtime_statistics_pkey PRIMARY KEY (id);


--
-- Name: submission_evaluations submission_evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_evaluations
    ADD CONSTRAINT submission_evaluations_pkey PRIMARY KEY (id);


--
-- Name: problem_tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: task_origins task_sources_full_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_origins
    ADD CONSTRAINT task_sources_full_name_unique UNIQUE (full_name);


--
-- Name: task_origins task_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_origins
    ADD CONSTRAINT task_sources_pkey PRIMARY KEY (abbreviation);


--
-- Name: task_submissions task_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_pkey PRIMARY KEY (id);


--
-- Name: test_set_tests task_version_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_pkey PRIMARY KEY (id);


--
-- Name: task_versions task_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: text_files test_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.text_files
    ADD CONSTRAINT test_files_pkey PRIMARY KEY (id);


--
-- Name: text_files test_files_sha256_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.text_files
    ADD CONSTRAINT test_files_sha256_key UNIQUE (sha256);


--
-- Name: test_sets test_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_sets
    ADD CONSTRAINT test_sets_pkey PRIMARY KEY (id);


--
-- Name: testlib_checkers testlib_checkers_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testlib_checkers
    ADD CONSTRAINT testlib_checkers_code_key UNIQUE (code);


--
-- Name: testlib_checkers testlib_checkers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testlib_checkers
    ADD CONSTRAINT testlib_checkers_pkey PRIMARY KEY (id);


--
-- Name: testlib_interactors testlib_interactors_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testlib_interactors
    ADD CONSTRAINT testlib_interactors_code_key UNIQUE (code);


--
-- Name: testlib_interactors testlib_interactors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testlib_interactors
    ADD CONSTRAINT testlib_interactors_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: users users_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER users_updated_at_trigger AFTER UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: evaluation_test_results evaluation_test_results_checker_r_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_checker_r_data_id_fkey FOREIGN KEY (checker_r_data_id) REFERENCES public.runtime_data(id);


--
-- Name: evaluation_test_results evaluation_test_results_eval_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_eval_status_id_fkey FOREIGN KEY (eval_status_id) REFERENCES public.evaluation_statuses(id);


--
-- Name: evaluation_test_results evaluation_test_results_evaluation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_evaluation_id_fkey FOREIGN KEY (evaluation_id) REFERENCES public.evaluations(id);


--
-- Name: evaluation_test_results evaluation_test_results_exec_r_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_exec_r_data_id_fkey FOREIGN KEY (exec_r_data_id) REFERENCES public.runtime_data(id);


--
-- Name: evaluation_test_results evaluation_test_results_task_v_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_task_v_test_id_fkey FOREIGN KEY (task_v_test_id) REFERENCES public.test_set_tests(id);


--
-- Name: evaluations evaluations_compilation_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_compilation_data_id_fkey FOREIGN KEY (compilation_data_id) REFERENCES public.runtime_data(id);


--
-- Name: evaluations evaluations_eval_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_eval_status_id_fkey FOREIGN KEY (eval_status_id) REFERENCES public.evaluation_statuses(id);


--
-- Name: evaluations evaluations_task_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_task_version_id_fkey FOREIGN KEY (task_version_id) REFERENCES public.task_versions(id);


--
-- Name: evaluations evaluations_test_runtime_statistics_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_test_runtime_statistics_id_fkey FOREIGN KEY (test_runtime_statistics_id) REFERENCES public.runtime_statistics(id);


--
-- Name: task_versions fk_statement_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT fk_statement_id FOREIGN KEY (md_statement_id) REFERENCES public.markdown_statements(id);


--
-- Name: task_versions fk_task_versions_example_set_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT fk_task_versions_example_set_id FOREIGN KEY (example_set_id) REFERENCES public.example_sets(id);


--
-- Name: task_versions fk_task_versions_test_set_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT fk_task_versions_test_set_id FOREIGN KEY (test_set_id) REFERENCES public.test_set_tests(id);


--
-- Name: published_task_codes published_task_codes_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.published_task_codes
    ADD CONSTRAINT published_task_codes_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: statement_examples statement_examples_example_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statement_examples
    ADD CONSTRAINT statement_examples_example_set_id_fkey FOREIGN KEY (example_set_id) REFERENCES public.example_sets(id);


--
-- Name: submission_evaluations submission_evaluations_evaluation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_evaluations
    ADD CONSTRAINT submission_evaluations_evaluation_id_fkey FOREIGN KEY (evaluation_id) REFERENCES public.evaluations(id);


--
-- Name: submission_evaluations submission_evaluations_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submission_evaluations
    ADD CONSTRAINT submission_evaluations_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.task_submissions(id);


--
-- Name: task_submissions task_submissions_programming_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_programming_lang_id_fkey FOREIGN KEY (programming_lang_id) REFERENCES public.programming_languages(id) DEFERRABLE;


--
-- Name: task_submissions task_submissions_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: task_submissions task_submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: task_submissions task_submissions_visible_eval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_visible_eval_id_fkey FOREIGN KEY (visible_eval_id) REFERENCES public.evaluations(id);


--
-- Name: test_set_tests task_version_tests_answer_test_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_answer_test_file_id_fkey FOREIGN KEY (answer_text_file_id) REFERENCES public.text_files(id);


--
-- Name: test_set_tests task_version_tests_input_test_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_input_test_file_id_fkey FOREIGN KEY (input_text_file_id) REFERENCES public.text_files(id);


--
-- Name: test_set_tests task_version_tests_test_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_test_set_id_fkey FOREIGN KEY (test_set_id) REFERENCES public.test_sets(id);


--
-- Name: task_versions task_versions_checker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_checker_id_fkey FOREIGN KEY (checker_id) REFERENCES public.testlib_checkers(id);


--
-- Name: task_versions task_versions_eval_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_eval_type_fkey FOREIGN KEY (testing_type_id) REFERENCES public.testing_types(id);


--
-- Name: task_versions task_versions_interactor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_interactor_id_fkey FOREIGN KEY (interactor_id) REFERENCES public.testlib_interactors(id);


--
-- Name: task_versions task_versions_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_current_version_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_current_version_fkey FOREIGN KEY (current_version_id) REFERENCES public.task_versions(id);


--
-- Name: tasks tasks_stable_version_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_stable_version_fkey FOREIGN KEY (stable_version_id) REFERENCES public.task_versions(id);


--
-- PostgreSQL database dump complete
--

