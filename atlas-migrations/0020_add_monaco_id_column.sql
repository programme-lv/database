ALTER TABLE programming_languages ADD COLUMN monaco_id TEXT;
UPDATE programming_languages SET monaco_id = 'cpp' WHERE id = 'cpp17';
UPDATE programming_languages SET monaco_id = 'python' WHERE id = 'python3.10';
UPDATE programming_languages SET monaco_id = 'java' WHERE id = 'java18';
