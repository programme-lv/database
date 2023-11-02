drop table submission_evaluations;

create table submission_evaluations(
    id bigserial primary key,
    submission_id bigint not null references task_submissions,
    evaluation_id bigint not null references evaluations
);