ALTER TABLE markdown_statements
DROP COLUMN task_version_id;

ALTER TABLE task_versions
ADD COLUMN md_statement_id BIGINT;

ALTER TABLE task_versions
ADD CONSTRAINT fk_statement_id
FOREIGN KEY (md_statement_id) REFERENCES markdown_statements(id);
