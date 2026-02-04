<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.dao.BookingDAO, com.oceanview.dao.RoomDAO, com.oceanview.model.Booking, com.oceanview.model.Room, com.oceanview.model.User, java.util.List" %>

<%
    User user = (User) session.getAttribute("userObj");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    BookingDAO dao = new BookingDAO();
    List<Booking> list = dao.getBookingsByUserId(user.getId());
    RoomDAO roomDao = new RoomDAO();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Bookings - Ocean View Resort</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary mb-4">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">🌊 Ocean View Resort</a>
    <a href="index.jsp" class="btn btn-outline-light btn-sm">Back to Home</a>
  </div>
</nav>

<div class="container">
    <div class="card shadow">
        <div class="card-header bg-white">
            <h4 class="text-primary">My Booking History 📅</h4>
        </div>
        <div class="card-body">
            <% if(list.isEmpty()) { %>
                <div class="alert alert-warning text-center">You haven't booked any rooms yet! <a href="index.jsp">Book Now</a></div>
            <% } else { %>
            
            <table class="table table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Booking ID</th>
                        <th>Room Type</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Total Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Booking b : list) { 
                        Room r = roomDao.getRoomById(b.getRoomId());
                    %>
                    <tr>
                        <td>#<%= b.getId() %></td>
                        <td>
                            <% if(r != null) { %>
                                <img src="img/<%= r.getImageUrl() %>" width="50" height="40" class="rounded me-2" style="object-fit:cover">
                                <%= r.getRoomType() %>
                            <% } else { %>
                                Unknown Room
                            <% } %>
                        </td>
                        <td><%= b.getCheckIn() %></td>
                        <td><%= b.getCheckOut() %></td>
                        <td class="fw-bold text-success">LKR <%= b.getTotalPrice() %></td>
                        <td><span class="badge bg-success">Confirmed</span></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>