DELETE FROM evaluation_statuses;
INSERT INTO evaluation_statuses (id, description_en, description_lv)
VALUES 
('IQS', 'in queue state', 'gaida rindā'),
('ICS', 'in compilation state', 'tiek kompilēts'),
('ITS', 'in testing state', 'tiek testēts'),
('AC', 'accepted', 'pieņemts'),
('PT', 'partially correct', 'daļēji pareizi'),
('WA', 'wrong answer', 'nepareiza atbilde'),
('RE', 'runtime error', 'izpildes laika kļūda'),
('PE', 'presentation error', 'prezentācijas kļūda'),
('TLE', 'time limit exceeded', 'laika limits pārsniegts'),
('MLE', 'memory limit exceeded', 'atmiņas limits pārsniegts'),
('ILE', 'idleness limit exceeded', 'darbības trūkums'),
('CE', 'compilation error', 'kompilācijas kļūda'),
('ISE', 'internal server error', 'iekšēja servera kļūda'),
('SV', 'security violation', 'drošības pārkāpums'),
('IG', 'ignored', 'noignorēts'),
('RJ', 'rejected', 'noraidīts');
