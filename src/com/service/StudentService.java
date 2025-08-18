package com.service;

import java.util.Set;

import com.dao.StudentDao;
import com.dao.StudentDaoImplementation;
import com.pojo.Student;

public class StudentService {
    private StudentDao studentDao;

    public StudentService() {
        studentDao = new StudentDaoImplementation();
    }

    public Set<Student> getAllStudents() {
        return studentDao.getAllStudents();
    }

    public Student admitStudent(Student newStudent) {
        return studentDao.admitStudent(newStudent);
    }

    public Student disbandStudent(int studentId) {
        return studentDao.disbandStudent(studentId);
    }

    public Student getIndividual(int studentId) {
        return studentDao.getIndividual(studentId);
    }

    public Student updateAddressDetails(int studentId, String newAddress, String newCity, String newState,
            String newCountry, int newPinCode) {
        return studentDao.updateAddressDetails(studentId, newAddress, newCity, newState, newCountry, newPinCode);
    }

    public Student updateContactDetails(int studentId, String newEmail, int newPhone) {
        return studentDao.updateContactDetails(studentId, newEmail, newPhone);
    }

    public Student updateDepartment(int studentId, String newDepartment) {
        return studentDao.updateDepartment(studentId, newDepartment);
    }

    public Student updateStudentName(int studentId, String newName) {
        return studentDao.updateStudentName(studentId, newName);
    }

    public int totalStudents() {
        return studentDao.totalStudents();
    }

    public Student latestJoinedStudent() {
        return studentDao.latestJoinedStudent();
    }

}
