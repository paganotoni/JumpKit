-- 20230623155332 - add_company_tables migration
CREATE TABLE companies (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE company_users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    company_id uuid NOT NULL,
    user_id uuid NOT NULL,

    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES companies(id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
);