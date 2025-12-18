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
import dtos.CertificateDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
            cert = createDefaultCertificateForCourse(courseId);
            if (cert == null) {
                return false;
            }
        }

        if (hasUserCertificate(userId, courseId)) {
            return true;
        }

        String prefix = cert.getCodePrefix();
        if (prefix == null || prefix.isBlank()) {
            prefix = "COURSE-" + courseId;
        }

        String certificateCode = prefix + "-"
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
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    public List<UserCertificate> getUserCertificates(int userId) {
        List<UserCertificate> list = new ArrayList<>();

        String sql = """
        SELECT 
            uc.id,
            uc.user_id,
            uc.certificate_id,
            uc.certificate_code,
            uc.issued_at,
            uc.file_path,

            c.course_id,
            c.title AS certificate_title,

            co.title AS course_title,
            co.description AS course_description,

            u.first_name,
            u.last_name,
            u.email,

            MAX(
                CASE 
                    WHEN ta.status = 'Passed' THEN ta.grade
                    ELSE NULL
                END
            ) AS passed_grade

        FROM user_certificate uc
        INNER JOIN certificate c ON uc.certificate_id = c.id
        INNER JOIN course co ON c.course_id = co.id
        INNER JOIN user u ON uc.user_id = u.id

        LEFT JOIN test t ON t.course_id = co.id
        LEFT JOIN test_attempt ta 
            ON ta.test_id = t.id 
           AND ta.user_id = uc.user_id

        WHERE uc.user_id = ?

        GROUP BY 
            uc.id, uc.user_id, uc.certificate_id, uc.certificate_code,
            uc.issued_at, uc.file_path,
            c.course_id, c.title,
            co.title, co.description,
            u.first_name, u.last_name, u.email

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

                uc.setCourseId(rs.getInt("course_id"));
                uc.setCourseTitle(rs.getString("course_title"));
                uc.setCourseDescription(rs.getString("course_description"));

                uc.setFirstName(rs.getString("first_name"));
                uc.setLastName(rs.getString("last_name"));
                uc.setEmail(rs.getString("email"));

                uc.setPassedGrade(rs.getObject("passed_grade", Float.class));

                list.add(uc);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

    public UserCertificate getUserCertificateById(int certId, int userId) {

        String sql = """
        SELECT 
            uc.id,
            uc.user_id,
            uc.certificate_id,
            uc.certificate_code,
            uc.issued_at,
            uc.file_path,

            c.course_id,
            c.title AS certificate_title,

            co.title AS course_title,
            co.description AS course_description,

            u.first_name,
            u.last_name,
            u.email,

            DATE_FORMAT(uc.issued_at, '%d/%m/%Y') AS issued_at_formatted
        FROM user_certificate uc
        INNER JOIN certificate c ON uc.certificate_id = c.id
        INNER JOIN course co ON c.course_id = co.id
        INNER JOIN user u ON uc.user_id = u.id
        WHERE uc.id = ? AND uc.user_id = ?
    """;

        System.out.println("Getting certificate - ID: " + certId + ", UserID: " + userId);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, certId);
            ps.setInt(2, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                UserCertificate cert = new UserCertificate();

                cert.setId(rs.getInt("id"));
                cert.setUserId(rs.getInt("user_id"));
                cert.setCertificateId(rs.getInt("certificate_id"));
                cert.setCertificateCode(rs.getString("certificate_code"));
                cert.setIssuedAt(rs.getTimestamp("issued_at"));
                cert.setFilePath(rs.getString("file_path"));

                cert.setCourseId(rs.getInt("course_id"));
                cert.setCourseTitle(rs.getString("course_title"));
                cert.setCourseDescription(rs.getString("course_description"));

                cert.setFirstName(rs.getString("first_name"));
                cert.setLastName(rs.getString("last_name"));
                cert.setEmail(rs.getString("email"));

                System.out.println("Certificate found: " + cert.getCertificateCode());
                return cert;
            }

            System.out.println("No certificate found in database");

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

    public UserCertificate getUserCertificateByCourseId(int courseId, int userId) {
        String sql = """
        SELECT 
            uc.id,
            uc.user_id,
            uc.certificate_id,
            uc.certificate_code,
            uc.issued_at,
            uc.file_path,
            c.title as certificate_title,
            c.course_id,
            co.title as course_title,
            co.description as course_description,
            DATE_FORMAT(uc.issued_at, '%d/%m/%Y') as issued_at_formatted,
            u.first_name,
            u.last_name,
            u.email
        FROM user_certificate uc
        INNER JOIN certificate c ON uc.certificate_id = c.id
        INNER JOIN course co ON c.course_id = co.id
        INNER JOIN user u ON uc.user_id = u.id
        WHERE c.course_id = ? AND uc.user_id = ?
        ORDER BY uc.issued_at DESC
        LIMIT 1
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, courseId);
            ps.setInt(2, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                UserCertificate cert = new UserCertificate();
                cert.setId(rs.getInt("id"));
                cert.setUserId(rs.getInt("user_id"));
                cert.setCertificateId(rs.getInt("certificate_id"));
                cert.setCertificateCode(rs.getString("certificate_code"));
                cert.setIssuedAt(rs.getTimestamp("issued_at"));
                cert.setFilePath(rs.getString("file_path"));

                cert.setCourseId(rs.getInt("course_id"));
                cert.setCourseTitle(rs.getString("course_title"));
                cert.setCourseDescription(rs.getString("course_description"));
                cert.setFirstName(rs.getString("first_name"));
                cert.setLastName(rs.getString("last_name"));
                cert.setEmail(rs.getString("email"));

                System.out.println("Certificate found for course " + courseId + ": " + cert.getCertificateCode());
                return cert;
            } else {
                System.out.println("No certificate found for userId=" + userId + ", courseId=" + courseId);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getUserCertificateByCourseId: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    public Certificate createDefaultCertificateForCourse(int courseId) {
        String sql = """
        INSERT INTO certificate
            (title, course_id, description, code_prefix, status, created_at)
        VALUES
            (?, ?, ?, ?, 'Active', NOW())
    """;

        String title = "Certificate of Completion";
        String description = "Auto-generated certificate";
        String codePrefix = "COURSE-" + courseId;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, title);
            ps.setInt(2, courseId);
            ps.setString(3, description);
            ps.setString(4, codePrefix);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                Certificate c = new Certificate();
                c.setId(rs.getInt(1));
                c.setTitle(title);
                c.setCourseId(courseId);
                c.setDescription(description);
                c.setCodePrefix(codePrefix);
                c.setStatus("Active");
                return c;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    public int countInstructorCertificates(int instructorId, String search, Integer categoryId, String status) {
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(DISTINCT c.id)
        FROM certificate c
        INNER JOIN course co ON c.course_id = co.id
        WHERE c.created_by = ?
    """);

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (\n"
                    + "    LOWER(c.title) LIKE ?\n"
                    + " OR LOWER(c.description) LIKE ?\n"
                    + " OR LOWER(co.title) LIKE ?\n"
                    + ")");
        }

        if (categoryId != null) {
            sql.append(" AND c.category_id = ?");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND c.status = ?");
        }

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int paramIndex = 1;
            ps.setInt(paramIndex++, instructorId);

            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim().toLowerCase() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            if (categoryId != null) {
                ps.setInt(paramIndex++, categoryId);
            }

            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    public List<CertificateDTO> getInstructorCertificates(int instructorId, String search,
            Integer categoryId, String status, String sortBy, String sortOrder, int offset, int limit) {

        List<CertificateDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT c.id, c.title, c.course_id, c.category_id, c.description, 
               c.code_prefix, c.status, c.created_at,
               co.title AS course_title,
               cat.name AS category_name,
               COUNT(DISTINCT uc.id) AS issued_count
        FROM certificate c
        INNER JOIN course co ON c.course_id = co.id
        LEFT JOIN category cat ON c.category_id = cat.id
        LEFT JOIN user_certificate uc ON uc.certificate_id = c.id
        WHERE c.created_by = ?
    """);

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (c.title LIKE ? OR c.description LIKE ? OR co.title LIKE ?)");
        }

        if (categoryId != null) {
            sql.append(" AND c.category_id = ?");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND c.status = ?");
        }

        sql.append(" GROUP BY c.id, c.title, c.course_id, c.category_id, c.description, ");
        sql.append("c.code_prefix, c.status, c.created_at, co.title, cat.name");

        // Sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append(" ORDER BY ");
            switch (sortBy) {
                case "title":
                    sql.append("c.title");
                    break;
                case "course":
                    sql.append("co.title");
                    break;
                case "category":
                    sql.append("cat.name");
                    break;
                case "issued":
                    sql.append("issued_count");
                    break;
                case "created":
                    sql.append("c.created_at");
                    break;
                default:
                    sql.append("c.created_at");
            }
            sql.append(" ").append(sortOrder != null && sortOrder.equalsIgnoreCase("asc") ? "ASC" : "DESC");
        } else {
            sql.append(" ORDER BY c.created_at DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int paramIndex = 1;
            ps.setInt(paramIndex++, instructorId);

            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.trim() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            if (categoryId != null) {
                ps.setInt(paramIndex++, categoryId);
            }

            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ps.setInt(paramIndex++, limit);
            ps.setInt(paramIndex++, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                CertificateDTO dto = new CertificateDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitle(rs.getString("title"));
                dto.setCourseId(rs.getInt("course_id"));
                dto.setCourseTitle(rs.getString("course_title"));
                dto.setCategoryId(rs.getObject("category_id", Integer.class));
                dto.setCategoryName(rs.getString("category_name"));
                dto.setDescription(rs.getString("description"));
                dto.setCodePrefix(rs.getString("code_prefix"));
                dto.setStatus(rs.getString("status"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                dto.setIssuedCount(rs.getInt("issued_count"));

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

    public List<Map<String, Object>> getCategoriesForInstructor(int instructorId) {
        List<Map<String, Object>> categories = new ArrayList<>();

        String sql = """
        SELECT DISTINCT cat.id, cat.name, COUNT(c.id) as cert_count
        FROM category cat
        INNER JOIN certificate c ON c.category_id = cat.id
        INNER JOIN course co ON c.course_id = co.id
        WHERE c.created_by  = ?
        GROUP BY cat.id, cat.name
        ORDER BY cat.name
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, instructorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> cat = new HashMap<>();
                cat.put("id", rs.getInt("id"));
                cat.put("name", rs.getString("name"));
                cat.put("count", rs.getInt("cert_count"));
                categories.add(cat);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return categories;
    }

    public Certificate createCert(Certificate cert) {
        String sql = """
                        INSERT INTO certificate
                            (title, course_id, description, code_prefix, status, created_at, created_by, category_id)
                        VALUES
                            (?, ?, ?, ?, ?, NOW(), ?, ?)
                    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, cert.getTitle());
            ps.setInt(2, cert.getCourseId());
            ps.setString(3, cert.getDescription());
            ps.setString(4, cert.getCodePrefix());
            ps.setString(5, cert.getStatus());
            ps.setInt(6, cert.getCreatedBy());
            ps.setInt(7, cert.getCategoryId());

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                Certificate c = new Certificate();
                c.setId(rs.getInt(1));
                c.setTitle(cert.getTitle());
                c.setCourseId(cert.getCourseId());
                c.setDescription(cert.getDescription());
                c.setCodePrefix(cert.getCodePrefix());
                c.setStatus(cert.getStatus());
                return c;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    public Certificate getCertificateById(int id) {
        String sql = """
            SELECT * FROM certificate
            WHERE id = ?;
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
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

    public boolean updateCertificate(Certificate cert) {
        String sql = """
                     UPDATE certificate
                     SET
                     title = ?,
                     description = ?,
                     status = ?
                     WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, cert.getTitle());
            ps.setString(2, cert.getDescription());
            ps.setString(3, cert.getStatus());
            ps.setInt(4, cert.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

}
