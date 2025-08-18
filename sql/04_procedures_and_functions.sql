-- Oracle SQL Script for Student Management System
-- Stored Procedures and Functions

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
   dbms_output.put_line('Student added successfully with ID: ' || p_student_id);
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
   dbms_output.put_line('Course added successfully with ID: ' || p_course_id);
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
   dbms_output.put_line('Student enrolled successfully with enrollment ID: ' || p_enrollment_id);
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
   dbms_output.put_line('Student updated successfully');
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

-- Procedure to drop an enrollment
create or replace procedure sp_drop_enrollment (
   p_enrollment_id in number
) as
   v_count number;
begin
    -- Check if enrollment exists
   select count(*)
     into v_count
     from enrollments
    where enrollment_id = p_enrollment_id;

   if v_count = 0 then
      raise_application_error(
         -20011,
         'Enrollment not found'
      );
   end if;
    
    -- Update enrollment status to DROPPED
   update enrollments
      set status = 'DROPPED',
          updated_at = current_timestamp
    where enrollment_id = p_enrollment_id;

   commit;
   dbms_output.put_line('Enrollment dropped successfully');
exception
   when others then
      rollback;
      raise_application_error(
         -20012,
         'Error dropping enrollment: ' || sqlerrm
      );
end;
/

-- Example usage of stored procedures and functions:
/*
-- Add a new student
DECLARE
    v_student_id NUMBER;
BEGIN
    sp_add_student(
        'Test Student', 
        'test@university.edu', 
        'Computer Science',
        '123 Test St',
        'Test City',
        'Test State',
        'Test Country',
        12345,
        9876543210,
        v_student_id
    );
END;
/

-- Add a new course
DECLARE
    v_course_id NUMBER;
BEGIN
    sp_add_course(
        'Test Course',
        'This is a test course',
        3,
        'Computer Science',
        v_course_id
    );
END;
/

-- Enroll a student
DECLARE
    v_enrollment_id NUMBER;
BEGIN
    sp_enroll_student(1, 1, v_enrollment_id);
END;
/

-- Check enrollment count
SELECT fn_get_student_enrollment_count(1) FROM DUAL;
SELECT fn_get_course_enrollment_count(1) FROM DUAL;
SELECT fn_is_student_enrolled(1, 1) FROM DUAL;
*/