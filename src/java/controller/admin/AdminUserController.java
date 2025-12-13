/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.UserDAO;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Role;
import model.User;


@WebServlet(name = "AdminUserController", urlPatterns = {"/admin/users"})
public class AdminUserController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        String raw = req.getParameter(name);
        return (raw == null || raw.isBlank()) ? null : Integer.parseInt(raw);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check session and authentication
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user is admin (role_id = 1)
        if (currentUser.getRole_id() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                showUserList(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "changeStatus":
                changeUserStatus(request, response);
                break;
            default:
                showUserList(request, response);
                break;
        }
    }

    private void showUserList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roleFilter = request.getParameter("role");
        List<User> userList;

        if (roleFilter != null && !roleFilter.equals("all")) {
            try {
                int roleId = Integer.parseInt(roleFilter);
                userList = userDAO.getUsersByRole(roleId);
            } catch (NumberFormatException e) {
                userList = userDAO.getAllUsers();
            }
        } else {
            userList = userDAO.getAllUsers();
        }

        request.setAttribute("userList", userList);
        request.setAttribute("selectedRole", roleFilter);
        request.getRequestDispatcher("/View/Admin/UserList.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = getInt(request, "id");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        User user = userDAO.getUserById(userId);

        if (user == null) {
            request.setAttribute("error", "Không tìm thấy người dùng!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        List<Role> roles = userDAO.getAllRoles();
        request.setAttribute("user", user);
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("/View/Admin/UpdateUser.jsp").forward(request, response);
    }

    private void changeUserStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = getInt(request, "id");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        User user = userDAO.getUserById(userId);

        if (user == null) {
            request.getSession().setAttribute("error", "Không tìm thấy người dùng!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        // Toggle status between Active and Inactive
        String newStatus = user.getStatus().equals("Active") ? "Inactive" : "Active";
        boolean success = userDAO.changeUserStatus(userId, newStatus);

        if (success) {
            request.getSession().setAttribute("success", "Đã thay đổi trạng thái người dùng thành công!");
        } else {
            request.getSession().setAttribute("error", "Thay đổi trạng thái thất bại!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check session and authentication
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user is admin (role_id = 1)
        if (currentUser.getRole_id() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateUser(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Integer userId = getInt(request, "id");

            if (userId == null) {
                request.getSession().setAttribute("error", "ID người dùng không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String bodStr = request.getParameter("bod");
            Integer roleId = getInt(request, "roleId");

            // Validation
            if (firstName == null || firstName.trim().isEmpty() ||
                    lastName == null || lastName.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    roleId == null) {
                request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                response.sendRedirect(request.getContextPath() + "/admin/users?action=edit&id=" + userId);
                return;
            }

            User user = new User();
            user.setId(userId);
            user.setFirst_name(firstName.trim());
            user.setLast_name(lastName.trim());
            user.setEmail(email.trim());
            user.setRole_id(roleId);

            // Parse date if provided
            if (bodStr != null && !bodStr.trim().isEmpty()) {
                try {
                    Date bod = Date.valueOf(bodStr);
                    user.setBod(bod);
                } catch (IllegalArgumentException e) {
                    request.getSession().setAttribute("error", "Định dạng ngày sinh không hợp lệ!");
                    response.sendRedirect(request.getContextPath() + "/admin/users?action=edit&id=" + userId);
                    return;
                }
            }

            boolean success = userDAO.updateUser(user);

            if (success) {
                request.getSession().setAttribute("success", "Cập nhật thông tin người dùng thành công!");
            } else {
                request.getSession().setAttribute("error", "Cập nhật thất bại! Email có thể đã tồn tại.");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    @Override
    public String getServletInfo() {
        return "Admin User Management Controller";
    }

}
