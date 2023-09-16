-- 20230710105501 - custom_fields_table migration

CREATE TABLE custom_fields (
    id uuid NOT NULL DEFAULT uuid_generate_v4() PRIMARY KEY,
    company_id uuid NOT NULL,

    name varchar(255) NOT NULL,
    type text NULL,
    label text NULL,
    placeholder text NULL,
    visibility text NULL,
    supporting_text text NULL,
    new_tags_allowed boolean NOT NULL DEFAULT false,

    CONSTRAINT fk_company FOREIGN KEY(company_id) REFERENCES companies(id)
);

CREATE TABLE employee_custom_field_values (
    id uuid NOT NULL DEFAULT uuid_generate_v4() PRIMARY KEY,
    custom_field_id uuid NOT NULL,
    employee_id uuid NOT NULL,
    value text NULL,

    CONSTRAINT fk_custom_field FOREIGN KEY(custom_field_id) REFERENCES custom_fields(id),
    CONSTRAINT fk_employee FOREIGN KEY(employee_id) REFERENCES employees(id)
);


CREATE TABLE custom_field_options (
    id uuid NOT NULL DEFAULT uuid_generate_v4() PRIMARY KEY,
    custom_field_id uuid NOT NULL,
    value text NOT NULL,
    "default" boolean NOT NULL DEFAULT false,

    CONSTRAINT fk_custom_field FOREIGN KEY(custom_field_id) REFERENCES custom_fields(id)
);