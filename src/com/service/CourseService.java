package com.service;

import java.util.Set;

import com.dao.CourseDao;
import com.dao.CourseDaoImplementation;
import com.pojo.Course;

public class CourseService {
    private CourseDao courseDao;

    public CourseService() {
        courseDao = new CourseDaoImplementation();
    }

    public CourseDao getCourseDao() {
        return courseDao;
    }

    public Course getCourseById(int courseId) {
        return courseDao.getCourseById(courseId);
    }

    public Course addCourse(Course course) {
        return courseDao.addCourse(course);
    }

    public Course updateCourse(int courseId, String courseName, String description, int credits, String department) {
        return courseDao.updateCourse(courseId, courseName, description, credits, department);
    }

    public boolean deleteCourse(int courseId) {
        return courseDao.deleteCourse(courseId);
    }

    public int totalCourses() {
        return courseDao.totalCourses();
    }

    public Course latestCourse() {
        return courseDao.latestCourse();
    }

    public Set<Course> getCoursesByDepartment(String department) {
        return courseDao.getCoursesByDepartment(department);
    }

}
