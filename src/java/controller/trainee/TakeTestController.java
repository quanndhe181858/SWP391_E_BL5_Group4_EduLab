package controller.trainee;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author vomin
 */
import dao.QuizAnswerDAO;
import dao.QuizDAO;
import dao.QuizTestDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Question;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/trainee/taketest")
public class TakeTestController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String testIdRaw = req.getParameter("testId");
        if (testIdRaw == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int testId;
        try {
            testId = Integer.parseInt(testIdRaw);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        QuizTestDAO quizTestDAO = new QuizTestDAO();
        QuizDAO quizDAO = new QuizDAO();
        QuizAnswerDAO answerDAO = new QuizAnswerDAO();

        List<Integer> quizIds = quizTestDAO.getQuizIdsByTest(testId);
        List<Question> questions = new ArrayList<>();

        for (int quizId : quizIds) {
            Question q = quizDAO.getQuestionById(quizId);
            if (q != null) {
                q.setAnswers(answerDAO.getQuizAnswersByQuizId(quizId));
                questions.add(q);
            }
        }

        if (questions.isEmpty()) {
            req.setAttribute("error", "This test has no questions yet.");
            req.getRequestDispatcher("/error/empty-test.jsp")
                    .forward(req, resp);
            return;
        }

        req.setAttribute("questions", questions);
        req.setAttribute("testId", testId);

        req.getRequestDispatcher("/View/Trainee/TakeTest.jsp")
                .forward(req, resp);
    }
}

