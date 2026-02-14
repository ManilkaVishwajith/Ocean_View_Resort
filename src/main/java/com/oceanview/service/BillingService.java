package com.oceanview.service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BillingService {
    // දින ගණන ගණනය කිරීම
    public long calculateDays(String checkIn, String checkOut) {
        try {
            LocalDate d1 = LocalDate.parse(checkIn);
            LocalDate d2 = LocalDate.parse(checkOut);
            long days = ChronoUnit.DAYS.between(d1, d2);
            return (days <= 0) ? 1 : days; // අවම දින 1ක් ලෙස ගනී
        } catch (Exception e) {
            return 1;
        }
    }

    // මුළු මුදල ගණනය කිරීම (Price * Days)
    public double calculateTotal(double price, long days) {
        return price * days;
    }
}