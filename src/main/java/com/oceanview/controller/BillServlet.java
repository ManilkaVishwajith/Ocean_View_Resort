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
            // 1. ID එක ලබා ගැනීම
            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);

                ReservationDAO dao = new ReservationDAO();
                Reservation r = dao.getReservationById(id);

                if (r != null) {
                    // 2. දින ගණන සහ මුළු මුදල ගණනය කිරීම
                    BillingService service = new BillingService();
                    
                    // දින ගණන (Dates String නිසා Service එක ඇතුලේ Parse කරන්න ඕනේ)
                    long days = service.calculateDays(r.getCheckIn(), r.getCheckOut());

                    // කාමරයේ මිල Double වලට හැරවීම
                    double price = 0;
                    try {
                        price = Double.parseDouble(r.getRoomPrice());
                    } catch (NumberFormatException e) {
                        price = 0; // මිල වැරදි නම් 0 ලෙස ගනී
                    }

                    // මුළු එකතුව (Total = Price * Days)
                    double total = service.calculateTotal(price, days);

                    // 3. Invoice JSP එකට දත්ත යැවීම
                    request.setAttribute("reservation", r);
                    request.setAttribute("days", days);
                    request.setAttribute("total", total);

                    // වැදගත්: සම්පූර්ණ Path එක දෙන්න (/billing/invoice.jsp)
                    request.getRequestDispatcher("/billing/invoice.jsp").forward(request, response);

                } else {
                    // Reservation එක හොයාගන්න බැරි නම්
                    response.sendRedirect(request.getContextPath() + "/my-bookings.jsp");
                }
            } else {
                // ID එකක් ඇවිත් නැත්නම්
                response.sendRedirect(request.getContextPath() + "/my-bookings.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Error එකක් ආවොත් Home Page එකට හෝ Error Page එකට යවන්න
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}