CREATE TABLE task_versions (
    id BIGSERIAL PRIMARY KEY,
    version_name TEXT NOT NULL,

    task_id TEXT NOT NULL REFERENCES tasks,

    time_lim_ms BIGINT NOT NULL,
    mem_lim_kb BIGINT NOT NULL,

    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE,

    CONSTRAINT task_versions_task_id_version_name_unique UNIQUE (task_id, version_name)
);

