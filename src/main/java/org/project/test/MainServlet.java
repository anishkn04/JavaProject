package org.project.test;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {

    public String getSubject(String sem, String link){
        if(link != null) return link;
        switch (sem){
            case "sem2": return "cpp";
            case "sem3": return "calc2";
            default: return "dl";
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException{
        try {
            String cat = request.getParameter("cat");

            String semester = cat == null ? "sem1" : cat;
            String subject = getSubject(semester, request.getParameter("subcat"));
            StringBuilder resHtml = new StringBuilder();

            Connection con = DatabaseConnection.getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM links WHERE subject=?");
                ps.setString(1, subject);

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    resHtml.append("<a class='container' target='_blank' href='").append(rs.getString(4)).append("'><span class='container-image'><img alt='pdf-logo' src='images/pdf.svg'></span><span class='container-description'>").append(rs.getString(3)).append("</span></a>");
                }
                request.setAttribute("output", resHtml.toString());
                request.getRequestDispatcher("main.jsp?cat="+semester+"&subcat="+subject).forward(request, response);
            } else {
                request.setAttribute("output", "Database Error");
                request.getRequestDispatcher("main.jsp?cat="+semester+"&subcat="+subject).forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e.getMessage());
        }
    }
}
