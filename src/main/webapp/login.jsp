<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Ocean View Resort</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f0f2f5;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .login-card {
        width: 100%;
        max-width: 400px;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        background: white;
    }
</style>
</head>
<body>

<div class="login-card">
    <h3 class="text-center mb-4 text-primary">Ocean View Resort</h3>
    <h5 class="text-center mb-4">Login</h5>

    <% 
        String error = (String) session.getAttribute("errorMsg");
        if(error != null) {
    %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <% 
        session.removeAttribute("errorMsg"); // Refresh කළාම මැකෙන්න
        } 
    %>

    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
</div>

</body>
</html>