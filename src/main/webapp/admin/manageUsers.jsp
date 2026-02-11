<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.oceanview.dao.UserDAO, com.oceanview.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | Ocean View Admin</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
            color: white;
        }

        /* 1. Background Animation (Same as Dashboard) */
        .bg-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('../img/double.jpg') no-repeat center center;
            background-size: cover;
            filter: blur(8px);
            z-index: -1;
            transform: scale(1.1);
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: -1;
        }

        /* 2. Glass Container */
        .glass-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
            animation: fadeIn 0.8s ease-in-out;
        }

        /* 3. Glass Table Styles */
        .table-glass {
            color: white;
            margin-top: 20px;
        }

        .table-glass thead {
            background: rgba(0, 0, 0, 0.5);
            color: #ffd700; /* Gold Headers */
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .table-glass th, .table-glass td {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 15px;
            vertical-align: middle;
        }

        .table-glass tbody tr:hover {
            background: rgba(255, 255, 255, 0.1); /* Hover Effect */
            transition: 0.3s;
        }

        /* 4. Action Buttons */
        .btn-add {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 600;
            transition: 0.3s;
            text-decoration: none;
        }

        .btn-add:hover {
            transform: scale(1.05);
            color: white;
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.6);
        }

        .btn-back {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: 0.3s;
            font-size: 1.1rem;
        }

        .btn-back:hover {
            color: #ffd700;
        }

        /* Status Badges */
        .badge-glass {
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.85rem;
        }
        .bg-admin { background: rgba(255, 215, 0, 0.2); color: #ffd700; border: 1px solid #ffd700; }
        .bg-user { background: rgba(0, 123, 255, 0.2); color: #00aaff; border: 1px solid #00aaff; }
        .bg-active { background: rgba(40, 167, 69, 0.2); color: #28a745; border: 1px solid #28a745; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="bg-image"></div>
    <div class="overlay"></div>

    <div class="container">
        
        <div class="d-flex justify-content-between align-items-center mt-5">
            <a href="../system/dashboard.jsp" class="btn-back">
                <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
            </a>
            <h2 class="fw-bold mb-0"><i class="fas fa-users-cog me-2 text-warning"></i> User Management</h2>
        </div>

        <div class="glass-container">
            
            <% 
            String msg = (String) session.getAttribute("succMsg");
            if(msg != null) { %>
                <div class="alert alert-success bg-transparent text-white border-success mb-3"><%= msg %></div>
                <% session.removeAttribute("succMsg"); %>
            <% } %>

            <div class="d-flex justify-content-end mb-3">
                <a href="addUser.jsp" class="btn-add">
                    <i class="fas fa-user-plus me-2"></i> Add New User
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-glass">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        // Database එකෙන් Users ලා ගැනීමේ කොටස
                        UserDAO dao = new UserDAO();
                        List<User> list = dao.getAllUsers();
                        
                        if(list != null && !list.isEmpty()) {
                            for(User u : list) {
                        %>
                        <tr>
                            <td>#<%= u.getId() %></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="rounded-circle bg-white text-dark d-flex justify-content-center align-items-center me-2" style="width: 35px; height: 35px; font-weight:bold;">
                                        <%= u.getUsername().substring(0, 1).toUpperCase() %>
                                    </div>
                                    <%= u.getUsername() %>
                                </div>
                            </td>
                            <td><%= u.getEmail() %></td>
                            <td>
                                <% if("admin".equals(u.getRole())) { %>
                                    <span class="badge-glass bg-admin"><i class="fas fa-crown me-1"></i> Admin</span>
                                <% } else { %>
                                    <span class="badge-glass bg-user"><i class="fas fa-user me-1"></i> Staff</span>
                                <% } %>
                            </td>
                            <td>
                                <span class="badge-glass bg-active">Active</span>
                            </td>
                            <td class="text-end">
                                <a href="editUser.jsp?id=<%= u.getId() %>" class="btn btn-sm btn-outline-warning me-2" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="../deleteUser?id=<%= u.getId() %>" class="btn btn-sm btn-outline-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this user?');">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </td>
                        </tr>
                        <% 
                            } 
                        } else { 
                        %>
                            <tr>
                                <td colspan="6" class="text-center py-4 text-white-50">No users found in the system.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>