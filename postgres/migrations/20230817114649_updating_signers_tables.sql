-- 20230817114649 - updating_signers_tables migration

ALTER TABLE document_signer_request_signatures DROP COLUMN image;
ALTER TABLE document_signer_request_signatures ADD COLUMN signature_type text;

ALTER TABLE document_signer_requests ADD COLUMN opened_at timestamp with time zone;
ALTER TABLE document_signer_requests ADD COLUMN signed_at timestamp with time zone;
ALTER TABLE document_signer_requests ADD COLUMN ip_address text;
