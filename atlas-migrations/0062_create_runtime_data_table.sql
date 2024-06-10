create table runtime_data(
    id bigserial primary key,
    stdout text,
    stderr text,
    time_millis bigint,
    memory_kibibytes bigint,
    time_wall_millis bigint,
    exit_code integer
);
