<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.project.test.DatabaseConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String editType = request.getParameter("type");
    if(editType == null){
        response.sendRedirect("main.jsp");
        return;
    }
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    if(session.getAttribute("role")==null || !session.getAttribute("role").equals("teacher")){
        response.sendRedirect("main.jsp");
        return;
    }
    String cat = request.getParameter("cat");
    if (cat == null){
        cat = "sem1";
    }
    String subcat = request.getParameter("subcat");
    if (subcat == null){
        subcat = "dl";
    }
    int semesterId = Integer.parseInt(cat.substring(3));
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/index.css?v=2">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/edit.css?v=1">
    <link rel="icon" href="images/icon.svg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit <%= editType %></title>
</head>
<body>
<div id="top">
    <span><span class="blue">EX-</span><span class="light-blue">Tension: </span>Engineering Notes without any Tension!</span>
</div>
<nav>
    <ul class="navbar">
        <li><a href="edit.jsp?type=Semesters" id="Semesters" class="nav-anchors">Edit Semesters</a></li>
        <li><a href="edit.jsp?type=Subjects" id="Subjects" class="nav-anchors">Edit Subjects</a></li>
        <li><a href="edit.jsp?type=Links" id="Links" class="nav-anchors">Edit Links</a></li>
    </ul>
    <script>
        const editType = document.querySelectorAll('.nav-anchors');
        editType.forEach(navItem=>{
            navItem.classList.remove('active')
        })
        document.getElementById('<%=editType%>').classList.add('active');
    </script>
</nav>
<% if(request.getAttribute("editFailed")!=null){
%>
<div class="error"><%=request.getAttribute("editFailed")%></div>
<%
    }if(request.getAttribute("editSuccess")!=null){
%>
<div class="success"><%=request.getAttribute("editSuccess")%></div>
<%
    }
%>
<main>
    <div id="main">

<%
        try {
            Connection con = DatabaseConnection.getConnection();
            if (con != null) {
                Statement psSemesters = con.createStatement();
                ResultSet rsSemesters = psSemesters.executeQuery("SELECT * FROM semesters");
                Statement psSubjects = con.createStatement();
                ResultSet rsSubjects = psSubjects.executeQuery("SELECT * FROM subjects");
                Statement psChapters = con.createStatement();
                ResultSet rsChapters = psChapters.executeQuery("SELECT * FROM links");
                if (editType.equals("Semesters")) {
                    %>

                    <form action="AddServlet?type=Semesters" method="post">
                        <input type="number" name="semester" placeholder="Enter Semester" min="1" max="8" required>
                        <input type="submit" value="Add Semester">
                    </form>
                    <table>
                        <tr>
                            <th>Semester</th>
                            <th>Action</th>
                        </tr>
                        <%
                        while (rsSemesters.next()) {
                            %>
                            <tr>
                                <td><%=rsSemesters.getString("semester")%></td>
                                <td><a href="DeleteServlet?type=Semesters&semester=<%=rsSemesters.getString("semester")%>">Delete</a></td>
                            </tr>
                            <%
                        }
                        %>
                    </table>
                    <%
                } else if (editType.equals("Subjects")) {
                    %>
                    <form action="AddServlet?type=Subjects" method="post">
                        <input type="text" name="subject_name" placeholder="Enter Subject" required>
                        <input type="text" maxlength="30" name="subject_notation" placeholder="Enter subject notation (Eg: ds for Discrete Structure)">
                        <select name="semester" required>
                            <%
                            while (rsSemesters.next()) {
                                %>
                                <option value="<%=rsSemesters.getInt("semester")%>">Semester <%=rsSemesters.getString("semester")%></option>
                                <%
                            }
                            %>
                        </select>
                        <input type="submit" value="Add Subject">
                    </form>
                    <table>
                        <tr>
                            <th>Subject</th>
                            <th>Semester</th>
                            <th>Action</th>
                        </tr>
                        <%
                        while (rsSubjects.next()) {
                            %>
                            <tr>
                                <td><%=rsSubjects.getString("subject_name")%></td>
                                <td><%=rsSubjects.getInt("semester")%></td>
                                <td><a href="DeleteServlet?type=Subjects&subject=<%=rsSubjects.getInt("subject_id")%>">Delete</a></td>
                            </tr>
                            <%
                        }
                        %>
                    </table>
                    <%
                } else if (editType.equals("Links")) {
                    %>
                    <form action="AddServlet?type=Links" method="post">
                        <select name="semester" id="semester" onchange="hideSubjects()"  required>
                            <%
                                Statement psSemesters1 = con.createStatement();
                                ResultSet rsSemesters1 = psSemesters1.executeQuery("SELECT * FROM semesters");
                                while (rsSemesters1.next()) {
                            %>
                            <option value="<%=rsSemesters1.getInt(1)%>">Semester <%=rsSemesters1.getInt(1)%></option>
                            <%
                                }
                            %>
                        </select>
                        <select name="subject_id" required>
                            <option class="subjectsOption" value=""></option>
                            <%
                                Statement psSubjects1 = con.createStatement();
                                ResultSet rsSubjects1 = psSubjects1.executeQuery("SELECT * FROM subjects");
                            while (rsSubjects1.next()) {
                                %>
                                <option class="subjectsOption" value="<%=rsSubjects1.getString("subject_id")%>" data-semester="<%=rsSubjects1.getInt("semester")%>" ><%=rsSubjects1.getString("subject_name")%></option>
                                <%
                            }
                            %>
                        </select>
<input type="text" name="chapter_name" placeholder="Enter Chapter/Link name" required>
                        <input type="text" name="chapter_link" placeholder="Enter Link" required>
                        <script rel="script" src="${pageContext.request.contextPath}/scripts/edit.js?v=1"></script>
                        <input type="submit" value="Add Link">
                    </form>
                    <table>
                        <tr>
                            <th>File Name</th>
                            <th>Subject</th>
                            <th>Action</th>
                        </tr>
                        <%
                        while (rsChapters.next()) {
                            %>
                            <tr>
                                <td><%=rsChapters.getString("chapter_link")%></td>
                                <td><%=rsChapters.getString("subject_name")%></td>
                                <td><a href="DeleteServlet?type=Links&link=<%=rsChapters.getInt(1)%>">Delete</a></td>
                            </tr>
                            <%
                        }
                        %>
                    </table>
            <%

            }
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
%>
    </div>
</main>
</body>
</html>
