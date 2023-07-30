ALTER TABLE task_versions DROP COLUMN checker;
ALTER TABLE task_versions DROP COLUMN interactor;

ALTER TABLE task_versions ADD COLUMN
checker_text_id BIGINT REFERENCES text_files(id);

ALTER TABLE task_versions ADD COLUMN
interactor_text_id BIGINT REFERENCES text_files(id);
