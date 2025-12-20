package controller.instructor;

import dao.CategoryDAO;
import dao.CourseDAO;
import dao.QuizDAO;
import dao.QuizTestDAO;
import dao.TestsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Course;
import model.Quiz;
import model.Test;
import model.User;

@WebServlet(name = "InstructorTestCourse", urlPatterns = {"/instructor/test-course"})
public class InstructorTestCourse extends HttpServlet {

    private final TestsDAO testDAO = new TestsDAO();
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuizTestDAO quizTestDAO = new QuizTestDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        try {
            String raw = req.getParameter(name);
            return (raw == null || raw.isBlank()) ? null : Integer.parseInt(raw);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        if (u.getRole_id() != 2) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        int instructorId = u.getId();

        var courses = courseDAO.getCoursesByInstructorId(999, 0, "", "", 0, "", "", instructorId);
        request.setAttribute("courses", courses);

        Integer selectedCourse = getInt(request, "courseId");

        if (selectedCourse == null && !courses.isEmpty()) {
            selectedCourse = courses.get(0).getId();
        }

        request.setAttribute("selectedCourse", selectedCourse);
        request.setAttribute("testList", testDAO.getTestsByInstructor(instructorId));

        // ⭐ LẤY QUIZ THEO CATEGORY CỦA COURSE (CHA + CON)
        if (selectedCourse != null) {
            Course course = courseDAO.getCourseById(selectedCourse);
            if (course != null && course.getCategory_id() > 0) {
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Integer> categoryIds = new ArrayList<>();
                categoryIds.add(course.getCategory_id());

                // Nếu là category cha → thêm tất cả con
                if (categoryDAO.hasChildren(course.getCategory_id())) {
                    categoryIds.addAll(categoryDAO.getChildCategoryIds(course.getCategory_id()));
                }

                List<Quiz> quizList = quizDAO.getQuizzesByMultipleCategories(categoryIds);
                request.setAttribute("quizList", quizList);
            } else {
                request.setAttribute("quizList", new ArrayList<>());
            }
        } else {
            request.setAttribute("quizList", new ArrayList<>());
        }

        Integer editId = getInt(request, "id");
        String action = request.getParameter("action");

        if ("edit".equals(action) && editId != null) {
            Test t = testDAO.getById(editId);
            request.setAttribute("editTest", t);
            request.setAttribute("selectedCourse", t.getCourseId());
            request.setAttribute("selectedQuizIds", quizTestDAO.getQuizIdsByTest(editId));

            // ⭐ UPDATE QUIZ LIST CHO EDIT MODE (CHA + CON)
            Course course = courseDAO.getCourseById(t.getCourseId());
            if (course != null && course.getCategory_id() > 0) {
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Integer> categoryIds = new ArrayList<>();
                categoryIds.add(course.getCategory_id());

                // Nếu là category cha → thêm tất cả con
                if (categoryDAO.hasChildren(course.getCategory_id())) {
                    categoryIds.addAll(categoryDAO.getChildCategoryIds(course.getCategory_id()));
                }

                List<Quiz> quizList = quizDAO.getQuizzesByMultipleCategories(categoryIds);
                request.setAttribute("quizList", quizList);
            }
        }

        request.getRequestDispatcher("/View/Instructor/testcreateCourse.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        User u = (User) session.getAttribute("user");

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        if (u.getRole_id() != 2) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }

        int instructorId = u.getId();

        String action = request.getParameter("action");
        Integer courseId = getInt(request, "courseId");

        Integer duration = getInt(request, "duration");
        Integer minGrade = getInt(request, "minGrade");
        String code = request.getParameter("code");
        String title = request.getParameter("title");
        String desc = request.getParameter("description");

        if (courseId == null || code == null || code.isBlank()
                || title == null || title.isBlank()
                || duration == null || minGrade == null) {

            request.setAttribute("error", "Thiếu dữ liệu.");
            doGet(request, response);
            return;
        }

        String mode = request.getParameter("mode");

        if ("create".equals(action)) {

            Test t = new Test();
            t.setCode(code);
            t.setTitle(title);
            t.setDescription(desc);
            t.setTimeInterval(duration);
            t.setMinGrade(minGrade);
            t.setCourseId(courseId);
            t.setCourseSectionId(0);
            t.setCreatedBy(instructorId);

            if (testDAO.isCodeOrTitleExisted(code, title, null)) {
                request.setAttribute("error", "Code hoặc tiêu đề đã tồn tại.");
                doGet(request, response);
                return;
            }
            if (testDAO.isCourseTestExisted(courseId, null)) {
                request.setAttribute("error", "Khóa học này đã có bài test cuối khóa.");
                doGet(request, response);
                return;
            }

            if (duration <= 0) {
                request.setAttribute("error", "Thời lượng bài test phải lớn hơn 0.");
                doGet(request, response);
                return;
            }

            if (minGrade < 0 || minGrade > 100) {
                request.setAttribute("error", "Điểm đạt phải nằm trong khoảng 0 – 100.");
                doGet(request, response);
                return;
            }

            int id = testDAO.createTest(t);

            if (id > 0) {
                quizTestDAO.deleteQuizByTest(id);
                // ⭐ TRUYỀN courseId VÀO processQuiz
                processQuiz(mode, id, courseId, request);
            }

            response.sendRedirect(request.getContextPath() + "/instructor/test-course?courseId=" + courseId);
            return;
        }

        if ("update".equals(action)) {
            Integer id = getInt(request, "id");

            Test t = new Test();
            t.setId(id);
            t.setCode(code);
            t.setTitle(title);
            t.setDescription(desc);
            t.setTimeInterval(duration);
            t.setMinGrade(minGrade);
            t.setCourseId(courseId);
            t.setCourseSectionId(0);

            if (testDAO.isCodeOrTitleExisted(code, title, id)) {
                request.setAttribute("error", "Code hoặc tiêu đề đã tồn tại.");
                doGet(request, response);
                return;
            }
            if (testDAO.isCourseTestExisted(courseId, id)) {
                request.setAttribute("error", "Mỗi khóa học chỉ được có 1 bài test cuối khóa.");
                doGet(request, response);
                return;
            }

            if (duration <= 0) {
                request.setAttribute("error", "Thời lượng bài test phải lớn hơn 0.");
                doGet(request, response);
                return;
            }

            if (minGrade < 0 || minGrade > 100) {
                request.setAttribute("error", "Điểm đạt phải nằm trong khoảng 0 – 100.");
                doGet(request, response);
                return;
            }

            testDAO.updateTest(t);

            quizTestDAO.deleteQuizByTest(id);
            processQuiz(mode, id, courseId, request);

            response.sendRedirect(request.getContextPath() + "/managerTest");
        }
    }

    // ⭐ UPDATE processQuiz ĐỂ FILTER THEO CATEGORY (CHA + CON)
    private void processQuiz(String mode, int testId, int courseId, HttpServletRequest request) {

        // Lấy categoryId từ course
        Course course = courseDAO.getCourseById(courseId);
        if (course == null || course.getCategory_id() <= 0) {
            request.setAttribute("error", "Không tìm thấy category của khóa học.");
            return;
        }

        int categoryId = course.getCategory_id();

        // ⭐ XÁC ĐỊNH DANH SÁCH CATEGORY IDs CẦN LẤY QUIZ
        List<Integer> categoryIds = new ArrayList<>();
        categoryIds.add(categoryId); // Luôn thêm category hiện tại

        // Nếu là category CHA (có con) → thêm tất cả con vào
        CategoryDAO categoryDAO = new CategoryDAO();
        if (categoryDAO.hasChildren(categoryId)) {
            List<Integer> childIds = categoryDAO.getChildCategoryIds(categoryId);
            categoryIds.addAll(childIds);
        }
        // Nếu là category CON → chỉ dùng chính nó (đã add ở trên)

        if ("custom".equals(mode)) {
            String[] ids = request.getParameterValues("quizId");
            if (ids != null) {
                // Lấy quiz theo nhiều categories
                List<Quiz> availableQuizzes = quizDAO.getQuizzesByMultipleCategories(categoryIds);

                for (String q : ids) {
                    int quizId = Integer.parseInt(q);

                    // ⭐ KIỂM TRA QUIZ CÓ TRONG DANH SÁCH AVAILABLE KHÔNG
                    boolean isValid = availableQuizzes.stream()
                            .anyMatch(quiz -> quiz.getId() == quizId);

                    if (isValid) {
                        quizTestDAO.addQuizToTest(testId, quizId);
                    }
                }
            }
        } else if ("random".equals(mode)) {
            Integer count = getInt(request, "randomCount");
            if (count == null || count <= 0) {
                return;
            }

            // ⭐ LẤY QUIZ THEO NHIỀU CATEGORIES
            List<Quiz> availableQuizzes = quizDAO.getQuizzesByMultipleCategories(categoryIds);

            if (count > availableQuizzes.size()) {
                request.setAttribute("error", "Không đủ số lượng quiz trong danh mục này. Có " + availableQuizzes.size() + " quiz.");
                return;
            }

            Collections.shuffle(availableQuizzes);
            for (int i = 0; i < count; i++) {
                quizTestDAO.addQuizToTest(testId, availableQuizzes.get(i).getId());
            }
        }
    }
}
