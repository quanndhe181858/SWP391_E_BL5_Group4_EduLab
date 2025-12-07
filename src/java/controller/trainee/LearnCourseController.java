/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import dao.CourseDAO;
import dao.CourseProgressDAO;
import dao.CourseSectionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Course;
import model.CourseProgress;
import model.CourseSection;

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = 1; // hardcode cho test

        // Hardcode courseId = 4
        int courseId = 4;

        // Lấy danh sách toàn bộ bài học trong khóa này
        List<CourseSection> sections = sectionDAO.getAllCourseSectionsByCourseId(courseId);

        if (sections == null || sections.isEmpty()) {
            response.sendError(404, "This course has no lessons.");
            return;
        }

        // Lấy sectionId trên URL
        String rawSectionId = request.getParameter("sectionId");
        int sectionId;

        // 🔥 Nếu không có sectionId trên URL → chọn bài học đầu tiên
        if (rawSectionId == null) {
            sectionId = sections.get(0).getId();
        } else {
            sectionId = Integer.parseInt(rawSectionId);
        }

        // Lấy thông tin khóa học
        Course course = courseDAO.getCourseById(courseId);

        // Lấy section hiện tại
        CourseSection currentSection = sectionDAO.getCourseSectionById(sectionId);
        if (currentSection == null) {
            currentSection = sections.get(0); // fallback
            sectionId = currentSection.getId();
        }

        // Ghi lại tiến trình
        progressDAO.createOrUpdateProgress(userId, courseId, sectionId);

        // Load tiến độ
        Map<Integer, CourseProgress> progressMap = new HashMap<>();
        for (CourseSection s : sections) {
            CourseProgress p = progressDAO.getProgress(userId, courseId, s.getId());
            progressMap.put(s.getId(), p);
        }

        // Set attribute sang JSP
        request.setAttribute("course", course);
        request.setAttribute("sections", sections);
        request.setAttribute("current", currentSection);
        request.setAttribute("progressMap", progressMap);

        request.getRequestDispatcher("/View/Trainee/learn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = 1; // hardcode test
    int courseId = Integer.parseInt(request.getParameter("courseId"));
    int sectionId = Integer.parseInt(request.getParameter("sectionId"));

    // đánh dấu hoàn thành
    progressDAO.markCompleted(userId, courseId, sectionId);

    // Redirect về lại học bài
    response.sendRedirect(request.getContextPath()
        + "/learn?courseId=" + courseId + "&sectionId=" + sectionId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
