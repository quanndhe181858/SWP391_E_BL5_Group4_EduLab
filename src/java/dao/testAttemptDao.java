/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author vomin
 */
import database.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class testAttemptDao extends DBContext {

    /**
     * Return the highest current_attempt for this user and test. If there is no
     * record, return 0.
     */
        /**
     * Insert a new attempt record.
     */
    public void saveAttempt(int userId, int testId, int attempt, double grade, String status) {
        String sql = "INSERT INTO test_attempt (user_id, test_id, current_attempt, grade, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, testId);
            ps.setInt(3, attempt);
            ps.setDouble(4, grade);
            ps.setString(5, status);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Float getPassedGradeByCourse(int userId, int courseId) {

        String sql = """
        SELECT MAX(ta.grade) AS passed_grade
        FROM test_attempt ta
        JOIN test t ON t.id = ta.test_id
        WHERE ta.user_id = ?
          AND t.course_id = ?
          AND ta.status = 'Passed'
    """;

        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat("passed_grade");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
