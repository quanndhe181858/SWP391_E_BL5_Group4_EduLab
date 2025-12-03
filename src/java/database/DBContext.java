/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.util.ResourceBundle;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;

/**
 *
 * @author quan
 */
public class DBContext {

    ResourceBundle bundle = ResourceBundle.getBundle("configuration.database");

    public Connection getConnection() {
        try {
            Class.forName(bundle.getString("drivername"));
            String url = bundle.getString("url");
            String username = bundle.getString("username");
            String password = bundle.getString("password");
            Connection connection = DriverManager.getConnection(url, username, password);
            return connection;
        } catch (ClassNotFoundException e) {
            String msg = "ClassNotFoundException throw from method getConnection()";
            System.err.println(e);
        } catch (SQLException e) {
            String msg = "SQLException throw from method getConnection()";
            System.err.println(e);
        } catch (Exception e) {
            String msg = "Unexpected Exception throw from method getConnection()";
            System.err.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.getConnection() != null) {
            System.out.println("Ok!");
        } else {
            System.err.println("Not Ok!");
        }
    }

}
