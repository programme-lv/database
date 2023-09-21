DELETE FROM evaluation_statuses;
INSERT INTO evaluation_statuses (id, description_en, description_lv)
VALUES
-- SUBMISSION SCOPE
('IQ', 'in queue', 'gaida rindā'),
('C', 'compiling', 'tiek kompilēts'),
('T', 'testing', 'tiek testēts'),
('F', 'finished', 'pabeigts'),
('CE', 'compilation error', 'kompilācijas kļūda'),
('SV', 'security violation', 'drošības pārkāpums'),
('RJ', 'rejected', 'noraidīts'),

-- TEST SCOPE
('AC', 'accepted', 'pieņemts'),
('PT', 'partially correct', 'daļēji pareizi'),

('WA', 'wrong answer', 'nepareiza atbilde'),
('PE', 'presentation error', 'prezentācijas kļūda'),

('TLE', 'time limit exceeded', 'laika limits pārsniegts'),
('MLE', 'memory limit exceeded', 'atmiņas limits pārsniegts'),
('ILE', 'idleness limit exceeded', 'darbības trūkums'),

('IG', 'ignored', 'noignorēts'),

-- COMMON STATES
('RE', 'runtime error', 'izpildes laika kļūda'),
('ISE', 'internal server error', 'iekšēja servera kļūda');
