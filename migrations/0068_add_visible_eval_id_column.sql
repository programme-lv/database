alter table task_submissions
    add visible_eval_id bigint references evaluations;
