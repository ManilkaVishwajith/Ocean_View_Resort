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
    
    // Users ලා පෙන්වන කොටස
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        List<User> userList = dao.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }

    // User කෙනෙක් Delete කරන කොටස
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            UserDAO dao = new UserDAO();
            HttpSession session = request.getSession();
            
            if(dao.deleteUser(id)) {
                session.setAttribute("succMsg", "User Deleted Successfully");
            } else {
                session.setAttribute("failedMsg", "Failed to Delete User");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("users"); // ආයෙත් ලිස්ට් එකටම එනවා
    }
}