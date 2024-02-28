package org.project.test;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user")==null || !session.getAttribute("role").equals("teacher")){
            response.sendRedirect("login.jsp");
        }
        String type = request.getParameter("type");
        try{
            Connection con = DatabaseConnection.getConnection();
            if(con != null){

                if(type.equals("Semesters")){;
                    int semester = Integer.parseInt(request.getParameter("semester"));
                    PreparedStatement ps = con.prepareStatement(
                            "DELETE FROM semesters WHERE semester=?");
                    ps.setInt(1, semester);

                    int rowsEffected = ps.executeUpdate();
                    if (rowsEffected>0) {
                        request.setAttribute("editSuccess", "Semester deleted successfully!");
                        request.getRequestDispatcher("edit.jsp?type=Semesters").forward(request, response);
                    } else {
                        request.setAttribute("editFailed", "Could not find/delete semester!");
                        request.getRequestDispatcher("edit.jsp?type=Semesters").forward(request, response);
                    }
                } else if (type.equals("Subjects")) {
                    int subject_id = Integer.parseInt(request.getParameter("subject"));
                    PreparedStatement ps = con.prepareStatement(
                            "DELETE FROM subjects WHERE subject_id=?");
                    ps.setInt(1, subject_id);
                    int rowsEffected = ps.executeUpdate();
                    if (rowsEffected>0) {
                        request.setAttribute("editSuccess", "Subject deleted successfully!");
                        request.getRequestDispatcher("edit.jsp?type=Subjects").forward(request, response);
                    } else {
                        request.setAttribute("editFailed", "Could not find/delete subject!");
                        request.getRequestDispatcher("edit.jsp?type=Subjects").forward(request, response);
                    }
                }else if (type.equals("Links")) {
                    int link_id = Integer.parseInt(request.getParameter("link"));
                    PreparedStatement ps = con.prepareStatement(
                            "DELETE FROM links WHERE id=?");
                    ps.setInt(1, link_id);
                    int rowsEffected = ps.executeUpdate();
                    if (rowsEffected>0) {
                        request.setAttribute("editSuccess", "Chapter/Link deleted successfully!");
                        request.getRequestDispatcher("edit.jsp?type=Links").forward(request, response);
                    } else {
                        request.setAttribute("editFailed", "Could not find/delete chapter/link!");
                        request.getRequestDispatcher("edit.jsp?type=Links").forward(request, response);
                    }
                }else{
                    request.setAttribute("editFailed", "Invalid request!");
                    request.getRequestDispatcher("edit.jsp?type="+type).forward(request, response);
                }
            }
        }
        catch (SQLIntegrityConstraintViolationException e){
            request.setAttribute("editFailed", "Delete all subjects for the semester first!");
            request.getRequestDispatcher("edit.jsp?type="+type).forward(request, response);
        }
        catch(Exception e){
            request.setAttribute("editFailed", e.getMessage());
            request.getRequestDispatcher("edit.jsp?type="+type).forward(request, response);
        }
    }
}
