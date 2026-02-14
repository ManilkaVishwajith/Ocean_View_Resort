<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User" %>
<%@ page import="com.oceanview.dao.RoomDAO" %>
<%@ page import="com.oceanview.model.Room" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort | Paradise Found</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        * { font-family: 'Poppins', sans-serif; scroll-behavior: smooth; }
        
        body, html { margin: 0; overflow-x: hidden; }

        /* 🔹 Navbar */
        .navbar {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(15px);
            padding: 15px 0;
            transition: 0.3s;
        }
        .navbar-brand { font-weight: 700; font-size: 1.8rem; color: #ffd700 !important; }
        .nav-link { color: white !important; font-weight: 500; margin-left: 15px; }
        .nav-link:hover { color: #ffd700 !important; }

        /* 🔹 Hero Section */
        .hero-section {
            height: 100vh;
            background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .hero-overlay {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.3), rgba(0,0,0,0.7));
        }
        .hero-content {
            position: relative; z-index: 2; color: white;
            animation: fadeIn 1.5s ease;
        }
        .hero-title { font-size: 4rem; font-weight: 700; text-shadow: 2px 2px 10px rgba(0,0,0,0.8); }
        .hero-subtitle { font-size: 1.5rem; color: #f8f9fa; margin-bottom: 30px; letter-spacing: 2px; }

        /* 🔹 Buttons */
        .btn-gold {
            background: linear-gradient(45deg, #ffd700, #ffb700);
            color: black; padding: 12px 40px; border-radius: 50px;
            font-weight: 700; border: none; transition: 0.3s;
        }
        .btn-gold:hover { transform: scale(1.05); box-shadow: 0 0 20px rgba(255, 215, 0, 0.7); color: black; }

        /* 🔹 Rooms Section */
        .section-title { font-weight: 700; color: #002850; text-align: center; margin-bottom: 50px; text-transform: uppercase; }
        .room-card {
            border: none; border-radius: 20px; overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: 0.3s; background: white;
        }
        .room-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.2); }
        .room-img { height: 250px; object-fit: cover; width: 100%; }
        .room-body { padding: 25px; text-align: center; }
        .price-tag { color: #d4af37; font-size: 1.4rem; font-weight: 700; }

        /* 🔹 Facilities Section */
        .facilities { background: #f8f9fa; padding: 80px 0; }
        .facility-box {
            background: white; padding: 30px; border-radius: 20px;
            text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: 0.3s;
        }
        .facility-box:hover { transform: translateY(-5px); border-bottom: 4px solid #ffd700; }
        .facility-icon { font-size: 3rem; color: #002850; margin-bottom: 20px; }

        /* 🔹 Footer */
        .footer { background: #001f3f; color: white; padding: 50px 0 20px; text-align: center; }
        .social-icons a { color: white; font-size: 1.5rem; margin: 0 10px; transition: 0.3s; }
        .social-icons a:hover { color: #ffd700; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-umbrella-beach me-2"></i>OCEAN VIEW</a>
            <button class="navbar-toggler bg-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#rooms">Rooms</a></li>
                    <li class="nav-item"><a class="nav-link" href="#facilities">Facilities</a></li>
                    
                    <% 
                        User user = (User) session.getAttribute("userObj");
                        if(user == null) { 
                    %>
                        <li class="nav-item ms-3"><a href="auth/login.jsp" class="btn btn-outline-light rounded-pill px-4">Login</a></li>
                    <% } else { %>
                        <li class="nav-item ms-3 text-warning fw-bold">Hi, <%= user.getUsername() %></li>
                        <li class="nav-item ms-2"><a href="logout" class="btn btn-danger btn-sm rounded-pill px-3">Logout</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <div id="home" class="hero-section">
        <div class="hero-overlay"></div>
        <div class="container hero-content">
            <h5 class="text-warning text-uppercase letter-spacing-2">Welcome to Paradise</h5>
            <h1 class="hero-title">OCEAN VIEW RESORT</h1>
            <p class="hero-subtitle">Experience luxury, comfort, and the soothing sound of the ocean.</p>
            <a href="#rooms" class="btn btn-gold shadow-lg mt-3">Book Your Stay <i class="fas fa-arrow-right ms-2"></i></a>
        </div>
    </div>

    <div id="rooms" class="container py-5 mt-5">
        <h2 class="section-title">Our Premium Rooms</h2>
        <div class="row g-4">
            <% 
                RoomDAO dao = new RoomDAO();
                List<Room> rooms = dao.getAllRooms();
                
                if(rooms.isEmpty()) { 
            %>
                <div class="col-12 text-center">
                    <p class="text-muted">No rooms available at the moment. Please check back later.</p>
                </div>
          <% } else {
    for(Room r : rooms) { %>
    <div class="col-md-4">
        <div class="room-card">
            <img src="${pageContext.request.contextPath}/img/<%= r.getImageUrl() %>" class="room-img" alt="Room Image">
            
            <div class="room-body">
                <h4><%= r.getRoomType() %></h4>
                
                <p class="text-muted small">
                    <i class="fas fa-door-open me-1"></i>No: <%= r.getRoomNumber() %> | 
                    <span class="badge bg-success"><%= r.getStatus() %></span>
                </p>
                
                <p class="price-tag">LKR <%= r.getPrice() %></p>
                
                <% if(user != null) { %>
                    <a href="${pageContext.request.contextPath}/reservations/add.jsp?type=<%= r.getRoomType() %>" class="btn btn-gold w-100 rounded-pill">Book Now</a>
                <% } else { %>
                    <a href="auth/login.jsp" class="btn btn-outline-dark w-100 rounded-pill">Login to Book</a>
                <% } %>
            </div>
        </div>
    </div>
<% }} %>
        </div>
    </div>

    <div id="facilities" class="facilities">
        <div class="container">
            <h2 class="section-title">World Class Facilities</h2>
            <div class="row g-4">
                <div class="col-md-3 col-6">
                    <div class="facility-box">
                        <i class="fas fa-swimming-pool facility-icon"></i>
                        <h5>Infinity Pool</h5>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="facility-box">
                        <i class="fas fa-wifi facility-icon"></i>
                        <h5>High-Speed WiFi</h5>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="facility-box">
                        <i class="fas fa-utensils facility-icon"></i>
                        <h5>Restaurant</h5>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="facility-box">
                        <i class="fas fa-spa facility-icon"></i>
                        <h5>Luxury Spa</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <h3 class="fw-bold text-warning">OCEAN VIEW</h3>
            <p class="mb-4 text-white-50">Your dream destination by the sea.</p>
            <div class="social-icons mb-4">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
            <hr class="border-secondary">
            <p class="small mb-0">&copy; 2026 Ocean View Resort. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>