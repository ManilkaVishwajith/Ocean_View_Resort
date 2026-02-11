package com.oceanview.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.service.BillingService;

@WebServlet("/billing/generate")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ID එක ලබා ගැනීම (URL එකෙන් ?id=1 වගේ එන අගය)
            String idParam = request.getParameter("id");
            
            if(idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                
                ReservationDAO dao = new ReservationDAO();
                Reservation r = dao.getReservationById(id);
                
                if(r != null) {
                    // ගණනය කිරීම්
                    BillingService service = new BillingService();
                    long days = service.calculateDays(r.getCheckIn(), r.getCheckOut());
                    
                    // Price එක Text එකක් නිසා Double වලට හැරවීම
                    double price = 0;
                    try {
                        price = Double.parseDouble(r.getRoomPrice());
                    } catch (Exception e) {
                         price = 0; // Price එක වැරදි නම් 0
                    }

                    double total = service.calculateTotal(price, days);
                    
                    // Invoice පිටුවට දත්ත යැවීම
                    request.setAttribute("reservation", r);
                    request.setAttribute("days", days);
                    request.setAttribute("total", total);
                    
                    // invoice.jsp තියෙන්නේ webapp/billing/ ෆෝල්ඩර් එකේ නම්:
                    request.getRequestDispatcher("invoice.jsp").forward(request, response);
                } else {
                    response.sendRedirect("../reservations/viewAll.jsp");
                }
            } else {
                response.sendRedirect("../reservations/viewAll.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("../errors/500.jsp");
        }
    }
}