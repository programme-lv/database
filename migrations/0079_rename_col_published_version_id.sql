ALTER TABLE tasks DROP CONSTRAINT "tasks_published_version_id_fkey";
ALTER TABLE tasks RENAME COLUMN published_version_id TO stable_version_id;
ALTER TABLE tasks ADD CONSTRAINT "tasks_stable_version_fkey" FOREIGN KEY (stable_version_id) REFERENCES task_versions(id);
