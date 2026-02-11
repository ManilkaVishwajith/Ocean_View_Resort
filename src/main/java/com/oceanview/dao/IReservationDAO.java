package com.oceanview.dao;

import java.util.List;
import com.oceanview.model.Reservation; 

public interface IReservationDAO {
    // Reservation එකක් අලුතෙන් දැමීම
    public boolean addReservation(Reservation r);
    
    // ID එක මගින් Reservation එකක් සොයා ගැනීම
    public Reservation getReservationById(int id);
    
    // සියලුම Reservations ලබා ගැනීම
    public List<Reservation> getAllReservations();
}