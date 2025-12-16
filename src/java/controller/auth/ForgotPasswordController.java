package controller.auth;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.Hash;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;
import util.Email;

@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private UserDAO uDao = new UserDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("View/Auth/ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String action = request.getParameter("action");
        Map<String, Object> result = new HashMap<>();

        try {
            if ("sendOTP".equals(action)) {
                handleSendOTP(request, response, result);
            } else if ("verifyOTP".equals(action)) {
                handleVerifyOTP(request, response, result);
            } else {
                result.put("success", false);
                result.put("message", "Hành động không hợp lệ");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();
        }

        response.getWriter().write(gson.toJson(result));
    }

    /**
     * Xử lý gửi OTP
     */
    private void handleSendOTP(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> result) {

        String email = request.getParameter("email");

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "Email không được để trống");
            return;
        }

        email = email.trim();

        // Validate email format
        if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            result.put("success", false);
            result.put("message", "Email không đúng định dạng");
            return;
        }

        // Kiểm tra email có tồn tại trong hệ thống không
        User user = uDao.getAuthUserByEmail(email);
        if (user == null) {
            result.put("success", false);
            result.put("message", "Email không tồn tại trong hệ thống");
            return;
        }

        // Kiểm tra tài khoản có bị khóa không
        if (!"Active".equals(user.getStatus())) {
            result.put("success", false);
            result.put("message", "Tài khoản đã bị khóa. Vui lòng liên hệ quản trị viên");
            return;
        }

        // Tạo OTP
        String otp = Email.generateOTP();

        // Lưu OTP và thời gian vào session
        HttpSession session = request.getSession();
        session.setAttribute("reset_otp", otp);
        session.setAttribute("reset_email", email);
        session.setAttribute("otp_time", System.currentTimeMillis());
        

        // Gửi email OTP
        boolean emailSent = Email.sendOTPEmail(email, otp);

        if (emailSent) {
            result.put("success", true);
            result.put("message", "Mã OTP đã được gửi đến email của bạn");
        } else {
            result.put("success", false);
            result.put("message", "Không thể gửi email. Vui lòng thử lại sau");
        }
    }

    /**
     * Xử lý xác thực OTP và gửi mật khẩu mới
     */
    private void handleVerifyOTP(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> result) {

        String otpInput = request.getParameter("otp");
        HttpSession session = request.getSession(false);

        // Validate OTP input
        if (otpInput == null || otpInput.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "Vui lòng nhập mã OTP");
            return;
        }

        otpInput = otpInput.trim();

        // Validate OTP format (6 chữ số)
        if (!otpInput.matches("^\\d{6}$")) {
            result.put("success", false);
            result.put("message", "Mã OTP phải là 6 chữ số");
            return;
        }

        // Kiểm tra session
        if (session == null) {
            result.put("success", false);
            result.put("message", "Phiên làm việc đã hết hạn. Vui lòng yêu cầu mã OTP mới");
            return;
        }

        String savedOTP = (String) session.getAttribute("reset_otp");
        String email = (String) session.getAttribute("reset_email");
        Long otpTime = (Long) session.getAttribute("otp_time");

        // Kiểm tra OTP có tồn tại không
        if (savedOTP == null || email == null || otpTime == null) {
            result.put("success", false);
            result.put("message", "Không tìm thấy mã OTP. Vui lòng yêu cầu mã mới");
            return;
        }

        // Kiểm tra OTP có hết hạn không (5 phút)
        long currentTime = System.currentTimeMillis();
        long elapsedTime = (currentTime - otpTime) / 1000; // giây

        if (elapsedTime > 300) { // 5 phút = 300 giây
            session.removeAttribute("reset_otp");
            session.removeAttribute("reset_email");
            session.removeAttribute("otp_time");
            result.put("success", false);
            result.put("message", "Mã OTP đã hết hạn. Vui lòng yêu cầu mã mới");
            return;
        }

        // Kiểm tra OTP có đúng không
        if (!savedOTP.equals(otpInput)) {
            result.put("success", false);
            result.put("message", "Mã OTP không chính xác");
            return;
        }

        // OTP đúng - Tạo mật khẩu mới
        String newPassword = Email.generateRandomPassword();
        String hashedPassword = Hash.sha512(newPassword);

        // Lấy user từ database
        User user = uDao.getAuthUserByEmail(email);
        if (user == null) {
            result.put("success", false);
            result.put("message", "Không tìm thấy người dùng");
            return;
        }

        // Cập nhật mật khẩu mới vào database
        boolean updated = uDao.updatePassword(hashedPassword, user.getId());

        if (!updated) {
            result.put("success", false);
            result.put("message", "Không thể cập nhật mật khẩu. Vui lòng thử lại");
            return;
        }

        // Gửi email mật khẩu mới
        boolean emailSent = Email.sendNewPasswordEmail(email, newPassword);

        if (!emailSent) {
            result.put("success", false);
            result.put("message", "Đã cập nhật mật khẩu nhưng không thể gửi email. Vui lòng liên hệ quản trị viên");
            return;
        }

        // Xóa thông tin OTP khỏi session
        session.removeAttribute("reset_otp");
        session.removeAttribute("reset_email");
        session.removeAttribute("otp_time");

        result.put("success", true);
        result.put("message", "Mật khẩu mới đã được gửi đến email của bạn");
    }
}
