package com.oceanview.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oceanview.dao.BookingDAO;
import com.oceanview.model.Booking;
import com.oceanview.model.User;

@WebServlet("/book-room")
public class BookingServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            // 1. Check if user is logged in
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userObj");
            
            if(user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // 2. Get data from the form
            int userId = user.getId();
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            double pricePerNight = Double.parseDouble(request.getParameter("price"));
            
            String checkInStr = request.getParameter("checkin");
            String checkOutStr = request.getParameter("checkout");
            
            Date checkIn = Date.valueOf(checkInStr);
            Date checkOut = Date.valueOf(checkOutStr);
            
            // 3. Calculate Days and Total Bill (Requirement 4)
            LocalDate d1 = LocalDate.parse(checkInStr);
            LocalDate d2 = LocalDate.parse(checkOutStr);
            
            long days = ChronoUnit.DAYS.between(d1, d2);
            
            if(days <= 0) {
                session.setAttribute("failedMsg", "Invalid Date Selection! Check-out must be after Check-in.");
                response.sendRedirect("booking.jsp?id=" + roomId);
                return;
            }
            
            double totalPrice = days * pricePerNight;
            
            // 4. Set data to Booking Object
            Booking b = new Booking();
            b.setUserId(userId);
            b.setRoomId(roomId);
            b.setCheckIn(checkIn);
            b.setCheckOut(checkOut);
            b.setTotalPrice(totalPrice);
            b.setStatus("Pending"); // Default status
            
            // 5. Save to Database using DAO
            BookingDAO dao = new BookingDAO();
            boolean f = dao.addBooking(b);
            
            if(f) {
                // Booking Success - Redirect to My Bookings with a success message
                session.setAttribute("succMsg", "Booking Placed Successfully! Total Bill: LKR " + totalPrice);
                response.sendRedirect("my-bookings.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server!");
                response.sendRedirect("booking.jsp?id=" + roomId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}