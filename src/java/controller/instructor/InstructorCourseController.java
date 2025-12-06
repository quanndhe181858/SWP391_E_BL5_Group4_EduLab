/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import constant.httpStatus;
import constant.paging;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Course;
import model.User;
import service.CategoryServices;
import service.CourseServices;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.Category;
import model.CourseSection;
import service.CourseSectionServices;
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
    private CourseSectionServices _courseSectionService;
    private final String BASE_PATH = "/instructor/courses";

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        _categoryService = new CategoryServices();
        _courseService = new CourseServices();
        _courseSectionService = new CourseSectionServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        AuthUtils.createAndSetDummyUser(req, resp);

        try {
            String qs = req.getQueryString();
            User user = AuthUtils.doAuthorize(req, resp, 2);

            if (qs == null || qs.contains("page")) {
                this.getListCourses(req, resp, user);
            } else {
                this.getCourseDetail(req, resp, user);
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

    protected void getListCourses(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        try {
            String pageStr = req.getParameter("page");
            String search = req.getParameter("search");
            String categoryIdStr = req.getParameter("filterCategoryId");
            String status = req.getParameter("status");
            String sortBy = req.getParameter("sortBy");

            int instructorId = user.getId();

            int page = paging.DEFAULT_PAGE;
            int filterCategoryId = 0;

            if (pageStr != null && !pageStr.isBlank()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
                    return;
                }
            }

            if (categoryIdStr != null && !categoryIdStr.isBlank()) {
                try {
                    filterCategoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
                    return;
                }
            }

            int offset = (page - 1) * paging.INSTRUCTOR_COURSE_LIST_ITEM_PER_PAGE;

            List<Course> courseList = _courseService.getListCourseByInstructorId(paging.INSTRUCTOR_COURSE_LIST_ITEM_PER_PAGE, offset, search, search, filterCategoryId, status, sortBy, instructorId);
            int totalCourses = _courseService.countCoursesByInstructorId(instructorId, "all");
            int totalActiveCourses = _courseService.countCoursesByInstructorId(instructorId, "Active");
            int totalInactiveCourses = _courseService.countCoursesByInstructorId(instructorId, "Inactive");

            int totalPages = (int) Math.ceil((double) totalCourses / paging.INSTRUCTOR_COURSE_LIST_ITEM_PER_PAGE);

            int startItem = ++offset;
            int endItem = startItem + paging.INSTRUCTOR_COURSE_LIST_ITEM_PER_PAGE - 1;

            if (endItem > totalCourses) {
                endItem = totalCourses;
            }

            if (totalCourses <= 0) {
                startItem = totalCourses;
            }

            List<Category> categories = _categoryService.getCategories();

            List<Category> parentCategories = categories.stream()
                    .filter(c -> c.getParent_id() == 0)
                    .collect(Collectors.toList());

            List<Category> childCategories = categories.stream()
                    .filter(c -> c.getParent_id() != 0)
                    .collect(Collectors.toList());

            req.setAttribute("parents", parentCategories);
            req.setAttribute("children", childCategories);

            req.setAttribute("page", page);
            req.setAttribute("courseList", courseList);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("startItem", startItem);
            req.setAttribute("endItem", endItem);
            req.setAttribute("totalCourses", totalCourses);
            req.setAttribute("totalActiveCourses", totalActiveCourses);
            req.setAttribute("totalInactiveCourses", totalInactiveCourses);

            req.setAttribute("parents", parentCategories);
            req.setAttribute("children", childCategories);

            req.getRequestDispatcher("../View/Instructor/CourseList.jsp").forward(req, resp);
        } catch (IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    protected void getCourseDetail(HttpServletRequest req, HttpServletResponse resp, User user)
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

        if (c.getCreated_by() != user.getId()) {
            resp.sendError(httpStatus.FORBIDDEN.getCode(), httpStatus.FORBIDDEN.getMessage());
            return;
        }

        if (c == null || c.getUuid().isBlank()) {
            resp.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
            return;
        } else {
            List<Category> categories = _categoryService.getCategories();

            List<Category> parentCategories = categories.stream()
                    .filter(ct -> ct.getParent_id() == 0)
                    .collect(Collectors.toList());

            List<Category> childCategories = categories.stream()
                    .filter(ct -> ct.getParent_id() != 0)
                    .collect(Collectors.toList());

            List<CourseSection> csList = _courseSectionService.getSectionsByCourseId(c.getId());

            req.setAttribute("parents", parentCategories);
            req.setAttribute("children", childCategories);

            req.setAttribute("course", c);
            req.setAttribute("courseSections", csList);
        }

        req.getRequestDispatcher("../View/Instructor/CourseCreateUpdate.jsp").forward(req, resp);
    }

}
