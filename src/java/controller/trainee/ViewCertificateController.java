/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.trainee;

/**
 *
 * @author vomin
 */
import dao.certificateDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Certificate;
import model.User;

@WebServlet("/trainee/view-certificate")
public class ViewCertificateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // FINAL EXAM certificate → truyền testId
        String testIdRaw = request.getParameter("testId");
        if (testIdRaw == null) {
            request.setAttribute("error", "Invalid certificate request.");
            request.getRequestDispatcher("/View/Error/error.jsp").forward(request, response);
            return;
        }

        int testId = Integer.parseInt(testIdRaw);

        certificateDAO dao = new certificateDAO();
        Certificate cert = dao.getCertificate(user.getId(), testId);

        if (cert == null) {
            request.setAttribute("error", "You have not earned this certificate yet.");
            request.getRequestDispatcher("/View/Error/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("cert", cert);
        request.getRequestDispatcher("/View/Trainee/certificate.jsp")
               .forward(request, response);
    }
}
