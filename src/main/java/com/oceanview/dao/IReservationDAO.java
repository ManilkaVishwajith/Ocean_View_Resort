package com.oceanview.dao;

import java.util.List;

import com.oceanview.model.Reservation;

public interface IReservationDAO {
    // මේ methods 3 අනිවාර්යයෙන්ම තියෙන්න ඕනේ
    public boolean addReservation(Reservation r);
    public Reservation getReservationById(int id);
    public List<Reservation> getAllReservations();
}