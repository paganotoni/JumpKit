-- 20230828103727 - create_time_offs_table migration

CREATE TABLE time_offs (
    id UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    type_id UUID NOT NULL,
    employee_id UUID NOT NULL,
    since TIMESTAMP NOT NULL,
    until TIMESTAMP NOT NULL,
    work_days_off INTEGER NOT NULL,
    file_name TEXT,
    notes TEXT NOT NULL,
    status TEXT NOT NULL,
    company_id UUID NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_type FOREIGN KEY (type_id) REFERENCES time_off_types(id),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES employees(id),
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES companies(id)
);
