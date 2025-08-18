package com.dao;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;

import com.pojo.Student;

public class StudentDaoImplementation implements StudentDao {
    private final Set<Student> studentDatabase;

    public StudentDaoImplementation() {
        studentDatabase = new HashSet<Student>();

        studentDatabase.add(
                new Student(1, "A", "a@email.com", "CSE", "House A", "City A", "State A", "Country A", 00001, 111111,
                        java.time.LocalDate.now()));
        studentDatabase.add(
                new Student(2, "B", "b@email.com", "CSE", "House B", "City B", "State B", "Country B", 00002, 222222,
                        java.time.LocalDate.now()));
        studentDatabase.add(
                new Student(3, "C", "c@email.com", "CSE", "House C", "City C", "State C", "Country C", 00002, 222222,
                        java.time.LocalDate.now()));
    }

    public Set<Student> getAllStudents() {
        return studentDatabase;
    }

    @Override
    public Student admitStudent(Student newStudent) {
        Student maxBook = Collections.max(studentDatabase, (obj1, obj2) -> obj1.getStudentId() - obj2.getStudentId());
        newStudent.setStudentId((maxBook.getStudentId() + 1));
        studentDatabase.add(newStudent);
        return newStudent;
    }

    @Override
    public Student disbandStudent(int studentId) {
        Student studentToDisband = null;
        for (Student student : studentDatabase) {
            if (student.getStudentId() == studentId) {
                studentToDisband = student;
                studentDatabase.remove(studentToDisband);
            }
        }
        return studentToDisband;
    }

    @Override
    public Student getIndividual(int studentId) {
        Student studentNew = null;
        for (Student eachStudent : studentDatabase) {
            if (eachStudent.getStudentId() == studentId) {
                studentNew = eachStudent;
            }
        }
        return studentNew;
    }

    @Override
    public String getStudentDepartment(int studentId) {
        Student student = null;
        for (Student student2 : studentDatabase) {
            if (student2.getStudentId() == studentId) {
                student = student2;
            }
        }
        return student.getDept();
    }

    @Override
    public Student updateAddressDetails(int studentId, String newAddress, String newCity, String newState,
            String newCountry, int newPinCode) {
        Student studentToUpdate = null;
        for (Student student : studentDatabase) {
            if (student.getStudentId() == studentId) {
                student.setAddress(newAddress);
                student.setCity(newCity);
                student.setState(newState);
                student.setCountry(newCountry);
                student.setPinCode(newPinCode);
            }
        }
        return studentToUpdate;
    }

    @Override
    public Student updateContactDetails(int studentId, String newEmail, int newPhone) {
        Student studentToUpdate = null;
        for (Student student : studentDatabase) {
            if (student.getStudentId() == studentId) {
                student.setEmail(newEmail);
                student.setContact(newPhone);
            }
        }
        return studentToUpdate;
    }

    @Override
    public Student updateDepartment(int studentId, String newDepartment) {
        Student studentToUpdate = null;
        for (Student student : studentDatabase) {
            if (student.getStudentId() == studentId) {
                student.setDept(newDepartment);
            }
        }
        return studentToUpdate;
    }

    @Override
    public Student updateStudentName(int studentId, String newName) {
        Student studentToUpdate = null;
        for (Student student : studentDatabase) {
            if (student.getStudentId() == studentId) {
                student.setStudentName(newName);
            }
        }
        return studentToUpdate;
    }

    @Override
    public int totalStudents() {
        return studentDatabase.size();
    }

    @Override
    public Student latestJoinedStudent() {
        Student latestStudent = null;
        if (studentDatabase.size() == 0) {
            return latestStudent;
        }
        Comparator<Student> joiningDateComparator = new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                return o1.getJoiningDate().compareTo(o2.getJoiningDate());
            }
        };
        latestStudent = Collections.max(studentDatabase, joiningDateComparator);
        return latestStudent;
    }

}
