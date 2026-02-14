package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.Room;
import com.oceanview.util.DBConnect;

public class RoomDAO {

    // 1. සියලුම කාමර ලබා ගැනීම (Get All Rooms)
    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        Room r = null;

        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM rooms";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                r = new Room();
                // Column Names භාවිතා කිරීම (වඩාත් ආරක්ෂිතයි)
                r.setId(rs.getInt("id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setRoomType(rs.getString("room_type"));
                r.setPrice(rs.getDouble("price"));
                r.setStatus(rs.getString("status"));
                r.setImageUrl(rs.getString("image_url"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    } 

    // 2. ID එක අනුව කාමරයක් ලබා ගැනීම (Get Room By ID)
    public Room getRoomById(int id) {
        Room r = null;
        try {
            Connection con = DBConnect.getConnection();
            String sql = "SELECT * FROM rooms WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Room();
                // මෙතැනත් Column Names භාවිතා කරන්න
                r.setId(rs.getInt("id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setRoomType(rs.getString("room_type"));
                r.setPrice(rs.getDouble("price"));
                r.setStatus(rs.getString("status"));
                r.setImageUrl(rs.getString("image_url"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }
}