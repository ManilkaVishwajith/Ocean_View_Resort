<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User" %>

<%
    // Session එකෙන් UserObj එක ලබා ගැනීම
    User user = (User) session.getAttribute("userObj");

    // Admin කෙනෙක් නෙවේ නම් ආපහු Login එකට යැවීම
    if(user == null || !"admin".equals(user.getRole())){
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AdminDashboard | Ocean View</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('<%=request.getContextPath()%>/img/double.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
        }

        .overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6); z-index: -1;
        }

        /* Glassmorphism Card */
        .admin-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            color: white;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
            margin-top: 100px;
        }

        .btn-action {
            background: rgba(255, 215, 0, 0.2);
            color: #ffd700;
            border: 1px solid #ffd700;
            transition: 0.3s;
            margin: 10px;
            padding: 15px 30px;
            border-radius: 15px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-action:hover {
            background: #ffd700;
            color: black;
            transform: translateY(-5px);
        }

        .logout-link {
            position: absolute; top: 20px; right: 20px;
            color: white; text-decoration: none;
            background: rgba(255, 0, 0, 0.4);
            padding: 8px 20px; border-radius: 30px;
        }
    </style>
</head>
<body>

    <div class="overlay"></div>

    <a href="<%=request.getContextPath()%>/logout" class="logout-link"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>

    <div class="container d-flex justify-content-center">
        <div class="admin-card text-center col-md-8">
            <i class="fas fa-user-shield fa-4x text-warning mb-4"></i>
            <h1 class="fw-bold">Welcome, <%= user.getUsername() %>!</h1>
            <p class="text-white-50">Ocean View Resort - Administrative Management Panel</p>
            
            <hr class="bg-white">

            <div class="mt-4">
                <a href="<%=request.getContextPath()%>/admin/users" class="btn-action">
                    <i class="fas fa-users fa-2x d-block mb-2"></i> Manage Users
                </a>

                <a href="<%=request.getContextPath()%>/reservations/viewAll.jsp" class="btn-action">
                    <i class="fas fa-calendar-alt fa-2x d-block mb-2"></i> All Bookings
                </a>
                <a href="<%=request.getContextPath()%>/reservations/search.jsp" class="btn-action">
    <i class="fas fa-search fa-2x d-block mb-2"></i> Search Bookings
</a>
            </div>
            
            
            <div class="mt-4">
                <a href="<%=request.getContextPath()%>/home/index.jsp" class="text-white-50 text-decoration-none">
                    <i class="fas fa-arrow-left me-2"></i>Back to Main Site
                </a>
            </div>
        </div>
    </div>

</body>
</html>