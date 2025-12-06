/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import constant.httpStatus;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CourseSection;
import model.User;
import service.CourseSectionServices;
import util.AuthUtils;

/**
 *
 * @author quan
 */
@WebServlet(name = "CourseSectionsController", urlPatterns = {
    "/instructor/courses/sections"
})
public class CourseSectionsController extends HttpServlet {

    private CourseSectionServices _courseSectionService;

    @Override
    public void init(ServletConfig config)
            throws ServletException {
        super.init(config);
        _courseSectionService = new CourseSectionServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String qs = req.getQueryString();
            User user = AuthUtils.doAuthorize(req, resp, 2);

            if (qs == null) {
                this.getCourseSections(req, resp);
            } else {
                this.getCourseSections(req, resp);
            }

        } catch (ServletException | IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            User user = AuthUtils.doAuthorize(req, resp, 2);

            String courseSectionIdStr = req.getParameter("csid");

            if (courseSectionIdStr == null || courseSectionIdStr.isBlank()) {
                resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
                return;
            }

            int courseSectionId = 0;

            try {
                courseSectionId = Integer.parseInt(courseSectionIdStr);
            } catch (NumberFormatException e) {
                resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
                return;
            }

            CourseSection c = _courseSectionService.getSectionById(courseSectionId);

            if (c == null || c.getId() != courseSectionId) {
                resp.sendError(httpStatus.NOT_FOUND.getCode(), httpStatus.NOT_FOUND.getMessage());
                return;
            }

            boolean isDeleted = _courseSectionService.deleteSection(courseSectionId);

            if (isDeleted) {

            } else {
                resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
            }

        } catch (IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
    }

    protected void getCourseSectionDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    }

    protected void getCourseSections(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    }
}
