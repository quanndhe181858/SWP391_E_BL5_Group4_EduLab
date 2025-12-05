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
            resp.sendError(httpStatus.UNAUTHORIZED.getCode(), httpStatus.UNAUTHORIZED.getMessage());
            return null;
        }

        User u = (User) session.getAttribute("user");

        if (u.getRole_id() != roleAccepted) {
            resp.sendError(httpStatus.FORBIDDEN.getCode(), httpStatus.FORBIDDEN.getMessage());
            return null;
        }

        return u;
    }
}
