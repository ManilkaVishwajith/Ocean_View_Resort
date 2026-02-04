package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
}