-- Oracle SQL Schema for Student Management System
-- This file creates the complete database schema including tables, constraints, indexes, views, procedures, functions, and triggers

-- Drop existing objects if they exist (in reverse order of dependencies)
drop table student_audit cascade constraints;
drop table enrollment_stats cascade constraints;
drop table enrollments cascade constraints;
drop table courses cascade constraints;
drop table students cascade constraints;

-- Drop sequences
drop sequence seq_student_id;
drop sequence seq_course_id;
drop sequence seq_enrollment_id;
drop sequence seq_student_audit_id;

-- Drop views
drop view v_student_summary;
drop view v_course_summary;
drop view v_student_enrollments;
drop view v_department_stats;

-- ===========================================
-- CREATE TABLES
-- ===========================================

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

-- Create audit table for students
create table student_audit (
   audit_id       number(10) primary key,
   student_id     number(10),
   operation      varchar2(10), -- INSERT, UPDATE, DELETE
   old_name       varchar2(100),
   new_name       varchar2(100),
   old_email      varchar2(100),
   new_email      varchar2(100),
   old_department varchar2(50),
   new_department varchar2(50),
   changed_by     varchar2(100),
   change_date    timestamp default current_timestamp
);

-- Create statistics table
create table enrollment_stats (
   stats_date                  date,
   total_students              number,
   total_courses               number,
   total_active_enrollments    number,
   avg_enrollments_per_student number(5,2),
   created_at                  timestamp default current_timestamp
);

-- ===========================================
-- CREATE SEQUENCES
-- ===========================================

create sequence seq_student_id start with 1 increment by 1 nocache nocycle;
create sequence seq_course_id start with 1 increment by 1 nocache nocycle;
create sequence seq_enrollment_id start with 1 increment by 1 nocache nocycle;
create sequence seq_student_audit_id start with 1 increment by 1 nocache nocycle;

-- ===========================================
-- CREATE INDEXES
-- ===========================================

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

-- ===========================================
-- CREATE VIEWS
-- ===========================================

-- View all students with their enrollment count
create or replace view v_student_summary as
   select s.student_id,
          s.student_name,
          s.email,
          s.department,
          s.joining_date,
          count(e.enrollment_id) as total_enrollments
     from students s
     left join enrollments e
   on s.student_id = e.student_id
      and e.status = 'ACTIVE'
    group by s.student_id,
             s.student_name,
             s.email,
             s.department,
             s.joining_date;

-- View all courses with enrollment count
create or replace view v_course_summary as
   select c.course_id,
          c.course_name,
          c.department,
          c.credits,
          count(e.enrollment_id) as total_enrollments
     from courses c
     left join enrollments e
   on c.course_id = e.course_id
      and e.status = 'ACTIVE'
    group by c.course_id,
             c.course_name,
             c.department,
             c.credits;

-- View student enrollments with course details
create or replace view v_student_enrollments as
   select e.enrollment_id,
          s.student_id,
          s.student_name,
          c.course_id,
          c.course_name,
          c.credits,
          e.enrollment_date,
          e.status
     from enrollments e
     join students s
   on e.student_id = s.student_id
     join courses c
   on e.course_id = c.course_id;

-- Department-wise statistics
create or replace view v_department_stats as
   select department,
          count(distinct student_id) as total_students,
          count(distinct course_id) as total_courses,
          count(enrollment_id) as total_enrollments
     from (
      select s.department,
             s.student_id,
             null as course_id,
             null as enrollment_id
        from students s
      union all
      select c.department,
             null as student_id,
             c.course_id,
             null as enrollment_id
        from courses c
      union all
      select s.department,
             null as student_id,
             null as course_id,
             e.enrollment_id
        from enrollments e
        join students s
      on e.student_id = s.student_id
       where e.status = 'ACTIVE'
   )
    group by department;

-- ===========================================
-- CREATE STORED PROCEDURES
-- ===========================================

-- Procedure to add a new student
create or replace procedure sp_add_student (
   p_name       in varchar2,
   p_email      in varchar2,
   p_department in varchar2,
   p_address    in varchar2,
   p_city       in varchar2,
   p_state      in varchar2,
   p_country    in varchar2,
   p_pin_code   in number,
   p_contact    in number,
   p_student_id out number
) as
begin
   insert into students (
      student_id,
      student_name,
      email,
      department,
      address,
      city,
      state,
      country,
      pin_code,
      contact
   ) values ( seq_student_id.nextval,
              p_name,
              p_email,
              p_department,
              p_address,
              p_city,
              p_state,
              p_country,
              p_pin_code,
              p_contact ) returning student_id into p_student_id;

   commit;
exception
   when dup_val_on_index then
      raise_application_error(
         -20001,
         'Email already exists'
      );
   when others then
      rollback;
      raise_application_error(
         -20002,
         'Error adding student: ' || sqlerrm
      );
end;
/

-- Procedure to add a new course
create or replace procedure sp_add_course (
   p_course_name in varchar2,
   p_description in varchar2,
   p_credits     in number,
   p_department  in varchar2,
   p_course_id   out number
) as
begin
   insert into courses (
      course_id,
      course_name,
      description,
      credits,
      department
   ) values ( seq_course_id.nextval,
              p_course_name,
              p_description,
              p_credits,
              p_department ) returning course_id into p_course_id;

   commit;
exception
   when others then
      rollback;
      raise_application_error(
         -20003,
         'Error adding course: ' || sqlerrm
      );
end;
/

-- Procedure to enroll a student in a course
create or replace procedure sp_enroll_student (
   p_student_id    in number,
   p_course_id     in number,
   p_enrollment_id out number
) as
   v_student_count number;
   v_course_count  number;
begin
    -- Check if student exists
   select count(*)
     into v_student_count
     from students
    where student_id = p_student_id;

   if v_student_count = 0 then
      raise_application_error(
         -20004,
         'Student not found'
      );
   end if;
    
    -- Check if course exists
   select count(*)
     into v_course_count
     from courses
    where course_id = p_course_id;

   if v_course_count = 0 then
      raise_application_error(
         -20005,
         'Course not found'
      );
   end if;
    
    -- Enroll student
   insert into enrollments (
      enrollment_id,
      student_id,
      course_id,
      enrollment_date,
      status
   ) values ( seq_enrollment_id.nextval,
              p_student_id,
              p_course_id,
              sysdate,
              'ACTIVE' ) returning enrollment_id into p_enrollment_id;

   commit;
exception
   when dup_val_on_index then
      raise_application_error(
         -20006,
         'Student is already enrolled in this course'
      );
   when others then
      rollback;
      raise_application_error(
         -20007,
         'Error enrolling student: ' || sqlerrm
      );
end;
/

-- Procedure to update student information
create or replace procedure sp_update_student (
   p_student_id in number,
   p_name       in varchar2 default null,
   p_email      in varchar2 default null,
   p_department in varchar2 default null,
   p_address    in varchar2 default null,
   p_city       in varchar2 default null,
   p_state      in varchar2 default null,
   p_country    in varchar2 default null,
   p_pin_code   in number default null,
   p_contact    in number default null
) as
   v_count number;
begin
    -- Check if student exists
   select count(*)
     into v_count
     from students
    where student_id = p_student_id;

   if v_count = 0 then
      raise_application_error(
         -20008,
         'Student not found'
      );
   end if;
    
    -- Update student information
   update students
      set student_name = nvl(
      p_name,
      student_name
   ),
          email = nvl(
             p_email,
             email
          ),
          department = nvl(
             p_department,
             department
          ),
          address = nvl(
             p_address,
             address
          ),
          city = nvl(
             p_city,
             city
          ),
          state = nvl(
             p_state,
             state
          ),
          country = nvl(
             p_country,
             country
          ),
          pin_code = nvl(
             p_pin_code,
             pin_code
          ),
          contact = nvl(
             p_contact,
             contact
          ),
          updated_at = current_timestamp
    where student_id = p_student_id;

   commit;
exception
   when dup_val_on_index then
      raise_application_error(
         -20009,
         'Email already exists'
      );
   when others then
      rollback;
      raise_application_error(
         -20010,
         'Error updating student: ' || sqlerrm
      );
end;
/

-- ===========================================
-- CREATE FUNCTIONS
-- ===========================================

-- Function to get student enrollment count
create or replace function fn_get_student_enrollment_count (
   p_student_id in number
) return number as
   v_count number;
begin
   select count(*)
     into v_count
     from enrollments
    where student_id = p_student_id
      and status = 'ACTIVE';

   return v_count;
exception
   when others then
      return 0;
end;
/

-- Function to get course enrollment count
create or replace function fn_get_course_enrollment_count (
   p_course_id in number
) return number as
   v_count number;
begin
   select count(*)
     into v_count
     from enrollments
    where course_id = p_course_id
      and status = 'ACTIVE';

   return v_count;
exception
   when others then
      return 0;
end;
/

-- Function to check if student is enrolled in course
create or replace function fn_is_student_enrolled (
   p_student_id in number,
   p_course_id  in number
) return varchar2 as
   v_count number;
begin
   select count(*)
     into v_count
     from enrollments
    where student_id = p_student_id
      and course_id = p_course_id
      and status = 'ACTIVE';

   if v_count > 0 then
      return 'YES';
   else
      return 'NO';
   end if;
exception
   when others then
      return 'ERROR';
end;
/

-- ===========================================
-- CREATE TRIGGERS
-- ===========================================

-- Trigger for student audit trail
create or replace trigger trg_student_audit after
   insert or update or delete on students
   for each row
begin
   if inserting then
      insert into student_audit (
         audit_id,
         student_id,
         operation,
         new_name,
         new_email,
         new_department,
         changed_by
      ) values ( seq_student_audit_id.nextval,
                 :new.student_id,
                 'INSERT',
                 :new.student_name,
                 :new.email,
                 :new.department,
                 user );
   elsif updating then
      insert into student_audit (
         audit_id,
         student_id,
         operation,
         old_name,
         new_name,
         old_email,
         new_email,
         old_department,
         new_department,
         changed_by
      ) values ( seq_student_audit_id.nextval,
                 :new.student_id,
                 'UPDATE',
                 :old.student_name,
                 :new.student_name,
                 :old.email,
                 :new.email,
                 :old.department,
                 :new.department,
                 user );
   elsif deleting then
      insert into student_audit (
         audit_id,
         student_id,
         operation,
         old_name,
         old_email,
         old_department,
         changed_by
      ) values ( seq_student_audit_id.nextval,
                 :old.student_id,
                 'DELETE',
                 :old.student_name,
                 :old.email,
                 :old.department,
                 user );
   end if;
end;
/

-- Trigger to automatically update timestamp on updates
create or replace trigger trg_student_updated_at before
   update on students
   for each row
begin
   :new.updated_at := current_timestamp;
end;
/

create or replace trigger trg_course_updated_at before
   update on courses
   for each row
begin
   :new.updated_at := current_timestamp;
end;
/

create or replace trigger trg_enrollment_updated_at before
   update on enrollments
   for each row
begin
   :new.updated_at := current_timestamp;
end;
/

-- Trigger to validate email format
create or replace trigger trg_validate_student_email before
   insert or update on students
   for each row
begin
   if
      :new.email is not null
      and not regexp_like(
         :new.email,
         '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
      )
   then
      raise_application_error(
         -20013,
         'Invalid email format'
      );
   end if;
end;
/

-- Trigger to validate contact number (must be 10 digits)
create or replace trigger trg_validate_contact before
   insert or update on students
   for each row
begin
   if
      :new.contact is not null
      and ( length(:new.contact) != 10
      or :new.contact < 1000000000 )
   then
      raise_application_error(
         -20014,
         'Contact number must be exactly 10 digits'
      );
   end if;
end;
/

-- Trigger to prevent enrollment in more than 6 courses per student
create or replace trigger trg_limit_enrollments before
   insert on enrollments
   for each row
declare
   v_enrollment_count number;
begin
   select count(*)
     into v_enrollment_count
     from enrollments
    where student_id = :new.student_id
      and status = 'ACTIVE';

   if v_enrollment_count >= 6 then
      raise_application_error(
         -20015,
         'Student cannot enroll in more than 6 courses'
      );
   end if;
end;
/

-- ===========================================
-- ADD COMMENTS
-- ===========================================

comment on table students is
   'Table to store student information';
comment on table courses is
   'Table to store course information';
comment on table enrollments is
   'Table to store student course enrollments';
comment on table student_audit is
   'Audit trail for student changes';

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

commit;