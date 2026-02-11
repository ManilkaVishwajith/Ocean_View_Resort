package com.oceanview.service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BillingService {

    // දින ගණන ගණනය කිරීම (String -> Date -> Days)
    public long calculateDays(String checkIn, String checkOut) {
        try {
            LocalDate start = LocalDate.parse(checkIn);
            LocalDate end = LocalDate.parse(checkOut);
            long days = ChronoUnit.DAYS.between(start, end);
            return (days > 0) ? days : 1; // දින 0 හෝ ඊට අඩු නම් 1ක් ලෙස ගනිමු
        } catch (Exception e) {
            e.printStackTrace();
            return 1; // Error එකක් ආවොත් Default දින 1යි
        }
    }

    // සම්පූර්ණ මුදල ගණනය කිරීම (10% Tax සහිතව)
    public double calculateTotal(double pricePerNight, long days) {
        double subTotal = pricePerNight * days;
        double tax = subTotal * 0.10; 
        return subTotal + tax;
    }
}