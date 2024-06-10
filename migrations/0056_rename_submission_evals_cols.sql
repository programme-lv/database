ALTER TABLE submission_evaluations
RENAME COLUMN total_time_ms TO test_total_time_ms;
ALTER TABLE submission_evaluations
RENAME COLUMN total_memory_kb TO test_total_memory_kb;
