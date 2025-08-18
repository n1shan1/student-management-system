-- Oracle SQL Script for Student Management System
-- Useful Queries and Views

-- 1. View all students with their enrollment count
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

-- 2. View all courses with enrollment count
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

-- 3. View student enrollments with course details
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

-- 4. Department-wise statistics
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

-- Sample Queries

-- Query 1: Find all students in Computer Science department
select *
  from students
 where department = 'Computer Science';

-- Query 2: Find courses with more than 3 credits
select *
  from courses
 where credits > 3;

-- Query 3: Find students enrolled in Java Programming
select distinct s.student_name,
                s.email
  from students s
  join enrollments e
on s.student_id = e.student_id
  join courses c
on e.course_id = c.course_id
 where c.course_name = 'Java Programming'
   and e.status = 'ACTIVE';

-- Query 4: Find students not enrolled in any course
select s.student_name,
       s.email
  from students s
  left join enrollments e
on s.student_id = e.student_id
   and e.status = 'ACTIVE'
 where e.student_id is null;

-- Query 5: Find courses with no enrollments
select c.course_name,
       c.department
  from courses c
  left join enrollments e
on c.course_id = e.course_id
   and e.status = 'ACTIVE'
 where e.course_id is null;

-- Query 6: Count enrollments per department
select s.department,
       count(e.enrollment_id) as enrollment_count
  from students s
  join enrollments e
on s.student_id = e.student_id
 where e.status = 'ACTIVE'
 group by s.department
 order by enrollment_count desc;

-- Query 7: Find students with most enrollments
select s.student_name,
       count(e.enrollment_id) as enrollment_count
  from students s
  join enrollments e
on s.student_id = e.student_id
 where e.status = 'ACTIVE'
 group by s.student_id,
          s.student_name
 order by enrollment_count desc;

-- Query 8: Find recent enrollments (last 30 days)
select s.student_name,
       c.course_name,
       e.enrollment_date
  from enrollments e
  join students s
on e.student_id = s.student_id
  join courses c
on e.course_id = c.course_id
 where e.enrollment_date >= sysdate - 30
 order by e.enrollment_date desc;

-- Query 9: Average credits per student
select s.student_name,
       nvl(
          sum(c.credits),
          0
       ) as total_credits,
       nvl(
          avg(c.credits),
          0
       ) as avg_credits_per_course
  from students s
  left join enrollments e
on s.student_id = e.student_id
   and e.status = 'ACTIVE'
  left join courses c
on e.course_id = c.course_id
 group by s.student_id,
          s.student_name
 order by total_credits desc;

-- Query 10: Course popularity by department
select c.department,
       c.course_name,
       count(e.enrollment_id) as popularity
  from courses c
  left join enrollments e
on c.course_id = e.course_id
   and e.status = 'ACTIVE'
 group by c.department,
          c.course_name
 order by c.department,
          popularity desc;