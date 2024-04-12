BEGIN;

ALTER TABLE tasks
ADD COLUMN deleted_at TIMESTAMP;

UPDATE tasks
SET deleted_at = CASE 
                    WHEN deleted THEN CURRENT_TIMESTAMP 
                    ELSE NULL 
                 END;

ALTER TABLE tasks
DROP COLUMN deleted;

COMMIT;
