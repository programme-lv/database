CREATE TABLE task_versions (
    id BIGSERIAL PRIMARY KEY,
    version_name TEXT NOT NULL,

    task_id BIGINT NOT NULL REFERENCES tasks,

    short_code TEXT UNIQUE NOT NULL,
    full_name TEXT UNIQUE NOT NULL,

    time_lim_ms BIGINT NOT NULL,
    mem_lim_kb BIGINT NOT NULL,

    eval_type TEXT NOT NULL REFERENCES eval_types,

    origin TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE,

    CONSTRAINT task_versions_task_id_version_name_unique UNIQUE (task_id, version_name)
);

