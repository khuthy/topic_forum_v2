<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h1>Register</h1>
    <form action="RegisterServlet" method="POST">
        <label for="name">Name: </label>
        <input type="text" id="name" name="name" required><br><br>
        
        
          <label for="email">Email:</label>
          <input type="email" id="email" name="email" required><br><br><!-- comment -->
          
          
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        
      
        
        <input type="submit" value="Register">
    </form>
    <a href="login.jsp">Already have an account? Login</a>
</body>
</html>
