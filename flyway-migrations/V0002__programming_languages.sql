CREATE TABLE programming_languages (
    id TEXT PRIMARY KEY,
    full_name TEXT NOT NULL UNIQUE,
    code_filename TEXT NOT NULL, -- how the submitted code should be named
    compile_cmd TEXT,
    execute_cmd TEXT NOT NULL,
    env_version_cmd TEXT -- command to get version of the compiler / interpreter
);