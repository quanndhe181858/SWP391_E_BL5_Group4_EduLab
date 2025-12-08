package dao; // Thay đổi package nếu cần

import DTO.TestDetailDTO;
import database.dao;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestDAO extends dao {
    public List<TestDetailDTO> getAllTests(int instructorId, String searchTitle, String category) throws SQLException {
        List<TestDetailDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ");
        sql.append("t.id, t.title, ");
        sql.append("c.title AS course_title, ");
        sql.append("CONCAT(u.first_name, ' ', u.last_name) AS instructor_name, ");
        sql.append("cat.name AS category_name, ");
        sql.append("t.created_at ");
        sql.append("FROM test t ");
        sql.append("JOIN course c ON t.course_id = c.id ");
        sql.append("JOIN user u ON t.created_by = u.id ");
        sql.append("JOIN category cat ON c.category_id = cat.id ");
        sql.append("WHERE 1 = 1 ");

        // filter instructor
        if (instructorId > 0) {
            sql.append("AND t.created_by = ? ");
        }
        if (searchTitle != null && !searchTitle.trim().isEmpty()) {
            sql.append("AND t.title LIKE ? ");
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append("AND cat.name = ? ");
        }

        sql.append("ORDER BY t.created_at DESC");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int idx = 1;

            if (instructorId > 0) {
                ps.setInt(idx++, instructorId);
            }
            if (searchTitle != null && !searchTitle.trim().isEmpty()) {
                ps.setString(idx++, "%" + searchTitle + "%");
            }
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(idx++, category);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                TestDetailDTO dto = new TestDetailDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitle(rs.getString("title"));
                dto.setCourseName(rs.getString("course_title"));
                dto.setInstructorName(rs.getString("instructor_name"));
                dto.setCategoryName(rs.getString("category_name"));
                dto.setDateCreated(rs.getTimestamp("created_at"));

                list.add(dto);
            }
        } finally {
            closeResources();
        }
        return list;
    }
      public static void main(String[] args) {
        TestDAO dao = new TestDAO();

        int instructorId = 2;             // ID instructor muốn test
        String searchTitle = null;        // hoặc thử: "Java"
        String categoryName = null;       // hoặc thử: "Backend"

        try {
            System.out.println("===== TEST getListTestDetail() =====");
            List<TestDetailDTO> list = dao.getAllTests(instructorId, searchTitle, categoryName);

            if (list == null || list.isEmpty()) {
                System.out.println("⚠ Không có test nào với instructor_id = " + instructorId);
            } else {
                System.out.println("✅ Tìm thấy " + list.size() + " bài Test:");
                System.out.println("----------------------------------");

                for (TestDetailDTO t : list) {
                    System.out.println("ID: " + t.getId());
                    System.out.println("Title: " + t.getTitle());
                    System.out.println("Course: " + t.getCourseName());
                    System.out.println("Instructor: " + t.getInstructorName());
                    System.out.println("Category: " + t.getCategoryName());
                    System.out.println("Created At: " + t.getDateCreated());
                    System.out.println("----------------------------------");
                }
            }

        } catch (SQLException e) {
            System.out.println("❌ Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
