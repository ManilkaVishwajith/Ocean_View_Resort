package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    // Database URL, Username, Password
    private static String url = "jdbc:mysql://localhost:3306/ocean_view_db";
    private static String user = "root";
    private static String pass = "12345"; 

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            System.out.println("Database Connection Failed!");
            e.printStackTrace();
        }
        return con;
    }
}