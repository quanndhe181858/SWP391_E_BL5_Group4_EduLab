/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author quan
 */
public class CategoryDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        System.out.println(dao.getChildCategoryIds(3));
    }

    public List<Category> getCategories() {
        List<Category> cList = new ArrayList<>();
        String sql = "SELECT * FROM category";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setParent_id(rs.getInt("parent_id"));

                cList.add(c);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        } finally {
            this.closeResources();
        }

        return cList;
    }

    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM category WHERE id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            if (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setParent_id(rs.getInt("parent_id"));
                return c;
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        } finally {
            this.closeResources();
        }

        return null;
    }

    public int countCategories() {
        String sql = "SELECT COUNT(*) AS total FROM category";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return 0;
        } finally {
            this.closeResources();
        }

        return 0;
    }

    public List<Integer> getChildCategoryIds(int parentId) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT id FROM category WHERE parent_id = ?";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, parentId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int childId = rs.getInt("id");
                ids.add(childId);
            }
        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }

        return ids;
    }

    public List<Category> searchCategories(String keyword) {
        List<Category> list = new ArrayList<>();

        String sql = """
        SELECT *
        FROM category
        WHERE name LIKE ?
        ORDER BY id DESC
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setParent_id(rs.getInt("parent_id"));
                list.add(c);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error searchCategories()", e);
        } finally {
            this.closeResources();
        }

        return list;
    }

    public boolean createCategory(Category category) {
        String sql = "INSERT INTO category (name, description, parent_id) VALUES (?, ?, ?)";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getParent_id());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error createCategory()", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean updateCategory(Category category) {
        String sql = "UPDATE category SET name = ?, description = ?, parent_id = ? WHERE id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getParent_id());
            ps.setInt(4, category.getId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error updateCategory()", e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean deleteCategory(int categoryId) {
        // Kiểm tra xem có khóa học nào phụ thuộc không
        String checkSql = "SELECT COUNT(*) FROM course WHERE category_id = ?";
        String deleteSql = "DELETE FROM category WHERE id = ?";

        try {
            con = dbc.getConnection();

            // Kiểm tra khóa học phụ thuộc
            ps = con.prepareStatement(checkSql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Có khóa học phụ thuộc, không thể xóa
                return false;
            }

            // Xóa category
            ps = con.prepareStatement(deleteSql);
            ps.setInt(1, categoryId);
            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, "Error deleteCategory()", e);
            return false;
        } finally {
            this.closeResources();
        }
    }
}
