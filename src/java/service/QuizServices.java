/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.CategoryDAO;
import dao.QuizDAO;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Quiz;

/**
 * Service layer for Quiz operations
 * 
 * @author Le Minh Duc
 */
public class QuizServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private QuizDAO quizDao = new QuizDAO();
    private CategoryDAO categoryDao = new CategoryDAO();

    /**
     * Creates a new quiz
     * 
     * @param quiz Quiz object to create
     * @param uid  User ID of the creator
     * @return Created Quiz with generated ID, or null if creation fails
     */
    public Quiz createQuiz(Quiz quiz, int uid) {
        try {
            return quizDao.createQuiz(quiz, uid);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    /**
     * Retrieves a quiz by its ID
     * 
     * @param id Quiz ID
     * @return Quiz object if found, null otherwise
     */
    public Quiz getQuizById(int id) {
        try {
            Quiz quiz = quizDao.getQuizById(id);
            if (quiz != null) {
                Category c = categoryDao.getCategoryById(quiz.getCategory_id());
                quiz.setCategory(c);
            }
            return quiz;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    /**
     * Updates an existing quiz
     * 
     * @param quiz Quiz object with updated data
     * @param uid  User ID of the updater
     * @return Updated Quiz, or null if update fails
     */
    public Quiz updateQuiz(Quiz quiz, int uid) {
        try {
            return quizDao.updateQuiz(quiz, uid);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    /**
     * Deletes a quiz by its ID
     * 
     * @param id Quiz ID to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteQuiz(int id) {
        try {
            return quizDao.deleteQuiz(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

    /**
     * Retrieves all quizzes
     * 
     * @return List of all Quiz objects
     */
    public List<Quiz> getAllQuizzes() {
        try {
            List<Quiz> quizList = quizDao.getAllQuizzes();
            for (Quiz quiz : quizList) {
                Category c = categoryDao.getCategoryById(quiz.getCategory_id());
                quiz.setCategory(c);
            }
            return quizList;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    /**
     * Retrieves quizzes by category
     * 
     * @param categoryId Category ID to filter by
     * @return List of Quiz objects in the category
     */
    public List<Quiz> getQuizzesByCategory(int categoryId) {
        try {
            List<Quiz> quizList = quizDao.getQuizzesByCategory(categoryId);
            for (Quiz quiz : quizList) {
                Category c = categoryDao.getCategoryById(quiz.getCategory_id());
                quiz.setCategory(c);
            }
            return quizList;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    /**
     * Retrieves quizzes by type
     * 
     * @param type Quiz type to filter by
     * @return List of Quiz objects of the specified type
     */
    public List<Quiz> getQuizzesByType(String type) {
        try {
            List<Quiz> quizList = quizDao.getQuizzesByType(type);
            for (Quiz quiz : quizList) {
                Category c = categoryDao.getCategoryById(quiz.getCategory_id());
                quiz.setCategory(c);
            }
            return quizList;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

    /**
     * Retrieves quizzes by creator
     * 
     * @param creatorId User ID of the creator
     * @return List of Quiz objects created by the user
     */
    public List<Quiz> getQuizzesByCreator(int creatorId) {
        try {
            List<Quiz> quizList = quizDao.getAllQuizzes();
            // Filter by creator
            quizList.removeIf(q -> q.getCreated_by() != creatorId);
            for (Quiz quiz : quizList) {
                Category c = categoryDao.getCategoryById(quiz.getCategory_id());
                quiz.setCategory(c);
            }
            return quizList;
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }

}
