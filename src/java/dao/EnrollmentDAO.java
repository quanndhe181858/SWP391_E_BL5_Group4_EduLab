package dao;

import java.sql.*;
import database.dao;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EnrollmentDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }
    
    public static void main(String[] args) {
        EnrollmentDAO dao = new EnrollmentDAO();
        try {
//            System.out.println(dao.enrollCourse(4, 1, "Learning"));
            System.out.println(dao.isEnrolled(2, 7));
        } catch (Exception e) {
            System.err.println(e);
        }
    }

    public boolean isEnrolled(int userId, int courseId) {
        String sql = "SELECT * FROM enrollment WHERE user_id = ? AND course_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        } finally {
            closeResources();
        }
    }

    public boolean enrollCourse(int courseId, int userId, String status) {
        String sql = """
                     INSERT INTO enrollment (course_id, user_id, status)
                     VALUES (?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, courseId);
            ps.setInt(2, userId);
            ps.setString(3, status);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        } finally {
            this.closeResources();
        }
    }
}
