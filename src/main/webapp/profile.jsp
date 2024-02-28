<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
</head>
<body>
<h1>Welcome, <%= session.getAttribute("user") %>, <%=session.getAttribute("role")%></h1>
<a href="logout">Logout</a>
</body>
</html>
