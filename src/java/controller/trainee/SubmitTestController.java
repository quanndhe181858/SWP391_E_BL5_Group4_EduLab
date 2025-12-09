/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.trainee;

/**
 *
 * @author vomin
 */
import dao.QuizAnswerDAO;
import dao.QuizDAO;
import dao.QuizTestDAO;
import dao.testAttemptDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import model.Question;
import model.QuestionResult;
import model.QuizAnswer;
import model.User;

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

        testAttemptDao attemptDao = new testAttemptDao();
        QuizDAO quizDAO = new QuizDAO();
        QuizAnswerDAO answerDAO = new QuizAnswerDAO();
        QuizTestDAO quizTestDAO = new QuizTestDAO();

        int currentAttempt = attemptDao.getCurrentAttempt(userId, testId);
        if (currentAttempt >= MAX_ATTEMPT) {
            resp.sendRedirect(req.getContextPath() + "/error/403.jsp");
            return;
        }

        List<Integer> quizIds = quizTestDAO.getQuizIdsByTest(testId);
        List<QuestionResult> results = new ArrayList<>();

        int correctCount = 0;

        for (int quizId : quizIds) {

            Question q = quizDAO.getQuestionById(quizId);
            List<QuizAnswer> answers = answerDAO.getQuizAnswersByQuizId(quizId);

            boolean isMultiple = "Multiple Choice".equalsIgnoreCase(q.getType());

            // ✅ User selected
            List<Integer> selectedIds = new ArrayList<>();
            if (isMultiple) {
                String[] arr = req.getParameterValues("q" + quizId);
                if (arr != null) {
                    for (String s : arr) {
                        selectedIds.add(Integer.parseInt(s));
                    }
                }
            } else {
                String s = req.getParameter("q" + quizId);
                if (s != null) {
                    selectedIds.add(Integer.parseInt(s));
                }
            }

            // ✅ Correct answers
            List<Integer> correctIds = answers.stream()
                    .filter(QuizAnswer::isIs_true)
                    .map(QuizAnswer::getId)
                    .toList();

            QuestionResult qr = new QuestionResult();
            qr.setQuestionId(quizId);
            qr.setContent(q.getContent());
            qr.setType(q.getType());
            qr.setAnswers(answers);
            qr.setSelectedAnswerIds(selectedIds);
            qr.setCorrectAnswerIds(correctIds);

            if (qr.isCorrect()) {
                correctCount++;
            }

            results.add(qr);
        }

        int total = quizIds.size();
        double score = total == 0 ? 0 : (correctCount * 10.0 / total);

        attemptDao.saveAttempt(
                userId,
                testId,
                currentAttempt + 1,
                score,
                score >= 4 ? "pass" : "fail"
        );

        req.setAttribute("score", score);
        req.setAttribute("passed", score >= 4);
        req.setAttribute("results", results);
        req.setAttribute("allowRetake", currentAttempt + 1 < MAX_ATTEMPT);
        req.setAttribute("testId", testId);

        req.getRequestDispatcher("/View/Trainee/TestResult.jsp")
                .forward(req, resp);
    }
}
