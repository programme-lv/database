alter table runtime_statistics
    alter column avg_time_millis type double precision using avg_time_millis::double precision;

alter table runtime_statistics
    alter column avg_memory_kibibytes type double precision using avg_memory_kibibytes::double precision;