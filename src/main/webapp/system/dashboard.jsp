<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.oceanview.dao.ReservationDAO, com.oceanview.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
            background-color: #f4f6f9;
        }

        /* පසුබිම (Fixed Background) */
        .bg-image {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: url('../img/double.jpg') no-repeat center center;
            background-size: cover;
            z-index: -1;
            filter: blur(5px);
            transform: scale(1.1);
        }

        .overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }

        /* Glass Navigation Bar */
        .glass-nav {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 15px 0;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            font-weight: 500;
            margin: 0 10px;
            transition: 0.3s;
            border-radius: 30px;
            padding: 8px 20px !important;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255, 255, 255, 0.2);
            color: #ffd700 !important;
            transform: translateY(-2px);
        }

        /* Dashboard Cards (Stats) */
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 25px;
            color: white;
            transition: 0.3s;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .stat-icon {
            font-size: 3rem;
            position: absolute;
            right: 20px;
            bottom: 20px;
            opacity: 0.3;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffd700;
        }

        /* Quick Action Buttons */
        .action-btn {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            transition: 0.3s;
            display: block;
            text-decoration: none;
            height: 100%;
        }

        .action-btn:hover {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            color: white;
            border-color: transparent;
            transform: scale(1.05);
        }

        .action-btn i {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
        }
    </style>
</head>
<body>

    <div class="bg-image"></div>
    <div class="overlay"></div>

    <nav class="navbar navbar-expand-lg glass-nav fixed-top">
        <div class="container">
            <a class="navbar-brand text-white fw-bold" href="#">
                <i class="fas fa-crown text-warning me-2"></i>Ocean View Admin
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-tachometer-alt me-1"></i> Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="../reservations/viewAll.jsp"><i class="fas fa-calendar-alt me-1"></i> Reservations</a></li>
                    
                    <li class="nav-item"><a class="nav-link" href="../billing/invoice.jsp"><i class="fas fa-file-invoice-dollar me-1"></i> Billing</a></li>
                    
                    <li class="nav-item"><a class="nav-link" href="../admin/manageUsers.jsp"><i class="fas fa-users-cog me-1"></i> Manage Users</a></li>
                    <li class="nav-item"><a class="nav-link" href="../system/help.jsp"><i class="fas fa-question-circle me-1"></i> Help</a></li>
                    <li class="nav-item"><a class="btn btn-danger rounded-pill ms-3 px-4" href="../logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <%
        ReservationDAO dao = new ReservationDAO();
        List<Reservation> list = dao.getAllReservations();
        
        int totalReservations = list != null ? list.size() : 0;
        double totalRevenue = 0;
        int totalRooms = 20; 
        
        if(list != null) {
            for(Reservation r : list) {
                try {
                    if(r.getRoomPrice() != null && !r.getRoomPrice().isEmpty()) {
                        totalRevenue += Double.parseDouble(r.getRoomPrice());
                    }
                } catch(Exception e) {}
            }
        }
        
        int availableRooms = totalRooms - totalReservations;
        if(availableRooms < 0) availableRooms = 0;
    %>

    <div class="container" style="margin-top: 100px;">
        
        <div class="row mb-4">
            <div class="col-12 text-white">
                <h2>Welcome back, Admin! 👋</h2>
                <p class="text-white-50">Here's what's happening at Ocean View Resort today.</p>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="stat-card">
                    <h5>Total Reservations</h5>
                    <div class="stat-value"><%= totalReservations %></div>
                    <p class="mb-0 text-white-50">Bookings this month</p>
                    <i class="fas fa-calendar-check stat-icon"></i>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card">
                    <h5>Available Rooms</h5>
                    <div class="stat-value"><%= availableRooms %> / <%= totalRooms %></div>
                    <p class="mb-0 text-white-50">Ready for booking</p>
                    <i class="fas fa-bed stat-icon"></i>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card">
                    <h5>Total Revenue</h5>
                    <div class="stat-value text-success">LKR <%= String.format("%,.0f", totalRevenue) %></div>
                    <p class="mb-0 text-white-50">Estimated earnings</p>
                    <i class="fas fa-coins stat-icon"></i>
                </div>
            </div>
        </div>

        <h4 class="text-white mb-3 border-bottom pb-2 border-secondary">⚡ Quick Actions</h4>
        <div class="row g-4">
            
            <div class="col-md-4">
                <a href="../reservations/add.jsp" class="action-btn">
                    <i class="fas fa-plus-circle text-primary"></i>
                    <h5>Add Reservation</h5>
                    <small>Create a new booking manually</small>
                </a>
            </div>

            <div class="col-md-4">
                <a href="../reservations/viewAll.jsp" class="action-btn">
                    <i class="fas fa-list-alt text-info"></i>
                    <h5>View All Reservations</h5>
                    <small>Check booking history & status</small>
                </a>
            </div>

            <div class="col-md-4">
                <a href="../billing/invoice.jsp" class="action-btn">
                    <i class="fas fa-file-invoice text-warning"></i>
                    <h5>Generate Bill</h5>
                    <small>Select a customer to invoice</small>
                </a>
            </div>

        </div>

        <div class="text-center text-white-50 mt-5 pt-3 pb-3">
            <small>&copy; 2026 Ocean View Resort System. All Rights Reserved.</small>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>