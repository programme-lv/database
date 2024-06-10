ALTER TABLE submission_evaluations
ALTER COLUMN total_time_ms SET DEFAULT 0,
ALTER COLUMN total_time_ms SET NOT NULL,
ALTER COLUMN total_memory_kb SET DEFAULT 0,
ALTER COLUMN total_memory_kb SET NOT NULL,
ALTER COLUMN eval_total_score SET DEFAULT 0,
ALTER COLUMN eval_total_score SET NOT NULL,
ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN created_at SET NOT NULL,
ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE submission_evaluations
ADD COLUMN total_score_possible bigint NULL;
