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
}
