package controller.instructor;

import dao.CourseDAO;
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
        int instructorId = 1;

        // Lấy danh sách khóa học
        var courses = courseDAO.getCoursesByInstructorId(999, 0, "", "", 0, "", "", instructorId);
        request.setAttribute("courses", courses);

        // Lấy courseId nếu có trên URL
        Integer selectedCourse = getInt(request, "courseId");

        // Nếu không có, lấy khóa đầu tiên
        if (selectedCourse == null && !courses.isEmpty()) {
            selectedCourse = courses.get(0).getId();
        }

        // Đẩy về JSP
        request.setAttribute("selectedCourse", selectedCourse);

        // LẤY DANH SÁCH TEST THEO COURSE
         request.setAttribute("testList", testDAO.getTestsByInstructor(instructorId));

        // Load quiz list để tạo / sửa test
        request.setAttribute("quizList", quizDAO.getAllQuizzes());

        // EDIT MODE
        Integer editId = getInt(request, "id");
        String action = request.getParameter("action");

        if ("edit".equals(action) && editId != null) {
            Test t = testDAO.getById(editId);
            request.setAttribute("editTest", t);
            request.setAttribute("selectedQuizIds", quizTestDAO.getQuizIdsByTest(editId));
        }

        request.getRequestDispatcher("/View/Instructor/testcreateCourse.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instructorId = 1;

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
            t.setCourseSectionId(0); // test của khóa học
            t.setCreatedBy(instructorId);

            int id = testDAO.createTest(t);

            if (id > 0) {
                quizTestDAO.deleteQuizByTest(id);
                processQuiz(mode, id, request);
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

            testDAO.updateTest(t);

            quizTestDAO.deleteQuizByTest(id);
            processQuiz(mode, id, request);

            response.sendRedirect(request.getContextPath() + "/instructor/test-course?courseId=" + courseId);
        }
    }

    private void processQuiz(String mode, int testId, HttpServletRequest request) {

        if ("custom".equals(mode)) {
            String[] ids = request.getParameterValues("quizId");
            if (ids != null) {
                for (String q : ids) {
                    quizTestDAO.addQuizToTest(testId, Integer.parseInt(q));
                }
            }
        } else if ("random".equals(mode)) {
            Integer count = getInt(request, "randomCount");
            if (count != null && count > 0) {

                List<Quiz> all = quizDAO.getAllQuizzes();
                Collections.shuffle(all);

                for (int i = 0; i < Math.min(count, all.size()); i++) {
                    quizTestDAO.addQuizToTest(testId, all.get(i).getId());
                }
            }
        }
    }
}
