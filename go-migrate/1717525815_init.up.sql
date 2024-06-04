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
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: evaluation_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluation_statuses (
    id text NOT NULL,
    description_en text NOT NULL,
    description_lv text NOT NULL,
    dev_notes text
);


--
-- Name: evaluation_test_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluation_test_results (
    id bigint NOT NULL,
    evaluation_id bigint NOT NULL,
    eval_status_id text NOT NULL,
    task_v_test_id bigint NOT NULL,
    exec_r_data_id bigint,
    checker_r_data_id bigint
);


--
-- Name: evaluation_test_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluation_test_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluation_test_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluation_test_results_id_seq OWNED BY public.evaluation_test_results.id;


--
-- Name: evaluations; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluations_id_seq OWNED BY public.evaluations.id;


--
-- Name: example_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.example_sets (
    id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: example_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.example_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: example_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.example_sets_id_seq OWNED BY public.example_sets.id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: markdown_statements; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: markdown_statements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.markdown_statements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: markdown_statements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.markdown_statements_id_seq OWNED BY public.markdown_statements.id;


--
-- Name: problem_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.problem_tags (
    id text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    color_rgb_hex text,
    description_lv text,
    CONSTRAINT tags_color_rgb_hex_check CHECK ((color_rgb_hex ~* '^#[0-9a-f]{6}$'::text))
);


--
-- Name: programming_languages; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: published_task_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.published_task_codes (
    task_code character varying(255) NOT NULL,
    task_id bigint NOT NULL
);


--
-- Name: runtime_data; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: runtime_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.runtime_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: runtime_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.runtime_data_id_seq OWNED BY public.runtime_data.id;


--
-- Name: runtime_statistics; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: runtime_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.runtime_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: runtime_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.runtime_statistics_id_seq OWNED BY public.runtime_statistics.id;


--
-- Name: statement_examples; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.statement_examples (
    id bigint NOT NULL,
    input text NOT NULL,
    answer text NOT NULL,
    example_set_id bigint NOT NULL
);


--
-- Name: statement_examples_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.statement_examples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statement_examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.statement_examples_id_seq OWNED BY public.statement_examples.id;


--
-- Name: submission_evaluations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submission_evaluations (
    id bigint NOT NULL,
    submission_id bigint NOT NULL,
    evaluation_id bigint NOT NULL
);


--
-- Name: submission_evaluations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submission_evaluations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submission_evaluations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submission_evaluations_id_seq OWNED BY public.submission_evaluations.id;


--
-- Name: task_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_origins (
    abbreviation text NOT NULL,
    full_name text NOT NULL,
    CONSTRAINT task_sources_full_name_not_empty CHECK ((full_name <> ''::text))
);


--
-- Name: task_submissions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: task_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.task_submissions_id_seq OWNED BY public.task_submissions.id;


--
-- Name: test_set_tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_set_tests (
    id bigint NOT NULL,
    test_filename text NOT NULL,
    test_set_id bigint NOT NULL,
    input_text_file_id bigint NOT NULL,
    answer_text_file_id bigint NOT NULL
);


--
-- Name: task_version_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_version_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_version_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.task_version_tests_id_seq OWNED BY public.test_set_tests.id;


--
-- Name: task_versions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: task_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.task_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.task_versions_id_seq OWNED BY public.task_versions.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by_id bigint NOT NULL,
    current_version_id bigint,
    stable_version_id bigint,
    deleted_at timestamp without time zone
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: text_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.text_files (
    id bigint NOT NULL,
    sha256 text NOT NULL,
    content text,
    created_at timestamp with time zone DEFAULT now(),
    compression text DEFAULT 'raw'::text NOT NULL
);


--
-- Name: test_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.test_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.test_files_id_seq OWNED BY public.text_files.id;


--
-- Name: test_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_sets (
    id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: test_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.test_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.test_sets_id_seq OWNED BY public.test_sets.id;


--
-- Name: testing_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testing_types (
    id text NOT NULL,
    description_en text NOT NULL
);


--
-- Name: testlib_checkers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testlib_checkers (
    id bigint NOT NULL,
    code text NOT NULL
);


--
-- Name: testlib_checkers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.testlib_checkers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: testlib_checkers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.testlib_checkers_id_seq OWNED BY public.testlib_checkers.id;


--
-- Name: testlib_interactors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testlib_interactors (
    id bigint NOT NULL,
    code text NOT NULL
);


--
-- Name: testlib_interactors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.testlib_interactors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: testlib_interactors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.testlib_interactors_id_seq OWNED BY public.testlib_interactors.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: evaluation_test_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results ALTER COLUMN id SET DEFAULT nextval('public.evaluation_test_results_id_seq'::regclass);


--
-- Name: evaluations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations ALTER COLUMN id SET DEFAULT nextval('public.evaluations_id_seq'::regclass);


--
-- Name: example_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.example_sets ALTER COLUMN id SET DEFAULT nextval('public.example_sets_id_seq'::regclass);


--
-- Name: markdown_statements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.markdown_statements ALTER COLUMN id SET DEFAULT nextval('public.markdown_statements_id_seq'::regclass);


--
-- Name: runtime_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.runtime_data ALTER COLUMN id SET DEFAULT nextval('public.runtime_data_id_seq'::regclass);


--
-- Name: runtime_statistics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.runtime_statistics ALTER COLUMN id SET DEFAULT nextval('public.runtime_statistics_id_seq'::regclass);


--
-- Name: statement_examples id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statement_examples ALTER COLUMN id SET DEFAULT nextval('public.statement_examples_id_seq'::regclass);


--
-- Name: submission_evaluations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_evaluations ALTER COLUMN id SET DEFAULT nextval('public.submission_evaluations_id_seq'::regclass);


--
-- Name: task_submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions ALTER COLUMN id SET DEFAULT nextval('public.task_submissions_id_seq'::regclass);


--
-- Name: task_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions ALTER COLUMN id SET DEFAULT nextval('public.task_versions_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: test_set_tests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_set_tests ALTER COLUMN id SET DEFAULT nextval('public.task_version_tests_id_seq'::regclass);


--
-- Name: test_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_sets ALTER COLUMN id SET DEFAULT nextval('public.test_sets_id_seq'::regclass);


--
-- Name: testlib_checkers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testlib_checkers ALTER COLUMN id SET DEFAULT nextval('public.testlib_checkers_id_seq'::regclass);


--
-- Name: testlib_interactors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testlib_interactors ALTER COLUMN id SET DEFAULT nextval('public.testlib_interactors_id_seq'::regclass);


--
-- Name: text_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_files ALTER COLUMN id SET DEFAULT nextval('public.test_files_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: testing_types eval_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testing_types
    ADD CONSTRAINT eval_types_pkey PRIMARY KEY (id);


--
-- Name: evaluation_statuses evaluation_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_statuses
    ADD CONSTRAINT evaluation_statuses_pkey PRIMARY KEY (id);


--
-- Name: evaluation_test_results evaluation_test_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_pkey PRIMARY KEY (id);


--
-- Name: evaluations evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_pkey PRIMARY KEY (id);


--
-- Name: example_sets example_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.example_sets
    ADD CONSTRAINT example_sets_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: markdown_statements markdown_statements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.markdown_statements
    ADD CONSTRAINT markdown_statements_pkey PRIMARY KEY (id);


--
-- Name: programming_languages programming_languages_full_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programming_languages
    ADD CONSTRAINT programming_languages_full_name_key UNIQUE (full_name);


--
-- Name: programming_languages programming_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programming_languages
    ADD CONSTRAINT programming_languages_pkey PRIMARY KEY (id);


--
-- Name: published_task_codes published_task_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.published_task_codes
    ADD CONSTRAINT published_task_codes_pkey PRIMARY KEY (task_code);


--
-- Name: runtime_data runtime_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.runtime_data
    ADD CONSTRAINT runtime_data_pkey PRIMARY KEY (id);


--
-- Name: runtime_statistics runtime_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.runtime_statistics
    ADD CONSTRAINT runtime_statistics_pkey PRIMARY KEY (id);


--
-- Name: submission_evaluations submission_evaluations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_evaluations
    ADD CONSTRAINT submission_evaluations_pkey PRIMARY KEY (id);


--
-- Name: problem_tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.problem_tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: task_origins task_sources_full_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_origins
    ADD CONSTRAINT task_sources_full_name_unique UNIQUE (full_name);


--
-- Name: task_origins task_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_origins
    ADD CONSTRAINT task_sources_pkey PRIMARY KEY (abbreviation);


--
-- Name: task_submissions task_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_pkey PRIMARY KEY (id);


--
-- Name: test_set_tests task_version_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_pkey PRIMARY KEY (id);


--
-- Name: task_versions task_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: text_files test_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_files
    ADD CONSTRAINT test_files_pkey PRIMARY KEY (id);


--
-- Name: text_files test_files_sha256_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_files
    ADD CONSTRAINT test_files_sha256_key UNIQUE (sha256);


--
-- Name: test_sets test_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_sets
    ADD CONSTRAINT test_sets_pkey PRIMARY KEY (id);


--
-- Name: testlib_checkers testlib_checkers_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testlib_checkers
    ADD CONSTRAINT testlib_checkers_code_key UNIQUE (code);


--
-- Name: testlib_checkers testlib_checkers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testlib_checkers
    ADD CONSTRAINT testlib_checkers_pkey PRIMARY KEY (id);


--
-- Name: testlib_interactors testlib_interactors_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testlib_interactors
    ADD CONSTRAINT testlib_interactors_code_key UNIQUE (code);


--
-- Name: testlib_interactors testlib_interactors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testlib_interactors
    ADD CONSTRAINT testlib_interactors_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: users users_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER users_updated_at_trigger AFTER UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: evaluation_test_results evaluation_test_results_checker_r_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_checker_r_data_id_fkey FOREIGN KEY (checker_r_data_id) REFERENCES public.runtime_data(id);


--
-- Name: evaluation_test_results evaluation_test_results_eval_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_eval_status_id_fkey FOREIGN KEY (eval_status_id) REFERENCES public.evaluation_statuses(id);


--
-- Name: evaluation_test_results evaluation_test_results_evaluation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_evaluation_id_fkey FOREIGN KEY (evaluation_id) REFERENCES public.evaluations(id);


--
-- Name: evaluation_test_results evaluation_test_results_exec_r_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_exec_r_data_id_fkey FOREIGN KEY (exec_r_data_id) REFERENCES public.runtime_data(id);


--
-- Name: evaluation_test_results evaluation_test_results_task_v_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_test_results
    ADD CONSTRAINT evaluation_test_results_task_v_test_id_fkey FOREIGN KEY (task_v_test_id) REFERENCES public.test_set_tests(id);


--
-- Name: evaluations evaluations_compilation_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_compilation_data_id_fkey FOREIGN KEY (compilation_data_id) REFERENCES public.runtime_data(id);


--
-- Name: evaluations evaluations_eval_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_eval_status_id_fkey FOREIGN KEY (eval_status_id) REFERENCES public.evaluation_statuses(id);


--
-- Name: evaluations evaluations_task_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_task_version_id_fkey FOREIGN KEY (task_version_id) REFERENCES public.task_versions(id);


--
-- Name: evaluations evaluations_test_runtime_statistics_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluations
    ADD CONSTRAINT evaluations_test_runtime_statistics_id_fkey FOREIGN KEY (test_runtime_statistics_id) REFERENCES public.runtime_statistics(id);


--
-- Name: task_versions fk_statement_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT fk_statement_id FOREIGN KEY (md_statement_id) REFERENCES public.markdown_statements(id);


--
-- Name: task_versions fk_task_versions_example_set_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT fk_task_versions_example_set_id FOREIGN KEY (example_set_id) REFERENCES public.example_sets(id);


--
-- Name: task_versions fk_task_versions_test_set_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT fk_task_versions_test_set_id FOREIGN KEY (test_set_id) REFERENCES public.test_set_tests(id);


--
-- Name: published_task_codes published_task_codes_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.published_task_codes
    ADD CONSTRAINT published_task_codes_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: statement_examples statement_examples_example_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.statement_examples
    ADD CONSTRAINT statement_examples_example_set_id_fkey FOREIGN KEY (example_set_id) REFERENCES public.example_sets(id);


--
-- Name: submission_evaluations submission_evaluations_evaluation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_evaluations
    ADD CONSTRAINT submission_evaluations_evaluation_id_fkey FOREIGN KEY (evaluation_id) REFERENCES public.evaluations(id);


--
-- Name: submission_evaluations submission_evaluations_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_evaluations
    ADD CONSTRAINT submission_evaluations_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.task_submissions(id);


--
-- Name: task_submissions task_submissions_programming_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_programming_lang_id_fkey FOREIGN KEY (programming_lang_id) REFERENCES public.programming_languages(id) DEFERRABLE;


--
-- Name: task_submissions task_submissions_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: task_submissions task_submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: task_submissions task_submissions_visible_eval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_submissions
    ADD CONSTRAINT task_submissions_visible_eval_id_fkey FOREIGN KEY (visible_eval_id) REFERENCES public.evaluations(id);


--
-- Name: test_set_tests task_version_tests_answer_test_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_answer_test_file_id_fkey FOREIGN KEY (answer_text_file_id) REFERENCES public.text_files(id);


--
-- Name: test_set_tests task_version_tests_input_test_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_input_test_file_id_fkey FOREIGN KEY (input_text_file_id) REFERENCES public.text_files(id);


--
-- Name: test_set_tests task_version_tests_test_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_set_tests
    ADD CONSTRAINT task_version_tests_test_set_id_fkey FOREIGN KEY (test_set_id) REFERENCES public.test_sets(id);


--
-- Name: task_versions task_versions_checker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_checker_id_fkey FOREIGN KEY (checker_id) REFERENCES public.testlib_checkers(id);


--
-- Name: task_versions task_versions_eval_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_eval_type_fkey FOREIGN KEY (testing_type_id) REFERENCES public.testing_types(id);


--
-- Name: task_versions task_versions_interactor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_interactor_id_fkey FOREIGN KEY (interactor_id) REFERENCES public.testlib_interactors(id);


--
-- Name: task_versions task_versions_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_versions
    ADD CONSTRAINT task_versions_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_current_version_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_current_version_fkey FOREIGN KEY (current_version_id) REFERENCES public.task_versions(id);


--
-- Name: tasks tasks_stable_version_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_stable_version_fkey FOREIGN KEY (stable_version_id) REFERENCES public.task_versions(id);


--
-- PostgreSQL database dump complete
--

