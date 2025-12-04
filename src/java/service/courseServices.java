/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CourseDAO;
import java.sql.Date;
import java.util.List;
import java.util.logging.Logger;
import model.Course;

/**
 *
 * @author quan
 */
public class CourseServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private CourseDAO cDao = new CourseDAO();

    public Course createCourse(Course c, int uid) {
        boolean ok = cDao.isValid(c);

        if (ok) {
            return cDao.createCourse(c, uid);
        }

        return null;
    }

    public Course getCourseById(int id) {
        return cDao.getCourseById(id);
    }

    public boolean deleteCourse(int id) {
        return cDao.deleteCourse(id);
    }

    public List<Course> getListCourse(int limit, int offset, String title, String description, int categoryId,
            String status, Date start, Date end) {
        return cDao.getCourses(limit, offset, title, description, categoryId, status, start, end);
    }
}
