-- 20230801113249 - add_column_until_employee migration

ALTER TABLE employees
  ADD until timestamp NULL;
