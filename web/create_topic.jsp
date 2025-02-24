<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Topic</title>
</head>
<body>
    <h2>Create New Topic</h2>
    
    <form action="ForumServlet" method="post">
        <%
            // Get the userId from the session
            String userId = (String) session.getAttribute("userId");
            if (userId == null) {
                out.println("<p>You must be logged in to create a topic.</p>");
                return; // Or redirect to login page
            }
        %>
        
        <input type="hidden" id="userId" name="userId" value="<%= userId %>">
        
        Title: <input type="text" name="title" required><br>
        Description:<br>
        <textarea name="description" required></textarea><br>
        <input type="submit" value="Create">
    </form>

    <a href="home.jsp">Back to Home</a>
</body>
</html>
