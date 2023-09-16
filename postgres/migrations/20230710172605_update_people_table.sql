-- 20230710172605 - update_people_table migration

ALTER TABLE people
  ADD email text,
  ADD birthdate timestamp,
  ADD address text,
  ADD phone_number numeric;