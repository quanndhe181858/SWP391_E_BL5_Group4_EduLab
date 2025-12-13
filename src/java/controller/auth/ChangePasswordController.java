/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dao.MediaDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Media;
import model.User;
import util.Hash;

/**
 *
 * @author hao
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/change-password"})
public class ChangePasswordController extends HttpServlet {

    private static final UserDAO userDao = new UserDAO();
    private static final MediaDAO mediaDao = new MediaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String curPassword = request.getParameter("curPassword");
        String newPassword = request.getParameter("newPassword");
        String rePassword = request.getParameter("rePassword");

        if (curPassword == null || curPassword.isBlank()
                || newPassword == null || newPassword.isBlank()
                || rePassword == null || rePassword.isBlank()) {
            request.setAttribute("error", "Thiếu biến giá trị, vui lòng kiểm tra kĩ các trường bắt buộc!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.setAttribute("tab", "security");
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
            return;
        }

        String hashedPassword = Hash.sha512(curPassword);
        String hashedNewPassowrd = Hash.sha512(newPassword);
        User existedUser = userDao.getAuthUser(u.getEmail(), hashedPassword);

        if (existedUser == null) {
            request.setAttribute("error", "Sai mật khẩu hiện tại!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.setAttribute("tab", "security");
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(rePassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu mới không khớp!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.setAttribute("tab", "security");
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
            return;
        }

        if (hashedNewPassowrd.equals(hashedPassword)) {
            request.setAttribute("error", "Mật khẩu mới phải khác với mật khẩu cũ!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.setAttribute("tab", "security");
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
            return;
        }

        boolean isUpdatedPassword = userDao.updatePassword(hashedNewPassowrd, u.getId());

        if (isUpdatedPassword) {
            request.setAttribute("ok", "Đổi mật khẩu thành công!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.setAttribute("tab", "security");
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật mật khẩu!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.setAttribute("tab", "security");
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
        }
    }

}
