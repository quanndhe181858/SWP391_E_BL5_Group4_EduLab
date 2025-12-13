/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.trainee;

/**
 *
 * @author vomin
 */
import dao.CourseProgressDAO;
import dao.QuizAnswerDAO;
import dao.QuizDAO;
import dao.QuizTestDAO;
import dao.TestsDAO;
import dao.testAttemptDao;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Quiz;
import model.QuizAnswer;

import java.io.IOException;
import java.util.List;
import model.Test;

@WebServlet("/trainee/submit-test")
public class SubmitTestController extends HttpServlet {

    private static final int MAX_ATTEMPT = 2;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int testId = Integer.parseInt(req.getParameter("testId"));

        // 🔥 PHÂN BIỆT SECTION TEST vs FINAL EXAM
        TestsDAO testsDAO = new TestsDAO();
        Test test = testsDAO.getById(testId);
        boolean isFinalExam = test.getCourseSectionId() == 0;

        QuizTestDAO quizTestDAO = new QuizTestDAO();
        QuizDAO quizDAO = new QuizDAO();
        QuizAnswerDAO answerDAO = new QuizAnswerDAO();
        testAttemptDao attemptDao = new testAttemptDao();

        int currentAttempt = attemptDao.getCurrentAttempt(userId, testId);
        if (currentAttempt >= MAX_ATTEMPT) {
            resp.sendRedirect(req.getContextPath() + "/error/403.jsp");
            return;
        }

        List<Integer> quizIds = quizTestDAO.getQuizIdsByTest(testId);
        int correct = 0;

        for (int quizId : quizIds) {
            List<QuizAnswer> answers = answerDAO.getQuizAnswersByQuizId(quizId);

            String selectedRaw = req.getParameter("q" + quizId);
            if (selectedRaw == null) {
                continue;
            }

            int selectedAnswerId = Integer.parseInt(selectedRaw);

            boolean isCorrect = answers.stream()
                    .anyMatch(a -> a.isIs_true() && a.getId() == selectedAnswerId);

            if (isCorrect) {
                correct++;
            }
        }

        double score = quizIds.isEmpty()
                ? 0
                : correct * 10.0 / quizIds.size();

        String status = score >= 4 ? "pass" : "fail";

        attemptDao.saveAttempt(userId, testId, currentAttempt + 1, score, status);

        // SECTION TEST 
        if (!isFinalExam) {

            int courseId = Integer.parseInt(req.getParameter("courseId"));
            int sectionId = Integer.parseInt(req.getParameter("sectionId"));

        // ⭐ KHỞI TẠO DAO ⭐
            CourseProgressDAO progressDAO = new CourseProgressDAO();

        // ⭐ ĐÁNH DẤU TEST HOÀN THÀNH ⭐
            progressDAO.markTestDone(userId, courseId, sectionId);

            resp.sendRedirect(
                    req.getContextPath()
                    + "/learn?courseId=" + courseId
                    + "&sectionId=" + sectionId
            );
            return;

        }

        //  FINAL EXAM  
        req.setAttribute("score", score);
        req.setAttribute("passed", score >= 4);
        req.setAttribute("allowRetake", currentAttempt + 1 < MAX_ATTEMPT);
        req.setAttribute("testId", testId);

        req.getRequestDispatcher("/View/Trainee/TestResult.jsp").forward(req, resp);
    }
}
