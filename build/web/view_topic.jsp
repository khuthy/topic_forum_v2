<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Topic</title>
</head>
<body>
    <%
        String topicId = request.getParameter("topicId");
        if (topicId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/topic_forum", "admin", "admin");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM topics WHERE id=" + topicId);
                
                if (rs.next()) {
                    out.println("<h2>" + rs.getString("title") + "</h2>");
                    out.println("<p>" + rs.getString("description") + "</p>");
                }
                
                out.println("<h3>Comments:</h3><ul>");
                rs = stmt.executeQuery("SELECT * FROM comments WHERE topic_id=" + topicId);
                while (rs.next()) {
                    out.println("<li>" + rs.getString("text") + " - <a href='post_reply.jsp?commentId=" + rs.getInt("id") + "'>Reply</a></li>");
                }
                out.println("</ul>");
                
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            out.println("<p>Invalid topic.</p>");
        }
    %>
    <form action="ForumServlet" method="post">
        <input type="hidden" name="action" value="postComment">
        <input type="hidden" name="topicId" value="<%= topicId %>">
        Comment:<br>
        <textarea name="text" required></textarea><br>
        <input type="submit" value="Post Comment">
    </form>
    <a href="home.jsp">Back to Home</a>
</body>
</html>
