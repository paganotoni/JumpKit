-- 20230803105711 - updating_user_rgister migration

UPDATE 
    users 
SET 
    role = 'admin', 
    active = 'TRUE'
WHERE 
    role IS NULL 
AND 
    active IS NULL;