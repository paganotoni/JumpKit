-- 20230812162158 - creating_signatures_database_structure migratio
CREATE TABLE document_signer_requests (
    id uuid NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    document_id uuid NOT NULL,
    user_id uuid NOT NULL,
    complete boolean NOT NULL,
    color text NOT NULL,
    created_at timestamp NOT NULL DEFAULT now()
);

CREATE TABLE document_signer_request_signatures (
    id uuid NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),
    document_signer_request_id uuid NOT NULL,
    x_coordinate numeric NOT NULL,
    y_coordinate numeric NOT NULL,
    page integer NOT NULL,
    image text NULL,
    created_at timestamp NOT NULL DEFAULT now()
)