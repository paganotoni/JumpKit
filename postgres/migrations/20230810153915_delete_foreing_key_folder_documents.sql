-- 20230810153915 - delete_foreing_key_folder_documents migration
ALTER TABLE folder_documents DROP CONSTRAINT fk_document;
