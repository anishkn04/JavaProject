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
    <link type="text/css" rel="stylesheet" href="styles/index.css?v=1">
    <title>Test Application</title>
</head>
<body>
<div id="top">
    <span><span class="blue">EX-</span><span class="light-blue">Tension: </span>Engineering Notes without any Tension!</span>
</div>
<nav>
    <ul class="navbar">
        <li><a id="sem1" class="nav-anchors" href="?cat=sem1">1st Semester</a></li>
        <li><a id="sem2" class="nav-anchors" href="?cat=sem2">2nd Semester</a></li>
        <li><a id="sem3" class="nav-anchors" href="?cat=sem3">3rd Semester</a></li>
    </ul>
    <%
        String cat = request.getParameter("cat");
        String subcat = request.getParameter("subcat");
        if( cat == null){
            cat = "sem1";
        }

        switch (cat){
            case "sem1":
                if(subcat == null){
                    subcat = "dl";
                }
    %>
    <ul class="subjects" id="1st-sem-nav">
        <li><a class="nav-anchors-subjects" id="dl" href="?cat=sem1&subcat=dl">Digital Logic</a></li>
        <li><a class="nav-anchors-subjects" id="ds" href="?cat=sem1&subcat=ds">Discrete Structure</a></li>
        <li><a class="nav-anchors-subjects" id="calc" href="?cat=sem1&subcat=calc">Calculus</a></li>
        <li><a class="nav-anchors-subjects" id="pst" href="?cat=sem1&subcat=pst">Problem Solving Techniques</a></li>
        <li><a class="nav-anchors-subjects" id="c" href="?cat=sem1&subcat=c">C Programming</a></li>
        <li><a class="nav-anchors-subjects" id="drawing" href="?cat=sem1&subcat=drawing">Basic Engineering Drawing</a></li>
    </ul>
    <% break;

        case "sem2":
            if(subcat == null){
                subcat = "cpp";
            }
    %>
    <ul class="subjects" id="2nd-sem-nav">
        <li><a class="nav-anchors-subjects" id="cpp" href="?cat=sem2&subcat=cpp">OOP in C++</a></li>
        <li><a class="nav-anchors-subjects" id="ag" href="?cat=sem2&subcat=ag">Algebra and Geometry</a></li>
        <li><a class="nav-anchors-subjects" id="ap" href="?cat=sem2&subcat=ap">Applied Physics</a></li>
        <li><a class="nav-anchors-subjects" id="ct" href="?cat=sem2&subcat=ct">Communication Techniques</a></li>
        <li><a class="nav-anchors-subjects" id="mca" href="?cat=sem2&subcat=mca">Microprocessor and Computer Architecture</a></li>
        <li><a class="nav-anchors-subjects" id="wt" href="?cat=sem2&subcat=wt">Web Technology</a></li>
    </ul>
    <% break;

        case "sem3":
            if(subcat == null){
                subcat = "calc2";
            }
    %>
    <ul class="subjects" id="3rd-sem-nav">
        <li><a class="nav-anchors-subjects" id="calc2" href="?cat=sem3&subcat=calc2">Calculus-II</a></li>
        <li><a class="nav-anchors-subjects" id="dbms" href="?cat=sem3&subcat=dbms">DBMS</a></li>
        <li><a class="nav-anchors-subjects" id="java" href="?cat=sem3&subcat=java">Advanced Programming in Java</a></li>
        <li><a class="nav-anchors-subjects" id="dsa" href="?cat=sem3&subcat=dsa">Data Structure and Algorithm</a></li>
        <li><a class="nav-anchors-subjects" id="pns" href="?cat=sem3&subcat=pns">Probability and Statistics</a></li>
        <li><a class="nav-anchors-subjects" id="sef" href="?cat=sem3&subcat=sef">Software Engineering Fundamentals</a></li>
    </ul>
    <% } %>
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