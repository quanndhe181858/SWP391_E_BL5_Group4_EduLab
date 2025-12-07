/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CourseSectionDAO;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;
import model.CourseSection;

/**
 *
 * @author quan
 */
public class CourseSectionServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private final CourseSectionDAO csDao = new CourseSectionDAO();
    
    public CourseSection createSection(CourseSection cs) {
        try {
            return csDao.createCourseSection(cs);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error creating course section", e);
            return null;
        }
    }

    public CourseSection getSectionById(int id) {
        try {
            return csDao.getCourseSectionById(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting course section", e);
            return null;
        }
    }

    public boolean updateSection(CourseSection cs) {
        try {
            return csDao.updateCourseSection(cs);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating course section", e);
            return false;
        }
    }

    public boolean deleteSection(int id) {
        try {
            return csDao.deleteCourseSection(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting course section", e);
            return false;
        }
    }

    public List<CourseSection> getSectionsByCourseId(int courseId) {
        try {
            return csDao.getAllCourseSectionsByCourseId(courseId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error listing course sections", e);
            return Collections.emptyList();
        }
    }
}
