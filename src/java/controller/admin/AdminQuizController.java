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
import dao.QuizAnswerDAO;
import dao.UserDAO;
import model.User;
import model.Quiz;
import model.QuizAnswer;
import model.Category;
import java.util.List;

@WebServlet(name = "AdminQuizController", urlPatterns = { "/admin/quizzes" })
public class AdminQuizController extends HttpServlet {

    private QuizDAO quizDAO;
    private CategoryDAO categoryDAO;
    private QuizAnswerDAO quizAnswerDAO; // Added field
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        quizDAO = new QuizDAO();
        categoryDAO = new CategoryDAO();
        quizAnswerDAO = new QuizAnswerDAO(); // Initialized
        userDAO = new UserDAO();
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
            case "detail":
                viewDetail(request, response);
                break;
            default:
                listQuizzes(request, response);
                break;
        }
    }

    private void viewDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Quiz quiz = quizDAO.getQuizById(id);
                if (quiz != null) {
                    Category category = categoryDAO.getCategoryById(quiz.getCategory_id());
                    quiz.setCategory(category);

                    List<QuizAnswer> answers = quizAnswerDAO.getQuizAnswersByQuizId(id);
                    quiz.setAnswers(answers);

                    if (quiz.getCreated_by() > 0) {
                        User creator = userDAO.getUserById(quiz.getCreated_by());
                        request.setAttribute("creator", creator);
                    }
                    if (quiz.getUpdated_by() > 0) {
                        User updater = userDAO.getUserById(quiz.getUpdated_by());
                        request.setAttribute("updater", updater);
                    }

                    request.setAttribute("quiz", quiz);
                    request.getRequestDispatcher("/View/Admin/QuizDetail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // ignore
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/quizzes");
    }

    private void listQuizzes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pageParam = request.getParameter("page");
        String keyword = request.getParameter("keyword");
        String type = request.getParameter("type");
        String categoryIdParam = request.getParameter("category");
        String status = request.getParameter("status");
        String sort = request.getParameter("sort");

        int page = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        Integer categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                // ignore invalid category id
            }
        }

        // Use the new search method that handles all filters and sorting
        List<Quiz> allQuizzes = quizDAO.searchQuizzes(keyword, type, categoryId, status, sort);

        // Manual Pagination
        int pageSize = 10;
        int totalQuizzes = allQuizzes.size();
        int totalPages = (int) Math.ceil((double) totalQuizzes / pageSize);

        if (page < 1)
            page = 1;
        if (page > totalPages && totalPages > 0)
            page = totalPages;

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalQuizzes);

        List<Quiz> paginatedList;
        if (start > end) {
            paginatedList = List.of();
        } else {
            paginatedList = allQuizzes.subList(start, end);
        }

        // Fetch categories and create a map for easy lookup in JSP
        List<Category> categories = categoryDAO.getCategories();
        request.setAttribute("categories", categories); // Passed list for dropdown
        java.util.Map<Integer, String> categoryMap = new java.util.HashMap<>();
        if (categories != null) {
            for (Category c : categories) {
                categoryMap.put(c.getId(), c.getName());
            }
        }
        request.setAttribute("categoryMap", categoryMap);

        request.setAttribute("quizList", paginatedList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Fetch global counts for statistics cards
        java.util.Map<String, Integer> counts = quizDAO.getQuizCounts();
        request.setAttribute("totalQuizzes", counts.getOrDefault("total", 0));
        request.setAttribute("activeQuizzes", counts.getOrDefault("active", 0));
        request.setAttribute("hiddenQuizzes", counts.getOrDefault("hidden", 0));

        // Count for filtered results
        request.setAttribute("totalFilteredQuizzes", totalQuizzes);

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
