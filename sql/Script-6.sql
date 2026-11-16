create table if not exists doctors(
    doctor_id integer,
    clinic_id integer,
    first_name text,
    last_name text,
    specialization text,
    email text,
    department text
);

create sequence if not exists doctors_s increment by 1 start with 1 minvalue 1 maxvalue 999;


truncate table doctors;
alter sequence doctors_s restart with 1;


create or replace procedure create_new_doctors(
    p_clinic_id integer,
    p_doctors_firstname text,
    p_doctors_lastname text,
    p_specialization text,
    p_email text,
    p_department text
)
language sql
as $$
    insert into doctors(doctor_id, clinic_id, first_name, last_name, specialization, email, department)
    values (nextval('doctors_s'), p_clinic_id, p_doctors_firstname, p_doctors_lastname, p_specialization, p_email, p_department)
$$;


call create_new_doctors(1, 'Ivan', 'Sokolov', 'Surgeon', 'sokolov@mail.ru', 'Surgery');
call create_new_doctors(1, 'Elena', 'Morozova', 'Therapist', 'morozova@mail.ru', 'Therapy');
call create_new_doctors(2, 'Dmitry', 'Volkov', 'Cardiologist', 'volkov@mail.ru', 'Cardiology');


select * from doctors;