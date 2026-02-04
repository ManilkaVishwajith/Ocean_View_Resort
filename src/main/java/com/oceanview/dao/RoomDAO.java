package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.oceanview.model.Room;
import com.oceanview.util.DBConnect;

public class RoomDAO {

    
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
                r.setId(rs.getInt(1));
                r.setRoomNumber(rs.getString(2));
                r.setRoomType(rs.getString(3));
                r.setPrice(rs.getDouble(4));
                r.setStatus(rs.getString(5));
                r.setImageUrl(rs.getString(6));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}