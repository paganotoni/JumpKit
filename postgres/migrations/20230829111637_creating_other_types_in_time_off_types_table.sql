-- 20230829111637 - creating_other_types_in_time_off_types_table migration

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
            active,
            created_at
        )
        VALUES
        (uuid_generate_v4(), 'Parental Leave', 'Time-off to care for a child following its birth or adoption.', false, f.id, false, CURRENT_DATE),
        (uuid_generate_v4(), 'Compensatory Days', 'Paid time off to balance out hours worked.', false, f.id, false, CURRENT_DATE),
        (uuid_generate_v4(), 'Unpaid Days', 'Time-off from the job without receiving pay.', false, f.id, false, CURRENT_DATE);
        end loop;
    end;
$$;