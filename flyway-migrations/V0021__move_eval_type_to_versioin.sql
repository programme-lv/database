ALTER TABLE tasks DROP COLUMN eval_type;

ALTER TABLE task_versions ADD COLUMN eval_type TEXT NOT NULL REFERENCES eval_types DEFAULT 'simple' NOT NULL;