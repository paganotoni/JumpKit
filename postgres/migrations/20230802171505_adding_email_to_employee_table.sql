-- 20230802171505 - adding_email_to_employee_table migration
ALTER TABLE employees ADD COLUMN email text;
UPDATE employees SET email = ab.email FROM (SELECT employees.id,people.email FROM people JOIN employees ON employees.person_id = people.id) as ab WHERE ab.id = employees.id;
ALTER TABLE people DROP COLUMN email;