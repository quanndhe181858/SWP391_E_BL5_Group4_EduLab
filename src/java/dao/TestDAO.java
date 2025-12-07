package dao; // Thay đổi package nếu cần

import DTO.TestDetailDTO;
import database.dao;
import model.Test;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class TestDAO extends dao {

    // Phương thức giả định tạo code duy nhất (TESTxxxx)
    private String generateUniqueCode() {
        return "T" + System.currentTimeMillis() % 100000;
    }

    /**
     * Lấy danh sách các bài Test chi tiết do một Instructor tạo, hỗ trợ tìm
     * kiếm/lọc.
     *
     * @param instructorId ID của người tạo (createdBy).
     * @param searchTitle Tiêu đề Test để tìm kiếm (có thể là null).
     * @param categoryName Tên danh mục để lọc (có thể là null).
     * @return List<TestDetailDTO>
     * @throws SQLException
     */
    public List<TestDetailDTO> getListTestDetail(int instructorId, String searchTitle, String categoryName) throws SQLException {
        List<TestDetailDTO> testList = new ArrayList<>();

        // Truy vấn phức tạp để lấy thông tin kết hợp từ 4 bảng
        // test, course, user, category
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT ");
        sqlBuilder.append("t.id, t.title, c.title AS course_title, CONCAT(u.first_name, ' ', u.last_name) AS instructor_name, cat.name AS category_name, t.created_at ");
        sqlBuilder.append("FROM test t ");
        sqlBuilder.append("JOIN course c ON t.course_id = c.id ");
        sqlBuilder.append("JOIN user u ON t.created_by = u.id ");
        sqlBuilder.append("JOIN category cat ON c.category_id = cat.id ");
        sqlBuilder.append("WHERE t.created_by = ?"); // Bắt buộc lọc theo Instructor

        // Thêm điều kiện tìm kiếm/lọc
        if (searchTitle != null && !searchTitle.trim().isEmpty()) {
            sqlBuilder.append(" AND t.title LIKE ?");
        }
        if (categoryName != null && !categoryName.trim().isEmpty()) {
            sqlBuilder.append(" AND cat.name = ?");
        }
        sqlBuilder.append(" ORDER BY t.created_at DESC");

        try {
            con = dbc.getConnection(); // Lấy Connection từ DBContext
            ps = con.prepareStatement(sqlBuilder.toString());

            int paramIndex = 1;
            ps.setInt(paramIndex++, instructorId);

            if (searchTitle != null && !searchTitle.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchTitle + "%");
            }
            if (categoryName != null && !categoryName.trim().isEmpty()) {
                ps.setString(paramIndex++, categoryName);
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
                testList.add(dto);
            }
        } finally {
            closeResources(); // Đóng tài nguyên thông qua lớp cơ sở
        }
        return testList;
    }

    /**
     * Tạo Test mới và liên kết các Quiz đã chọn.
     *
     * @param test Đối tượng Test (chứa thông tin chính).
     * @param quizIds Danh sách ID của các Quiz được chọn (hoặc random).
     * @return ID của Test vừa được tạo, hoặc -1 nếu thất bại.
     * @throws SQLException
     */
    public int createTest(Test test, List<Integer> quizIds) throws SQLException {
        PreparedStatement psQuizTest = null;
        int newTestId = -1;

        String SQL_INSERT_TEST = "INSERT INTO test (code, title, description, time_interval, min_grade, course_id, course_section_id, created_by, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String SQL_INSERT_QUIZ_TEST = "INSERT INTO quiz_test (quiz_id, test_id) VALUES (?, ?)";

        try {
            con = dbc.getConnection();
            con.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Chèn vào bảng 'test'
            ps = con.prepareStatement(SQL_INSERT_TEST, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, generateUniqueCode());
            ps.setString(2, test.getTitle());
            ps.setString(3, test.getDescription());
            ps.setInt(4, test.getTimeInterval());
            ps.setInt(5, test.getMinGrade());
            ps.setInt(6, test.getCourseId());
            ps.setInt(7, test.getCourseSectionId());
            ps.setInt(8, test.getCreatedBy());
            ps.setInt(9, test.getCreatedBy());

            if (ps.executeUpdate() > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    newTestId = rs.getInt(1);
                } else {
                    throw new SQLException("Creating test failed, no ID obtained.");
                }
            } else {
                throw new SQLException("Creating test failed, no rows affected.");
            }

            // 2. Chèn vào bảng 'quiz_test' (sử dụng Batch Insert nếu có quiz)
            if (newTestId != -1 && quizIds != null && !quizIds.isEmpty()) {
                psQuizTest = con.prepareStatement(SQL_INSERT_QUIZ_TEST);
                for (int quizId : quizIds) {
                    psQuizTest.setInt(1, quizId);
                    psQuizTest.setInt(2, newTestId);
                    psQuizTest.addBatch();
                }
                psQuizTest.executeBatch();
            }

            con.commit(); // Hoàn tất Transaction
            return newTestId;

        } catch (SQLException e) {
            if (con != null) {
                con.rollback(); // Rollback nếu có lỗi
            }
            throw e;
        } finally {
            // Đóng tài nguyên
            if (psQuizTest != null) {
                psQuizTest.close();
            }
            closeResources();
        }
    }

    /**
     * Xóa một bài Test.
     *
     * @param testId ID của Test cần xóa.
     * @return true nếu xóa thành công, false nếu ngược lại.
     * @throws SQLException
     */
    public boolean deleteTest(int testId) throws SQLException {
        String SQL_DELETE_TEST = "DELETE FROM test WHERE id = ?";
        // Giả sử quiz_test có khóa ngoại ON DELETE CASCADE, nên chỉ cần xóa bảng test.
        // Nếu không có CASCADE, bạn phải xóa quiz_test trước.

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(SQL_DELETE_TEST);
            ps.setInt(1, testId);
            return ps.executeUpdate() > 0;
        } finally {
            closeResources();
        }
    }

    /**
     * Đếm số lượng Quiz khả dụng dựa trên Course ID. (Quiz thuộc Category của
     * Course)
     */
    public int countAvailableQuizzesByCourse(int courseId) throws SQLException {
        String SQL = "SELECT COUNT(q.id) "
                + "FROM quiz q "
                + "JOIN category c ON q.category_id = c.id "
                + "JOIN course co ON co.category_id = c.id "
                + "WHERE co.id = ?";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(SQL);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        } finally {
            closeResources();
        }
    }

    /**
     * Lấy ngẫu nhiên các Quiz ID dựa trên Course ID.
     */
    public List<Integer> getRandomQuizIds(int courseId, int count) throws SQLException {
        List<Integer> quizIds = new ArrayList<>();
        String SQL = "SELECT q.id FROM quiz q "
                + "JOIN category c ON q.category_id = c.id "
                + "JOIN course co ON co.category_id = c.id "
                + "WHERE co.id = ? "
                + "ORDER BY RAND() LIMIT ?"; // MySQL specific
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(SQL);
            ps.setInt(1, courseId);
            ps.setInt(2, count);
            rs = ps.executeQuery();
            while (rs.next()) {
                quizIds.add(rs.getInt("id"));
            }
            return quizIds;
        } finally {
            closeResources();
        }
    }

    // --- Các phương thức cho chức năng Update (Tùy chọn) ---
    // public Test getTestById(int testId) { ... }
    // public List<Integer> getQuizIdsForTest(int testId) { ... }
    // public boolean updateTest(Test test, List<Integer> quizIds) { ... }
    public static void main(String[] args) {
        TestDAO testDAO = new TestDAO();
        int createdByInstructorId = 2; // Giả định ID của Instructor cần kiểm tra

        System.out.println("--- BẮT ĐẦU KIỂM TRA CHỨC NĂNG HIỂN THỊ DANH SÁCH TEST ---");

        try {
            // Gọi hàm getListTestDetail mà không truyền tham số lọc (searchTitle, categoryName)
            System.out.println("\n[1] Đọc danh sách Test của Instructor ID " + createdByInstructorId + "...");

            // Truyền null cho các tham số lọc không sử dụng
            List<TestDetailDTO> listTest = testDAO.getListTestDetail(createdByInstructorId, null, null);

            if (listTest != null && !listTest.isEmpty()) {
                System.out.println("    ✅ Đọc danh sách thành công! Tổng số Test: " + listTest.size());
                System.out.println("\n    --- Chi tiết danh sách ---");

                // In chi tiết từng Test
                for (TestDetailDTO test : listTest) {
                    System.out.printf("    | ID: %-5d | Title: %-30s | Course: %-20s | Created: %s\n",
                            test.getId(),
                            test.getTitle(),
                            test.getCourseName(),
                            test.getDateCreated());
                }

            } else {
                System.out.println("    ⚠️ Danh sách Test trống cho Instructor ID " + createdByInstructorId + ". Vui lòng kiểm tra dữ liệu trong DB.");
            }

        } catch (SQLException e) {
            System.err.println("\n❌ LỖI KẾT NỐI/SQL XẢY RA: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("\n--- KẾT THÚC KIỂM TRA CHỨC NĂNG ---");
    }
}
