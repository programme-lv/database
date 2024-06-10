CREATE TABLE published_task_codes (
    task_code VARCHAR(255) PRIMARY KEY,
    task_id INTEGER NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id)
);
