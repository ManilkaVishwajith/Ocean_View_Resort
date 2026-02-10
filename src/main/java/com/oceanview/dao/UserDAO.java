package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.User;
import com.oceanview.util.DBConnect;

public class UserDAO {
    
   
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
 
    public boolean registerUser(User user) {
        boolean isSuccess = false;
        
        try {
            Connection con = DBConnect.getConnection();

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
 // 1. Admin සඳහා සියලුම Users ලා ලබා ගැනීම
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        User u = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM user ORDER BY id DESC"; // Table name එක හරියටම බලන්න
            PreparedStatement ps = con.prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                u = new User();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4)); 
                u.setRole(rs.getString(5));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. User කෙනෙක් ඉවත් කිරීම (Delete)
    public boolean deleteUser(int id) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "DELETE FROM user WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            int i = ps.executeUpdate();
            if(i > 0) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}