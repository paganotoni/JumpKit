-- 20230623135212 - add_users_table migration

CREATE TABLE IF NOT EXISTS people (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    person_id uuid NOT NULL,

    email text NOT NULL,
    locale text NOT NULL DEFAULT 'es',
    
    CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES people(id)
);
