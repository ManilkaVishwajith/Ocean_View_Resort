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
        
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // Default Role එක "Staff" ලෙස සලකමු (Admin අවශ්‍ය නම් Database එකෙන් වෙනස් කරගන්න)
            String role = "staff"; 

            User u = new User();
            u.setUsername(username);
            u.setEmail(email);
            u.setPassword(password);
            u.setRole(role);

            UserDAO dao = new UserDAO();
            // මෙන්න නිවැරදි Method එක (addUser)
            boolean f = dao.addUser(u);

            HttpSession session = request.getSession();

            if(f) {
                session.setAttribute("succMsg", "Registration Successful! Please Login.");
                response.sendRedirect("auth/login.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server!");
                response.sendRedirect("auth/signup.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errors/500.jsp");
        }
    }
}