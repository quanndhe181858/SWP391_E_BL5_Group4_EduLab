/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import dao.QuizDAO;
import model.Quiz;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for Quiz operations
 * Updated to support new frontend with pagination, filtering, sorting, and
 * statistics
 * 
 * @author Le Minh Duc
 */
@WebServlet(name = "InstructorQuizController", urlPatterns = { "/instructor/quizes" })
public class InstructorQuizController extends HttpServlet {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private QuizDAO quizDAO;
    private static final int ITEMS_PER_PAGE = 10;

    @Override
    public void init() throws ServletException {
        super.init();
        quizDAO = new QuizDAO();
    }

    /**
     * Handles GET requests - displays quiz list, forms, etc.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                showQuizList(request, response);
            } else {
                switch (action) {
                    case "list":
                        showQuizList(request, response);
                        break;
                    case "add":
                        showCreateForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    default:
                        showQuizList(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in QuizController doGet", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("../Error/error.jsp").forward(request, response);
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
                    case "delete":
                        deleteQuiz(request, response);
                        break;
                    default:
                        showQuizList(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in QuizController doPost", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("../Error/error.jsp").forward(request, response);
        }
    }

    /**
     * Displays the list of quizzes with filtering, searching, sorting, and
     * pagination
     */
    private void showQuizList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get filter parameters
        String categoryIdParam = request.getParameter("categoryId");
        String typeParam = request.getParameter("type");
        String searchParam = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        String pageParam = request.getParameter("page");

        // Get all quizzes first
        List<Quiz> allQuizzes = quizDAO.getAllQuizzes();
        List<Quiz> filteredQuizzes = new ArrayList<>(allQuizzes);

        // Apply category filter
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);
                filteredQuizzes = filteredQuizzes.stream()
                        .filter(q -> q.getCategory_id() == categoryId)
                        .collect(Collectors.toList());
            } catch (NumberFormatException e) {
                logger.log(Level.WARNING, "Invalid categoryId: " + categoryIdParam);
            }
        }

        // Apply type filter
        if (typeParam != null && !typeParam.isEmpty()) {
            filteredQuizzes = filteredQuizzes.stream()
                    .filter(q -> typeParam.equals(q.getType()))
                    .collect(Collectors.toList());
        }

        // Apply search filter
        if (searchParam != null && !searchParam.trim().isEmpty()) {
            String searchLower = searchParam.trim().toLowerCase();
            filteredQuizzes = filteredQuizzes.stream()
                    .filter(q -> q.getQuestion() != null &&
                            q.getQuestion().toLowerCase().contains(searchLower))
                    .collect(Collectors.toList());
        }

        // Apply sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "question_asc":
                    filteredQuizzes.sort(Comparator.comparing(
                            Quiz::getQuestion,
                            Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER)));
                    break;
                case "created_desc":
                    filteredQuizzes.sort((q1, q2) -> {
                        if (q2.getCreated_at() == null)
                            return -1;
                        if (q1.getCreated_at() == null)
                            return 1;
                        return q2.getCreated_at().compareTo(q1.getCreated_at());
                    });
                    break;
                case "created_asc":
                    filteredQuizzes.sort((q1, q2) -> {
                        if (q1.getCreated_at() == null)
                            return -1;
                        if (q2.getCreated_at() == null)
                            return 1;
                        return q1.getCreated_at().compareTo(q2.getCreated_at());
                    });
                    break;
                case "updated_desc":
                default:
                    filteredQuizzes.sort((q1, q2) -> {
                        if (q2.getUpdated_at() == null)
                            return -1;
                        if (q1.getUpdated_at() == null)
                            return 1;
                        return q2.getUpdated_at().compareTo(q1.getUpdated_at());
                    });
                    break;
            }
        } else {
            // Default sort by updated_at desc
            filteredQuizzes.sort((q1, q2) -> {
                if (q2.getUpdated_at() == null)
                    return -1;
                if (q1.getUpdated_at() == null)
                    return 1;
                return q2.getUpdated_at().compareTo(q1.getUpdated_at());
            });
        }

        // Calculate statistics from all quizzes (before pagination)
        int totalQuizzes = filteredQuizzes.size();
        long multipleChoiceCount = allQuizzes.stream()
                .filter(q -> "Multiple Choice".equals(q.getType()))
                .count();
        long trueFalseCount = allQuizzes.stream()
                .filter(q -> "True/False".equals(q.getType()))
                .count();
        long otherTypesCount = allQuizzes.stream()
                .filter(q -> q.getType() != null &&
                        !"Multiple Choice".equals(q.getType()) &&
                        !"True/False".equals(q.getType()))
                .count();

        // Pagination
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1)
                    currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        int totalItems = filteredQuizzes.size();
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
        if (totalPages < 1)
            totalPages = 1;
        if (currentPage > totalPages)
            currentPage = totalPages;

        int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);

        List<Quiz> paginatedQuizzes;
        if (startIndex < totalItems) {
            paginatedQuizzes = filteredQuizzes.subList(startIndex, endIndex);
        } else {
            paginatedQuizzes = new ArrayList<>();
        }

        // Calculate display items
        int startItem = totalItems > 0 ? startIndex + 1 : 0;
        int endItem = endIndex;

        // Set request attributes for the view
        request.setAttribute("quizList", paginatedQuizzes);
        request.setAttribute("totalQuizzes", totalQuizzes);
        request.setAttribute("multipleChoiceCount", multipleChoiceCount);
        request.setAttribute("trueFalseCount", trueFalseCount);
        request.setAttribute("otherTypesCount", otherTypesCount);
        request.setAttribute("page", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startItem", startItem);
        request.setAttribute("endItem", endItem);

        request.getRequestDispatcher("../View/Instructor/QuizList.jsp").forward(request, response);
    }

    /**
     * Shows the form to create a new quiz
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("../View/Instructor/AddQuiz.jsp").forward(request, response);
    }

    /**
     * Creates a new quiz
     */
    private void createQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String question = request.getParameter("question");
        String type = request.getParameter("type");
        String categoryIdParam = request.getParameter("categoryId");

        // Validate input
        if (question == null || question.trim().isEmpty()) {
            request.setAttribute("error", "Question is required.");
            request.getRequestDispatcher("../View/Instructor/AddQuiz.jsp").forward(request, response);
            return;
        }

        if (type == null || type.trim().isEmpty()) {
            request.setAttribute("error", "Question type is required.");
            request.getRequestDispatcher("../View/Instructor/AddQuiz.jsp").forward(request, response);
            return;
        }

        if (categoryIdParam == null || categoryIdParam.trim().isEmpty()) {
            request.setAttribute("error", "Category is required.");
            request.getRequestDispatcher("../View/Instructor/AddQuiz.jsp").forward(request, response);
            return;
        }

        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid category ID.");
            request.getRequestDispatcher("../View/Instructor/AddQuiz.jsp").forward(request, response);
            return;
        }

        // Get user ID from session (assuming user is logged in)
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            userId = 1; // Default fallback for testing
        }

        // Create quiz object
        Quiz quiz = new Quiz();
        quiz.setQuestion(question.trim());
        quiz.setType(type);
        quiz.setCategory_id(categoryId);

        // Save to database
        Quiz createdQuiz = quizDAO.createQuiz(quiz, userId);

        if (createdQuiz != null) {
            session.setAttribute("notification", "Quiz created successfully!");
            session.setAttribute("notificationType", "success");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
        } else {
            request.setAttribute("error", "Failed to create quiz. Please try again.");
            request.getRequestDispatcher("../View/Instructor/AddQuiz.jsp").forward(request, response);
        }
    }

    /**
     * Shows the form to edit an existing quiz
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("notification", "Quiz ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        try {
            int quizId = Integer.parseInt(idParam);
            Quiz quiz = quizDAO.getQuizById(quizId);

            if (quiz != null) {
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("../View/Instructor/editQuiz.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("notification", "Quiz not found.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            }
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("notification", "Invalid Quiz ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
        }
    }

    /**
     * Updates an existing quiz (supports inline editing from modal)
     */
    private void updateQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get form parameters
        String idParam = request.getParameter("id");
        String question = request.getParameter("question");
        String type = request.getParameter("type");
        String categoryIdParam = request.getParameter("categoryId");

        // Validate quiz ID
        if (idParam == null || idParam.isEmpty()) {
            session.setAttribute("notification", "Quiz ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        int quizId;
        try {
            quizId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid Quiz ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        // Validate question - redirect back to list with error for inline editing
        if (question == null || question.trim().isEmpty()) {
            session.setAttribute("notification", "Question is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        // Validate type
        if (type == null || type.trim().isEmpty()) {
            session.setAttribute("notification", "Question type is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        // Validate category ID
        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid category ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        // Get user ID from session
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            userId = 1; // Default fallback for testing
        }

        // Create quiz object with updated data
        Quiz quiz = new Quiz();
        quiz.setId(quizId);
        quiz.setQuestion(question.trim());
        quiz.setType(type);
        quiz.setCategory_id(categoryId);

        // Update in database
        Quiz updatedQuiz = quizDAO.updateQuiz(quiz, userId);

        if (updatedQuiz != null) {
            session.setAttribute("notification", "Quiz updated successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            session.setAttribute("notification", "Failed to update quiz. Please try again.");
            session.setAttribute("notificationType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
    }

    /**
     * Deletes a quiz
     */
    private void deleteQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get quiz ID parameter
        String idParam = request.getParameter("id");

        // Validate quiz ID
        if (idParam == null || idParam.isEmpty()) {
            session.setAttribute("notification", "Quiz ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        int quizId;
        try {
            quizId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid Quiz ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        // Delete from database
        boolean deleted = quizDAO.deleteQuiz(quizId);

        if (deleted) {
            session.setAttribute("notification", "Quiz deleted successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            session.setAttribute("notification", "Failed to delete quiz. It may have linked data.");
            session.setAttribute("notificationType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
    }

    @Override
    public String getServletInfo() {
        return "Quiz Controller - Handles CRUD operations for quizzes with filtering, sorting, and pagination";
    }
}