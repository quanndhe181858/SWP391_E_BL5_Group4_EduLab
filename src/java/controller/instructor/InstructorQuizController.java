/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import constant.httpStatus;
import dao.QuizDAO;
import dao.CategoryDAO;
import service.QuizServices;
import model.Quiz;
import model.User;
import model.Category;
import util.AuthUtils;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
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
    private CategoryDAO categoryDAO;
    private QuizServices quizServices;
    private static final int ITEMS_PER_PAGE = 10;

    @Override
    public void init() throws ServletException {
        super.init();
        quizDAO = new QuizDAO();
        categoryDAO = new CategoryDAO();
        quizServices = new QuizServices();
    }

    /**
     * Handles GET requests - displays quiz list, forms, etc.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User authResult = AuthUtils.doAuthorize(request, response, 2);
            if (authResult == null) {
                return;
            }

            String action = request.getParameter("action");

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
        } catch (ServletException | IOException e) {
            logger.log(Level.SEVERE, "Error in QuizController doGet", e);
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Handles POST requests - creates or updates quiz
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            User authResult = AuthUtils.doAuthorize(request, response, 2);
            if (authResult == null) {
                return;
            }

            String action = request.getParameter("action");

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
        } catch (ServletException | IOException e) {
            logger.log(Level.SEVERE, "Error in QuizController doPost", e);
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Displays the list of quizzes with filtering, searching, sorting, and
     * pagination
     */
    private void showQuizList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get filter parameters
            String categoryIdParam = request.getParameter("categoryId");
            String typeParam = request.getParameter("type");
            String searchParam = request.getParameter("search");
            String sortBy = request.getParameter("sortBy");
            String pageParam = request.getParameter("page");

            // Fetch all categories for filter dropdown
            List<Category> categories = categoryDAO.getCategories();

            // Create a map of category IDs to names for easy lookup in JSP
            Map<Integer, String> categoryMap = new HashMap<>();
            if (categories != null) {
                for (Category category : categories) {
                    categoryMap.put(category.getId(), category.getName());
                }
            }

            // Get all quizzes with categories properly loaded
            List<Quiz> allQuizzes = quizServices.getAllQuizzes();
            List<Quiz> filteredQuizzes = new ArrayList<>(allQuizzes);

            // Apply category filter with validation
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                try {
                    int categoryId = Integer.parseInt(categoryIdParam);
                    filteredQuizzes = filteredQuizzes.stream()
                            .filter(q -> q.getCategory_id() == categoryId)
                            .collect(Collectors.toList());
                } catch (NumberFormatException e) {
                    logger.log(Level.WARNING, "Invalid categoryId: " + categoryIdParam);
                    response.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
                    return;
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

            // Pagination with validation
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1)
                        currentPage = 1;
                } catch (NumberFormatException e) {
                    logger.log(Level.WARNING, "Invalid page parameter: " + pageParam);
                    response.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
                    return;
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
            request.setAttribute("categories", categories);
            request.setAttribute("categoryMap", categoryMap);

            request.getRequestDispatcher("../View/Instructor/QuizList.jsp").forward(request, response);

        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error in showQuizList", e);
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Shows the form to create a new quiz
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch categories for dropdown
        List<Category> categories = categoryDAO.getCategories();
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("../View/Instructor/QuizCreate.jsp").forward(request, response);
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
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Question is required.");
            return;
        }

        if (type == null || type.trim().isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Question type is required.");
            return;
        }

        if (categoryIdParam == null || categoryIdParam.trim().isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Category is required.");
            return;
        }

        int categoryId;
        try {
            categoryId = Integer.parseInt(categoryIdParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid category ID: " + categoryIdParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid category ID.");
            return;
        }

        // Get user from session - we know it exists due to authorization check
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Create quiz object
        Quiz quiz = new Quiz();
        quiz.setQuestion(question.trim());
        quiz.setType(type);
        quiz.setCategory_id(categoryId);

        // Save to database
        Quiz createdQuiz = quizServices.createQuiz(quiz, user.getId());

        if (createdQuiz != null) {
            session.setAttribute("notification", "Quiz created successfully!");
            session.setAttribute("notificationType", "success");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
        } else {
            logger.log(Level.SEVERE, "Failed to create quiz for user: " + user.getId());
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Shows the form to edit an existing quiz
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
            return;
        }

        try {
            int quizId = Integer.parseInt(idParam);
            Quiz quiz = quizServices.getQuizById(quizId);

            if (quiz != null) {
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("../View/Instructor/editQuiz.jsp").forward(request, response);
            } else {
                response.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            }
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Quiz ID: " + idParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
        }
    }

    /**
     * Updates an existing quiz (supports inline editing from modal)
     */
    private void updateQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get authorized user - we know this exists because authorization was checked in doPost
        User user = (User) session.getAttribute("user");

        // Get form parameters
        String idParam = request.getParameter("id");
        String question = request.getParameter("question");
        String type = request.getParameter("type");
        String categoryIdParam = request.getParameter("categoryId");

        // Validate quiz ID
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Quiz ID is required.");
            return;
        }

        int quizId;
        try {
            quizId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Quiz ID: " + idParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid Quiz ID.");
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
            logger.log(Level.WARNING, "Invalid category ID: " + categoryIdParam);
            session.setAttribute("notification", "Invalid category ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=list");
            return;
        }

        // Check if quiz exists
        Quiz existingQuiz = quizServices.getQuizById(quizId);
        if (existingQuiz == null) {
            response.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            return;
        }

        // Create quiz object with updated data
        Quiz quiz = new Quiz();
        quiz.setId(quizId);
        quiz.setQuestion(question.trim());
        quiz.setType(type);
        quiz.setCategory_id(categoryId);

        // Update in database using the authorized user's ID
        boolean updated = quizServices.updateQuiz(quiz, user.getId());

        if (updated) {
            session.setAttribute("notification", "Quiz updated successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            logger.log(Level.SEVERE, "Failed to update quiz ID: " + quizId + " for user: " + user.getId());
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
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Quiz ID is required.");
            return;
        }

        int quizId;
        try {
            quizId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Quiz ID: " + idParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid Quiz ID.");
            return;
        }

        // Check if quiz exists before attempting to delete
        Quiz existingQuiz = quizServices.getQuizById(quizId);
        if (existingQuiz == null) {
            response.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            return;
        }

        // Delete from database
        boolean deleted = quizServices.deleteQuiz(quizId);

        if (deleted) {
            session.setAttribute("notification", "Quiz deleted successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            logger.log(Level.SEVERE, "Failed to delete quiz ID: " + quizId);
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