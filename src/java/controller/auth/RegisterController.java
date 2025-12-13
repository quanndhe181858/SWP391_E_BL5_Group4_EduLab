/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.auth;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Media;
import model.User;
import util.Email;
import util.Hash;
import util.ValidateUtils;

/**
 *
 * @author hao
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private static final UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/View/Auth/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy parameters từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");

        // Kiểm tra các trường có bị null hoặc rỗng không
        if (firstName == null || firstName.isBlank()
                || lastName == null || lastName.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()
                || rePassword == null || rePassword.isBlank()) {

            request.setAttribute("error", "Vui lòng điền đầy đủ các trường thông tin.");
            request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
            return;
        }

        // Validate email
        if (!ValidateUtils.validateEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ.");
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
            return;
        }

        // Validate password
        if (!ValidateUtils.validatePassword(password)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt.");
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu nhập lại có khớp không
        if (!password.equals(rePassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp.");
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại chưa
        if (userDao.isEmailExisted(email)) {
            request.setAttribute("error", "Email này đã được đăng ký.");
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
            return;
        }

        try {
            // Hash password và tạo user mới
            String hashedPassword = Hash.sha512(password);
            User u = new User(firstName, lastName, email, hashedPassword);

            // Đăng ký user
            boolean isRegistered = userDao.doRegister(u);

            if (isRegistered) {
                // Đăng ký thành công - chuyển đến trang login
                Email.sendEmail(email, "Đăng kí tài khoản EduLAB thành công.", "Ban da dang ki tai khoan EduLAB thanh cong, cam on ban da tin tuong.");

                request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                // Đăng ký thất bại
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
            }

        } catch (ServletException | IOException e) {
            // Xử lý exception
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại.");
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/View/Auth/register.jsp").forward(request, response);
        }
    }

}
