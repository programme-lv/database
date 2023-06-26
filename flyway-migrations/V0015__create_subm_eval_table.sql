CREATE TABLE task_subm_evaluations (
    id BIGSERIAL PRIMARY KEY,
    task_submission_id BIGINT NOT NULL REFERENCES task_submissions,

    eval_task_version_id BIGINT NOT NULL REFERENCES task_versions,

    test_maximum_time_ms BIGINT,
    test_maximum_memory_kb BIGINT,

    total_time_ms BIGINT,
    total_memory_kb BIGINT,

    eval_status_id TEXT NOT NULL REFERENCES evaluation_statuses,
    eval_total_score BIGINT,

    compilation_stdout TEXT,
    compilation_stderr TEXT,
    compilation_time_ms BIGINT,
    compilation_memory_kb BIGINT,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE
);