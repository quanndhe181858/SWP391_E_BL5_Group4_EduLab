package controller.trainee;

import dao.CourseProgressDAO;
import dao.EnrollmentDAO;
import dao.QuizDAO;
import dao.QuizAnswerDAO;
import dao.QuizTestDAO;
import dao.TestsDAO;
import dao.TestAttemptDAOv2;
import model.TestAttempt;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Question;
import model.Test;
import model.User;

@WebServlet(name = "TraineeTakeTestController", urlPatterns = {"/trainee/test"})
public class TraineeTakeTestController extends HttpServlet {

    private final TestsDAO testDAO = new TestsDAO();
    private final QuizTestDAO quizTestDAO = new QuizTestDAO();
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuizAnswerDAO quizAnswerDAO = new QuizAnswerDAO();
    private final TestAttemptDAOv2 testAttemptDAO = new TestAttemptDAOv2();
    private final CourseProgressDAO courseProgressDAO = new CourseProgressDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        try {
            String v = req.getParameter(name);
            return (v == null || v.isBlank()) ? null : Integer.parseInt(v);
        } catch (Exception e) {
            return null;
        }
    }

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer testId = getInt(request, "id");

        if (testId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Test ID is required");
            return;
        }

        Test test = testDAO.getById(testId);

        if (test == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Test not found");
            return;
        }

        List<Question> questions = testDAO.getQuestionsByTest(testId);

        if (questions.isEmpty()) {
            request.setAttribute("error", "Bài test này chưa có câu hỏi");
        }

        TestAttempt previousAttempt = testAttemptDAO.getAttemptByUserAndTest(currentUser.getId(), testId);

        request.setAttribute("test", test);
        request.setAttribute("questions", questions);
        request.setAttribute("previousAttempt", previousAttempt);

        request.getRequestDispatcher("/View/Trainee/TakeTest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = getCurrentUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer testId = getInt(request, "testId");

        if (testId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Test ID is required");
            return;
        }

        // Lấy thông tin test
        Test test = testDAO.getById(testId);
        if (test == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Test not found");
            return;
        }

        List<Question> questions = testDAO.getQuestionsByTest(testId);

        int correctCount = 0;
        int totalQuestions = questions.size();

        for (Question question : questions) {
            String paramName = "answer_" + question.getId();
            Integer selectedAnswerId = getInt(request, paramName);

            if (selectedAnswerId != null) {
                boolean isCorrect = quizAnswerDAO.isCorrect(selectedAnswerId);
                if (isCorrect) {
                    correctCount++;
                }
            }
        }

        // Tính điểm
        float grade = (totalQuestions > 0)
                ? Math.round((correctCount * 100.0f / totalQuestions) * 10) / 10.0f : 0;

        boolean passed = (grade >= test.getMinGrade());

        TestAttempt previousAttempt = testAttemptDAO.getAttemptByUserAndTest(
                currentUser.getId(), testId);

        TestAttempt attempt = new TestAttempt();
        attempt.setUserId(currentUser.getId());
        attempt.setTestId(testId);
        attempt.setGrade(grade);

        if (previousAttempt != null) {
            attempt.setCurrentAttempted(previousAttempt.getCurrentAttempted() + 1);
        } else {
            attempt.setCurrentAttempted(1);
        }

        // Set status
        if (passed) {
            attempt.setStatus("Passed");
        } else {
            if (previousAttempt != null && "Passed".equals(previousAttempt.getStatus())) {
                attempt.setStatus("Passed");
            } else {
                attempt.setStatus("Retaking");
            }
        }

        boolean saved = testAttemptDAO.saveTestAttempt(attempt);
        if (saved && passed) {

            int courseId = test.getCourseId();
            int sectionId = test.getCourseSectionId();

            if (sectionId > 0) {
                courseProgressDAO.markTestDone(
                        currentUser.getId(),
                        courseId,
                        sectionId
                );

                if (courseProgressDAO.isAllSectionsCompleted(
                        currentUser.getId(),
                        courseId)) {

                    enrollmentDAO.markCourseCompleted(
                            currentUser.getId(),
                            courseId
                    );
                }
            } else {
                if (courseProgressDAO.isAllSectionsCompleted(
                        currentUser.getId(),
                        courseId)) {

                    enrollmentDAO.markCourseCompleted(
                            currentUser.getId(),
                            courseId
                    );
                }
            }
        }

        if (!saved) {
            System.err.println("Failed to save test attempt!");
        } else {
            System.out.println("Test attempt saved successfully: User "
                    + currentUser.getId() + " - Test " + testId + " - Grade: " + grade);
        }

        // Set attributes để hiển thị kết quả
        request.setAttribute("test", test);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("correctCount", correctCount);
        request.setAttribute("grade", grade);
        request.setAttribute("passed", passed);
        request.setAttribute("attempt", attempt);
        request.setAttribute("previousAttempt", previousAttempt);

        // Forward to result page
        request.getRequestDispatcher("/View/Trainee/TestResult.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Trainee Take Test Controller - handles test taking and submission";
    }
}
