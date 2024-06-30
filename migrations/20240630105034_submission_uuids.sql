-- Step 1: Add a temporary UUID column to task_submissions
ALTER TABLE task_submissions ADD COLUMN temp_uuid UUID;

-- Step 2: Populate the temporary UUID column with random UUIDs
UPDATE task_submissions SET temp_uuid = gen_random_uuid();

-- Step 3: Add a submission_uuid column to submission_evaluations
ALTER TABLE submission_evaluations ADD COLUMN submission_uuid UUID;

-- Step 4: Populate the submission_uuid column with the corresponding UUIDs
UPDATE submission_evaluations SET submission_uuid = ts.temp_uuid
FROM task_submissions ts
WHERE submission_evaluations.submission_id = ts.id;

-- Step 5: Remove foreign key constraints that reference the id column
ALTER TABLE submission_evaluations DROP CONSTRAINT submission_evaluations_submission_id_fkey;

-- Step 6: Drop the existing primary key constraint
ALTER TABLE task_submissions DROP CONSTRAINT task_submissions_pkey;

-- Step 7: Rename the old id column and set temp_uuid as the new primary key in task_submissions
ALTER TABLE task_submissions RENAME COLUMN id TO old_id;
ALTER TABLE task_submissions RENAME COLUMN temp_uuid TO id;

-- Step 8: Set the new id column as the primary key
ALTER TABLE task_submissions ADD PRIMARY KEY (id);

-- Step 9: Rename submission_uuid to submission_id in submission_evaluations
ALTER TABLE submission_evaluations RENAME COLUMN submission_id TO old_submission_id;
ALTER TABLE submission_evaluations RENAME COLUMN submission_uuid TO submission_id;

-- Step 10: Add the foreign key constraint back with the new UUID column
ALTER TABLE submission_evaluations ADD CONSTRAINT submission_evaluations_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES task_submissions(id);

-- Step 11: Drop the old id column in task_submissions
ALTER TABLE task_submissions DROP COLUMN old_id;

-- Step 12: Drop the old_submission_id column in submission_evaluations
ALTER TABLE submission_evaluations DROP COLUMN old_submission_id;
