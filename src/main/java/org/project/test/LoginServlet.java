package org.project.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session.getAttribute("user")!=null){
            response.sendRedirect("profile.jsp");
        }
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Get a database connection using your DatabaseConnection class
            Connection con = DatabaseConnection.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM users WHERE username=? AND password=?");
                ps.setString(1, username);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Successful login
                    request.getSession().setAttribute("user", username);
                    response.sendRedirect("profile.jsp"); // Redirect to profile page
                } else {
                    // Invalid login
                    request.setAttribute("loginError", "Invalid username or password");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Database connection failed
                request.setAttribute("loginError", "Database connection error");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }
}