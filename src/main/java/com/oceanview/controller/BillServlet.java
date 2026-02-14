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

/**
 * Servlet implementation class BillServlet
 * URL Mapping: /billing/generate
 */
@WebServlet("/billing/generate")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. URL එකෙන් එවන Reservation ID එක ලබා ගැනීම
            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);

                // 2. DAO එක හරහා දත්ත ලබා ගැනීම
                ReservationDAO dao = new ReservationDAO();
                Reservation r = dao.getReservationById(id);

                if (r != null) {
                    // 3. Billing Logic ක්‍රියාත්මක කිරීම
                    BillingService service = new BillingService();
                    
                    // දින ගණන ගණනය කිරීම (Service එකේ calculateDays method එක අවශ්‍යයි)
                    long days = service.calculateDays(r.getCheckIn(), r.getCheckOut());
                    
                    // දින ගණන 0 වුණොත් අවම වශයෙන් 1 ලෙස ගනිමු
                    if (days <= 0) days = 1;

                    // මිල Double වලට හැරවීම (Error safe parsing)
                    double price = 0;
                    try {
                        price = Double.parseDouble(r.getRoomPrice());
                    } catch (Exception e) {
                        price = 0.0;
                    }

                    // මුළු එකතුව (Total = Price * Days)
                    double total = service.calculateTotal(price, days);

                    // 4. Invoice JSP එකට අවශ්‍ය attributes set කිරීම
                    request.setAttribute("reservation", r);
                    request.setAttribute("days", days);
                    request.setAttribute("total", total);

                    // 5. Invoice පිටුවට යොමු කිරීම
                    request.getRequestDispatcher("/billing/invoice.jsp").forward(request, response);

                } else {
                    // දත්ත නැත්නම් Redirect කිරීම
                    response.sendRedirect(request.getContextPath() + "/reservations/my-bookings.jsp");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/reservations/my-bookings.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Error එකක් ආවොත් ප්‍රධාන පිටුවට යවන්න
            response.sendRedirect(request.getContextPath() + "/home/index.jsp");
        }
    }
}