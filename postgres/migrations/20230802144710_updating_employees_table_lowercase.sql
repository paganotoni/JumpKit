-- 20230802144710 - updating_employees_table_lowercase migration

UPDATE 
    employees 
SET 
    payment_frequency = LOWER(payment_frequency), 
    employment_status = LOWER(employment_status), 
    employment_type = LOWER(employment_type);