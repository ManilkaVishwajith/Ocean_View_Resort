<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User, com.oceanview.dao.RoomDAO, com.oceanview.model.Room, java.util.List" %>

<%
    User user = (User) session.getAttribute("userObj");
    RoomDAO dao = new RoomDAO();
    List<Room> rooms = dao.getAllRooms();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort 🌊</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .hero-section {
        background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?q=80&w=1600&auto=format&fit=crop');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 100px 0;
        text-align: center;
        margin-bottom: 50px;
    }
    .room-card { transition: transform 0.3s ease; }
    .room-card:hover { transform: translateY(-10px); }
    .room-img { height: 200px; object-fit: cover; }
    .price-tag { font-size: 1.2rem; font-weight: bold; color: #0d6efd; }
</style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="#">🌊 Ocean View Resort</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <div class="d-flex align-items-center">
            <% if(user != null) { %>
                <span class="navbar-text text-white me-3">Hi, <%= user.getUsername() %>!</span>
                
                <a href="../reservations/viewAll.jsp" class="btn btn-warning btn-sm me-2">My Bookings 📅</a>
                
                <% if("admin".equals(user.getRole())) { %>
                    <a href="../system/dashboard.jsp" class="btn btn-outline-info btn-sm me-2">Admin Panel</a>
                <% } %>
                
                <a href="../logout" class="btn btn-danger btn-sm">Logout</a>
            <% } else { %>
                <a href="../auth/login.jsp" class="btn btn-primary btn-sm me-2">Login</a>
                <a href="../auth/signup.jsp" class="btn btn-outline-light btn-sm">Sign Up</a>
            <% } %>
        </div>
    </div>
  </div>
</nav>

<div class="hero-section">
    <h1 class="display-3 fw-bold">Welcome to Paradise</h1>
    <p class="lead">Experience luxury and comfort like never before.</p>
</div>

<div class="container mb-5">
    <h2 class="text-center mb-5 text-uppercase fw-bold text-secondary">Our Premium Rooms</h2>
    <div class="row">
        <% if(rooms != null && !rooms.isEmpty()) { 
            for(Room r : rooms) { %>
            <div class="col-md-4 mb-4">
                <div class="card room-card h-100 shadow-sm">
                    <img src="../img/<%= r.getImageUrl() %>" class="card-img-top room-img" alt="Room"
                         onerror="this.src='https://source.unsplash.com/400x300/?hotel,room'">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= r.getRoomType() %></h5>
                        <p class="card-text">Room No: <%= r.getRoomNumber() %></p>
                        <p class="price-tag">LKR <%= r.getPrice() %> / Night</p>
                        <div class="mt-auto">
                            <% if(user != null) { %>
                                <a href="../reservations/add.jsp?id=<%= r.getId() %>" class="btn btn-primary w-100">Book Now 🏨</a>
                            <% } else { %>
                                <a href="../auth/login.jsp" class="btn btn-outline-primary w-100">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        <% } } else { %>
            <div class="alert alert-warning text-center w-100">No rooms available.</div>
        <% } %>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p class="mb-0">&copy; 2026 Ocean View Resort. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>