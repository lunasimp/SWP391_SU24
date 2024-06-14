<%-- 
    Document   : insertCourse
    Created on : May 28, 2024, 10:27:46 PM
    Author     : Thanh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Course</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">  
        <style>
            .form-container {
                max-width: 600px;
                margin: auto;
                padding: 20px;
                background-color: #f4f4f4;
                border-radius: 8px;
            }

            .form-container h1 {
                text-align: center;
                margin-bottom: 20px;
            }

            .form-container div {
                margin-bottom: 15px;
            }

            .form-container label {
                display: block;
                margin-bottom: 5px;
            }

            .form-container input[type="text"],
            .form-container input[type="date"],
            .form-container textarea,
            .form-container select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .form-container button {
                background-color: #333333;
                color: #ffffff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
            }

            .form-container button:hover {
                background-color: #444444;
            }
        </style>
    </head>
    <body>
        <%@include file="/components/header.jspf" %>
        <div class="grid">
            <div class="admin-sidebar">
                <!-- Add your sidebar content here if any -->
            </div>
            <div class="admin-content">
                <div class="form-container">
                    <h1>Create Course</h1>
                    <form method="post" action="${pageContext.request.contextPath}/manager/create-course">
                        <div>
                            <label for="imageUrl">Image URL:</label>
                            <input type="text" id="imageUrl" name="imageUrl" required>
                        </div>
                        <div>
                            <label for="title">Title:</label>
                            <input type="text" id="title" name="title" required>
                        </div>
                        <div>
                            <label for="description">Description:</label>
                            <input type="text" id="description" name="description" required>
                        </div>
                        <div>
                            <label for="publishDate">Publish Date:</label>
                            <input type="date" id="publishDate" name="publishDate" required>
                        </div>
                        <div>
                            <label for="lecturer">Lecturer:</label>
                            <input type="text" id="lecturer" name="lecturer" required>
                        </div>
                        <div>
                            <label for="semesterId">Semester:</label>
                            <select id="semesterId" name="semesterId" required>
                                <c:forEach items="${semesters}" var="s">
                                    <option value="${s.id}">${s.description}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <br>
                        <button type="submit">Create Course</button>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="/components/footer.jspf" %>
    </body>
</html>
