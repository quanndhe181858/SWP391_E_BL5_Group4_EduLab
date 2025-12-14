/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import model.QuizAnswer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for QuizAnswer table operations
 *
 * @author Le Minh Duc
 */
public class QuizAnswerDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        QuizAnswerDAO dao = new QuizAnswerDAO();

        // Test getAllQuizAnswers
        List<QuizAnswer> answers = dao.getAllQuizAnswers();
        System.out.println("Total answers: " + answers.size());
        for (QuizAnswer a : answers) {
            System.out.println(a);
        }
    }

    /**
     * Creates a new quiz answer in the database
     *
     * @param answer QuizAnswer object to create
     * @param uid User ID of the creator
     * @return QuizAnswer object with generated ID, or null if creation fails
     */
    public QuizAnswer createQuizAnswer(QuizAnswer answer, int uid) {
        String sql = """
                INSERT INTO `edulab`.`quiz_answer`
                (`quiz_id`,
                `is_true`,
                `type`,
                `content`,
                `created_by`,
                `updated_by`)
                VALUES
                (?, ?, ?, ?, ?, ?);
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, answer.getQuiz_id());
            ps.setBoolean(2, answer.isIs_true());
            ps.setString(3, answer.getType());
            ps.setString(4, answer.getContent());
            ps.setInt(5, uid);
            ps.setInt(6, uid);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                answer.setId(generatedId);
            }

            return answer;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while createQuizAnswer() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Updates an existing quiz answer in the database
     *
     * @param answer QuizAnswer object with updated information
     * @param uid User ID of the updater
     * @return QuizAnswer object if update was successful, null otherwise
     */
    public QuizAnswer updateQuizAnswer(QuizAnswer answer, int uid) {
        String sql = """
                UPDATE `edulab`.`quiz_answer`
                SET
                    `quiz_id` = ?,
                    `is_true` = ?,
                    `type` = ?,
                    `content` = ?,
                    `updated_by` = ?
                WHERE `id` = ?;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, answer.getQuiz_id());
            ps.setBoolean(2, answer.isIs_true());
            ps.setString(3, answer.getType());
            ps.setString(4, answer.getContent());
            ps.setInt(5, uid);
            ps.setInt(6, answer.getId());

            int rows = ps.executeUpdate();

            // If no row updated => answer does not exist
            if (rows == 0) {
                return null;
            }

            return answer;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while updateQuizAnswer() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Deletes a quiz answer from the database
     *
     * @param id ID of the quiz answer to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteQuizAnswer(int id) {
        String sql = "DELETE FROM `edulab`.`quiz_answer` WHERE `id` = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            if (e.getSQLState().startsWith("23")) {
                System.out.println("Cannot delete quiz answer ID " + id + " because it has linked data.");
            } else {
                this.log(Level.SEVERE, "Something wrong while deleteQuizAnswer() execute!", e);
            }
            return false;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Retrieves a quiz answer by its ID
     *
     * @param id ID of the quiz answer to retrieve
     * @return QuizAnswer object if found, null otherwise
     */
    public QuizAnswer getQuizAnswerById(int id) {
        String sql = """
                SELECT
                    id,
                    quiz_id,
                    is_true,
                    type,
                    content,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz_answer
                WHERE id = ?;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                QuizAnswer answer = new QuizAnswer();

                answer.setId(rs.getInt("id"));
                answer.setQuiz_id(rs.getInt("quiz_id"));
                answer.setIs_true(rs.getBoolean("is_true"));
                answer.setType(rs.getString("type"));
                answer.setContent(rs.getString("content"));
                answer.setCreated_at(rs.getTimestamp("created_at"));
                answer.setUpdated_at(rs.getTimestamp("updated_at"));
                answer.setCreated_by(rs.getInt("created_by"));
                answer.setUpdated_by(rs.getInt("updated_by"));

                return answer;
            }

            return null;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getQuizAnswerById() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Retrieves all quiz answers from the database
     *
     * @return List of all QuizAnswer objects
     */
    public List<QuizAnswer> getAllQuizAnswers() {
        String sql = """
                SELECT
                    id,
                    quiz_id,
                    is_true,
                    type,
                    content,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz_answer;
                """;
        List<QuizAnswer> answers = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                QuizAnswer answer = new QuizAnswer();
                answer.setId(rs.getInt("id"));
                answer.setQuiz_id(rs.getInt("quiz_id"));
                answer.setIs_true(rs.getBoolean("is_true"));
                answer.setType(rs.getString("type"));
                answer.setContent(rs.getString("content"));
                answer.setCreated_at(rs.getTimestamp("created_at"));
                answer.setUpdated_at(rs.getTimestamp("updated_at"));
                answer.setCreated_by(rs.getInt("created_by"));
                answer.setUpdated_by(rs.getInt("updated_by"));

                answers.add(answer);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getAllQuizAnswers() execute!", e);
        } finally {
            this.closeResources();
        }

        return answers;
    }

    /**
     * Retrieves quiz answers by quiz ID
     *
     * @param quizId Quiz ID to filter by
     * @return List of QuizAnswer objects for the specified quiz
     */
    public List<QuizAnswer> getQuizAnswersByQuizId(int quizId) {
        String sql = """
                SELECT
                    id,
                    quiz_id,
                    is_true,
                    type,
                    content,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz_answer
                WHERE quiz_id = ?;
                """;
        List<QuizAnswer> answers = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);

            rs = ps.executeQuery();

            while (rs.next()) {
                QuizAnswer answer = new QuizAnswer();
                answer.setId(rs.getInt("id"));
                answer.setQuiz_id(rs.getInt("quiz_id"));
                answer.setIs_true(rs.getBoolean("is_true"));
                answer.setType(rs.getString("type"));
                answer.setContent(rs.getString("content"));
                answer.setCreated_at(rs.getTimestamp("created_at"));
                answer.setUpdated_at(rs.getTimestamp("updated_at"));
                answer.setCreated_by(rs.getInt("created_by"));
                answer.setUpdated_by(rs.getInt("updated_by"));

                answers.add(answer);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getQuizAnswersByQuizId() execute!", e);
        } finally {
            this.closeResources();
        }

        return answers;
    }

    public boolean isCorrect(int answerId) {
        String sql = "SELECT is_true FROM quiz_answer WHERE id = ?";
        // dùng dbc.getConnection() cho nhất quán với các method khác trong class
        try (Connection c = dbc.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, answerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBoolean("is_true");
                }
            }
        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in isCorrect()", e);
        }
        return false;
    }

    /**
     * Retrieves quiz answers by type
     *
     * @param type Answer type to filter by
     * @return List of QuizAnswer objects of the specified type
     */
    public List<QuizAnswer> getQuizAnswersByType(String type) {
        String sql = """
                SELECT
                    id,
                    quiz_id,
                    is_true,
                    type,
                    content,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz_answer
                WHERE type = ?;
                """;
        List<QuizAnswer> answers = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, type);

            rs = ps.executeQuery();

            while (rs.next()) {
                QuizAnswer answer = new QuizAnswer();
                answer.setId(rs.getInt("id"));
                answer.setQuiz_id(rs.getInt("quiz_id"));
                answer.setIs_true(rs.getBoolean("is_true"));
                answer.setType(rs.getString("type"));
                answer.setContent(rs.getString("content"));
                answer.setCreated_at(rs.getTimestamp("created_at"));
                answer.setUpdated_at(rs.getTimestamp("updated_at"));
                answer.setCreated_by(rs.getInt("created_by"));
                answer.setUpdated_by(rs.getInt("updated_by"));

                answers.add(answer);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getQuizAnswersByType() execute!", e);
        } finally {
            this.closeResources();
        }

        return answers;
    }

    public List<QuizAnswer> getAnswersByQuizId(int quizId) {
        String sql = """
        SELECT id, content
        FROM quiz_answer
        WHERE quiz_id = ?
    """;

        List<QuizAnswer> list = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();

            while (rs.next()) {
                QuizAnswer a = new QuizAnswer();
                a.setId(rs.getInt("id"));
                a.setContent(rs.getString("content"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

}
