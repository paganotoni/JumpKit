-- 20230810145407 - create_table_document_signature migration
CREATE TABLE document_signatures (
   id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    creator_id uuid NOT NULL,
    creator_ip text NOT NULL,
    filename text NOT NULL,
    name text NOT NULL,
    status text NOT NULL,
    hash bytea NOT NULL,
    signed_hash_encrypted bytea NULL,
    created_at timestamp NOT NULL DEFAULT now()
);