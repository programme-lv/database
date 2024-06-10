-- Add new schema named "atlas_schema_revisions"
CREATE SCHEMA "atlas_schema_revisions";
-- Modify "task_versions" table
ALTER TABLE "public"."task_versions" DROP COLUMN "md_statement_id", DROP COLUMN "example_set_id", DROP COLUMN "test_set_id", ADD COLUMN "updated_at" timestamptz NULL;
-- Create "atlas_schema_revisions" table
CREATE TABLE "atlas_schema_revisions"."atlas_schema_revisions" ("version" character varying NOT NULL, "description" character varying NOT NULL, "type" bigint NOT NULL DEFAULT 2, "applied" bigint NOT NULL DEFAULT 0, "total" bigint NOT NULL DEFAULT 0, "executed_at" timestamptz NOT NULL, "execution_time" bigint NOT NULL, "error" text NULL, "error_stmt" text NULL, "hash" character varying NOT NULL, "partial_hashes" jsonb NULL, "operator_version" character varying NOT NULL, PRIMARY KEY ("version"));
-- Create "flyway_schema_history" table
CREATE TABLE "public"."flyway_schema_history" ("installed_rank" integer NOT NULL, "version" character varying(50) NULL, "description" character varying(200) NOT NULL, "type" character varying(20) NOT NULL, "script" character varying(1000) NOT NULL, "checksum" integer NULL, "installed_by" character varying(100) NOT NULL, "installed_on" timestamp NOT NULL DEFAULT now(), "execution_time" integer NOT NULL, "success" boolean NOT NULL, PRIMARY KEY ("installed_rank"));
-- Create index "flyway_schema_history_s_idx" to table: "flyway_schema_history"
CREATE INDEX "flyway_schema_history_s_idx" ON "public"."flyway_schema_history" ("success");
-- Modify "statement_examples" table
ALTER TABLE "public"."statement_examples" DROP COLUMN "example_set_id", ADD COLUMN "task_version_id" bigint NOT NULL, ADD CONSTRAINT "statement_examples_task_version_id_fkey" FOREIGN KEY ("task_version_id") REFERENCES "public"."task_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Modify "markdown_statements" table
ALTER TABLE "public"."markdown_statements" ADD COLUMN "task_version_id" bigint NULL, ADD CONSTRAINT "markdown_statements_task_version_id_fkey" FOREIGN KEY ("task_version_id") REFERENCES "public"."task_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Modify "text_files" table
ALTER TABLE "public"."text_files" ALTER COLUMN "content" SET NOT NULL, DROP COLUMN "compression";
-- Create "task_version_tests" table
CREATE TABLE "public"."task_version_tests" ("id" bigserial NOT NULL, "test_filename" text NOT NULL, "task_version_id" bigint NOT NULL, "input_text_file_id" bigint NOT NULL, "answer_text_file_id" bigint NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "task_version_tests_answer_test_file_id_fkey" FOREIGN KEY ("answer_text_file_id") REFERENCES "public"."text_files" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "task_version_tests_input_test_file_id_fkey" FOREIGN KEY ("input_text_file_id") REFERENCES "public"."text_files" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, CONSTRAINT "task_version_tests_task_version_id_fkey" FOREIGN KEY ("task_version_id") REFERENCES "public"."task_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- Modify "tasks" table
ALTER TABLE "public"."tasks" DROP CONSTRAINT "tasks_current_version_fkey", DROP COLUMN "stable_version_id", DROP COLUMN "deleted_at", ADD COLUMN "published_version_id" integer NULL, ADD CONSTRAINT "tasks_published_version_id_fkey" FOREIGN KEY ("published_version_id") REFERENCES "public"."task_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION, ADD CONSTRAINT "tasks_relevant_version_fkey" FOREIGN KEY ("relevant_version_id") REFERENCES "public"."task_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Rename a column from "current_version_id" to "relevant_version_id"
ALTER TABLE "public"."tasks" RENAME COLUMN "current_version_id" TO "relevant_version_id";
-- Create "version_authors" table
CREATE TABLE "public"."version_authors" ("task_version_id" integer NOT NULL, "author" text NOT NULL, PRIMARY KEY ("task_version_id", "author"), CONSTRAINT "version_authors_task_version_id_fkey" FOREIGN KEY ("task_version_id") REFERENCES "public"."task_versions" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION);
-- Drop "published_task_codes" table
DROP TABLE "public"."published_task_codes";
-- Drop "example_sets" table
DROP TABLE "public"."example_sets";
-- Drop "test_set_tests" table
DROP TABLE "public"."test_set_tests";
-- Drop "test_sets" table
DROP TABLE "public"."test_sets";
