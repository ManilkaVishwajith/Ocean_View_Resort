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

@WebServlet("/register") 
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
       
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); 
        
       
        User u = new User();
        u.setUsername(username);
        u.setEmail(email);
        u.setPassword(password);
        u.setRole(role);
        
       
        UserDAO dao = new UserDAO();
        boolean f = dao.registerUser(u);
        
        HttpSession session = request.getSession();
        
        if(f) {
          
            session.setAttribute("regSuccess", "Registration Successfully! Please Login.");
            response.sendRedirect("signup.jsp");
        } else {
            
            session.setAttribute("regError", "Something went wrong! Please try again.");
            response.sendRedirect("signup.jsp");
        }
    }
}