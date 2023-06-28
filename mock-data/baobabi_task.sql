INSERT INTO task_sources(abbreviation, full_name, event_description) VALUES
('ProblemCon','ProblemCon++','Programmēšanas sacensības un hakatons.');

INSERT INTO tasks(id, full_name, origin)
VALUES ('baobabi', 'Baobabi', 'ProblemCon');

INSERT INTO task_versions(version_name, task_id, time_lim_ms, mem_lim_kb, eval_type)
VALUES ('v1', 'baobabi', 1000, 262144, 'simple');

INSERT INTO task_authors(task_id, author) VALUES
('baobabi', 'KrisjanisP'),
('baobabi', 'KPetrucena');