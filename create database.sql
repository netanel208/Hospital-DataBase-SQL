create database Hospital;

use Hospital;

create table Doctors (doctore_id int(9) primary key, doctor_type varchar(20) not null, doctor_name varchar(20) not null, salary int(7) not null);
create table Patients (patient_id int(9) primary key,  patient_name varchar(20) not null);
create table Appointment (appointment_id int(9) primary key, patient_id int(9) unique not null, doctor_id int(9) not null, appointment_time datetime not null);
create table Queue (appointment_id int(9) primary key,  actual_time datetime);
create table Queue_Summary (date datetime, doctor_id int(9) not null, num_of_patients int not null);