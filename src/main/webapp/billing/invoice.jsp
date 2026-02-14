<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    // Servlet එකෙන් එවපු Object ලබා ගැනීම
    Reservation r = (Reservation) request.getAttribute("reservation");
    Long days = (Long) request.getAttribute("days");
    Double total = (Double) request.getAttribute("total");

    if (r == null) {
        response.sendRedirect(request.getContextPath() + "/home/index.jsp");
        return;
    }
    
    long d = (days != null) ? days : 1;
    double t = (total != null) ? total : 0.0;
    double rate = 0;
    try { rate = Double.parseDouble(r.getRoomPrice()); } catch(Exception e) { rate = 0; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice #INV-<%= r.getId() %> | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed; background-size: cover; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: -1; }
        .glass-card { background: rgba(255, 255, 255, 0.15); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 25px; padding: 40px; color: white; width: 100%; max-width: 750px; box-shadow: 0 15px 35px rgba(0,0,0,0.4); }
        .invoice-header { border-bottom: 2px solid #ffd700; padding-bottom: 15px; margin-bottom: 25px; }
        .table { color: white; margin-top: 20px; }
        .table thead { background: rgba(255, 215, 0, 0.2); color: #ffd700; }
        .total-box { background: rgba(255, 215, 0, 0.1); padding: 15px; border-radius: 15px; border: 1px solid #ffd700; }
        @media print { .no-print { display: none; } body { background: white; } .glass-card { background: white; color: black; box-shadow: none; border: 1px solid #000; } .table { color: black; } }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <div class="glass-card">
        <div class="invoice-header d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-bold text-warning mb-0">OCEAN VIEW RESORT 🌊</h2>
                <p class="small text-white-50">Luxury Seashore Experience</p>
            </div>
            <div class="text-end">
                <h3 class="mb-0">INVOICE</h3>
                <span class="badge bg-warning text-dark">#INV-<%= r.getId() %></span>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-6">
                <p class="text-warning fw-bold mb-1">CUSTOMER INFO</p>
                <h5 class="mb-0"><%= r.getCustomerName() %></h5>
                <p class="small"><%= r.getEmail() %></p>
            </div>
            <div class="col-6 text-end">
                <p class="text-warning fw-bold mb-1">STAY PERIOD</p>
                <p class="mb-0 small">In: <%= r.getCheckIn() %></p>
                <p class="mb-0 small">Out: <%= r.getCheckOut() %></p>
            </div>
        </div>

        <table class="table">
            <thead>
                <tr class="text-center">
                    <th>Description</th>
                    <th>Price/Day</th>
                    <th>Days</th>
                    <th class="text-end">Subtotal</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <tr>
                    <td class="text-start"><%= r.getRoomType() %> Room</td>
                    <td>LKR <%= String.format("%.2f", rate) %></td>
                    <td><%= d %></td>
                    <td class="text-end fw-bold">LKR <%= String.format("%.2f", rate * d) %></td>
                </tr>
            </tbody>
        </table>

        <div class="total-box text-end mt-4">
            <h4 class="mb-0">GRAND TOTAL: <span class="text-warning">LKR <%= String.format("%.2f", t) %></span></h4>
        </div>

        <div class="mt-5 text-center no-print">
            <button onclick="window.print()" class="btn btn-warning rounded-pill px-4 me-2"><i class="fas fa-print me-2"></i>Print</button>
            <a href="${pageContext.request.contextPath}/reservations/my-bookings.jsp" class="btn btn-outline-light rounded-pill px-4">Back</a>
        </div>
    </div>
</body>
</html>