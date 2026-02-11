<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.oceanview.dao.ReservationDAO, com.oceanview.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservations | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        /* Dashboard එකේ CSS මයි */
        body { font-family: 'Poppins', sans-serif; overflow-x: hidden; color: white; }
        .bg-image {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: url('../img/double.jpg') no-repeat center center;
            background-size: cover; filter: blur(8px); z-index: -1; transform: scale(1.1);
        }
        .overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.7); z-index: -1;
        }
        .glass-nav {
            background: rgba(255, 255, 255, 0.15); backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2); padding: 15px 0;
        }
        .nav-link { color: rgba(255, 255, 255, 0.8) !important; font-weight: 500; margin: 0 10px; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { color: #ffd700 !important; transform: translateY(-2px); }
        
        /* Table Box */
        .glass-container {
            background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 20px;
            padding: 30px; margin-top: 100px; box-shadow: 0 15px 35px rgba(0,0,0,0.5);
        }
        .table-glass { color: white; margin-top: 20px; vertical-align: middle; }
        .table-glass thead { background: rgba(0, 0, 0, 0.5); color: #ffd700; text-transform: uppercase; }
        .table-glass th, .table-glass td { border-bottom: 1px solid rgba(255, 255, 255, 0.1); padding: 15px; }
        .table-glass tbody tr:hover { background: rgba(255, 255, 255, 0.1); }
        
        .btn-action { text-decoration: none; font-size: 1.2rem; transition: 0.3s; }
        .btn-action:hover { transform: scale(1.2); }
    </style>
</head>
<body>

    <div class="bg-image"></div>
    <div class="overlay"></div>

    <nav class="navbar navbar-expand-lg glass-nav fixed-top">
        <div class="container">
            <a class="navbar-brand text-white fw-bold" href="../system/dashboard.jsp"><i class="fas fa-crown text-warning me-2"></i>Ocean View Admin</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="../system/dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">Reservations</a></li>
                    <li class="nav-item"><a class="nav-link" href="../billing/index.jsp">Billing</a></li>
                    <li class="nav-item"><a class="nav-link" href="../admin/manageUsers.jsp">Manage Users</a></li>
                    <li class="nav-item"><a class="nav-link" href="../system/help.jsp">Help</a></li>
                    <li class="nav-item"><a class="btn btn-danger rounded-pill ms-3 px-4" href="../logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="glass-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold"><i class="fas fa-list-alt text-warning me-2"></i> All Reservations</h2>
                <a href="add.jsp" class="btn btn-warning rounded-pill fw-bold"><i class="fas fa-plus me-2"></i>New Booking</a>
            </div>

            <div class="table-responsive">
                <table class="table table-glass">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Room Type</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Price</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        ReservationDAO dao = new ReservationDAO();
                        List<Reservation> list = dao.getAllReservations();
                        if(list != null && !list.isEmpty()) {
                            for(Reservation r : list) {
                        %>
                        <tr>
                            <td>#<%= r.getId() %></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-white text-dark d-flex justify-content-center align-items-center me-2" style="width: 35px; height: 35px; font-weight:bold;">
                                        <%= r.getCustomerName().substring(0, 1).toUpperCase() %>
                                    </div>
                                    <%= r.getCustomerName() %>
                                </div>
                            </td>
                            <td><span class="badge bg-primary"><%= r.getRoomType() %></span></td>
                            <td><%= r.getCheckIn() %></td>
                            <td><%= r.getCheckOut() %></td>
                            <td class="text-warning fw-bold">LKR <%= r.getRoomPrice() %></td>
                            <td class="text-end">
                                <a href="../billing/generate?id=<%= r.getId() %>" class="btn-action text-info me-3" title="Generate Bill"><i class="fas fa-file-invoice-dollar"></i></a>
                                <a href="#" class="btn-action text-danger" title="Delete"><i class="fas fa-trash-alt"></i></a>
                            </td>
                        </tr>
                        <% }} else { %>
                            <tr><td colspan="7" class="text-center">No reservations found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>