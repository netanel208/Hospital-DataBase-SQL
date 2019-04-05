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
/*DELIMITER $$
CREATE TRIGGER after_delete_trigger 
after delete on hospital.queue
 for each row 
 begin

update hospital.queue_summary inner join 
(select rel.actual_time as date, rel.doctor_id, count(rel.patient_id) as num_of_patients 
 from 
  (select queue.actual_time, queue.appointment_id, appointment.patient_id, appointment.doctor_id 
   from hospital.queue inner join hospital.appointment on queue.appointment_id = appointment.appointment_id) as rel
 group by rel.doctor_id) as t on queue_summary.doctor_id = t.doctor_id
 set queue_summary.num_of_patients = t.num_of_patients;
 
 end $$
 DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_insert_trigger 
after insert on hospital.queue
 for each row 
 begin

update hospital.queue_summary inner join 
(select rel.actual_time as date, rel.doctor_id, count(rel.patient_id) as num_of_patients 
 from 
  (select queue.actual_time, queue.appointment_id, appointment.patient_id, appointment.doctor_id 
   from hospital.queue inner join hospital.appointment on queue.appointment_id = appointment.appointment_id) as rel
 group by rel.doctor_id) as t on queue_summary.doctor_id = t.doctor_id
 set queue_summary.num_of_patients = t.num_of_patients;

 end $$
 DELIMITER ;*/