-- Oracle SQL Script for Student Management System
-- Create Tables

-- Drop tables if they exist (in reverse order of dependencies)
drop table enrollments cascade constraints;
drop table courses cascade constraints;
drop table students cascade constraints;

-- Create Students table
create table students (
   student_id   number(10) primary key,
   student_name varchar2(100) not null,
   email        varchar2(100) unique not null,
   department   varchar2(50) not null,
   address      varchar2(200),
   city         varchar2(50),
   state        varchar2(50),
   country      varchar2(50),
   pin_code     number(10),
   contact      number(15),
   joining_date date default sysdate,
   created_at   timestamp default current_timestamp,
   updated_at   timestamp default current_timestamp
);

-- Create Courses table
create table courses (
   course_id   number(10) primary key,
   course_name varchar2(100) not null,
   description varchar2(500),
   credits     number(2) not null check ( credits > 0 ),
   department  varchar2(50) not null,
   created_at  timestamp default current_timestamp,
   updated_at  timestamp default current_timestamp
);

-- Create Enrollments table
create table enrollments (
   enrollment_id   number(10) primary key,
   student_id      number(10) not null,
   course_id       number(10) not null,
   enrollment_date date default sysdate,
   status          varchar2(20) default 'ACTIVE' check ( status in ( 'ACTIVE',
                                                            'DROPPED',
                                                            'COMPLETED' ) ),
   created_at      timestamp default current_timestamp,
   updated_at      timestamp default current_timestamp,
   constraint fk_enrollment_student foreign key ( student_id )
      references students ( student_id )
         on delete cascade,
   constraint fk_enrollment_course foreign key ( course_id )
      references courses ( course_id )
         on delete cascade,
   constraint uk_student_course unique ( student_id,
                                         course_id )
);

-- Create sequences for auto-incrementing IDs
create sequence seq_student_id start with 1 increment by 1 nocache nocycle;

create sequence seq_course_id start with 1 increment by 1 nocache nocycle;

create sequence seq_enrollment_id start with 1 increment by 1 nocache nocycle;

-- Create indexes for better performance
create index idx_students_department on
   students (
      department
   );
create index idx_students_email on
   students (
      email
   );
create index idx_courses_department on
   courses (
      department
   );
create index idx_enrollments_student on
   enrollments (
      student_id
   );
create index idx_enrollments_course on
   enrollments (
      course_id
   );
create index idx_enrollments_date on
   enrollments (
      enrollment_date
   );

-- Add comments to tables
comment on table students is
   'Table to store student information';
comment on table courses is
   'Table to store course information';
comment on table enrollments is
   'Table to store student course enrollments';

-- Add comments to columns
comment on column students.student_id is
   'Unique identifier for student';
comment on column students.student_name is
   'Full name of the student';
comment on column students.email is
   'Email address of the student';
comment on column students.department is
   'Department of the student';
comment on column students.joining_date is
   'Date when student joined the institution';

comment on column courses.course_id is
   'Unique identifier for course';
comment on column courses.course_name is
   'Name of the course';
comment on column courses.credits is
   'Credit hours for the course';

comment on column enrollments.enrollment_id is
   'Unique identifier for enrollment';
comment on column enrollments.status is
   'Current status of enrollment';