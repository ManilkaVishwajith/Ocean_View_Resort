package com.oceanview.factory;

import com.oceanview.service.ReservationService;

public class ServiceFactory {
    
    public static ReservationService getReservationService() {
        return new ReservationService();
    }
}