-- Add new schema named "atlas_schema_revisions"
CREATE SCHEMA "atlas_schema_revisions";
-- Create "flyway_schema_history" table
CREATE TABLE "public"."flyway_schema_history" ("installed_rank" integer NOT NULL, "version" character varying(50) NULL, "description" character varying(200) NOT NULL, "type" character varying(20) NOT NULL, "script" character varying(1000) NOT NULL, "checksum" integer NULL, "installed_by" character varying(100) NOT NULL, "installed_on" timestamp NOT NULL DEFAULT now(), "execution_time" integer NOT NULL, "success" boolean NOT NULL, PRIMARY KEY ("installed_rank"));
-- Create index "flyway_schema_history_s_idx" to table: "flyway_schema_history"
CREATE INDEX "flyway_schema_history_s_idx" ON "public"."flyway_schema_history" ("success");
-- Create "atlas_schema_revisions" table
CREATE TABLE "atlas_schema_revisions"."atlas_schema_revisions" ("version" character varying NOT NULL, "description" character varying NOT NULL, "type" bigint NOT NULL DEFAULT 2, "applied" bigint NOT NULL DEFAULT 0, "total" bigint NOT NULL DEFAULT 0, "executed_at" timestamptz NOT NULL, "execution_time" bigint NOT NULL, "error" text NULL, "error_stmt" text NULL, "hash" character varying NOT NULL, "partial_hashes" jsonb NULL, "operator_version" character varying NOT NULL, PRIMARY KEY ("version"));
