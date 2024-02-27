<%@ page import="java.sql.Connection" %>
<%@ page import="org.project.test.DatabaseConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="styles/index.css?v=2">
    <title>Test Application</title>
</head>
<body>
<div id="top">
    <span><span class="blue">EX-</span><span class="light-blue">Tension: </span>Engineering Notes without any Tension!</span>
</div>
<nav>
    <ul class="navbar">
        <%
            try {
                Connection con = DatabaseConnection.getConnection();
                if (con != null) {
                    Statement psSemesters = con.createStatement();

                    ResultSet rsSemesters = psSemesters.executeQuery("SELECT * FROM semesters");
                    while (rsSemesters.next()) {
                        String semName = rsSemesters.getString(2);
        %>
        <li><a id="<%=semName%>" class="nav-anchors" href="?cat=<%=semName%>">Semester <%=rsSemesters.getInt(1)%></a> </li>
        <% } %>
    </ul>
    <%
        String cat = request.getParameter("cat");
        String subcat = request.getParameter("subcat");
        if( cat == null){
            cat = "sem1";
        }
    %>
    <ul class="subjects" id="1st-sem-nav">
    <%
                int semesterId = Integer.parseInt(cat.substring(3));
                PreparedStatement psSubjects = con.prepareStatement("SELECT * FROM subjects WHERE semester=?");
                psSubjects.setInt(1, semesterId);

                ResultSet rsSubjects = psSubjects.executeQuery();
                while (rsSubjects.next()) {
                    String subName = rsSubjects.getString(2);
                    String subNotation = rsSubjects.getString(3);
    %>
        <li><a class="nav-anchors-subjects" id="<%=subNotation%>" href="?cat=<%=cat%>&subcat=<%=subNotation%>"><%=subName%></a></li>
    <% } %>
    </ul>
    <script>
        const cats = document.querySelectorAll('.nav-anchors');
        const subcats = document.querySelectorAll('.nav-anchors-subjects');
        cats.forEach(navItem=>{
            navItem.classList.remove('active')
        })
        document.getElementById('<%=cat%>').classList.add('active');

        subcats.forEach(navItem=>{
            navItem.classList.remove('active')
        })
        document.getElementById('<%=subcat%>').classList.add('active')
    </script>
</nav>
<main>
    <div id="main">
        <%

                    PreparedStatement psChapters = con.prepareStatement("SELECT * FROM links WHERE subject=?");
                    psChapters.setString(1, subcat);

                    ResultSet rsChapters = psChapters.executeQuery();
                    while (rsChapters.next()) {
        %>
    <a class="container" href="<%=rsChapters.getString(4)%>">
        <span class="container-image"><img alt="pdf-logo" src="images/pdf.svg"></span>
        <span class="container-description"><%=rsChapters.getString(3)%></span>
    </a>
    <%
                    }

                }
            }catch (Exception e){}
        %>

    </div>
</main>
<%--<script src="scripts/index.js"></script>--%>
</body>
</html>