package com.oceanview.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Users ලා පෙන්වන කොටස (List Users)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            UserDAO dao = new UserDAO();
            List<User> userList = dao.getAllUsers();
            
            request.setAttribute("userList", userList);
            // නිවැරදි Path එක:
            request.getRequestDispatcher("/admin/manageUsers.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // User කෙනෙක් Delete කරන කොටස
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // JSP එකෙන් එවන ID එක ගැනීම
            int id = Integer.parseInt(request.getParameter("id"));
            
            UserDAO dao = new UserDAO();
            HttpSession session = request.getSession();
            
            // DAO එකේ deleteUser method එක call කිරීම
            boolean f = dao.deleteUser(id);
            
            if(f) {
                session.setAttribute("succMsg", "User Deleted Successfully");
            } else {
                session.setAttribute("failedMsg", "Failed to Delete User");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // ආපහු ලිස්ට් එකටම Redirect කිරීම
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}