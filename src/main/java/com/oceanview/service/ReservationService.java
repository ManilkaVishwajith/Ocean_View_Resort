package com.oceanview.service;

import java.util.List;
import com.oceanview.dao.IReservationDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

public class ReservationService {
    
    private IReservationDAO reservationDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
    }

    public boolean makeReservation(Reservation reservation) {
        return reservationDAO.addReservation(reservation);
    }

    public List<Reservation> getAllReservationsForAdmin() {
        return reservationDAO.getAllReservations();
    }
    
    public Reservation getReservationById(int id) {
        return reservationDAO.getReservationById(id);
    }
}