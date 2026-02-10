package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnect;

public class ReservationDAO implements IReservationDAO {

    @Override
    public boolean addReservation(Reservation r) { // addBooking නෙවෙයි addReservation
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "INSERT INTO bookings(user_id, room_id, check_in, check_out, total_price, status) VALUES(?,?,?,?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getRoomId());
            ps.setDate(3, r.getCheckIn());
            ps.setDate(4, r.getCheckOut());
            ps.setDouble(5, r.getTotalPrice());
            ps.setString(6, r.getStatus());
            
            int i = ps.executeUpdate();
            if(i > 0) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public List<Reservation> getReservationsByUserId(int userId) { // Name changed here
        List<Reservation> list = new ArrayList<>();
        Reservation r = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM bookings WHERE user_id=? ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                r = new Reservation();
                r.setId(rs.getInt(1));
                r.setUserId(rs.getInt(2));
                r.setRoomId(rs.getInt(3));
                r.setCheckIn(rs.getDate(4));
                r.setCheckOut(rs.getDate(5));
                r.setTotalPrice(rs.getDouble(6));
                r.setStatus(rs.getString(7));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Reservation> getAllReservations() { // Name changed here
        List<Reservation> list = new ArrayList<>();
        Reservation r = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM bookings ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                r = new Reservation();
                r.setId(rs.getInt(1));
                r.setUserId(rs.getInt(2));
                r.setRoomId(rs.getInt(3));
                r.setCheckIn(rs.getDate(4));
                r.setCheckOut(rs.getDate(5));
                r.setTotalPrice(rs.getDouble(6));
                r.setStatus(rs.getString(7));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}