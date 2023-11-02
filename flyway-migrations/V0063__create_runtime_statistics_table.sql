create table runtime_statistics (
    id bigserial primary key,
    maximum_time_millis bigint default 0 not null,
    maximum_memory_kibibytes bigint default 0 not null,
    total_time_millis bigint default 0 not null,
    total_memory_kibibytes bigint default 0 not null
);