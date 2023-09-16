-- 20230829165849 - adding_order_to_document_signer_requests_table migration
ALTER TABLE document_signer_requests ADD COLUMN "order" integer;

DELETE FROM document_signer_requests;
DELETE FROM document_signer_request_signatures;
DELETE FROM document_signatures;
