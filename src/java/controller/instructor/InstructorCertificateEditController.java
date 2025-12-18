package controller.instructor;

import dao.CertificateDAO;
import dao.CourseDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Certificate;
import model.Course;
import model.User;

@WebServlet(name = "InstructorCertificateEditController", urlPatterns = {"/instructor/certificate/edit"})
public class InstructorCertificateEditController extends HttpServlet {

    private final CertificateDAO certDao = new CertificateDAO();
    private final CourseDAO courseDao = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
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

        if (u.getRole_id() != 2) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String certIdStr = req.getParameter("id");
        if (certIdStr == null || certIdStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/instructor/manager/certificate");
            return;
        }

        try {
            int certId = Integer.parseInt(certIdStr);
            Certificate cert = certDao.getCertificateById(certId);

            if (cert == null) {
                req.getSession().setAttribute("error", "Không tìm thấy chứng chỉ!");
                resp.sendRedirect(req.getContextPath() + "/instructor/manager/certificate");
                return;
            }

            if (cert.getCourseId() > 0) {
                Course c = courseDao.getCourseById(cert.getCourseId());
                req.setAttribute("courseName", c.getTitle());
            }

            req.setAttribute("cert", cert);
            req.getRequestDispatcher("/View/Instructor/EditCertificate.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/instructor/manager/certificate");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

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

        if (u.getRole_id() != 2) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int certId = Integer.parseInt(req.getParameter("id"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String status = req.getParameter("status");

            if (title == null || title.trim().isEmpty()) {
                req.setAttribute("error", "Tiêu đề không được để trống!");
                doGet(req, resp);
                return;
            }

            if (title.length() > 100) {
                req.setAttribute("error", "Tiêu đề chỉ được dài tối đa 100 từ!");
                doGet(req, resp);
                return;
            }

            if (description.length() > 200) {
                req.setAttribute("error", "Mô tả chỉ được dài tối đa 200 từ!");
                doGet(req, resp);
                return;
            }

            Certificate cert = certDao.getCertificateById(certId);
            if (cert == null) {
                req.setAttribute("error", "Không tìm thấy chứng chỉ!");
                resp.sendRedirect(req.getContextPath() + "/instructor/manager/certificate");
                return;
            }

            cert.setTitle(title.trim());
            cert.setDescription(description != null ? description.trim() : "");
            cert.setStatus(status);

            boolean success = certDao.updateCertificate(cert);

            if (success) {
                req.setAttribute("success", "Cập nhật chứng chỉ thành công!");
                doGet(req, resp);
            } else {
                req.setAttribute("error", "Cập nhật chứng chỉ thất bại!");
                doGet(req, resp);
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Dữ liệu không hợp lệ!");
            doGet(req, resp);
        } catch (ServletException | IOException e) {
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
