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

@WebServlet("/reservation/add")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            // 1. Form Data ලබා ගැනීම
            String customerName = request.getParameter("customerName");
            String email = request.getParameter("email");
            String roomType = request.getParameter("roomType");
            String roomPrice = request.getParameter("roomPrice"); 
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");

            // 2. Reservation Object සැකසීම
            // (දැන් Model එකේ Setters තියෙන නිසා රතු ඉරි එන්නේ නෑ)
            Reservation r = new Reservation();
            r.setCustomerName(customerName);
            r.setEmail(email);
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
                // සාර්ථක නම් My Bookings පිටුවට
                response.sendRedirect(request.getContextPath() + "/my-bookings.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong! Please try again.");
                // අසාර්ථක නම් Home Page එකට
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}