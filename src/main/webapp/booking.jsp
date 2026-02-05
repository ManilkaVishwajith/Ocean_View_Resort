<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.dao.RoomDAO, com.oceanview.model.Room, com.oceanview.model.User, java.util.List" %>

<%
    // ලොග් වෙලාද බලනවා
    User user = (User) session.getAttribute("userObj");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // URL එකෙන් එන Room ID එක ගන්නවා (index.jsp එකෙන් එවන එක)
    String idStr = request.getParameter("id");
    int roomId = 0;
    Room selectedRoom = null;

    if(idStr != null) {
        roomId = Integer.parseInt(idStr);
        RoomDAO dao = new RoomDAO();
        selectedRoom = dao.getRoomById(roomId);
    }
    
    if(selectedRoom == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Room - Ocean View Resort</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-primary mb-4">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">🌊 Ocean View Resort</a>
    <a href="index.jsp" class="btn btn-outline-light btn-sm">Back to Home</a>
  </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg">
                <div class="row g-0">
                    <div class="col-md-5">
                        <img src="img/<%= selectedRoom.getImageUrl() %>" class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="Room Image"
                        onerror="this.src='https://source.unsplash.com/400x600/?hotel,room'">
                    </div>
                    
                    <div class="col-md-7">
                        <div class="card-body p-4">
                            <h3 class="card-title text-primary">Confirm Booking</h3>
                            <h5 class="mb-3"><%= selectedRoom.getRoomType() %> <span class="badge bg-secondary">LKR <%= selectedRoom.getPrice() %>/Night</span></h5>
                            <p class="text-muted">Room No: <%= selectedRoom.getRoomNumber() %></p>
                            
                            <form action="book-room" method="post">
                                
                                <input type="hidden" name="room_id" value="<%= roomId %>">
                                <input type="hidden" name="price" value="<%= selectedRoom.getPrice() %>">
                                
                                <div class="row mb-3">
                                    <div class="col">
                                        <label class="form-label">Check-in Date</label>
                                        <input type="date" name="checkin" class="form-control" required>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">Check-out Date</label>
                                        <input type="date" name="checkout" class="form-control" required>
                                    </div>
                                </div>
                                
                                <div class="alert alert-info py-2 small">
                                    Total price will be calculated automatically based on days.
                                </div>
                                
                                <button type="submit" class="btn btn-success w-100 btn-lg">Confirm Booking ✅</button>
                                <a href="index.jsp" class="btn btn-outline-secondary w-100 mt-2">Cancel</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>