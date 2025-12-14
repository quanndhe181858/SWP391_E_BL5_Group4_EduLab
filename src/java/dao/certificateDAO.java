/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author vomin
 */
import database.dao;
import dtos.AccomplishmentDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import model.Certificate;
import model.UserCertificate;

public class CertificateDAO extends dao {

    public Certificate getCertificateByCourseId(int courseId) {
        String sql = """
            SELECT * FROM certificate
            WHERE course_id = ? AND status = 'Active'
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Certificate c = new Certificate();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setCourseId(rs.getInt("course_id"));
                c.setCategoryId(rs.getObject("category_id", Integer.class));
                c.setDescription(rs.getString("description"));
                c.setCodePrefix(rs.getString("code_prefix"));
                c.setStatus(rs.getString("status"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                return c;
            }

        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return null;
    }

    public boolean hasUserCertificate(int userId, int courseId) {
        String sql = """
            SELECT 1
            FROM user_certificate uc
            JOIN certificate c ON uc.certificate_id = c.id
            WHERE uc.user_id = ? AND c.course_id = ?
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            return false;
        } finally {
            closeResources();
        }
    }

    public boolean issueCertificate(int userId, int courseId, String filePath) {

        Certificate cert = getCertificateByCourseId(courseId);
        if (cert == null) {
            return false;
        }

        if (hasUserCertificate(userId, courseId)) {
            return true;
        }

        String certificateCode = cert.getCodePrefix() + "-"
                + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        String sql = """
            INSERT INTO user_certificate
                (user_id, certificate_id, certificate_code, issued_at, file_path)
            VALUES (?, ?, ?, NOW(), ?)
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, cert.getId());
            ps.setString(3, certificateCode);
            ps.setString(4, filePath);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            return false;
        } finally {
            closeResources();
        }
    }

    public List<UserCertificate> getUserCertificates(int userId) {
        List<UserCertificate> list = new ArrayList<>();

        String sql = """
            SELECT uc.*
            FROM user_certificate uc
            WHERE uc.user_id = ?
            ORDER BY uc.issued_at DESC
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                UserCertificate uc = new UserCertificate();
                uc.setId(rs.getInt("id"));
                uc.setUserId(rs.getInt("user_id"));
                uc.setCertificateId(rs.getInt("certificate_id"));
                uc.setCertificateCode(rs.getString("certificate_code"));
                uc.setIssuedAt(rs.getTimestamp("issued_at"));
                uc.setFilePath(rs.getString("file_path"));
                list.add(uc);
            }

        } catch (SQLException e) {
        } finally {
            closeResources();
        }

        return list;
    }

    public UserCertificate getUserCertificateById(int certId, int userId) {
        String sql = "SELECT uc.id, uc.user_id, uc.certificate_id, uc.certificate_code, "
                + "uc.issued_at, uc.file_path, "
                + "DATE_FORMAT(uc.issued_at, '%d/%m/%Y') as issued_at_formatted "
                + "FROM user_certificate uc "
                + "WHERE uc.id = ? AND uc.user_id = ?";

        System.out.println("Getting certificate - ID: " + certId + ", UserID: " + userId);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, certId);
            ps.setInt(2, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                UserCertificate uc = new UserCertificate();
                uc.setId(rs.getInt("id"));
                uc.setUserId(rs.getInt("user_id"));
                uc.setCertificateId(rs.getInt("certificate_id"));
                uc.setCertificateCode(rs.getString("certificate_code"));
                uc.setIssuedAt(rs.getTimestamp("issued_at"));
                uc.setFilePath(rs.getString("file_path"));

                System.out.println("Certificate found: " + uc.getCertificateCode());
                return uc;
            } else {
                System.out.println("No certificate found in database");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    public List<AccomplishmentDTO> getUserAccomplishments(int userId) {

        List<AccomplishmentDTO> list = new ArrayList<>();

        String sql = """
        SELECT
            c.id AS course_id,
            c.title AS course_title,
            MAX(cp.completed_at) AS completed_at,
            e.status AS course_status,
            MAX(
                CASE
                    WHEN ta.status = 'Passed' THEN ta.grade
                    ELSE NULL
                END
            ) AS passed_grade

        FROM enrollment e
        JOIN course c
            ON c.id = e.course_id

        LEFT JOIN course_progress cp
            ON cp.course_id = c.id
           AND cp.user_id = e.user_id
           AND cp.status = 'Completed'

        LEFT JOIN test_attempt ta
            ON ta.user_id = e.user_id
           AND ta.test_id IN (
                SELECT t.id
                FROM test t
                WHERE t.course_id = c.id
           )

        WHERE e.user_id = ?
          AND e.status = 'Completed'

        GROUP BY c.id, c.title, e.status
        ORDER BY completed_at DESC
    """;

        try (Connection con = dbc.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AccomplishmentDTO dto = new AccomplishmentDTO();

                dto.setCourseId(rs.getInt("course_id"));
                dto.setCourseTitle(rs.getString("course_title"));
                dto.setCompletedAt(rs.getTimestamp("completed_at"));
                dto.setCourseStatus(rs.getString("course_status"));

                Float passedGrade = rs.getObject("passed_grade", Float.class);
                dto.setPassedGrade(passedGrade);

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
