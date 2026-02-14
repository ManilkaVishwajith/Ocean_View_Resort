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
            // JSP එකේ input fields වල 'name' එක මේවට සමාන විය යුතුයි
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            UserDAO dao = new UserDAO();
            // UserDAO එකේ තියෙන Method එක 'checkLogin' නම් එය නිවැරදියි
            User user = dao.checkLogin(username, password);
            
            HttpSession session = request.getSession();

            if (user != null) {
                // 'userObj' කියන නමම dashboard එකේ session එකටත් පාවිච්චි කරන්න
                session.setAttribute("userObj", user);
                
                // Admin කෙනෙක් නම් Dashboard එකට යවනවා
                if("admin".equals(user.getRole())) {
                    // ඔයාගේ Dashboard එකේ නම 'admindashboard.jsp'
                    // එය තියෙන්නේ 'system' folder එක ඇතුළේ
                    response.sendRedirect(request.getContextPath() + "/system/admindashboard.jsp");
                } 
                else {
                    // සාමාන්‍ය Customer කෙනෙක් නම් Home Page එකට යවනවා
                    response.sendRedirect(request.getContextPath() + "/home/index.jsp");
                }
            } else {
                // වැරදි නම් නැවත Login එකට යවනවා
                session.setAttribute("failedMsg", "Invalid Username or Password");
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}