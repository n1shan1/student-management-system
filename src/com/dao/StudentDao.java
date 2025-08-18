package com.dao;

import java.util.Set;

import com.pojo.Student;

public interface StudentDao {
    Set<Student> getAllStudents();

    Student getIndividual(int studentId);

    Student admitStudent(Student newStudent);

    Student updateStudentName(int studentId, String newName);

    Student disbandStudent(int studentId);

    String getStudentDepartment(int studentId);

    Student updateDepartment(int studentId, String newDepartment);

    Student updateContactDetails(int studentId, String newEmail, int newPhone);

    Student updateAddressDetails(int studentId, String address, String city, String state,
            String country, int pincode);

    int totalStudents();

    Student latestJoinedStudent();
}
