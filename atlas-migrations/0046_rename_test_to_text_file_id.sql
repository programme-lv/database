ALTER TABLE task_version_tests
    RENAME COLUMN input_test_file_id TO input_text_file_id;
ALTER TABLE task_version_tests
    RENAME COLUMN answer_test_file_id TO answer_text_file_id;
