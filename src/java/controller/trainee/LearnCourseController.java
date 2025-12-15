package controller.trainee;

import dao.CertificateDAO;
import dao.CourseDAO;
import dao.CourseProgressDAO;
import dao.CourseSectionDAO;
import dao.EnrollmentDAO;
import dao.MediaDAO;
import dao.TestAttemptDAOv2;
import dao.TestsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Course;
import model.CourseProgress;
import model.CourseSection;
import model.Media;
import model.Test;
import model.TestAttempt;
import model.User;
import model.UserCertificate;

@WebServlet(name = "LearnCourseController", urlPatterns = {"/learn"})
public class LearnCourseController extends HttpServlet {

    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();
    private final CourseProgressDAO progressDAO = new CourseProgressDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final MediaDAO mediaDAO = new MediaDAO();
    private final TestsDAO testsDAO = new TestsDAO();
    private final CertificateDAO certificateDAO = new CertificateDAO();
    private final TestAttemptDAOv2 testAttemptDAO = new TestAttemptDAOv2();

    // Helper parse int an toàn
    private Integer getInt(HttpServletRequest req, String name) {
        try {
            String raw = req.getParameter(name);
            if (raw == null || raw.isBlank()) {
                return null;
            }
            return Integer.parseInt(raw);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = util.AuthUtils.doAuthorize(request, response, 3);
        if (u == null) {
            return;
        }
        int userId = u.getId();

        Integer courseIdObj = getInt(request, "courseId");
        if (courseIdObj == null) {
            request.setAttribute("error", "Thiếu hoặc sai courseId");
            request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
            return;
        }
        int courseId = courseIdObj;

        Course course = courseDAO.getCourseById(courseId);
        if (course == null) {
            request.setAttribute("error", "Khóa học không tồn tại");
            request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
            return;
        }

        if (!"Active".equalsIgnoreCase(course.getStatus())) {
            request.setAttribute("error", "Khóa học chưa được mở");
            request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
            return;
        }

        if (!enrollmentDAO.isEnrolled(userId, courseId)) {
            request.setAttribute("error", "Bạn chưa đăng ký khóa học này");
            request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
            return;
        }

        List<CourseSection> sections = sectionDAO.getAllCourseSectionsByCourseId(courseId);
        if (sections == null || sections.isEmpty()) {
            request.setAttribute("error", "Khóa học chưa có bài học nào");
            request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
            return;
        }

        Integer sectionIdObj = getInt(request, "sectionId");
        int sectionId = (sectionIdObj == null) ? sections.get(0).getId() : sectionIdObj;

        CourseSection current = sectionDAO.getCourseSectionById(sectionId);
        if (current == null || current.getCourse_id() != courseId) {
            request.setAttribute("error", "Bài học không tồn tại hoặc không thuộc khóa học");
            request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
            return;
        }

        progressDAO.createOrUpdateProgress(userId, courseId, sectionId);

        Map<Integer, CourseProgress> progressMap = new HashMap<>();
        int completedCount = 0;

        for (CourseSection s : sections) {
            CourseProgress p = progressDAO.getProgress(userId, courseId, s.getId());
            progressMap.put(s.getId(), p);
            if (p != null && "Completed".equalsIgnoreCase(p.getStatus())) {
                completedCount++;
            }
        }

        boolean allCompleted = completedCount == sections.size();

        Test sectionTest = testsDAO.getTestBySectionId(sectionId);
        TestAttempt sectionTestAttempt = null;
        if (sectionTest != null) {
            sectionTestAttempt = testAttemptDAO.getAttemptByUserAndTest(userId, sectionTest.getId());
        }

        CourseProgress curProgress = progressMap.get(sectionId);
        boolean testDone = curProgress != null && curProgress.isTestDone();

        Test courseTest = allCompleted
                ? testsDAO.getCourseTestByCourseId(courseId)
                : null;
        TestAttempt courseTestAttempt = null;
        boolean courseTestLimitReached = false;
        if (courseTest != null) {
            courseTestAttempt = testAttemptDAO.getAttemptByUserAndTest(userId, courseTest.getId());
            if (courseTestAttempt != null && courseTestAttempt.getCurrentAttempted() >= 2) {
                courseTestLimitReached = true;
            }
        }

        UserCertificate courseCertificate = null;
        if (allCompleted) {
            courseCertificate
                    = certificateDAO.getUserCertificateByCourseId(courseId, userId);
        }

        request.setAttribute("courseCertificate", courseCertificate);

        request.setAttribute("sectionTestAttempt", sectionTestAttempt);
        request.setAttribute("courseTestAttempt", courseTestAttempt);
        request.setAttribute("courseTestLimitReached", courseTestLimitReached);
        request.setAttribute("course", course);
        request.setAttribute("sections", sections);
        request.setAttribute("current", current);
        request.setAttribute("mediaList", mediaDAO.getMediaBySectionId(sectionId));
        request.setAttribute("progressMap", progressMap);
        request.setAttribute("test", sectionTest);
        request.setAttribute("testDone", testDone);
        request.setAttribute("allCompleted", allCompleted);
        request.setAttribute("courseTest", courseTest);

        request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = util.AuthUtils.doAuthorize(request, response, 3);
        if (u == null) {
            return;
        }
        int userId = u.getId();

        Integer courseIdObj = getInt(request, "courseId");
        Integer sectionIdObj = getInt(request, "sectionId");

        if (courseIdObj == null || sectionIdObj == null) {
            request.setAttribute("error", "Dữ liệu gửi lên không hợp lệ");
            doGet(request, response);
            return;
        }

        int courseId = courseIdObj;
        int sectionId = sectionIdObj;

        CourseProgress progress = progressDAO.getProgress(userId, courseId, sectionId);
        Test sectionTest = testsDAO.getTestBySectionId(sectionId);

        // Kiểm tra nếu có section test thì phải hoàn thành trước
        if (sectionTest != null && (progress == null || !progress.isTestDone())) {
            request.setAttribute("error", "Bạn phải hoàn thành bài test trước khi đánh dấu hoàn thành");
            doGet(request, response);
            return;
        }

        // Nếu đã completed rồi thì redirect
        if (progress != null && "Completed".equalsIgnoreCase(progress.getStatus())) {
            response.sendRedirect(request.getContextPath()
                    + "/learn?courseId=" + courseId + "&sectionId=" + sectionId);
            return;
        }

        // Đánh dấu section hiện tại là completed
        progressDAO.markCompleted(userId, courseId, sectionId);

        // Kiểm tra xem đã hoàn thành tất cả sections chưa
        List<CourseSection> sections = sectionDAO.getAllCourseSectionsByCourseId(courseId);

        int completedCount = 0;
        for (CourseSection s : sections) {
            CourseProgress p = progressDAO.getProgress(userId, courseId, s.getId());
            if (p != null && "Completed".equalsIgnoreCase(p.getStatus())) {
                completedCount++;
            }
        }

        boolean allCompleted = completedCount == sections.size();

        // Nếu hoàn thành tất cả sections -> xét cấp chứng chỉ
        if (allCompleted) {
            // Kiểm tra xem có final test không
            Test finalTest = testsDAO.getCourseTestByCourseId(courseId);
            boolean canIssueCertificate = false;

            if (finalTest != null) {
                // Có final test -> phải pass mới được chứng chỉ
                TestAttempt attempt = testAttemptDAO.getAttemptByUserAndTest(userId, finalTest.getId());
                canIssueCertificate = (attempt != null && "Passed".equalsIgnoreCase(attempt.getStatus()));

                if (!canIssueCertificate) {
                    System.out.println("User " + userId + " chưa pass final test của course " + courseId);
                }
            } else {
                // Không có final test -> hoàn thành tất cả sections là đủ điều kiện
                canIssueCertificate = true;
                System.out.println("Course " + courseId + " không có final test, tự động cấp chứng chỉ");
            }

            if (canIssueCertificate) {

                boolean issued = certificateDAO.issueCertificate(userId, courseId, null);

                if (issued) {
                    System.out.println("✓ Certificate issued successfully for userId=" + userId + ", courseId=" + courseId);
                } else {
                    System.out.println("✗ Failed to issue certificate for userId=" + userId + ", courseId=" + courseId);
                }
            }
        }

        response.sendRedirect(request.getContextPath()
                + "/learn?courseId=" + courseId + "&sectionId=" + sectionId);
    }
}
