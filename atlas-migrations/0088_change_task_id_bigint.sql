ALTER TABLE public.published_task_codes ALTER COLUMN task_id TYPE int8 USING task_id::int8;
