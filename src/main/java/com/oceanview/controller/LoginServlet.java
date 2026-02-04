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

@WebServlet("/login") 
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
     
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        
     
        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(username, pass);
        
        if (user != null) {
           
            HttpSession session = request.getSession();
            session.setAttribute("userObj", user); 
            
      
            if("admin".equals(user.getRole())) {
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "Invalid Username or Password!");
            response.sendRedirect("login.jsp");
        }
    }
}