<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
       <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3e5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        h2 {
            color: #6a1b9a;
        }
        input[type="email"], input[type="password"], input[type="submit"], input[type="text"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #6a1b9a;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #6a1b9a;
            color: white;
            cursor: pointer;
            border: none;
        }
        input[type="submit"]:hover {
            background-color: #4a148c;
        }
        a {
            color: #6a1b9a;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
      <div class="container">
    <h2>User Registration</h2>
    <form action="ForumServlet" method="post">
        <input type="hidden"  name="action" value="register">
        <input type="text" placeholder="Enter your name" name="name" required><br>
        <input type="email" placeholder="Enter your email" name="email" required><br>
        <input type="password" placeholder="Enter your password" name="password" required><br>
        <input type="submit" value="Register">
    </form>
    <a href="login.jsp">Already have an account? Login</a>
      </div>
</body>
</html>
