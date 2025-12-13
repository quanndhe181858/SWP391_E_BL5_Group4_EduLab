/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Question;
import model.Test;
import model.QuizAnswer;

public class TestsDAO extends dao {

    public static void main(String[] args) {
        TestsDAO t = new TestsDAO();
        System.out.println(t.getQuestionsByTest(1));
    }

    public List<Test> getTestsByInstructor(int instructorId) {
        List<Test> list = new ArrayList<>();
        String sql = "SELECT * FROM test WHERE created_by = ? ORDER BY id DESC";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, instructorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Test t = new Test();
                t.setId(rs.getInt("id"));
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));
                t.setCourseSectionId(rs.getInt("course_section_id"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Test getById(int id) {
        String sql = "SELECT * FROM test WHERE id = ?";
        Test t = null;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                t = new Test();
                t.setId(id);
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));
                t.setCourseSectionId(rs.getInt("course_section_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    public List<Test> getTestsByCourseId(int courseId) {
        List<Test> list = new ArrayList<>();
        String sql = "SELECT * FROM test  WHERE course_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Test t = new Test();
                t.setId(rs.getInt("id"));
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));
                t.setCourseSectionId(rs.getInt("course_section_id"));
                t.setCreatedBy(rs.getInt("created_by"));
                t.setUpdatedBy(rs.getInt("updated_by"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int createTest(Test t) {
        String sql = """
        INSERT INTO test 
        (code, title, description, time_interval, min_grade,
         course_id, course_section_id, created_by, updated_by)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, t.getCode());
            ps.setString(2, t.getTitle());
            ps.setString(3, t.getDescription());
            ps.setInt(4, t.getTimeInterval());
            ps.setInt(5, t.getMinGrade());
            ps.setInt(6, t.getCourseId());
            ps.setInt(7, t.getCourseSectionId());
            ps.setInt(8, t.getCreatedBy());
            ps.setInt(9, t.getUpdatedBy());

            ps.executeUpdate();
            rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public boolean updateTest(Test t) {
        String sql = """
            UPDATE test 
            SET code=?, title=?, description=?, time_interval=?, min_grade=?, 
                course_id=?, course_section_id=?, updated_by=? 
            WHERE id=?
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getCode());
            ps.setString(2, t.getTitle());
            ps.setString(3, t.getDescription());
            ps.setInt(4, t.getTimeInterval());
            ps.setInt(5, t.getMinGrade());
            ps.setInt(6, t.getCourseId());
            ps.setInt(7, t.getCourseSectionId());
            ps.setInt(8, t.getUpdatedBy());
            ps.setInt(9, t.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Question> getQuestionsByTest(int testId) {
        List<Question> list = new ArrayList<>();

        String sql = """
        SELECT q.id, q.question, q.type
        FROM quiz q
        JOIN quiz_test qt ON q.id = qt.quiz_id
        WHERE qt.test_id = ?
    """;

        try (Connection conn = dbc.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setContent(rs.getString("question"));
                q.setType(rs.getString("type")); // ★★★★★ BẮT BUỘC

                q.setAnswers(getAnswersByQuiz(q.getId(), conn));
                list.add(q);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private List<QuizAnswer> getAnswersByQuiz(int quizId, Connection conn) throws Exception {
        List<QuizAnswer> list = new ArrayList<>();

        String sql = "SELECT * FROM quiz_answer WHERE quiz_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                QuizAnswer a = new QuizAnswer();
                a.setId(rs.getInt("id"));
                a.setQuiz_id(rs.getInt("quiz_id"));
                a.setContent(rs.getString("content"));
                a.setIs_true(rs.getBoolean("is_true"));

                list.add(a);
            }
        }
        return list;
    }

    public Test getTestBySectionId(int sectionId) {
        String sql = "SELECT * FROM test WHERE course_section_id = ?";

        Test t = null;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, sectionId);
            rs = ps.executeQuery();

            if (rs.next()) {
                t = new Test();
                t.setId(rs.getInt("id"));
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));
                t.setCourseSectionId(rs.getInt("course_section_id"));
                t.setCreatedBy(rs.getInt("created_by"));
                t.setUpdatedBy(rs.getInt("updated_by"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setUpdatedAt(rs.getTimestamp("updated_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return t;
    }

    public boolean isCodeOrTitleExisted(String code, String title, Integer excludeId) {
        String sql = """
        SELECT COUNT(*) FROM test 
        WHERE (code = ? OR title = ?)
        """ + (excludeId != null ? " AND id <> ?" : "");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, code);
            ps.setString(2, title);
            if (excludeId != null) {
                ps.setInt(3, excludeId);
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isCourseTestExisted(int courseId, Integer excludeTestId) {
        String sql = """
        SELECT 1
        FROM test
        WHERE course_id = ?
          AND course_section_id = 0
          AND (? IS NULL OR id <> ?)
        LIMIT 1
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);

            if (excludeTestId == null) {
                ps.setNull(2, java.sql.Types.INTEGER);
                ps.setNull(3, java.sql.Types.INTEGER);
            } else {
                ps.setInt(2, excludeTestId);
                ps.setInt(3, excludeTestId);
            }

            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isSectionTestExisted(int courseId, int sectionId, Integer excludeTestId) {
        String sql = """
        SELECT 1
        FROM test
        WHERE course_id = ?
          AND course_section_id = ?
          AND (? IS NULL OR id <> ?)
        LIMIT 1
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            ps.setInt(2, sectionId);

            if (excludeTestId == null) {
                ps.setNull(3, java.sql.Types.INTEGER);
                ps.setNull(4, java.sql.Types.INTEGER);
            } else {
                ps.setInt(3, excludeTestId);
                ps.setInt(4, excludeTestId);
            }

            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Test getCourseTestByCourseId(int courseId) {
        String sql = """
        SELECT * 
        FROM test
        WHERE course_id = ?
          AND course_section_id = 0
        LIMIT 1
    """;

        Test t = null;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();

            if (rs.next()) {
                t = new Test();
                t.setId(rs.getInt("id"));
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));

                t.setCourseSectionId(0);

                t.setCreatedBy(rs.getInt("created_by"));
                t.setUpdatedBy(rs.getInt("updated_by"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setUpdatedAt(rs.getTimestamp("updated_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return t;
    }

    public boolean deleteTest(int testId) {
        String deleteTestAttemptSql = "DELETE FROM test_attempt WHERE test_id = ?";
        String deleteTestSql = "DELETE FROM test WHERE id = ?";

        try {
            con = dbc.getConnection();
            con.setAutoCommit(false); // bắt đầu transaction

            // Xóa test_attempt
            ps = con.prepareStatement(deleteTestAttemptSql);
            ps.setInt(1, testId);
            ps.executeUpdate();

            // Xóa test
            ps = con.prepareStatement(deleteTestSql);
            ps.setInt(1, testId);
            int rowsAffected = ps.executeUpdate();

            con.commit(); // commit transaction
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (con != null) {
                    con.rollback(); // rollback nếu lỗi
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
