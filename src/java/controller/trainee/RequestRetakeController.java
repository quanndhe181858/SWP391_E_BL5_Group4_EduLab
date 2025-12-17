/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import dao.TestAttemptDAOv2;
import dao.TestsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Test;
import model.TestAttempt;
import model.User;

@WebServlet(name = "RequestRetakeController", urlPatterns = {"/trainee/request_retake"})
public class RequestRetakeController extends HttpServlet {

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
            out.println("<title>Servlet RequestRetakeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestRetakeController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private final TestAttemptDAOv2 testAttemptDAO = new TestAttemptDAOv2();
    private final TestsDAO testDAO = new TestsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User u = util.AuthUtils.doAuthorize(request, response, 3);
        if (u == null) {
            return;
        }

        int userId = u.getId();
        Integer testId = Integer.parseInt(request.getParameter("testId"));

        TestAttempt attempt = testAttemptDAO.getAttemptByUserAndTest(userId, testId);

        if (attempt == null || !"Retaking".equals(attempt.getStatus())) {
            response.sendError(400, "Invalid retake request");
            return;
        }

        // chuyển sang Pending
        testAttemptDAO.updateStatus(userId, testId, "Pending");
        Test test = testDAO.getById(testId);

        if (test == null) {
            response.sendError(404);
            return;
        }
        response.sendRedirect(request.getContextPath()
                + "/learn?courseId=" + test.getCourseId());
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
