alter table evaluations
    add task_version_id bigint not null references task_versions;
