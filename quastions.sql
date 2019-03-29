use hospital;

/*Q1*/
/*SELECT patients.patient_id , patient_name, appointment_time FROM appointment 
inner join patients on appointment.patient_id = patients.patient_id
where appointment.doctor_id = 111111111
order by appointment_time;*/

/*Q2*/
/*
drop procedure enter_patient;
delimiter $$
create procedure enter_patient (in patientId int, in doctorId int)
begin
insert into hospital.queue value(
(select appointment_id from hospital.appointment where patient_id = patientId and doctor_id = doctorId),
(select now()));
end $$
delimiter ;*/


/*Q3*/
/*create view long_time_waiting_view as
select rel.patient_id from
(select appointment.patient_id, appointment.appointment_time, queue.actual_time, (queue.actual_time - appointment.appointment_time)as diff 
from hospital.appointment
inner join hospital.queue on appointment.appointment_id = queue.appointment_id
order by diff desc) as rel LIMIT 10;*/

/*Q4*/

