/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import dao.CourseDAO;
import dao.CourseProgressDAO;
import dao.CourseSectionDAO;
import dao.TestAttemptDAOv2;
import dao.TestsDAO;
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
import model.Test;
import model.TestAttempt;
import model.User;

@WebServlet(name = "TraineeAccomplishmentDetailController", urlPatterns = {"/trainee/accomplishment-detail"})
public class TraineeAccomplishmentDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TraineeAccomplishmentDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TraineeAccomplishmentDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();
    private final TestsDAO testsDAO = new TestsDAO();
    private final TestAttemptDAOv2 attemptDAO = new TestAttemptDAOv2();
    private final CourseProgressDAO progressDAO = new CourseProgressDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = user.getId();
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        // 1. Course info
        Course course = courseDAO.getCourseById(courseId);

        // 2. Sections
        List<CourseSection> sections =
                sectionDAO.getAllCourseSectionsByCourseId(courseId);

        // 3. Progress map
        Map<Integer, CourseProgress> progressMap = new HashMap<>();
        for (CourseSection s : sections) {
            CourseProgress p = progressDAO.getProgress(userId, courseId, s.getId());
            progressMap.put(s.getId(), p);
        }

        // 4. Test + attempts
        Map<Integer, Test> testMap = new HashMap<>();
        Map<Integer, List<TestAttempt>> attemptMap = new HashMap<>();

        for (CourseSection s : sections) {
            Test t = testsDAO.getTestBySectionId(s.getId());
            if (t != null) {
                testMap.put(s.getId(), t);
                attemptMap.put(
                    s.getId(),
                    attemptDAO.getAttemptsByUserAndTest(userId, t.getId())
                );
            }
        }

        request.setAttribute("course", course);
        request.setAttribute("sections", sections);
        request.setAttribute("progressMap", progressMap);
        request.setAttribute("testMap", testMap);
        request.setAttribute("attemptMap", attemptMap);

        request.getRequestDispatcher("/View/Trainee/AccomplishmentDetail.jsp")
               .forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
