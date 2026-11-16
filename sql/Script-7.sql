-- 1. Создание таблицы и последовательности
create table if not exists appointments(
    appointment_id integer,
    patient_id integer,
    doctor_id integer,
    visit_type text,
    date_of_admission date
);

create sequence if not exists appointments_s increment by 1 start with 1 minvalue 1 maxvalue 999;

-- Очистка таблицы и сброс счетчика перед заполнением
truncate table appointments;
alter sequence appointments_s restart with 1;

-- 2. Создание процедуры
create or replace procedure create_new_appointments(
    p_patient_id integer,
    p_doctor_id integer,
    p_visit_type text,
    p_date_of_admission date
)
language sql
as $$
    insert into appointments(appointment_id, patient_id, doctor_id, visit_type, date_of_admission)
    values (nextval('appointments_s'), p_patient_id, p_doctor_id, p_visit_type, p_date_of_admission)
$$;

-- 3. Добавление 3 строк через процедуру
call create_new_appointments(1, 1, 'Primary', to_date('2026.11.10', 'YYYY.mm.dd'));
call create_new_appointments(2, 2, 'Secondary', to_date('2026.11.12', 'YYYY.mm.dd'));
call create_new_appointments(3, 3, 'Consultation', to_date('2026.11.15', 'YYYY.mm.dd'));

-- 4. Вывод результата
select * from appointments;