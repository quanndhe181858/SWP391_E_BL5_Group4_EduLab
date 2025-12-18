/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.util.List;
import model.Certificate;
import model.Course;
import model.User;

/**
 *
 * @author hao
 */
@WebServlet(name = "InstructorCertificatesController", urlPatterns = {"/instructor/certificate"})
public class InstructorCertificatesController extends HttpServlet {
    
    private final CourseDAO cDao = new CourseDAO();
    private final CertificateDAO certDao = new CertificateDAO();
    
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
        
        List<Course> cList = cDao.getCourseNotHaveCert(u.getId());
        
        req.setAttribute("courseList", cList);
        req.getRequestDispatcher("../View/Instructor/AddCertificate.jsp").forward(req, resp);
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
        
        String title = req.getParameter("title");
        String cidStr = req.getParameter("course_id");
        String des = req.getParameter("description");
        String codePrefix = req.getParameter("code_prefix");
        String status = req.getParameter("status");
        
        if (title == null || title.isBlank()
                || cidStr == null || cidStr.isBlank()
                || codePrefix == null || codePrefix.isBlank()
                || status == null || status.isBlank()) {
            req.setAttribute("error", "Thiếu thông tin!");
            req.getRequestDispatcher("../View/Instructor/AddCertificate.jsp").forward(req, resp);
            return;
        }
        
        int cid;
        
        try {
            cid = Integer.parseInt(cidStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Mã khoá học phải là số nguyên!");
            req.getRequestDispatcher("../View/Instructor/AddCertificate.jsp").forward(req, resp);
            return;
        }
        
        Course c = cDao.getCourseById(cid);
        
        Certificate cert = new Certificate();
        cert.setTitle(title);
        cert.setCourseId(cid);
        cert.setCodePrefix(codePrefix);
        cert.setDescription(des);
        cert.setStatus(status);
        cert.setCategoryId(c.getCategory_id());
        cert.setCreatedBy(u.getId());
        
        cert = certDao.createCert(cert);
        
        List<Course> cList = cDao.getCourseNotHaveCert(u.getId());
        
        if (cert == null) {
            req.setAttribute("error", "Tạo chứng chỉ thất bại, vui lòng thử lại sau!");
            req.setAttribute("courseList", cList);
            req.getRequestDispatcher("../View/Instructor/AddCertificate.jsp").forward(req, resp);
        } else {
            req.setAttribute("success", "Tạo chứng chỉ thành công!");
            req.setAttribute("courseList", cList);
            req.getRequestDispatcher("../View/Instructor/AddCertificate.jsp").forward(req, resp);
        }
        
    }
    
}
