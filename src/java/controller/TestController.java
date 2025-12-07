package controller;

import DTO.TestDetailDTO;
import dao.TestDAO;
import model.Test;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * Servlet Controller để quản lý Bài Test (Test Builder)
 * @author nguye
 */
@WebServlet(name = "TestController", urlPatterns = {"/instructor/test"})
public class TestController extends HttpServlet {
    
    private TestDAO testDAO;
    private static final String TEST_LIST_PAGE = "testList.jsp";
    private static final String TEST_FORM_PAGE = "testBuild.jsp";

    @Override
    public void init() throws ServletException {
        super.init();
        testDAO = new TestDAO();
    }

    // Xử lý các yêu cầu đọc dữ liệu và chuyển hướng (list, createForm, updateForm, delete)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; 
        }

        try {
            switch (action) {
                case "list":
                    listTests(request, response);
                    break;
                case "createForm":
                    showCreateForm(request, response);
                    break;
                case "delete":
                    deleteTest(request, response);
                    break;
                // case "updateForm": 
                //     showUpdateForm(request, response); // Cần hiện thực
                //     break;
                default:
                    listTests(request, response);
                    break;
            }
        } catch (SQLException ex) {
            log("Lỗi SQL trong TestController (doGet): " + ex.getMessage(), ex);
            request.setAttribute("errorMessage", "Lỗi Cơ sở dữ liệu: " + ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception ex) {
            log("Lỗi hệ thống: " + ex.getMessage(), ex);
            throw new ServletException(ex);
        }
    }

    // Xử lý các yêu cầu ghi dữ liệu (save/create/update)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if ("save".equals(action)) {
            try {
                saveTest(request, response);
            } catch (SQLException ex) {
                log("Lỗi SQL khi lưu Test: " + ex.getMessage(), ex);
                request.setAttribute("errorMessage", "Lỗi lưu dữ liệu: " + ex.getMessage());
                request.getRequestDispatcher(TEST_FORM_PAGE).forward(request, response);
            }
        } else if ("randomQuiz".equals(action)) {
            // Xử lý yêu cầu AJAX để lấy Quiz ngẫu nhiên
            handleRandomQuiz(request, response);
        }
        else {
            doGet(request, response);
        }
    }

    // --- Phương thức cho GET ---
    
    private void listTests(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // --- Giả định Authentication ---
        // Lấy ID của Instructor từ Session. Giả định ID = 1 cho mục đích test.
        int instructorId = 1; 

        String searchTitle = request.getParameter("searchTitle");
        String categoryName = request.getParameter("categoryName"); 

        List<TestDetailDTO> listTest = testDAO.getListTestDetail(instructorId, searchTitle, categoryName);
        
        request.setAttribute("listTest", listTest);
        request.setAttribute("searchTitle", searchTitle);
        request.setAttribute("categoryName", categoryName);
        
        request.getRequestDispatcher(TEST_LIST_PAGE).forward(request, response);
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        
        // Lấy danh sách Course cho ComboBox (Cần thêm CourseDAO)
        // List<Course> listCourse = courseDAO.getAllCourses(); 
        // request.setAttribute("listCourse", listCourse);
        
        request.setAttribute("mode", "CREATE");
        request.getRequestDispatcher(TEST_FORM_PAGE).forward(request, response);
    }
    
    private void deleteTest(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int testId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();

        if (testDAO.deleteTest(testId)) {
            session.setAttribute("successMessage", "Xóa bài Test thành công!");
        } else {
            session.setAttribute("errorMessage", "Xóa bài Test thất bại. Vui lòng kiểm tra các ràng buộc.");
        }
        
        response.sendRedirect(request.getContextPath() + "/instructor/test?action=list");
    }

    // --- Phương thức cho POST ---

    private void saveTest(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException, ServletException {
        
        request.setCharacterEncoding("UTF-8"); // Đảm bảo tiếng Việt
        
        // 1. Lấy dữ liệu từ Form
        String title = request.getParameter("testName");
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int timeLimit = Integer.parseInt(request.getParameter("timeLimit"));
        String description = request.getParameter("description");
        String chosenQuizzesStr = request.getParameter("chosenQuizzes"); // Chuỗi ID quiz: "1,5,8"
        
        // Giả định
        int instructorId = 1; 

        // 2. Chuyển đổi Quiz IDs
        List<Integer> quizIds = convertStringToList(chosenQuizzesStr);
        
        // 3. Tạo đối tượng Test
        Test test = new Test(
            "", // Code sẽ được tạo trong DAO
            title, 
            description, 
            timeLimit, 
            courseId, 
            instructorId, 
            quizIds.size()
        );

        // 4. Lưu vào Database
        int newTestId = testDAO.createTest(test, quizIds); 

        HttpSession session = request.getSession();
        if (newTestId != -1) {
             session.setAttribute("successMessage", "Tạo bài Test thành công!");
        } else {
             session.setAttribute("errorMessage", "Tạo bài Test thất bại.");
        }

        // 5. Quay lại trang list
        response.sendRedirect(request.getContextPath() + "/instructor/test?action=list");
    }

    // --- Phương thức tiện ích ---
    
    // Hàm xử lý yêu cầu AJAX để lấy Quiz ngẫu nhiên
    private void handleRandomQuiz(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            int count = Integer.parseInt(request.getParameter("count"));
            
            // 1. Kiểm tra số lượng Quiz khả dụng
            int availableCount = testDAO.countAvailableQuizzesByCourse(courseId);
            
            if (count > availableCount) {
                 // Trả về lỗi nếu số lượng yêu cầu lớn hơn số lượng có sẵn
                out.print("{\"success\": false, \"message\": \"Số lượng quiz yêu cầu (" + count + ") vượt quá số lượng khả dụng (" + availableCount + ").\"}");
                return;
            }
            
            // 2. Lấy ngẫu nhiên
            List<Integer> randomIds = testDAO.getRandomQuizIds(courseId, count);
            
            // 3. Trả về JSON thành công
            String jsonResponse = "{\"success\": true, \"quizIds\": " + randomIds.toString() + "}";
            out.print(jsonResponse);
            
        } catch (Exception e) {
            log("Lỗi xử lý Random Quiz (AJAX): " + e.getMessage(), e);
            out.print("{\"success\": false, \"message\": \"Lỗi Server khi xử lý Random Quiz.\"}");
        }
    }

    private List<Integer> convertStringToList(String chosenQuizzesStr) {
        if (chosenQuizzesStr == null || chosenQuizzesStr.trim().isEmpty()) {
            return List.of(); // Trả về list rỗng
        }
        // Chuyển chuỗi "1,5,8" thành List<Integer> {1, 5, 8}
        return Arrays.stream(chosenQuizzesStr.split(","))
                     .map(String::trim)
                     .filter(s -> !s.isEmpty())
                     .map(Integer::parseInt)
                     .collect(Collectors.toList());
    }

}