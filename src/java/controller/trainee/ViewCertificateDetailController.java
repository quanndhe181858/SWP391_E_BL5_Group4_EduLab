package controller.trainee;

import dao.CertificateDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.UserCertificate;

@WebServlet(name = "ViewCertificateDetailController", urlPatterns = {"/trainee/certificate/view"})
public class ViewCertificateDetailController extends HttpServlet {

    private final CertificateDAO certificateDAO = new CertificateDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewCertificateDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewCertificateDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String certificateId = request.getParameter("id");
        String courseIdParam = request.getParameter("courseId");

        UserCertificate certificate = null;

        try {
            if (certificateId != null && !certificateId.isEmpty()) {
                int certId = Integer.parseInt(certificateId);
                certificate = certificateDAO.getUserCertificateById(certId, user.getId());
            } 
            else if (courseIdParam != null && !courseIdParam.isEmpty()) {
                int courseId = Integer.parseInt(courseIdParam);
                certificate = certificateDAO.getUserCertificateByCourseId(courseId, user.getId());
            } 
            else {
                response.sendRedirect(request.getContextPath() + "/trainee/certificates");
                return;
            }

            if (certificate == null) {
                request.setAttribute("error", "Không tìm thấy chứng chỉ hoặc bạn chưa hoàn thành khóa học này.");
                request.getRequestDispatcher("/View/Trainee/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("certificate", certificate);
            request.getRequestDispatcher("/View/Trainee/ViewCertificateDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/trainee/certificates");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "View Certificate Detail Controller - Displays certificate details";
    }
}
