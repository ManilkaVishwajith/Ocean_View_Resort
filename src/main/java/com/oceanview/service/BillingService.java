package com.oceanview.service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BillingService {

    // දින ගණන ගණනය කිරීම (String -> Date -> Difference)
    public long calculateDays(String checkIn, String checkOut) {
        long days = 0;
        try {
            // String දිනයන් LocalDate බවට පත් කිරීම (Format: yyyy-MM-dd)
            LocalDate date1 = LocalDate.parse(checkIn);
            LocalDate date2 = LocalDate.parse(checkOut);

            // දින පරතරය ලබා ගැනීම
            days = ChronoUnit.DAYS.between(date1, date2);

            // දින ගණන 0 හෝ ඊට අඩු නම් (එකම දවසෙ check-out වුණොත්), අඩුම තරමේ දවස් 1ක් ලෙස සලකයි
            if (days <= 0) {
                days = 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return 1; // Error එකක් ආවොත් Default දවස් 1ක් ලෙස ගනී
        }
        return days;
    }

    // මුළු මුදල ගණනය කිරීම
    public double calculateTotal(double price, long days) {
        return price * days;
    }
}