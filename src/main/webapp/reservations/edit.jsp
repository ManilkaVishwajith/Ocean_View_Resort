<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    // Servlet එකෙන් එවපු Reservation Object එක ලබා ගැනීම
    Reservation r = (Reservation) request.getAttribute("resObj");
    if(r == null) {
        response.sendRedirect(request.getContextPath() + "/reservations/my-bookings.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Reservation | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed; background-size: cover; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 0; }
        .overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: -1; }
        .glass-card { background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 30px; padding: 40px; width: 100%; max-width: 700px; box-shadow: 0 25px 50px rgba(0,0,0,0.4); color: white; animation: slideIn 0.8s ease; }
        .form-label { color: #ffd700; font-weight: 500; font-size: 0.9rem; margin-bottom: 8px; }
        .form-control, .form-select { background: rgba(255, 255, 255, 0.1) !important; border: 1px solid rgba(255, 255, 255, 0.3); color: white !important; height: 48px; }
        .form-control:focus { border-color: #ffd700; box-shadow: none; }
        .form-select option { background: #1a1a1a; color: white; }
        .btn-update { background: linear-gradient(45deg, #ffd700, #c5a028); border: none; color: black; padding: 12px 40px; border-radius: 30px; font-weight: 700; transition: 0.3s; }
        .btn-update:hover { transform: scale(1.05); box-shadow: 0 0 15px rgba(255, 215, 0, 0.5); }
        .btn-cancel { background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.3); color: white; padding: 12px 30px; border-radius: 30px; text-decoration: none; }
        @keyframes slideIn { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-edit fa-3x text-warning mb-3"></i>
            <h2 class="fw-bold">Update Reservation 🌊</h2>
            <p class="text-white-50">Modify details for Booking #<%= r.getId() %></p>
        </div>

        <form action="${pageContext.request.contextPath}/ReservationUpdateServlet" method="post">
            <input type="hidden" name="id" value="<%= r.getId() %>">
            
            <div class="row">
                <div class="col-md-12 mb-3">
                    <label class="form-label">Customer Name</label>
                    <input type="text" name="customerName" class="form-control" value="<%= r.getCustomerName() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Email / NIC</label>
                    <input type="text" name="email" class="form-control" value="<%= r.getEmail() %>" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Room Type</label>
                    <select name="roomType" class="form-select" required>
                        <option value="Single" <%= "Single".equals(r.getRoomType()) ? "selected" : "" %>>Single Room</option>
                        <option value="Double" <%= "Double".equals(r.getRoomType()) ? "selected" : "" %>>Double Room</option>
                        <option value="Luxury Suite" <%= "Luxury Suite".equals(r.getRoomType()) ? "selected" : "" %>>Luxury Suite</option>
                    </select>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">Check-in Date</label>
                    <input type="date" name="checkIn" class="form-control" value="<%= r.getCheckIn() %>" required>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">Check-out Date</label>
                    <input type="date" name="checkOut" class="form-control" value="<%= r.getCheckOut() %>" required>
                </div>
            </div>

            <div class="d-flex justify-content-between mt-3">
                <a href="${pageContext.request.contextPath}/reservations/my-bookings.jsp" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-update"><i class="fas fa-sync-alt me-2"></i>Update Reservation</button>
            </div>
        </form>
    </div>
</body>
</html>