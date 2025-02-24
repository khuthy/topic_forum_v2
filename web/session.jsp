<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Info</title>
</head>
<body>
    <h1>Welcome, ${sessionScope.firstName} ${sessionScope.lastName}</h1>
    <a href="home.jsp">Go to Home</a><br>
    <a href="logout.jsp">Log out</a>
</body>
</html>
