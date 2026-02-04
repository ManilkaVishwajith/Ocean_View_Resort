<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User" %>

<%
 
    User user = (User) session.getAttribute("userObj");

   
    String username = (user != null) ? user.getUsername() : "Guest";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home - Ocean View Resort</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand" href="#">🌊 Ocean View Resort</a>
    <div class="d-flex">
        <% if(user != null) { %>
            <span class="navbar-text text-white me-3">Welcome, <%= user.getUsername() %>!</span>
            <a href="login.jsp" class="btn btn-outline-light btn-sm">Logout</a>
        <% } else { %>
            <a href="login.jsp" class="btn btn-light btn-sm">Login</a>
        <% } %>
    </div>
  </div>
</nav>

<div class="container mt-5 text-center">
    <div class="p-5 bg-white shadow rounded">
        <h1 class="display-4">Welcome to Paradise! 🌴</h1>
        <p class="lead">Experience the best vacation of your life.</p>
        <hr class="my-4">
        <% if(user != null) { %>
            <p>Ready to book your room?</p>
            <a class="btn btn-primary btn-lg" href="#" role="button">Book Now</a>
        <% } else { %>
            <p>Please login to make a reservation.</p>
         <a href="logout" class="btn btn-outline-light btn-sm">Logout</a>
        <% } %>
    </div>
</div>

</body>
</html>