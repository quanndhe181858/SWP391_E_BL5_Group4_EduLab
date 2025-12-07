/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import model.Quiz;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Data Access Object for Quiz table operations
 * 
 * @author Le Minh Duc
 */
public class QuizDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        QuizDAO dao = new QuizDAO();

        Quiz q = new Quiz();
        q.setQuestion("What is polymorphism in Java?");
        q.setType("Multiple Choice");
        q.setCategory_id(1);

        Quiz created = dao.createQuiz(q, 1); // uid = 1 (creator)
        System.out.println("Created Quiz:");
        System.out.println(created);

        Quiz found = dao.getQuizById(created.getId());
        System.out.println("Found Quiz:");
        System.out.println(found);

        found.setQuestion("What is polymorphism in OOP?");
        found.setType("True/False");

        Quiz updated = dao.updateQuiz(found, 1); // uid = 1 (updater)
        System.out.println("Updated Quiz:");
        System.out.println(updated);

        boolean deleted = dao.deleteQuiz(updated.getId());
        System.out.println("Deleted? " + deleted);
    }

    /**
     * Creates a new quiz in the database
     * 
     * @param quiz Quiz object to create
     * @param uid  User ID of the creator
     * @return Quiz object with generated ID, or null if creation fails
     */
    public Quiz createQuiz(Quiz quiz, int uid) {
        String sql = """
                INSERT INTO `edulab`.`quiz`
                (`question`,
                `type`,
                `category_id`,
                `created_by`,
                `updated_by`)
                VALUES
                (?, ?, ?, ?, ?);
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, quiz.getQuestion());
            ps.setString(2, quiz.getType());
            ps.setInt(3, quiz.getCategory_id());
            ps.setInt(4, uid);
            ps.setInt(5, uid);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                quiz.setId(generatedId);
            }

            return quiz;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while createQuiz() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Updates an existing quiz in the database
     * 
     * @param quiz Quiz object with updated information
     * @param uid  User ID of the updater
     * @return Quiz object if update was successful, null otherwise
     */
    public Quiz updateQuiz(Quiz quiz, int uid) {
        String sql = """
                UPDATE `edulab`.`quiz`
                SET
                    `question` = ?,
                    `type` = ?,
                    `category_id` = ?,
                    `updated_by` = ?
                WHERE `id` = ?;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, quiz.getQuestion());
            ps.setString(2, quiz.getType());
            ps.setInt(3, quiz.getCategory_id());
            ps.setInt(4, uid);
            ps.setInt(5, quiz.getId());

            int rows = ps.executeUpdate();

            // If no row updated => quiz does not exist
            if (rows == 0) {
                return null;
            }

            return quiz;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while updateQuiz() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Deletes a quiz from the database
     * 
     * @param id ID of the quiz to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteQuiz(int id) {
        String sql = "DELETE FROM `edulab`.`quiz` WHERE `id` = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            // SQLState "23000" usually refers to Integrity Constraint Violation (Foreign
            // Key)
            if (e.getSQLState().startsWith("23")) {
                System.out.println("Cannot delete quiz ID " + id + " because it has linked data.");
            } else {
                this.log(Level.SEVERE, "Something wrong while deleteQuiz() execute!", e);
            }
            return false;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Retrieves a quiz by its ID
     * 
     * @param id ID of the quiz to retrieve
     * @return Quiz object if found, null otherwise
     */
    public Quiz getQuizById(int id) {
        String sql = """
                SELECT
                    id,
                    question,
                    type,
                    category_id,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz
                WHERE id = ?;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                Quiz quiz = new Quiz();

                quiz.setId(rs.getInt("id"));
                quiz.setQuestion(rs.getString("question"));
                quiz.setType(rs.getString("type"));
                quiz.setCategory_id(rs.getInt("category_id"));
                quiz.setCreated_at(rs.getTimestamp("created_at"));
                quiz.setUpdated_at(rs.getTimestamp("updated_at"));
                quiz.setCreated_by(rs.getInt("created_by"));
                quiz.setUpdated_by(rs.getInt("updated_by"));

                return quiz;
            }

            return null;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getQuizById() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    /**
     * Retrieves all quizzes from the database
     * 
     * @return List of all Quiz objects
     */
    public List<Quiz> getAllQuizzes() {
        String sql = """
                SELECT
                    id,
                    question,
                    type,
                    category_id,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz;
                """;
        List<Quiz> quizzes = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setQuestion(rs.getString("question"));
                quiz.setType(rs.getString("type"));
                quiz.setCategory_id(rs.getInt("category_id"));
                quiz.setCreated_at(rs.getTimestamp("created_at"));
                quiz.setUpdated_at(rs.getTimestamp("updated_at"));
                quiz.setCreated_by(rs.getInt("created_by"));
                quiz.setUpdated_by(rs.getInt("updated_by"));

                quizzes.add(quiz);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getAllQuizzes() execute!", e);
        } finally {
            this.closeResources();
        }

        return quizzes;
    }

    /**
     * Retrieves quizzes by category ID
     * 
     * @param categoryId Category ID to filter by
     * @return List of Quiz objects in the specified category
     */
    public List<Quiz> getQuizzesByCategory(int categoryId) {
        String sql = """
                SELECT
                    id,
                    question,
                    type,
                    category_id,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz
                WHERE category_id = ?;
                """;
        List<Quiz> quizzes = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, categoryId);

            rs = ps.executeQuery();

            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setQuestion(rs.getString("question"));
                quiz.setType(rs.getString("type"));
                quiz.setCategory_id(rs.getInt("category_id"));
                quiz.setCreated_at(rs.getTimestamp("created_at"));
                quiz.setUpdated_at(rs.getTimestamp("updated_at"));
                quiz.setCreated_by(rs.getInt("created_by"));
                quiz.setUpdated_by(rs.getInt("updated_by"));

                quizzes.add(quiz);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getQuizzesByCategory() execute!", e);
        } finally {
            this.closeResources();
        }

        return quizzes;
    }

    /**
     * Retrieves quizzes by type
     * 
     * @param type Quiz type to filter by
     * @return List of Quiz objects of the specified type
     */
    public List<Quiz> getQuizzesByType(String type) {
        String sql = """
                SELECT
                    id,
                    question,
                    type,
                    category_id,
                    created_at,
                    updated_at,
                    created_by,
                    updated_by
                FROM edulab.quiz
                WHERE type = ?;
                """;
        List<Quiz> quizzes = new ArrayList<>();

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, type);

            rs = ps.executeQuery();

            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setQuestion(rs.getString("question"));
                quiz.setType(rs.getString("type"));
                quiz.setCategory_id(rs.getInt("category_id"));
                quiz.setCreated_at(rs.getTimestamp("created_at"));
                quiz.setUpdated_at(rs.getTimestamp("updated_at"));
                quiz.setCreated_by(rs.getInt("created_by"));
                quiz.setUpdated_by(rs.getInt("updated_by"));

                quizzes.add(quiz);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getQuizzesByType() execute!", e);
        } finally {
            this.closeResources();
        }

        return quizzes;
    }
}