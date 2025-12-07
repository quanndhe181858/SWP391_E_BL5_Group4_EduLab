/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Media;

/**
 *
 * @author quan
 */
public class MediaDAO extends dao {

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public static void main(String[] args) {
        MediaDAO dao = new MediaDAO();
//        Media m = new Media();
//        m.setType("section");
//        m.setPath("test");
//        m.setObjectId(1);
//        System.out.println(dao.createMedia(m, 1));
        System.out.println(dao.getMediaByIdAndType("section", 176));
    }

    public Media createMedia(Media m, int uid) {
        String sql = """
                     INSERT INTO `edulab`.`media`
                     (`objectId`,
                     `type`,
                     `mime_type`,
                     `path`,
                     `created_by`)
                     VALUES
                     (?, ?, ?, ?, ?);
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, m.getObjectId());
            ps.setString(2, m.getType());
            ps.setString(3, m.getMime_type());
            ps.setString(4, m.getPath());
            ps.setInt(5, m.getCreated_by());

            int row = ps.executeUpdate();
            if (row > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    m.setId(rs.getInt(1));
                }
                return m;
            }

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        } finally {
            this.closeResources();
        }

        return null;
    }

    public Media getMediaByIdAndType(String type, int objectid) {
        Media m = null;
        String sql = """
                     SELECT * FROM media WHERE type = ? AND objectid = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, type);
            ps.setInt(2, objectid);

            rs = ps.executeQuery();

            if (rs.next()) {
                m = new Media();
                m.setId(rs.getInt("id"));
                m.setObjectId(rs.getInt("objectid"));
                m.setType(rs.getString("type"));
                m.setMime_type(rs.getString("mime_type"));
                m.setPath(rs.getString("path"));
                m.setCreated_at(rs.getTimestamp("created_at"));
                m.setCreated_by(rs.getInt("created_by"));
            }

            return m;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return null;
        } finally {
            this.closeResources();
        }
    }

    public boolean deleteMedia(int id) {
        String sql = "DELETE FROM `edulab`.`media` WHERE id = ?;";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        } finally {
            this.closeResources();
        }
    }

    public boolean updateMedia(Media m) {
        String sql = """
                     UPDATE `edulab`.`media`
                     SET
                     `type` = ?,
                     `mime_type` = ?,
                     `path` = ?
                     WHERE `id` = ?;
                     """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, m.getType());
            ps.setString(2, m.getMime_type());
            ps.setString(3, m.getPath());
            ps.setInt(4, m.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            this.log(Level.SEVERE, e.getMessage(), e);
            return false;
        } finally {
            this.closeResources();
        }
    }
}
