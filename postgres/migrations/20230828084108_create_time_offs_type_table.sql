-- 20230828084108 - create_time_offs_type_table migration

CREATE TABLE time_off_types (
    id UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    required_document BOOLEAN NOT NULL,
    company_id UUID NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES companies(id)
);
