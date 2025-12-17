/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import dao.CertificateDAO;
import dtos.CertificateDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.User;

@WebServlet(name = "InstructorManagerCertificate", urlPatterns = {"/instructor/manager/certificate"})
public class InstructorManagerCertificate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InstructorManagerCertificate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InstructorManagerCertificate at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private final CertificateDAO certificateDAO = new CertificateDAO();
    private static final int RECORDS_PER_PAGE = 2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        if (u.getRole_id() != 2) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        int instructorId = u.getId();

        String search = request.getParameter("search");
        String categoryIdStr = request.getParameter("category");
        String status = request.getParameter("status");
        String sortBy = request.getParameter("sort");
        String sortOrder = request.getParameter("order");
        String pageStr = request.getParameter("page");

        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
            }
        }

        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "created";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "desc";
        }

        int offset = (currentPage - 1) * RECORDS_PER_PAGE;

        List<CertificateDTO> certificates = certificateDAO.getInstructorCertificates(
                instructorId, search, categoryId, status, sortBy, sortOrder, offset, RECORDS_PER_PAGE);

        int totalRecords = certificateDAO.countInstructorCertificates(instructorId, search, categoryId, status);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        List<Map<String, Object>> categories = certificateDAO.getCategoriesForInstructor(instructorId);

        request.setAttribute("certificates", certificates);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("search", search);
        request.setAttribute("selectedCategory", categoryId);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("/View/Instructor/ManagerCertificate.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
