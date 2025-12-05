/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

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
import service.CourseServices;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;
import util.AuthUtils;
import util.ResponseUtils;

/**
 *
 * @author quan
 */
@WebServlet(name = "InstructorCourseController", urlPatterns = {
    "/instructor/courses"
})
public class InstructorCourseController extends HttpServlet {

    private CategoryServices _categoryService;
    private CourseServices _courseService;
    private final String BASE_PATH = "/instructor/courses";

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        _categoryService = new CategoryServices();
        _courseService = new CourseServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String qs = req.getQueryString();
            User user = AuthUtils.doAuthorize(req, resp, 2);

            if (qs == null) {
                this.getListCourses(req, resp);
            } else {
                this.getCourseDetail(req, resp);
            }

        } catch (ServletException | IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Object> res = new HashMap<>();

        try {
            User user = AuthUtils.doAuthorize(req, resp, 2);

        } catch (ServletException | IOException e) {
            resp.setStatus(500);
            res.put("success", false);
            res.put("message", httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }

        ResponseUtils.sendJsonResponse(resp, res);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User user = AuthUtils.doAuthorize(req, resp, 2);

            String courseIdStr = req.getParameter("cid");

            if (courseIdStr == null || courseIdStr.isBlank()) {
                resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
                return;
            }

            int courseId = 0;

            try {
                courseId = Integer.parseInt(courseIdStr);
            } catch (NumberFormatException e) {
                resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
                return;
            }

            Course c = _courseService.getCourseById(courseId);

            if (c == null || c.getUuid() == null) {
                resp.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
                return;
            }

            boolean isDeleted = _courseService.deleteCourse(courseId);

            if (isDeleted) {

            } else {
                resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
            }

        } catch (IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Object> res = new HashMap<>();

        try {
            User user = AuthUtils.doAuthorize(req, resp, 2);
            
        } catch (ServletException | IOException e) {
            resp.setStatus(500);
            res.put("success", false);
            res.put("message", httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }

        ResponseUtils.sendJsonResponse(resp, res);
    }

    protected void getListCourses(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("../View/Instructor/CourseList.jsp").forward(req, resp);
    }

    protected void getCourseDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String courseIdStr = req.getParameter("cid");

        if (courseIdStr == null || courseIdStr.isBlank()) {
            resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
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
            resp.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            return;
        } else {
            req.setAttribute("course", c);
        }

        req.getRequestDispatcher("../View/Instructor/CourseDetail.jsp").forward(req, resp);
    }

}
