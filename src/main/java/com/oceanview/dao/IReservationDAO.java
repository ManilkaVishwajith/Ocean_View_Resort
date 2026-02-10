package com.oceanview.dao;

import java.util.List;
import com.oceanview.model.Reservation;

public interface IReservationDAO {
    boolean addReservation(Reservation reservation);
    List<Reservation> getReservationsByUserId(int userId);
    List<Reservation> getAllReservations();
}