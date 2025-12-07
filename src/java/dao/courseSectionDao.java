/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.Timestamp;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CourseSection;

/**
 *
 * @author quan
 */
public class CourseSectionDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {

        CourseSectionDAO dao = new CourseSectionDAO();

        CourseSection newCS = new CourseSection();
        newCS.setCourse_id(3);
        newCS.setTitle("Introduction");
        newCS.setDescription("This is the intro section");
        newCS.setContent("HTML content here");
        newCS.setType("video");
        newCS.setPosition(1);
        newCS.setStatus("active");
        newCS.setCreated_at(new Timestamp(System.currentTimeMillis()));
        newCS.setCreated_by(1);

        CourseSection created = dao.createCourseSection(newCS);

        int testId = created.getId();

        CourseSection cs = dao.getCourseSectionById(testId);
        System.out.println(cs != null ? cs : "Not found");

        cs.setTitle("Updated Title");
        cs.setUpdated_at(new Timestamp(System.currentTimeMillis()));
        cs.setUpdated_by(2);

        boolean updated = dao.updateCourseSection(cs);

        List<CourseSection> listByCourse = dao.getAllCourseSectionsByCourseId(1);
        listByCourse.forEach(System.out::println);

        boolean deleted = dao.deleteCourseSection(testId);

        CourseSection afterDelete = dao.getCourseSectionById(testId);
    }

    public CourseSection createCourseSection(CourseSection cs) {
        String sql = """
                 INSERT INTO `edulab`.`course_section`
                 (`course_id`,
                  `title`,
                  `description`,
                  `content`,
                  `type`,
                  `position`,
                  `status`,
                  `created_at`,
                  `created_by`)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, cs.getCourse_id());
            ps.setString(2, cs.getTitle());
            ps.setString(3, cs.getDescription());
            ps.setString(4, cs.getContent());
            ps.setString(5, cs.getType());
            ps.setInt(6, cs.getPosition());
            ps.setString(7, cs.getStatus());
            ps.setTimestamp(8, cs.getCreated_at());
            ps.setInt(9, cs.getCreated_by());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    cs.setId(rs.getInt(1));  // gán id mới
                }
                return cs;
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        } finally {
            this.closeResources();
        }

        return null;
    }

    public boolean updateCourseSection(CourseSection cs) {
        String sql = """
                 UPDATE `edulab`.`course_section`
                 SET
                   `course_id` = ?,
                   `title` = ?,
                   `description` = ?,
                   `content` = ?,
                   `type` = ?,
                   `position` = ?,
                   `status` = ?,
                   `updated_at` = ?,
                   `updated_by` = ?
                 WHERE `id` = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, cs.getCourse_id());
            ps.setString(2, cs.getTitle());
            ps.setString(3, cs.getDescription());
            ps.setString(4, cs.getContent());
            ps.setString(5, cs.getType());
            ps.setInt(6, cs.getPosition());
            ps.setString(7, cs.getStatus());
            ps.setTimestamp(8, cs.getUpdated_at());
            ps.setInt(9, cs.getUpdated_by());
            ps.setInt(10, cs.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean deleteCourseSection(int id) {
        String sql = "DELETE FROM `edulab`.`course_section` WHERE id = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public CourseSection getCourseSectionById(int id) {
        String sql = "SELECT * FROM `edulab`.`course_section` WHERE id = ? ORDER BY position;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                CourseSection cs = new CourseSection();

                cs.setId(rs.getInt("id"));
                cs.setCourse_id(rs.getInt("course_id"));
                cs.setTitle(rs.getString("title"));
                cs.setDescription(rs.getString("description"));
                cs.setContent(rs.getString("content"));
                cs.setType(rs.getString("type"));
                cs.setPosition(rs.getInt("position"));
                cs.setStatus(rs.getString("status"));
                cs.setCreated_at(rs.getTimestamp("created_at"));
                cs.setUpdated_at(rs.getTimestamp("updated_at"));
                cs.setCreated_by(rs.getInt("created_by"));
                cs.setUpdated_by(rs.getInt("updated_by"));

                return cs;
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }

        return null;
    }

    public List<CourseSection> getAllCourseSectionsByCourseId(int courseId) {
        List<CourseSection> list = new ArrayList<>();

        String sql = """
                 SELECT * FROM `edulab`.`course_section`
                 WHERE course_id = ?
                 ORDER BY position ASC;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();

            while (rs.next()) {
                CourseSection cs = new CourseSection();

                cs.setId(rs.getInt("id"));
                cs.setCourse_id(rs.getInt("course_id"));
                cs.setTitle(rs.getString("title"));
                cs.setDescription(rs.getString("description"));
                cs.setContent(rs.getString("content"));
                cs.setType(rs.getString("type"));
                cs.setPosition(rs.getInt("position"));
                cs.setStatus(rs.getString("status"));
                cs.setCreated_at(rs.getTimestamp("created_at"));
                cs.setUpdated_at(rs.getTimestamp("updated_at"));
                cs.setCreated_by(rs.getInt("created_by"));
                cs.setUpdated_by(rs.getInt("updated_by"));

                list.add(cs);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }

        return list;
    }

}
