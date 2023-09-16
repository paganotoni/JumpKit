-- 20230828135137 - creating_employees migration

INSERT INTO employees (id, company_id, person_id, job_title_id, manager_employee_id, salary, payment_frequency, employment_status, employment_type, since, until, email)
SELECT 
    uuid_generate_v4(),
    company_users.company_id, 
    users.person_id, 
    (SELECT job_titles.id FROM job_titles LIMIT 1),
    NULL, 
    0, 
    '', 
    '',
    '', 
    now(), 
    null, 
    users.email 
    FROM users 
JOIN 
    company_users ON company_users.user_id = users.id
WHERE users.person_id NOT IN (SELECT employees.person_id FROM employees);