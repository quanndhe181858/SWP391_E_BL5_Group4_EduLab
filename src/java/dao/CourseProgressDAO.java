/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import model.CourseProgress;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CourseProgressDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public CourseProgress createOrUpdateProgress(int userId, int courseId, int sectionId) {
        String sql = """
        INSERT INTO course_progress (user_id, course_id, section_id, last_accessed_at)
        VALUES (?, ?, ?, NOW())
        ON DUPLICATE KEY UPDATE last_accessed_at = NOW();
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setInt(3, sectionId);

            ps.executeUpdate();

            return getProgress(userId, courseId, sectionId);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in createOrUpdateProgress()", e);
            return null;
        } finally {
            closeResources();
        }
    }

    public boolean markCompleted(int userId, int courseId, int sectionId) {
        String sql = """
            UPDATE course_progress
            SET status = 'Completed',
                progress_percent = 100,
                completed_at = NOW()
            WHERE user_id = ? AND course_id = ? AND section_id = ?
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setInt(3, sectionId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in markCompleted()", e);
            return false;
        } finally {
            closeResources();
        }
    }

    public CourseProgress getProgress(int userId, int courseId, int sectionId) {
        String sql = """
        SELECT * FROM course_progress
        WHERE user_id = ? AND course_id = ? AND section_id = ?
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setInt(3, sectionId);

            rs = ps.executeQuery();

            if (rs.next()) {
                CourseProgress cp = new CourseProgress();
                cp.setId(rs.getInt("id"));
                cp.setUserId(rs.getInt("user_id"));
                cp.setCourseId(rs.getInt("course_id"));
                cp.setSectionId(rs.getInt("section_id"));
                cp.setProgressPercent(rs.getInt("progress_percent"));
                cp.setStatus(rs.getString("status"));
                cp.setTestDone(rs.getBoolean("test_done"));
                cp.setLastAccessedAt(rs.getTimestamp("last_accessed_at"));
                cp.setCompletedAt(rs.getTimestamp("completed_at"));
                return cp;
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in getProgress()", e);
        } finally {
            closeResources();
        }

        return null;
    }

    public void markTestDone(int userId, int courseId, int sectionId) {
        String sql = """
        UPDATE course_progress
        SET test_done = b'1',
            status = 'Completed',
            progress_percent = 100,
            completed_at = NOW()
        WHERE user_id = ?
          AND course_id = ?
          AND section_id = ?
    """;

        try (Connection conn = dbc.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setInt(3, sectionId);
            ps.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException("markTestDone failed", e);
        }
    }

    public int countCompletedSections(int userId, int courseId) {
        String sql = """
            SELECT COUNT(*) FROM course_progress
            WHERE user_id = ? AND course_id = ? AND status = 'Completed'
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            rs = ps.executeQuery();

            return rs.next() ? rs.getInt(1) : 0;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in countCompletedSections()", e);
            return 0;
        } finally {
            closeResources();
        }
    }

    public boolean isAllSectionsCompleted(int userId, int courseId) {
        String sql = """
        SELECT COUNT(cs.id) = SUM(cp.status = 'Completed')
        FROM course_section cs
        LEFT JOIN course_progress cp
               ON cs.id = cp.section_id
              AND cp.user_id = ?
        WHERE cs.course_id = ?
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            rs = ps.executeQuery();
            return rs.next() && rs.getBoolean(1);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error in isAllSectionsCompleted()", e);
            return false;
        } finally {
            closeResources();
        }
    }

    public Timestamp getCourseCompletedAt(int userId, int courseId) {

        String sql = """
        SELECT MAX(cp.completed_at) AS completed_at
        FROM course_progress cp
        JOIN course_section cs ON cs.id = cp.section_id
        WHERE cp.user_id = ?
          AND cp.course_id = ?
          AND cp.status = 'Completed'
    """;

        try (Connection con = dbc.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getTimestamp("completed_at");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
