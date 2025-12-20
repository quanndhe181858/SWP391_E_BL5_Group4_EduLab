package controller.instructor;

import dao.CategoryDAO;
import dao.CourseDAO;
import dao.CourseSectionDAO;
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

@WebServlet(name = "InstructorTestController", urlPatterns = {"/instructor/test"})
public class InstructorTestController extends HttpServlet {

    private final TestsDAO testDAO = new TestsDAO();
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuizTestDAO quizTestDAO = new QuizTestDAO();
    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        try {
            String raw = req.getParameter(name);
            return (raw == null || raw.isBlank()) ? null : Integer.parseInt(raw);
        } catch (NumberFormatException e) {
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

        var courses = courseDAO.getCoursesByInstructorId(
                999, 0, "", "", 0, "", "", instructorId);
        request.setAttribute("courses", courses);

        Integer selectedCourse = getInt(request, "courseId");

        if (selectedCourse == null && !courses.isEmpty()) {
            selectedCourse = courses.get(0).getId();
        }

        request.setAttribute("selectedCourse", selectedCourse);

        // ⭐ KIỂM TRA selectedCourse TRƯỚC KHI SỬ DỤNG
        if (selectedCourse != null) {
            request.setAttribute("sections", sectionDAO.getAllCourseSectionsByCourseId(selectedCourse));

            // ⭐ LẤY QUIZ THEO CATEGORY CỦA COURSE (CHA + CON)
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
            // Nếu không có course nào được chọn
            request.setAttribute("sections", new ArrayList<>());
            request.setAttribute("quizList", new ArrayList<>());
        }

        request.setAttribute("testList", testDAO.getTestsByInstructor(instructorId));

        String action = request.getParameter("action");
        Integer id = getInt(request, "id");

        if ("edit".equals(action) && id != null) {

            Test t = testDAO.getById(id);

            if (t.getCourseSectionId() == 0) {
                response.sendRedirect(request.getContextPath()
                        + "/instructor/test-course?action=edit&id=" + id);
                return;
            }

            request.setAttribute("editTest", t);
            request.setAttribute("selectedCourse", t.getCourseId());
            request.setAttribute("sections",
                    sectionDAO.getAllCourseSectionsByCourseId(t.getCourseId()));
            request.setAttribute("selectedQuizIds",
                    quizTestDAO.getQuizIdsByTest(id));

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

        } else if ("view".equals(action) && id != null) {
            Test t = testDAO.getById(id);

            if (t.getCourseSectionId() == 0) {
                response.sendRedirect(request.getContextPath()
                        + "/instructor/test-course?action=edit&id=" + id);
                return;
            }

            request.setAttribute("editTest", t);
            request.setAttribute("selectedCourse", t.getCourseId());
            request.setAttribute("sections",
                    sectionDAO.getAllCourseSectionsByCourseId(t.getCourseId()));
            request.setAttribute("selectedQuizIds",
                    quizTestDAO.getQuizIdsByTest(id));
        }

        request.getRequestDispatcher("/View/Instructor/TestCreate.jsp")
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
        String mode = request.getParameter("mode");

        Integer courseId = getInt(request, "courseId");
        Integer sectionId = getInt(request, "sectionId");

        if (courseId == null || sectionId == null) {
            request.setAttribute("error", "Thiếu khóa học hoặc bài học");
            doGet(request, response);
            return;
        }

        Integer duration = getInt(request, "duration");
        Integer minGrade = getInt(request, "minGrade");
        String code = request.getParameter("code");
        String title = request.getParameter("title");
        String desc = request.getParameter("description");

        if ("create".equals(action)) {

            Test t = new Test();
            t.setCode(code);
            t.setTitle(title);
            t.setDescription(desc);
            t.setTimeInterval(duration);
            t.setMinGrade(minGrade);
            t.setCourseId(courseId);
            t.setCourseSectionId(sectionId);
            t.setCreatedBy(instructorId);
            t.setUpdatedBy(instructorId);

            if (testDAO.isCodeOrTitleExisted(code, title, null)) {
                request.setAttribute("error", "Code hoặc tiêu đề đã tồn tại.");
                doGet(request, response);
                return;
            }
            if (testDAO.isSectionTestExisted(courseId, sectionId, null)) {
                request.setAttribute("error", "Bài học này đã có bài test.");
                doGet(request, response);
                return;
            }

            int id = testDAO.createTest(t);
            if (id <= 0) {
                request.setAttribute("error", "Không thể tạo test");
                doGet(request, response);
                return;
            }

            // ⭐ TRUYỀN courseId VÀO processQuiz
            processQuiz(mode, id, courseId, request);
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
            t.setCourseSectionId(sectionId);
            t.setUpdatedBy(instructorId);

            if (testDAO.isCodeOrTitleExisted(code, title, id)) {
                request.setAttribute("error", "Code hoặc tiêu đề đã tồn tại.");
                doGet(request, response);
                return;
            }
            if (testDAO.isSectionTestExisted(courseId, sectionId, id)) {
                request.setAttribute("error", "Mỗi bài học chỉ được có 1 bài test.");
                doGet(request, response);
                return;
            }

            testDAO.updateTest(t);

            quizTestDAO.deleteQuizByTest(id);

            // ⭐ TRUYỀN courseId VÀO processQuiz
            processQuiz(mode, id, courseId, request);
        }

        response.sendRedirect(request.getContextPath() + "/managerTest");
    }

    // ⭐ UPDATE processQuiz ĐỂ FILTER THEO CATEGORY
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
            String[] quizIds = request.getParameterValues("quizId");
            if (quizIds != null) {
                // Lấy quiz theo nhiều categories
                List<Quiz> availableQuizzes = quizDAO.getQuizzesByMultipleCategories(categoryIds);

                for (String q : quizIds) {
                    int quizId = Integer.parseInt(q);

                    // ⭐ KIỂM TRA QUIZ CÓ TRONG DANH SÁCH AVAILABLE KHÔNG
                    boolean isValid = availableQuizzes.stream()
                            .anyMatch(quiz -> quiz.getId() == quizId);

                    if (isValid) {
                        quizTestDAO.addQuizToTest(testId, quizId);
                    }
                }
            }
            return;
        }

        if ("random".equals(mode)) {
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
