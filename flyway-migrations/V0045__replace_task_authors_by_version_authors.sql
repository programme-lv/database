DROP TABLE task_authors;

CREATE TABLE version_authors (
    task_version_id int NOT NULL,
    author TEXT NOT NULL,
    PRIMARY KEY (task_version_id, author),
    FOREIGN KEY (task_version_id) REFERENCES task_versions (id)
);
