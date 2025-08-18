package com.dao;

import java.util.Set;

import com.pojo.Enrollment;

public interface EnrollmentDao {
    Set<Enrollment> getAllEnrollments();

    Enrollment getEnrollmentById(int enrollmentId);

    Enrollment enrollStudent(int studentId, int courseId);

    Enrollment updateEnrollment(int enrollmentId, int studentId, int courseId);

    boolean disbandEnrollment(int enrollmentId);

    int totalEnrollments();

    Enrollment latestEnrollment();

    Set<Enrollment> getEnrollmentsByStudentId(int studentId);

    Set<Enrollment> getEnrollmentsByCourseId(int courseId);
}
