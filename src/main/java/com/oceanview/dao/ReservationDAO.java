package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnect;

public class ReservationDAO implements IReservationDAO {

    // 1. වෙන්කිරීමක් එකතු කිරීම
    @Override
    public boolean addReservation(Reservation r) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            // Table නම 'reservations' ලෙස සහ Column names database එකට ගැලපෙන ලෙස නිවැරදි කළා
            String sql = "INSERT INTO reservations(customer_name, room_type, check_in, check_out, room_price, email) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomType());
            ps.setString(3, r.getCheckIn());
            ps.setString(4, r.getCheckOut());
            ps.setString(5, r.getRoomPrice()); 
            ps.setString(6, r.getEmail());

            int i = ps.executeUpdate();
            if (i > 0) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // 2. ID එක අනුව දත්ත ලබා ගැනීම (Edit/Invoice සඳහා)
    @Override
    public Reservation getReservationById(int id) {
        Reservation r = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM reservations WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));
                r.setRoomPrice(rs.getString("room_price")); // Column name එක database එකට ගැලපෙන ලෙස වෙනස් කළා
                r.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    // 3. සියලුම දත්ත ලබා ගැනීම (View All සඳහා)
    @Override
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM reservations ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));
                r.setRoomPrice(rs.getString("room_price"));
                r.setEmail(rs.getString("email"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. දත්ත යාවත්කාලීන කිරීම (Update සඳහා)
    public boolean updateReservation(Reservation r) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "UPDATE reservations SET customer_name=?, room_type=?, check_in=?, check_out=?, room_price=?, email=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomType());
            ps.setString(3, r.getCheckIn());
            ps.setString(4, r.getCheckOut());
            ps.setString(5, r.getRoomPrice());
            ps.setString(6, r.getEmail());
            ps.setInt(7, r.getId());

            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }

    // 5. දත්ත මැකීම (Delete සඳහා)
    public boolean deleteReservation(int id) {
        boolean f = false;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "DELETE FROM reservations WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            if (i == 1) f = true;
        } catch (Exception e) { e.printStackTrace(); }
        return f;
    }
    public List<Reservation> searchReservations(String id, String name, String date) {
        List<Reservation> list = new ArrayList<>();
        try {
            Connection con = DBConnect.getConnection();
            // Dynamic SQL based on user input
            String sql = "SELECT * FROM reservations WHERE (id=? OR ?='') AND (customer_name LIKE ? OR ?='') AND (check_in=? OR ?='')";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, id); ps.setString(2, id);
            ps.setString(3, "%" + name + "%"); ps.setString(4, name);
            ps.setString(5, date); ps.setString(6, date);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomerName(rs.getString("customer_name"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getString("check_in"));
                r.setCheckOut(rs.getString("check_out"));
                r.setRoomPrice(rs.getString("room_price"));
                list.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}