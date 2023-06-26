CREATE TABLE task_submissions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users,
    task_id TEXT NOT NULL REFERENCES tasks,
    programming_lang_id TEXT NOT NULL REFERENCES programming_languages,
    submission TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    CONSTRAINT submission CHECK (submission <> '')
);