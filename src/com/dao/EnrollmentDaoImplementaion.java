package com.dao;

import java.util.HashSet;
import java.util.Set;

import com.pojo.Enrollment;

public class EnrollmentDaoImplementaion implements EnrollmentDao {
    private final Set<Enrollment> enrollmentDatabase;

    public EnrollmentDaoImplementaion() {
        enrollmentDatabase = new HashSet<Enrollment>();
        enrollmentDatabase.add(new Enrollment(1, 1, 1, java.time.LocalDate.now()));
        enrollmentDatabase.add(new Enrollment(2, 1, 2, java.time.LocalDate.now()));
        enrollmentDatabase.add(new Enrollment(3, 2, 1, java.time.LocalDate.now()));
    }

    @Override
    public Set<Enrollment> getAllEnrollments() {
        return enrollmentDatabase;
    }

    @Override
    public Enrollment getEnrollmentById(int enrollmentId) {
        for (Enrollment enrollment : enrollmentDatabase) {
            if (enrollment.getEnrollmentId() == enrollmentId) {
                return enrollment;
            }
        }
        System.out.println("Enrollment not found with ID: " + enrollmentId);
        return null;
    }

    @Override
    public Enrollment enrollStudent(int studentId, int courseId) {
        int maxEnrollmentId = enrollmentDatabase.stream()
                .mapToInt(Enrollment::getEnrollmentId)
                .max()
                .orElse(0);
        Enrollment newEnrollment = new Enrollment(maxEnrollmentId + 1, studentId, courseId, java.time.LocalDate.now());
        enrollmentDatabase.add(newEnrollment);
        return newEnrollment;
    }

    @Override
    public Enrollment updateEnrollment(int enrollmentId, int studentId, int courseId) {
        for (Enrollment enrollment : enrollmentDatabase) {
            if (enrollment.getEnrollmentId() == enrollmentId) {
                enrollment.setStudentId(studentId);
                enrollment.setcourseId(courseId);
                return enrollment;
            }
        }
        System.out.println("Enrollment not found with ID: " + enrollmentId);
        return null;
    }

    @Override
    public boolean disbandEnrollment(int enrollmentId) {
        for (Enrollment enrollment : enrollmentDatabase) {
            if (enrollment.getEnrollmentId() == enrollmentId) {
                enrollmentDatabase.remove(enrollment);
                return true;
            }
        }
        System.out.println("Enrollment not found with ID: " + enrollmentId);
        return false;
    }

    @Override
    public int totalEnrollments() {
        return enrollmentDatabase.size();
    }

    @Override
    public Enrollment latestEnrollment() {
        return enrollmentDatabase.stream()
                .max((e1, e2) -> e1.getEnrollmentDate().compareTo(e2.getEnrollmentDate()))
                .orElse(null);
    }

    @Override
    public Set<Enrollment> getEnrollmentsByStudentId(int studentId) {
        Set<Enrollment> enrollments = new HashSet<>();
        for (Enrollment enrollment : enrollmentDatabase) {
            if (enrollment.getStudentId() == studentId) {
                enrollments.add(enrollment);
            }
        }
        return enrollments;
    }

    @Override
    public Set<Enrollment> getEnrollmentsByCourseId(int courseId) {
        Set<Enrollment> enrollments = new HashSet<>();
        for (Enrollment enrollment : enrollmentDatabase) {
            if (enrollment.getcourseId() == courseId) {
                enrollments.add(enrollment);
            }
        }
        return enrollments;
    }

}
