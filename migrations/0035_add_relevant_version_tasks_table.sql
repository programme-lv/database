ALTER TABLE tasks
ADD COLUMN relevant_version BIGINT;
ALTER TABLE tasks
ADD CONSTRAINT tasks_relevant_version_fkey FOREIGN KEY (relevant_version)
REFERENCES task_versions (id);
