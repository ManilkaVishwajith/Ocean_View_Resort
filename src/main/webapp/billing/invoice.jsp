<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    // Servlet එකෙන් එවපු Object ලබා ගැනීම
    Reservation r = (Reservation) request.getAttribute("reservation");
    Long days = (Long) request.getAttribute("days");
    Double total = (Double) request.getAttribute("total");

    // දත්ත නැත්නම් ආපහු යවන්න
    if (r == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    // දින ගණන සහ මිල Null ද කියා පරීක්ෂා කිරීම
    long d = (days != null) ? days : 1;
    double t = (total != null) ? total : 0.0;
    double rate = 0;
    try {
        rate = Double.parseDouble(r.getRoomPrice());
    } catch(Exception e) {
        rate = 0;
    }
%>
