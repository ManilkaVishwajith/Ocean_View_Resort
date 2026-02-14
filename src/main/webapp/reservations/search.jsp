<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Reservations | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed; background-size: cover; min-height: 100vh; color: white; }
        .overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.6); z-index: -1; }
        .glass-card { background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 25px; padding: 35px; box-shadow: 0 15px 35px rgba(0,0,0,0.4); margin-top: 50px; }
        .form-control, .form-select { background: rgba(255, 255, 255, 0.1) !important; border: 1px solid rgba(255, 255, 255, 0.3); color: white !important; }
        .btn-search { background: linear-gradient(45deg, #ffd700, #ffae00); color: black; font-weight: 600; border-radius: 30px; padding: 10px 30px; border: none; }
        .table { color: white; margin-top: 30px; }
        .table thead { background: rgba(255, 215, 0, 0.2); color: #ffd700; }
        .result-row:hover { background: rgba(255, 255, 255, 0.1); transition: 0.3s; }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <div class="container">
        <div class="glass-card">
            <h2 class="text-center mb-4"><i class="fas fa-search text-warning me-2"></i>Find Reservation</h2>
            
            <form action="${pageContext.request.contextPath}/SearchServlet" method="get" class="row g-3">
                <div class="col-md-3">
                    <input type="text" name="resId" class="form-control" placeholder="Reservation ID">
                </div>
                <div class="col-md-3">
                    <input type="text" name="cusName" class="form-control" placeholder="Customer Name">
                </div>
                <div class="col-md-3">
                    <input type="date" name="resDate" class="form-control">
                </div>
                <div class="col-md-3 d-flex gap-2">
                    <button type="submit" class="btn-search w-100">Search</button>
                    <a href="search.jsp" class="btn btn-outline-light rounded-pill"><i class="fas fa-undo"></i></a>
                </div>
            </form>

            <hr class="my-4 border-secondary">

            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Room Type</th>
                            <th>Dates</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Reservation> list = (List<Reservation>) request.getAttribute("searchList");
                            if(list != null && !list.isEmpty()) {
                                for(Reservation r : list) {
                        %>
                        <tr class="result-row">
                            <td>#<%= r.getId() %></td>
                            <td><%= r.getCustomerName() %></td>
                            <td><span class="badge bg-dark border border-warning text-warning"><%= r.getRoomType() %></span></td>
                            <td><%= r.getCheckIn() %> to <%= r.getCheckOut() %></td>
                            <td class="text-warning fw-bold">LKR <%= r.getRoomPrice() %></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/billing/generate?id=<%= r.getId() %>" class="btn btn-sm btn-info rounded-pill"><i class="fas fa-file-invoice"></i></a>
                            </td>
                        </tr>
                        <% 
                                }
                            } else if(request.getAttribute("searchList") != null) {
                        %>
                        <tr><td colspan="6" class="text-center py-4">No results found!</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div class="mt-4 text-center">
                <a href="${pageContext.request.contextPath}/system/admindashboard.jsp" class="btn btn-sm btn-outline-light rounded-pill px-4">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>