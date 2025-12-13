package controller.home;

import dao.MediaDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import model.Media;
import model.User;
import util.FileUtils;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 15 // 15MB
)
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

    static final MediaDAO mediaDao = new MediaDAO();
    static final UserDAO userDao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        Media m = mediaDao.getMediaByIdAndType("user", u.getId());

        request.setAttribute("media", m);
        request.getRequestDispatcher("View/profile.jsp").forward(request, response);
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

        String action = request.getParameter("action");

        // Xử lý upload avatar
        if ("uploadAvatar".equals(action)) {
            handleAvatarUpload(request, response, u);
            return;
        }

        // Xử lý cập nhật thông tin profile
        handleProfileUpdate(request, response, session, u);
    }

    private void handleAvatarUpload(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Part avatarPart = request.getPart("avatar");

            if (avatarPart == null || avatarPart.getSize() == 0) {
                out.print("{\"success\": false, \"message\": \"Không có file được chọn\"}");
                return;
            }

            Media currentMedia = mediaDao.getMediaByIdAndType("user", user.getId());
            String oldPath = (currentMedia != null) ? currentMedia.getPath() : null;

            String newPath = FileUtils.saveFile(avatarPart, "avatar", getServletContext());

            if (oldPath != null && !oldPath.isEmpty()) {
                if (!oldPath.equalsIgnoreCase("/media/avatar/default-avatar.avif")) {
                    FileUtils.deleteFile(oldPath, getServletContext());
                }
            }

            HttpSession session = request.getSession();

            if (currentMedia != null) {
                currentMedia.setPath(newPath);
                mediaDao.updateMedia(currentMedia);
                session.setAttribute("avatar", currentMedia);
            } else {
                Media newMedia = new Media();
                newMedia.setPath(newPath);
                newMedia.setType("user");
                newMedia.setObjectId(user.getId());
                mediaDao.createMedia(newMedia, user.getId());
                session.setAttribute("avatar", newMedia);
            }

            session.setAttribute("user", userDao.getUserById(user.getId()));

            out.print("{\"success\": true, \"message\": \"Cập nhật avatar thành công\", \"path\": \"" + newPath + "\"}");

        } catch (IllegalArgumentException e) {
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (ServletException | IOException e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra khi upload avatar\"}");
        } finally {
            out.flush();
        }
    }

    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, User u) throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String bodStr = request.getParameter("bod");
        String userIdStr = request.getParameter("userId");

        if (firstName == null || firstName.isBlank()
                || lastName == null || lastName.isBlank()
                || userIdStr == null || userIdStr.isBlank()) {

            request.setAttribute("error", "Họ và tên không được để trống hoặc chỉ có khoảng trắng!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
            return;
        }

        LocalDate bod = null;
        int userId = Integer.parseInt(userIdStr);

        if (bodStr != null && !bodStr.isBlank()) {
            try {
                bod = LocalDate.parse(bodStr);
            } catch (DateTimeParseException e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ!");
                Media m = mediaDao.getMediaByIdAndType("user", u.getId());
                request.setAttribute("media", m);
                request.getRequestDispatcher("View/profile.jsp").forward(request, response);
                return;
            }
        }

        if (bod != null && bod.isAfter(LocalDate.now().plusDays(1))) {
            request.setAttribute("error", "Ngày sinh không được nằm trong tương lai!");
            Media m = mediaDao.getMediaByIdAndType("user", u.getId());
            request.setAttribute("media", m);
            request.getRequestDispatcher("View/profile.jsp").forward(request, response);
            return;
        }

        userDao.updateUserInfo(firstName, lastName, bod, userId);

        u = userDao.getUserById(userId);
        Media m = mediaDao.getMediaByIdAndType("user", u.getId());

        request.setAttribute("ok", "Cập nhật thông tin thành công!");
        request.setAttribute("media", m);
        session.setAttribute("user", u);
        request.getRequestDispatcher("View/profile.jsp").forward(request, response);
    }
}
