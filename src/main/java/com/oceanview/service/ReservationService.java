package com.oceanview.service;

import java.util.List;

import com.oceanview.dao.IReservationDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

public class ReservationService {
    
    // Interface එක හරහා DAO එකට සම්බන්ධ වීම (Best Practice)
    private IReservationDAO reservationDAO;

    public ReservationService() {
        // Implementation එක මෙතැනදී ලබා දෙනවා
        this.reservationDAO = new ReservationDAO();
    }

    // Reservation එකක් සාදන Method එක
    public boolean makeReservation(Reservation reservation) {
        return reservationDAO.addReservation(reservation);
    }

    // Admin සඳහා සියලුම Reservations ලබා ගැනීම
    public List<Reservation> getAllReservationsForAdmin() {
        return reservationDAO.getAllReservations();
    }
    
    // ID එක මගින් Reservation එකක් ලබා ගැනීම
    public Reservation getReservationById(int id) {
        return reservationDAO.getReservationById(id);
    }
}