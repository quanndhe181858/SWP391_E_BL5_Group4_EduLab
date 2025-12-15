/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import dao.CertificateDAO;
import dao.TestAttemptDAOv2;
import dao.TestsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Color;
import model.Test;
import model.TestAttempt;
import model.User;
import model.UserCertificate;

@WebServlet(name = "DownloadCertificateController", urlPatterns = {"/trainee/certificate/download"})
public class DownloadCertificateController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DownloadCertificateController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DownloadCertificateController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
            // === LẤY CERTIFICATE GIỐNG ViewCertificateDetailController ===
            if (certificateId != null && !certificateId.isBlank()) {
                int certId = Integer.parseInt(certificateId);
                certificate = certificateDAO.getUserCertificateById(certId, user.getId());
            } else if (courseIdParam != null && !courseIdParam.isBlank()) {
                int courseId = Integer.parseInt(courseIdParam);
                certificate = certificateDAO.getUserCertificateByCourseId(courseId, user.getId());
            } else {
                response.sendRedirect(request.getContextPath() + "/trainee/certificates");
                return;
            }

            if (certificate == null) {
                response.sendRedirect(request.getContextPath() + "/trainee/certificates");
                return;
            }

            // === LẤY ĐIỂM FINAL TEST (Y CHANG VIEW) ===
            int courseId = certificate.getCourseId();
            Test finalTest = testsDAO.getCourseTestByCourseId(courseId);

            if (finalTest != null) {
                TestAttempt attempt
                        = testAttemptDAO.getAttemptByUserAndTest(user.getId(), finalTest.getId());

                if (attempt != null && attempt.getGrade() != null) {
                    certificate.setPassedGrade(attempt.getGrade());
                }
            }

            // === GEN PDF ===
            generateCertificatePDF(response, certificate, user);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/trainee/certificates");
        }
    }

    private void generateCertificatePDF(HttpServletResponse response,
            UserCertificate cert,
            User user) throws IOException {

        response.setContentType("application/pdf");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=certificate-" + cert.getCertificateCode() + ".pdf"
        );

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        Font titleFont = new Font(Font.TIMES_ROMAN, 26, Font.BOLD);
        Font subTitleFont = new Font(Font.TIMES_ROMAN, 16, Font.ITALIC);
        Font nameFont = new Font(Font.TIMES_ROMAN, 22, Font.BOLD);
        Font normalFont = new Font(Font.TIMES_ROMAN, 14);
        Font boldFont = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);

        PdfPTable outer = new PdfPTable(1);
        outer.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBorderWidth(6);
        cell.setBorderColor(new Color(251, 191, 36)); // amber
        cell.setPadding(30);

        // TITLE
        Paragraph p = new Paragraph("CHỨNG CHỈ HOÀN THÀNH\n", titleFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        p = new Paragraph("Certificate of Completion\n\n", subTitleFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        // USER
        p = new Paragraph("Chứng nhận rằng\n\n", normalFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        p = new Paragraph(
                cert.getFirstName() + " " + cert.getLastName() + "\n\n",
                nameFont
        );
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        // COURSE
        p = new Paragraph("Đã hoàn thành xuất sắc khóa học\n\n", normalFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        p = new Paragraph(cert.getCourseTitle() + "\n\n", boldFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        if (cert.getCourseDescription() != null) {
            p = new Paragraph(cert.getCourseDescription() + "\n\n", normalFont);
            p.setAlignment(Element.ALIGN_CENTER);
            cell.addElement(p);
        }

        // INFO TABLE
        PdfPTable info = new PdfPTable(2);
        info.setWidthPercentage(80);
        info.setSpacingBefore(20);

        info.addCell(label("Mã chứng chỉ"));
        info.addCell(value(cert.getCertificateCode()));

        info.addCell(label("Ngày cấp"));
        info.addCell(value(cert.getIssuedAt().toString()));

        info.addCell(label("Email"));
        info.addCell(value(cert.getEmail()));

        if (cert.getPassedGrade() != null) {
            info.addCell(label("Điểm đạt"));
            info.addCell(value(cert.getPassedGrade() + " / 100"));
        }

        cell.addElement(info);

        // SIGN
        p = new Paragraph("\n\nGiám đốc điều hành\nLearning Management System",
                normalFont);
        p.setAlignment(Element.ALIGN_RIGHT);
        cell.addElement(p);

        outer.addCell(cell);
        document.add(outer);
        document.close();
    }

    private PdfPCell label(String text) {
        PdfPCell c = new PdfPCell(new Phrase(text));
        c.setBorder(Rectangle.NO_BORDER);
        c.setHorizontalAlignment(Element.ALIGN_LEFT);
        return c;
    }

    private PdfPCell value(String text) {
        PdfPCell c = new PdfPCell(new Phrase(text, new Font(Font.TIMES_ROMAN, 12, Font.BOLD)));
        c.setBorder(Rectangle.NO_BORDER);
        c.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return c;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
