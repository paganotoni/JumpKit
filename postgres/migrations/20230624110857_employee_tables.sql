-- 20230624110857 - employee_tables migration

CREATE TABLE job_titles (
    id uuid NOT NULL DEFAULT uuid_generate_v4() PRIMARY KEY,
    company_id uuid NOT NULL,

    name varchar(255) NOT NULL,
    description text NULL,

    CONSTRAINT fk_company FOREIGN KEY(company_id) REFERENCES companies(id)
);

CREATE TABLE employees (
    id uuid NOT NULL DEFAULT uuid_generate_v4() PRIMARY KEY,
    company_id uuid NOT NULL,
    person_id uuid NOT NULL,

    job_title_id uuid NULL,
    manager_employee_id uuid NULL,

    CONSTRAINT fk_company FOREIGN KEY(company_id)  REFERENCES companies(id),
    CONSTRAINT fk_people FOREIGN KEY(person_id)  REFERENCES people(id),
    CONSTRAINT fk_job_title FOREIGN KEY(job_title_id)  REFERENCES job_titles(id),
    CONSTRAINT fk_manager_id FOREIGN KEY(manager_employee_id)  REFERENCES employees(id)
);

