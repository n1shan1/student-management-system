package com.dao;

import java.util.Set;

import com.pojo.Course;

public interface CourseDao {
    Set<Course> getCourses();

    Course getCourseById(int courseId);

    Course addCourse(Course course);

    Course updateCourse(int courseId, String courseName, String description, int credits, String department);

    boolean deleteCourse(int courseId);

    int totalCourses();

    Course latestCourse();

    Set<Course> getCoursesByDepartment(String department);

}
