package com.oceanview.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User u = new User();
            u.setId(id);
            u.setUsername(username);
            u.setEmail(email);
            u.setPassword(password);
            u.setRole(role);

            UserDAO dao = new UserDAO();
            boolean f = dao.updateUser(u);

            HttpSession session = request.getSession();
            if(f) {
                session.setAttribute("succMsg", "User Updated Successfully! 🔄");
                response.sendRedirect("admin/manageUsers.jsp");
            } else {
                session.setAttribute("failedMsg", "Update Failed!");
                response.sendRedirect("admin/editUser.jsp?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}