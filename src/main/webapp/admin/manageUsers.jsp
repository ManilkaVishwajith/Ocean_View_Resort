<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.oceanview.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Ocean View Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">Ocean View Admin</a>
            <div class="d-flex align-items-center">
                <span class="navbar-text text-white me-3">Welcome, Admin</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3 class="text-center mb-4"><i class="fas fa-users-cog me-2"></i>User Management</h3>
                
                <% 
                String succMsg = (String) session.getAttribute("succMsg");
                String failedMsg = (String) session.getAttribute("failedMsg");
                
                if(succMsg != null) { %>
                    <div class="alert alert-success text-center" role="alert"><%= succMsg %></div>
                    <% session.removeAttribute("succMsg"); %>
                <% } 
                if(failedMsg != null) { %>
                    <div class="alert alert-danger text-center" role="alert"><%= failedMsg %></div>
                    <% session.removeAttribute("failedMsg"); %>
                <% } %>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    // Servlet එකෙන් එවන List එක ලබා ගැනීම
                                    List<User> list = (List<User>) request.getAttribute("userList");
                                    
                                    if(list != null && !list.isEmpty()) {
                                        for(User u : list) {
                                    %>
                                    <tr>
                                        <td><%= u.getId() %></td>
                                        <td><%= u.getUsername() %></td> 
                                        <td><%= u.getEmail() %></td>
                                        <td>
                                            <% if("admin".equalsIgnoreCase(u.getRole())) { %>
                                                <span class="badge bg-danger">Admin</span>
                                            <% } else { %>
                                                <span class="badge bg-primary">User</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this user?')">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%  } 
                                    } else { %>
                                        <tr><td colspan="5" class="text-center text-muted p-4">No users found in the database.</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/system/dashboard.jsp" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
                
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>