<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reply to Comment</title>
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

        a {
            text-decoration: none;
            color: #6a1b9a; /* Purple color */
        }

        a:hover {
            text-decoration: underline;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            width: 50%;
            margin: 20px auto;
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
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #8e24aa; /* Lighter purple on hover */
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            color: #6a1b9a;
            font-size: 16px;
            text-align: center;
            display: block;
        }

        .error-message {
            color: red;
            font-size: 18px;
            text-align: center;
        }
    </style>
</head>
<body>

    <%
        String commentId = request.getParameter("commentId");
        if (commentId == null) {
            out.println("<p class='error-message'>Invalid comment.</p>");
        } else {
    %>

    <div class="form-container">
        <h2>Post a Reply</h2>
        <form action="ForumServlet" method="post">
            <input type="hidden" name="action" value="postReply">
            <input type="hidden" name="commentId" value="<%= commentId %>">
            <label for="replyText">Reply:</label><br>
            <textarea name="text" id="replyText" required></textarea><br>
            <input type="submit" value="Post Reply">
        </form>
    </div>

    <a href="home.jsp" class="back-button">Back to Home</a>

    <% } %>

</body>
</html>
