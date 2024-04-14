-- Add column `example_set_id` to the table `task_versions`
ALTER TABLE task_versions
ADD COLUMN example_set_id BIGINT;

-- Add foreign key constraint to `example_set_id` referencing `example_sets(id)`
ALTER TABLE task_versions
ADD CONSTRAINT fk_task_versions_example_set_id
FOREIGN KEY (example_set_id) REFERENCES example_sets(id);

-- Add column `test_set_id` to the table `task_versions`
ALTER TABLE task_versions
ADD COLUMN test_set_id BIGINT;

-- Add foreign key constraint to `test_set_id` referencing `test_set_tests(id)`
ALTER TABLE task_versions
ADD CONSTRAINT fk_task_versions_test_set_id
FOREIGN KEY (test_set_id) REFERENCES test_set_tests(id);
