/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.trainee;

/**
 *
 * @author vomin
 */
import dao.CertificateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Certificate;
import model.User;
import model.UserCertificate;

@WebServlet("/trainee/certificates")
public class ViewCertificateController extends HttpServlet {

    private final CertificateDAO certificateDAO = new CertificateDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<UserCertificate> certificates
                = certificateDAO.getUserCertificates(user.getId());

        request.setAttribute("certificates", certificates);

        request.getRequestDispatcher("/View/Trainee/Certificate.jsp")
                .forward(request, response);
    }
}
