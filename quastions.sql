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
 
 update hospital.queue_summary set num_of_patients = 
  (select count(rel.patient_id) 
   from 
	   (select queue.appointment_id, appointment.patient_id, appointment.doctor_id 
	    from queue inner join appointment on queue.appointment_id = appointment.appointment_id) as rel
   group by rel.doctor_id
   having rel.doctor_id = 111111111)
where doctor_id = 111111111;


 update hospital.queue_summary set num_of_patients = 
  (select count(rel.patient_id) 
   from 
	   (select queue.appointment_id, appointment.patient_id, appointment.doctor_id 
	    from queue inner join appointment on queue.appointment_id = appointment.appointment_id) as rel
   group by rel.doctor_id
   having rel.doctor_id = 222222222)
where doctor_id = 222222222;

update hospital.queue_summary set num_of_patients = 
  (select count(rel.patient_id) 
   from 
	   (select queue.appointment_id, appointment.patient_id, appointment.doctor_id 
	    from queue inner join appointment on queue.appointment_id = appointment.appointment_id) as rel
   group by rel.doctor_id
   having rel.doctor_id = 333333333)
where doctor_id = 333333333;

 end $$
 DELIMITER ;


DELIMITER $$
CREATE TRIGGER after_insert_trigger 
after insert on hospital.queue
 for each row 
 begin
 
 update hospital.queue_summary set num_of_patients = 
  (select count(rel.patient_id) 
   from 
	   (select queue.appointment_id, appointment.patient_id, appointment.doctor_id 
	    from queue inner join appointment on queue.appointment_id = appointment.appointment_id) as rel
   group by rel.doctor_id
   having rel.doctor_id = 111111111)
where doctor_id = 111111111;


 update hospital.queue_summary set num_of_patients = 
  (select count(rel.patient_id) 
   from 
	   (select queue.appointment_id, appointment.patient_id, appointment.doctor_id 
	    from queue inner join appointment on queue.appointment_id = appointment.appointment_id) as rel
   group by rel.doctor_id
   having rel.doctor_id = 222222222)
where doctor_id = 222222222;

update hospital.queue_summary set num_of_patients = 
  (select count(rel.patient_id) 
   from 
	   (select queue.appointment_id, appointment.patient_id, appointment.doctor_id 
	    from queue inner join appointment on queue.appointment_id = appointment.appointment_id) as rel
   group by rel.doctor_id
   having rel.doctor_id = 333333333)
where doctor_id = 333333333;

 end $$
 DELIMITER ;*/
