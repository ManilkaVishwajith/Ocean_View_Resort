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
        
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            UserDAO dao = new UserDAO();
         // login වෙනුවට checkLogin ලෙස වෙනස් කරන්න
            User user = dao.checkLogin(username, password);
            HttpSession session = request.getSession();

            if (user != null) {
                // User ව Session එකට දාගන්නවා (system එක පුරාම පාවිච්චි කරන්න)
                session.setAttribute("userObj", user);
                session.setAttribute("role", user.getRole());
                
                // Admin නම් Dashboard එකට, නැත්නම් Home Page එකට
                if("admin".equals(user.getRole())) {
                    response.sendRedirect("system/dashboard.jsp");
                } else {
                    response.sendRedirect("system/dashboard.jsp"); // Staff ලත් Dashboard යවමු
                }
            } else {
                session.setAttribute("failedMsg", "Invalid Email or Password");
                response.sendRedirect("auth/login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}