<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Topic</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #6a1b9a; /* Purple color */
        }

        h3 {
            color: #333;
        }

        a {
            text-decoration: none;
            color: #6a1b9a; /* Purple color */
        }

        a:hover {
            text-decoration: underline;
        }

        .topic-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .comments-container {
            margin-top: 20px;
        }

        .comment-item {
            background-color: #ffffff;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .reply-item {
            background-color: #f9f9f9;
            margin: 5px 0 5px 20px;
            padding: 8px;
            border-radius: 5px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #6a1b9a; /* Purple color */
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #8e24aa; /* Lighter purple on hover */
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            color: #6a1b9a;
            font-size: 16px;
        }
    </style>
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
                    out.println("<div class='topic-container'>");
                    out.println("<h2>" + rs.getString("title") + "</h2>");
                    out.println("<p>" + rs.getString("description") + "</p>");
                    out.println("</div>");
                }

                // Display comments and their replies
                out.println("<div class='comments-container'><h3>Comments:</h3><ul>");
                rs = stmt.executeQuery("SELECT * FROM comments WHERE topic_id=" + topicId);
                while (rs.next()) {
                    int commentId = rs.getInt("id");
                    String commentText = rs.getString("text");
                    out.println("<li class='comment-item'>" + commentText + " - <a href='post_reply.jsp?commentId=" + commentId + "'>Reply</a>");

                    // Fetch replies to this comment
                    Statement stmtReplies = conn.createStatement();
                    ResultSet rsReplies = stmtReplies.executeQuery("SELECT * FROM replies WHERE comment_id=" + commentId);
                    while (rsReplies.next()) {
                        out.println("<div class='reply-item'>" + rsReplies.getString("text") + "</div>");
                    }
                    out.println("</li>");
                }
                out.println("</ul></div>");

                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            out.println("<p>Invalid topic.</p>");
        }
    %>

    <div class="form-container">
        <form action="ForumServlet" method="post">
            <input type="hidden" name="action" value="postComment">
            <input type="hidden" name="topicId" value="<%= topicId %>">
            <label for="commentText">Comment:</label><br>
            <textarea name="text" id="commentText" required></textarea><br>
            <input type="submit" value="Post Comment">
        </form>
    </div>

    <a href="home.jsp" class="back-button">Back to Home</a>

</body>
</html>
