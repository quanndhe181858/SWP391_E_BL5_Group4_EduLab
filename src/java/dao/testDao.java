package dao;

import database.DBContext;
import java.sql.*;
import java.util.*;
import model.Question;
import model.Answer;

public class testDao extends DBContext {

    public List<Question> getQuestionsByTest(int testId) {
        List<Question> list = new ArrayList<>();

        String sql = "SELECT * FROM test_question WHERE test_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setTestId(rs.getInt("test_id"));
                q.setContent(rs.getString("content"));

                q.setAnswers(getAnswers(q.getId(), conn));
                list.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private List<Answer> getAnswers(int questionId, Connection conn) throws Exception {
        List<Answer> list = new ArrayList<>();

        String sql = "SELECT * FROM test_answer WHERE question_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, questionId);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Answer a = new Answer();
            a.setId(rs.getInt("id"));
            a.setQuestionId(rs.getInt("question_id"));
            a.setContent(rs.getString("content"));
            a.setCorrect(rs.getBoolean("is_correct"));

            list.add(a);
        }
        return list;
    }
}
