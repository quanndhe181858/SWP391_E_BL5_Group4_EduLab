package controller;

import DTO.TestDetailDTO;
import dao.TestDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/instructor/listTests", "/instructor/deleteTest"})
public class TestController extends HttpServlet {

    private final TestDAO dao = new TestDAO();
    private static final int INSTRUCTOR_ID = 2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String searchTitle = request.getParameter("searchTitle");
            String categoryName = request.getParameter("categoryName");

            List<TestDetailDTO> list = dao.getAllTests(
                    INSTRUCTOR_ID, searchTitle, categoryName
            );

            request.setAttribute("listTest", list);
            request.setAttribute("searchTitle", searchTitle);
            request.setAttribute("categoryName", categoryName);

            request.getRequestDispatcher("/View/Instructor/ListTest.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Lỗi CSDL: " + e.getMessage());
        }
    }
}
