<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forum Home</title>
</head>
<body>
    <h2>Welcome to the Forum</h2>
    <a href="create_topic.jsp">Create New Topic</a><br><br>

    <h3>Topics:</h3>
    <ul>
        <%
            // Database connection to fetch topics
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/topic_forum", "admin", "admin");
                java.sql.Statement stmt = conn.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM topics");

                while (rs.next()) {
                    out.println("<li><a href='view_topic.jsp?topicId=" + rs.getInt("id") + "'>" + rs.getString("title") + "</a></li>");
                }

                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </ul>
    <a href="logout.jsp">Logout</a>
</body>
</html>
