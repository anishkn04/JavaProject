<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="styles/index.css">
    <title>Test Application</title>
</head>
<body>
<div id="top">
    <span>Welcome to&nbsp;<span class="blue">NO</span><span class="light-blue">TEnsion!</span></span>
</div>
<nav>
    <ul class="navbar">
        <li><a id="sem1" class="nav-anchors active" href="?cat=sem1">1st Semester</a></li>
        <li><a id="sem2" class="nav-anchors" href="?cat=sem2">2nd Semester</a></li>
        <li><a id="sem3" class="nav-anchors" href="?cat=sem3">3rd Semester</a></li>
    </ul>
    <%
        String cat = request.getParameter("cat");
        if( cat == null){
            cat = "sem3";
        }
        switch (cat){
            case "sem1":
    %>
    <ul class="navbar" id="1st-sem-nav">
        <li><a class="nav-anchors-subjects active" href="#">Digital Logic</a></li>
        <li><a class="nav-anchors-subjects" href="#">Discrete Structure</a></li>
        <li><a class="nav-anchors-subjects" href="#">Calculus</a></li>
        <li><a class="nav-anchors-subjects" href="#">Problem Solving Techniques</a></li>
        <li><a class="nav-anchors-subjects" href="#">C Programming</a></li>
        <li><a class="nav-anchors-subjects" href="#">Basic Engineering Drawing</a></li>
    </ul>
    <% break;

        case "sem2":
    %>
    <ul class="navbar" id="2nd-sem-nav">
        <li><a class="nav-anchors-subjects active" href="#">OOP in C++</a></li>
        <li><a class="nav-anchors-subjects" href="#">Algebra and Geometry</a></li>
        <li><a class="nav-anchors-subjects" href="#">Applied Physics</a></li>
        <li><a class="nav-anchors-subjects" href="#">Communication Techniques</a></li>
        <li><a class="nav-anchors-subjects" href="#">Microprocessor and Computer Architecture</a></li>
        <li><a class="nav-anchors-subjects" href="#">Web Technology</a></li>
    </ul>
    <% break;

        case "sem3":
    %>
    <ul class="navbar" id="3rd-sem-nav">
        <li><a class="nav-anchors-subjects active" href="#">Calculus-II</a></li>
        <li><a class="nav-anchors-subjects" href="#">DBMS</a></li>
        <li><a class="nav-anchors-subjects" href="#">Advanced Programming in Java</a></li>
        <li><a class="nav-anchors-subjects" href="#">Data Structure and Algorithm</a></li>
        <li><a class="nav-anchors-subjects" href="#">Probability and Statistics</a></li>
        <li><a class="nav-anchors-subjects" href="#">Software Engineering Fundamentals</a></li>
    </ul>
    <% } %>
    <script>
        document.querySelectorAll('.nav-anchors').forEach(navItem=>{
            navItem.classList.remove('active')
        })
        document.getElementById('<%=cat%>').classList.add('active')
    </script>
</nav>
<main>
    <div id="main">
    <% for (int i = 0; i < 8; i++) { %>
        <a class="container" href="#">
            <span class="container-image"><img alt="pdf-logo" src="images/pdf.svg"></span>
            <span class="container-description">Chapter <%= i+1 %></span>
        </a>
    <% } %>
    </div>
</main>
<%--<script src="scripts/index.js"></script>--%>
</body>
</html>