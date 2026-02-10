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

import com.oceanview.factory.ServiceFactory;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;
import com.oceanview.service.ReservationService;

// URL එකත් අපි වෙනස් කළා reservation කියලා
@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            // 1. User Log වෙලාද බලනවා
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userObj");
            
            if(user == null) {
                response.sendRedirect("auth/login.jsp"); // ෆෝල්ඩර් මාරු කළ නිසා Path එක වෙනස් වුණා
                return;
            }
            
            // 2. Form එකෙන් දත්ත ගන්නවා
            int userId = user.getId();
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            double pricePerNight = Double.parseDouble(request.getParameter("price"));
            
            String checkInStr = request.getParameter("checkin");
            String checkOutStr = request.getParameter("checkout");
            
            Date checkIn = Date.valueOf(checkInStr);
            Date checkOut = Date.valueOf(checkOutStr);
            
            // 3. දින ගණන සහ මුළු මුදල ගණනය කිරීම
            LocalDate d1 = LocalDate.parse(checkInStr);
            LocalDate d2 = LocalDate.parse(checkOutStr);
            
            long days = ChronoUnit.DAYS.between(d1, d2);
            
            if(days <= 0) {
                session.setAttribute("failedMsg", "Invalid Dates! Check-out must be after Check-in.");
                response.sendRedirect("reservations/add.jsp?id=" + roomId);
                return;
            }
            
            double totalPrice = days * pricePerNight;
            
            // 4. Reservation Object එක හදනවා (Model)
            Reservation r = new Reservation();
            r.setUserId(userId);
            r.setRoomId(roomId);
            r.setCheckIn(checkIn);
            r.setCheckOut(checkOut);
            r.setTotalPrice(totalPrice);
            r.setStatus("Pending");
            
            // 5. Service Factory හරහා Service එක අරගෙන Data යවනවා (Professional Way) 🏭
            ReservationService service = ServiceFactory.getReservationService();
            boolean f = service.makeReservation(r);
            
            if(f) {
                session.setAttribute("succMsg", "Reservation Placed Successfully! Bill: LKR " + totalPrice);
                response.sendRedirect("reservations/viewAll.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server!");
                response.sendRedirect("reservations/add.jsp?id=" + roomId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}