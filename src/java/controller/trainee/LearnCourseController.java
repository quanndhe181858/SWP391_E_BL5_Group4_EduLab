/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import dao.CourseDAO;
import dao.CourseProgressDAO;
import dao.CourseSectionDAO;
import dao.EnrollmentDAO;
import dao.MediaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Course;
import model.CourseProgress;
import model.CourseSection;
import model.Media;
import model.User;

@WebServlet(name = "LearnCourseController", urlPatterns = {"/learn"})
public class LearnCourseController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LearnCourseController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LearnCourseController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();
    private final CourseProgressDAO progressDAO = new CourseProgressDAO();
    private final EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private final MediaDAO mediaDAO = new MediaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        User u = util.AuthUtils.doAuthorize(request, response, 3);
//
//        if (u == null) {
//            return;
//        }

//        int uid = u.getId();
       int uid = 1;

        int courseId = Integer.parseInt(request.getParameter("courseId"));

        if (!enrollmentDAO.isEnrolled(uid, courseId)) {
            response.sendError(403, "Bạn chưa đăng ký khóa học này.");
            return;
        }

        List<CourseSection> sections = sectionDAO.getAllCourseSectionsByCourseId(courseId);

        if (sections.isEmpty()) {
            response.sendError(404, "Khóa học chưa có bài học nào.");
            return;
        }

        String rawSectionId = request.getParameter("sectionId");
        int sectionId = (rawSectionId == null)
                ? sections.get(0).getId()
                : Integer.parseInt(rawSectionId);

        CourseSection current = sectionDAO.getCourseSectionById(sectionId);

        List<Media> mediaList = mediaDAO.getMediaBySectionId(sectionId);

        progressDAO.createOrUpdateProgress(uid, courseId, sectionId);

        Map<Integer, CourseProgress> progressMap = new HashMap<>();
        for (CourseSection s : sections) {
            progressMap.put(s.getId(), progressDAO.getProgress(uid, courseId, s.getId()));
        }

        request.setAttribute("course", courseDAO.getCourseById(courseId));
        request.setAttribute("sections", sections);
        request.setAttribute("current", current);
        request.setAttribute("progressMap", progressMap);
        request.setAttribute("mediaList", mediaList);

        request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = 1;
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int sectionId = Integer.parseInt(request.getParameter("sectionId"));

        progressDAO.markCompleted(userId, courseId, sectionId);

        response.sendRedirect(
                request.getContextPath() + "/learn?courseId=" + courseId + "&sectionId=" + sectionId
        );
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
