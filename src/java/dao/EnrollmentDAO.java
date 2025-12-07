
package dao;
import java.sql.*;
import database.dao;


public class EnrollmentDAO extends dao{
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
            return false;
        } finally {
            closeResources();
        }
    }
}
