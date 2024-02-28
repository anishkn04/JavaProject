<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.project.test.DatabaseConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    String role = session.getAttribute("role").equals("teacher") ? "teacher" : "student";
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/index.css?v=3">
    <link rel="icon" href="images/icon.svg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ExTension - Notes</title>
</head>
<body>
<div id="top">
    <span><span class="blue">EX-</span><span class="light-blue">Tension: </span>Engineering Notes without any Tension!</span>
    <div class="dropdown">
        <i class="fa-solid fa-user"></i>
    <div class="dropdown-content">
        <div><%=session.getAttribute("user")%></div>
        <a href="${pageContext.request.contextPath}/logout" id="logout-button">Logout</a>
    </div>
    </div>
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
        <% }
            if (role.equals("teacher")) {%>
        <li><a id="" class="nav-anchors" href="edit.jsp?type=Semesters"> <img src="images/edit.svg" alt="Edit Semesters" height="auto"></a> </li>
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
            PreparedStatement psSubjects = con.prepareStatement("SELECT * FROM subjects JOIN javaproject.semesters s on s.semester = subjects.semester WHERE subjects.semester=?");
            psSubjects.setInt(1, semesterId);
            ResultSet rsSubjects = psSubjects.executeQuery();
            boolean flag = false;
            while (rsSubjects.next()) {
                String subName = rsSubjects.getString(2);
                String subNotation = rsSubjects.getString(3);
                if(subcat == null && !flag){
                    subcat = subNotation;
                    flag = true;
                }
        %>
        <li><a class="nav-anchors-subjects" id="<%=subNotation%>" href="?cat=<%=cat%>&subcat=<%=subNotation%>"><%=subName%></a></li>
        <% } if (role.equals("teacher")) {%>
        <li><a class="nav-anchors-subjects" id="a" href="edit.jsp?type=Subjects&cat=<%=cat%>"><img src="images/editDoc.svg" alt="Edit Subjects"></a></li>
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
    <%if(request.getAttribute("deleteError")!=null){
    %>
    <div class="error"><%=request.getAttribute("deleteError")%></div>
    <%
        }if(request.getAttribute("deleteError")!=null){
    %>
    <div class="success"><%=request.getAttribute("deleteSuccess")%></div>
    <%
        }
    %>
    <div id="main">
        <%

            PreparedStatement psChapters = con.prepareStatement("SELECT * FROM links JOIN javaproject.subjects s on s.subject_id = links.subject_id WHERE subject_notation=?");
            psChapters.setString(1, subcat);

            ResultSet rsChapters = psChapters.executeQuery();
            while (rsChapters.next()) {
        %>
        <a class="card" href="<%=rsChapters.getString(5)%>">
            <img alt="pdf-logo" src="images/pdf.svg" style="width:100%">
            <div class="container">
                <p><%=rsChapters.getString(4)%></p>
            </div>
        </a>
        <%
            } if (role.equals("teacher")) {
        %>
        <a class="card" target="_blank" href="edit.jsp?type=Links&cat=<%=cat%>&subcat=<%=subcat%>">
            <img  alt="Edit Documents" src="images/editText.svg" style="width:100%">
            <div class="container">
                <p>Edit Documents</p>
            </div>
        </a>
        <%
                    }
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        %>
    </div>
</main>
</body>
</html>
