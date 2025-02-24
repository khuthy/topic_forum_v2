<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${topic.title}</title>
</head>
<body>
    <h1>${topic.title}</h1>
    <p>${topic.description}</p>

    <h2>Comments</h2>
    <ul>
        <c:forEach var="comment" items="${comments}">
            <li>
                <p><strong>${comment.first_name} ${comment.last_name}</strong>: ${comment.text}</p>
                <form action="ReplyServlet" method="POST">
                    <input type="hidden" name="commentId" value="${comment.comment_id}" />
                    <textarea name="text" placeholder="Reply..."></textarea><br>
                    <input type="submit" value="Post Reply" />
                </form>
                <!-- Displaying replies -->
                <ul>
                    <c:forEach var="reply" items="${comment.replies}">
                        <li>${reply.text} - <strong>${reply.first_name} ${reply.last_name}</strong></li>
                    </c:forEach>
                </ul>
            </li>
        </c:forEach>
    </ul>

    <h3>Post a Comment</h3>
    <form action="CommentServlet" method="POST">
        <input type="hidden" name="topicId" value="${topic.topic_id}" />
        <textarea name="text" placeholder="Write your comment..."></textarea><br>
        <input type="submit" value="Post Comment" />
    </form>
</body>
</html>
