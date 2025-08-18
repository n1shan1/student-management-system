# Oracle SQL Scripts for Student Management System

This directory contains Oracle SQL scripts to create and manage the database schema for the Student Management System.

## Script Execution Order

Execute the scripts in the following order:

1. **01_create_tables.sql** - Creates the main tables (students, courses, enrollments) with constraints, indexes, and sequences
2. **02_insert_sample_data.sql** - Inserts sample data for testing
3. **03_views_and_queries.sql** - Creates useful views and contains sample queries
4. **04_procedures_and_functions.sql** - Creates stored procedures and functions
5. **05_triggers_and_automation.sql** - Creates triggers for audit trails and business rules

## Database Schema Overview

### Tables

- **students** - Stores student information
- **courses** - Stores course information
- **enrollments** - Stores student-course enrollment relationships
- **student_audit** - Audit trail for student changes
- **enrollment_stats** - Daily enrollment statistics

### Key Features

- Auto-incrementing primary keys using sequences
- Foreign key constraints with cascading deletes
- Unique constraints to prevent duplicate data
- Check constraints for data validation
- Indexes for improved query performance
- Audit trails for tracking changes
- Business rule enforcement via triggers

### Views

- **v_student_summary** - Students with enrollment counts
- **v_course_summary** - Courses with enrollment counts
- **v_student_enrollments** - Student enrollments with course details
- **v_department_stats** - Department-wise statistics

### Stored Procedures

- **sp_add_student** - Add a new student
- **sp_add_course** - Add a new course
- **sp_enroll_student** - Enroll a student in a course
- **sp_update_student** - Update student information
- **sp_drop_enrollment** - Drop an enrollment
- **sp_update_enrollment_stats** - Update daily statistics

### Functions

- **fn_get_student_enrollment_count** - Get enrollment count for a student
- **fn_get_course_enrollment_count** - Get enrollment count for a course
- **fn_is_student_enrolled** - Check if student is enrolled in a course

### Triggers

- **trg_student_audit** - Audit trail for student changes
- **trg\_\*\_updated_at** - Auto-update timestamps
- **trg_validate_student_email** - Email format validation
- **trg_validate_contact** - Contact number validation
- **trg_limit_enrollments** - Limit student to 6 courses
- **trg_prevent_duplicate_enrollment** - Prevent duplicate enrollments

## Usage

1. Connect to your Oracle database
2. Execute the scripts in order using SQL\*Plus, SQL Developer, or similar tool
3. Use the views and procedures to interact with the data
4. The Java application can use JDBC to connect and perform operations

## Sample Queries

```sql
-- View all students
SELECT * FROM v_student_summary;

-- View course enrollments
SELECT * FROM v_student_enrollments;

-- Get department statistics
SELECT * FROM v_department_stats;

-- Check if student is enrolled in course
SELECT fn_is_student_enrolled(1, 1) FROM DUAL;
```

## Notes

- All scripts include error handling and rollback on failures
- Foreign key constraints ensure data integrity
- Triggers enforce business rules automatically
- Views provide convenient access to complex queries
- Stored procedures encapsulate common operations

## Permissions Required

The following Oracle privileges may be needed:

- CREATE TABLE
- CREATE SEQUENCE
- CREATE VIEW
- CREATE PROCEDURE
- CREATE TRIGGER
- CREATE INDEX
- INSERT, UPDATE, DELETE on created objects
