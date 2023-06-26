CREATE TABLE task_version_tests (
    id BIGSERIAL PRIMARY KEY,
    test_name TEXT NOT NULL,

    task_version_id BIGINT NOT NULL REFERENCES task_versions,
    input_test_file_id BIGINT NOT NULL REFERENCES test_files,
    answer_test_file_id BIGINT NOT NULL REFERENCES test_files
);