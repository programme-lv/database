CREATE TABLE programming_languages (
    id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    code_filename TEXT NOT NULL,
    compile_cmd TEXT,
    execute_cmd TEXT NOT NULL,
    CONSTRAINT programming_languages_pkey PRIMARY KEY (id),
    CONSTRAINT programming_languages_name_key UNIQUE (full_name)
);