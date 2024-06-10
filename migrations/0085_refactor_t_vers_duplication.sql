-- Step 1: Create the `test_sets` table
CREATE TABLE test_sets (
    id BIGSERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Step 2: Insert records into `test_sets` based on `task_version_id` from `task_version_tests`
INSERT INTO test_sets (id, created_at)
SELECT DISTINCT task_version_id, CURRENT_TIMESTAMP
FROM task_version_tests;
-- Step 3: Rename column `task_version_id` to `test_set_id` in `task_version_tests`
ALTER TABLE task_version_tests
RENAME COLUMN task_version_id TO test_set_id;
-- Step 4: Update the foreign key in `task_version_tests` to reference `test_sets`
ALTER TABLE task_version_tests
DROP CONSTRAINT IF EXISTS task_version_tests_task_version_id_fkey;
ALTER TABLE task_version_tests
ADD CONSTRAINT task_version_tests_test_set_id_fkey FOREIGN KEY (test_set_id) REFERENCES test_sets(id);
-- Step 5: Create the `example_sets` table
CREATE TABLE example_sets (
    id BIGSERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Step 6: Insert records into `example_sets` based on `task_version_id` from `statement_examples`
INSERT INTO example_sets (id, created_at)
SELECT DISTINCT task_version_id, CURRENT_TIMESTAMP
FROM statement_examples;
-- Step 7: Rename column `task_version_id` to `example_set_id` in `statement_examples`
ALTER TABLE statement_examples
RENAME COLUMN task_version_id TO example_set_id;
-- Step 8: Update the foreign key in `statement_examples` to reference `example_sets`
ALTER TABLE statement_examples
DROP CONSTRAINT IF EXISTS statement_examples_task_version_id_fkey;
ALTER TABLE statement_examples
ADD CONSTRAINT statement_examples_example_set_id_fkey FOREIGN KEY (example_set_id) REFERENCES example_sets(id);
