alter table task_submissions
    drop constraint task_submissions_programming_lang_id_fkey;
alter table task_submissions
    add foreign key (programming_lang_id) references programming_languages
        deferrable;
