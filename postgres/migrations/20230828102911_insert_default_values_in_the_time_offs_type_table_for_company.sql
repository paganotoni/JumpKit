-- 20230828102911 - insert_default_values_in_the_time_offs_type_table_for_company migration
do
$$
    declare
        f record;
    begin
        for f in 
            SELECT
                id
            FROM
                companies 
        loop 
        
        INSERT INTO time_off_types (
            id,
            name,
            description,
            required_document,
            company_id,
            created_at
        )
        VALUES
        (uuid_generate_v4(), 'Personal Bussines Leave', 'Short time-offs during the work time.', false, f.id, CURRENT_DATE),
        (uuid_generate_v4(), 'Vacations', 'Paid time-offs of one or more days for the employee.', true, f.id, CURRENT_DATE),
        (uuid_generate_v4(), 'Sick Leave', 'Time-off from work permitted because of illness.', true, f.id, CURRENT_DATE);
        end loop;
    end;
$$;