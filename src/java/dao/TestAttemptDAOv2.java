/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import database.dao;
import dtos.RetakeRequestDTO;
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

    public List<TestAttempt> getAttemptsByUserAndTest(int userId, int testId) {

        List<TestAttempt> list = new ArrayList<>();

        String sql = """
            SELECT
                user_id,
                test_id,
                current_attempted,
                grade,
                status
            FROM test_attempt
            WHERE user_id = ?
              AND test_id = ?
        """;

        try (
                Connection con = dbc.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, testId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TestAttempt ta = new TestAttempt();
                ta.setUserId(rs.getInt("user_id"));
                ta.setTestId(rs.getInt("test_id"));
                ta.setCurrentAttempted(rs.getInt("current_attempted"));
                ta.setGrade(rs.getFloat("grade"));
                ta.setStatus(rs.getString("status"));

                list.add(ta);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateStatus(int userId, int testId, String status) {
        String sql = "UPDATE test_attempt SET status = ? WHERE user_id = ? AND test_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, userId);
            ps.setInt(3, testId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return false;
    }

    public boolean deletePendingAttempt(int userId, int testId) {
        String sql = """
        DELETE FROM test_attempt
        WHERE user_id = ?
          AND test_id = ?
          AND status = 'Pending'
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, testId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    public boolean isLimitReached(int userId, int testId) {
        String sql = """
        SELECT current_attempted
        FROM test_attempt
        WHERE user_id = ? AND test_id = ?
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, testId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("current_attempted") >= 2;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return false;
    }

    public boolean isBlockedStatus(int userId, int testId) {
        String sql = "SELECT status FROM test_attempt WHERE user_id = ? AND test_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, testId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");
                return "Pending".equals(status) || "Rejected".equals(status) || "Retaking".equals(status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return false;
    }

    public List<RetakeRequestDTO> getPendingRetakeRequestsByInstructor(
            int instructorId,
            Integer courseId,
            String search) {
        List<RetakeRequestDTO> list = new ArrayList<>();

        String sql = """
SELECT 
    ta.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,

    c.id AS course_id,
    c.title AS course_title,

    t.id AS test_id,
    t.title AS test_title,

    ta.grade,
    ta.current_attempted,
    ta.status

FROM test_attempt ta
JOIN user u ON ta.user_id = u.id
JOIN test t ON ta.test_id = t.id
JOIN course c ON t.course_id = c.id

WHERE ta.status = 'Pending'
  AND c.created_by = ?
""";

        if (courseId != null) {
            sql += " AND c.id = ? ";
        }

        if (search != null && !search.isBlank()) {
            sql += """
      AND (
          CONCAT(u.first_name, ' ', u.last_name) LIKE ?
          OR u.email LIKE ?
      )
    """;
        }

        sql += " ORDER BY ta.user_id DESC ";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            int idx = 1;
            ps.setInt(idx++, instructorId);

            if (courseId != null) {
                ps.setInt(idx++, courseId);
            }

            if (search != null && !search.isBlank()) {
                String kw = "%" + search + "%";
                ps.setString(idx++, kw);
                ps.setString(idx++, kw);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                RetakeRequestDTO dto = new RetakeRequestDTO();
                dto.setUserId(rs.getInt("user_id"));
                dto.setUserName(rs.getString("full_name"));
                dto.setUserEmail(rs.getString("email"));

                dto.setCourseId(rs.getInt("course_id"));
                dto.setCourseTitle(rs.getString("course_title"));

                dto.setTestId(rs.getInt("test_id"));
                dto.setTestTitle(rs.getString("test_title"));

                dto.setGrade(rs.getFloat("grade"));
                dto.setCurrentAttempted(rs.getInt("current_attempted"));

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

}
