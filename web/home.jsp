<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Forum</title>
</head>
<body>
    <h1>Welcome to the Forum</h1>

    <!-- Link to create a new topic -->
    <a href="createTopic.jsp">Create New Topic</a><br><br>

    <!-- Displaying list of topics -->
    <h2>All Topics</h2>
    <ul>
        <c:forEach var="topic" items="${topics}">
            <li>
                <a href="ViewTopicServlet?topicId=${topic.topic_id}">${topic.title}</a>
                <p>${topic.description}</p>
            </li>
        </c:forEach>
    </ul>
</body>
</html>
