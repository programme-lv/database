ALTER TABLE tasks ADD COLUMN published_version_id integer REFERENCES task_versions;
