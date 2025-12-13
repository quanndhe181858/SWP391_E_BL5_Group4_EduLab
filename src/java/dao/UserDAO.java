/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        System.out.println(dao.getAuthUser("instructor@gmail.com", "ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413"));
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
}
