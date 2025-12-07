/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import constant.httpStatus;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.HashMap;
import java.util.Map;
import model.Course;
import model.CourseSection;
import model.Media;
import model.User;
import service.CourseSectionServices;
import service.CourseServices;
import service.MediaServices;
import util.AuthUtils;
import util.FileUtils;
import util.ResponseUtils;

/**
 *
 * @author quan
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 100, // 100MB
        maxRequestSize = 1024 * 1024 * 150 // 150MB
)
@WebServlet(name = "CourseSectionsController", urlPatterns = {
    "/instructor/courses/sections"
})
public class CourseSectionsController extends HttpServlet {

    private CourseSectionServices _courseSectionService;
    private CourseServices _courseService;
    private MediaServices _mediaService;

    @Override
    public void init(ServletConfig config)
            throws ServletException {
        super.init(config);
        _courseSectionService = new CourseSectionServices();
        _courseService = new CourseServices();
        _mediaService = new MediaServices();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String qs = req.getQueryString();
            User user = AuthUtils.doAuthorize(req, resp, 2);

            if (qs == null || qs.contains("page")) {
                this.getCourseSections(req, resp);
            } else {
                this.getCourseSectionDetail(req, resp);
            }

        } catch (ServletException | IOException e) {
            resp.sendError(httpStatus.INTERNAL_SERVER_ERROR.getCode(), httpStatus.INTERNAL_SERVER_ERROR.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, Object> res = new HashMap<>();

        try {
            User user = AuthUtils.doAuthorize(req, resp, 2);
            int instructorId = user.getId();

            String courseIdStr = req.getParameter("courseId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String content = req.getParameter("content");
            String type = req.getParameter("type");
            String positionStr = req.getParameter("position");
            String status = req.getParameter("status");

            if (courseIdStr == null || courseIdStr.isBlank()
                    || title == null || title.isBlank()
                    || description == null || description.isBlank()
                    || content == null || content.isBlank()
                    || type == null || type.isBlank()
                    || positionStr == null || positionStr.isBlank()
                    || status == null || status.isBlank()) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "Vui lòng điền đầy đủ thông tin bắt buộc");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            int courseId = 0;
            int position = 0;
            try {
                courseId = Integer.parseInt(courseIdStr);
                position = Integer.parseInt(positionStr);
            } catch (NumberFormatException e) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "Dữ liệu không hợp lệ");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            if (!type.equals("text") && !type.equals("image") && !type.equals("video")) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "Loại bài học không hợp lệ");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            Course course = _courseService.getCourseById(courseId);
            if (course == null) {
                resp.setStatus(404);
                res.put("success", false);
                res.put("message", "Không tìm thấy khoá học");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            if (course.getCreated_by() != instructorId) {
                resp.setStatus(403);
                res.put("success", false);
                res.put("message", "Bạn không có quyền thêm bài học vào khoá học này");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            String mediaUrl = null;

            if (type.equals("image") || type.equals("video")) {
                Part mediaPart = req.getPart("media");

                if (mediaPart == null || mediaPart.getSize() == 0) {
                    resp.setStatus(400);
                    res.put("success", false);
                    res.put("message", "Vui lòng đính kèm " + (type.equals("image") ? "hình ảnh" : "video"));
                    ResponseUtils.sendJsonResponse(resp, res);
                    return;
                }

                try {
                    mediaUrl = FileUtils.saveFile(mediaPart, type, getServletContext());

                } catch (IllegalArgumentException e) {
                    resp.setStatus(400);
                    res.put("success", false);
                    res.put("message", "Lỗi file: " + e.getMessage());
                    ResponseUtils.sendJsonResponse(resp, res);
                    return;
                } catch (IOException e) {
                    resp.setStatus(500);
                    res.put("success", false);
                    res.put("message", "Không thể lưu file, vui lòng thử lại");
                    ResponseUtils.sendJsonResponse(resp, res);
                    return;
                }
            }

            CourseSection section = new CourseSection();
            section.setCourse_id(courseId);
            section.setTitle(title);
            section.setDescription(description);
            section.setContent(content);
            section.setType(type);
            section.setPosition(position);
            section.setStatus(status);
            section.setCreated_by(instructorId);
            section.setUpdated_by(instructorId);

            CourseSection createdSection = _courseSectionService.createSection(section);

            if (createdSection != null && createdSection.getId() > 0) {
                if (mediaUrl != null) {
                    try {
                        Media m = new Media();
                        m.setType("section");
                        m.setPath(mediaUrl);
                        m.setObjectId(createdSection.getId());

                        Media createdMedia = _mediaService.createMedia(m, instructorId);

                        if (createdMedia == null || createdMedia.getId() <= 0) {
                            System.err.println("Warning: Failed to create media record for section " + createdSection.getId());
                            // FileUtils.deleteFile(mediaUrl, getServletContext());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.err.println("Error creating media record: " + e.getMessage());
                    }
                }

                resp.setStatus(200);
                res.put("success", true);
                res.put("message", "Thêm bài học thành công!");
                res.put("data", Map.of(
                        "id", createdSection.getId(),
                        "title", createdSection.getTitle(),
                        "type", createdSection.getType(),
                        "mediaUrl", mediaUrl != null ? mediaUrl : ""
                ));
            } else {
                if (mediaUrl != null) {
                    FileUtils.deleteFile(mediaUrl, getServletContext());
                }

                resp.setStatus(500);
                res.put("success", false);
                res.put("message", "Không thể thêm bài học, vui lòng thử lại");
            }

        } catch (NumberFormatException e) {
            resp.setStatus(400);
            res.put("success", false);
            res.put("message", "Dữ liệu không hợp lệ");
        } catch (ServletException | IOException e) {
            e.printStackTrace();
            resp.setStatus(500);
            res.put("success", false);
            res.put("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        ResponseUtils.sendJsonResponse(resp, res);
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

        Map<String, Object> res = new HashMap<>();

        try {
            User user = AuthUtils.doAuthorize(req, resp, 2);
            int instructorId = user.getId();

            String sectionIdStr = req.getParameter("id");
            String courseIdStr = req.getParameter("courseId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String content = req.getParameter("content");
            String type = req.getParameter("type");
            String positionStr = req.getParameter("position");
            String status = req.getParameter("status");

            // Validate required fields
            if (sectionIdStr == null || sectionIdStr.isBlank()
                    || courseIdStr == null || courseIdStr.isBlank()
                    || title == null || title.isBlank()
                    || description == null || description.isBlank()
                    || content == null || content.isBlank()
                    || type == null || type.isBlank()
                    || positionStr == null || positionStr.isBlank()
                    || status == null || status.isBlank()) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "Vui lòng điền đầy đủ thông tin bắt buộc");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            int sectionId = 0;
            int courseId = 0;
            int position = 0;
            try {
                sectionId = Integer.parseInt(sectionIdStr);
                courseId = Integer.parseInt(courseIdStr);
                position = Integer.parseInt(positionStr);
            } catch (NumberFormatException e) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "Dữ liệu không hợp lệ");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            // Validate type
            if (!type.equals("text") && !type.equals("image") && !type.equals("video")) {
                resp.setStatus(400);
                res.put("success", false);
                res.put("message", "Loại bài học không hợp lệ");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            // Check if section exists
            CourseSection existingSection = _courseSectionService.getSectionById(sectionId);
            if (existingSection == null) {
                resp.setStatus(404);
                res.put("success", false);
                res.put("message", "Không tìm thấy bài học");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            // Check course ownership
            Course course = _courseService.getCourseById(courseId);
            if (course == null) {
                resp.setStatus(404);
                res.put("success", false);
                res.put("message", "Không tìm thấy khoá học");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            if (course.getCreated_by() != instructorId) {
                resp.setStatus(403);
                res.put("success", false);
                res.put("message", "Bạn không có quyền chỉnh sửa bài học này");
                ResponseUtils.sendJsonResponse(resp, res);
                return;
            }

            String mediaUrl = null;
            String currentMedia = req.getParameter("currentMedia");

            // Handle media upload for image/video types
            if (type.equals("image") || type.equals("video")) {
                Part mediaPart = req.getPart("media");

                // If new media file is uploaded
                if (mediaPart != null && mediaPart.getSize() > 0) {
                    try {
                        mediaUrl = FileUtils.saveFile(mediaPart, type, getServletContext());

                        // Delete old media if exists
                        Media oldMedia = _mediaService.getMediaByIdAndType("section", sectionId);
                        if (oldMedia != null && oldMedia.getPath() != null) {
                            FileUtils.deleteFile(oldMedia.getPath(), getServletContext());
                            _mediaService.deleteMedia(oldMedia.getId());
                        }

                    } catch (IllegalArgumentException e) {
                        resp.setStatus(400);
                        res.put("success", false);
                        res.put("message", "Lỗi file: " + e.getMessage());
                        ResponseUtils.sendJsonResponse(resp, res);
                        return;
                    } catch (IOException e) {
                        resp.setStatus(500);
                        res.put("success", false);
                        res.put("message", "Không thể lưu file, vui lòng thử lại");
                        ResponseUtils.sendJsonResponse(resp, res);
                        return;
                    }
                } else if (currentMedia != null && !currentMedia.isBlank()) {
                    mediaUrl = currentMedia;
                }
            } else {
                Media oldMedia = _mediaService.getMediaByIdAndType("section", sectionId);
                if (oldMedia != null) {
                    if (oldMedia.getPath() != null) {
                        FileUtils.deleteFile(oldMedia.getPath(), getServletContext());
                    }
                    _mediaService.deleteMedia(oldMedia.getId());
                }
            }

            CourseSection section = new CourseSection();
            section.setId(sectionId);
            section.setCourse_id(courseId);
            section.setTitle(title);
            section.setDescription(description);
            section.setContent(content);
            section.setType(type);
            section.setPosition(position);
            section.setStatus(status);
            section.setUpdated_by(instructorId);

            boolean isUpdated = _courseSectionService.updateSection(section);

            if (isUpdated) {
                if (mediaUrl != null && (type.equals("image") || type.equals("video"))) {
                    Media existingMedia = _mediaService.getMediaByIdAndType("section", sectionId);

                    if (existingMedia != null) {
                        existingMedia.setPath(mediaUrl);
                        _mediaService.updateMedia(existingMedia, instructorId);
                    } else {
                        Media m = new Media();
                        m.setType("section");
                        m.setPath(mediaUrl);
                        m.setObjectId(sectionId);

                        Media createdMedia = _mediaService.createMedia(m, instructorId);

                        if (createdMedia == null || createdMedia.getId() <= 0) {
                            System.err.println("Warning: Failed to create media record for section " + sectionId);
                        }
                    }
                }

                resp.setStatus(200);
                res.put("success", true);
                res.put("message", "Cập nhật bài học thành công!");
                res.put("data", Map.of(
                        "id", sectionId,
                        "title", title,
                        "type", type,
                        "mediaUrl", mediaUrl != null ? mediaUrl : ""
                ));
            } else {
                if (mediaUrl != null && !mediaUrl.equals(currentMedia)) {
                    FileUtils.deleteFile(mediaUrl, getServletContext());
                }

                resp.setStatus(500);
                res.put("success", false);
                res.put("message", "Không thể cập nhật bài học, vui lòng thử lại");
            }

        } catch (NumberFormatException e) {
            resp.setStatus(400);
            res.put("success", false);
            res.put("message", "Dữ liệu không hợp lệ");
        } catch (ServletException | IOException e) {
            e.printStackTrace();
            resp.setStatus(500);
            res.put("success", false);
            res.put("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        ResponseUtils.sendJsonResponse(resp, res);
    }

    protected void getCourseSectionDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Object> res = new HashMap<>();
        String courseSectionIdStr = req.getParameter("csid");

        if (courseSectionIdStr == null || courseSectionIdStr.isBlank()) {
            resp.sendError(httpStatus.BAD_REQUEST.getCode(), httpStatus.BAD_REQUEST.getMessage());
            return;
        }

        int courseSectionId = 0;

        try {
            courseSectionId = Integer.parseInt(courseSectionIdStr);
        } catch (NumberFormatException e) {
            resp.setStatus(400);
            res.put("success", false);
            res.put("message", "Thiếu id của section!");
            ResponseUtils.sendJsonResponse(resp, res);
            return;
        }

        CourseSection cs = _courseSectionService.getSectionById(courseSectionId);

        if (cs == null) {
            resp.setStatus(404);
            res.put("success", false);
            res.put("message", "Không tìm thấy bài học");
            ResponseUtils.sendJsonResponse(resp, res);
            return;
        } else {
            Media m = _mediaService.getMediaByIdAndType("section", courseSectionId);

            resp.setStatus(200);
            res.put("success", true);
            res.put("section", cs);
            res.put("media", m);
        }

        ResponseUtils.sendJsonResponse(resp, res);
    }

    protected void getCourseSections(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    }
}
