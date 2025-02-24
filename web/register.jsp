<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>User Registration</h2>
    <form action="ForumServlet" method="post">
        <input type="hidden" name="action" value="register">
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Register">
    </form>
    <a href="login.jsp">Already have an account? Login</a>
</body>
</html>
