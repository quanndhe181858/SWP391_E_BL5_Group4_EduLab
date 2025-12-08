package dao;

import database.DBContext;
import java.sql.*;
import java.util.*;
import model.Question;
import model.Answer;

public class testDao extends DBContext {

    /**
     * Lấy danh sách câu hỏi theo test_id
     */
    public List<Question> getQuestionsByTest(int testId) {
        List<Question> list = new ArrayList<>();

        String sql = """
            SELECT q.id, q.content
            FROM quiz q
            JOIN quiz_test qt ON q.id = qt.quiz_id
            WHERE qt.test_id = ?
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setContent(rs.getString("content"));

                q.setAnswers(getAnswersByQuiz(q.getId(), conn));
                list.add(q);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

  
    private List<Answer> getAnswersByQuiz(int quizId, Connection conn) throws Exception {
        List<Answer> list = new ArrayList<>();

        String sql = "SELECT * FROM quiz_answer WHERE quiz_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Answer a = new Answer();
                a.setId(rs.getInt("id"));
                a.setQuestionId(rs.getInt("quiz_id"));
                a.setContent(rs.getString("content"));
                a.setCorrect(rs.getBoolean("is_true"));

                list.add(a);
            }
        }
        return list;
    }
}
