<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>

<%
    ReservationDAO dao = new ReservationDAO();
    List<Reservation> list = dao.getAllReservations();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History | Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --glass-bg: rgba(255, 255, 255, 0.12);
            --glass-border: rgba(255, 255, 255, 0.25);
            --gold-gradient: linear-gradient(45deg, #ffd700, #ffae00);
            --ocean-blue: #0077be;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            color: white;
        }

        .hero-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.7));
            z-index: -1;
        }

        /* 🔹 Modern Glass Navbar */
        .navbar {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            border-bottom: 1px solid var(--glass-border);
            padding: 15px 0;
        }

        /* 🔹 Premium Glass Table Container */
        .main-card {
            background: var(--glass-bg);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border-radius: 30px;
            border: 1px solid var(--glass-border);
            box-shadow: 0 25px 45px rgba(0,0,0,0.5);
            padding: 40px;
            margin: 60px auto;
            animation: fadeIn 1s ease-in-out;
        }

        /* 🔹 Custom Table Styling */
        .table {
            color: #f8f9fa;
            border-collapse: separate;
            border-spacing: 0 12px;
        }

        .table thead th {
            border: none;
            color: #ffd700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-size: 0.85rem;
            padding-bottom: 20px;
        }

        .table tbody tr {
            background: rgba(255, 255, 255, 0.05);
            transition: 0.3s;
            border-radius: 15px;
        }

        .table tbody tr:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .table td {
            padding: 20px;
            border: none;
            border-top: 1px solid var(--glass-border);
            border-bottom: 1px solid var(--glass-border);
        }

        .table td:first-child { border-left: 1px solid var(--glass-border); border-top-left-radius: 15px; border-bottom-left-radius: 15px; }
        .table td:last-child { border-right: 1px solid var(--glass-border); border-top-right-radius: 15px; border-bottom-right-radius: 15px; }

        /* 🔹 Status Badges */
        .status-badge {
            background: var(--gold-gradient);
            color: #000;
            font-weight: 700;
            font-size: 0.75rem;
            padding: 6px 15px;
            border-radius: 30px;
            text-transform: uppercase;
        }

        /* 🔹 Action Buttons */
        .btn-bill {
            background: rgba(0, 255, 255, 0.2);
            color: #00ffff;
            border: 1px solid #00ffff;
            border-radius: 10px;
            transition: 0.3s;
        }
        .btn-bill:hover { background: #00ffff; color: #000; box-shadow: 0 0 10px #00ffff; }

        .btn-home {
            background: var(--gold-gradient);
            color: #000;
            border: none;
            font-weight: 600;
            border-radius: 30px;
            padding: 8px 25px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="hero-overlay"></div>

    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold fs-3" href="${pageContext.request.contextPath}/home/index.jsp">
                <i class="fas fa-water me-2"></i>OCEAN VIEW
            </a>
            <div class="ms-auto">
                <a href="${pageContext.request.contextPath}/home/index.jsp" class="btn btn-home me-2">
                    <i class="fas fa-home me-1"></i> Home
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-4">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="main-card">
            
            <div class="row mb-5 align-items-center">
                <div class="col-md-6">
                    <h2 class="fw-bold mb-0 text-white"><i class="fas fa-history text-warning me-3"></i>Booking History</h2>
                    <p class="text-white-50 mt-2">Manage and view all your luxury stays</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="${pageContext.request.contextPath}/reservations/add.jsp" class="btn btn-outline-warning rounded-pill px-4">
                        <i class="fas fa-plus me-2"></i>New Reservation
                    </a>
                </div>
            </div>

            <% String succMsg = (String) session.getAttribute("succMsg");
               if(succMsg != null) { %>
                <div class="alert alert-success bg-transparent text-success border-success text-center mb-4">
                    <i class="fas fa-check-double me-2"></i><%= succMsg %>
                </div>
            <% session.removeAttribute("succMsg"); } %>

            <% if(list.isEmpty()) { %>
                <div class="text-center py-5">
                    <img src="${pageContext.request.contextPath}/img/empty.png" alt="No data" style="width: 150px; opacity: 0.5;">
                    <h4 class="mt-4 text-white-50">No bookings found in your history.</h4>
                    <a href="add.jsp" class="btn btn-warning mt-3 rounded-pill px-4">Start Booking Now</a>
                </div>
            <% } else { %>
            
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>#ID</th>
                            <th>Guest Info</th>
                            <th>Accommodation</th>
                            <th>Stay Period</th>
                            <th>Total Cost</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Reservation r : list) { %>
                        <tr>
                            <td class="fw-bold text-white-50">#<%= r.getId() %></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="avatar-circle me-3 bg-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold text-white"><%= r.getCustomerName() %></div>
                                        <div class="small text-white-50"><%= r.getEmail() %></div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-dark border border-warning text-warning px-3 py-2">
                                    <i class="fas fa-bed me-2"></i><%= r.getRoomType() %>
                                </span>
                            </td>
                            <td>
                                <div class="small text-white">
                                    <i class="far fa-calendar-alt me-1 text-info"></i> <%= r.getCheckIn() %>
                                </div>
                                <div class="small text-white mt-1">
                                    <i class="far fa-calendar-check me-1 text-danger"></i> <%= r.getCheckOut() %>
                                </div>
                            </td>
                            <td>
                                <div class="fw-bold text-warning fs-5">LKR <%= r.getRoomPrice() %></div>
                            </td>
                            <td class="text-center">
                                <span class="status-badge mb-2 d-inline-block">Confirmed</span>
                                <br>
                                <a href="${pageContext.request.contextPath}/billing/generate?id=<%= r.getId() %>" class="btn btn-sm btn-bill px-3 py-2">
                                    <i class="fas fa-file-invoice-dollar me-2"></i>Invoice
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>