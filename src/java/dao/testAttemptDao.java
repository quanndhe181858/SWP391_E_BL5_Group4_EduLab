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
     * Return the highest current_attempt for this user and test.
     * If there is no record, return 0.
     */
    public int getCurrentAttempt(int userId, int testId) {
        String sql = "SELECT MAX(current_attempt) AS mx FROM test_attempt WHERE user_id = ? AND test_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, testId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // if result is NULL (no rows), getInt returns 0, but better check
                    int val = rs.getInt("mx");
                    if (rs.wasNull()) return 0;
                    return val;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Insert a new attempt record.
     */
    public void saveAttempt(int userId, int testId, int attempt, double grade, String status) {
        String sql = "INSERT INTO test_attempt (user_id, test_id, current_attempt, grade, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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
}
