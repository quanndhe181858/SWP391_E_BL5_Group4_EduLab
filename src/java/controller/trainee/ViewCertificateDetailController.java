package controller.trainee;

import dao.CertificateDAO;
import dao.TestAttemptDAOv2;
import dao.TestsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Test;
import model.TestAttempt;
import model.User;
import model.UserCertificate;

@WebServlet(name = "ViewCertificateDetailController", urlPatterns = {"/trainee/certificate/view"})
public class ViewCertificateDetailController extends HttpServlet {

    private final CertificateDAO certificateDAO = new CertificateDAO();
    private final TestsDAO testsDAO = new TestsDAO();
    private final TestAttemptDAOv2 testAttemptDAO = new TestAttemptDAOv2();

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
            } else if (courseIdParam != null && !courseIdParam.isEmpty()) {
                int courseId = Integer.parseInt(courseIdParam);
                certificate = certificateDAO.getUserCertificateByCourseId(courseId, user.getId());
            } else {
                response.sendRedirect(request.getContextPath() + "/trainee/certificates");
                return;
            }

            if (certificate == null) {
                request.setAttribute("error", "Không tìm thấy chứng chỉ hoặc bạn chưa hoàn thành khóa học này.");
                request.getRequestDispatcher("/View/Trainee/error.jsp").forward(request, response);
                return;
            }

            int courseId = certificate.getCourseId();
            Test finalTest = testsDAO.getCourseTestByCourseId(courseId);

            if (finalTest != null) {
                TestAttempt attempt = testAttemptDAO.getAttemptByUserAndTest(user.getId(), finalTest.getId());

                if (attempt != null && attempt.getGrade() != null) {
                    // Set điểm vào certificate để hiển thị
                    certificate.setPassedGrade(attempt.getGrade());
                    System.out.println("Final test grade found: " + attempt.getGrade());
                } else {
                    System.out.println("No final test attempt found or grade is null");
                }
            } else {
                System.out.println("No final test found for course " + courseId);
            }

            request.setAttribute("certificate", certificate);
            request.getRequestDispatcher("/View/Trainee/ViewCertificateDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("Invalid certificate/course ID format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/trainee/certificates");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "View Certificate Detail Controller - Displays certificate with course details and grade";
    }
}
