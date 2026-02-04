package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.Booking;
import com.oceanview.util.DBConnect;

public class BookingDAO {

    
    public boolean addBooking(Booking b) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "INSERT INTO bookings(user_id, room_id, check_in, check_out, total_price, status) VALUES(?,?,?,?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getRoomId());
            ps.setDate(3, b.getCheckIn());
            ps.setDate(4, b.getCheckOut());
            ps.setDouble(5, b.getTotalPrice());
            ps.setString(6, b.getStatus());
            
            int i = ps.executeUpdate();
            if(i > 0) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

   
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        Booking b = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM bookings WHERE user_id=? ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                b = new Booking();
                b.setId(rs.getInt(1));
                b.setUserId(rs.getInt(2));
                b.setRoomId(rs.getInt(3));
                b.setCheckIn(rs.getDate(4));
                b.setCheckOut(rs.getDate(5));
                b.setTotalPrice(rs.getDouble(6));
                b.setStatus(rs.getString(7));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}