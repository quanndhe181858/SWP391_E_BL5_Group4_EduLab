/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import dao.QuizAnswerDAO;
import dao.QuizDAO;
import model.Quiz;
import model.QuizAnswer;
import model.User;
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
import util.AuthUtils;

/**
 * Controller for Quiz Answer operations
 * Supports listing, creating, updating, and deleting quiz answers
 * with pagination, filtering, and sorting
 * 
 * @author Le Minh Duc
 */
@WebServlet(name = "InstructorQuizAnswerController", urlPatterns = { "/instructor/quiz-answers" })
public class InstructorQuizAnswerController extends HttpServlet {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private QuizAnswerDAO quizAnswerDAO;
    private QuizDAO quizDAO;
    private static final int ITEMS_PER_PAGE = 10;

    @Override
    public void init() throws ServletException {
        super.init();
        quizAnswerDAO = new QuizAnswerDAO();
        quizDAO = new QuizDAO();
    }

    /**
     * Handles GET requests - displays quiz answer list, forms, etc.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Authorization check - only instructors (role_id = 2) can access
        User user = AuthUtils.doAuthorize(request, response, 2);
        if (user == null) {
            return; // AuthUtils handles the redirect/error response
        }

        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                showQuizAnswerList(request, response);
            } else {
                switch (action) {
                    case "list":
                        showQuizAnswerList(request, response);
                        break;
                    case "add":
                        showCreateForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    default:
                        showQuizAnswerList(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in QuizAnswerController doGet", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("../Error/error.jsp").forward(request, response);
        }
    }

    /**
     * Handles POST requests - creates, updates, or deletes quiz answer
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Authorization check - only instructors (role_id = 2) can access
        User user = AuthUtils.doAuthorize(request, response, 2);
        if (user == null) {
            return; // AuthUtils handles the redirect/error response
        }

        String action = request.getParameter("action");

        try {
            if (action == null) {
                showQuizAnswerList(request, response);
            } else {
                switch (action) {
                    case "create":
                        createQuizAnswer(request, response);
                        break;
                    case "update":
                        updateQuizAnswer(request, response);
                        break;
                    case "delete":
                        deleteQuizAnswer(request, response);
                        break;
                    default:
                        showQuizAnswerList(request, response);
                        break;
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in QuizAnswerController doPost", e);
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("../Error/error.jsp").forward(request, response);
        }
    }

    /**
     * Displays the list of quiz answers with filtering, searching, sorting, and
     * pagination
     */
    private void showQuizAnswerList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get filter parameters
        String quizIdParam = request.getParameter("quizId");
        String isTrueParam = request.getParameter("isTrue");
        String searchParam = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        String pageParam = request.getParameter("page");

        // Get all quiz answers first
        List<QuizAnswer> allAnswers = quizAnswerDAO.getAllQuizAnswers();
        List<QuizAnswer> filteredAnswers = new ArrayList<>(allAnswers);

        // Apply quiz ID filter
        if (quizIdParam != null && !quizIdParam.isEmpty()) {
            try {
                int quizId = Integer.parseInt(quizIdParam);
                filteredAnswers = filteredAnswers.stream()
                        .filter(a -> a.getQuiz_id() == quizId)
                        .collect(Collectors.toList());
            } catch (NumberFormatException e) {
                logger.log(Level.WARNING, "Invalid quizId: " + quizIdParam);
            }
        }

        // Apply isTrue filter
        if (isTrueParam != null && !isTrueParam.isEmpty()) {
            boolean isTrue = "true".equalsIgnoreCase(isTrueParam);
            filteredAnswers = filteredAnswers.stream()
                    .filter(a -> a.isIs_true() == isTrue)
                    .collect(Collectors.toList());
        }

        // Apply search filter
        if (searchParam != null && !searchParam.trim().isEmpty()) {
            String searchLower = searchParam.trim().toLowerCase();
            filteredAnswers = filteredAnswers.stream()
                    .filter(a -> a.getContent() != null &&
                            a.getContent().toLowerCase().contains(searchLower))
                    .collect(Collectors.toList());
        }

        // Apply sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "content_asc":
                    filteredAnswers.sort(Comparator.comparing(
                            QuizAnswer::getContent,
                            Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER)));
                    break;
                case "quiz_id_asc":
                    filteredAnswers.sort(Comparator.comparingInt(QuizAnswer::getQuiz_id));
                    break;
                case "created_desc":
                    filteredAnswers.sort((a1, a2) -> {
                        if (a2.getCreated_at() == null)
                            return -1;
                        if (a1.getCreated_at() == null)
                            return 1;
                        return a2.getCreated_at().compareTo(a1.getCreated_at());
                    });
                    break;
                case "created_asc":
                    filteredAnswers.sort((a1, a2) -> {
                        if (a1.getCreated_at() == null)
                            return -1;
                        if (a2.getCreated_at() == null)
                            return 1;
                        return a1.getCreated_at().compareTo(a2.getCreated_at());
                    });
                    break;
                case "updated_desc":
                default:
                    filteredAnswers.sort((a1, a2) -> {
                        if (a2.getUpdated_at() == null)
                            return -1;
                        if (a1.getUpdated_at() == null)
                            return 1;
                        return a2.getUpdated_at().compareTo(a1.getUpdated_at());
                    });
                    break;
            }
        } else {
            // Default sort by updated_at desc
            filteredAnswers.sort((a1, a2) -> {
                if (a2.getUpdated_at() == null)
                    return -1;
                if (a1.getUpdated_at() == null)
                    return 1;
                return a2.getUpdated_at().compareTo(a1.getUpdated_at());
            });
        }

        // Calculate statistics from all answers (before pagination)
        int totalAnswers = filteredAnswers.size();
        long correctAnswerCount = allAnswers.stream()
                .filter(QuizAnswer::isIs_true)
                .count();
        long incorrectAnswerCount = allAnswers.stream()
                .filter(a -> !a.isIs_true())
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

        int totalItems = filteredAnswers.size();
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
        if (totalPages < 1)
            totalPages = 1;
        if (currentPage > totalPages)
            currentPage = totalPages;

        int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);

        List<QuizAnswer> paginatedAnswers;
        if (startIndex < totalItems) {
            paginatedAnswers = filteredAnswers.subList(startIndex, endIndex);
        } else {
            paginatedAnswers = new ArrayList<>();
        }

        // Calculate display items
        int startItem = totalItems > 0 ? startIndex + 1 : 0;
        int endItem = endIndex;

        // Get quizzes for dropdown
        List<Quiz> quizzes = quizDAO.getAllQuizzes();

        // Set request attributes for the view
        request.setAttribute("answerList", paginatedAnswers);
        request.setAttribute("quizzes", quizzes);
        request.setAttribute("totalAnswers", totalAnswers);
        request.setAttribute("correctAnswerCount", correctAnswerCount);
        request.setAttribute("incorrectAnswerCount", incorrectAnswerCount);
        request.setAttribute("page", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startItem", startItem);
        request.setAttribute("endItem", endItem);

        request.getRequestDispatcher("../View/Instructor/QuizAnswerList.jsp").forward(request, response);
    }

    /**
     * Shows the form to create a new quiz answer
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Quiz> quizzes = quizDAO.getAllQuizzes();
        request.setAttribute("quizzes", quizzes);
        request.getRequestDispatcher("../View/Instructor/AddQuizAnswer.jsp").forward(request, response);
    }

    /**
     * Creates a new quiz answer
     */
    private void createQuizAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get authorized user - we know this exists because authorization was checked in doPost
        User user = (User) session.getAttribute("user");

        // Get form parameters
        String quizIdParam = request.getParameter("quizId");
        String isTrueParam = request.getParameter("isTrue");
        String type = request.getParameter("type");
        String content = request.getParameter("content");

        // Validate quiz ID
        if (quizIdParam == null || quizIdParam.trim().isEmpty()) {
            session.setAttribute("notification", "Quiz ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        int quizId;
        try {
            quizId = Integer.parseInt(quizIdParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid Quiz ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Validate content
        if (content == null || content.trim().isEmpty()) {
            session.setAttribute("notification", "Answer content is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Create quiz answer object
        QuizAnswer answer = new QuizAnswer();
        answer.setQuiz_id(quizId);
        answer.setIs_true("true".equalsIgnoreCase(isTrueParam));
        answer.setType(type != null ? type : "text");
        answer.setContent(content.trim());

        // Save to database using the authorized user's ID
        QuizAnswer createdAnswer = quizAnswerDAO.createQuizAnswer(answer, user.getId());

        if (createdAnswer != null) {
            session.setAttribute("notification", "Quiz answer created successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            session.setAttribute("notification", "Failed to create quiz answer. Please try again.");
            session.setAttribute("notificationType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
    }

    /**
     * Shows the form to edit an existing quiz answer
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("notification", "Answer ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        try {
            int answerId = Integer.parseInt(idParam);
            QuizAnswer answer = quizAnswerDAO.getQuizAnswerById(answerId);

            if (answer != null) {
                List<Quiz> quizzes = quizDAO.getAllQuizzes();
                request.setAttribute("answer", answer);
                request.setAttribute("quizzes", quizzes);
                request.getRequestDispatcher("../View/Instructor/EditQuizAnswer.jsp").forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("notification", "Answer not found.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            }
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute("notification", "Invalid Answer ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
        }
    }

    /**
     * Updates an existing quiz answer (supports inline editing from modal)
     */
    private void updateQuizAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get authorized user - we know this exists because authorization was checked in doPost
        User user = (User) session.getAttribute("user");

        // Get form parameters
        String idParam = request.getParameter("id");
        String quizIdParam = request.getParameter("quizId");
        String isTrueParam = request.getParameter("isTrue");
        String type = request.getParameter("type");
        String content = request.getParameter("content");

        // Validate answer ID
        if (idParam == null || idParam.isEmpty()) {
            session.setAttribute("notification", "Answer ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        int answerId;
        try {
            answerId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid Answer ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Validate quiz ID
        int quizId;
        try {
            quizId = Integer.parseInt(quizIdParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid Quiz ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Validate content
        if (content == null || content.trim().isEmpty()) {
            session.setAttribute("notification", "Answer content is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Create quiz answer object with updated data
        QuizAnswer answer = new QuizAnswer();
        answer.setId(answerId);
        answer.setQuiz_id(quizId);
        answer.setIs_true("true".equalsIgnoreCase(isTrueParam));
        answer.setType(type != null ? type : "text");
        answer.setContent(content.trim());

        // Update in database using the authorized user's ID
        QuizAnswer updatedAnswer = quizAnswerDAO.updateQuizAnswer(answer, user.getId());

        if (updatedAnswer != null) {
            session.setAttribute("notification", "Quiz answer updated successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            session.setAttribute("notification", "Failed to update quiz answer. Please try again.");
            session.setAttribute("notificationType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
    }

    /**
     * Deletes a quiz answer
     */
    private void deleteQuizAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get answer ID parameter
        String idParam = request.getParameter("id");

        // Validate answer ID
        if (idParam == null || idParam.isEmpty()) {
            session.setAttribute("notification", "Answer ID is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        int answerId;
        try {
            answerId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid Answer ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Delete from database
        boolean deleted = quizAnswerDAO.deleteQuizAnswer(answerId);

        if (deleted) {
            session.setAttribute("notification", "Quiz answer deleted successfully!");
            session.setAttribute("notificationType", "success");
        } else {
            session.setAttribute("notification", "Failed to delete quiz answer.");
            session.setAttribute("notificationType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
    }

    @Override
    public String getServletInfo() {
        return "Quiz Answer Controller - Handles CRUD operations for quiz answers with filtering, sorting, and pagination";
    }
}
