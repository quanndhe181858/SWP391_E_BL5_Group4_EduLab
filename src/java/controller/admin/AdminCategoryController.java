/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.CategoryDAO;
import dao.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.User;

/**
 *
 * @author quann
 */
@WebServlet(name = "AdminCategoryController", urlPatterns = {"/manager_category"})
public class AdminCategoryController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminCategoryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminCategoryController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private CategoryDAO cateDAO = new CategoryDAO();
    private CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//
//        if (session == null) {
//            response.sendRedirect(request.getContextPath() + "/logout");
//            return;
//        }
//
//        User u = (User) session.getAttribute("user");
//
//        if (u == null) {
//            response.sendRedirect(request.getContextPath() + "/logout");
//            return;
//        }
//
//        if (u.getRole_id() != 2) {
//            response.sendRedirect(request.getContextPath() + "/logout");
//            return;
//        }

        HttpSession session = request.getSession();
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");

        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success");
        }

        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }

        String keyword = request.getParameter("keyword");
        List<Category> cates;

        if (keyword != null && !keyword.trim().isEmpty()) {
            cates = cateDAO.searchCategories(keyword.trim());
        } else {
            cates = cateDAO.getCategories();
        }

        Map<Integer, Integer> countMap = new HashMap<>();
        for (Category cate : cates) {
            int count = courseDAO.countCoursesByCategoryId(cate.getId());
            countMap.put(cate.getId(), count);
        }

        request.setAttribute("total", cateDAO.countCategories());
        request.setAttribute("listcategory", cates);
        request.setAttribute("countMap", countMap);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("View/Admin/admin_manager_category.jsp")
                .forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String action = request.getParameter("action");

        if (action == null) {
            doGet(request, response);
            return;
        }

        try {
            switch (action) {
                case "create":
                    handleCreate(request, response);
                    break;
                case "update":
                    handleUpdate(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manager_category");
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String parentIdStr = request.getParameter("parent_id");

        // Validate
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Tên danh mục không được để trống!");
            response.sendRedirect(request.getContextPath() + "/manager_category");
            return;
        }

        int parentId = 0;
        if (parentIdStr != null && !parentIdStr.trim().isEmpty()) {
            try {
                parentId = Integer.parseInt(parentIdStr);
            } catch (NumberFormatException e) {
                parentId = 0;
            }
        }

        Category category = new Category();
        category.setName(name.trim());
        category.setDescription(description != null ? description.trim() : "");
        category.setParent_id(parentId);

        boolean success = cateDAO.createCategory(category);

        if (success) {
            session.setAttribute("success", "✅ Thêm danh mục thành công!");
        } else {
            session.setAttribute("error", "❌ Thêm danh mục thất bại!");
        }

        // Redirect để tránh resubmit form khi F5
        response.sendRedirect(request.getContextPath() + "/manager_category");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String parentIdStr = request.getParameter("parent_id");

        // Validate
        if (idStr == null || name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/manager_category");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            int parentId = 0;

            if (parentIdStr != null && !parentIdStr.trim().isEmpty()) {
                parentId = Integer.parseInt(parentIdStr);
            }

            // Không cho phép category làm cha của chính nó
            if (id == parentId) {
                session.setAttribute("error", "⚠️ Danh mục không thể là danh mục cha của chính nó!");
                response.sendRedirect(request.getContextPath() + "/manager_category");
                return;
            }

            Category category = new Category();
            category.setId(id);
            category.setName(name.trim());
            category.setDescription(description != null ? description.trim() : "");
            category.setParent_id(parentId);

            boolean success = cateDAO.updateCategory(category);

            if (success) {
                session.setAttribute("success", "✅ Cập nhật danh mục thành công!");
            } else {
                session.setAttribute("error", "❌ Cập nhật danh mục thất bại!");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID không hợp lệ!");
        }

        // Redirect để tránh resubmit form khi F5
        response.sendRedirect(request.getContextPath() + "/manager_category");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String idStr = request.getParameter("id");

        if (idStr == null) {
            session.setAttribute("error", "ID không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/manager_category");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);

            // Kiểm tra có khóa học phụ thuộc không
            int courseCount = courseDAO.countCoursesByCategoryId(id);
            if (courseCount > 0) {
                session.setAttribute("error",
                        "⚠️ Không thể xóa danh mục này vì có " + courseCount + " khóa học đang sử dụng!");
                response.sendRedirect(request.getContextPath() + "/manager_category");
                return;
            }

            boolean success = cateDAO.deleteCategory(id);

            if (success) {
                session.setAttribute("success", "✅ Xóa danh mục thành công!");
            } else {
                session.setAttribute("error", "❌ Xóa danh mục thất bại!");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID không hợp lệ!");
        }

        // Redirect để tránh resubmit form khi F5
        response.sendRedirect(request.getContextPath() + "/manager_category");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
