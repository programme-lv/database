ALTER TABLE tasks DROP CONSTRAINT "tasks_relevant_version_fkey";
ALTER TABLE tasks RENAME COLUMN relevant_version_id TO current_version_id;
ALTER TABLE tasks ADD CONSTRAINT "tasks_current_version_fkey" FOREIGN KEY (current_version_id) REFERENCES task_versions(id);
