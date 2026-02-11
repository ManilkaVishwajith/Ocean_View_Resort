package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    private static Connection con = null;

    public static Connection getConnection() {
        if (con == null) {
            try {
                Class.forName("com.mysql.jdbc.Driver"); // හෝ "com.mysql.cj.jdbc.Driver"
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ocean_view_db", "root", "1234");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return con;
    }
}