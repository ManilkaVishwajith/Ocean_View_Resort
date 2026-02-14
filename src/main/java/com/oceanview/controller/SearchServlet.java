package com.oceanview.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            // Search Form එකෙන් එන දත්ත ලබා ගැනීම
            String id = request.getParameter("resId");
            String name = request.getParameter("cusName");
            String date = request.getParameter("resDate");

            // Null values හැසිරවීම (Null නම් හිස් String එකක් යවමු)
            if(id == null) id = "";
            if(name == null) name = "";
            if(date == null) date = "";

            ReservationDAO dao = new ReservationDAO();
            List<Reservation> list = dao.searchReservations(id, name, date);

            request.setAttribute("searchList", list);
            request.getRequestDispatcher("/reservations/search.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}