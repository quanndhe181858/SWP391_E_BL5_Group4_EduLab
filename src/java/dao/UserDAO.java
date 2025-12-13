/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Role;
import model.User;

/**
 *
 * @author hoanghao
 */
public class UserDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        User u = new User("test", "test", "test@gmail.com", "test");
        System.out.println(dao.doRegister(u));
    }

    public User getAuthUser(String email, String password) {
        User u = null;
        String sql = """
                     SELECT * FROM user WHERE email = ? AND hash_password = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setId(rs.getInt("id"));
                u.setUuid(rs.getString("uuid"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(email);
                u.setBod(rs.getDate("bod"));
                u.setStatus(rs.getString("status"));
                u.setRole_id(rs.getInt("role_id"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }

        return u;
    }

    public User getUserById(int userId) {
        User u = null;
        String sql = """
                     SELECT * FROM user WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setId(rs.getInt("id"));
                u.setUuid(rs.getString("uuid"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setBod(rs.getDate("bod"));
                u.setStatus(rs.getString("status"));
                u.setRole_id(rs.getInt("role_id"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }

        return u;
    }

    public User getAuthUserByEmail(String email) {
        User u = null;
        String sql = """
                     SELECT * FROM user WHERE email = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);

            rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setId(rs.getInt("id"));
                u.setUuid(rs.getString("uuid"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(email);
                u.setBod(rs.getDate("bod"));
                u.setStatus(rs.getString("status"));
                u.setRole_id(rs.getInt("role_id"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }

        return u;
    }

    public boolean isEmailExisted(String email) {
        String sql = """
                     SELECT COUNT(*) FROM user WHERE email = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

            return false;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

    public boolean doRegister(User user) {
        String sql = """
                     INSERT INTO `edulab`.`user`
                     (`first_name`,
                     `last_name`,
                     `email`,
                     `hash_password`,
                     `status`,
                     `role_id`)
                     VALUES
                     (?, ?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, user.getFirst_name());
            ps.setString(2, user.getLast_name());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getHash_password());
            ps.setString(5, "Active");
            ps.setInt(6, 3);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

    public boolean updateUserInfo(String firstName, String lastName, LocalDate bod, int userId) {
        String sql = """
                 UPDATE user
                 SET
                     first_name = ?,
                     last_name = ?
                 """;

        if (bod != null) {
            sql += ", bod = ?";
        }

        sql += " WHERE id = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            int index = 1;

            ps.setString(index++, firstName);
            ps.setString(index++, lastName);

            if (bod != null) {
                ps.setDate(index++, Date.valueOf(bod));
            }

            ps.setInt(index, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

    public boolean updatePassword(String newPassword, int userId) {
        String sql = """
                     UPDATE user
                     SET
                     hash_password = ?
                     WHERE id = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }
    
    public boolean changeUserStatus(int userId, String status) {
        String sql = """
                UPDATE user 
                SET status = ?, updated_at = NOW()
                WHERE id = ?;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }
    
    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM role ORDER BY id;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("id"));
                role.setName(rs.getString("name"));
                role.setDescription(rs.getString("description"));
                roles.add(role);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        }

        return roles;
    }
    
    public List<User> getUsersByRole(int roleId) {
        List<User> users = new ArrayList<>();
        String sql = """
                SELECT u.*, r.name as role_name, r.description as role_description
                FROM user u
                LEFT JOIN role r ON u.role_id = r.id
                WHERE u.role_id = ?
                ORDER BY u.created_at DESC;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, roleId);
            rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUuid(rs.getString("uuid"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setBod(rs.getDate("bod"));
                u.setStatus(rs.getString("status"));
                u.setRole_id(rs.getInt("role_id"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));

                // Set role information
                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                role.setName(rs.getString("role_name"));
                role.setDescription(rs.getString("role_description"));
                u.setRole(role);

                users.add(u);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        }

        return users;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = """
                SELECT u.*, r.name as role_name, r.description as role_description
                FROM user u
                LEFT JOIN role r ON u.role_id = r.id
                ORDER BY u.created_at DESC;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUuid(rs.getString("uuid"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setBod(rs.getDate("bod"));
                u.setStatus(rs.getString("status"));
                u.setRole_id(rs.getInt("role_id"));
                u.setCreated_at(rs.getTimestamp("created_at"));
                u.setUpdated_at(rs.getTimestamp("updated_at"));

                // Set role information
                Role role = new Role();
                role.setId(rs.getInt("role_id"));
                role.setName(rs.getString("role_name"));
                role.setDescription(rs.getString("role_description"));
                u.setRole(role);

                users.add(u);
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
        }

        return users;
    }
    
    public boolean updateUser(User user) {
        String sql = """
                UPDATE user 
                SET first_name = ?, last_name = ?, email = ?, bod = ?, role_id = ?, updated_at = NOW()
                WHERE id = ?;
                """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, user.getFirst_name());
            ps.setString(2, user.getLast_name());
            ps.setString(3, user.getEmail());
            ps.setDate(4, user.getBod());
            ps.setInt(5, user.getRole_id());
            ps.setInt(6, user.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        }
    }

}
