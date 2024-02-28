<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if(session.getAttribute("user") != null){
    response.sendRedirect("main.jsp");
}
%>
<!DOCTYPE html>

<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title> Login and Registration | ExTension</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/login.css?v=2">
    <link rel="icon" href="images/icon.svg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<div class="container">
    <input type="checkbox" id="flip" <%= request.getAttribute("signupPage")!=null?"checked":"" %> >
    <div class="cover">
        <div class="front">
            <img src="images/loginImage.jpg" alt="">
        </div>
        <div class="back">
            <img class="backImg" src="images/loginImage.jpg" alt="">
        </div>
    </div>
    <div class="forms">
        <div class="form-content">
            <div class="login-form">
                <div class="title">Login</div>
                <form action="LoginServlet" method="post">
                    <div class="input-boxes">
                        <% if(request.getAttribute("loginError") != null){ %>
                        <div class="error"><%=request.getAttribute("loginError")%></div>
                        <% } %>
                        <% if(request.getAttribute("signupSuccess") != null){ %>
                        <div class="success"><%=request.getAttribute("signupSuccess")%></div>
                        <% } %>
                        <div class="input-box">
                            <i class="fas fa-user"></i>
                            <input type="text" placeholder="Enter your username" name="username" required>
                        </div>
                        <div class="input-box">
                            <i class="fas fa-lock"></i>
                            <input type="password" placeholder="Enter your password" name="password" required>
                        </div>
                        <div class="text"><a href="#">Forgot password?</a></div>
                        <div class="button input-box">
                            <input type="submit" value="Submit">
                        </div>
                        <div class="text sign-up-text">Don't have an account? <label for="flip">Signup now</label></div>
                    </div>
                </form>
            </div>
            <div class="signup-form">
                <div class="title">Signup</div>
                <form action="SignupServlet" method="post">
                    <div class="input-boxes">
                        <% if(request.getAttribute("signupError") != null){ %>
                        <div class="error"><%=request.getAttribute("signupError")%></div>
                        <% } %>
                        <div class="input-box">
                            <i class="fas fa-user"></i>
                            <input type="text" placeholder="Enter your name" name="name" required>
                        </div>
                        <div class="input-box">
                            <i class="fa fa-sign-in"></i>
                            <input type="text" placeholder="Enter your username" name="username" required>
                        </div>
                        <div class="input-box">
                             <i class="fa fa-users"></i>
                            <select name="role">
                                <option value="student">Student</option>
                                <option value="teacher">Teacher</option>
                            </select>
                        </div>
                        <div class="input-box">
                            <i class="fas fa-lock"></i>
                            <input type="password" placeholder="Enter your password" name="password" required>
                        </div>
                        <div class="button input-box">
                            <input type="submit" value="Sumbit">
                        </div>
                        <div class="text sign-up-text">Already have an account? <label for="flip">Login now</label></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
