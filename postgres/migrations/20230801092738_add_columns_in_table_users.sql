-- 20230801092738 - add_columns_in_table_users migration

ALTER TABLE users 
    ADD role text NULL,
    ADD active boolean NULL 