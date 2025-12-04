/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.Timestamp;
import java.sql.SQLException;
import model.Course;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

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

//        Course c = new Course();
//        c.setTitle("Java Web Development");
//        c.setDescription("Learn MVC, Servlet, JDBC");
//        c.setStatus("active");
//        c.setCategory_id(2);
//
//        Course created = dao.createCourse(c, 1); // uid = 1 (creator)
//        System.out.println("Created Course:");
//        System.out.println(created);
//
//        Course found = dao.getCourseById(created.getId());
//        System.out.println("Found Course:");
//        System.out.println(found);
//
//        found.setTitle("Updated Java Web Development");
//        found.setStatus("inactive");
//
//        Course updated = dao.updateCourse(found, 1); // uid = 1 (updater)
//        System.out.println("Updated Course:");
//        System.out.println(updated);
//
//        boolean deleted = dao.deleteCourse(updated.getId());
//        System.out.println("Deleted? " + deleted);
        System.out.println(dao.getCourses(0, 0, "", "", 0, "", null, null));
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

    public boolean isExist(int id) {
        String sql = """
                 SELECT 
                     COUNT(*)
                 FROM edulab.course
                 WHERE id = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                int i = rs.getInt(1);
                if (i > 0) {
                    return true;
                }
            }

            return false;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while isExist() execute!", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean isValid(Course c) {
        String sql = "SELECT COUNT(*) AS total FROM edulab.course WHERE title = ? AND category_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getTitle());
            ps.setInt(2, c.getCategory_id());

            rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("total");
                return count == 0;
            }

            return false;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while isValid()", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public List<Course> getCourses(int limit, int offset, String title, String description,
            int categoryId, String status, Date start, Date end) {

        List<Course> cList = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM edulab.course WHERE 1 = 1"
        );

        List<Object> params = new ArrayList<>();

        if (title != null && !title.isEmpty()) {
            sql.append(" AND title LIKE ?");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isEmpty()) {
            sql.append(" AND description LIKE ?");
            params.add("%" + description + "%");
        }

        if (categoryId > 0) {
            sql.append(" AND category_id = ?");
            params.add(categoryId);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        if (start != null) {
            sql.append(" AND created_at >= ?");
            params.add(start);
        }

        if (end != null) {
            sql.append(" AND created_at <= ?");
            params.add(end);
        }

        sql.append(" ORDER BY id DESC");
        sql.append(" LIMIT ? OFFSET ?");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;
            for (Object p : params) {
                ps.setObject(index++, p);
            }

            ps.setInt(index++, limit);
            ps.setInt(index, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setUuid(rs.getString("uuid"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setCategory_id(rs.getInt("category_id"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUpdated_at(rs.getTimestamp("updated_at"));
                c.setCreated_by(rs.getInt("created_by"));
                c.setUpdated_by(rs.getInt("updated_by"));
                cList.add(c);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in getCourses()", e);
        } finally {
            this.closeResources();
        }

        return cList;
    }

}
