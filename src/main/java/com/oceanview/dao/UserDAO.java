package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.oceanview.model.User;
import com.oceanview.util.DBConnect;

public class UserDAO {
    
    // Login පරීක්ෂා කිරීම
    public User checkLogin(String username, String password) {
        User user = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role")); 
                user.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user; 
    }
 
    // 🔴 නම වෙනස් කළා: registerUser -> addUser
    // දැන් RegisterServlet එකේ error එක හරියනවා.
    public boolean addUser(User user) {
        boolean isSuccess = false;
        try {
            Connection con = DBConnect.getConnection();
            // DB එකේ column names හරියටම බලන්න (id auto increment නම් අවුලක් නෑ)
            String sql = "INSERT INTO users (username, password, role, email) VALUES (?, ?, ?, ?)";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getEmail());
            
            int i = ps.executeUpdate(); 
            
            if (i > 0) {
                isSuccess = true; 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}