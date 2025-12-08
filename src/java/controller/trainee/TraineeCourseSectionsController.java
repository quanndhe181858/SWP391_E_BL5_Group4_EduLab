/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.trainee;

import constant.httpStatus;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.CourseSection;
import service.CourseSectionServices;
import service.CourseServices;
import util.ResponseUtils;

/**
 *
 * @author quan
 */
@WebServlet(name = "TraineeCourseSectionsController", urlPatterns = {
    "/courses/sections"
})
public class TraineeCourseSectionsController extends HttpServlet {
    
    private CourseServices _courseService;
    private CourseSectionServices _courseSectionService;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        _courseService = new CourseServices();
        _courseSectionService = new CourseSectionServices();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String qs = req.getQueryString();
            
            if (qs == null || qs.contains("id")) {
                this.getCourseSections(req, resp);
            } else if (qs.contains("csid")) {
                this.getCourseSectionDetail(req, resp);
            }
            
        } catch (ServletException | IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
    }
    
    protected void getCourseSections(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Object> res = new HashMap<>();
        
        try {
            String courseIdStr = req.getParameter("id");
            
            if (courseIdStr == null || courseIdStr.isBlank()) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "ID không hợp lệ");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }
            
            int courseId = 0;
            
            try {
                courseId = Integer.parseInt(courseIdStr);
            } catch (NumberFormatException e) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "ID không hợp lệ");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }
            
            List<CourseSection> csList = _courseSectionService.getSectionsByCourseId(courseId);
            
            resp.setStatus(200);
            res.put("success", true);
            res.put("sections", csList);
            
        } catch (IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
        
        ResponseUtils.sendJsonResponse(resp, res);
    }
    
    protected void getCourseSectionDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
}
