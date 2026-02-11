package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.User;
import com.oceanview.util.DBConnect;

public class UserDAO {

    // 1. සියලුම Users ලබා ගැනීම (manageUsers.jsp සඳහා)
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM user"; // Table name එක 'user' විය යුතුයි
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
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

    // 2. අලුත් User කෙනෙක් එකතු කිරීම (Sign Up / Add User සඳහා)
    public boolean addUser(User u) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "INSERT INTO user(username, email, password, role) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRole()); // Default role එකක් එවන්න ඕනේ

            int i = ps.executeUpdate();
            if (i > 0) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    // 3. Login පරීක්ෂා කිරීම (LoginServlet සඳහා)
    public User login(String username, String password) {
        User u = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM user WHERE username=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                u = new User();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setRole(rs.getString(5));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    // 4. User කෙනෙක් Delete කිරීම (Delete Button සඳහා)
    public boolean deleteUser(int id) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "DELETE FROM user WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            if (i > 0) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
 // 5. ID එක මගින් User කෙනෙක් ලබා ගැනීම (Edit Page එකට)
    public User getUserById(int id) {
        User u = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM user WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                u = new User();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setRole(rs.getString(5));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return u;
    }

    // 6. User විස්තර යාවත්කාලීන කිරීම (Update Button එකට)
    public boolean updateUser(User u) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "UPDATE user SET username=?, email=?, password=?, role=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRole());
            ps.setInt(5, u.getId());

            int i = ps.executeUpdate();
            if(i > 0) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }
}