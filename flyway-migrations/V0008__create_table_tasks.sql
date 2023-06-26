CREATE TABLE tasks (
    id TEXT PRIMARY KEY,
    full_name TEXT UNIQUE NOT NULL,
    origin TEXT NOT NULL REFERENCES task_sources,
    eval_type TEXT NOT NULL REFERENCES eval_types,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL
);