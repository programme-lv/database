CREATE TABLE task_authors (
    task_id TEXT NOT NULL,
    author TEXT NOT NULL,
    CONSTRAINT task_authors_author_not_empty CHECK (author <> ''),
    CONSTRAINT task_authors_task_id_author_unique UNIQUE (task_id, author),
    CONSTRAINT fk_task_authors_tasks FOREIGN KEY (task_id) REFERENCES tasks
);