create table evaluations (
    id bigserial primary key,
    eval_status_id text not null references evaluation_statuses,
    eval_total_score bigint default 0 not null,
    eval_possible_score bigint null,
    test_runtime_statistics_id bigint null references runtime_statistics,
    compilation_data_id bigint null references runtime_data,
    created_at timestamp with time zone default CURRENT_TIMESTAMP not null
);