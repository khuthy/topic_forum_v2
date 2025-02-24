<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Topic</title>
</head>
<body>
    <h1>Create New Topic</h1>
    
    <form action="TopicServlet" method="POST">
        <label for="title">Title:</label><br>
        <input type="text" id="title" name="title" required /><br><br>
        
        <label for="description">Description:</label><br>
        <textarea id="description" name="description" required></textarea><br><br>
        
        <input type="hidden" name="userId" value="1" /> <!-- Replace with dynamic user session data -->
        
        <input type="submit" value="Create Topic" />
    </form>

    <br>
    <a href="home.jsp">Back to Home</a>
</body>
</html>
