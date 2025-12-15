package controller.trainee;

import dao.CertificateDAO;
import dao.CourseProgressDAO;
import dao.CourseSectionDAO;
import dao.EnrollmentDAO;
import dao.QuizDAO;
import dao.QuizAnswerDAO;
import dao.QuizTestDAO;
import dao.TestsDAO;
import dao.TestAttemptDAOv2;
import model.CourseProgress;
import model.CourseSection;
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
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();  // THÊM
    private final CertificateDAO certificateDAO = new CertificateDAO();  // THÊM

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

        // Kiểm tra số lần làm bài TRƯỚC khi load questions
        TestAttempt previousAttempt = testAttemptDAO.getAttemptByUserAndTest(currentUser.getId(), testId);

        // CHỈ giới hạn course test (courseSectionId == 0)
        if (test.getCourseSectionId() == 0) {  // Course test
            if (previousAttempt != null && previousAttempt.getCurrentAttempted() >= 2) {
                // Redirect về trang learn thay vì hiển thị modal
                response.sendRedirect(request.getContextPath() + "/learn?courseId=" + test.getCourseId());
                return;
            }
        }

        // Nếu chưa hết lượt hoặc là section test, tiếp tục load questions
        List<Question> questions = testDAO.getQuestionsByTest(testId);

        if (questions.isEmpty()) {
            request.setAttribute("error", "Bài test này chưa có câu hỏi");
        }

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

        // Kiểm tra số lần làm bài TRƯỚC khi xử lý
        TestAttempt previousAttempt = testAttemptDAO.getAttemptByUserAndTest(
                currentUser.getId(), testId);

        // CHỈ giới hạn course test
        if (test.getCourseSectionId() == 0) {  // Course test
            if (previousAttempt != null && previousAttempt.getCurrentAttempted() >= 2) {
                // Redirect về trang learn
                response.sendRedirect(request.getContextPath() + "/learn?courseId=" + test.getCourseId());
                return;
            }
        }

        // Tiếp tục xử lý bài test
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

            // Xử lý section test
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
            } // Xử lý FINAL TEST (course test) - sectionId == 0
            else {
                System.out.println("=== FINAL TEST PASSED ===");
                System.out.println("User: " + currentUser.getId() + ", Course: " + courseId);
                System.out.println("Grade: " + grade + " (min required: " + test.getMinGrade() + ")");

                // Kiểm tra xem đã hoàn thành tất cả sections chưa
                boolean allSectionsCompleted = courseProgressDAO.isAllSectionsCompleted(
                        currentUser.getId(),
                        courseId
                );

                System.out.println("All sections completed: " + allSectionsCompleted);

                if (allSectionsCompleted) {
                    // Mark enrollment as completed
                    enrollmentDAO.markCourseCompleted(
                            currentUser.getId(),
                            courseId
                    );

                    // ===== CẤP CHỨNG CHỈ =====
                    System.out.println("Attempting to issue certificate...");
                    boolean certificateIssued = certificateDAO.issueCertificate(
                            currentUser.getId(),
                            courseId,
                            null
                    );

                    if (certificateIssued) {
                        System.out.println("✓ Certificate issued successfully for userId="
                                + currentUser.getId() + ", courseId=" + courseId);
                    } else {
                        System.out.println("✗ Failed to issue certificate for userId="
                                + currentUser.getId() + ", courseId=" + courseId);
                    }
                } else {
                    // Debug: Xem section nào chưa completed
                    List<CourseSection> allSections = sectionDAO.getAllCourseSectionsByCourseId(courseId);
                    int completedCount = 0;

                    for (CourseSection s : allSections) {
                        CourseProgress p = courseProgressDAO.getProgress(
                                currentUser.getId(),
                                courseId,
                                s.getId()
                        );
                        if (p != null && "Completed".equalsIgnoreCase(p.getStatus())) {
                            completedCount++;
                        } else {
                            System.out.println("Section " + s.getId() + " (" + s.getTitle()
                                    + ") not completed yet");
                        }
                    }

                    System.out.println("Progress: " + completedCount + "/" + allSections.size()
                            + " sections completed");
                    System.out.println("Cannot issue certificate: Not all sections completed");
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
