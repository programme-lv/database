CREATE TABLE evaluation_test_verdicts (
    id BIGSERIAL PRIMARY KEY,
    evaluation_id BIGINT NOT NULL REFERENCES submission_evaluations(id),
    test_id BIGINT NOT NULL REFERENCES task_version_tests(id),

    verdict TEXT NOT NULL REFERENCES evaluation_statuses(id),

    compilation_time_ms BIGINT,
    compilation_time_wall_ms BIGINT,
    compilation_memory_kb BIGINT,
    compilation_stdout TEXT,
    compilation_stderr TEXT,
    compilation_exit_code BIGINT,

    execution_time_ms BIGINT,
    execution_time_wall_ms BIGINT,
    execution_memory_kb BIGINT,
    execution_stdout TEXT,
    execution_stderr TEXT,
    execution_exit_code BIGINT,

    checker_time_ms BIGINT,
    checker_time_wall_ms BIGINT,
    checker_memory_kb BIGINT,
    checker_stdout TEXT,
    checker_stderr TEXT,
    checker_exit_code BIGINT
);
    
