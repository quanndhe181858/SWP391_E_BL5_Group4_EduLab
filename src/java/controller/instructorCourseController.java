/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constant.httpStatus;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.User;
import service.CategoryServices;
import service.CourseSectionServices;
import service.CourseServices;

/**
 *
 * @author quan
 */
@WebServlet(name = "InstructorCourseController", urlPatterns = {
    "/instructor/courses"
})
public class InstructorCourseController extends HttpServlet {

    private CategoryServices _categoryService;
    private CourseSectionServices _courseSectionService;
    private CourseServices _courseService;
    private httpStatus _httpStatus;
    private final String BASE_PATH = "/instructor/courses";

    @Override
    public void init(ServletConfig config) throws ServletException {
        _categoryService = new CategoryServices();
        _courseSectionService = new CourseSectionServices();
        _courseService = new CourseServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        try {
            String qs = req.getQueryString();
            User user = (User) session.getAttribute("user");

            this.doAuthorize(req, resp, user);
            
            if (qs == null) {
                this.getListCourses(req, resp);
            } else {
                this.getCourseDetail(req, resp);
            }

        } catch (ServletException | IOException e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    protected void getListCourses(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("../View/Instructor/CourseList.jsp").forward(req, resp);
    }

    protected void getCourseDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String courseIdStr = req.getParameter("cid");

        if (courseIdStr == null || courseIdStr.isBlank()) {
            resp.sendError(404);
            return;
        }

        int courseId = 0;

        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            resp.sendError(400);
            return;
        }

        Course c = _courseService.getCourseById(courseId);

        if (c == null || c.getUuid().isBlank()) {
            resp.sendError(_httpStatus.NOT_FOUND.getCode(), _httpStatus.NOT_FOUND.getMessage());
            return;
        } else {
            req.setAttribute("course", c);
        }

        req.getRequestDispatcher("../View/Instructor/CourseDetail.jsp").forward(req, resp);
    }

    protected void doAuthorize(HttpServletRequest req, HttpServletResponse resp, User u) throws IOException {
        if (u.getRole_id() != 2) {
            resp.sendError(_httpStatus.FORBIDDEN.getCode(), _httpStatus.FORBIDDEN.getMessage());
            return;
        }
    }
}
