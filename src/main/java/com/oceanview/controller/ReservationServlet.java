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
            // 1. Form එකෙන් එන Data ලබා ගැනීම (add.jsp එකේ name වලට සමාන විය යුතුයි)
            String customerName = request.getParameter("customerName");
            String roomType = request.getParameter("roomType");
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");
            String roomPrice = request.getParameter("roomPrice");
            String email = request.getParameter("email");

            // 2. Reservation Object එකක් සාදා Data ඇතුළත් කිරීම
            Reservation r = new Reservation();
            r.setCustomerName(customerName);
            r.setRoomType(roomType);
            r.setCheckIn(checkIn);
            r.setCheckOut(checkOut);
            r.setRoomPrice(roomPrice);
            r.setEmail(email);

            // 3. Database එකට යැවීම
            ReservationDAO dao = new ReservationDAO();
            boolean f = dao.addReservation(r);

            HttpSession session = request.getSession();

            if(f) {
                // සාර්ථක නම් View All පිටුවට යවන්න (reservations ෆෝල්ඩර් එක ඇතුළේ)
                session.setAttribute("succMsg", "Booking Placed Successfully!");
                response.sendRedirect("../reservations/viewAll.jsp");
            } else {
                // අසාර්ථක නම් ආපහු Add Page එකට
                session.setAttribute("failedMsg", "Something went wrong on server!");
                response.sendRedirect("../reservations/add.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../errors/500.jsp");
        }
    }
}