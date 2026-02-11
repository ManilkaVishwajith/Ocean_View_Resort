<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.dao.UserDAO, com.oceanview.model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background: url('../img/double.jpg') no-repeat center center fixed;
        background-size: cover;
    }
    .glass-card {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        padding: 30px;
        margin-top: 50px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }
</style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="glass-card">
                <h3 class="text-center mb-4">Edit User Details ✏️</h3>
                
                <%
                    int id = Integer.parseInt(request.getParameter("id"));
                    UserDAO dao = new UserDAO();
                    User u = dao.getUserById(id);
                %>

                <form action="../updateUser" method="post">
                    <input type="hidden" name="id" value="<%= u.getId() %>">
                    
                    <div class="mb-3">
                        <label>Username</label>
                        <input type="text" name="username" class="form-control" value="<%= u.getUsername() %>" required>
                    </div>
                    
                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" value="<%= u.getEmail() %>" required>
                    </div>
                    
                    <div class="mb-3">
                        <label>Password</label>
                        <input type="text" name="password" class="form-control" value="<%= u.getPassword() %>" required>
                    </div>
                    
                    <div class="mb-3">
                        <label>Role</label>
                        <select name="role" class="form-select">
                            <option value="admin" <%= "admin".equals(u.getRole()) ? "selected" : "" %>>Admin</option>
                            <option value="staff" <%= "staff".equals(u.getRole()) ? "selected" : "" %>>Staff</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-warning w-100">Update User</button>
                    <a href="manageUsers.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>