<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reply to Comment</title>
</head>
<body>
    <%
        String commentId = request.getParameter("commentId");
        if (commentId == null) {
            out.println("<p>Invalid comment.</p>");
        } else {
    %>
    <h2>Post a Reply</h2>
    <form action="ForumServlet" method="post">
        <input type="hidden" name="action" value="postReply">
        <input type="hidden" name="commentId" value="<%= commentId %>">
        Reply:<br>
        <textarea name="text" required></textarea><br>
        <input type="submit" value="Reply">
    </form>
    <a href="home.jsp">Back to Home</a>
    <% } %>
</body>
</html>
