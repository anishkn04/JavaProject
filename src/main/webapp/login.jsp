<%--
  Created by IntelliJ IDEA.
  User: Anish
  Date: 19/02/2024
  Time: 3:57 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if(session.getAttribute("user") != null){
    response.sendRedirect("profile.jsp");
}
%>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>
<form action="LoginServlet" method="post">
    <?= session.getAttribute("username") ?>
    <input type="text" name="username" placeholder="Username">
    <input type="password" name="password" placeholder="Password">
    <input type="radio" name="">
    <input type="submit" value="Login">
</form>
<c:if test="${not empty loginError}">
    <p style="color: red;">${loginError}</p>
</c:if>
</body>
</html>
