/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizTestDAO extends dao {

    public void addQuizToTest(int testId, int quizId) {
        String sql = "INSERT INTO quiz_test (quiz_id, test_id) VALUES (?, ?)";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            ps.setInt(2, testId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteQuizByTest(int testId) {
        String sql = "DELETE FROM quiz_test WHERE test_id = ?";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, testId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Integer> getQuizIdsByTest(int testId) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT quiz_id FROM quiz_test WHERE test_id = ?";

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, testId);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("quiz_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
