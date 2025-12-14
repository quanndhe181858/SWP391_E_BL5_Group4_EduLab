package controller.instructor;

import dao.DashboardDAO;
import dtos.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.User;

@WebServlet(name = "InstructorDashboardServlet", urlPatterns = {"/instructor/dashboard"})
public class InstructorDashboardController extends HttpServlet {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User instructor = (User) session.getAttribute("user");

        if (instructor == null || instructor.getRole_id() != 2) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int instructorId = instructor.getId();

        String filterParam = request.getParameter("filter");
        int currentFilter = 7;

        if (filterParam != null) {
            try {
                currentFilter = Integer.parseInt(filterParam);
            } catch (NumberFormatException e) {
                currentFilter = 7;
            }
        }

        InstructorDashboardStatisticDTO stats = dashboardDAO.getInstructorStatistic(instructorId);
        List<InstructorCourseDTO> myCourses = dashboardDAO.getInstructorCourses(instructorId, 5);
        List<TopStudentDTO> topStudents = dashboardDAO.getTopStudents(instructorId, 5);
        List<InstructorActivityDTO> recentActivities = dashboardDAO.getInstructorRecentActivities(instructorId, 10);
        List<EngagementStatisticDTO> engagementStats = dashboardDAO.getEngagementStatistic(instructorId, currentFilter);
        List<CoursePerformanceDTO> coursePerformance = dashboardDAO.getCoursePerformance(instructorId, 5);

        request.setAttribute("myCourses", myCourses);
        request.setAttribute("topStudents", topStudents);
        request.setAttribute("recentActivities", recentActivities);
        request.setAttribute("engagementStats", engagementStats);
        request.setAttribute("currentFilter", currentFilter);
        request.setAttribute("coursePerformance", coursePerformance);
        request.setAttribute("ds", stats);
        request.getRequestDispatcher("../View/Instructor/instructor-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
