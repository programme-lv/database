alter table runtime_data
    alter column exit_code type bigint using exit_code::bigint;
