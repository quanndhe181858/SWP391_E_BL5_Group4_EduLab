/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.SQLException;
import model.Course;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author quan
 */
public class CourseDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());
    private final CategoryDAO categoryDao = new CategoryDAO();

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        CourseDAO dao = new CourseDAO();

//        Course c = new Course();
//        c.setTitle("Java Web Development");
//        c.setDescription("Learn MVC, Servlet, JDBC");
//        c.setStatus("active");
//        c.setCategory_id(2);
//
//        Course created = dao.createCourse(c, 1); // uid = 1 (creator)
//        System.out.println("Created Course:");
//        System.out.println(created);
//
//        Course found = dao.getCourseById(created.getId());
//        System.out.println("Found Course:");
//        System.out.println(found);
//
//        found.setTitle("Updated Java Web Development");
//        found.setStatus("inactive");
//
//        Course updated = dao.updateCourse(found, 1); // uid = 1 (updater)
//        System.out.println("Updated Course:");
//        System.out.println(updated);
//
//        boolean deleted = dao.deleteCourse(updated.getId());
//        System.out.println("Deleted? " + deleted);
//        System.out.println(dao.getCoursesByInstructorId(10, 0, "", "", 0, "", "", 1));
//        System.out.println(dao.countCourses("", "", 0, ""));
//        System.out.println(dao.getCoursesByInstructorId(10, 0, "", "", 0, "", "", 1).size());
//        System.out.println(dao.countCoursesByInstructorId(1, "active"));
        System.out.println(dao.getCourseCatalog(1000, 0, "", "", 0).size());
    }

    public Course createCourse(Course course, int uid) {
        String sql = """
                 INSERT INTO `edulab`.`course`
                 (`title`,
                 `description`,
                 `category_id`,
                 `status`,
                 `created_by`,
                 `thumbnail`)
                 VALUES
                 (?, ?, ?, ?, ?, ?);
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getCategory_id());
            ps.setString(4, course.getStatus());
            ps.setInt(5, uid);
            ps.setString(6, course.getThumbnail());

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                course.setId(generatedId);
            }

            return course;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while createCourse() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    public boolean updateCourse(Course course, int uid) {
        String sql = """
                 UPDATE `edulab`.`course`
                 SET 
                     `title` = ?, 
                     `description` = ?, 
                     `category_id` = ?, 
                     `status` = ?, 
                     `thumbnail` = ?,
                     `updated_by` = ?
                 WHERE `id` = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getCategory_id());
            ps.setString(4, course.getStatus());
            ps.setString(5, course.getThumbnail());
            ps.setInt(6, uid);
            ps.setInt(7, course.getId());

            int rows = ps.executeUpdate();

            if (rows == 0) {
                return false;
            }

            return true;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while updateCourse() execute!", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean deleteCourse(int id) {
        String sql = """
                 DELETE FROM `edulab`.`course`
                 WHERE `id` = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while deleteCourse() execute!", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public Course getCourseById(int id) {
        String sql = """
                 SELECT 
                     *
                 FROM edulab.course
                 WHERE id = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                Course course = new Course();

                course.setId(rs.getInt("id"));
                course.setUuid(rs.getString("uuid"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setStatus(rs.getString("status"));

                course.setCategory_id(rs.getInt("category_id"));
                // load category object if you have categoryDAO
                // course.setCategory(categoryDAO.getCategoryById(course.getCategory_id()));

                course.setCreated_at(rs.getTimestamp("created_at"));
                course.setUpdated_at(rs.getTimestamp("updated_at"));
                course.setCreated_by(rs.getInt("created_by"));
                course.setUpdated_by(rs.getInt("updated_by"));
                course.setThumbnail(rs.getString("thumbnail"));

                return course;
            }

            return null;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while getCourseById() execute!", e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    public boolean isExist(int id) {
        String sql = """
                 SELECT 
                     COUNT(*)
                 FROM edulab.course
                 WHERE id = ?;
                 """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                int i = rs.getInt(1);
                if (i > 0) {
                    return true;
                }
            }

            return false;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while isExist() execute!", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean isValid(Course c) {
        String sql = "SELECT COUNT(*) AS total FROM edulab.course WHERE title = ? AND category_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getTitle());
            ps.setInt(2, c.getCategory_id());

            rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("total");
                return count == 0;
            }

            return false;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Something wrong while isValid()", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public List<Course> getAllCourses(int limit, int offset, String title, String description,
            int categoryId, String status, String sortBy) {
        List<Course> cList = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM edulab.course WHERE 1 = 1"
        );

        List<Object> params = new ArrayList<>();

        StringBuilder orGroup = new StringBuilder();

        if (title != null && !title.isEmpty()) {
            orGroup.append(" OR title LIKE ?");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isEmpty()) {
            orGroup.append(" OR description LIKE ?");
            params.add("%" + description + "%");
        }

        if (categoryId > 0) {

            List<Integer> allCategoryIds = new ArrayList<>();
            allCategoryIds.add(categoryId);
            allCategoryIds.addAll(categoryDao.getChildCategoryIds(categoryId));

            StringBuilder inClause = new StringBuilder(" AND category_id IN (");
            for (int i = 0; i < allCategoryIds.size(); i++) {
                inClause.append("?");
                if (i < allCategoryIds.size() - 1) {
                    inClause.append(",");
                }
                params.add(allCategoryIds.get(i));
            }
            inClause.append(")");

            orGroup.append(inClause);
        }

        if (status != null && !status.isEmpty()) {
            orGroup.append(" AND status = ?");
            params.add(status);
        }

        if (orGroup.length() > 0) {
            sql.append(" AND (");
            sql.append(orGroup.substring(4));
            sql.append(")");
        }

        if (sortBy != null && !sortBy.isBlank()) {
            sql.append(" ORDER BY ").append(sortBy);
        } else {
            sql.append(" ORDER BY id DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;
            for (Object p : params) {
                ps.setObject(index++, p);
            }

            ps.setInt(index++, limit);
            ps.setInt(index, offset);

            rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setUuid(rs.getString("uuid"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setCategory_id(rs.getInt("category_id"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUpdated_at(rs.getTimestamp("updated_at"));
                c.setCreated_by(rs.getInt("created_by"));
                c.setUpdated_by(rs.getInt("updated_by"));
                cList.add(c);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in getCoursesByInstructorId()", e);
        } finally {
            this.closeResources();
        }

        return cList;
    }

    public List<Course> getCoursesByInstructorId(int limit, int offset, String title, String description,
            int categoryId, String status, String sortBy, int instructorId) {

        List<Course> cList = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM edulab.course WHERE created_by = ?"
        );
        params.add(instructorId);

        StringBuilder orSearch = new StringBuilder();

        if (title != null && !title.isBlank()) {
            orSearch.append(" title LIKE ? OR");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isBlank()) {
            orSearch.append(" description LIKE ? OR");
            params.add("%" + description + "%");
        }

        if (orSearch.length() > 0) {
            sql.append(" AND (");
            sql.append(orSearch.substring(0, orSearch.length() - 2)); // remove last OR
            sql.append(")");
        }

        if (categoryId > 0) {

            List<Integer> allCategoryIds = new ArrayList<>();
            allCategoryIds.add(categoryId);

            List<Integer> children = categoryDao.getChildCategoryIds(categoryId);
            if (children != null && !children.isEmpty()) {
                allCategoryIds.addAll(children);
            }

            sql.append(" AND category_id IN (");
            for (int i = 0; i < allCategoryIds.size(); i++) {
                sql.append("?");
                if (i < allCategoryIds.size() - 1) {
                    sql.append(",");
                }
                params.add(allCategoryIds.get(i));
            }
            sql.append(")");
        }

        if (status != null && !status.isBlank() && !status.equalsIgnoreCase("all")) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        if (sortBy != null && !sortBy.isBlank()) {
            sql.append(" ORDER BY ").append(sortBy);
        } else {
            sql.append(" ORDER BY id DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int idx = 1;
            for (Object p : params) {
                ps.setObject(idx++, p);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setUuid(rs.getString("uuid"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setCategory_id(rs.getInt("category_id"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUpdated_at(rs.getTimestamp("updated_at"));
                c.setCreated_by(rs.getInt("created_by"));
                c.setUpdated_by(rs.getInt("updated_by"));
                c.setThumbnail(rs.getString("thumbnail"));
                cList.add(c);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in getCoursesByInstructorId()", e);
        } finally {
            this.closeResources();
        }

        return cList;
    }

    public int countCourses(String title, String description,
            int categoryId, String status) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM edulab.course"
        );

        List<Object> params = new ArrayList<>();

        StringBuilder orGroup = new StringBuilder();

        if (title != null && !title.isEmpty()) {
            orGroup.append(" OR title LIKE ?");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isEmpty()) {
            orGroup.append(" OR description LIKE ?");
            params.add("%" + description + "%");
        }

        if (categoryId > 0) {

            List<Integer> allCategoryIds = new ArrayList<>();
            allCategoryIds.add(categoryId);
            allCategoryIds.addAll(categoryDao.getChildCategoryIds(categoryId));

            StringBuilder inClause = new StringBuilder(" AND category_id IN (");
            for (int i = 0; i < allCategoryIds.size(); i++) {
                inClause.append("?");
                if (i < allCategoryIds.size() - 1) {
                    inClause.append(",");
                }
                params.add(allCategoryIds.get(i));
            }
            inClause.append(")");

            orGroup.append(inClause);
        }

        if (status != null && !status.isEmpty()) {
            orGroup.append(" AND status = ?");
            params.add(status);
        }

        if (orGroup.length() > 0) {
            sql.append(" AND (");
            sql.append(orGroup.substring(4));
            sql.append(")");
        }

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;
            for (Object p : params) {
                ps.setObject(index++, p);
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in countCoursesByInstructorId()", e);
        } finally {
            this.closeResources();
        }

        return 0;
    }

    public int countCoursesByInstructorIdWithFilter(String title, String description,
            int categoryId, String status, int instructorId) {

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM edulab.course WHERE created_by = ?"
        );

        List<Object> params = new ArrayList<>();
        params.add(instructorId);

        StringBuilder orSearch = new StringBuilder();

        if (title != null && !title.isBlank()) {
            orSearch.append(" title LIKE ? OR");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isBlank()) {
            orSearch.append(" description LIKE ? OR");
            params.add("%" + description + "%");
        }

        if (orSearch.length() > 0) {
            sql.append(" AND (");
            sql.append(orSearch.substring(0, orSearch.length() - 2));
            sql.append(")");
        }

        if (categoryId > 0) {

            List<Integer> allCategoryIds = new ArrayList<>();
            allCategoryIds.add(categoryId);

            List<Integer> children = categoryDao.getChildCategoryIds(categoryId);
            if (children != null && !children.isEmpty()) {
                allCategoryIds.addAll(children);
            }

            sql.append(" AND category_id IN (");
            for (int i = 0; i < allCategoryIds.size(); i++) {
                sql.append("?");
                if (i < allCategoryIds.size() - 1) {
                    sql.append(",");
                }
                params.add(allCategoryIds.get(i));
            }
            sql.append(")");
        }

        if (status != null && !status.isBlank() && !status.equalsIgnoreCase("all")) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;
            for (Object p : params) {
                ps.setObject(index++, p);
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in countCoursesByInstructorId()", e);
        } finally {
            this.closeResources();
        }

        return 0;
    }

    public int countCoursesByInstructorId(int instructorId, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM edulab.course WHERE created_by = ?");

        if (status != null && !status.isBlank()) {
            if (status.equalsIgnoreCase("Active") || status.equalsIgnoreCase("Inactive")) {
                sql.append(" AND status = ?");
            }
        }

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;

            ps.setInt(index++, instructorId);

            if (status != null && !status.isBlank()) {
                if (status.equalsIgnoreCase("Active") || status.equalsIgnoreCase("Inactive")) {
                    ps.setString(index++, status);
                }
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in countCoursesByInstructorId()", e);
        } finally {
            this.closeResources();
        }

        return 0;
    }

    public List<Course> getCourseCatalog(int limit, int offset, String title, String description,
            int categoryId) {
        List<Course> cList = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM edulab.course WHERE status = 'Active'"
        );

        StringBuilder orSearch = new StringBuilder();

        if (title != null && !title.isBlank()) {
            orSearch.append(" title LIKE ? OR");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isBlank()) {
            orSearch.append(" description LIKE ? OR");
            params.add("%" + description + "%");
        }

        if (orSearch.length() > 0) {
            sql.append(" AND (");
            sql.append(orSearch.substring(0, orSearch.length() - 2)); // remove last OR
            sql.append(")");
        }

        if (categoryId > 0) {
            List<Integer> allCategoryIds = new ArrayList<>();
            allCategoryIds.add(categoryId);

            List<Integer> children = categoryDao.getChildCategoryIds(categoryId);
            if (children != null && !children.isEmpty()) {
                allCategoryIds.addAll(children);
            }

            sql.append(" AND category_id IN (");
            for (int i = 0; i < allCategoryIds.size(); i++) {
                sql.append("?");
                if (i < allCategoryIds.size() - 1) {
                    sql.append(",");
                }
                params.add(allCategoryIds.get(i));
            }
            sql.append(")");
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int idx = 1;
            for (Object p : params) {
                ps.setObject(idx++, p);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                Course c = new Course();
                c.setId(rs.getInt("id"));
                c.setUuid(rs.getString("uuid"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setCategory_id(rs.getInt("category_id"));
                c.setCreated_at(rs.getTimestamp("created_at"));
                c.setUpdated_at(rs.getTimestamp("updated_at"));
                c.setCreated_by(rs.getInt("created_by"));
                c.setUpdated_by(rs.getInt("updated_by"));
                c.setThumbnail(rs.getString("thumbnail"));
                cList.add(c);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error in getCoursesByInstructorId()", e);
        } finally {
            this.closeResources();
        }

        return cList;
    }

    public int countCoursesCatalog(String title, String description,
            int categoryId) {

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM edulab.course WHERE status = 'Active'"
        );

        List<Object> params = new ArrayList<>();

        StringBuilder orSearch = new StringBuilder();

        if (title != null && !title.isBlank()) {
            orSearch.append(" title LIKE ? OR");
            params.add("%" + title + "%");
        }

        if (description != null && !description.isBlank()) {
            orSearch.append(" description LIKE ? OR");
            params.add("%" + description + "%");
        }

        if (orSearch.length() > 0) {
            sql.append(" AND (");
            sql.append(orSearch.substring(0, orSearch.length() - 2));
            sql.append(")");
        }

        if (categoryId > 0) {

            List<Integer> allCategoryIds = new ArrayList<>();
            allCategoryIds.add(categoryId);

            List<Integer> children = categoryDao.getChildCategoryIds(categoryId);
            if (children != null && !children.isEmpty()) {
                allCategoryIds.addAll(children);
            }

            sql.append(" AND category_id IN (");
            for (int i = 0; i < allCategoryIds.size(); i++) {
                sql.append("?");
                if (i < allCategoryIds.size() - 1) {
                    sql.append(",");
                }
                params.add(allCategoryIds.get(i));
            }
            sql.append(")");
        }

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql.toString());

            int index = 1;
            for (Object p : params) {
                ps.setObject(index++, p);
            }

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            this.closeResources();
        }

        return 0;
    }
}
