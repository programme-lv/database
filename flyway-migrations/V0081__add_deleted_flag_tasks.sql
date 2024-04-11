ALTER TABLE IF EXISTS public.tasks
    ADD COLUMN deleted boolean NOT NULL DEFAULT false;