package controller.admin;

import dao.DashboardDAO;
import dtos.CategoriesStatisticDTO;
import dtos.DashboardStatisticDTO;
import dtos.RecentActivityDTO;
import dtos.UsersStatisticDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Course;
import model.User;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin_dashboard"})
public class AdminDashboardController extends HttpServlet {

    private static final DashboardDAO dDao = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (u.getRole_id() != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userChartDayFilterStr = request.getParameter("chartDayFilter");

        int userChartDayFilter = 7;

        if (userChartDayFilterStr != null && !userChartDayFilterStr.isBlank()) {
            userChartDayFilter = Integer.parseInt(userChartDayFilterStr);
        }

        DashboardStatisticDTO ds = dDao.getAdminStatistic();
        List<Course> cList = dDao.getPopularCourses(10);
        List<User> uList = dDao.getNewestUsers(10);
        List<RecentActivityDTO> raList = dDao.getRecentActivity(10);
        List<UsersStatisticDTO> usList = dDao.getUsersStatisticChartData(userChartDayFilter);
        List<CategoriesStatisticDTO> csList = dDao.getCategoriesStatisticChartData();

        request.setAttribute("currentFilter", userChartDayFilter);
        request.setAttribute("usList", usList);
        request.setAttribute("csList", csList);
        request.setAttribute("ds", ds);
        request.setAttribute("cList", cList);
        request.setAttribute("uList", uList);
        request.setAttribute("raList", raList);
        request.getRequestDispatcher("View/Admin/admin_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
