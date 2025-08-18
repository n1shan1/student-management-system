package com.service;

import java.util.Set;

import com.dao.EnrollmentDao;
import com.dao.EnrollmentDaoImplementaion;
import com.pojo.Enrollment;

public class EnrollmentService {
    private CourseService courseService;
    private StudentService studentService;
    private EnrollmentDao enrollmentDao;

    public EnrollmentService() {
        courseService = new CourseService();
        studentService = new StudentService();
        enrollmentDao = new EnrollmentDaoImplementaion();
    }

    public CourseService getCourseService() {
        return courseService;
    }

    public StudentService getStudentService() {
        return studentService;
    }

    public Set<Enrollment> getAllEnrollments() {
        return enrollmentDao.getAllEnrollments();
    }

    public Enrollment getEnrollmentById(int enrollmentId) {
        return enrollmentDao.getEnrollmentById(enrollmentId);
    }

    public Enrollment enrollStudent(int studentId, int courseId) {
        if (studentService.getIndividual(studentId) == null) {
            System.out.println("Student not found with ID: " + studentId);
            return null;
        }
        if (courseService.getCourseById(courseId) == null) {
            System.out.println("Course not found with ID: " + courseId);
            return null;
        }
        return enrollmentDao.enrollStudent(studentId, courseId);
    }

    public Enrollment updateEnrollment(int enrollmentId, int studentId, int courseId) {
        if (enrollmentDao.getEnrollmentById(enrollmentId) == null) {
            System.out.println("Enrollment not found with ID: " + enrollmentId);
            return null;
        }
        if (studentService.getIndividual(studentId) == null) {
            System.out.println("Student not found with ID: " + studentId);
            return null;
        }
        if (courseService.getCourseById(courseId) == null) {
            System.out.println("Course not found with ID: " + courseId);
            return null;
        }
        return enrollmentDao.updateEnrollment(enrollmentId, studentId, courseId);
    }

    public boolean disbandEnrollment(int enrollmentId) {
        if (enrollmentDao.getEnrollmentById(enrollmentId) == null) {
            System.out.println("Enrollment not found with ID: " + enrollmentId);
            return false;
        }
        return enrollmentDao.disbandEnrollment(enrollmentId);
    }

    public int totalEnrollments() {
        return enrollmentDao.totalEnrollments();
    }

    public Enrollment latestEnrollment() {
        return enrollmentDao.latestEnrollment();
    }

    public Set<Enrollment> getEnrollmentsByStudentId(int studentId) {
        if (studentService.getIndividual(studentId) == null) {
            System.out.println("Student not found with ID: " + studentId);
            return null;
        }
        return enrollmentDao.getEnrollmentsByStudentId(studentId);
    }

    public Set<Enrollment> getEnrollmentsByCourseId(int courseId) {
        if (courseService.getCourseById(courseId) == null) {
            System.out.println("Course not found with ID: " + courseId);
            return null;
        }
        return enrollmentDao.getEnrollmentsByCourseId(courseId);
    }
}
