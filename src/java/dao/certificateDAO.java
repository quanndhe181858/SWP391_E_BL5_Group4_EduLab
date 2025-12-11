/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author vomin
 */
import database.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Certificate;

public class certificateDAO extends DBContext {

    public Certificate getCertificate(int userId, int courseId) {

        String sql = """
        SELECT 
            u.full_name,
            c.title AS course_title,
            a.title AS accomplishment_title,
            ua.issued_at
        FROM user_accomplishment ua
        JOIN accomplishment a ON ua.accomplishment_id = a.id
        JOIN course c ON a.course_id = c.id
        JOIN user u ON ua.user_id = u.id
        WHERE ua.user_id = ?
          AND c.id = ?
    """;

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Certificate cert = new Certificate();
                cert.setUserName(rs.getString("full_name"));
                cert.setCourseTitle(rs.getString("course_title"));
                cert.setAccomplishmentTitle(rs.getString("accomplishment_title"));
                cert.setIssuedAt(rs.getString("issued_at"));
                return cert;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createCertificate(int userId, int courseId) {
        String sql = """
        INSERT INTO user_accomplishment (user_id, accomplishment_id, issued_at)
        SELECT ?, a.id, NOW()
        FROM accomplishment a
        WHERE a.course_id = ?
    """;

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
