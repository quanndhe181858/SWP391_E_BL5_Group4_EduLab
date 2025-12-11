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
import model.Quiz;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/trainee/taketest")
public class TakeTestController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int testId = Integer.parseInt(req.getParameter("testId"));

        QuizTestDAO quizTestDAO = new QuizTestDAO();
        QuizDAO quizDAO = new QuizDAO();
        QuizAnswerDAO answerDAO = new QuizAnswerDAO();

        // Lấy danh sách quizId theo test
        List<Integer> quizIds = quizTestDAO.getQuizIdsByTest(testId);

        if (quizIds == null || quizIds.isEmpty()) {
            req.setAttribute("error", "No quiz found for this test.");
            req.getRequestDispatcher("/View/Error/error.jsp").forward(req, resp);
            return;
        }

        // Chuẩn hóa list Quiz + Answers
        List<Quiz> quizList = new ArrayList<>();

        for (int qId : quizIds) {
            Quiz quiz = quizDAO.getQuizById(qId);

            if (quiz != null) {
                // TÊN HÀM ĐÚNG !!
                quiz.setAnswers(answerDAO.getQuizAnswersByQuizId(qId));
                quizList.add(quiz);
            }
        }

        if (quizList.isEmpty()) {
            req.setAttribute("error", "Quiz data is missing.");
            req.getRequestDispatcher("/View/Error/error.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("quizList", quizList);
        req.setAttribute("testId", testId);

        req.getRequestDispatcher("/View/Trainee/TakeTest.jsp")
                .forward(req, resp);
    }
}
