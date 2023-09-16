-- 20230816113334 - updating_documents_tables migration

ALTER TABLE documents ADD COLUMN company_id uuid;
ALTER TABLE document_signatures ADD COLUMN company_id uuid;

ALTER TABLE documents ADD CONSTRAINT documents_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id);
ALTER TABLE document_signatures ADD CONSTRAINT document_signatures_company_id_fkey FOREIGN KEY (company_id) REFERENCES companies(id);


UPDATE documents SET company_id = (
    SELECT folders.company_id 
    FROM folders
    JOIN folder_documents ON folder_documents.folder_id = folders.id
    WHERE folder_documents.document_id = documents.id
);


UPDATE document_signatures SET company_id = (
    SELECT folders.company_id 
    FROM folders
    JOIN folder_documents ON folder_documents.folder_id = folders.id
    WHERE folder_documents.document_id = document_signatures.id
);


DROP TABLE folder_documents;
DROP TABLE folders;