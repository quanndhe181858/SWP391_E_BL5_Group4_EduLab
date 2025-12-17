/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.admin;

import constant.paging;
import dao.CategoryDAO;
import dao.CourseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Course;
import model.User;
import util.ResponseUtils;

/**
 *
 * @author quan
 */
@WebServlet(name = "AdminCoursesController", urlPatterns = {"/admin/courses"})
public class AdminCoursesController extends HttpServlet {

    private final CourseDAO cDao = new CourseDAO();
    private final CategoryDAO cateDao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (u.getRole_id() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String search = req.getParameter("search");
        String categoryIdStr = req.getParameter("categoryId");
        String status = req.getParameter("status");
        String sortBy = req.getParameter("sortBy");
        String curPageStr = req.getParameter("pageNum");

        int page = 1;
        int categoryId = 0;
        if (categoryIdStr != null && !categoryIdStr.isBlank()) {
            categoryId = Integer.parseInt(categoryIdStr);
        }
        if (curPageStr != null && !curPageStr.isBlank()) {
            page = Integer.parseInt(curPageStr);
        }

        boolean hide_by_admin = false;

        if (status != null && status.equals("Hidden")) {
            status = "";
            hide_by_admin = true;
        }

        int offset = (page - 1) * paging.ADMIN_COURSE_MANAGEMENT_PER_PAGE;

        List<Course> cList = cDao.getAllCoursesForAdmin(paging.ADMIN_COURSE_MANAGEMENT_PER_PAGE, offset, search, search, categoryId, status, sortBy, hide_by_admin);
        int countAllCourse = cDao.countAllCourse("", "", 0, "", false);
        int CountActiveCourses = cDao.countAllCourse("", "", 0, "Active", false);
        int countHiddenCourse = cDao.countAllCourse("", "", 0, "", true);

        int totalPages = (int) Math.ceil((double) countAllCourse / paging.ADMIN_COURSE_MANAGEMENT_PER_PAGE);

        List<Category> categories = cateDao.getCategories();

        req.setAttribute("totalCourses", countAllCourse);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("search", search);
        req.setAttribute("activeCourses", CountActiveCourses);
        req.setAttribute("hiddenCourses", countHiddenCourse);
        req.setAttribute("categoryId", categoryId);
        req.setAttribute("status", status);
        req.setAttribute("sortBy", sortBy);
        req.setAttribute("curPage", page);
        req.setAttribute("categories", categories);
        req.setAttribute("cList", cList);
        req.getRequestDispatcher("../View/Admin/CoursesManagement.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> res = new HashMap<>();

        String courseIdStr = req.getParameter("courseId");

        if (courseIdStr == null || courseIdStr.isBlank()) {
            resp.setStatus(400);
            res.put("success", false);
            res.put("message", "Course ID không hợp lệ");
            ResponseUtils.sendJsonResponse(resp, res);
            return;
        }

        int courseId = Integer.parseInt(courseIdStr);

        Course c = cDao.getCourseById(courseId);

        boolean toggle = !c.isHide_by_admin();

        cDao.UpdateHideByAdmin(courseId, toggle);
        resp.setStatus(200);
        res.put("success", true);
        res.put("message", "Ẩn course thành công");
        ResponseUtils.sendJsonResponse(resp, res);
    }

}
