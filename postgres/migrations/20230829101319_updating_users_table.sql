-- 20230829101319 - updating_users_table migration

ALTER TABLE users ADD COLUMN notify_my_time_off_activity BOOLEAN NOT NULL DEFAULT TRUE;
ALTER TABLE users ADD COLUMN notify_time_off_requested BOOLEAN NOT NULL DEFAULT TRUE;
ALTER TABLE users ADD COLUMN notify_signatures_requested BOOLEAN NOT NULL DEFAULT TRUE;