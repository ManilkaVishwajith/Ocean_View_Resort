<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>

<%
    // ReservationDAO හරහා ඩේටා ගැනීම
    ReservationDAO dao = new ReservationDAO();
    // දැනට Database එකේ තියෙන ඔක්කොම Bookings පෙන්වමු (පසුව User ට අදාළව ෆිල්ටර් කරගන්න පුළුවන්)
    List<Reservation> list = dao.getAllReservations();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('img/double.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
        }

        .overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5); z-index: -1;
        }

        /* Glass Navbar */
        .navbar-glass {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Glass Container */
        .glass-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            margin-top: 50px;
            color: white;
        }

        /* Table Styles */
        .table { color: white; }
        .table thead { background-color: rgba(0,0,0,0.3); color: #ffd700; }
        .table tbody tr:hover { background-color: rgba(255,255,255,0.1); }
        .table td, .table th { border-color: rgba(255,255,255,0.1); vertical-align: middle; }

        .btn-home {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
        }
        .btn-home:hover { background: rgba(255, 255, 255, 0.4); color: #ffd700; }

        .badge-status {
            background: rgba(40, 167, 69, 0.6);
            border: 1px solid #28a745;
        }
    </style>
</head>
<body>

    <div class="overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-glass">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp"><i class="fas fa-umbrella-beach me-2"></i>Ocean View</a>
            <div class="ms-auto">
                <a href="index.jsp" class="btn btn-sm btn-home"><i class="fas fa-home me-1"></i> Home</a>
                <a href="logout" class="btn btn-sm btn-danger ms-2">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <% String succMsg = (String) session.getAttribute("succMsg");
           if(succMsg != null) { %>
            <div class="alert alert-success mt-4 text-center opacity-75">
                <i class="fas fa-check-circle me-2"></i><%= succMsg %>
            </div>
        <% session.removeAttribute("succMsg"); } %>

        <div class="glass-container">
            <h3 class="text-center mb-4"><i class="fas fa-calendar-check text-warning me-2"></i>My Bookings</h3>
            
            <% if(list.isEmpty()) { %>
                <div class="text-center py-5">
                    <i class="fas fa-box-open fa-3x text-white-50 mb-3"></i>
                    <h4>No bookings found yet!</h4>
                    <a href="index.jsp" class="btn btn-warning mt-2">Book a Room</a>
                </div>
            <% } else { %>
            
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Room Type</th>
                            <th>Dates</th>
                            <th>Price</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Reservation r : list) { %>
                        <tr>
                            <td>#<%= r.getId() %></td>
                            <td><%= r.getCustomerName() %></td>
                            <td>
                                <span class="fw-bold text-warning"><%= r.getRoomType() %></span>
                            </td>
                            <td>
                                <small class="d-block">In: <%= r.getCheckIn() %></small>
                                <small class="d-block">Out: <%= r.getCheckOut() %></small>
                            </td>
                            <td>$<%= r.getRoomPrice() %></td>
                            <td>
                                <span class="badge badge-status">Confirmed</span>
                                <a href="billing/generate?id=<%= r.getId() %>" class="btn btn-sm btn-outline-light ms-2" title="View Bill">
                                    <i class="fas fa-file-invoice"></i>
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>

</body>
</html>