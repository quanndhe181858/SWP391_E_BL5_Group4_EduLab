/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import dao.MediaDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Media;
import model.User;

/**
 *
 * @author hao
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
    
    static final MediaDAO mediaDao = new MediaDAO();
    
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
        
    }
    
}
