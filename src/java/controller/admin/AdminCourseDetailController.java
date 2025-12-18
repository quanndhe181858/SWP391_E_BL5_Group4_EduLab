/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import constant.httpStatus;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.Category;
import model.Course;
import model.CourseSection;
import model.User;
import service.CategoryServices;
import service.CourseSectionServices;
import service.CourseServices;
import service.MediaServices;
import util.AuthUtils;
import util.ResponseUtils;

/**
 *
 * @author quan
 */
@WebServlet(name = "AdminCourseDetailController", urlPatterns = {"/admin/courses/detail"})
public class AdminCourseDetailController extends HttpServlet {

    private CategoryServices _categoryService;
    private CourseServices _courseService;
    private CourseSectionServices _courseSectionService;
    private MediaServices _mediaService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        _categoryService = new CategoryServices();
        _courseService = new CourseServices();
        _courseSectionService = new CourseSectionServices();
        _mediaService = new MediaServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Object> res = new HashMap<>();

        User user = AuthUtils.doAuthorize(req, resp, 1);

        if (user == null) {
            return;
        }

        String courseIdStr = req.getParameter("cid");

        if (courseIdStr == null || courseIdStr.isBlank()) {
            resp.setStatus(400);
            res.put("success", false);
            res.put("message", httpStatus.BAD_REQUEST.getMessage());
            ResponseUtils.sendJsonResponse(resp, res);
            return;
        }

        int courseId = 0;

        try {
            courseId = Integer.parseInt(courseIdStr);
        } catch (NumberFormatException e) {
            resp.setStatus(500);
            res.put("success", false);
            res.put("message", httpStatus.INTERNAL_SERVER_ERROR.getMessage());
            ResponseUtils.sendJsonResponse(resp, res);
            return;
        }

        Course c = _courseService.getCourseById(courseId);

        if (c == null || c.getUuid().isBlank()) {
            resp.setStatus(500);
            res.put("success", false);
            res.put("message", httpStatus.NOT_FOUND.getMessage());
            ResponseUtils.sendJsonResponse(resp, res);
        } else {
            List<CourseSection> csList = _courseSectionService.getSectionsByCourseId(c.getId());

            for (CourseSection cs : csList) {
                if (cs.getType() != "text") {
                    cs.setMedia(_mediaService.getMediaByIdAndType("section", cs.getId()));
                }
            }

            resp.setStatus(200);
            res.put("success", true);
            res.put("course", c);
            res.put("sections", csList);
            res.put("message", httpStatus.NOT_FOUND.getMessage());
            ResponseUtils.sendJsonResponse(resp, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
