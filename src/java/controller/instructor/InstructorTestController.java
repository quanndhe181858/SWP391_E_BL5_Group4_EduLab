package controller.instructor;

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
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import model.Quiz;
import model.Test;

@WebServlet(name = "InstructorTestController", urlPatterns = {"/instructor/test"})
public class InstructorTestController extends HttpServlet {

    private final TestsDAO testDAO = new TestsDAO();
    private final QuizDAO quizDAO = new QuizDAO();
    private final QuizTestDAO quizTestDAO = new QuizTestDAO();
    private final CourseDAO courseDAO = new CourseDAO();
    private final CourseSectionDAO sectionDAO = new CourseSectionDAO();

    private Integer getInt(HttpServletRequest req, String name) {
        String raw = req.getParameter(name);
        return (raw == null || raw.isBlank()) ? null : Integer.parseInt(raw);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instructorId = 1;

        // Load course list
        var courses = courseDAO.getCoursesByInstructorId(
                999, 0, "", "", 0, "", "", instructorId);

        request.setAttribute("courses", courses);

        // Determine selected course
        Integer selectedCourse = getInt(request, "courseId");

        if (selectedCourse == null && !courses.isEmpty()) {
            selectedCourse = courses.get(0).getId();   // CHỌN KHÓA ĐẦU TIÊN
        }

        request.setAttribute("selectedCourse", selectedCourse);

        // Load section theo selectedCourse
        var sections = sectionDAO.getAllCourseSectionsByCourseId(selectedCourse);
        request.setAttribute("sections", sections);

        // Load quiz
        request.setAttribute("quizList", quizDAO.getAllQuizzes());

        // Load tests
        request.setAttribute("testList", testDAO.getTestsByInstructor(instructorId));

        // EDIT MODE
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            Integer id = getInt(request, "id");
            if (id != null) {
                Test t = testDAO.getById(id);
                request.setAttribute("editTest", t);

                selectedCourse = t.getCourseId();
                request.setAttribute("selectedCourse", selectedCourse);

                request.setAttribute("sections",
                        sectionDAO.getAllCourseSectionsByCourseId(selectedCourse));

                request.setAttribute("selectedQuizIds",
                        quizTestDAO.getQuizIdsByTest(id));
            }
        }

        request.getRequestDispatcher("/View/Instructor/TestCreate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instructorId = 1;

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

        // CREATE
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

            int id = testDAO.createTest(t);

            if (id <= 0) {
                request.setAttribute("error", "Không thể tạo test");
                doGet(request, response);
                return;
            }

            processQuiz(mode, id, request);
        }

        // UPDATE
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

            testDAO.updateTest(t);
            quizTestDAO.deleteQuizByTest(id);

            processQuiz(mode, id, request);
        }

        response.sendRedirect(request.getContextPath() + "/instructor/test");
    }

   private void processQuiz(String mode, int testId, HttpServletRequest request) {

    // ===== CUSTOM MODE =====
    if ("custom".equals(mode)) {
        String[] quizIds = request.getParameterValues("quizId");
        if (quizIds != null) {
            for (String q : quizIds) {
                quizTestDAO.addQuizToTest(testId, Integer.parseInt(q));
            }
        }
        return; // 🔥 QUAN TRỌNG: DỪNG Ở ĐÂY, KHÔNG XỬ LÝ RANDOM
    }

    // ===== RANDOM MODE =====
    if ("random".equals(mode)) {
        Integer count = getInt(request, "randomCount");

        if (count == null || count <= 0) {
            System.out.println("⚠ randomCount is null → skip random");
            return; // hoặc throw lỗi tuỳ bạn
        }

        List<Quiz> all = quizDAO.getAllQuizzes();
        Collections.shuffle(all);

        for (int i = 0; i < Math.min(count, all.size()); i++) {
            quizTestDAO.addQuizToTest(testId, all.get(i).getId());
        }
    }
}

}
