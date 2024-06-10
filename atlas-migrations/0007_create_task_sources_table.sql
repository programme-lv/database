CREATE TABLE task_sources (
    abbreviation TEXT PRIMARY KEY,
    full_name TEXT NOT NULL,
    event_description TEXT NOT NULL,
    CONSTRAINT task_sources_full_name_not_empty CHECK (full_name <> ''),
    CONSTRAINT task_sources_full_name_unique UNIQUE (full_name)
);
