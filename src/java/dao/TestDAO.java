/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Test;

public class TestDAO extends dao {

    // Lấy danh sách test theo instructor
    public List<Test> getTestsByInstructor(int instructorId) {
        List<Test> list = new ArrayList<>();
        String sql = "SELECT * FROM test WHERE created_by = ? ORDER BY id DESC";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, instructorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Test t = new Test();
                t.setId(rs.getInt("id"));
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));
                t.setCourseSectionId(rs.getInt("course_section_id"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy test theo ID
    public Test getById(int id) {
        String sql = "SELECT * FROM test WHERE id = ?";
        Test t = null;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                t = new Test();
                t.setId(id);
                t.setCode(rs.getString("code"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setTimeInterval(rs.getInt("time_interval"));
                t.setMinGrade(rs.getInt("min_grade"));
                t.setCourseId(rs.getInt("course_id"));
                t.setCourseSectionId(rs.getInt("course_section_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    public int createTest(Test t) {
        String sql = """
        INSERT INTO test 
        (code, title, description, time_interval, min_grade,
         course_id, course_section_id, created_by, updated_by)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, t.getCode());
            ps.setString(2, t.getTitle());
            ps.setString(3, t.getDescription());
            ps.setInt(4, t.getTimeInterval());
            ps.setInt(5, t.getMinGrade());
            ps.setInt(6, t.getCourseId());
            ps.setInt(7, t.getCourseSectionId());
            ps.setInt(8, t.getCreatedBy());
            ps.setInt(9, t.getUpdatedBy());

            ps.executeUpdate();
            rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    // Cập nhật bài test
    public boolean updateTest(Test t) {
        String sql = """
            UPDATE test 
            SET code=?, title=?, description=?, time_interval=?, min_grade=?, 
                course_id=?, course_section_id=?, updated_by=? 
            WHERE id=?
        """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, t.getCode());
            ps.setString(2, t.getTitle());
            ps.setString(3, t.getDescription());
            ps.setInt(4, t.getTimeInterval());
            ps.setInt(5, t.getMinGrade());
            ps.setInt(6, t.getCourseId());
            ps.setInt(7, t.getCourseSectionId());
            ps.setInt(8, t.getUpdatedBy());
            ps.setInt(9, t.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
