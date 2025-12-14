/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import database.dao;
import java.util.ArrayList;
import java.util.List;
import model.TestAttempt;

public class TestAttemptDAOv2 extends dao {

    public TestAttempt getAttemptByUserAndTest(int userId, int testId) {
        String sql = "SELECT * FROM test_attempt WHERE user_id = ? AND test_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, testId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return mapTestAttempt(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return null;
    }

    public boolean saveTestAttempt(TestAttempt attempt) {
        TestAttempt existing = getAttemptByUserAndTest(attempt.getUserId(), attempt.getTestId());

        if (existing != null) {
            // Update
            return updateTestAttempt(attempt);
        } else {
            // Insert
            return createTestAttempt(attempt);
        }
    }

    private boolean createTestAttempt(TestAttempt attempt) {
        String sql = """
            INSERT INTO test_attempt 
            (user_id, test_id, current_attempted, grade, status)
            VALUES (?, ?, ?, ?, ?)
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, attempt.getUserId());
            ps.setInt(2, attempt.getTestId());
            ps.setInt(3, attempt.getCurrentAttempted());

            if (attempt.getGrade() != null) {
                ps.setFloat(4, attempt.getGrade());
            } else {
                ps.setNull(4, Types.FLOAT);
            }

            ps.setString(5, attempt.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return false;
    }

    private boolean updateTestAttempt(TestAttempt attempt) {
        String sql = """
            UPDATE test_attempt 
            SET current_attempted = ?, grade = ?, status = ?
            WHERE user_id = ? AND test_id = ?
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, attempt.getCurrentAttempted());

            if (attempt.getGrade() != null) {
                ps.setFloat(2, attempt.getGrade());
            } else {
                ps.setNull(2, Types.FLOAT);
            }

            ps.setString(3, attempt.getStatus());
            ps.setInt(4, attempt.getUserId());
            ps.setInt(5, attempt.getTestId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return false;
    }

    public List<TestAttempt> getAttemptsByUser(int userId) {
        List<TestAttempt> list = new ArrayList<>();
        String sql = "SELECT * FROM test_attempt WHERE user_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                TestAttempt attempt = mapTestAttempt(rs);
                list.add(attempt);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

    public List<TestAttempt> getAttemptsByTest(int testId) {
        List<TestAttempt> list = new ArrayList<>();
        String sql = "SELECT * FROM test_attempt WHERE test_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, testId);
            rs = ps.executeQuery();

            while (rs.next()) {
                TestAttempt attempt = mapTestAttempt(rs);
                list.add(attempt);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

    public boolean hasUserPassedTest(int userId, int testId) {
        TestAttempt attempt = getAttemptByUserAndTest(userId, testId);
        return attempt != null && "Passed".equals(attempt.getStatus());
    }

    public int countAttempts(int userId, int testId) {
        TestAttempt attempt = getAttemptByUserAndTest(userId, testId);
        return attempt != null ? attempt.getCurrentAttempted() : 0;
    }

    private TestAttempt mapTestAttempt(ResultSet rs) throws SQLException {
        TestAttempt attempt = new TestAttempt();
        attempt.setUserId(rs.getInt("user_id"));
        attempt.setTestId(rs.getInt("test_id"));
        attempt.setCurrentAttempted(rs.getInt("current_attempted"));

        Float grade = rs.getFloat("grade");
        if (!rs.wasNull()) {
            attempt.setGrade(grade);
        }

        attempt.setStatus(rs.getString("status"));
        return attempt;
    }
}
