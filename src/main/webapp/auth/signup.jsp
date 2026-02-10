<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up - Ocean View Resort</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f0f2f5;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .signup-card {
        width: 100%;
        max-width: 500px;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        background: white;
    }
</style>
</head>
<body>

<div class="signup-card">
    <h3 class="text-center mb-4 text-primary">Join Ocean View Resort 🌊</h3>
    <h5 class="text-center mb-4">Create Account</h5>

    <% 
        String error = (String) session.getAttribute("regError");
        String success = (String) session.getAttribute("regSuccess");
        
        if(error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
    <%  session.removeAttribute("regError"); } 
        
        if(success != null) { %>
            <div class="alert alert-success"><%= success %></div>
    <%  session.removeAttribute("regSuccess"); } %>

    <form action="register" method="post">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        
        <input type="hidden" name="role" value="customer">
        
        <button type="submit" class="btn btn-success w-100">Sign Up</button>
        
        <div class="text-center mt-3">
            <a href="login.jsp" class="text-decoration-none">Already have an account? Login</a>
        </div>
    </form>
</div>

</body>
</html>