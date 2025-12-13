/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import jakarta.servlet.ServletConfig;
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
import service.CourseServices;

/**
 *
 * @author hoanghao
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private CourseServices _courseService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        _courseService = new CourseServices();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            User u = (User) session.getAttribute("user");

            if (u != null) {
                if (u.getRole_id() == 2) {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses");
                    return;
                }
            }
        }

        List<Course> cList = _courseService.getAllCourses(8, 0, "", "", 0, "Active", "created_at desc");

        request.setAttribute("cList", cList);
        request.getRequestDispatcher("View/Home/Homepage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
