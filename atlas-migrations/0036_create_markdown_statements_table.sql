CREATE TABLE markdown_statements (
    id BIGSERIAL PRIMARY KEY,
    story TEXT NOT NULL,
    input TEXT NOT NULL,
    output TEXT NOT NULL,
    notes TEXT,
    scoring TEXT
);
