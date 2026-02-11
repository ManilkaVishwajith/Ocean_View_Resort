package com.oceanview.dao;

import java.util.List;
import com.oceanview.model.Reservation; // මේක අනිවාර්යයි

public interface IReservationDAO {
    public boolean addReservation(Reservation r);
    public Reservation getReservationById(int id);
    public List<Reservation> getAllReservations();
}