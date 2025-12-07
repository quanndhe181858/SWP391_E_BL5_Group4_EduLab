s/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constant.httpStatus;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.categoryServices;
import service.courseSectionServices;
import service.courseServices;

/**
 *
 * @author quan
 */
@WebServlet(name = "InstructorCourseController", urlPatterns = {
    "/instructor/courses"
})
public class InstructorCourseController extends HttpServlet {

    private categoryServices _categoryService;
    private courseSectionServices _courseSectionService;
    private courseServices _courseService;
    private httpStatus _httpStatus;

    @Override
    public void init(ServletConfig config) throws ServletException {
        _categoryService = new categoryServices();
        _courseSectionService = new courseSectionServices();
        _courseService = new courseServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

        } catch (Exception e) {
            resp.sendError(_httpStatus.INTERNAL_SERVER_ERROR.getCode(), _httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

}
