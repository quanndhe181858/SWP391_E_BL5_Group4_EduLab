package controller.trainee;

import dao.*;
import model.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "LearnCourseController", urlPatterns = {"/learn"})
public class LearnCourseController extends HttpServlet {

    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();
    private final CourseProgressDAO progressDAO = new CourseProgressDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final MediaDAO mediaDAO = new MediaDAO();
    private final TestsDAO testsDAO = new TestsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = util.AuthUtils.doAuthorize(request, response, 3);
        if (u == null) return;

        int userId = u.getId();
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        if (!enrollmentDAO.isEnrolled(userId, courseId)) {
            response.sendError(403, "Bạn chưa đăng ký khóa học này.");
            return;
        }

        List<CourseSection> sections = sectionDAO.getAllCourseSectionsByCourseId(courseId);
        if (sections.isEmpty()) {
            response.sendError(404, "Khóa học chưa có bài học nào.");
            return;
        }

        String rawSectionId = request.getParameter("sectionId");
        int sectionId = (rawSectionId == null) ? sections.get(0).getId() : Integer.parseInt(rawSectionId);
        CourseSection current = sectionDAO.getCourseSectionById(sectionId);

        List<Media> mediaList = mediaDAO.getMediaBySectionId(sectionId);
        Test test = testsDAO.getTestBySectionId(sectionId);
        CourseProgress progress = progressDAO.getProgress(userId, courseId, sectionId);

        // Nếu chưa có progress → tạo progress entry (nhưng chưa đánh dấu hoàn thành)
        progressDAO.createOrUpdateProgress(userId, courseId, sectionId);

        Map<Integer, CourseProgress> progressMap = new HashMap<>();
        for (CourseSection s : sections) {
            progressMap.put(s.getId(), progressDAO.getProgress(userId, courseId, s.getId()));
        }

        request.setAttribute("course", courseDAO.getCourseById(courseId));
        request.setAttribute("sections", sections);
        request.setAttribute("current", current);
        request.setAttribute("mediaList", mediaList);
        request.setAttribute("progressMap", progressMap);
        request.setAttribute("test", test);
        request.setAttribute("testDone", (progress != null && progress.isTestDone()));

        request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = util.AuthUtils.doAuthorize(request, response, 3);
        if (u == null) return;

        int userId = u.getId();
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int sectionId = Integer.parseInt(request.getParameter("sectionId"));

        Test test = testsDAO.getTestBySectionId(sectionId);
        CourseProgress progress = progressDAO.getProgress(userId, courseId, sectionId);

        if (test != null && (progress == null || !progress.isTestDone())) {
            response.sendError(400, "Bạn cần hoàn thành bài test trước khi đánh dấu hoàn thành.");
            return;
        }

        progressDAO.markCompleted(userId, courseId, sectionId);
        response.sendRedirect(request.getContextPath() + "/learn?courseId=" + courseId + "&sectionId=" + sectionId);
    }
}
