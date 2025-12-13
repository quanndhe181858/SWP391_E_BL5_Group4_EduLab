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
 * Handles business logic, validation, and data integration
 *
 * @author Le Minh Duc
 */
public class QuizServices {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private QuizDAO quizDAO = new QuizDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    public static void main(String[] args) {
        QuizServices qs = new QuizServices();
        System.out.println("Total quizzes: " + qs.countQuizzes("", "", 0));

        // Test getting quizzes with category information
        List<Quiz> quizzes = qs.getAllQuizzes();
        if (quizzes != null && !quizzes.isEmpty()) {
            System.out.println("First quiz: " + quizzes.get(0));
            System.out.println("Category: " + (quizzes.get(0).getCategory() != null ?
                    quizzes.get(0).getCategory().getName() : "No category"));
        }
    }

    /**
     * Creates a new quiz with validation
     *
     * @param quiz Quiz object to create
     * @param uid  User ID of the creator
     * @return Created Quiz object or null if creation fails
     */
    public Quiz createQuiz(Quiz quiz, int uid) {
        try {
            boolean isValid = isValid(quiz);
            if (isValid) {
                Quiz createdQuiz = quizDAO.createQuiz(quiz, uid);
                if (createdQuiz != null) {
                    // Load category information
                    Category category = categoryDAO.getCategoryById(createdQuiz.getCategory_id());
                    createdQuiz.setCategory(category);
                }
                return createdQuiz;
            }
            return null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error creating quiz", e);
            return null;
        }
    }

    /**
     * Retrieves a quiz by its ID
     *
     * @param id Quiz ID
     * @return Quiz object with category information or null if not found
     */
    public Quiz getQuizById(int id) {
        try {
            Quiz quiz = quizDAO.getQuizById(id);
            if (quiz != null) {
                // Load category information
                Category category = categoryDAO.getCategoryById(quiz.getCategory_id());
                quiz.setCategory(category);
            }
            return quiz;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting quiz by ID: " + id, e);
            return null;
        }
    }

    /**
     * Updates an existing quiz
     *
     * @param quiz Quiz object with updated information
     * @param uid  User ID of the updater
     * @return true if update was successful, false otherwise
     */
    public boolean updateQuiz(Quiz quiz, int uid) {
        try {
            Quiz updatedQuiz = quizDAO.updateQuiz(quiz, uid);
            return updatedQuiz != null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating quiz ID: " + quiz.getId(), e);
            return false;
        }
    }

    /**
     * Deletes a quiz by its ID
     *
     * @param id Quiz ID to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteQuiz(int id) {
        try {
            return quizDAO.deleteQuiz(id);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting quiz ID: " + id, e);
            return false;
        }
    }

    /**
     * Retrieves all quizzes with category information
     *
     * @return List of Quiz objects with category information
     */
    public List<Quiz> getAllQuizzes() {
        try {
            List<Quiz> quizzes = quizDAO.getAllQuizzes();
            if (quizzes != null) {
                // Load category information for each quiz
                for (Quiz quiz : quizzes) {
                    Category category = categoryDAO.getCategoryById(quiz.getCategory_id());
                    quiz.setCategory(category);
                }
            }
            return quizzes;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting all quizzes", e);
            return null;
        }
    }

    /**
     * Retrieves quizzes by category ID
     *
     * @param categoryId Category ID to filter by
     * @return List of Quiz objects in the specified category
     */
    public List<Quiz> getQuizzesByCategory(int categoryId) {
        try {
            List<Quiz> quizzes = quizDAO.getQuizzesByCategory(categoryId);
            if (quizzes != null) {
                // Load category information for each quiz
                Category category = categoryDAO.getCategoryById(categoryId);
                for (Quiz quiz : quizzes) {
                    quiz.setCategory(category);
                }
            }
            return quizzes;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting quizzes by category ID: " + categoryId, e);
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
            List<Quiz> quizzes = quizDAO.getQuizzesByType(type);
            if (quizzes != null) {
                // Load category information for each quiz
                for (Quiz quiz : quizzes) {
                    Category category = categoryDAO.getCategoryById(quiz.getCategory_id());
                    quiz.setCategory(category);
                }
            }
            return quizzes;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting quizzes by type: " + type, e);
            return null;
        }
    }

    /**
     * Gets random quizzes for a specific course
     *
     * @param courseId Course ID
     * @param amount   Number of quizzes to retrieve
     * @return List of random Quiz objects
     */
    public List<Quiz> getRandomQuizzesByCourse(int courseId, int amount) {
        try {
            List<Quiz> quizzes = quizDAO.getRandomQuizzesByCourse(courseId, amount);
            if (quizzes != null) {
                // Load category information for each quiz
                for (Quiz quiz : quizzes) {
                    Category category = categoryDAO.getCategoryById(quiz.getCategory_id());
                    quiz.setCategory(category);
                }
            }
            return quizzes;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting random quizzes for course ID: " + courseId, e);
            return null;
        }
    }

    /**
     * Counts total number of quizzes with filters
     *
     * @param question   Question text to search for
     * @param type       Quiz type to filter by
     * @param categoryId Category ID to filter by (0 for all categories)
     * @return Total count of quizzes matching the criteria
     */
    public int countQuizzes(String question, String type, int categoryId) {
        try {
            // For now, this returns count of all quizzes
            // If QuizDAO had a countQuizzes method with filters, we would use it
            List<Quiz> allQuizzes = quizDAO.getAllQuizzes();
            if (allQuizzes == null) return 0;

            // Apply filters manually since QuizDAO doesn't have filtered count method
            int count = 0;
            for (Quiz quiz : allQuizzes) {
                boolean matches = true;

                // Filter by question text
                if (question != null && !question.trim().isEmpty()) {
                    if (quiz.getQuestion() == null ||
                            !quiz.getQuestion().toLowerCase().contains(question.toLowerCase())) {
                        matches = false;
                    }
                }

                // Filter by type
                if (type != null && !type.trim().isEmpty()) {
                    if (quiz.getType() == null || !quiz.getType().equals(type)) {
                        matches = false;
                    }
                }

                // Filter by category
                if (categoryId > 0) {
                    if (quiz.getCategory_id() != categoryId) {
                        matches = false;
                    }
                }

                if (matches) count++;
            }

            return count;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error counting quizzes", e);
            return 0;
        }
    }

    /**
     * Counts quizzes by category
     *
     * @param categoryId Category ID
     * @return Count of quizzes in the specified category
     */
    public int countQuizzesByCategory(int categoryId) {
        try {
            List<Quiz> quizzes = quizDAO.getQuizzesByCategory(categoryId);
            return quizzes != null ? quizzes.size() : 0;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error counting quizzes by category ID: " + categoryId, e);
            return 0;
        }
    }

    /**
     * Counts quizzes by type
     *
     * @param type Quiz type
     * @return Count of quizzes of the specified type
     */
    public int countQuizzesByType(String type) {
        try {
            List<Quiz> quizzes = quizDAO.getQuizzesByType(type);
            return quizzes != null ? quizzes.size() : 0;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error counting quizzes by type: " + type, e);
            return 0;
        }
    }

    /**
     * Validates if a quiz is valid for creation
     * Checks for duplicate questions in the same category
     *
     * @param quiz Quiz to validate
     * @return true if quiz is valid, false otherwise
     */
    public boolean isValid(Quiz quiz) {
        try {
            // Check if required fields are present
            if (quiz.getQuestion() == null || quiz.getQuestion().trim().isEmpty()) {
                logger.log(Level.WARNING, "Quiz validation failed: Question is required");
                return false;
            }

            if (quiz.getType() == null || quiz.getType().trim().isEmpty()) {
                logger.log(Level.WARNING, "Quiz validation failed: Type is required");
                return false;
            }

            if (quiz.getCategory_id() <= 0) {
                logger.log(Level.WARNING, "Quiz validation failed: Valid category is required");
                return false;
            }

            // Check if category exists
            Category category = categoryDAO.getCategoryById(quiz.getCategory_id());
            if (category == null) {
                logger.log(Level.WARNING, "Quiz validation failed: Category does not exist");
                return false;
            }

            // Check for duplicate questions in the same category
            List<Quiz> existingQuizzes = quizDAO.getQuizzesByCategory(quiz.getCategory_id());
            if (existingQuizzes != null) {
                for (Quiz existing : existingQuizzes) {
                    if (existing.getQuestion() != null &&
                            existing.getQuestion().trim().equalsIgnoreCase(quiz.getQuestion().trim())) {
                        // If updating, allow the same question for the same quiz
                        if (quiz.getId() > 0 && existing.getId() == quiz.getId()) {
                            continue;
                        }
                        logger.log(Level.WARNING, "Quiz validation failed: Duplicate question in category");
                        return false;
                    }
                }
            }

            return true;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error validating quiz", e);
            return false;
        }
    }

    /**
     * Checks if a quiz exists by ID
     *
     * @param id Quiz ID to check
     * @return true if quiz exists, false otherwise
     */
    public boolean isExist(int id) {
        try {
            Quiz quiz = quizDAO.getQuizById(id);
            return quiz != null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error checking if quiz exists for ID: " + id, e);
            return false;
        }
    }
}
