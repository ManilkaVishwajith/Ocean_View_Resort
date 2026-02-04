<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User" %>

<%
   
    User user = (User) session.getAttribute("userObj");

   
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card text-center">
        <div class="card-header">
            Admin Panel 🛡️
        </div>
        <div class="card-body">
            <h1 class="card-title">Welcome, <%= user.getUsername() %>!</h1>
            <p class="card-text">You have successfully logged in as an Admin.</p>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </div>
</div>

</body>
</html>