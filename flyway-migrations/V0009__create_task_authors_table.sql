CREATE TABLE task_authors (
    task_id BIGINT NOT NULL REFERENCES tasks,
    author TEXT NOT NULL,
    CONSTRAINT task_authors_author_not_empty CHECK (author <> ''),
    CONSTRAINT task_authors_task_id_author_unique UNIQUE (task_id, author)
);
