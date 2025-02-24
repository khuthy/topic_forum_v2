<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3e5f5;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #4a148c;
        }

        h3 {
            color: #333;
        }

        a {
            text-decoration: none;
            color: #4a148c;
        }

        a:hover {
            text-decoration: underline;
        }

        .topics-list {
            list-style-type: none;
            padding: 0;
        }

        .topics-list li {
            background-color: #ffffff;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .button {
            background-color: #4a148c;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
        }

        .button:hover {
            background-color: #45a049;
        }

        .logout {
            margin-top: 20px;
            display: inline-block;
            font-size: 16px;
        }
    </style>
</head>
<body>

    <h2>Welcome to the Forum</h2>
    
    <!-- Button to create a new topic -->
    <a href="create_topic.jsp" class="button">Create New Topic</a>

    <h3>Topics:</h3>

    <!-- Display topics fetched from the database -->
    <ul class="topics-list">
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

    <!-- Logout button -->
    <a href="logout.jsp" class="logout">Logout</a>

</body>
</html>
