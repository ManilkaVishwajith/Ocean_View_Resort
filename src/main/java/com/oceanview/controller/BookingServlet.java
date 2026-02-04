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
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            double pricePerNight = Double.parseDouble(request.getParameter("price"));
            String checkInStr = request.getParameter("checkin");
            String checkOutStr = request.getParameter("checkout");

            
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userObj");
            
            if(user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            
            LocalDate inDate = LocalDate.parse(checkInStr);
            LocalDate outDate = LocalDate.parse(checkOutStr);
            long days = ChronoUnit.DAYS.between(inDate, outDate);
            
            if(days <= 0) {
                session.setAttribute("msg", "Invalid Date Selection!");
                response.sendRedirect("index.jsp");
                return;
            }

            // 4. (Total Price)
            double totalPrice = days * pricePerNight;

            // 5. Booking Object 
            Booking b = new Booking();
            b.setUserId(user.getId());
            b.setRoomId(roomId);
            b.setCheckIn(Date.valueOf(inDate));
            b.setCheckOut(Date.valueOf(outDate));
            b.setTotalPrice(totalPrice);
            b.setStatus("Pending");

            // 6. Database 
            BookingDAO dao = new BookingDAO();
            boolean f = dao.addBooking(b);

            if(f) {
                session.setAttribute("succMsg", "Booking Placed Successfully! Total: " + totalPrice);
                response.sendRedirect("index.jsp"); // හෝ Success page එකකට
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server");
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}