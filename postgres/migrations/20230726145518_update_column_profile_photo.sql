-- 20230726145518 - update_column_profile_photo migration
ALTER TABLE people ALTER COLUMN profile_photo DROP NOT NULL;
UPDATE people SET profile_photo = NULLIF(profile_photo,'');