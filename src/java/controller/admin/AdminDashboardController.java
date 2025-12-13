package controller.admin;

import dao.DashboardDAO;
import dtos.DashboardStatisticDTO;
import dtos.RecentActivityDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Course;
import model.User;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin_dashboard"})
public class AdminDashboardController extends HttpServlet {

    private static final DashboardDAO dDao = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DashboardStatisticDTO ds = dDao.getAdminStatistic();
        List<Course> cList = dDao.getPopularCourses(10);
        List<User> uList = dDao.getNewestUsers(10);
        List<RecentActivityDTO> raList = dDao.getRecentActivity(10);

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
