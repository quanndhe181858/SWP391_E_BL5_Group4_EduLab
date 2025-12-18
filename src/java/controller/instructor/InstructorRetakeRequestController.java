/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import dao.CourseDAO;
import dao.TestAttemptDAOv2;
import dtos.RetakeRequestDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.TestAttempt;
import model.User;

@WebServlet(name = "InstructorRetakeRequestController", urlPatterns = {"/instructor/retake-request"})
public class InstructorRetakeRequestController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InstructorRetakeRequestController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InstructorRetakeRequestController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private final TestAttemptDAOv2 attemptDAO = new TestAttemptDAOv2();
    private final CourseDAO courseDAO = new CourseDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        try {
            String v = req.getParameter(name);
            return (v == null || v.isBlank()) ? null : Integer.parseInt(v);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User instructor = util.AuthUtils.doAuthorize(request, response, 2);
        if (instructor == null) {
            return;
        }

        Integer courseId = getInt(request, "courseId");
        String search = request.getParameter("search");

        List<RetakeRequestDTO> requests
                = attemptDAO.getPendingRetakeRequestsByInstructor(
                        instructor.getId(),
                        courseId,
                        search
                );

        request.setAttribute("requests", requests);
        request.setAttribute("courses",
                courseDAO.getCoursesByInstructorSimple(instructor.getId()));
        request.setAttribute("selectedCourseId", courseId);
        request.setAttribute("search", search);

        request.getRequestDispatcher("/View/Instructor/RetakeRequest.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User instructor = util.AuthUtils.doAuthorize(request, response, 2);
        if (instructor == null) {
            return;
        }

        String action = request.getParameter("action");
        Integer userId = getInt(request, "userId");
        Integer testId = getInt(request, "testId");

        if (action == null || userId == null || testId == null) {
            response.sendError(400, "Invalid request");
            return;
        }

        TestAttempt attempt = attemptDAO.getAttemptByUserAndTest(userId, testId);
        if (attempt == null || !"Pending".equals(attempt.getStatus())) {
            response.sendError(400, "Invalid retake state");
            return;
        }

        switch (action) {

            case "approve":
                attemptDAO.deletePendingAttempt(userId, testId);
                break;

            case "reject":
                attemptDAO.updateStatus(userId, testId, "Rejected");
                break;

            default:
                response.sendError(400, "Unknown action");
                return;
        }

        response.sendRedirect(request.getContextPath() + "/instructor/retake-request");
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
