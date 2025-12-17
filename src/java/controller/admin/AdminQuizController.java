/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.QuizDAO;
import dao.CategoryDAO;
import model.User;
import model.Quiz;
import java.util.List;

@WebServlet(name = "AdminQuizController", urlPatterns = { "/admin/quizzes" })
public class AdminQuizController extends HttpServlet {

    private QuizDAO quizDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        quizDAO = new QuizDAO();
        categoryDAO = new CategoryDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check admin role
        if (user == null || user.getRole_id() != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null)
            action = "list";

        switch (action) {
            case "list":
                listQuizzes(request, response);
                break;
            case "hide":
                updateStatus(request, response, "Hidden");
                break;
            case "show":
                updateStatus(request, response, "Active");
                break;
            default:
                listQuizzes(request, response);
                break;
        }
    }

    private void listQuizzes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Reuse similar logic from InstructorQuizController for pagination if needed,
        // or just getAll for now as per simple requirement.
        // Let's implement basic pagination to be safe for large datasets.

        int page = 1;
        int limit = 10;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Quiz> allQuizzes = quizDAO.getAllQuizzes();

        // Simple manual pagination since DAO returns all
        int totalItems = allQuizzes.size();
        int totalPages = (int) Math.ceil((double) totalItems / limit);

        int start = (page - 1) * limit;
        int end = Math.min(start + limit, totalItems);

        List<Quiz> paginatedList;
        if (start < totalItems) {
            paginatedList = allQuizzes.subList(start, end);
        } else {
            paginatedList = new java.util.ArrayList<>();
        }

        request.setAttribute("quizList", paginatedList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/View/Admin/QuizList.jsp").forward(request, response);
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response, String status)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                quizDAO.updateQuizStatus(id, status);
                request.getSession().setAttribute("notification", "Quiz status updated to " + status);
                request.getSession().setAttribute("notificationType", "success");
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("notification", "Invalid Quiz ID");
                request.getSession().setAttribute("notificationType", "error");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/quizzes");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin Quiz Controller";
    }

}
