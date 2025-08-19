-- Oracle SQL Data for Student Management System
-- This file contains sample data and useful queries for the Student Management System

-- ===========================================
-- INSERT SAMPLE DATA
-- ===========================================

-- Insert sample students
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
   contact,
   joining_date
) values ( seq_student_id.nextval,
           'John Doe',
           'john.doe@university.edu',
           'Computer Science',
           '123 Main St',
           'New York',
           'NY',
           'USA',
           10001,
           1234567890,
           sysdate - 30 );

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
   contact,
   joining_date
) values ( seq_student_id.nextval,
           'Jane Smith',
           'jane.smith@university.edu',
           'Computer Science',
           '456 Oak Ave',
           'Los Angeles',
           'CA',
           'USA',
           90001,
           1234567891,
           sysdate - 25 );

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
   contact,
   joining_date
) values ( seq_student_id.nextval,
           'Bob Johnson',
           'bob.johnson@university.edu',
           'Mathematics',
           '789 Pine St',
           'Chicago',
           'IL',
           'USA',
           60601,
           1234567892,
           sysdate - 20 );

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
   contact,
   joining_date
) values ( seq_student_id.nextval,
           'Alice Brown',
           'alice.brown@university.edu',
           'Physics',
           '321 Elm St',
           'Houston',
           'TX',
           'USA',
           77001,
           1234567893,
           sysdate - 15 );

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
   contact,
   joining_date
) values ( seq_student_id.nextval,
           'Charlie Wilson',
           'charlie.wilson@university.edu',
           'Computer Science',
           '654 Maple Ave',
           'Phoenix',
           'AZ',
           'USA',
           85001,
           1234567894,
           sysdate - 10 );

-- Insert sample courses
insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Java Programming',
           'Introduction to Java programming language and object-oriented concepts',
           4,
           'Computer Science' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Python Programming',
           'Introduction to Python programming language and its applications',
           4,
           'Computer Science' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Data Structures',
           'Fundamental data structures and algorithms',
           3,
           'Computer Science' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Database Systems',
           'Introduction to database design and SQL',
           3,
           'Computer Science' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Calculus I',
           'Introduction to differential and integral calculus',
           4,
           'Mathematics' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Linear Algebra',
           'Vector spaces, matrices, and linear transformations',
           3,
           'Mathematics' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Physics I',
           'Classical mechanics and thermodynamics',
           4,
           'Physics' );

insert into courses (
   course_id,
   course_name,
   description,
   credits,
   department
) values ( seq_course_id.nextval,
           'Quantum Physics',
           'Introduction to quantum mechanics',
           3,
           'Physics' );

-- Insert sample enrollments
-- Student 1 (John Doe) enrolled in Java and Data Structures
insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           1,
           1,
           sysdate - 25,
           'ACTIVE' );

insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           1,
           3,
           sysdate - 25,
           'ACTIVE' );

-- Student 2 (Jane Smith) enrolled in Python and Database Systems
insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           2,
           2,
           sysdate - 20,
           'ACTIVE' );

insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           2,
           4,
           sysdate - 20,
           'ACTIVE' );

-- Student 3 (Bob Johnson) enrolled in Calculus and Linear Algebra
insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           3,
           5,
           sysdate - 15,
           'ACTIVE' );

insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           3,
           6,
           sysdate - 15,
           'ACTIVE' );

-- Student 4 (Alice Brown) enrolled in Physics courses
insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           4,
           7,
           sysdate - 10,
           'ACTIVE' );

insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           4,
           8,
           sysdate - 10,
           'ACTIVE' );

-- Student 5 (Charlie Wilson) enrolled in Java and Python
insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           5,
           1,
           sysdate - 5,
           'ACTIVE' );

insert into enrollments (
   enrollment_id,
   student_id,
   course_id,
   enrollment_date,
   status
) values ( seq_enrollment_id.nextval,
           5,
           2,
           sysdate - 5,
           'ACTIVE' );

-- Commit the sample data
commit;

-- ===========================================
-- USEFUL QUERIES
-- ===========================================

-- Query 1: View all students with their enrollment summary
select *
  from v_student_summary
 order by student_name;

-- Query 2: View all courses with enrollment counts
select *
  from v_course_summary
 order by department,
          course_name;

-- Query 3: View all active enrollments with student and course details
select *
  from v_student_enrollments
 where status = 'ACTIVE'
 order by enrollment_date desc;

-- Query 4: Department-wise statistics
select *
  from v_department_stats
 order by total_students desc;

-- Query 5: Find all students in Computer Science department
select student_name,
       email,
       joining_date
  from students
 where department = 'Computer Science'
 order by joining_date;

-- Query 6: Find courses with more than 3 credits
select course_name,
       credits,
       department
  from courses
 where credits > 3
 order by department,
          course_name;

-- Query 7: Find students enrolled in Java Programming
select distinct s.student_name,
                s.email,
                e.enrollment_date
  from students s
  join enrollments e
on s.student_id = e.student_id
  join courses c
on e.course_id = c.course_id
 where c.course_name = 'Java Programming'
   and e.status = 'ACTIVE'
 order by e.enrollment_date;

-- Query 8: Find students not enrolled in any course
select s.student_name,
       s.email,
       s.department
  from students s
  left join enrollments e
on s.student_id = e.student_id
   and e.status = 'ACTIVE'
 where e.student_id is null
 order by s.student_name;

-- Query 9: Find courses with no active enrollments
select c.course_name,
       c.department,
       c.credits
  from courses c
  left join enrollments e
on c.course_id = e.course_id
   and e.status = 'ACTIVE'
 where e.course_id is null
 order by c.department,
          c.course_name;

-- Query 10: Count active enrollments per department
select s.department,
       count(e.enrollment_id) as enrollment_count
  from students s
  join enrollments e
on s.student_id = e.student_id
 where e.status = 'ACTIVE'
 group by s.department
 order by enrollment_count desc;

-- Query 11: Find students with most enrollments
select s.student_name,
       s.department,
       count(e.enrollment_id) as enrollment_count
  from students s
  join enrollments e
on s.student_id = e.student_id
 where e.status = 'ACTIVE'
 group by s.student_id,
          s.student_name,
          s.department
 order by enrollment_count desc;

-- Query 12: Find recent enrollments (last 30 days)
select s.student_name,
       c.course_name,
       c.department,
       e.enrollment_date
  from enrollments e
  join students s
on e.student_id = s.student_id
  join courses c
on e.course_id = c.course_id
 where e.enrollment_date >= sysdate - 30
 order by e.enrollment_date desc;

-- Query 13: Average credits per student
select s.student_name,
       s.department,
       nvl(
          sum(c.credits),
          0
       ) as total_credits,
       nvl(
          round(
             avg(c.credits),
             2
          ),
          0
       ) as avg_credits_per_course,
       count(e.enrollment_id) as total_courses_enrolled
  from students s
  left join enrollments e
on s.student_id = e.student_id
   and e.status = 'ACTIVE'
  left join courses c
on e.course_id = c.course_id
 group by s.student_id,
          s.student_name,
          s.department
 order by total_credits desc;

-- Query 14: Course popularity by department
select c.department,
       c.course_name,
       c.credits,
       count(e.enrollment_id) as enrollment_count
  from courses c
  left join enrollments e
on c.course_id = e.course_id
   and e.status = 'ACTIVE'
 group by c.department,
          c.course_name,
          c.credits
 order by c.department,
          enrollment_count desc;

-- Query 15: Students who joined in the last month
select student_name,
       email,
       department,
       joining_date
  from students
 where joining_date >= sysdate - 30
 order by joining_date desc;

-- Query 16: Total credits enrolled by each student
select s.student_name,
       s.department,
       sum(c.credits) as total_credits
  from students s
  join enrollments e
on s.student_id = e.student_id
  join courses c
on e.course_id = c.course_id
 where e.status = 'ACTIVE'
 group by s.student_id,
          s.student_name,
          s.department
 order by total_credits desc;

-- ===========================================
-- EXAMPLE STORED PROCEDURE USAGE
-- ===========================================

-- Example: Add a new student using stored procedure
/*
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
    DBMS_OUTPUT.PUT_LINE('New student ID: ' || v_student_id);
END;
/
*/

-- Example: Add a new course using stored procedure
/*
DECLARE
    v_course_id NUMBER;
BEGIN
    sp_add_course(
        'Machine Learning',
        'Introduction to machine learning algorithms and applications',
        3,
        'Computer Science',
        v_course_id
    );
    DBMS_OUTPUT.PUT_LINE('New course ID: ' || v_course_id);
END;
/
*/

-- Example: Enroll a student using stored procedure
/*
DECLARE
    v_enrollment_id NUMBER;
BEGIN
    sp_enroll_student(1, 1, v_enrollment_id);
    DBMS_OUTPUT.PUT_LINE('New enrollment ID: ' || v_enrollment_id);
END;
/
*/

-- ===========================================
-- EXAMPLE FUNCTION USAGE
-- ===========================================

-- Check enrollment counts using functions
select 'Student 1 enrollment count: ' || fn_get_student_enrollment_count(1) as student_info
  from dual
union all
select 'Course 1 enrollment count: ' || fn_get_course_enrollment_count(1) as course_info
  from dual
union all
select 'Is student 1 enrolled in course 1? ' || fn_is_student_enrolled(
   1,
   1
) as enrollment_check
  from dual;

-- ===========================================
-- DATA VALIDATION QUERIES
-- ===========================================

-- Verify data integrity
select 'Total Students: ' || count(*) as info
  from students
union all
select 'Total Courses: ' || count(*) as info
  from courses
union all
select 'Total Active Enrollments: ' || count(*) as info
  from enrollments
 where status = 'ACTIVE'
union all
select 'Total Audit Records: ' || count(*) as info
  from student_audit;

-- Check for orphaned records (should return no rows if data is clean)
select 'Orphaned enrollments (no student):' as check_type,
       count(*) as count
  from enrollments e
  left join students s
on e.student_id = s.student_id
 where s.student_id is null
union all
select 'Orphaned enrollments (no course):' as check_type,
       count(*) as count
  from enrollments e
  left join courses c
on e.course_id = c.course_id
 where c.course_id is null;