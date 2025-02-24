<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <form action="RegisterServlet" method="POST">
        <input type="email" name="email" required placeholder="Email">
        <input type="password" name="password" required placeholder="Password">
        <input type="text" name="firstName" required placeholder="First Name">
        <input type="text" name="lastName" required placeholder="Last Name">
        <button type="submit">Register</button>
    </form>
    <p><a href="login.jsp">Login</a></p>
</body>
</html>
