/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import constant.httpStatus;
import constant.paging;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;
import model.Category;
import model.Course;
import model.CourseSection;
import service.CategoryServices;
import service.CourseSectionServices;
import service.CourseServices;

/**
 *
 * @author quan
 */
@WebServlet(name = "TraineeCoursesController", urlPatterns = {
    "/courses"
})
public class TraineeCoursesController extends HttpServlet {

    private CourseServices _courseService;
    private CategoryServices _categoryService;
    private CourseSectionServices _courseSectionService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        _courseService = new CourseServices();
        _categoryService = new CategoryServices();
        _courseSectionService = new CourseSectionServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String qs = req.getQueryString();

            if (qs == null || qs.contains("page") || qs.contains("search")) {
                this.getCourseCatalog(req, resp);
            } else if (qs.contains("id")) {
                this.getCourseDetail(req, resp);
            } else {

            }
        } catch (ServletException | IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {

        } catch (Exception e) {
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

        } catch (Exception e) {
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

        } catch (Exception e) {
        }
    }

    protected void getCourseCatalog(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String pageStr = req.getParameter("page");
            String search = req.getParameter("search");
            String categoryIdStr = req.getParameter("categoryId");

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

            int offset = (page - 1) * paging.COURSE_CATALOG_ITEM_PER_PAGE;

            List<Course> courseCatalog = _courseService.getCourseCatalog(paging.COURSE_CATALOG_ITEM_PER_PAGE, offset, search, search, filterCategoryId);
            int totalCourses = _courseService.countCourseCatalog(search, search, filterCategoryId);

            int totalPages = (int) Math.ceil((double) totalCourses / paging.COURSE_CATALOG_ITEM_PER_PAGE);

            int startItem = ++offset;
            int endItem = startItem + paging.COURSE_CATALOG_ITEM_PER_PAGE - 1;

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
            req.setAttribute("courseCatalog", courseCatalog);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("startItem", startItem);
            req.setAttribute("endItem", endItem);
            req.setAttribute("totalCourses", totalCourses);

            req.getRequestDispatcher("/View/Trainee/CourseCatalog.jsp").forward(req, resp);
        } catch (IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    protected void getCourseDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String courseIdStr = req.getParameter("id");

            if (courseIdStr == null || courseIdStr.isBlank()) {
                resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
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
                List<CourseSection> csList = _courseSectionService.getSectionsByCourseId(c.getId());

                req.setAttribute("course", c);
                req.setAttribute("sections", csList);
            }
            
            req.getRequestDispatcher("/View/Trainee/CourseDetail.jsp").forward(req, resp);
        } catch (IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

}
