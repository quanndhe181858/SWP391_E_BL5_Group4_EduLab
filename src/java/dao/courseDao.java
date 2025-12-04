/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.SQLException;
import model.Course;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.sql.Statement;

/**
 *
 * @author quan
 */
public class CourseDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        CourseDAO dao = new CourseDAO();

        Course c = new Course();
        c.setTitle("Java Web Development");
        c.setDescription("Learn MVC, Servlet, JDBC");
        c.setStatus("active");
        c.setCategory_id(2);

        Course created = dao.createCourse(c, 1); // uid = 1 (creator)
        System.out.println("Created Course:");
        System.out.println(created);

        Course found = dao.getCourseById(created.getId());
        System.out.println("Found Course:");
        System.out.println(found);

        found.setTitle("Updated Java Web Development");
        found.setStatus("inactive");

        Course updated = dao.updateCourse(found, 1); // uid = 1 (updater)
        System.out.println("Updated Course:");
        System.out.println(updated);

        boolean deleted = dao.deleteCourse(updated.getId());
        System.out.println("Deleted? " + deleted);
    }

    public Course createCourse(Course course, int uid) {
        String sql = """
                 INSERT INTO `edulab`.`course`
                 (`title`,
                 `description`,
                 `category_id`,
                 `status`,
                 `created_by`)
                 VALUES
                 (?, ?, ?, ?, ?);
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getCategory_id());
            ps.setString(4, course.getStatus());
            ps.setInt(5, uid);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                course.setId(generatedId);
            }

            return course;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while createCourse() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    public Course updateCourse(Course course, int uid) {
        String sql = """
                 UPDATE `edulab`.`course`
                 SET 
                     `title` = ?, 
                     `description` = ?, 
                     `category_id` = ?, 
                     `status` = ?, 
                     `updated_by` = ?
                 WHERE `id` = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getCategory_id());
            ps.setString(4, course.getStatus());
            ps.setInt(5, uid);
            ps.setInt(6, course.getId());

            int rows = ps.executeUpdate();

            // If no row updated => course does not exist
            if (rows == 0) {
                return null;
            }

            return course;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while updateCourse() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    public boolean deleteCourse(int id) {
        String sql = """
                 DELETE FROM `edulab`.`course`
                 WHERE `id` = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while deleteCourse() execute!", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public Course getCourseById(int id) {
        String sql = """
                 SELECT 
                     id,
                     uuid,
                     title,
                     description,
                     status,
                     category_id,
                     created_at,
                     updated_at,
                     created_by,
                     updated_by
                 FROM edulab.course
                 WHERE id = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                Course course = new Course();

                course.setId(rs.getInt("id"));
                course.setUuid(rs.getString("uuid"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setStatus(rs.getString("status"));

                course.setCategory_id(rs.getInt("category_id"));
                // load category object if you have categoryDAO
                // course.setCategory(categoryDAO.getCategoryById(course.getCategory_id()));

                course.setCreated_at(rs.getTimestamp("created_at"));
                course.setUpdated_at(rs.getTimestamp("updated_at"));
                course.setCreated_by(rs.getInt("created_by"));
                course.setUpdated_by(rs.getInt("updated_by"));

                return course;
            }

            return null;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getCourseById() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

}
