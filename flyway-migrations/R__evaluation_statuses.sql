DELETE FROM evaluation_statuses;
INSERT INTO evaluation_statuses
(id, description_en, description_lv, dev_notes)
VALUES
-- SUBMISSION SCOPE
('IQ', 'in queue', 'gaida rindā', '(submission)'),
('C', 'compiling', 'tiek kompilēts', '(submission)'),
('T', 'testing', 'tiek testēts', '(submission)'),
('F', 'finished', 'pabeigts', '(submission)'),
('CE', 'compilation error', 'kompilācijas kļūda', '(submission)'),
('RJ', 'rejected', 'noraidīts', '(submission)'),

-- TEST SCOPE
('AC', 'accepted', 'pieņemts', '(test)'),
('PT', 'partially correct', 'daļēji pareizi', '(test)'),

('WA', 'wrong answer', 'nepareiza atbilde', '(test)'),
('PE', 'presentation error', 'prezentācijas kļūda', '(test)'),

('TLE', 'time limit exceeded', 'laika limits pārsniegts', '(test)'),
('MLE', 'memory limit exceeded', 'atmiņas limits pārsniegts', '(test)'),
('ILE', 'idleness limit exceeded', 'darbības trūkums', '(test)'),

('IG', 'ignored', 'noignorēts', '(test)'),
('RE', 'runtime error', 'izpildes laika kļūda', '(test)'),

-- COMMON STATES
('SV', 'security violation', 'drošības pārkāpums', '(common)'),
('ISE', 'internal server error', 'iekšēja servera kļūda', '(common)');
