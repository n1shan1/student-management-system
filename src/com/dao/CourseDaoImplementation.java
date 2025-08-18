package com.dao;

import java.util.HashSet;
import java.util.Set;

import com.pojo.Course;

public class CourseDaoImplementation implements CourseDao {
    private final Set<Course> courseDatabase;

    public CourseDaoImplementation() {
        courseDatabase = new HashSet<Course>();
        // seeding the database
        courseDatabase.add(new Course(1, "JAVA", "Programming Language", 4, "CSE"));
        courseDatabase.add(new Course(2, "Python", "Programming Language", 4, "CSE"));
        courseDatabase.add(new Course(3, "Data Structures", "Fundamental Data Structures", 3, "CSE"));
    }

    public Set<Course> getCourses() {
        return courseDatabase;
    }

    @Override
    public Course getCourseById(int courseId) {
        for (Course course : courseDatabase) {
            if (course.getCourseId() == courseId) {
                return course;
            }
        }
        System.out.println("Course not found with ID: " + courseId);
        return null;
    }

    @Override
    public Course addCourse(Course course) {
        int maxCourseId = courseDatabase.stream()
                .mapToInt(Course::getCourseId)
                .max()
                .orElse(0);
        course.setCourseId(maxCourseId + 1);
        courseDatabase.add(course);
        return course;
    }

    @Override
    public Course updateCourse(int courseId, String courseName, String description, int credits, String department) {
        for (Course course : courseDatabase) {
            if (course.getCourseId() == courseId) {
                course.setCourseName(courseName);
                course.setDescription(description);
                course.setCredits(credits);
                course.setDepartment(department);
                return course;
            }
        }
        System.out.println("Course not found with ID: " + courseId);
        return null;
    }

    @Override
    public boolean deleteCourse(int courseId) {
        for (Course course : courseDatabase) {
            if (course.getCourseId() == courseId) {
                courseDatabase.remove(course);
                return true;
            }
        }
        System.out.println("Course not found with ID: " + courseId);
        return false;
    }

    @Override
    public int totalCourses() {
        return courseDatabase.size();
    }

    @Override
    public Course latestCourse() {
        return courseDatabase.stream()
                .max((course1, course2) -> Integer.compare(course1.getCourseId(), course2.getCourseId()))
                .orElse(null);
    }

    @Override
    public Set<Course> getCoursesByDepartment(String department) {
        Set<Course> coursesByDepartment = new HashSet<>();
        for (Course course : courseDatabase) {
            if (course.getDepartment().equalsIgnoreCase(department)) {
                coursesByDepartment.add(course);
            }
        }
        return coursesByDepartment;
    }

}
