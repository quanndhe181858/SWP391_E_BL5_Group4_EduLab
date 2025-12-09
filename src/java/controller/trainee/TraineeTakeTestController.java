/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import dao.TestsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Question;

/**
 *
 * @author quan
 */
@WebServlet(name = "TraineeTakeTestController", urlPatterns = {"/trainee/taketest_old"})
public class TraineeTakeTestController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int testId = Integer.parseInt(req.getParameter("testId"));

        TestsDAO dao = new TestsDAO();
        List<Question> questions = dao.getQuestionsByTest(testId);

        req.setAttribute("questions", questions);
        req.setAttribute("testId", testId);

        req.getRequestDispatcher("/View/Trainee/TakeTest.jsp").forward(req, resp);
    }
}
