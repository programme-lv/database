ALTER TABLE IF EXISTS public.markdown_statements
    ADD COLUMN task_version_id bigint REFERENCES public.task_versions (id);
