<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
</head>
<body>
    <h1>Sign Up</h1>

    <form action="SignupServlet" method="POST">
        <label for="firstName">First Name:</label><br>
        <input type="text" id="firstName" name="firstName" required /><br><br>

        <label for="lastName">Last Name:</label><br>
        <input type="text" id="lastName" name="lastName" required /><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required /><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" required /><br><br>

        <input type="submit" value="Sign Up" />
    </form>

    <br>
    <a href="login.jsp">Already have an account? Log in</a>
</body>
</html>
