package com.pojo;

import java.time.LocalDate;

public class Student {
    // properties of the student

    private int studentId;
    private String studentName;
    private String email;
    private String dept;
    private String address;
    private String city;
    private String state;
    private String country;
    private int pinCode;
    private int contact;
    private LocalDate joiningDate;

    public Student(int studentId, String studentName,
            String email, String dept, String address,
            String city, String state, String country,
            int pinCode, int contact, LocalDate joiningDate) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.email = email;
        this.dept = dept;
        this.address = address;
        this.city = city;
        this.state = state;
        this.country = country;
        this.pinCode = pinCode;
        this.contact = contact;
        this.joiningDate = joiningDate;
    }

    public int getStudentId() {
        return studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public String getEmail() {
        return email;
    }

    public String getDept() {
        return dept;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getCountry() {
        return country;
    }

    public int getPinCode() {
        return pinCode;
    }

    public int getContact() {
        return contact;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setPinCode(int pinCode) {
        this.pinCode = pinCode;
    }

    public void setContact(int contact) {
        this.contact = contact;
    }

    public LocalDate getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }

    @Override
    public String toString() {
        return "Student{" +
                "studentId=" + studentId +
                ", studentName='" + studentName + '\'' +
                ", email='" + email + '\'' +
                ", dept='" + dept + '\'' +
                ", address='" + address + '\'' +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                ", country='" + country + '\'' +
                ", pinCode=" + pinCode +
                ", contact=" + contact +
                '}';
    }
}
