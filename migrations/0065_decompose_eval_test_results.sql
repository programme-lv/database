drop table evaluation_test_results;
create table evaluation_test_results (
    id bigserial primary key,
    evaluation_id bigint not null references evaluations,
    eval_status_id text not null references evaluation_statuses,
    task_v_test_id bigint not null references task_version_tests,
    exec_r_data_id bigint null references runtime_data,
    checker_r_data_id bigint null references runtime_data
);
