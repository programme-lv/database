ALTER TABLE task_versions
DROP COLUMN checker_text_id;

ALTER TABLE task_versions
DROP COLUMN interactor_text_id;

ALTER TABLE task_versions
ADD COLUMN checker_id BIGINT REFERENCES testlib_checkers;

ALTER TABLE task_versions
ADD COLUMN interactor_id BIGINT REFERENCES testlib_interactors;
