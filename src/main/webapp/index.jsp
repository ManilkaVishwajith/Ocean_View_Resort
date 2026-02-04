<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User, com.oceanview.dao.RoomDAO, com.oceanview.model.Room, java.util.List" %>

<%
    User user = (User) session.getAttribute("userObj");
    
    // Database එකෙන් කාමර ටික ලබා ගැනීම
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
    /* Hero Section Styling */
    .hero-section {
        background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://source.unsplash.com/1600x900/?beach,resort');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 100px 0;
        text-align: center;
        margin-bottom: 50px;
    }
    
    /* Card Hover Effect */
    .room-card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: none;
        overflow: hidden;
    }
    .room-card:hover {
        transform: translateY(-10px); /* උඩට පාවෙනවා වගේ පේන්න */
        box-shadow: 0 10px 20px rgba(0,0,0,0.2);
    }
    .room-img {
        height: 200px;
        object-fit: cover;
    }
    .price-tag {
        font-size: 1.2rem;
        font-weight: bold;
        color: #0d6efd;
    }
</style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="#">🌊 Ocean View Resort</a>
    <div class="d-flex">
        <% if(user != null) { %>
            <span class="navbar-text text-white me-3">Hi, <%= user.getUsername() %>!</span>
            <% if("admin".equals(user.getRole())) { %>
                <a href="admin-dashboard.jsp" class="btn btn-outline-info btn-sm me-2">Admin Panel</a>
            <% } %>
            <a href="logout" class="btn btn-danger btn-sm">Logout</a>
        <% } else { %>
            <a href="login.jsp" class="btn btn-primary btn-sm me-2">Login</a>
            <a href="signup.jsp" class="btn btn-outline-light btn-sm">Sign Up</a>
        <% } %>
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
        <% 
        if(!rooms.isEmpty()) { 
            for(Room r : rooms) { 
        %>
            <div class="col-md-4 mb-4">
                <div class="card room-card h-100">
                    <img src="img/<%= r.getImageUrl() %>" class="card-img-top room-img" alt="<%= r.getRoomType() %>" 
                         onerror="this.src='https://source.unsplash.com/400x300/?hotel,room'"> <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h5 class="card-title mb-0"><%= r.getRoomType() %></h5>
                            <span class="badge bg-success"><%= r.getStatus() %></span>
                        </div>
                        <p class="card-text text-muted">Room No: <%= r.getRoomNumber() %></p>
                        <p class="price-tag">LKR <%= r.getPrice() %> / Night</p>
                        
                        <div class="mt-auto">
                            <% if(user != null) { %>
                                <a href="#" class="btn btn-primary w-100">Book Now 🏨</a>
                            <% } else { %>
                                <a href="login.jsp" class="btn btn-outline-primary w-100">Login to Book</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        <% 
            } 
        } else { 
        %>
            <div class="col-12 text-center">
                <div class="alert alert-warning">No rooms available at the moment. Please check back later!</div>
            </div>
        <% } %>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <p class="mb-0">&copy; 2026 Ocean View Resort. All Rights Reserved.</p>
</footer>

</body>
</html>