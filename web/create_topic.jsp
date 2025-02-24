<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Topic</title>
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
            text-align: center;
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
            margin-top: 30px;
            width: 50%;
            margin: 20px auto;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], textarea {
            width: 90%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            font-size: 16px;
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
            text-decoration: none;
        }

        .back-button:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2>Create New Topic</h2>

    <div class="form-container">
        <form action="ForumServlet" method="post">
                  <input type="hidden" name="action" value="createTopic">
            <label for="title">Title:</label>
            <input type="text" name="title" id="title" required><br>
            
            <label for="description">Description:</label><br>
            <textarea name="description" id="description" rows="5" required></textarea><br>

            <input type="submit" value="Create">
        </form>
    </div>

    <a href="home.jsp" class="back-button">Back to Home</a>

</body>
</html>
