package com.oceanview.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

@WebServlet("/ReservationServlet") // JSP එකේ Action එකට ගැලපෙන ලෙස වෙනස් කළා
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            // 1. add.jsp එකෙන් එවන Form Data ලබා ගැනීම
            String customerName = request.getParameter("customerName");
            String nic = request.getParameter("nic");
            String contactNo = request.getParameter("contactNo");
            String roomType = request.getParameter("roomType");
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");
            String noOfGuests = request.getParameter("noOfGuests");

            // Room Type එක අනුව මිල ස්වයංක්‍රීයව තීරණය කිරීම
            String roomPrice = "0";
            if ("Single".equals(roomType)) roomPrice = "5000";
            else if ("Double".equals(roomType)) roomPrice = "8500";
            else if ("Luxury Suite".equals(roomType)) roomPrice = "15000";

            // 2. Reservation Object එකට දත්ත ඇතුළත් කිරීම
            Reservation r = new Reservation();
            r.setCustomerName(customerName);
            // Model එකේ මේ අලුත් Fields (NIC, Contact) තියෙනවාදැයි බලන්න
            r.setEmail(nic); // දැනට email field එක NIC එක තියාගන්න පාවිච්චි කරමු
            r.setRoomType(roomType);
            r.setRoomPrice(roomPrice);
            r.setCheckIn(checkIn);
            r.setCheckOut(checkOut);

            // 3. Database එකට යැවීම
            ReservationDAO dao = new ReservationDAO();
            boolean isSuccess = dao.addReservation(r);

            HttpSession session = request.getSession();

            if(isSuccess) {
                session.setAttribute("succMsg", "Booking Placed Successfully!");
                response.sendRedirect(request.getContextPath() + "/reservations/my-bookings.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong!");
                response.sendRedirect(request.getContextPath() + "/reservations/add.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home/index.jsp");
        }
    }
}