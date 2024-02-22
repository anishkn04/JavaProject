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

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        resp.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session.getAttribute("user")!=null){
            response.sendRedirect("profile.jsp");
        }
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            // Get a database connection using your DatabaseConnection class
            Connection con = DatabaseConnection.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM users WHERE username=?");
                ps.setString(1, username);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("signupError", "Username already in use!");
                    request.setAttribute("signupPage", "");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    PreparedStatement psInsert = con.prepareStatement(
                            "INSERT INTO users(username, password, role, name) VALUES (?, ?, ?, ?)");
                    psInsert.setString(1, username);
                    psInsert.setString(2, password);
                    psInsert.setString(3, role);
                    psInsert.setString(4, name);
                    int rows = psInsert.executeUpdate();
                    try {
                        request.setAttribute("signupSuccess", "Successfully Signed up!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }catch (Exception e){
                        request.setAttribute("signupError", e.getMessage());
                        request.setAttribute("signupPage", "");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }

                }
            } else {
                // Database connection failed
                request.setAttribute("signupError", "Database connection error");
                request.setAttribute("signupPage", "");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }
}
