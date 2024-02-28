package org.project.test;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet {
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
                if(type.equals("Semesters")){
                    int semester = Integer.parseInt(request.getParameter("semester"));
                    String semesterName = "sem"+semester;
                    PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO semesters (semester, semester_name) VALUES (?, ?)");
                    ps.setInt(1, semester);
                    ps.setString(2, semesterName);
                    int rowsEffected = ps.executeUpdate();
                    if (rowsEffected>0) {
                        request.setAttribute("editSuccess", "Semester added successfully!");
                        request.getRequestDispatcher("edit.jsp?type=Semesters").forward(request, response);
                    } else {
                        request.setAttribute("editFailed", "Could not add semester!");
                        request.getRequestDispatcher("edit.jsp?type=Semesters").forward(request, response);
                    }
                } else if (type.equals("Subjects")) {
                    int semester = Integer.parseInt(request.getParameter("semester"));
                    String subject_name = request.getParameter("subject_name");
                    String subject_notation = request.getParameter("subject_notation");
                    PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO subjects (semester, subject_name, subject_notation) VALUES (?, ?, ?)");
                    ps.setInt(1, semester);
                    ps.setString(2, subject_name);
                    ps.setString(3, subject_notation);
                    int rowsEffected = ps.executeUpdate();
                    if (rowsEffected>0) {
                        request.setAttribute("editSuccess", "Subject added successfully!");
                        request.getRequestDispatcher("edit.jsp?type=Subjects").forward(request, response);
                    } else {
                        request.setAttribute("editFailed", "Could not add subject!");
                        request.getRequestDispatcher("edit.jsp?type=Subjects").forward(request, response);
                    }
                }else if (type.equals("Links")) {
                    int subject = Integer.parseInt(request.getParameter("subject_id"));
                    String link = request.getParameter("chapter_link");
                    String name = request.getParameter("chapter_name");
                    String subject_name = "";
                    PreparedStatement psSubjects1 = con.prepareStatement("SELECT * FROM subjects WHERE subject_id=?");
                    psSubjects1.setInt(1, subject);
                    ResultSet rsSubjects1 = psSubjects1.executeQuery();
                    while (rsSubjects1.next()) {
                        subject_name = rsSubjects1.getString("subject_name");
                    }
                    PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO links (subject_id, subject_name ,chapter_name, chapter_link) VALUES (?, ?, ?, ?)");
                    ps.setInt(1, subject);
                    ps.setString(2, subject_name);
                    ps.setString(3, name);
                    ps.setString(4, link);
                    int rowsEffected = ps.executeUpdate();
                    if (rowsEffected>0) {
                        request.setAttribute("editSuccess", "Link added successfully!");
                        request.getRequestDispatcher("edit.jsp?type=Links").forward(request, response);
                    } else {
                        request.setAttribute("editFailed", "Could not add link!");
                        request.getRequestDispatcher("edit.jsp?type=Links").forward(request, response);
                    }
                }
            }
        }catch (SQLIntegrityConstraintViolationException e){
            request.setAttribute("editFailed", "Provided data already exists!");
            request.getRequestDispatcher("edit.jsp?type="+type).forward(request, response);
        }
        catch (Exception e){
            request.setAttribute("editFailed", e.getClass());
            request.getRequestDispatcher("edit.jsp?type="+type).forward(request, response);
        }
    }
}
