-- Oracle SQL Script for Student Management System
-- Insert Sample Data

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

-- Commit the changes
commit;