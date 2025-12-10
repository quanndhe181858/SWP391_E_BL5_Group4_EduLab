/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import dao.CourseDAO;
import dao.CourseSectionDAO;
import dao.QuizDAO;
import dao.QuizTestDAO;
import dao.TestsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "IntructorManagerTest", urlPatterns = {"/managerTest"})
public class IntructorManagerTest extends HttpServlet {

    private final TestsDAO testDAO = new TestsDAO();
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuizTestDAO quizTestDAO = new QuizTestDAO();
    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        String raw = req.getParameter(name);
        return (raw == null || raw.isBlank()) ? null : Integer.parseInt(raw);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        if (u.getRole_id() != 2) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        int instructorId = u.getId();

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Delete test
            Integer id = getInt(request, "id");
            if (id != null) {
                boolean deleted = testDAO.deleteTest(id);
                if (deleted) {
                    request.setAttribute("success", "Xóa bài test thành công!");
                } else {
                    request.setAttribute("error", "Xóa bài test thất bại hoặc không tồn tại!");
                }
            }
        }

        request.setAttribute("testList", testDAO.getTestsByInstructor(instructorId));
        request.getRequestDispatcher("/View/Instructor/managerTest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
