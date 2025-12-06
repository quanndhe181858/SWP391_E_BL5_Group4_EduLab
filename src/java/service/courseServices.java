/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CategoryDAO;
import dao.CourseDAO;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Course;

/**
 *
 * @author quan
 */
public class CourseServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private CourseDAO cDao = new CourseDAO();
    private CategoryDAO categoryDao = new CategoryDAO();

    public Course createCourse(Course c, int uid) {
        try {
            boolean ok = cDao.isValid(c);
            if (ok) {
                return cDao.createCourse(c, uid);
            }

            return null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public Course getCourseById(int id) {
        try {
            return cDao.getCourseById(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public boolean deleteCourse(int id) {
        try {
            return cDao.deleteCourse(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

    public List<Course> getListCourse(int limit, int offset, String title, String description, int categoryId,
            String status, String sortBy) {
        try {
            return cDao.getCourses(limit, offset, title, description, categoryId, status, sortBy);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public List<Course> getListCourseByInstructorId(int limit, int offset, String title, String description, int categoryId,
            String status, String sortBy, int instructorId) {
        try {
            List<Course> cList = cDao.getCoursesByInstructorId(limit, offset, title, description, categoryId, status, sortBy, instructorId);

            for (Course course : cList) {
                Category c = categoryDao.getCategoryById(course.getCategory_id());
                course.setCategory(c);
            }

            return cList;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    public int countCourses(String title, String description,
            int categoryId, String status) {
        try {
            return cDao.countCourses(title, description, categoryId, status);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return 0;
        }
    }

    public int countCoursesByInstructorIdWithFilter(String title, String description,
            int categoryId, String status, int instructorId) {
        try {
            return cDao.countCoursesByInstructorIdWithFilter(title, description, categoryId, status, instructorId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return 0;
        }
    }
    
    public int countCoursesByInstructorId(int instructorId, String status) {
        try {
            return cDao.countCoursesByInstructorId(instructorId, status);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return 0;
        }
    }
}
