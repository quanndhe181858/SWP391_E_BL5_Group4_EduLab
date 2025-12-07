/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import constant.httpStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;
import model.Role;
import model.User;

/**
 *
 * @author quan
 */
public class AuthUtils {

    public static User doAuthorize(HttpServletRequest req, HttpServletResponse resp, int roleAccepted)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return null;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return null;
        }

        if (u.getRole_id() != roleAccepted) {
            resp.sendError(httpStatus.FORBIDDEN.getCode(), httpStatus.FORBIDDEN.getMessage());
            return null;
        }

        return u;
    }

    public static User createAndSetDummyUser(HttpServletRequest request, HttpServletResponse response) {

        User u = new User();
        u.setId(1);
        u.setUuid(UUID.randomUUID().toString());
        u.setFirst_name("John");
        u.setLast_name("Doe");
        u.setEmail("john.doe@example.com");
        u.setHash_password("dummy_hash");  // just a placeholder
        u.setBod(java.sql.Date.valueOf("1992-05-10"));
        u.setStatus("active");

        // Role
        Role r = new Role();
        r.setId(2);
        r.setName("Instructor");
        u.setRole_id(2);
        u.setRole(r);

        // timestamps
        Timestamp now = new Timestamp(System.currentTimeMillis());
        u.setCreated_at(now);
        u.setUpdated_at(now);

        // store into session
        HttpSession session = request.getSession();
        session.setAttribute("user", u);

        return u;
    }
}
