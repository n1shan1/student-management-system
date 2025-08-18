-- Oracle SQL Script for Student Management System
-- Triggers for Audit and Business Logic

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

-- Create sequence for audit table
create sequence seq_student_audit_id start with 1 increment by 1 nocache nocycle;

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

-- Trigger to automatically update timestamp on student updates
create or replace trigger trg_student_updated_at before
   update on students
   for each row
begin
   :new.updated_at := current_timestamp;
end;
/

-- Trigger to automatically update timestamp on course updates
create or replace trigger trg_course_updated_at before
   update on courses
   for each row
begin
   :new.updated_at := current_timestamp;
end;
/

-- Trigger to automatically update timestamp on enrollment updates
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

-- Trigger to prevent duplicate active enrollments
create or replace trigger trg_prevent_duplicate_enrollment before
   insert on enrollments
   for each row
declare
   v_count number;
begin
   select count(*)
     into v_count
     from enrollments
    where student_id = :new.student_id
      and course_id = :new.course_id
      and status = 'ACTIVE';

   if v_count > 0 then
      raise_application_error(
         -20016,
         'Student is already enrolled in this course'
      );
   end if;
end;
/

-- Create a table to track enrollment statistics
create table enrollment_stats (
   stats_date                  date,
   total_students              number,
   total_courses               number,
   total_active_enrollments    number,
   avg_enrollments_per_student number(5,2),
   created_at                  timestamp default current_timestamp
);

-- Procedure to update enrollment statistics (can be called daily)
create or replace procedure sp_update_enrollment_stats as
   v_total_students    number;
   v_total_courses     number;
   v_total_enrollments number;
   v_avg_enrollments   number;
begin
    -- Get current statistics
   select count(*)
     into v_total_students
     from students;
   select count(*)
     into v_total_courses
     from courses;
   select count(*)
     into v_total_enrollments
     from enrollments
    where status = 'ACTIVE';
    
    -- Calculate average enrollments per student
   if v_total_students > 0 then
      v_avg_enrollments := v_total_enrollments / v_total_students;
   else
      v_avg_enrollments := 0;
   end if;
    
    -- Insert or update today's statistics
   merge into enrollment_stats es
   using (
      select trunc(sysdate) as stats_date
        from dual
   ) d on ( es.stats_date = d.stats_date )
   when matched then update
   set total_students = v_total_students,
       total_courses = v_total_courses,
       total_active_enrollments = v_total_enrollments,
       avg_enrollments_per_student = v_avg_enrollments,
       created_at = current_timestamp
   when not matched then
   insert (
      stats_date,
      total_students,
      total_courses,
      total_active_enrollments,
      avg_enrollments_per_student )
   values
      ( trunc(sysdate),
        v_total_students,
        v_total_courses,
        v_total_enrollments,
        v_avg_enrollments );

   commit;
   dbms_output.put_line('Enrollment statistics updated successfully');
end;
/

-- Schedule the statistics update (example - would need DBMS_SCHEDULER privileges)
/*
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'JOB_UPDATE_ENROLLMENT_STATS',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN sp_update_enrollment_stats; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=1; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Daily update of enrollment statistics'
    );
END;
/
*/