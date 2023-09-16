-- 20230829111107 - adding_active_column_in_time_off_types_table migration
ALTER TABLE time_off_types 
ADD COLUMN active BOOLEAN DEFAULT TRUE;