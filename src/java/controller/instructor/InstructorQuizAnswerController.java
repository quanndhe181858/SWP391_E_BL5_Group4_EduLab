/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import constant.httpStatus;
import dao.QuizAnswerDAO;
import dao.QuizDAO;
import model.Quiz;
import model.QuizAnswer;
import model.User;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
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

        try {
            // Authorization check - only instructors (role_id = 2) can access
            User user = AuthUtils.doAuthorize(request, response, 2);
            if (user == null) {
                return; // AuthUtils handles the redirect/error response
            }

            response.sendError(httpStatus.BAD_REQUEST.getCode(),
                    "Invalid action for GET request. This controller only supports POST/AJAX operations.");
        } catch (ServletException | IOException e) {
            logger.log(Level.SEVERE, "Error in QuizAnswerController doGet", e);
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(),
                    httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Handles POST requests - creates, updates, or deletes quiz answer
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Authorization check - only instructors (role_id = 2) can access
            User user = AuthUtils.doAuthorize(request, response, 2);
            if (user == null) {
                return; // AuthUtils handles the redirect/error response
            }

            String action = request.getParameter("action");

            if (action == null) {
                response.sendError(httpStatus.BAD_REQUEST.getCode(), "Action is required");
            } else {
                switch (action) {
                    case "create":
                    case "createAnswer":
                        createQuizAnswer(request, response);
                        break;
                    case "update":
                    case "updateAnswer":
                        updateQuizAnswer(request, response);
                        break;
                    case "delete":
                        deleteQuizAnswer(request, response);
                        break;
                    default:
                        response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid action");
                        break;
                }
            }
        } catch (ServletException | IOException e) {
            logger.log(Level.SEVERE, "Error in QuizAnswerController doPost", e);
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(),
                    httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Creates a new quiz answer
     */
    private void createQuizAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get authorized user - we know this exists because authorization was checked
        // in doPost
        User user = (User) session.getAttribute("user");

        // Get form parameters
        String quizIdParam = request.getParameter("quizId");
        String isTrueParam = request.getParameter("isCorrect");
        String content = request.getParameter("content");

        // Validate quiz ID
        if (quizIdParam == null || quizIdParam.trim().isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Quiz ID is required.");
            return;
        }

        int quizId;
        try {
            quizId = Integer.parseInt(quizIdParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Quiz ID: " + quizIdParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid Quiz ID.");
            return;
        }

        // Validate content
        if (content == null || content.trim().isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Answer content is required.");
            return;
        }

        // Check if quiz exists and get its type
        Quiz existingQuiz = quizDAO.getQuizById(quizId);
        if (existingQuiz == null) {
            response.sendError(httpStatus.NOT_FOUND.getCode(), "Quiz not found.");
            return;
        }

        // Validate max 6 answers
        java.util.List<QuizAnswer> existingAnswers = quizAnswerDAO.getQuizAnswersByQuizId(quizId);
        if (existingAnswers != null && existingAnswers.size() >= 6) {
            String ajaxHeader = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Tối đa 6 câu trả lời cho phép.\"}");
            } else {
                session.setAttribute("notification", "Tối đa 6 câu trả lời cho phép.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=edit&id=" + quizId);
            }
            return;
        }

        // Validate Single Choice constraint
        if ("Single Choice".equals(existingQuiz.getType()) && "on".equalsIgnoreCase(isTrueParam))

        {
            // Check if there is already a correct answer
            if (existingAnswers != null) {
                boolean hasCorrect = existingAnswers.stream().anyMatch(QuizAnswer::isIs_true);
                if (hasCorrect) {
                    String ajaxHeader = request.getHeader("X-Requested-With");
                    boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

                    if (isAjax) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write(
                                "{\"success\": false, \"message\": \"Câu hỏi Single Choice chỉ được có 1 đáp án đúng.\"}");
                    } else {
                        session.setAttribute("notification", "Câu hỏi Single Choice chỉ được có 1 đáp án đúng.");
                        session.setAttribute("notificationType", "error");
                        response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=edit&id=" + quizId);
                    }
                    return;
                }
            }
        }

        // Create quiz answer object
        QuizAnswer answer = new QuizAnswer();
        answer.setQuiz_id(quizId);
        answer.setIs_true("on".equalsIgnoreCase(isTrueParam));
        answer.setType(existingQuiz.getType() != null ? existingQuiz.getType() : "text");
        answer.setContent(content.trim());

        // Save to database using the authorized user's ID
        QuizAnswer createdAnswer = quizAnswerDAO.createQuizAnswer(answer, user.getId());

        if (createdAnswer != null) {
            // Check if this is an AJAX request
            String ajaxHeader = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"Quiz answer created successfully!\"}");
            } else {
                session.setAttribute("notification", "Quiz answer created successfully!");
                session.setAttribute("notificationType", "success");
                response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=edit&id=" + quizId);
            }
        } else {
            logger.log(Level.SEVERE, "Failed to create quiz answer for user: " + user.getId());
            response.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(),
                    httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    /**
     * Updates an existing quiz answer (supports inline editing from modal)
     */
    private void updateQuizAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get authorized user - we know this exists because authorization was checked
        // in doPost
        User user = (User) session.getAttribute("user");

        // Get form parameters - check both parameter names for flexibility
        String idParam = request.getParameter("answerId");
        if (idParam == null || idParam.isEmpty()) {
            idParam = request.getParameter("id");
        }
        String quizIdParam = request.getParameter("quizId");
        String isTrueParam = request.getParameter("isCorrect");
        String content = request.getParameter("content");

        // Validate answer ID
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Answer ID is required.");
            return;
        }

        int answerId;
        try {
            answerId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Answer ID: " + idParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid Answer ID.");
            return;
        }

        // Validate quiz ID
        int quizId;
        try {
            quizId = Integer.parseInt(quizIdParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Quiz ID: " + quizIdParam);
            session.setAttribute("notification", "Invalid Quiz ID.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Validate content - redirect back to list with error for inline editing
        if (content == null || content.trim().isEmpty()) {
            session.setAttribute("notification", "Answer content is required.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            return;
        }

        // Check if answer exists
        QuizAnswer existingAnswer = quizAnswerDAO.getQuizAnswerById(answerId);
        if (existingAnswer == null) {
            response.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            return;
        }

        // Check if quiz exists and get its type
        Quiz existingQuiz = quizDAO.getQuizById(quizId);
        if (existingQuiz == null) {
            response.sendError(httpStatus.NOT_FOUND.getCode(), "Quiz not found.");
            return;
        }

        // Create quiz answer object with updated data, using quiz type from Quiz
        QuizAnswer answer = new QuizAnswer();
        answer.setId(answerId);
        answer.setQuiz_id(quizId);
        answer.setIs_true("on".equalsIgnoreCase(isTrueParam));
        answer.setType(existingQuiz.getType() != null ? existingQuiz.getType() : "text"); // Use Quiz's type
        answer.setContent(content.trim());

        // Update in database using the authorized user's ID
        QuizAnswer updatedAnswer = quizAnswerDAO.updateQuizAnswer(answer, user.getId());

        // Check if this is an AJAX request
        String ajaxHeader = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

        if (updatedAnswer != null) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"Quiz answer updated successfully!\"}");
            } else {
                session.setAttribute("notification", "Quiz answer updated successfully!");
                session.setAttribute("notificationType", "success");
                response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=edit&id=" + quizId);
            }
        } else {
            logger.log(Level.SEVERE, "Failed to update quiz answer ID: " + answerId + " for user: " + user.getId());
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update quiz answer.\"}");
            } else {
                session.setAttribute("notification", "Failed to update quiz answer. Please try again.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            }
        }
    }

    /**
     * Deletes a quiz answer
     */
    private void deleteQuizAnswer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get answer ID parameter - check both parameter names
        String idParam = request.getParameter("answerId");
        if (idParam == null || idParam.isEmpty()) {
            idParam = request.getParameter("id");
        }

        // Validate answer ID
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Answer ID is required.");
            return;
        }

        int answerId;
        try {
            answerId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid Answer ID: " + idParam);
            response.sendError(httpStatus.BAD_REQUEST.getCode(), "Invalid Answer ID.");
            return;
        }

        // Check if answer exists before attempting to delete
        QuizAnswer existingAnswer = quizAnswerDAO.getQuizAnswerById(answerId);
        if (existingAnswer == null) {
            response.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            return;
        }

        // Get quizId for redirect
        int quizId = existingAnswer.getQuiz_id();

        // Delete from database
        boolean deleted = quizAnswerDAO.deleteQuizAnswer(answerId);

        // Check if this is an AJAX request
        String ajaxHeader = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxHeader);

        if (deleted) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"Quiz answer deleted successfully!\"}");
            } else {
                session.setAttribute("notification", "Quiz answer deleted successfully!");
                session.setAttribute("notificationType", "success");
                response.sendRedirect(request.getContextPath() + "/instructor/quizes?action=edit&id=" + quizId);
            }
        } else {
            logger.log(Level.SEVERE, "Failed to delete quiz answer ID: " + answerId);
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete quiz answer.\"}");
            } else {
                session.setAttribute("notification", "Failed to delete quiz answer.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect(request.getContextPath() + "/instructor/quiz-answers?action=list");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Quiz Answer Controller - Handles CRUD operations for quiz answers with filtering, sorting, and pagination";
    }
}
