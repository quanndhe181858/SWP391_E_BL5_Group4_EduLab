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
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Color;
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
        if (certificateId == null || certificateId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/trainee/certificates");
            return;
        }

        try {
            int certId = Integer.parseInt(certificateId);
            UserCertificate certificate = certificateDAO.getUserCertificateById(certId, user.getId());

            if (certificate == null) {
                response.sendRedirect(request.getContextPath() + "/trainee/certificates");
                return;
            }

            generateCertificatePDF(response, certificate, user);

        } catch (NumberFormatException e) {
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

        // Fonts
        Font titleFont = new Font(Font.TIMES_ROMAN, 24, Font.BOLD);
        Font subTitleFont = new Font(Font.TIMES_ROMAN, 16, Font.ITALIC);
        Font nameFont = new Font(Font.TIMES_ROMAN, 20, Font.BOLD);
        Font normalFont = new Font(Font.TIMES_ROMAN, 14);
        Font smallFont = new Font(Font.TIMES_ROMAN, 12);

        // Outer border
        PdfPTable outer = new PdfPTable(1);
        outer.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBorderWidth(6);
        cell.setBorderColor(new Color(37, 99, 235)); // blue-600
        cell.setPadding(30);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);

        // Title
        Paragraph p = new Paragraph("CHỨNG CHỈ HOÀN THÀNH\n", titleFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        p = new Paragraph("Certificate of Completion\n\n", subTitleFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        // Body
        p = new Paragraph("Chứng nhận rằng\n\n", normalFont);
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        p = new Paragraph(
                user.getFirst_name() + " " + user.getLast_name() + "\n\n",
                nameFont
        );
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        p = new Paragraph(
                "Đã hoàn thành xuất sắc chương trình đào tạo\n"
                + "và được cấp chứng chỉ này để ghi nhận\n"
                + "sự nỗ lực và thành tích đạt được.\n\n",
                normalFont
        );
        p.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(p);

        // Details box
        PdfPTable info = new PdfPTable(2);
        info.setWidthPercentage(70);
        info.setSpacingBefore(20);

        info.addCell(createLabelCell("Mã chứng chỉ:"));
        info.addCell(createValueCell(cert.getCertificateCode()));

        info.addCell(createLabelCell("Ngày cấp:"));
        info.addCell(createValueCell(cert.getIssuedAt().toString()));

        cell.addElement(info);

        // Signature
        p = new Paragraph("\n\nGiám đốc\n\n", smallFont);
        p.setAlignment(Element.ALIGN_RIGHT);
        cell.addElement(p);

        outer.addCell(cell);
        document.add(outer);

        document.close();
    }

    private PdfPCell createLabelCell(String text) {
        PdfPCell c = new PdfPCell(new Phrase(text));
        c.setBorder(Rectangle.NO_BORDER);
        c.setHorizontalAlignment(Element.ALIGN_LEFT);
        return c;
    }

    private PdfPCell createValueCell(String text) {
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
