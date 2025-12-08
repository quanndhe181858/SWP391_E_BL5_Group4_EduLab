/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.trainee;

/**
 *
 * @author vomin
 */



import dao.testAttemptDao;
import dao.testDao;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Answer;
import model.Question;
import java.io.IOException;
import java.util.List;

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
        testDao dao = new testDao();

        int currentAttempt = attemptDao.getCurrentAttempt(userId, testId);
        if (currentAttempt >= MAX_ATTEMPT) {
            resp.sendRedirect(req.getContextPath() + "/error/403.jsp");
            return;
        }

        List<Question> questions = dao.getQuestionsByTest(testId);

        int correct = 0;
        int total = questions.size();

        for (int i = 0; i < total; i++) {
            String userAnswer = req.getParameter("q" + (i + 1));
            int correctAnswerId = findCorrectAnswerId(questions.get(i));

            if (userAnswer != null
                    && correctAnswerId != -1
                    && Integer.parseInt(userAnswer) == correctAnswerId) {
                correct++;
            }
        }

        double score = total == 0 ? 0 : (correct * 10.0) / total;
        int newAttempt = currentAttempt + 1;

        attemptDao.saveAttempt(
                userId,
                testId,
                newAttempt,
                score,
                score >= 4 ? "pass" : "fail"
        );

        req.setAttribute("score", score);
        req.setAttribute("testId", testId);
        req.setAttribute("allowRetake", newAttempt < MAX_ATTEMPT);
        req.setAttribute("showBack", score >= 4);

        req.getRequestDispatcher("/View/Trainee/TestResult.jsp")
                .forward(req, resp);
    }

    private int findCorrectAnswerId(Question q) {
        for (Answer a : q.getAnswers()) {
            if (a.isCorrect()) {
                return a.getId();
            }
        }
        return -1;
    }
}
