DROP TABLE IF EXISTS evaluation_test_verdicts;

CREATE TABLE evaluation_test_results (
    id BIGSERIAL PRIMARY KEY,
    submission_evaluations_id BIGINT NOT NULL REFERENCES submission_evaluations,
    task_version_test_id BIGINT NOT NULL REFERENCES task_version_tests,

	exec_stdout TEXT,
	exec_stderr TEXT,
	exec_time_ms BIGINT,
	exec_memory_kb BIGINT,
	exec_time_wall_ms BIGINT,
	exec_exit_code INT,

	checker_stdout TEXT,
	checker_stderr TEXT,
	checker_time_ms BIGINT,
	checker_memory_kb BIGINT,
	checker_time_wall_ms BIGINT,
	checker_exit_code INT,

	eval_status_id TEXT NOT NULL REFERENCES evaluation_statuses
);
