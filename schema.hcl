table "atlas_schema_revisions" {
  schema = schema.public
  column "version" {
    null = false
    type = character_varying
  }
  column "description" {
    null = false
    type = character_varying
  }
  column "type" {
    null    = false
    type    = bigint
    default = 2
  }
  column "applied" {
    null    = false
    type    = bigint
    default = 0
  }
  column "total" {
    null    = false
    type    = bigint
    default = 0
  }
  column "executed_at" {
    null = false
    type = timestamptz
  }
  column "execution_time" {
    null = false
    type = bigint
  }
  column "error" {
    null = true
    type = text
  }
  column "error_stmt" {
    null = true
    type = text
  }
  column "hash" {
    null = false
    type = character_varying
  }
  column "partial_hashes" {
    null = true
    type = jsonb
  }
  column "operator_version" {
    null = false
    type = character_varying
  }
  primary_key {
    columns = [column.version]
  }
}
table "evaluation_statuses" {
  schema = schema.public
  column "id" {
    null = false
    type = text
  }
  column "description_en" {
    null = false
    type = text
  }
  column "description_lv" {
    null = false
    type = text
  }
  column "dev_notes" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.id]
  }
}
table "evaluation_test_results" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "evaluation_id" {
    null = false
    type = bigint
  }
  column "eval_status_id" {
    null = false
    type = text
  }
  column "task_v_test_id" {
    null = false
    type = bigint
  }
  column "exec_r_data_id" {
    null = true
    type = bigint
  }
  column "checker_r_data_id" {
    null = true
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "evaluation_test_results_checker_r_data_id_fkey" {
    columns     = [column.checker_r_data_id]
    ref_columns = [table.runtime_data.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluation_test_results_eval_status_id_fkey" {
    columns     = [column.eval_status_id]
    ref_columns = [table.evaluation_statuses.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluation_test_results_evaluation_id_fkey" {
    columns     = [column.evaluation_id]
    ref_columns = [table.evaluations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluation_test_results_exec_r_data_id_fkey" {
    columns     = [column.exec_r_data_id]
    ref_columns = [table.runtime_data.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluation_test_results_task_v_test_id_fkey" {
    columns     = [column.task_v_test_id]
    ref_columns = [table.test_set_tests.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "evaluations" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "eval_status_id" {
    null = false
    type = text
  }
  column "eval_total_score" {
    null    = false
    type    = bigint
    default = 0
  }
  column "eval_possible_score" {
    null = true
    type = bigint
  }
  column "test_runtime_statistics_id" {
    null = true
    type = bigint
  }
  column "compilation_data_id" {
    null = true
    type = bigint
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  column "task_version_id" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "evaluations_compilation_data_id_fkey" {
    columns     = [column.compilation_data_id]
    ref_columns = [table.runtime_data.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluations_eval_status_id_fkey" {
    columns     = [column.eval_status_id]
    ref_columns = [table.evaluation_statuses.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluations_task_version_id_fkey" {
    columns     = [column.task_version_id]
    ref_columns = [table.task_versions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "evaluations_test_runtime_statistics_id_fkey" {
    columns     = [column.test_runtime_statistics_id]
    ref_columns = [table.runtime_statistics.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "example_sets" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "created_at" {
    null    = false
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "markdown_statements" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "story" {
    null = false
    type = text
  }
  column "input" {
    null = false
    type = text
  }
  column "output" {
    null = false
    type = text
  }
  column "notes" {
    null = true
    type = text
  }
  column "scoring" {
    null = true
    type = text
  }
  column "lang_iso639_1" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.id]
  }
}
table "problem_tags" {
  schema = schema.public
  column "id" {
    null = false
    type = text
  }
  column "created_at" {
    null = true
    type = timestamptz
  }
  column "updated_at" {
    null = true
    type = timestamptz
  }
  column "color_rgb_hex" {
    null = true
    type = text
  }
  column "description_lv" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  check "tags_color_rgb_hex_check" {
    expr = "(color_rgb_hex ~* '^#[0-9a-f]{6}$'::text)"
  }
}
table "programming_languages" {
  schema = schema.public
  column "id" {
    null = false
    type = text
  }
  column "full_name" {
    null = false
    type = text
  }
  column "code_filename" {
    null = false
    type = text
  }
  column "compile_cmd" {
    null = true
    type = text
  }
  column "execute_cmd" {
    null = false
    type = text
  }
  column "env_version_cmd" {
    null = true
    type = text
  }
  column "hello_world_code" {
    null = true
    type = text
  }
  column "monaco_id" {
    null = true
    type = text
  }
  column "compiled_filename" {
    null = true
    type = text
  }
  column "enabled" {
    null    = false
    type    = boolean
    default = false
  }
  primary_key {
    columns = [column.id]
  }
  unique "programming_languages_full_name_key" {
    columns = [column.full_name]
  }
}
table "published_task_codes" {
  schema = schema.public
  column "task_code" {
    null = false
    type = character_varying(255)
  }
  column "task_id" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.task_code]
  }
  foreign_key "published_task_codes_task_id_fkey" {
    columns     = [column.task_id]
    ref_columns = [table.tasks.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "atlas_test" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "name" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.id]
  }
}
table "runtime_data" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "stdout" {
    null = true
    type = text
  }
  column "stderr" {
    null = true
    type = text
  }
  column "time_millis" {
    null = true
    type = bigint
  }
  column "memory_kibibytes" {
    null = true
    type = bigint
  }
  column "time_wall_millis" {
    null = true
    type = bigint
  }
  column "exit_code" {
    null = true
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
}
table "runtime_statistics" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "maximum_time_millis" {
    null    = false
    type    = bigint
    default = 0
  }
  column "maximum_memory_kibibytes" {
    null    = false
    type    = bigint
    default = 0
  }
  column "total_time_millis" {
    null    = false
    type    = bigint
    default = 0
  }
  column "total_memory_kibibytes" {
    null    = false
    type    = bigint
    default = 0
  }
  column "avg_time_millis" {
    null = false
    type = double_precision
  }
  column "avg_memory_kibibytes" {
    null = false
    type = double_precision
  }
  primary_key {
    columns = [column.id]
  }
}
table "statement_examples" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "input" {
    null = false
    type = text
  }
  column "answer" {
    null = false
    type = text
  }
  column "example_set_id" {
    null = false
    type = bigint
  }
  foreign_key "statement_examples_example_set_id_fkey" {
    columns     = [column.example_set_id]
    ref_columns = [table.example_sets.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "submission_evaluations" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "submission_id" {
    null = false
    type = bigint
  }
  column "evaluation_id" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "submission_evaluations_evaluation_id_fkey" {
    columns     = [column.evaluation_id]
    ref_columns = [table.evaluations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "submission_evaluations_submission_id_fkey" {
    columns     = [column.submission_id]
    ref_columns = [table.task_submissions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "task_origins" {
  schema = schema.public
  column "abbreviation" {
    null = false
    type = text
  }
  column "full_name" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.abbreviation]
  }
  check "task_sources_full_name_not_empty" {
    expr = "(full_name <> ''::text)"
  }
  unique "task_sources_full_name_unique" {
    columns = [column.full_name]
  }
}
table "task_submissions" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "user_id" {
    null = false
    type = bigint
  }
  column "task_id" {
    null = false
    type = bigint
  }
  column "programming_lang_id" {
    null = false
    type = text
  }
  column "submission" {
    null = false
    type = text
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  column "hidden" {
    null    = false
    type    = boolean
    default = false
  }
  column "visible_eval_id" {
    null = true
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "task_submissions_programming_lang_id_fkey" {
    columns     = [column.programming_lang_id]
    ref_columns = [table.programming_languages.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_submissions_task_id_fkey" {
    columns     = [column.task_id]
    ref_columns = [table.tasks.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_submissions_user_id_fkey" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_submissions_visible_eval_id_fkey" {
    columns     = [column.visible_eval_id]
    ref_columns = [table.evaluations.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  check "submission" {
    expr = "(submission <> ''::text)"
  }
}
table "task_versions" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "task_id" {
    null = false
    type = bigint
  }
  column "short_code" {
    null = false
    type = text
  }
  column "full_name" {
    null = false
    type = text
  }
  column "time_lim_ms" {
    null = false
    type = bigint
  }
  column "mem_lim_kibibytes" {
    null = false
    type = bigint
  }
  column "testing_type_id" {
    null = false
    type = text
  }
  column "origin" {
    null = true
    type = text
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  column "checker_id" {
    null = true
    type = bigint
  }
  column "interactor_id" {
    null = true
    type = bigint
  }
  column "md_statement_id" {
    null = true
    type = bigint
  }
  column "example_set_id" {
    null = true
    type = bigint
  }
  column "test_set_id" {
    null = true
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "fk_statement_id" {
    columns     = [column.md_statement_id]
    ref_columns = [table.markdown_statements.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "fk_task_versions_example_set_id" {
    columns     = [column.example_set_id]
    ref_columns = [table.example_sets.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "fk_task_versions_test_set_id" {
    columns     = [column.test_set_id]
    ref_columns = [table.test_set_tests.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_versions_checker_id_fkey" {
    columns     = [column.checker_id]
    ref_columns = [table.testlib_checkers.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_versions_eval_type_fkey" {
    columns     = [column.testing_type_id]
    ref_columns = [table.testing_types.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_versions_interactor_id_fkey" {
    columns     = [column.interactor_id]
    ref_columns = [table.testlib_interactors.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_versions_task_id_fkey" {
    columns     = [column.task_id]
    ref_columns = [table.tasks.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "tasks" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  column "created_by_id" {
    null = false
    type = bigint
  }
  column "current_version_id" {
    null = true
    type = bigint
  }
  column "stable_version_id" {
    null = true
    type = bigint
  }
  column "deleted_at" {
    null = true
    type = timestamp
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "tasks_created_by_fkey" {
    columns     = [column.created_by_id]
    ref_columns = [table.users.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "tasks_current_version_fkey" {
    columns     = [column.current_version_id]
    ref_columns = [table.task_versions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "tasks_stable_version_fkey" {
    columns     = [column.stable_version_id]
    ref_columns = [table.task_versions.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_set_tests" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "test_filename" {
    null = false
    type = text
  }
  column "test_set_id" {
    null = false
    type = bigint
  }
  column "input_text_file_id" {
    null = false
    type = bigint
  }
  column "answer_text_file_id" {
    null = false
    type = bigint
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "task_version_tests_answer_test_file_id_fkey" {
    columns     = [column.answer_text_file_id]
    ref_columns = [table.text_files.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_version_tests_input_test_file_id_fkey" {
    columns     = [column.input_text_file_id]
    ref_columns = [table.text_files.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "task_version_tests_test_set_id_fkey" {
    columns     = [column.test_set_id]
    ref_columns = [table.test_sets.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "test_sets" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "created_at" {
    null    = false
    type    = timestamp
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.id]
  }
}
table "testing_types" {
  schema = schema.public
  column "id" {
    null = false
    type = text
  }
  column "description_en" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.id]
  }
}
table "testlib_checkers" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "code" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  unique "testlib_checkers_code_key" {
    columns = [column.code]
  }
}
table "testlib_interactors" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "code" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.id]
  }
  unique "testlib_interactors_code_key" {
    columns = [column.code]
  }
}
table "text_files" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "sha256" {
    null = false
    type = text
  }
  column "content" {
    null = true
    type = text
  }
  column "created_at" {
    null    = true
    type    = timestamptz
    default = sql("now()")
  }
  column "compression" {
    null    = false
    type    = text
    default = "raw"
  }
  primary_key {
    columns = [column.id]
  }
  unique "test_files_sha256_key" {
    columns = [column.sha256]
  }
}
table "users" {
  schema = schema.public
  column "id" {
    null = false
    type = bigserial
  }
  column "username" {
    null = false
    type = text
  }
  column "email" {
    null = false
    type = text
  }
  column "hashed_password" {
    null = false
    type = text
  }
  column "first_name" {
    null = false
    type = text
  }
  column "last_name" {
    null = false
    type = text
  }
  column "created_at" {
    null    = false
    type    = timestamptz
    default = sql("now()")
  }
  column "updated_at" {
    null = true
    type = timestamptz
  }
  column "is_admin" {
    null    = false
    type    = boolean
    default = false
  }
  primary_key {
    columns = [column.id]
  }
  unique "users_email_key" {
    columns = [column.email]
  }
  unique "users_username_key" {
    columns = [column.username]
  }
}
function "update_updated_at" {
  schema = schema.public
  lang   = PLpgSQL
  return = trigger
  as     = <<-SQL
  BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
  END;
  SQL
}
trigger "users_updated_at_trigger" {
  on = table.users
  after {
    update = true
  }
  for = ROW
  execute {
    function = function.update_updated_at
  }
}
schema "public" {
  comment = "standard public schema"
}
