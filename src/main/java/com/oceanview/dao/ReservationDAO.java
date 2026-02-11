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
    public boolean addReservation(Reservation r) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "INSERT INTO reservation(customer_name, room_type, check_in, check_out, price, email) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomType());
            ps.setString(3, r.getCheckIn());
            ps.setString(4, r.getCheckOut());
            ps.setString(5, r.getRoomPrice());
            ps.setString(6, r.getEmail());

            int i = ps.executeUpdate();
            if (i > 0) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public Reservation getReservationById(int id) {
        Reservation r = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM reservation WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()) {
                r = new Reservation();
                r.setId(rs.getInt(1));
                r.setCustomerName(rs.getString(2));
                r.setRoomType(rs.getString(3));
                r.setCheckIn(rs.getString(4));
                r.setCheckOut(rs.getString(5));
                r.setRoomPrice(rs.getString(6));
                r.setEmail(rs.getString(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    @Override
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM reservation";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt(1));
                r.setCustomerName(rs.getString(2));
                r.setRoomType(rs.getString(3));
                r.setCheckIn(rs.getString(4));
                r.setCheckOut(rs.getString(5));
                r.setRoomPrice(rs.getString(6));
                r.setEmail(rs.getString(7));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}