package controller.trainee;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author vomin
 */

import dao.TestDAO;
import model.Question;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/trainee/taketest")
public class TakeTestController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int testId = Integer.parseInt(req.getParameter("testId"));

        TestDAO dao = new TestDAO();
        List<Question> questions = dao.getQuestionsByTest(testId);

        req.setAttribute("questions", questions);
        req.setAttribute("testId", testId);

        req.getRequestDispatcher("/View/Trainee/TakeTest.jsp").forward(req, resp);
    }
}
