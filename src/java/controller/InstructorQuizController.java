/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.QuizDAO;
import model.Quiz;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for Quiz operations
 * @author Le Minh Duc
 */
@WebServlet(name = "InstructorQuizController", urlPatterns = {"/instructor/quizes"})
public class InstructorQuizController extends HttpServlet {
    
    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private QuizDAO quizDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        quizDAO = new QuizDAO();
    }
    
    /**
     * Handles GET requests - displays quiz list
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                // Default action: show quiz list
                showQuizList(request, response);
            } else {
                switch (action) {
                    case "list":
                        showQuizList(request, response);
                        break;
                    case "view":
                        viewQuizDetail(request, response);
                        break;
                    case "delete":
                        deleteQuiz(request, response);
                        break;
                    case "add":
                        showCreateForm(request, response);
                        break;
                    default:
                        showQuizList(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in QuizController doGet", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Handles POST requests - creates or updates quiz
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                showQuizList(request, response);
            } else {
                switch (action) {
                    case "create":
                        createQuiz(request, response);
                        break;
                    case "update":
                        updateQuiz(request, response);
                        break;
                    default:
                        showQuizList(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in QuizController doPost", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    /**
     * Displays the list of all quizzes
     */
    private void showQuizList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get filter parameters if any
        String categoryIdParam = request.getParameter("categoryId");
        String typeParam = request.getParameter("type");
        
        List<Quiz> quizList;
        
        // Apply filters if provided
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdParam);
            quizList = quizDAO.getQuizzesByCategory(categoryId);
        } else if (typeParam != null && !typeParam.isEmpty()) {
            quizList = quizDAO.getQuizzesByType(typeParam);
        } else {
            quizList = quizDAO.getAllQuizzes();
        }
        
        request.setAttribute("quizList", quizList);
        request.setAttribute("totalQuizzes", quizList.size());
        request.getRequestDispatcher("/quizList.jsp").forward(request, response);
    }
    
    /**
     * Displays details of a specific quiz
     */
    private void viewQuizDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int quizId = Integer.parseInt(request.getParameter("id"));
        Quiz quiz = quizDAO.getQuizById(quizId);
        
        if (quiz != null) {
            request.setAttribute("quiz", quiz);
            request.getRequestDispatcher("/quizDetail.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Quiz not found with ID: " + quizId);
            showQuizList(request, response);
        }
    }
    
    /**
     * Shows the form to create a new quiz
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/addQuiz.jsp").forward(request, response);
    }
    
    /**
     * Creates a new quiz
     */
    private void createQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form parameters
        String question = request.getParameter("question");
        String type = request.getParameter("type");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        
        // Get user ID from session (assuming user is logged in)
        // For now, using a default value
        int userId = 1; // TODO: Get from session
        
        // Create quiz object
        Quiz quiz = new Quiz();
        quiz.setQuestion(question);
        quiz.setType(type);
        quiz.setCategory_id(categoryId);
        
        // Save to database
        Quiz createdQuiz = quizDAO.createQuiz(quiz, userId);
        
        if (createdQuiz != null) {
            request.setAttribute("success", "Quiz created successfully!");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
        } else {
            request.setAttribute("error", "Failed to create quiz.");
            request.getRequestDispatcher("/addQuiz.jsp").forward(request, response);
        }
    }
    
    private void updateQuiz(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Get form parameters
    int quizId = Integer.parseInt(request.getParameter("id"));
    String question = request.getParameter("question");
    String type = request.getParameter("type");
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    
    // Get user ID from session
    int userId = 1; // TODO: Get from session
    
    // Create quiz object with updated data
    Quiz quiz = new Quiz();
    quiz.setId(quizId);
    quiz.setQuestion(question);
    quiz.setType(type);
    quiz.setCategory_id(categoryId);
    
    // Update in database
    Quiz updatedQuiz = quizDAO.updateQuiz(quiz, userId);
    
    if (updatedQuiz != null) {
        // Send success message as session attribute
        request.getSession().setAttribute("success", "Quiz updated successfully!");
    } else {
        // Send error message as session attribute
        request.getSession().setAttribute("error", "Failed to update quiz.");
    }
    
    // Redirect back to list page
    response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
}
    
    /**
     * Deletes a quiz
     */
    private void deleteQuiz(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    int quizId = Integer.parseInt(request.getParameter("id"));
    
    // We attempt to delete
    boolean deleted = quizDAO.deleteQuiz(quizId);
    
    // Get the Session object
    HttpSession session = request.getSession();
    
    if (deleted) {
        session.setAttribute("notification", "Quiz deleted successfully!");
        session.setAttribute("notificationType", "success");
    } else {
        // This is the message that will pop up if deletion fails (e.g., linked answers)
        session.setAttribute("notification", "Unable to delete: This quiz is linked to existing tests or student results.");
        session.setAttribute("notificationType", "error");
    }
    
    // Redirect to the list
    response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
}
    
    @Override
    public String getServletInfo() {
        return "Quiz Controller - Handles CRUD operations for quizzes";
    }
}