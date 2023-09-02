CREATE TABLE statement_examples (
	id BIGSERIAL NOT NULL,
	input TEXT NOT NULL,
	answer TEXT NOT NULL,
	task_version_id BIGINT NOT NULL REFERENCES task_versions
);
