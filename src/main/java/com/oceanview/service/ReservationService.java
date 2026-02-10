package com.oceanview.service;

import java.util.List;
import com.oceanview.dao.IReservationDAO; // මේක import වෙන්න ඕනේ
import com.oceanview.dao.ReservationDAO;  // මේකත් import වෙන්න ඕනේ
import com.oceanview.model.Reservation;

public class ReservationService {
    
    private IReservationDAO reservationDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
    }

    public boolean makeReservation(Reservation reservation) {
        return reservationDAO.addReservation(reservation);
    }

    public List<Reservation> getUserReservations(int userId) {
        return reservationDAO.getReservationsByUserId(userId);
    }

    public List<Reservation> getAllReservationsForAdmin() {
        return reservationDAO.getAllReservations();
    }
}