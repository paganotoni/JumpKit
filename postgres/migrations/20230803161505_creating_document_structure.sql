-- 20230803161505 - creating_document_structure migration

CREATE TABLE documents (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    name text NOT NULL,
    filename text NOT NULL,
    access_for_employees boolean NOT NULL DEFAULT false,
    access_for text NOT NULL,
    created_at timestamp NOT NULL DEFAULT now()
);  

CREATE TABLE employee_documents (
    document_id uuid NOT NULL,
    employee_id uuid NOT NULL,
    created_at timestamp NOT NULL DEFAULT now(),
    CONSTRAINT pk_document_employee PRIMARY KEY (document_id, employee_id),
    CONSTRAINT fk_document FOREIGN KEY (document_id) REFERENCES documents(id),
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE tags (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    name text NOT NULL,
    company_id uuid NOT NULL REFERENCES companies(id)
);

CREATE TABLE tagged_elements(
    tag_id uuid NOT NULL,
    element_id uuid NOT NULL,
    CONSTRAINT pk_tagged_element PRIMARY KEY (tag_id, element_id),
    CONSTRAINT fk_tag FOREIGN KEY (tag_id) REFERENCES tags(id)
);

CREATE TABLE folder_documents(
    folder_id uuid NOT NULL,
    document_id uuid NOT NULL,
    CONSTRAINT pk_folder_document PRIMARY KEY (folder_id, document_id),
    CONSTRAINT fk_folder FOREIGN KEY (folder_id) REFERENCES folders(id),
    CONSTRAINT fk_document FOREIGN KEY (document_id) REFERENCES documents(id)
);
