package com.oceanview.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("userObj");
            session.removeAttribute("role");
            session.invalidate(); // Session එක විනාශ කිරීම
            
            HttpSession newSession = request.getSession();
            newSession.setAttribute("succMsg", "Logout Successfully");
            response.sendRedirect("auth/login.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}