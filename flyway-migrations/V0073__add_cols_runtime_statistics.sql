alter table runtime_statistics
    add avg_time_millis bigint not null;

alter table runtime_statistics
    add avg_memory_kibibytes bigint not null;